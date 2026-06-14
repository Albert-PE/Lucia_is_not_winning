--=====================================================================
--                            TIPOS
--=====================================================================

CREATE OR REPLACE TYPE MEA_conversion_row AS OBJECT (
    id_pais       NUMBER,
    nom_pais      VARCHAR2(20),
    moneda        VARCHAR2(3),
    monto_origen  NUMBER,
    tasa_cambio   VARCHAR2(50),
    monto_usd     VARCHAR2(30)
);
/

CREATE OR REPLACE TYPE MEA_conversion_table AS TABLE OF MEA_conversion_row;
/

--=====================================================================
--                            FUNCIONES
--=====================================================================

CREATE OR REPLACE FUNCTION MEA_conversion_monetaria(

    p_id_pais     IN MEA_PAISES.id_pais%TYPE,
    p_monto       IN NUMBER,
    p_tasa_cambio IN NUMBER
) RETURN MEA_conversion_table PIPELINED IS
    v_monto_usd  NUMBER;
    v_moneda     MEA_PAISES.moneda%TYPE;
    v_pais       MEA_PAISES.nom_pais%TYPE;
BEGIN
    SELECT moneda, nom_pais
    INTO v_moneda, v_pais
    FROM MEA_PAISES
    WHERE id_pais = p_id_pais;

    IF v_moneda = 'USD' THEN
        v_monto_usd := p_monto;
    ELSE
        v_monto_usd := ROUND(p_monto / p_tasa_cambio, 2);
    END IF;

    PIPE ROW (MEA_conversion_row(
        p_id_pais,
        v_pais,
        v_moneda,
        p_monto,
        CASE WHEN v_moneda = 'USD' THEN 'Misma moneda (USD)' ELSE '1 USD = ' || p_tasa_cambio || ' ' || v_moneda END,
        v_monto_usd || ' USD'
    ));

    RETURN;
END;
/


-- COMPROBACIÓN
-- SELECT * FROM TABLE(MEA_conversion_monetaria(&id_pais, &monto, &tasa_cambio));

--=========================================================================

CREATE OR REPLACE FUNCTION MEA_edad_miembro (
    p_id_lector IN NUMBER
) RETURN NUMBER IS
    v_fecha DATE;
BEGIN
    SELECT f_nacimiento INTO v_fecha
    FROM MEA_LECTORES
    WHERE id_lector = p_id_lector;

    RETURN TRUNC(MONTHS_BETWEEN(SYSDATE, v_fecha) / 12);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        raise_application_error(-20015, 'Error: El lector con ID ' || p_id_lector || ' no existe.');
    WHEN OTHERS THEN
        raise_application_error(-20016, 'Error al calcular edad: ' || SQLERRM);
END;
/

--=========================================================================

CREATE OR REPLACE FUNCTION MEA_antiguedad_miembro (
    p_id_lector IN NUMBER
) RETURN NUMBER IS
    v_fecha DATE;
BEGIN
    -- Buscamos la fecha de ingreso al club en la tabla de SOCIOS
    SELECT fech_i_socio INTO v_fecha
    FROM MEA_SOCIOS
    WHERE id_lector = p_id_lector;

    RETURN TRUNC(MONTHS_BETWEEN(SYSDATE, v_fecha) / 12);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        raise_application_error(-20017, 'Error: El lector ' || p_id_lector || ' no es socio de ningún club.');
    WHEN OTHERS THEN
        raise_application_error(-20018, 'Error al calcular antigüedad: ' || SQLERRM);
END;
/

--COMPROBACIÓN
-- SELECT p_nombre, MEA_edad_miembro(id_lector) as edad, MEA_antiguedad_miembro(id_lector) as anios_club FROM MEA_LECTORES;



--=========================================================================

CREATE OR REPLACE FUNCTION MEA_promedio_part_mensual_tipo(
    p_id_club IN NUMBER,
    p_mes     IN NUMBER,
    p_anio    IN NUMBER
) RETURN VARCHAR2 IS
    v_total_esperado      NUMBER;
    v_total_inasistencias NUMBER;
    v_promedio_grupo      NUMBER;
    v_suma_promedios_tipo NUMBER;
    v_cont_grupos_tipo    NUMBER;
    v_promedio_tipo_final NUMBER;
    
    v_nom_club            MEA_CLUBES.nombre_club%TYPE;
    v_salida              VARCHAR2(2000);
    
    -- Cursor para iterar por los tipos de grupo definidos en el negocio
    CURSOR cur_tipos IS 
        SELECT column_value AS tipo 
        FROM TABLE(SYS.ODCIVARCHAR2LIST('adulto', 'joven', 'infantil'));
BEGIN
    ----- VALIDACIONES INICIALES -----
    BEGIN
        SELECT nombre_club INTO v_nom_club
        FROM MEA_CLUBES
        WHERE id_club = p_id_club;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            raise_application_error(-20010, 'Error: El club con ID ' || p_id_club || ' no existe.');
    END;

    IF p_mes < 1 OR p_mes > 12 THEN
        raise_application_error(-20011, 'Error: El mes debe estar entre 1 y 12.');
    END IF;

    IF TO_DATE('01/' || p_mes || '/' || p_anio, 'DD/MM/YYYY') > SYSDATE THEN
        raise_application_error(-20012, 'Error: No se pueden analizar fechas futuras.');
    END IF;

    v_salida := 'Promedio por grupos:' || CHR(10);

    -- Iteramos por cada tipo (Adulto, Joven, Infantil)
    FOR r_tipo IN cur_tipos LOOP
        v_suma_promedios_tipo := 0;
        v_cont_grupos_tipo    := 0;

        -- Buscamos todos los grupos de ese tipo para el club dado
        FOR r_grupo IN (SELECT id_grupo FROM MEA_GRUPOS WHERE id_club = p_id_club AND tipo = r_tipo.tipo) LOOP
            
            -- 1. Calculamos esperados para el grupo específico
            SELECT COUNT(*)
            INTO v_total_esperado
            FROM MEA_REUNIONES_CALENDARIO r, MEA_HISTORICO_GRUPOS h
            WHERE r.id_club = h.id_club_grupo
              AND r.id_grupo = h.id_grupo
              AND r.fech_reunion >= h.fech_i_hist_grupo
              AND (h.fech_f_hist_grupo IS NULL OR r.fech_reunion <= h.fech_f_hist_grupo)
              AND r.id_club = p_id_club
              AND r.id_grupo = r_grupo.id_grupo
              AND EXTRACT(MONTH FROM r.fech_reunion) = p_mes
              AND EXTRACT(YEAR FROM r.fech_reunion) = p_anio
              AND r.realizada = 'SI';

            -- 2. Calculamos inasistencias para el grupo específico
            SELECT COUNT(*)
            INTO v_total_inasistencias
            FROM MEA_INASISTENTES i
            WHERE i.id_club_reu = p_id_club
              AND i.id_grupo_reu = r_grupo.id_grupo
              AND EXTRACT(MONTH FROM i.fech_reunion) = p_mes
              AND EXTRACT(YEAR FROM i.fech_reunion) = p_anio;

            -- 3. Promedio del grupo
            IF v_total_esperado > 0 THEN
                v_promedio_grupo := ((v_total_esperado - v_total_inasistencias) / v_total_esperado) * 100;
                v_suma_promedios_tipo := v_suma_promedios_tipo + v_promedio_grupo;
                v_cont_grupos_tipo := v_cont_grupos_tipo + 1;
            END IF;
        END LOOP;

        -- 4. Promedio de promedios para el tipo
        IF v_cont_grupos_tipo > 0 THEN
            v_promedio_tipo_final := ROUND(v_suma_promedios_tipo / v_cont_grupos_tipo, 2);
        ELSE
            v_promedio_tipo_final := 0;
        END IF;

        -- 5. Construcción de la cadena de salida
        IF r_tipo.tipo = 'adulto' THEN
            v_salida := v_salida || 'Adultos: ' || v_promedio_tipo_final || '%' || CHR(10);
        ELSIF r_tipo.tipo = 'joven' THEN
            v_salida := v_salida || 'Juveniles: ' || v_promedio_tipo_final || '%' || CHR(10);
        ELSIF r_tipo.tipo = 'infantil' THEN
            v_salida := v_salida || 'Infantiles: ' || v_promedio_tipo_final || '%';
        END IF;
        
    END LOOP;

    RETURN v_salida;

EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE NOT BETWEEN -20999 AND -20000 THEN
            raise_application_error(-20013, 'Error inesperado: ' || SQLERRM);
        ELSE
            RAISE;
        END IF;
END;
/

-- COMPROBACIÓN
-- SELECT MEA_promedio_part_mensual_tipo(&id_club, '&tipo_grupo', &mes, &anio) FROM DUAL;


--=========================================================================

CREATE OR REPLACE FUNCTION MEA_participacion_bimestre_miembro (p_id_lector NUMBER, p_fecha_inicial DATE)
RETURN NUMBER IS
    v_inasistencias NUMBER;
    v_total_reuniones NUMBER;
    v_porcentaje NUMBER;
BEGIN

    SELECT count(*) INTO v_inasistencias
        FROM mea_inasistentes
        WHERE p_id_lector = id_lector AND fech_reunion between add_months(p_fecha_inicial,-2) AND p_fecha_inicial;

    SELECT count(*) INTO v_total_reuniones    
        FROM mea_historico_grupos h, mea_reuniones_calendario r 
        WHERE 
            p_id_lector = h.id_lector 
            AND h.id_club_grupo = r.id_club 
            AND h.id_grupo = r.id_grupo 
            AND r.fech_reunion >= h.fech_i_hist_grupo 
            AND (h.fech_f_hist_grupo IS NULL OR r.fech_reunion <= h.fech_f_hist_grupo) 
            AND r.fech_reunion between add_months(p_fecha_inicial,-2) AND p_fecha_inicial
            AND r.realizada = 'SI';

    IF v_total_reuniones = 0 THEN
        RETURN 0;
    ELSE
        v_porcentaje := ((v_total_reuniones - v_inasistencias) / v_total_reuniones) * 100;
        RETURN v_porcentaje;
    END IF;
END;

-- COMPROBACIÓN

-- SELECT MEA_participacion_bimestre_miembro(&id_lector, TO_DATE('&fecha', 'DD-MM-YYYY')) FROM DUAL;
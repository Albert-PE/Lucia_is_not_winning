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

    IF UPPER(v_pais) = 'ESTADOS UNIDOS' THEN
        raise_application_error(-20008, 'No se permite convertir desde Estados Unidos.');
    END IF;

    v_monto_usd := ROUND(p_monto / p_tasa_cambio, 2);

    PIPE ROW (MEA_conversion_row(
        p_id_pais,
        v_pais,
        v_moneda,
        p_monto,
        '1 USD = ' || p_tasa_cambio || ' ' || v_moneda,
        v_monto_usd || ' USD'
    ));

    RETURN;
END;


-- COMPROBACIÓN
-- SELECT * FROM TABLE(MEA_conversion_monetaria(&id_pais, &monto, &tasa_cambio));

--=========================================================================

CREATE OR REPLACE FUNCTION MEA_antiguedad_en_club_miembro (
    p_id_lector IN MEA_LECTORES.id_lector%TYPE
) RETURN MEA_edad_table PIPELINED IS
    v_edad NUMBER;
BEGIN
    FOR rec IN (
        SELECT id_lector, p_nombre, s_nombre, p_apellido, s_apellido, f_nacimiento
        FROM MEA_LECTORES
        WHERE id_lector = p_id_lector
    ) LOOP
        v_edad := ROUND(((SYSDATE - rec.f_nacimiento) / 365), 0);

        PIPE ROW (MEA_edad_row(
            rec.id_lector,
            rec.p_nombre,
            rec.s_nombre,
            rec.p_apellido,
            rec.s_apellido,
            TO_CHAR(rec.f_nacimiento, 'DD/MM/YYYY'),
            v_edad
        ));
    END LOOP;

    RETURN;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        raise_application_error(-20015, 'Error: El lector con ID ' || p_id_lector || ' no existe.');
    WHEN OTHERS THEN
        raise_application_error(-20016, 'Error al calcular edad: ' || SQLERRM);
END;

--COMPROBACIÓN
-- SELECT * FROM TABLE(MEA_antiguedad_en_club_miembro(&id_lector));

--=========================================================================

CREATE OR REPLACE FUNCTION MEA_promedio_part_mensual_tipo(
    p_id_club IN NUMBER,
    p_tipo_grupo IN VARCHAR2, -- 'joven', 'adulto', 'infantil'
    p_mes IN NUMBER,
    p_anio IN NUMBER
) RETURN NUMBER IS
    v_total_esperado NUMBER := 0;
    v_total_inasistencias NUMBER := 0;
    v_promedio NUMBER := 0;
    v_tipo_normalizado VARCHAR2(20);
    v_nom_club MEA_CLUBES.nombre_club%TYPE;
    v_fecha_consulta DATE;
BEGIN
    v_tipo_normalizado := LOWER(p_tipo_grupo);

    -----VALIDACIONES-----
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

    v_fecha_consulta := TO_DATE('01/' || p_mes || '/' || p_anio, 'DD/MM/YYYY');
    IF v_fecha_consulta > SYSDATE THEN
        raise_application_error(-20012, 'Error: No se pueden analizar promedios de fechas futuras.');
    END IF;
    -----------------------

    -- Calculo asistencias esperadas
    SELECT COUNT(*)
    INTO v_total_esperado
    FROM MEA_REUNIONES_CALENDARIO r, MEA_GRUPOS g, MEA_HISTORICO_GRUPOS h
    WHERE r.id_club = g.id_club 
      AND r.id_grupo = g.id_grupo
      AND h.id_club_grupo = g.id_club 
      AND h.id_grupo = g.id_grupo
      AND r.fech_reunion >= h.fech_i_hist_grupo 
      AND (h.fech_f_hist_grupo IS NULL OR r.fech_reunion <= h.fech_f_hist_grupo)
      AND g.id_club = p_id_club
      AND g.tipo = v_tipo_normalizado
      AND EXTRACT(MONTH FROM r.fech_reunion) = p_mes
      AND EXTRACT(YEAR FROM r.fech_reunion) = p_anio
      AND r.realizada = 'SI';

    -- Calculo Total de inasistencias reales
    SELECT COUNT(*)
    INTO v_total_inasistencias
    FROM MEA_INASISTENTES i, MEA_GRUPOS g
    WHERE i.id_club_reu = g.id_club 
      AND i.id_grupo_reu = g.id_grupo
      AND g.id_club = p_id_club
      AND g.tipo = v_tipo_normalizado
      AND EXTRACT(MONTH FROM i.fech_reunion) = p_mes
      AND EXTRACT(YEAR FROM i.fech_reunion) = p_anio;

    -- Cálculo final
    IF v_total_esperado > 0 THEN
        v_promedio := ((v_total_esperado - v_total_inasistencias) / v_total_esperado) * 100;
    ELSE
        v_promedio := 0;
    END IF;

    v_promedio := ROUND(v_promedio, 2);

    -- IMPRESIÓN EN CONSOLA
    DBMS_OUTPUT.PUT_LINE('--- RESULTADO DEL ANÁLISIS ---');
    DBMS_OUTPUT.PUT_LINE('Club: ' || v_nom_club);
    DBMS_OUTPUT.PUT_LINE('Periodo: ' || p_mes || '/' || p_anio);
    DBMS_OUTPUT.PUT_LINE('Tipo de Grupo: ' || v_tipo_normalizado);
    DBMS_OUTPUT.PUT_LINE('Promedio de Asistencia: ' || v_promedio || '%');
    DBMS_OUTPUT.PUT_LINE('------------------------------');

    RETURN v_promedio;

EXCEPTION
    WHEN OTHERS THEN
        -- Si el error no es uno de los definidos arriba, relanzar con mensaje general
        IF SQLCODE NOT BETWEEN -20999 AND -20000 THEN
            raise_application_error(-20013, 'Error inesperado en la función: ' || SQLERRM);
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
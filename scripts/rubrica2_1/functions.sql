CREATE OR REPLACE FUNCTION Conversion_Monetaria(
    p_id_pais IN PAISES.id_pais%TYPE,
    p_monto IN NUMBER,
    p_tasa_cambio IN NUMBER
) RETURN NUMBER IS
    v_monto_usd NUMBER;
    v_nom_moneda PAISES.moneda%TYPE;
BEGIN
    -- Buscamos el nombre de la moneda basado en el ID del país
    SELECT moneda 
    INTO v_nom_moneda
    FROM PAISES
    WHERE id_pais = p_id_pais;

    -- Realizamos la conversión
    v_monto_usd := p_monto / p_tasa_cambio;
    
    -- Feedback para el usuario con la moneda recuperada de la tabla
    DBMS_OUTPUT.PUT_LINE(p_monto || ' ' || v_nom_moneda || ' cambiados a ' || v_monto_usd || ' dolares');

    RETURN (v_monto_usd);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        raise_application_error(-20007, 'El ID de país proporcionado no existe.');
        RETURN NULL;
    WHEN ZERO_DIVIDE THEN
        raise_application_error(-20005, 'La tasa de cambio no puede ser cero.');
        RETURN NULL;
    WHEN OTHERS THEN
        raise_application_error(-20006, 'Error en la conversión monetaria: ' || SQLERRM);
        RETURN NULL;
END;

--=========================================================================

CREATE OR REPLACE FUNCTION Antigüedad_en_club_miembro (v_fecha DATE) 
RETURN NUMBER IS 
BEGIN 
    -- Se calcula la diferencia en días y se redondea al dividir entre los días del año.
    RETURN (ROUND(((SYSDATE - v_fecha) / 365), 0)); 
END;

-- Query de prueba para Antigüedad_en_club_miembro
SELECT 
    p_nombre AS "Nombre", 
    f_nacimiento AS "Fecha Nacimiento",
    Antigüedad_en_club_miembro(f_nacimiento) AS "Edad Calculada"
FROM MEA_LECTORES;

--=========================================================================

CREATE OR REPLACE FUNCTION participacion_bimestre_miembro (id_part_lector number)
RETURN NUMBER IS
    v_inasistencias NUMBER;
    v_total_reuniones NUMBER;
    v_porcentaje NUMBER;
BEGIN

    SELECT count(*) INTO v_inasistencias
        FROM mea_inasistentes
        WHERE id_part_lector = id_lector AND fech_reunion between add_months(SYSDATE,-2) AND SYSDATE;

    SELECT count(*) INTO v_total_reuniones    
        FROM mea_historico_grupos h, mea_reuniones_calendario r 
        WHERE 
            id_part_lector = h.id_lector 
            AND h.id_club_grupo = r.id_club 
            AND h.id_grupo = r.id_grupo 
            AND r.fech_reunion >= h.fech_i_hist_grupo 
            AND (h.fech_f_hist_grupo IS NULL OR r.fech_reunion <= h.fech_f_hist_grupo) 
            AND r.fech_reunion between add_months(SYSDATE,-2) AND SYSDATE 
            AND r.realizada = 'SI';

    IF v_total_reuniones = 0 THEN
        RETURN 0;
    ELSE
        v_porcentaje := ((v_total_reuniones - v_inasistencias) / v_total_reuniones) * 100;
        RETURN v_porcentaje;
    END IF;
END;
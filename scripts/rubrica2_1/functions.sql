-- =============================================================================
-- TIPOS Y FUNCIONES - PROYECTO CLUBES DE LECTURA (MEA)
-- =============================================================================

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

CREATE OR REPLACE FUNCTION MEA_conversion_monetaria(
    p_id_pais     IN NUMBER,
    p_monto       IN NUMBER,
    p_tasa_cambio IN NUMBER
) RETURN MEA_conversion_table PIPELINED IS
    v_monto_usd  NUMBER;
    v_moneda     VARCHAR2(3);
    v_pais       VARCHAR2(20);
BEGIN
    SELECT moneda, nom_pais INTO v_moneda, v_pais
    FROM MEA_PAISES WHERE id_pais = p_id_pais;

    IF v_moneda = 'USD' THEN v_monto_usd := p_monto;
    ELSE v_monto_usd := ROUND(p_monto / p_tasa_cambio, 2);
    END IF;

    PIPE ROW (MEA_conversion_row(p_id_pais, v_pais, v_moneda, p_monto, 
        CASE WHEN v_moneda = 'USD' THEN 'Misma moneda (USD)' ELSE '1 USD = ' || p_tasa_cambio || ' ' || v_moneda END,
        v_monto_usd || ' USD'));
    RETURN;
END;
/

CREATE OR REPLACE FUNCTION MEA_edad_miembro(p_id_lector IN NUMBER) 
RETURN NUMBER IS
    v_f_nacimiento DATE;
BEGIN
    SELECT f_nacimiento INTO v_f_nacimiento
    FROM MEA_LECTORES
    WHERE id_lector = p_id_lector;
    
    RETURN TRUNC(MONTHS_BETWEEN(SYSDATE, v_f_nacimiento) / 12);

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        raise_application_error(-20015, 'Error: El lector con ID ' || p_id_lector || ' no existe.');
    WHEN OTHERS THEN
        raise_application_error(-20016, 'Error al calcular edad: ' || SQLERRM);
END;
/

CREATE OR REPLACE FUNCTION MEA_antiguedad_miembro(p_id_lector IN NUMBER)
RETURN NUMBER IS
    v_fech_i DATE;
BEGIN
    SELECT MIN(fech_i_socio) INTO v_fech_i
    FROM MEA_SOCIOS
    WHERE id_lector = p_id_lector;
    
    IF v_fech_i IS NULL THEN
        RETURN 0;
    END IF;
    
    RETURN TRUNC(MONTHS_BETWEEN(SYSDATE, v_fech_i) / 12);

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        raise_application_error(-20017, 'Error: El lector ' || p_id_lector || ' no es socio de ningún club.');
    WHEN OTHERS THEN
        raise_application_error(-20018, 'Error al calcular antigüedad: ' || SQLERRM);
END;
/

CREATE OR REPLACE FUNCTION MEA_participacion_bimestre_miembro (p_id_lector NUMBER, p_bimestre NUMBER, p_anio NUMBER)
RETURN NUMBER IS
    v_inasistencias NUMBER;
    v_total_reuniones NUMBER;
    v_porcentaje NUMBER;
BEGIN
    IF p_bimestre < 1 OR p_bimestre > 6 THEN
        raise_application_error(-20014, 'Error: El bimestre debe ser un valor entre 1 y 6.');
    END IF;

    SELECT count(*) INTO v_inasistencias
        FROM mea_inasistentes
        WHERE p_id_lector = id_lector 
            AND EXTRACT(YEAR FROM fech_reunion) = p_anio
            AND EXTRACT(MONTH FROM fech_reunion) BETWEEN (p_bimestre - 1) * 2 + 1 AND p_bimestre * 2;

    SELECT count(*) INTO v_total_reuniones    
        FROM mea_historico_grupos h, mea_reuniones_calendario r 
        WHERE 
            p_id_lector = h.id_lector 
            AND h.id_club_grupo = r.id_club 
            AND h.id_grupo = r.id_grupo 
            AND r.fech_reunion >= h.fech_i_hist_grupo 
            AND (h.fech_f_hist_grupo IS NULL OR r.fech_reunion <= h.fech_f_hist_grupo) 
            AND EXTRACT(YEAR FROM r.fech_reunion) = p_anio
            AND EXTRACT(MONTH FROM r.fech_reunion) BETWEEN (p_bimestre - 1) * 2 + 1 AND p_bimestre * 2
            AND r.realizada = 'SI';

    IF v_total_reuniones = 0 THEN
        RETURN 0;
    ELSE
        v_porcentaje := ((v_total_reuniones - v_inasistencias) / v_total_reuniones) * 100;
        RETURN v_porcentaje;
    END IF;
END;
/







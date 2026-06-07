--insertar aquí el code de las funciones

CREATE OR REPLACE FUNCTION Antigüedad_en_club_miembro (v_fecha DATE) 
RETURN NUMBER IS 
BEGIN 
    -- Se calcula la diferencia en días y se redondea al dividir entre los días del año.
    RETURN (ROUND(((SYSDATE - v_fecha) / 365), 0)); 
END;


CREATE OR REPLACE FUNCTION %participacion_bimestre_miembro (id_part_lector number)
RETURN NUMBER IS
    v_inasistencias NUMBER;
    v_total_reuniones NUMBER;
    v_porcentaje NUMBER;
BEGIN
    
    SELECT count(*) INTO v_inasistencias
        FROM inasistentes
        WHERE id_part_lector = id_lector AND fech_reunion between add_months(SYSDATE,-2) AND SYSDATE;

    SELECT count(*) INTO v_total_reuniones    
        FROM historico_grupos h, reuniones_calendario r 
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
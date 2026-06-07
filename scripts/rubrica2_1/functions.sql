--insertar aquí el code de las funciones

CREATE OR REPLACE FUNCTION Antigüedad_en_club_miembro (v_fecha DATE) 
RETURN NUMBER IS 
BEGIN 
    -- Se calcula la diferencia en días y se redondea al dividir entre los días del año.
    RETURN (ROUND(((SYSDATE - v_fecha) / 365), 0)); 
END;
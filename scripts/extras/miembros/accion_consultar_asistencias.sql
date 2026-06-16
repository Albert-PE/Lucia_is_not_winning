CLEAR SCREEN
PROMPT =========================================================
PROMPT             CONSULTAR ASISTENCIA POR BIMESTRE
PROMPT =========================================================
PROMPT

PROMPT --- LECTORES ACTIVOS ---
COLUMN id_club FORMAT 999 HEADING 'ID Club'
COLUMN nombre_club FORMAT A25 HEADING 'Club'
COLUMN id_lector FORMAT 99999 HEADING 'ID Lector'
COLUMN nombre_completo FORMAT A30 HEADING 'Nombre Lector'

SELECT 
    c.id_club,
    c.nombre_club,
    s.id_lector, 
    l.p_nombre || ' ' || l.p_apellido AS nombre_completo
FROM MEA_SOCIOS s
JOIN MEA_CLUBES c ON s.id_club = c.id_club
JOIN MEA_LECTORES l ON s.id_lector = l.id_lector
WHERE s.status_socio = 'activo'
ORDER BY c.id_club, s.id_lector;

ACCEPT v_id_lector NUMBER FORMAT '99999' PROMPT '>> Ingrese el ID del Lector a consultar: '

PROMPT
PROMPT --- SELECCIONE EL BIMESTRE ---
PROMPT 1: Enero - Febrero
PROMPT 2: Marzo - Abril
PROMPT 3: Mayo - Junio
PROMPT 4: Julio - Agosto
PROMPT 5: Septiembre - Octubre
PROMPT 6: Noviembre - Diciembre
ACCEPT v_bimestre NUMBER FORMAT '9' PROMPT '>> Ingrese el numero del bimestre (1-6): '

PROMPT
ACCEPT v_anio NUMBER FORMAT '9999' PROMPT '>> Ingrese el ano (ej. 2024): '

PROMPT
PROMPT =========================================================
PROMPT                 RESULTADO DE ASISTENCIA
PROMPT =========================================================

DECLARE
    v_porcentaje NUMBER;
BEGIN
    v_porcentaje := MEA_participacion_bimestre_miembro(&v_id_lector, &v_bimestre, &v_anio);
    
    DBMS_OUTPUT.PUT_LINE('Porcentaje de asistencia del lector ' || &v_id_lector || ' en el bimestre ' || &v_bimestre || ' del ano ' || &v_anio || ':');
    DBMS_OUTPUT.PUT_LINE('>>> ' || ROUND(v_porcentaje, 2) || '%');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('!!! ERROR !!!');
        DBMS_OUTPUT.PUT_LINE('Mensaje: ' || SQLERRM);
END;
/

PROMPT
PROMPT Presione ENTER para volver al menu de miembros...
PAUSE

UNDEFINE v_id_lector
UNDEFINE v_bimestre
UNDEFINE v_anio

@@menu_miembros.sql

CLEAR SCREEN
PROMPT =========================================================
PROMPT                  RETIRAR MIEMBRO
PROMPT =========================================================
PROMPT

-- 1. Pedir a cual club pertenece
ACCEPT v_id_club NUMBER FORMAT '999' PROMPT 'Ingrese el ID del Club: '

PROMPT 
PROMPT Mostrando miembros activos del Club &v_id_club...
PROMPT ---------------------------------------------------------
COLUMN id_lector FORMAT 99999 HEADING 'ID Lector'
COLUMN nombre_completo FORMAT A30 HEADING 'Nombre Completo'
COLUMN fech_i_socio FORMAT A12 HEADING 'Fecha Ingreso'

SELECT 
    l.id_lector, 
    l.p_nombre || ' ' || l.p_apellido AS nombre_completo,
    TO_CHAR(s.fech_i_socio, 'YYYY-MM-DD') AS fech_i_socio
FROM MEA_LECTORES l
JOIN MEA_SOCIOS s ON l.id_lector = s.id_lector
WHERE s.id_club = &v_id_club AND s.status_socio = 'activo'
ORDER BY l.id_lector;

PROMPT ---------------------------------------------------------

-- 3. Pedir el id_lector y el motivo
ACCEPT v_id_lector NUMBER FORMAT '99999' PROMPT 'Ingrese el ID del Lector a retirar: '
PROMPT Opciones de motivo: deuda, inasistencia, otro
ACCEPT v_motivo CHAR FORMAT 'A15' PROMPT 'Ingrese el motivo del retiro: '

PROMPT 
PROMPT Procesando el retiro del miembro...
PROMPT ---------------------------------------------------------

BEGIN
    MEA_retirar_miembro(
        p_id_club => &v_id_club,
        p_id_lector => &v_id_lector,
        p_motivo => '&v_motivo'
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

PROMPT
PROMPT Presione ENTER para volver al menu de miembros...
PAUSE

UNDEFINE v_id_club
UNDEFINE v_id_lector
UNDEFINE v_motivo

@@menu_miembros.sql

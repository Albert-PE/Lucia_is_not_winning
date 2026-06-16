CLEAR SCREEN
PROMPT =========================================================
PROMPT             CONSULTAR PAGOS DE MEMBRESIA
PROMPT =========================================================
PROMPT

PROMPT --- SELECCION DE CLUB ---
COLUMN id_club FORMAT 999 HEADING 'ID'
COLUMN nombre_club FORMAT A30 HEADING 'Nombre del Club'
COLUMN cuota_display FORMAT A15 HEADING 'Cuota'
SELECT id_club, nombre_club, NVL(TO_CHAR(cuota_membresia), 'Gratis') AS cuota_display 
FROM MEA_CLUBES 
ORDER BY id_club;

ACCEPT v_id_club PROMPT '>> Ingrese ID del Club a consultar: '

PROMPT
PROMPT --- MIEMBROS DEL CLUB ---
COLUMN id_lector FORMAT 99999 HEADING 'ID Lector'
COLUMN nombre_completo FORMAT A30 HEADING 'Nombre Completo'
COLUMN status_socio FORMAT A10 HEADING 'Estatus'

SELECT 
    s.id_lector, 
    l.p_nombre || ' ' || l.p_apellido AS nombre_completo,
    s.status_socio
FROM MEA_SOCIOS s
JOIN MEA_LECTORES l ON s.id_lector = l.id_lector
WHERE s.id_club = &v_id_club
ORDER BY s.status_socio, s.id_lector;

ACCEPT v_id_lector NUMBER FORMAT '99999' PROMPT '>> Ingrese el ID del Lector para ver su historial de pagos: '

PROMPT
PROMPT =========================================================
PROMPT                 HISTORIAL DE PAGOS
PROMPT =========================================================
COLUMN num_pago FORMAT 999 HEADING '# Pago'
COLUMN fecha_pago FORMAT A15 HEADING 'Fecha Emision'
COLUMN monto FORMAT A15 HEADING 'Monto Pagado'

SELECT 
    p.id_pago_membresia AS num_pago,
    TO_CHAR(p.fech_emision, 'YYYY-MM-DD') AS fecha_pago,
    NVL(TO_CHAR(c.cuota_membresia), '0') AS monto
FROM MEA_PAGOS_MEMBRESIAS p
JOIN MEA_CLUBES c ON p.id_club = c.id_club
WHERE p.id_club = &v_id_club AND p.id_lector = &v_id_lector
ORDER BY p.fech_emision DESC;

PROMPT
PROMPT Presione ENTER para volver al menu de miembros...
PAUSE

UNDEFINE v_id_club
UNDEFINE v_id_lector

@@menu_miembros.sql

SET VERIFY OFF
DEFINE v_script_club = 'menu_clubes.sql'
UNDEFINE v_opc_club

PROMPT ######################################################################
PROMPT #                       GESTIONAR CLUBES                             #
PROMPT ######################################################################
PROMPT
PROMPT 1. Crear nuevo Club
PROMPT 2. Volver al menu principal
PROMPT

ACCEPT v_opc_club NUMBER PROMPT '>> Seleccione una opcion (1-2): '

COLUMN script_to_run_club NEW_VALUE v_script_club
SELECT CASE &v_opc_club
    WHEN 1 THEN 'accion_crear_club.sql'
    WHEN 2 THEN '../menu_principal.sql'
    ELSE 'menu_clubes.sql'
END AS script_to_run_club FROM DUAL;

UNDEFINE v_opc_club
@@&v_script_club

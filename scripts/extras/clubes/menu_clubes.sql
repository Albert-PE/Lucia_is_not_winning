UNDEFINE v_opc_club

CLEAR SCREEN
PROMPT ######################################################################
PROMPT #                       GESTIONAR CLUBES                             #
PROMPT ######################################################################
PROMPT
PROMPT 1. Crear nuevo Club
PROMPT 2. Volver al menu principal
PROMPT

ACCEPT v_opc_club PROMPT '>> Seleccione una opcion (1-2): '

COLUMN script_to_run NEW_VALUE v_script_club
SELECT CASE 
    WHEN '&v_opc_club' = '1' THEN 'accion_crear_club.sql'
    WHEN '&v_opc_club' = '2' THEN '..\menu_principal.sql'
    WHEN '&v_opc_club' IS NULL THEN '..\salir.sql'
    ELSE 'menu_clubes.sql'
END AS script_to_run FROM DUAL;

@@&v_script_club

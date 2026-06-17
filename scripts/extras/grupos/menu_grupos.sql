UNDEFINE v_opc_grupo

CLEAR SCREEN
PROMPT ######################################################################
PROMPT #                       GESTIONAR GRUPOS                             #
PROMPT ######################################################################
PROMPT
PROMPT 1. Crear nuevo Grupo
PROMPT 2. Hacer split a un Grupo
PROMPT 3. Volver al menu principal
PROMPT

ACCEPT v_opc_grupo PROMPT '>> Seleccione una opcion (1-3): '

COLUMN script_to_run NEW_VALUE v_script_grupo
SELECT CASE 
    WHEN '&v_opc_grupo' = '1' THEN 'accion_crear_grupo.sql'
    WHEN '&v_opc_grupo' = '2' THEN 'accion_split_grupo.sql'
    WHEN '&v_opc_grupo' = '3' THEN '..\menu_principal.sql'
    WHEN '&v_opc_grupo' IS NULL THEN '..\salir.sql'
    ELSE 'menu_grupos.sql'
END AS script_to_run FROM DUAL;

@@&v_script_grupo

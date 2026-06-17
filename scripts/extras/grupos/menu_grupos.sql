SET VERIFY OFF
DEFINE v_script_grupo = 'menu_grupos.sql'
UNDEFINE v_opc_grupo

PROMPT ######################################################################
PROMPT #                       GESTIONAR GRUPOS                             #
PROMPT ######################################################################
PROMPT
PROMPT 1. Crear nuevo Grupo
PROMPT 2. Hacer split a un Grupo
PROMPT 3. Volver al menu principal
PROMPT

ACCEPT v_opc_grupo NUMBER PROMPT '>> Seleccione una opcion (1-3): '

COLUMN script_to_run_grp NEW_VALUE v_script_grupo
SELECT CASE &v_opc_grupo
    WHEN 1 THEN 'accion_crear_grupo.sql'
    WHEN 2 THEN 'accion_split_grupo.sql'
    WHEN 3 THEN '../menu_principal.sql'
    ELSE 'menu_grupos.sql'
END AS script_to_run_grp FROM DUAL;

UNDEFINE v_opc_grupo
@@&v_script_grupo

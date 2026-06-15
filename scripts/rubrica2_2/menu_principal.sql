SET SERVEROUTPUT ON SIZE 1000000
SET VERIFY OFF
SET FEEDBACK OFF
SET LINESIZE 200
SET PAGESIZE 50

UNDEFINE v_opc_principal

CLEAR SCREEN
PROMPT ######################################################################
PROMPT #                     SISTEMA CLUB DE LECTURA                        #
PROMPT ######################################################################
PROMPT
PROMPT 1. Gestionar Clubes
PROMPT 2. Gestionar Grupos
PROMPT 3. Gestionar Reuniones
PROMPT 4. Gestionar Miembros
PROMPT 5. Salir del Sistema
PROMPT

ACCEPT v_opc_principal PROMPT '>> Seleccione una opcion (1-5): '

COLUMN script_to_run NEW_VALUE v_script_principal
SELECT CASE '&v_opc_principal'
    WHEN '1' THEN 'menu_clubes.sql'
    WHEN '2' THEN 'menu_grupos.sql'
    WHEN '3' THEN 'menu_reuniones.sql'
    WHEN '4' THEN 'menu_miembros.sql'
    WHEN '5' THEN 'salir.sql'
    ELSE 'menu_principal.sql'
END AS script_to_run FROM DUAL;

@@&v_script_principal

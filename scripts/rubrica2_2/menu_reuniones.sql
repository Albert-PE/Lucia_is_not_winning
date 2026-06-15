UNDEFINE v_opc_reunion

CLEAR SCREEN
PROMPT ######################################################################
PROMPT #                     GESTIONAR REUNIONES                            #
PROMPT ######################################################################
PROMPT
PROMPT 1. Generar reuniones
PROMPT 2. Volver al menu principal
PROMPT

ACCEPT v_opc_reunion PROMPT '>> Seleccione una opcion (1-2): '

COLUMN script_to_run NEW_VALUE v_script_reunion
SELECT CASE '&v_opc_reunion'
    WHEN '1' THEN 'accion_gen_reuniones.sql'
    WHEN '2' THEN 'menu_principal.sql'
    ELSE 'menu_reuniones.sql'
END AS script_to_run FROM DUAL;

@@&v_script_reunion

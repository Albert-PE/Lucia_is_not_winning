SET VERIFY OFF
DEFINE v_script_reunion = 'menu_reuniones.sql'
UNDEFINE opcion_gestion_reuniones

PROMPT ######################################################################
PROMPT #                         GESTIONAR REUNIONES                        #
PROMPT ######################################################################
PROMPT
PROMPT 1. Generar Calendario (Nuevo Libro)
PROMPT 2. Marcar Reunión como Realizada
PROMPT 3. Cierre de Discusión (Finalizar Libro)
PROMPT 4. Volver al menú principal
PROMPT

ACCEPT opcion_gestion_reuniones NUMBER PROMPT '>> Seleccione una opción (1-4): '

COLUMN script_to_run_reu NEW_VALUE v_script_reunion
SELECT CASE &opcion_gestion_reuniones
    WHEN 1 THEN 'accion_gen_reuniones.sql'
    WHEN 2 THEN 'accion_realizar_reunion.sql'
    WHEN 3 THEN 'accion_cerrar_calendario.sql'
    WHEN 4 THEN '../menu_principal.sql'
    ELSE 'menu_reuniones.sql'
END AS script_to_run_reu FROM DUAL;

UNDEFINE opcion_gestion_reuniones
@@&v_script_reunion

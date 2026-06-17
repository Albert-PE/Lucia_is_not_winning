PROMPT ######################################################################
PROMPT #                         GESTIONAR REUNIONES                        #
PROMPT ######################################################################
PROMPT
PROMPT 1. Generar Calendario (Nuevo Libro)
PROMPT 2. Marcar Reunión como Realizada
PROMPT 3. Cierre de Discusión (Finalizar Libro)
PROMPT 4. Volver al menú principal
PROMPT

COLUMN script_to_run NEW_VALUE v_script_reunion
SELECT CASE 
    WHEN '&opcion_gestion_reuniones' = '1' THEN 'accion_gen_reuniones.sql'
    WHEN '&opcion_gestion_reuniones' = '2' THEN 'accion_realizar_reunion.sql'
    WHEN '&opcion_gestion_reuniones' = '3' THEN 'accion_cerrar_calendario.sql'
    WHEN '&opcion_gestion_reuniones' = '4' THEN '..\menu_principal.sql'
    WHEN '&opcion_gestion_reuniones' IS NULL THEN '..\salir.sql'
    ELSE 'menu_reuniones.sql'
END AS script_to_run FROM DUAL;

@@&v_script_reunion

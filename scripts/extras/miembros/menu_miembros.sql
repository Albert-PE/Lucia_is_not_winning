UNDEFINE v_opc_miembro

CLEAR SCREEN
PROMPT ######################################################################
PROMPT #                     GESTIONAR MIEMBROS                             #
PROMPT ######################################################################
PROMPT
PROMPT 1. Anadir nuevo miembro
PROMPT 2. Consultar pagos de membresia
PROMPT 3. Consultar bimestre de asistencias
PROMPT 4. Retirar miembro
PROMPT 5. Modificar libros favoritos
PROMPT 6. Volver al menu principal
PROMPT

ACCEPT v_opc_miembro PROMPT '>> Seleccione una opcion (1-6): '

COLUMN script_to_run NEW_VALUE v_script_miembro
SELECT CASE 
    WHEN '&v_opc_miembro' = '1' THEN 'menu_inscribir.sql'
    WHEN '&v_opc_miembro' = '2' THEN 'accion_consultar_pagos.sql'
    WHEN '&v_opc_miembro' = '3' THEN 'accion_consultar_asistencias.sql'
    WHEN '&v_opc_miembro' = '4' THEN 'accion_retirar_miembro.sql'
    WHEN '&v_opc_miembro' = '5' THEN 'accion_modificar_favoritos.sql'
    WHEN '&v_opc_miembro' = '6' THEN '..\menu_principal.sql'
    WHEN '&v_opc_miembro' IS NULL THEN '..\salir.sql'
    ELSE 'menu_miembros.sql'
END AS script_to_run FROM DUAL;

@@&v_script_miembro

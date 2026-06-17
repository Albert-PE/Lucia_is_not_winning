SET DEFINE ON
SET SERVEROUTPUT ON
SET FEEDBACK OFF

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

-- Pre-definimos la variable para evitar que SQL Developer muestre un popup pidiendo su valor
DEFINE v_script_principal = 'menu_principal.sql'

COLUMN script_to_run NEW_VALUE v_script_principal
-- Usamos & directo para que SQL Developer abra el popup automáticamente
SELECT CASE 
    WHEN '&opcion_menu_principal' = '1' THEN 'clubes\menu_clubes.sql'
    WHEN '&opcion_menu_principal' = '2' THEN 'grupos\menu_grupos.sql'
    WHEN '&opcion_menu_principal' = '3' THEN 'reuniones\menu_reuniones.sql'
    WHEN '&opcion_menu_principal' = '4' THEN 'miembros\menu_miembros.sql'
    WHEN '&opcion_menu_principal' = '5' THEN 'salir.sql'
    WHEN '&opcion_menu_principal' IS NULL THEN 'salir.sql'
    ELSE 'menu_principal.sql'
END AS script_to_run FROM DUAL;

@@&v_script_principal

-- Limpiamos la variable de opcion para que la vuelva a pedir la proxima vez
UNDEFINE opcion_menu_principal

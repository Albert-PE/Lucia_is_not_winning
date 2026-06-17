SET DEFINE ON
SET SERVEROUTPUT ON
SET FEEDBACK OFF
SET VERIFY OFF

-- 1. Inicializamos la variable de navegación para evitar popups innecesarios
DEFINE v_script_principal = 'menu_principal.sql'
UNDEFINE opcion_menu_principal

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

-- 2. Capturamos la opción del usuario
ACCEPT opcion_menu_principal NUMBER PROMPT '>> Seleccione una opción (1-5): '

-- 3. Usamos COLUMN NEW_VALUE para capturar el resultado de la consulta en la variable
COLUMN script_to_run NEW_VALUE v_script_principal

SELECT CASE &opcion_menu_principal
    WHEN 1 THEN 'clubes/menu_clubes.sql'
    WHEN 2 THEN 'grupos/menu_grupos.sql'
    WHEN 3 THEN 'reuniones/menu_reuniones.sql'
    WHEN 4 THEN 'miembros/menu_miembros.sql'
    WHEN 5 THEN 'salir.sql'
    ELSE 'menu_principal.sql'
END AS script_to_run FROM DUAL;

-- 4. Limpiamos la opción para la siguiente vuelta
UNDEFINE opcion_menu_principal

-- 5. Ejecutamos el script resultante (usando la variable capturada por NEW_VALUE)
@@&v_script_principal

CLEAR SCREEN
PROMPT =========================================================
PROMPT                  CREAR NUEVO GRUPO
PROMPT =========================================================
PROMPT

PROMPT --- LISTA DE CLUBES ---
COLUMN id_club FORMAT 999 HEADING 'ID'
COLUMN nombre_club FORMAT A30 HEADING 'Nombre del Club'
SELECT id_club, nombre_club FROM MEA_CLUBES ORDER BY id_club;

ACCEPT v_id_club PROMPT '>> Ingrese ID del Club al que pertenecera el grupo: '

PROMPT
PROMPT --- TIPOS DE GRUPO ---
PROMPT - infantil
PROMPT - joven
PROMPT - adulto
ACCEPT v_tipo PROMPT '>> Ingrese el tipo de grupo: '

PROMPT
PROMPT Creando grupo...
PROMPT ---------------------------------------------------------

BEGIN
    MEA_crear_grupo(
        p_id_club => &v_id_club,
        p_tipo => LOWER('&v_tipo')
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('!!! ERROR AL CREAR EL GRUPO !!!');
        DBMS_OUTPUT.PUT_LINE('Mensaje: ' || SQLERRM);
        ROLLBACK;
END;
/

PROMPT
PROMPT Presione ENTER para volver al menu de grupos...
PAUSE

UNDEFINE v_id_club
UNDEFINE v_tipo

@@menu_grupos.sql

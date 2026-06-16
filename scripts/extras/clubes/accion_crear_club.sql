CLEAR SCREEN
PROMPT =========================================================
PROMPT                  CREAR NUEVO CLUB
PROMPT =========================================================
PROMPT

ACCEPT v_nombre_club PROMPT '>> Ingrese Nombre del Club: '
ACCEPT v_direccion PROMPT '>> Ingrese Direccion: '
ACCEPT v_codigo_postal PROMPT '>> Ingrese Codigo Postal: '

PROMPT
PROMPT --- LISTA DE PAISES ---
COLUMN id_pais FORMAT 999 HEADING 'ID'
COLUMN nom_pais FORMAT A20 HEADING 'Pais'
SELECT id_pais, nom_pais FROM MEA_PAISES ORDER BY id_pais;
ACCEPT v_id_pais NUMBER FORMAT '999' PROMPT '>> Ingrese ID del Pais: '

PROMPT
PROMPT --- LISTA DE CIUDADES ---
COLUMN id_ciudad FORMAT 999 HEADING 'ID'
COLUMN nom_ciudad FORMAT A20 HEADING 'Ciudad'
SELECT id_ciudad, nom_ciudad FROM MEA_CIUDADES WHERE id_pais = &v_id_pais ORDER BY id_ciudad;
ACCEPT v_id_ciudad NUMBER FORMAT '999' PROMPT '>> Ingrese ID de la Ciudad: '

PROMPT
PROMPT --- INSTITUCIONES ASOCIADAS ---
PROMPT (Los clubes asociados a una institucion NO tienen cuota de membresia)
COLUMN id_inst FORMAT 999 HEADING 'ID'
COLUMN nom_inst FORMAT A35 HEADING 'Institucion'
COLUMN tipo_inst FORMAT A15 HEADING 'Tipo'
SELECT id_inst, nom_inst, tipo_inst FROM MEA_INSTITUCIONES ORDER BY id_inst;

ACCEPT v_id_inst PROMPT '>> Ingrese ID de Institucion (ENTER para dejar vacio): ' DEFAULT 'NULL'

PROMPT
PROMPT --- CUOTA DE MEMBRESIA ---
PROMPT (Deje vacio si el club es gratuito o si esta asociado a una institucion)
ACCEPT v_cuota PROMPT '>> Ingrese Cuota de Membresia: ' DEFAULT 'NULL'

PROMPT
PROMPT Creando club...
PROMPT ---------------------------------------------------------

DECLARE
    v_id_inst NUMBER := NULL;
    v_cuota NUMBER := NULL;
BEGIN
    IF '&v_id_inst' <> 'NULL' AND TRIM('&v_id_inst') IS NOT NULL THEN
        v_id_inst := TO_NUMBER('&v_id_inst');
    END IF;

    IF '&v_cuota' <> 'NULL' AND TRIM('&v_cuota') IS NOT NULL THEN
        v_cuota := TO_NUMBER('&v_cuota');
    END IF;

    MEA_crear_club(
        p_nombre => '&v_nombre_club',
        p_direccion => '&v_direccion',
        p_codigo_postal => '&v_codigo_postal',
        p_id_pais => &v_id_pais,
        p_id_ciudad => &v_id_ciudad,
        p_id_inst => v_id_inst,
        p_cuota => v_cuota
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('!!! ERROR AL CREAR EL CLUB !!!');
        DBMS_OUTPUT.PUT_LINE('Mensaje: ' || SQLERRM);
        ROLLBACK;
END;
/

PROMPT
PROMPT Presione ENTER para volver al menu de clubes...
PAUSE

UNDEFINE v_nombre_club
UNDEFINE v_direccion
UNDEFINE v_codigo_postal
UNDEFINE v_id_pais
UNDEFINE v_id_ciudad
UNDEFINE v_id_inst
UNDEFINE v_cuota

@@menu_clubes.sql

SET SERVEROUTPUT ON SIZE 1000000
SET VERIFY OFF
SET FEEDBACK OFF
SET LINESIZE 200
SET PAGESIZE 50

UNDEFINE v_doc_identidad
UNDEFINE v_p_nombre
UNDEFINE v_s_nombre
UNDEFINE v_p_apellido
UNDEFINE v_s_apellido
UNDEFINE v_f_nacimiento
UNDEFINE v_email
UNDEFINE v_id_club
UNDEFINE v_id_repre_lector
UNDEFINE v_doc_repre_ext
UNDEFINE v_nom_repre_ext
UNDEFINE v_ape_repre_ext
UNDEFINE v_sape_repre_ext
UNDEFINE v_isbn_fav1
UNDEFINE v_isbn_fav2
UNDEFINE v_isbn_fav3
CLEAR SCREEN
PROMPT
PROMPT ######################################################################
PROMPT #                 INSCRIPCION DE NUEVO MIEMBRO                       #
PROMPT ######################################################################
PROMPT

PROMPT --- SELECCION DE CLUB ---
COLUMN id_club FORMAT 999 HEADING 'ID'
COLUMN nombre_club FORMAT A30 HEADING 'Nombre del Club'
COLUMN cuota_display FORMAT A15 HEADING 'Cuota'
SELECT id_club, nombre_club, NVL(TO_CHAR(cuota_membresia), 'Gratis') AS cuota_display FROM MEA_CLUBES ORDER BY id_club;
ACCEPT v_id_club       PROMPT '>> Ingrese ID del Club al que se une: '

PROMPT
PROMPT --- DATOS PERSONALES ---
ACCEPT v_doc_identidad PROMPT '>> Ingrese Documento de Identidad (ej. 12345678): '
ACCEPT v_p_nombre      PROMPT '>> Ingrese Primer Nombre: '
ACCEPT v_s_nombre      PROMPT '>> Ingrese Segundo Nombre: '
ACCEPT v_p_apellido    PROMPT '>> Ingrese Primer Apellido: '
ACCEPT v_s_apellido    PROMPT '>> Ingrese Segundo Apellido: '
PROMPT (Formato Fecha: YYYY-MM-DD)
ACCEPT v_f_nacimiento  PROMPT '>> Ingrese Fecha de Nacimiento (ej. 2005-05-10): '
ACCEPT v_email         PROMPT '>> Ingrese Email: '

PROMPT
PROMPT --- DATOS DE REPRESENTANTE (Solo si es menor de 18 anos) ---
PROMPT Opcion A: Si el representante es un Lector existente:
ACCEPT v_id_repre_lector PROMPT '>> Ingrese ID de Lector Representante (ENTER si no aplica): ' DEFAULT 'NULL'

PROMPT Opcion B: Si el representante es externo (no registrado en ningun club):
ACCEPT v_doc_repre_ext   PROMPT '>> Ingrese Doc Identidad del Representante (ENTER si no aplica): ' DEFAULT 'NULL'
ACCEPT v_nom_repre_ext   PROMPT '>> Ingrese Primer Nombre del Representante: ' DEFAULT 'NULL'
ACCEPT v_ape_repre_ext   PROMPT '>> Ingrese Primer Apellido del Representante: ' DEFAULT 'NULL'
ACCEPT v_sape_repre_ext  PROMPT '>> Ingrese Segundo Apellido del Representante: ' DEFAULT 'NULL'

PROMPT
PROMPT --- SELECCION DE LIBROS FAVORITOS ---
PROMPT A continuacion se muestra la lista de libros disponibles:
COLUMN isbn FORMAT 9999999999999 HEADING 'ISBN'
COLUMN titulo_libro FORMAT A35 HEADING 'Titulo'
COLUMN tema FORMAT A15 HEADING 'Tema'
SELECT isbn, titulo_libro, tema FROM MEA_LIBROS ORDER BY titulo_libro;

PROMPT Indique sus 3 libros favoritos (1 = Mas favorito, 3 = Menos favorito)
ACCEPT v_isbn_fav1 PROMPT '>> Ingrese ISBN del Favorito #1: ' DEFAULT 'NULL'
ACCEPT v_isbn_fav2 PROMPT '>> Ingrese ISBN del Favorito #2: ' DEFAULT 'NULL'
ACCEPT v_isbn_fav3 PROMPT '>> Ingrese ISBN del Favorito #3: ' DEFAULT 'NULL'

PROMPT
PROMPT Procesando inscripcion...

DECLARE
    v_id_repre_lector NUMBER := NULL;
    v_doc_repre_ext   NUMBER := NULL;
    v_nom_repre_ext   VARCHAR2(15) := NULL;
    v_ape_repre_ext   VARCHAR2(15) := NULL;
    v_sape_repre_ext  VARCHAR2(15) := NULL;
BEGIN
    -- Validamos y asignamos id_repre_lector
    IF '&v_id_repre_lector' <> 'NULL' AND TRIM('&v_id_repre_lector') IS NOT NULL THEN
        v_id_repre_lector := TO_NUMBER('&v_id_repre_lector');
    END IF;

    -- Validamos y asignamos doc_repre_ext
    IF '&v_doc_repre_ext' <> 'NULL' AND TRIM('&v_doc_repre_ext') IS NOT NULL THEN
        v_doc_repre_ext := TO_NUMBER('&v_doc_repre_ext');
    END IF;

    -- Validamos y asignamos nombres/apellidos
    IF '&v_nom_repre_ext' <> 'NULL' AND TRIM('&v_nom_repre_ext') IS NOT NULL THEN
        v_nom_repre_ext := '&v_nom_repre_ext';
    END IF;

    IF '&v_ape_repre_ext' <> 'NULL' AND TRIM('&v_ape_repre_ext') IS NOT NULL THEN
        v_ape_repre_ext := '&v_ape_repre_ext';
    END IF;

    IF '&v_sape_repre_ext' <> 'NULL' AND TRIM('&v_sape_repre_ext') IS NOT NULL THEN
        v_sape_repre_ext := '&v_sape_repre_ext';
    END IF;

    -- Validamos y asignamos libros favoritos
    DECLARE
        v_fav1 NUMBER := NULL;
        v_fav2 NUMBER := NULL;
        v_fav3 NUMBER := NULL;
    BEGIN
        IF '&v_isbn_fav1' <> 'NULL' AND TRIM('&v_isbn_fav1') IS NOT NULL THEN
            v_fav1 := TO_NUMBER('&v_isbn_fav1');
        END IF;
        IF '&v_isbn_fav2' <> 'NULL' AND TRIM('&v_isbn_fav2') IS NOT NULL THEN
            v_fav2 := TO_NUMBER('&v_isbn_fav2');
        END IF;
        IF '&v_isbn_fav3' <> 'NULL' AND TRIM('&v_isbn_fav3') IS NOT NULL THEN
            v_fav3 := TO_NUMBER('&v_isbn_fav3');
        END IF;

    MEA_inscribir_miembro(
        p_doc_identidad      => &v_doc_identidad,
        p_p_nombre           => '&v_p_nombre',
        p_s_nombre           => '&v_s_nombre',
        p_p_apellido         => '&v_p_apellido',
        p_s_apellido         => '&v_s_apellido',
        p_f_nacimiento       => TO_DATE('&v_f_nacimiento', 'YYYY-MM-DD'),
        p_email              => '&v_email',
        p_id_club            => &v_id_club,
        p_isbn_fav1          => v_fav1,
        p_isbn_fav2          => v_fav2,
        p_isbn_fav3          => v_fav3,
        p_id_repre_lector    => v_id_repre_lector,
        p_doc_repre_ext      => v_doc_repre_ext,
        p_nom_repre_ext      => v_nom_repre_ext,
        p_ape_repre_ext      => v_ape_repre_ext,
        p_sape_repre_ext     => v_sape_repre_ext
    );
    END;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('>>> Lector inscrito exitosamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('!!! ERROR EN LA INSCRIPCION !!!');
        DBMS_OUTPUT.PUT_LINE('Mensaje Oracle: ' || SQLERRM);
        ROLLBACK;
END;
/

PROMPT
PROMPT Presione ENTER para continuar...
PAUSE

@@menu_miembros.sql


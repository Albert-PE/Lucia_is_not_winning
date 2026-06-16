CLEAR SCREEN
PROMPT =========================================================
PROMPT               MODIFICAR LIBROS FAVORITOS
PROMPT =========================================================
PROMPT

-- 1. Preguntar cual miembro va a modificar
PROMPT LECTORES REGISTRADOS Y SUS FAVORITOS ACTUALES:
COLUMN id_lector FORMAT 99999 HEADING 'ID Lector'
COLUMN nombre_completo FORMAT A25 HEADING 'Nombre Completo'
COLUMN libros_favoritos FORMAT A60 HEADING 'Top 3 Libros Favoritos'

SELECT 
    l.id_lector, 
    l.p_nombre || ' ' || l.p_apellido AS nombre_completo,
    NVL(LISTAGG(f.orden || '.- ' || lib.titulo_libro, ' | ') WITHIN GROUP (ORDER BY f.orden), 'Sin favoritos registrados') AS libros_favoritos
FROM MEA_LECTORES l
LEFT JOIN MEA_FAVORITOS f ON l.id_lector = f.id_lector
LEFT JOIN MEA_LIBROS lib ON f.isbn = lib.isbn
GROUP BY l.id_lector, l.p_nombre, l.p_apellido
ORDER BY l.id_lector;
PROMPT ---------------------------------------------------------
ACCEPT v_id_lector NUMBER FORMAT '99999' PROMPT '>> Ingrese el ID del Lector que desea modificar: '

-- 2. Mostrar libros disponibles
PROMPT
PROMPT --- SELECCION DE LIBROS FAVORITOS ---
PROMPT A continuacion se muestra la lista de libros disponibles:
COLUMN isbn FORMAT 9999999999999 HEADING 'ISBN'
COLUMN titulo_libro FORMAT A35 HEADING 'Titulo'
COLUMN tema FORMAT A15 HEADING 'Tema'
SELECT isbn, titulo_libro, tema FROM MEA_LIBROS ORDER BY titulo_libro;

-- 3. Pedir el nuevo Top 3
PROMPT
PROMPT ATENCION: Esta accion reemplazara la lista de favoritos completa del lector.
PROMPT Debe ingresar los 3 libros en orden. Si desea mantener algun libro, ingreselo de nuevo.
PROMPT Indique sus 3 libros favoritos (1 = Mas favorito, 3 = Menos favorito)
ACCEPT v_isbn_fav1 PROMPT '>> Ingrese ISBN del Favorito #1: ' DEFAULT 'NULL'
ACCEPT v_isbn_fav2 PROMPT '>> Ingrese ISBN del Favorito #2: ' DEFAULT 'NULL'
ACCEPT v_isbn_fav3 PROMPT '>> Ingrese ISBN del Favorito #3: ' DEFAULT 'NULL'

PROMPT
PROMPT Actualizando libros favoritos...
PROMPT ---------------------------------------------------------

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

    -- Llamar al procedimiento modularizado
    MEA_asignar_favoritos(
        p_id_lector => &v_id_lector,
        p_isbn_fav1 => v_fav1,
        p_isbn_fav2 => v_fav2,
        p_isbn_fav3 => v_fav3
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('!!! ERROR !!!');
        DBMS_OUTPUT.PUT_LINE('Mensaje: ' || SQLERRM);
        ROLLBACK;
END;
/

PROMPT
PROMPT Presione ENTER para volver al menu de miembros...
PAUSE

UNDEFINE v_id_lector
UNDEFINE v_isbn_fav1
UNDEFINE v_isbn_fav2
UNDEFINE v_isbn_fav3

@@menu_miembros.sql

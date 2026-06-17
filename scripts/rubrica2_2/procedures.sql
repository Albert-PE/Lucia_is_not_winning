-- PROCEDURE: DIVIDIR GRUPO
-- Propósito: Dividir un grupo en dos, moviendo la mitad mas nueva al nuevo grupo.
CREATE OR REPLACE PROCEDURE MEA_dividir_grupo(
    p_id_club IN NUMBER,
    p_id_grupo IN NUMBER
)
IS
    v_nuevo_id_grupo NUMBER;
    v_conteo_actual NUMBER;
    v_mitad NUMBER;
    v_fecha_actual DATE := SYSDATE;
    v_tipo VARCHAR2(10);
    v_dia NUMBER;
    v_hora NUMBER;
    v_reuniones_pendientes NUMBER;
BEGIN
    -- 0. Validar que el grupo no esté discutiendo un libro actualmente
    -- Un grupo está discutiendo un libro si tiene reuniones en el calendario que aún no se han realizado.
    SELECT COUNT(*) INTO v_reuniones_pendientes
    FROM MEA_REUNIONES_CALENDARIO
    WHERE id_club = p_id_club 
      AND id_grupo = p_id_grupo
      AND ult_discusion = 'SI'
      AND realizada = 'NO';

    IF v_reuniones_pendientes > 0 THEN
        raise_application_error(-20050, 'ERROR: No se puede realizar el split del grupo porque actualmente se encuentra discutiendo un libro (tiene reuniones pendientes por realizar).');
    END IF;

    -- 1. Obtener datos del grupo original para heredarlos
    BEGIN
        SELECT tipo, dia_reunion, hora_i_reunion 
        INTO v_tipo, v_dia, v_hora
        FROM MEA_GRUPOS
        WHERE id_club = p_id_club AND id_grupo = p_id_grupo;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            raise_application_error(-20004, 'El grupo ' || p_id_grupo || ' no existe en el club ' || p_id_club);
    END;

    -- 2. Verificar cuantos miembros tiene actualmente
    SELECT COUNT(*) INTO v_conteo_actual
    FROM MEA_HISTORICO_GRUPOS
    WHERE id_club_grupo = p_id_club AND id_grupo = p_id_grupo AND fech_f_hist_grupo IS NULL;

    IF v_conteo_actual < 2 THEN
        DBMS_OUTPUT.PUT_LINE('El grupo es demasiado pequeno para dividirse.');
        RETURN;
    END IF;

    -- 3. Crear el nuevo grupo clonando el horario
    v_nuevo_id_grupo := MEA_seq_grupos.NEXTVAL;
    
    INSERT INTO MEA_GRUPOS (
        id_club, id_grupo, fech_creacion, tipo, dia_reunion, hora_i_reunion
    ) VALUES (
        p_id_club, v_nuevo_id_grupo, v_fecha_actual, v_tipo, v_dia, v_hora
    );

    -- 4. Mover la mitad mas nueva al nuevo grupo
    v_mitad := FLOOR(v_conteo_actual / 2);

    FOR rec IN (
        SELECT id_lector, fech_i_socio
        FROM MEA_HISTORICO_GRUPOS
        WHERE id_club_grupo = p_id_club AND id_grupo = p_id_grupo AND fech_f_hist_grupo IS NULL
        ORDER BY MEA_antiguedad_miembro(id_lector) ASC, fech_i_socio DESC
        FETCH FIRST v_mitad ROWS ONLY
    ) LOOP
        -- Anadir al nuevo grupo (el trigger MEA_TRG_TRASLADO_GRUPO cerrara el grupo anterior automaticamente)
        INSERT INTO MEA_HISTORICO_GRUPOS (
            id_club_grupo, id_grupo, id_club_soc, id_lector, 
            fech_i_socio, fech_i_hist_grupo
        ) VALUES (
            p_id_club, v_nuevo_id_grupo, p_id_club, rec.id_lector, 
            rec.fech_i_socio, v_fecha_actual
        );
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('--- DIVISION AUTOMATICA ---');
    DBMS_OUTPUT.PUT_LINE('Se creo el grupo ID: ' || v_nuevo_id_grupo || ' heredando el horario del grupo ' || p_id_grupo || '.');
    DBMS_OUTPUT.PUT_LINE('Se movieron ' || v_mitad || ' lectores al nuevo grupo.');
END;
/


-- PROCEDURE: INSCRIBIR MIEMBRO
-- Propósito: Inscribir un nuevo miembro en el club
CREATE OR REPLACE PROCEDURE MEA_inscribir_miembro(
    p_doc_identidad IN NUMBER,
    p_p_nombre IN VARCHAR2,
    p_s_nombre IN VARCHAR2,
    p_p_apellido IN VARCHAR2,
    p_s_apellido IN VARCHAR2,
    p_f_nacimiento IN DATE,
    p_email IN VARCHAR2,
    p_id_club IN NUMBER,
    -- Parámetros de libros favoritos
    p_isbn_fav1 IN NUMBER,
    p_isbn_fav2 IN NUMBER,
    p_isbn_fav3 IN NUMBER,
    -- Parámetros opcionales para representantes (menores de edad)
    p_id_repre_lector IN NUMBER DEFAULT NULL,
    p_doc_repre_ext   IN NUMBER DEFAULT NULL,
    p_nom_repre_ext   IN VARCHAR2 DEFAULT NULL,
    p_ape_repre_ext   IN VARCHAR2 DEFAULT NULL,
    p_sape_repre_ext  IN VARCHAR2 DEFAULT NULL
)
IS
    v_id_lector NUMBER;
    v_edad NUMBER;
    v_tipo_grupo VARCHAR2(10);
    v_max_miembros NUMBER;
    v_id_grupo NUMBER;
    v_conteo_actual NUMBER;
    v_fecha_actual DATE := SYSDATE;
BEGIN
    -- 0. Validar si el lector es menor de edad y tiene representante ANTES de insertar nada
    v_edad := TRUNC(MONTHS_BETWEEN(v_fecha_actual, p_f_nacimiento) / 12);
    IF v_edad < 18 AND p_id_repre_lector IS NULL AND p_doc_repre_ext IS NULL THEN
        raise_application_error(-20040, 'El lector es menor de 18 años (tiene ' || v_edad || ' años) y debe tener un representante asignado obligatoriamente.');
    END IF;

    -- 1. Buscamos si el lector ya existe en la base de datos (por su doc_identidad)
    BEGIN
        SELECT id_lector INTO v_id_lector
        FROM MEA_LECTORES
        WHERE doc_identidad = p_doc_identidad;
        
        -- Si existe, no lo volvemos a insertar en LECTORES ni en REPRESENTANTES.
        -- El trigger MEA_TRG_UN_CLUB_A_LA_VEZ validará que no esté activo en otro club al insertarlo en SOCIOS.
        DBMS_OUTPUT.PUT_LINE('El lector ya está registrado en el sistema. Procediendo a inscribirlo al nuevo club...');

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- Lector nuevo, lo insertamos
            v_id_lector := MEA_seq_lectores.NEXTVAL;

            INSERT INTO MEA_LECTORES (
                id_lector, doc_identidad, p_nombre, s_nombre, 
                p_apellido, s_apellido, f_nacimiento, email, id_lector_repre
            ) 
            VALUES (
                v_id_lector, p_doc_identidad, p_p_nombre, p_s_nombre, 
                p_p_apellido, p_s_apellido, p_f_nacimiento, p_email, p_id_repre_lector
            );

            -- Si es nuevo y tiene representante externo, lo registramos en MEA_REPRESENTANTES
            IF p_doc_repre_ext IS NOT NULL THEN
                INSERT INTO MEA_REPRESENTANTES (
                    id_lector, id_representante, doc_identidad, p_nombre, p_apellido, s_apellido
                ) VALUES (
                    v_id_lector, MEA_seq_representantes.NEXTVAL, p_doc_repre_ext, p_nom_repre_ext, p_ape_repre_ext, p_sape_repre_ext
                );
            END IF;
    END;

    -- 2. Actualizar/Insertar Libros Favoritos
    MEA_asignar_favoritos(v_id_lector, p_isbn_fav1, p_isbn_fav2, p_isbn_fav3);

    -- 3. Clasificamos por edad
    v_edad := MEA_edad_miembro(v_id_lector);

    IF v_edad BETWEEN 6 AND 12 THEN
        v_tipo_grupo := 'infantil';
        v_max_miembros := 15;
    ELSIF v_edad BETWEEN 13 AND 24 THEN
        v_tipo_grupo := 'joven';
        v_max_miembros := 15;
    ELSIF v_edad >= 25 THEN
        v_tipo_grupo := 'adulto';
        v_max_miembros := 30;
    ELSE
        raise_application_error(-20001, 'El lector no tiene edad suficiente para ningun grupo.');
    END IF;

    -- 4. Inscribimos al lector como socio
    INSERT INTO MEA_SOCIOS (
        id_club, id_lector, fech_i_socio, status_socio
    ) VALUES (
        p_id_club, v_id_lector, v_fecha_actual, 'activo'
    );

    -- 4. Buscamos el ID de un grupo de ese tipo que pertenezca al club y NO esté discutiendo un libro
    BEGIN
        SELECT MIN(id_grupo) INTO v_id_grupo
        FROM MEA_GRUPOS g
        WHERE g.id_club = p_id_club 
          AND g.tipo = v_tipo_grupo
          AND NOT EXISTS (
              SELECT 1 FROM MEA_REUNIONES_CALENDARIO r
              WHERE r.id_club = g.id_club AND r.id_grupo = g.id_grupo
                AND r.realizada = 'NO'
          );

        IF v_id_grupo IS NULL THEN
            raise_application_error(-20002, 'No se encontró un grupo de tipo ' || v_tipo_grupo || ' disponible (todos están discutiendo un libro actualmente).');
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            raise_application_error(-20002, 'No se encontró un grupo de tipo ' || v_tipo_grupo || ' en el club.');
    END;

    -- 5. Lo anadimos al historico de grupos
    INSERT INTO MEA_HISTORICO_GRUPOS (
        id_club_grupo, id_grupo, id_club_soc, id_lector, 
        fech_i_socio, fech_i_hist_grupo
    ) VALUES (
        p_id_club, v_id_grupo, p_id_club, v_id_lector, 
        v_fecha_actual, v_fecha_actual
    );
    
    DBMS_OUTPUT.PUT_LINE('Lector inscrito exitosamente en el grupo ID: ' || v_id_grupo);

    -- 6. Verificamos el tamano del grupo post-insercion
    SELECT COUNT(*) INTO v_conteo_actual
    FROM MEA_HISTORICO_GRUPOS
    WHERE id_club_grupo = p_id_club AND id_grupo = v_id_grupo AND fech_f_hist_grupo IS NULL;

    -- 7. Logica de Split (Llamada al procedimiento automatico)
    IF v_conteo_actual > v_max_miembros THEN
        DBMS_OUTPUT.PUT_LINE('!ATENCION! Se supero el limite de ' || v_max_miembros || ' miembros.');
        DBMS_OUTPUT.PUT_LINE('Iniciando division automatica...');
        MEA_dividir_grupo(p_id_club, v_id_grupo);
    END IF;
END;
/



-- PROCEDURE: GENERAR CALENDARIO AUTOMÁTICO
-- Propósito: Generar N reuniones a partir de una fecha de inicio, sumando 7 días.
CREATE OR REPLACE PROCEDURE MEA_generar_calendario(
    p_id_club      IN NUMBER,
    p_id_grupo     IN NUMBER,
    p_isbn         IN NUMBER,
    p_fecha_inicio IN DATE,
    p_cant_reun    IN NUMBER,
    p_id_lector    IN NUMBER -- Moderador
) IS
    v_fecha_iterada DATE;
    v_id_club_soc   NUMBER;
    v_fech_i_socio  DATE;
    v_fech_i_hist   DATE;
    v_dummy         NUMBER;
BEGIN
    -- 1. Validar existencia del Club y Grupo
    BEGIN
        SELECT 1 INTO v_dummy FROM MEA_GRUPOS 
        WHERE id_club = p_id_club AND id_grupo = p_id_grupo;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            raise_application_error(-20044, 'ERROR: El grupo '||p_id_grupo||' en el club '||p_id_club||' no existe.');
    END;

    -- 2. Validar existencia del Libro (ISBN)
    BEGIN
        SELECT 1 INTO v_dummy FROM MEA_LIBROS WHERE isbn = p_isbn;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            raise_application_error(-20045, 'ERROR: El libro con ISBN '||p_isbn||' no está registrado en el sistema.');
    END;

    -- 3. Validar existencia y estado del Moderador
    BEGIN
        SELECT id_club_soc, fech_i_socio, fech_i_hist_grupo
        INTO v_id_club_soc, v_fech_i_socio, v_fech_i_hist
        FROM MEA_HISTORICO_GRUPOS
        WHERE id_lector = p_id_lector 
          AND fech_f_hist_grupo IS NULL; -- Moderador activo
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            raise_application_error(-20040, 'ERROR: El moderador (ID: '||p_id_lector||') no existe o no tiene un historial activo en ningún grupo.');
    END;

    -- 4. Generación iterativa
    FOR i IN 0..(p_cant_reun - 1) LOOP
        v_fecha_iterada := p_fecha_inicio + (i * 7);
        
        INSERT INTO MEA_REUNIONES_CALENDARIO (
            id_club, id_grupo, isbn, fech_reunion, realizada,
            id_club_hist, id_grupo_hist, id_club_soc, id_lector, 
            fech_i_socio, fech_i_hist_grupo, ult_discusion
        ) VALUES (
            p_id_club, p_id_grupo, p_isbn, v_fecha_iterada, 'NO',
            p_id_club, p_id_grupo, v_id_club_soc, p_id_lector, 
            v_fech_i_socio, v_fech_i_hist, 'NO'
        );
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Se generaron ' || p_cant_reun || ' reuniones exitosamente.');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
    COMMIT;
END;
/



-- PROCEDURE: REALIZAR REUNIÓN
-- Propósito: Marcar una reunión como realizada.
CREATE OR REPLACE PROCEDURE MEA_realizar_reunion(
    p_id_club   IN NUMBER,
    p_id_grupo  IN NUMBER,
    p_isbn      IN NUMBER,
    p_fecha     IN DATE
) IS
BEGIN
    UPDATE MEA_REUNIONES_CALENDARIO
    SET realizada = 'SI'
    WHERE id_club = p_id_club AND id_grupo = p_id_grupo 
      AND isbn = p_isbn AND fech_reunion = p_fecha;
      
    IF SQL%ROWCOUNT = 0 THEN
        raise_application_error(-20041, 'ERROR: No se encontró la reunión para el club '||p_id_club||', grupo '||p_id_grupo||', libro '||p_isbn||' en la fecha '||TO_CHAR(p_fecha, 'DD/MM/YYYY')||'.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Reunión marcada como REALIZADA.');
    COMMIT;
END;
/



-- PROCEDURE: CIERRE DE DISCUSIÓN Y LIMPIEZA
-- Propósito: Cerrar el libro, pedir valoración y borrar reuniones futuras huérfanas.
CREATE OR REPLACE PROCEDURE MEA_cerrar_calendario(
    p_id_club      IN NUMBER,
    p_id_grupo     IN NUMBER,
    p_isbn         IN NUMBER,
    p_fecha_cierre IN DATE,
    p_valoracion   IN NUMBER,
    p_conclusion   IN VARCHAR2
) IS
BEGIN
    -- 1. Marcar la reunión como la última y realizada
    UPDATE MEA_REUNIONES_CALENDARIO
    SET realizada = 'SI',
        ult_discusion = 'SI',
        valoracion = p_valoracion,
        conclusion = p_conclusion
    WHERE id_club = p_id_club AND id_grupo = p_id_grupo 
      AND isbn = p_isbn AND fech_reunion = p_fecha_cierre;

    IF SQL%ROWCOUNT = 0 THEN
        raise_application_error(-20042, 'ERROR: No se pudo realizar el cierre. Verifique que el ID de club, grupo, ISBN y fecha sean correctos.');
    END IF;

    -- 2. Limpieza: Borrar reuniones futuras que quedaron "en el aire"
    DELETE FROM MEA_REUNIONES_CALENDARIO
    WHERE id_club = p_id_club AND id_grupo = p_id_grupo 
      AND isbn = p_isbn AND fech_reunion > p_fecha_cierre;

    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Calendario cerrado exitosamente. Se eliminaron las reuniones futuras sobrantes.');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
    COMMIT;
END;
/



-- PROCEDURE: RETIRAR MIEMBRO
-- Propósito: Desactiva a un socio de un club y lo retira de su grupo activo.
CREATE OR REPLACE PROCEDURE MEA_retirar_miembro(
    p_id_club IN NUMBER,
    p_id_lector IN NUMBER,
    p_motivo IN VARCHAR2
) IS
BEGIN
    -- 1. Validar y actualizar estado del socio
    UPDATE MEA_SOCIOS
    SET status_socio = 'inactivo',
        fech_f_socio = SYSDATE,
        motivo_retiro = LOWER(p_motivo)
    WHERE id_club = p_id_club 
      AND id_lector = p_id_lector 
      AND status_socio = 'activo';

    IF SQL%ROWCOUNT = 0 THEN
        raise_application_error(-20045, 'El lector indicado no es un socio activo de este club.');
    END IF;

    -- 2. Retirarlo del grupo si pertenece a alguno
    UPDATE MEA_HISTORICO_GRUPOS
    SET fech_f_hist_grupo = SYSDATE
    WHERE id_lector = p_id_lector 
      AND fech_f_hist_grupo IS NULL;

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Se ha retirado al miembro exitosamente.');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    COMMIT;
END;
/



-- PROCEDURE: ASIGNAR LIBROS FAVORITOS
-- Propósito: Actualiza o inserta el Top 3 de libros favoritos de un lector.
CREATE OR REPLACE PROCEDURE MEA_asignar_favoritos(
    p_id_lector IN NUMBER,
    p_isbn_fav1 IN NUMBER,
    p_isbn_fav2 IN NUMBER,
    p_isbn_fav3 IN NUMBER
) IS
BEGIN
    DELETE FROM MEA_FAVORITOS WHERE id_lector = p_id_lector;
    
    IF p_isbn_fav1 IS NOT NULL THEN
        INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (p_id_lector, p_isbn_fav1, 1);
    END IF;
    IF p_isbn_fav2 IS NOT NULL THEN
        INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (p_id_lector, p_isbn_fav2, 2);
    END IF;
    IF p_isbn_fav3 IS NOT NULL THEN
        INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (p_id_lector, p_isbn_fav3, 3);
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Libros favoritos actualizados correctamente.');
END;
/



-- PROCEDURE: CREAR CLUB
-- Propósito: Crea un nuevo club validando las reglas de institución y cuotas.
CREATE OR REPLACE PROCEDURE MEA_crear_club(
    p_nombre IN VARCHAR2,
    p_direccion IN VARCHAR2,
    p_codigo_postal IN VARCHAR2,
    p_id_pais IN NUMBER,
    p_id_ciudad IN NUMBER,
    p_id_inst IN NUMBER,
    p_cuota IN NUMBER
) IS
    v_id_club NUMBER;
BEGIN
    -- Validacion de regla de negocio: Si depende de institucion, no puede tener cuota
    IF p_id_inst IS NOT NULL AND p_cuota IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20080, 'ERROR: Los clubes que dependen de una institución no pueden tener cuota de membresía.');
    END IF;

    -- Obtener el siguiente ID para el club
    v_id_club := MEA_seq_clubes.NEXTVAL;

    INSERT INTO MEA_CLUBES (
        id_club, nombre_club, fech_creacion, direccion, codigo_postal, 
        id_pais, id_ciudad, cuota_membresia, id_inst
    ) VALUES (
        v_id_club, p_nombre, SYSDATE, p_direccion, p_codigo_postal, 
        p_id_pais, p_id_ciudad, p_cuota, p_id_inst
    );

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Club "' || p_nombre || '" creado exitosamente con ID: ' || v_id_club);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    COMMIT;
END;
/

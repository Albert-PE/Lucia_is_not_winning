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
BEGIN
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

CREATE OR REPLACE PROCEDURE MEA_inscribir_miembro(
    p_doc_identidad IN NUMBER,
    p_p_nombre IN VARCHAR2,
    p_s_nombre IN VARCHAR2,
    p_p_apellido IN VARCHAR2,
    p_s_apellido IN VARCHAR2,
    p_f_nacimiento IN DATE,
    p_email IN VARCHAR2,
    p_id_club IN NUMBER
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
    -- 1. Insertamos el lector
    v_id_lector := MEA_seq_lectores.NEXTVAL;

    INSERT INTO MEA_LECTORES (
        id_lector, doc_identidad, p_nombre, s_nombre, 
        p_apellido, s_apellido, f_nacimiento, email
    ) 
    VALUES (
        v_id_lector, p_doc_identidad, p_p_nombre, p_s_nombre, 
        p_p_apellido, p_s_apellido, p_f_nacimiento, p_email
    );

    -- 2. Clasificamos por edad
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

    -- 3. Inscribimos al lector como socio
    INSERT INTO MEA_SOCIOS (
        id_club, id_lector, fech_i_socio, status_socio
    ) VALUES (
        p_id_club, v_id_lector, v_fecha_actual, 'activo'
    );

    -- 4. Buscamos el ID de un grupo de ese tipo que pertenezca al club
    BEGIN
        SELECT id_grupo INTO v_id_grupo
        FROM MEA_GRUPOS
        WHERE id_club = p_id_club AND tipo = v_tipo_grupo AND ROWNUM = 1;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            raise_application_error(-20002, 'No se encontro un grupo de tipo ' || v_tipo_grupo || ' en el club.');
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

-- =============================================================================
-- FASE 2: PROCEDIMIENTOS DE GESTIÓN DE REUNIONES - PROYECTO MEA
-- =============================================================================

-- 1. PROCEDURE: GENERAR CALENDARIO AUTOMÁTICO
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
BEGIN
    -- 1. Obtener datos del historial del moderador para la FK
    BEGIN
        SELECT id_club_soc, fech_i_socio, fech_i_hist_grupo
        INTO v_id_club_soc, v_fech_i_socio, v_fech_i_hist
        FROM MEA_HISTORICO_GRUPOS
        WHERE id_lector = p_id_lector 
          AND fech_f_hist_grupo IS NULL; -- Moderador activo
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            raise_application_error(-20040, 'El moderador seleccionado no tiene un historial activo.');
    END;

    -- 2. Bucle para insertar reuniones
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

    DBMS_OUTPUT.PUT_LINE('Se generaron ' || p_cant_reun || ' reuniones exitosamente.');
    COMMIT;
END;
/

-- 2. PROCEDURE: REALIZAR REUNIÓN
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
        raise_application_error(-20041, 'No se encontró la reunión especificada.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Reunión marcada como REALIZADA.');
    COMMIT;
END;
/

-- 3. PROCEDURE: CIERRE DE DISCUSIÓN Y LIMPIEZA
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
        raise_application_error(-20042, 'No se encontró la reunión para realizar el cierre.');
    END IF;

    -- 2. Limpieza: Borrar reuniones futuras que quedaron "en el aire"
    DELETE FROM MEA_REUNIONES_CALENDARIO
    WHERE id_club = p_id_club AND id_grupo = p_id_grupo 
      AND isbn = p_isbn AND fech_reunion > p_fecha_cierre;

    DBMS_OUTPUT.PUT_LINE('Calendario cerrado exitosamente. Se eliminaron las reuniones futuras sobrantes.');
    COMMIT;
END;
/

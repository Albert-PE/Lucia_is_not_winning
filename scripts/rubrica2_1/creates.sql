--=====================================================================
--                            SECUENCIAS
--=====================================================================

CREATE SEQUENCE MEA_seq_instituciones START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE MEA_seq_idiomas START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE MEA_seq_paises START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE MEA_seq_autores START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE MEA_seq_ciudades START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE MEA_seq_clubes START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE MEA_seq_lectores START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE MEA_seq_representantes START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE MEA_seq_hablan START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE MEA_seq_obras START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE MEA_seq_pagos_membresias START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE MEA_seq_grupos START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE MEA_seq_id_orden START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE MEA_seq_favoritos START WITH 1 INCREMENT BY 1;


--=====================================================================
--                      TABLAS INDEPENDIENTES
--=====================================================================

-- ENTRADA
CREATE TABLE MEA_INSTITUCIONES (
    id_inst number(3,0) PRIMARY KEY,
    nom_inst varchar2(35) NOT NULL,
    tipo_inst varchar2(20) NOT NULL,
    CONSTRAINT MEA_chk_tipo_inst CHECK (tipo_inst IN ('colegio', 'biblioteca', 'universidad'))
);

-- ENTRADA
CREATE TABLE MEA_IDIOMAS (
    id_idioma number(3,0) PRIMARY KEY,
    nom_idioma varchar2(20) NOT NULL
);

-- ENTRADA
CREATE TABLE MEA_PAISES (
    id_pais number(3,0) PRIMARY KEY,
    nom_pais varchar2(20) NOT NULL,
    moneda varchar2(3) NOT NULL,
    nacionalidad varchar2(20) NOT NULL
);

-- ENTRADA
CREATE TABLE MEA_AUTORES (
    id_autor number(3,0) PRIMARY KEY,
    p_nombre  varchar2(15) DEFAULT 'DESCONOCIDO' NOT NULL,
    s_nombre  varchar2(15),
    p_apellido varchar2(15),
    s_apellido varchar2(15)
);


--=====================================================================
--                      TABLAS DEPENDIENTES
--=====================================================================

-- ENTRADA
CREATE TABLE MEA_CIUDADES (
    id_pais number(3,0) NOT NULL,
    id_ciudad number(3,0) NOT NULL,
    nom_ciudad varchar2(20) NOT NULL,
    CONSTRAINT MEA_fk_ciud_pais FOREIGN KEY (id_pais) REFERENCES MEA_PAISES(id_pais),
    CONSTRAINT MEA_pk_ciudades PRIMARY KEY (id_pais, id_ciudad)
);

-- ENTRADA
CREATE TABLE MEA_CLUBES (
    id_club number (3,0) PRIMARY KEY,
    nombre_club varchar2(40) NOT NULL,
    fech_creacion date NOT NULL,
    direccion varchar2(30) NOT NULL,
    codigo_postal varchar2(5) NOT NULL,
    id_pais number(3,0) NOT NULL,
    id_ciudad number(3,0) NOT NULL,
    cuota_membresia number (5,0),
    id_inst number(3,0),
    CONSTRAINT MEA_fk_club_ciudad FOREIGN KEY (id_pais, id_ciudad) REFERENCES MEA_CIUDADES(id_pais, id_ciudad),
    CONSTRAINT MEA_fk_club_institucion FOREIGN KEY (id_inst) REFERENCES MEA_INSTITUCIONES(id_inst)
);

-- ENTRADA
CREATE TABLE MEA_LECTORES (
    id_lector number(5,0) PRIMARY KEY,
    doc_identidad number(9,0) NOT NULL UNIQUE,
    p_nombre varchar2(15) NOT NULL,
    s_nombre varchar2(15) NOT NULL,
    p_apellido varchar2(15) NOT NULL,
    s_apellido varchar2(15) NOT NULL,
    f_nacimiento date NOT NULL,
    email varchar2(30) NOT NULL,
    id_lector_repre number(5,0), -- Corregido: match con id_lector
    CONSTRAINT MEA_fk_lect_repre FOREIGN KEY (id_lector_repre) REFERENCES MEA_LECTORES(id_lector)
);

-- ENTRADA
CREATE TABLE MEA_REPRESENTANTES (
    id_lector number(5,0),
    id_representante number(3,0),
    doc_identidad number(9,0) NOT NULL,
    p_nombre varchar2(15) NOT NULL,
    p_apellido varchar2(15) NOT NULL,
    s_apellido varchar2(15) NOT NULL,
    CONSTRAINT MEA_fk_repr_lector FOREIGN KEY (id_lector) REFERENCES MEA_LECTORES(id_lector),
    CONSTRAINT MEA_pk_representantes PRIMARY KEY (id_lector, id_representante)
);

-- ENTRADA
CREATE TABLE MEA_HABLAN (
    id_idioma number(3,0) NOT NULL,
    id_habla number(3,0) NOT NULL,
    id_club number(3,0),
    id_lector number(5,0), -- Corregido: match con id_lector
    CONSTRAINT MEA_fk_habl_idioma FOREIGN KEY (id_idioma) REFERENCES MEA_IDIOMAS(id_idioma),
    CONSTRAINT MEA_fk_habl_lector FOREIGN KEY (id_lector) REFERENCES MEA_LECTORES(id_lector),
    CONSTRAINT MEA_fk_habl_club FOREIGN KEY (id_club) REFERENCES MEA_CLUBES(id_club),
    CONSTRAINT MEA_pk_hablan PRIMARY KEY (id_idioma, id_habla),
    CONSTRAINT MEA_chk_club_lector CHECK ((id_club IS NOT NULL AND id_lector IS NULL) OR (id_lector IS NOT NULL AND id_club IS NULL))
);

-- ENTRADA
CREATE TABLE MEA_TELEFONOS (
    cod_local number(3,0) NOT NULL,
    cod_area number(3,0) NOT NULL,
    num_tlf number(7,0) NOT NULL,
    id_club number(3,0),
    id_lector number(5,0),
    CONSTRAINT MEA_fk_tele_club FOREIGN KEY (id_club) REFERENCES MEA_CLUBES(id_club),
    CONSTRAINT MEA_fk_tele_lector FOREIGN KEY (id_lector) REFERENCES MEA_LECTORES(id_lector),
    CONSTRAINT MEA_pk_telefonos PRIMARY KEY (cod_local, cod_area, num_tlf),
    CONSTRAINT MEA_chk_club_tele_lector CHECK ((id_club IS NOT NULL AND id_lector IS NULL) OR (id_lector IS NOT NULL AND id_club IS NULL))
);

-- ENTRADA
CREATE TABLE MEA_OBRAS (
    id_obra number(4,0) PRIMARY KEY,
    nombre_obra varchar2(50) NOT NULL,
    status_obra varchar2(10) NOT NULL,
    id_club number(3,0) NOT NULL,
    precio number(10,2),
    CONSTRAINT MEA_fk_obra_club FOREIGN KEY (id_club) REFERENCES MEA_CLUBES(id_club),
    CONSTRAINT MEA_chk_status_obra CHECK (status_obra IN ('activa', 'inactiva'))
);

-- ENTRADA / SALIDA
CREATE TABLE MEA_SOCIOS (
    id_club number(3,0) NOT NULL,
    id_lector number(5,0) NOT NULL,
    fech_i_socio date NOT NULL,
    status_socio varchar2(8) NOT NULL,
    fech_f_socio date,
    motivo_retiro varchar2(15),
    CONSTRAINT MEA_fk_soci_club FOREIGN KEY (id_club) REFERENCES MEA_CLUBES(id_club),
    CONSTRAINT MEA_fk_soci_lector FOREIGN KEY (id_lector) REFERENCES MEA_LECTORES(id_lector),
    CONSTRAINT MEA_pk_socios PRIMARY KEY (id_club, id_lector, fech_i_socio),
    CONSTRAINT MEA_chk_status_socio CHECK (status_socio IN ('activo', 'inactivo')),
    CONSTRAINT MEA_chk_motivo CHECK (motivo_retiro IN ('deuda', 'inasistencia', 'otro') OR motivo_retiro IS NULL)
);

-- SALIDA
CREATE TABLE MEA_PAGOS_MEMBRESIAS (
    id_club number(3,0) NOT NULL,
    id_lector number(5,0) NOT NULL,
    fech_i_socio date NOT NULL,
    id_pago_membresia number(3,0) NOT NULL,
    fech_emision date NOT NULL,
    CONSTRAINT MEA_fk_pago_memb_socios FOREIGN KEY (id_club, id_lector, fech_i_socio) REFERENCES MEA_SOCIOS (id_club, id_lector, fech_i_socio), 
    CONSTRAINT MEA_pk_pagos_memb PRIMARY KEY (id_club, id_lector, fech_i_socio, id_pago_membresia)
);

-- SALIDA
CREATE TABLE MEA_PRESENTACIONES(
    id_obra number(3,0) NOT NULL,
    fech_presentacion date NOT NULL,
    valoracion number(2,1) NOT NULL,
    cantidad_asistentes number(5,0) NOT NULL,
    CONSTRAINT MEA_fk_pres_obra FOREIGN KEY (id_obra) REFERENCES MEA_OBRAS(id_obra),
    CONSTRAINT MEA_pk_presentaciones PRIMARY KEY (id_obra, fech_presentacion)
);

-- ENTRADA / SALIDA
CREATE TABLE MEA_GRUPOS (
    id_club number(3,0) NOT NULL,
    id_grupo number(3,0) NOT NULL,
    fech_creacion date NOT NULL,
    tipo varchar2(10) NOT NULL,
    dia_reunion number(1,0) NOT NULL,
    hora_i_reunion number(2,0) NOT NULL,
    CONSTRAINT MEA_fk_club FOREIGN KEY (id_club) REFERENCES MEA_CLUBES(id_club),
    Constraint MEA_pk_grupos PRIMARY KEY (id_club, id_grupo),
    CONSTRAINT MEA_chk_tipo CHECK (tipo IN ('joven', 'adulto', 'infantil')),
    CONSTRAINT MEA_chk_dia_reunion CHECK (dia_reunion IN (2,3,4,5,6)),
    CONSTRAINT MEA_chk_hora_i_reunion CHECK (hora_i_reunion >= 17.00 and hora_i_reunion <= 19.00)
);

-- ENTRADA
CREATE TABLE MEA_ELENCOS (
    id_obra number(3,0) NOT NULL,
    id_lector number(5,0) NOT NULL,
    CONSTRAINT MEA_fk_elen_obra FOREIGN KEY (id_obra) REFERENCES MEA_OBRAS(id_obra),
    CONSTRAINT MEA_fk_elen_lector FOREIGN KEY (id_lector) REFERENCES MEA_LECTORES(id_lector),
    CONSTRAINT MEA_pk_elencos PRIMARY KEY (id_obra, id_lector)
);

-- ENTRADA
CREATE TABLE MEA_MEJORES_ACTORES (
    id_obra_presentacion number(3,0) NOT NULL,
    id_fech_presentacion date NOT NULL,
    id_obra_elenco number(3,0) NOT NULL,
    id_lector number(5,0) NOT NULL,
    CONSTRAINT MEA_fk_mej_act_presentacion FOREIGN KEY (id_obra_presentacion, id_fech_presentacion) REFERENCES MEA_PRESENTACIONES(id_obra, fech_presentacion),
    CONSTRAINT MEA_fk_mej_act_elenco FOREIGN KEY (id_obra_elenco, id_lector) REFERENCES MEA_ELENCOS(id_obra, id_lector),
    CONSTRAINT MEA_pk_mejor_actores PRIMARY KEY (id_obra_presentacion, id_fech_presentacion, id_obra_elenco, id_lector)
);

-- ENTRADA / SALIDA
CREATE TABLE MEA_HISTORICO_GRUPOS (
    id_club_grupo number(3,0) NOT NULL,
    id_grupo number(3,0) NOT NULL,
    id_club_soc number(3,0) NOT NULL,
    id_lector number(5,0) NOT NULL,
    fech_i_socio date NOT NULL,
    fech_i_hist_grupo date NOT NULL, 
    fech_f_hist_grupo date,
    CONSTRAINT MEA_fk_hist_grup_grupo FOREIGN KEY (id_club_grupo, id_grupo) REFERENCES MEA_GRUPOS(id_club, id_grupo),
    CONSTRAINT MEA_fk_hist_grup_socio FOREIGN KEY (id_club_soc, id_lector, fech_i_socio) REFERENCES MEA_SOCIOS (id_club, id_lector, fech_i_socio),
    CONSTRAINT MEA_pk_historico_grupos PRIMARY KEY (id_club_grupo, id_grupo, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo)
);

-- ENTRADA
CREATE TABLE MEA_ASOCIACIONES (
    id_club1 number(3,0) NOT NULL,
    id_club2 number (3,0) NOT NULL,
    CONSTRAINT MEA_fk_asoc_club1 FOREIGN KEY (id_club1) REFERENCES MEA_CLUBES(id_club),
    CONSTRAINT MEA_fk_asoc_club2 FOREIGN KEY (id_club2) REFERENCES MEA_CLUBES(id_club),
    CONSTRAINT MEA_pk_asociaciones PRIMARY KEY (id_club1, id_club2)
);

-- ENTRADA
CREATE TABLE MEA_LIBROS (
    isbn number(13,0) PRIMARY KEY,
    titulo_libro varchar2(35) NOT NULL,
    año_publicacion number(4,0) NOT NULL,
    cant_paginas number(4,0) NOT NULL,
    resumen varchar2(500) NOT NULL,
    sinopsis varchar2(500) NOT NULL,
    tema varchar2(20) NOT NULL,
    tipo_narrativa varchar2(7) NOT NULL,
    id_pais number(3,0) NOT NULL,
    isbn_lib_anterior number(13,0),
    CONSTRAINT MEA_fk_libr_pais FOREIGN KEY (id_pais) REFERENCES MEA_PAISES(id_pais),
    CONSTRAINT MEA_fk_libr_anterior FOREIGN KEY (isbn_lib_anterior) REFERENCES MEA_LIBROS(isbn)
);

-- ENTRADA / SALIDA
CREATE TABLE MEA_REUNIONES_CALENDARIO (
    id_club number(3,0) NOT NULL,
    id_grupo number(3,0) NOT NULL,
    isbn number(13,0) NOT NULL,
    fech_reunion date NOT NULL,
    realizada varchar2(2) NOT NULL, -- 'SI' o 'NO'
    id_club_hist number(3,0) NOT NULL,
    id_grupo_hist number(3,0) NOT NULL,
    id_club_soc number(3,0) NOT NULL,
    id_lector number(5,0) NOT NULL,
    fech_i_socio date NOT NULL,
    fech_i_hist_grupo date NOT NULL,
    conclusion varchar2(500),
    valoracion number(2,1), -- Valoración de 0.0 a 5.0
    ult_discusion varchar2(2), -- 'SI' o 'NO'
    CONSTRAINT MEA_fk_reun_grupo FOREIGN KEY (id_club, id_grupo) REFERENCES MEA_GRUPOS(id_club, id_grupo), -- Corregido orden
    CONSTRAINT MEA_fk_reun_libro FOREIGN KEY (isbn) REFERENCES MEA_LIBROS(isbn),
    CONSTRAINT MEA_fk_reun_historico_grupo FOREIGN KEY (id_club_hist, id_grupo_hist, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo) REFERENCES MEA_HISTORICO_GRUPOS(id_club_grupo, id_grupo, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo),
    CONSTRAINT MEA_pk_reuniones_calendario PRIMARY KEY (id_club, id_grupo, isbn, fech_reunion),
    CONSTRAINT MEA_chk_realizada CHECK (realizada IN ('SI', 'NO')),
    CONSTRAINT MEA_chk_ult_discusion CHECK (ult_discusion IN ('SI', 'NO') OR ult_discusion IS NULL),
    CONSTRAINT MEA_chk_valoracion CHECK (valoracion >= 0.0 AND valoracion <= 5.0)   
);

-- ENTRADA
CREATE TABLE MEA_A_L (
    id_autor number(3,0) NOT NULL,
    isbn number(13,0) NOT NULL,
    CONSTRAINT MEA_fk_a_l_autor FOREIGN KEY (id_autor) REFERENCES MEA_AUTORES(id_autor),
    CONSTRAINT MEA_fk_a_l_libro FOREIGN KEY (isbn) REFERENCES MEA_LIBROS(isbn),
    CONSTRAINT MEA_pk_a_l PRIMARY KEY (id_autor, isbn)
);

-- ENTRADA
CREATE TABLE MEA_REFERENCIAS(
    id_obra number(3,0) NOT NULL,
    isbn number(13,0) NOT NULL,
    CONSTRAINT MEA_fk_refe_obra FOREIGN KEY (id_obra) REFERENCES MEA_OBRAS(id_obra),
    CONSTRAINT MEA_fk_refe_libro FOREIGN KEY (isbn) REFERENCES MEA_LIBROS(isbn),
    CONSTRAINT MEA_pk_referencias PRIMARY KEY (id_obra, isbn)
);

-- SALIDA
CREATE TABLE MEA_INASISTENTES(
    id_club_reu number(3,0) NOT NULL,
    id_grupo_reu number(3,0) NOT NULL,
    isbn number(13,0) NOT NULL,
    fech_reunion date NOT NULL, 
    id_club_hist number(3,0) NOT NULL,
    id_grupo_hist number(3,0) NOT NULL,
    id_club_soc number(3,0) NOT NULL,
    id_lector number(5,0) NOT NULL,
    fech_i_socio date NOT NULL, 
    fech_i_hist_grupo date NOT NULL, 
    CONSTRAINT MEA_fk_inas_reunion FOREIGN KEY (id_club_reu, id_grupo_reu, isbn, fech_reunion) REFERENCES MEA_REUNIONES_CALENDARIO(id_club, id_grupo, isbn, fech_reunion),
    CONSTRAINT MEA_fk_inas_historico FOREIGN KEY (id_club_hist, id_grupo_hist, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo) REFERENCES MEA_HISTORICO_GRUPOS(id_club_grupo, id_grupo, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo),
    CONSTRAINT MEA_pk_inasistentes PRIMARY KEY (id_club_reu, id_grupo_reu, isbn, fech_reunion, id_club_hist, id_grupo_hist, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo)
);

-- SALIDA
CREATE TABLE MEA_FAVORITOS (
    id_lector number(5,0) NOT NULL,
    isbn number(13,0) NOT NULL,
    orden number(5,0) NOT NULL,
    CONSTRAINT MEA_fk_favo_lector FOREIGN KEY (id_lector) REFERENCES MEA_LECTORES(id_lector),
    CONSTRAINT MEA_fk_favo_libro FOREIGN KEY (isbn) REFERENCES MEA_LIBROS(isbn),
    CONSTRAINT MEA_pk_favoritos PRIMARY KEY (id_lector, isbn, orden)
);


--=====================================================================
--                            ÍNDICES
--=====================================================================

CREATE INDEX MEA_idx_paises_nom ON MEA_PAISES(nom_pais);

CREATE INDEX MEA_idx_autores_apellido ON MEA_AUTORES(p_apellido);

CREATE INDEX MEA_idx_inst_nombre ON MEA_INSTITUCIONES(nom_inst);

CREATE INDEX MEA_idx_libros_titulo ON MEA_LIBROS(titulo_libro);

CREATE INDEX MEA_idx_fk_club_ciudades ON MEA_CIUDADES(id_pais);

CREATE INDEX MEA_idx_fk_clubes_inst ON MEA_CLUBES(id_inst);

CREATE INDEX MEA_idx_fk_lectores_repr ON MEA_LECTORES(id_lector_repre);

CREATE INDEX MEA_idx_fk_obras_club ON MEA_OBRAS(id_club);

CREATE INDEX MEA_idx_fk_libros_pais ON MEA_LIBROS(id_pais);

CREATE INDEX MEA_idx_fk_libros_anterior ON MEA_LIBROS(isbn_lib_anterior);


--=====================================================================
--                            FUNCIONES
--=====================================================================

CREATE OR REPLACE FUNCTION MEA_conversion_monetaria(
    p_id_pais IN MEA_PAISES.id_pais%TYPE,
    p_monto IN NUMBER,
    p_tasa_cambio IN NUMBER
) RETURN NUMBER IS
    v_monto_usd NUMBER;
    v_nom_moneda MEA_PAISES.moneda%TYPE;
BEGIN
    -- Buscamos el nombre de la moneda basado en el ID del país
    SELECT moneda 
    INTO v_nom_moneda
    FROM MEA_PAISES
    WHERE id_pais = p_id_pais;

    -- Realizamos la conversión
    v_monto_usd := p_monto / p_tasa_cambio;
    
    -- Feedback para el usuario con la moneda recuperada de la tabla
    DBMS_OUTPUT.PUT_LINE(p_monto || ' ' || v_nom_moneda || ' cambiados a ' || v_monto_usd || ' dolares');

    RETURN (v_monto_usd);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        raise_application_error(-20007, 'El ID de país proporcionado no existe.');
        RETURN NULL;
    WHEN ZERO_DIVIDE THEN
        raise_application_error(-20005, 'La tasa de cambio no puede ser cero.');
        RETURN NULL;
    WHEN OTHERS THEN
        raise_application_error(-20006, 'Error en la conversión monetaria: ' || SQLERRM);
        RETURN NULL;
END;
/

--========================================================================

CREATE OR REPLACE FUNCTION MEA_antiguedad_en_club_miembro (v_fecha DATE) 
RETURN NUMBER IS 
BEGIN 
    RETURN (ROUND(((SYSDATE - v_fecha) / 365), 0)); 
END;
/

--========================================================================

CREATE OR REPLACE FUNCTION MEA_promedio_part_mensual_tipo(
    p_id_club IN NUMBER,
    p_tipo_grupo IN VARCHAR2, -- 'joven', 'adulto', 'infantil'
    p_mes IN NUMBER,
    p_anio IN NUMBER
) RETURN NUMBER IS
    v_total_esperado NUMBER := 0;
    v_total_inasistencias NUMBER := 0;
    v_promedio NUMBER := 0;
    v_tipo_normalizado VARCHAR2(20);
    v_nom_club MEA_CLUBES.nombre_club%TYPE;
    v_fecha_consulta DATE;
BEGIN
    v_tipo_normalizado := LOWER(p_tipo_grupo);

    -----VALIDACIONES-----
    BEGIN
        SELECT nombre_club INTO v_nom_club
        FROM MEA_CLUBES
        WHERE id_club = p_id_club;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            raise_application_error(-20010, 'Error: El club con ID ' || p_id_club || ' no existe.');
    END;

    IF p_mes < 1 OR p_mes > 12 THEN
        raise_application_error(-20011, 'Error: El mes debe estar entre 1 y 12.');
    END IF;

    v_fecha_consulta := TO_DATE('01/' || p_mes || '/' || p_anio, 'DD/MM/YYYY');
    IF v_fecha_consulta > SYSDATE THEN
        raise_application_error(-20012, 'Error: No se pueden analizar promedios de fechas futuras.');
    END IF;
    -----------------------

    -- Calculo asistencias esperadas
    SELECT COUNT(*)
    INTO v_total_esperado
    FROM MEA_REUNIONES_CALENDARIO r, MEA_GRUPOS g, MEA_HISTORICO_GRUPOS h
    WHERE r.id_club = g.id_club 
      AND r.id_grupo = g.id_grupo
      AND h.id_club_grupo = g.id_club 
      AND h.id_grupo = g.id_grupo
      AND r.fech_reunion >= h.fech_i_hist_grupo 
      AND (h.fech_f_hist_grupo IS NULL OR r.fech_reunion <= h.fech_f_hist_grupo)
      AND g.id_club = p_id_club
      AND g.tipo = v_tipo_normalizado
      AND EXTRACT(MONTH FROM r.fech_reunion) = p_mes
      AND EXTRACT(YEAR FROM r.fech_reunion) = p_anio
      AND r.realizada = 'SI';

    -- Calculo Total de inasistencias reales
    SELECT COUNT(*)
    INTO v_total_inasistencias
    FROM MEA_INASISTENTES i, MEA_GRUPOS g
    WHERE i.id_club_reu = g.id_club 
      AND i.id_grupo_reu = g.id_grupo
      AND g.id_club = p_id_club
      AND g.tipo = v_tipo_normalizado
      AND EXTRACT(MONTH FROM i.fech_reunion) = p_mes
      AND EXTRACT(YEAR FROM i.fech_reunion) = p_anio;

    -- Cálculo final
    IF v_total_esperado > 0 THEN
        v_promedio := ((v_total_esperado - v_total_inasistencias) / v_total_esperado) * 100;
    ELSE
        v_promedio := 0;
    END IF;

    v_promedio := ROUND(v_promedio, 2);

    -- IMPRESIÓN EN CONSOLA
    DBMS_OUTPUT.PUT_LINE('--- RESULTADO DEL ANÁLISIS ---');
    DBMS_OUTPUT.PUT_LINE('Club: ' || v_nom_club);
    DBMS_OUTPUT.PUT_LINE('Periodo: ' || p_mes || '/' || p_anio);
    DBMS_OUTPUT.PUT_LINE('Tipo de Grupo: ' || v_tipo_normalizado);
    DBMS_OUTPUT.PUT_LINE('Promedio de Asistencia: ' || v_promedio || '%');
    DBMS_OUTPUT.PUT_LINE('------------------------------');

    RETURN v_promedio;

    EXCEPTION
    WHEN OTHERS THEN
        -- Si el error no es uno de los definidos arriba, relanzar con mensaje general
        IF SQLCODE NOT BETWEEN -20999 AND -20000 THEN
            raise_application_error(-20013, 'Error inesperado en la función: ' || SQLERRM);
        ELSE
            RAISE;
        END IF;
END;
/

--========================================================================

CREATE OR REPLACE FUNCTION MEA_participacion_bimestre_miembro (id_part_lector number, fecha_inicial date)
RETURN NUMBER IS
    v_inasistencias NUMBER;
    v_total_reuniones NUMBER;
    v_porcentaje NUMBER;
BEGIN

    SELECT count(*) INTO v_inasistencias
        FROM mea_inasistentes
        WHERE id_part_lector = id_lector AND fech_reunion between add_months(fecha_inicial,-2) AND fecha_inicial;

    SELECT count(*) INTO v_total_reuniones    
        FROM mea_historico_grupos h, mea_reuniones_calendario r 
        WHERE 
            id_part_lector = h.id_lector 
            AND h.id_club_grupo = r.id_club 
            AND h.id_grupo = r.id_grupo 
            AND r.fech_reunion >= h.fech_i_hist_grupo 
            AND (h.fech_f_hist_grupo IS NULL OR r.fech_reunion <= h.fech_f_hist_grupo) 
            AND r.fech_reunion between add_months(fecha_inicial,-2) AND fecha_inicial
            AND r.realizada = 'SI';

    IF v_total_reuniones = 0 THEN
        RETURN 0;
    ELSE
        v_porcentaje := ((v_total_reuniones - v_inasistencias) / v_total_reuniones) * 100;
        RETURN v_porcentaje;
    END IF;
END;
/


--=====================================================================
--                             VISTAS
--=====================================================================

-- 1. Vista: V_DETALLE_LECTORES
CREATE OR REPLACE VIEW MEA_v_detalle_lectores AS
SELECT 
    l.id_lector, 
    l.p_nombre || ' ' || l.p_apellido AS nombre_lector, 
    l.email,
    r.p_nombre || ' ' || r.p_apellido AS nombre_representante
FROM MEA_LECTORES l
LEFT JOIN MEA_REPRESENTANTES r ON l.id_lector = r.id_lector;

-- 2. Vista: V_CLUBES_INSTITUCIONES
CREATE OR REPLACE VIEW MEA_v_clubes_instituciones AS
SELECT 
    c.id_club, 
    c.nombre_club, 
    c.cuota_membresia,
    i.nom_inst AS nombre_institucion, 
    i.tipo_inst
FROM MEA_CLUBES c
LEFT JOIN MEA_INSTITUCIONES i ON c.id_inst = i.id_inst;

-- 3. Vista: V_SOCIOS_ACTIVOS
CREATE OR REPLACE VIEW MEA_v_socios_activos AS
SELECT 
    s.id_club, 
    c.nombre_club, 
    l.p_nombre || ' ' || l.p_apellido AS nombre_socio, 
    s.fech_i_socio AS fecha_ingreso
FROM MEA_SOCIOS s
JOIN MEA_CLUBES c ON s.id_club = c.id_club
JOIN MEA_LECTORES l ON s.id_lector = l.id_lector
WHERE s.status_socio = 'activo';

-- 4. Vista: V_CATALOGO_LIBROS
CREATE OR REPLACE VIEW MEA_v_catalogo_libros AS
SELECT 
    b.isbn, 
    b.titulo_libro, 
    a.p_nombre || ' ' || a.p_apellido AS autor,
    p.nom_pais AS pais_origen,
    b.tipo_narrativa
FROM MEA_LIBROS b
JOIN MEA_A_L al ON b.isbn = al.isbn
JOIN MEA_AUTORES a ON al.id_autor = a.id_autor
JOIN MEA_PAISES p ON b.id_pais = p.id_pais;

-- 5. Vista: V_HISTORIAL_PAGOS
CREATE OR REPLACE VIEW MEA_v_historial_pago_socios AS
SELECT 
    l.p_nombre || ' ' || l.p_apellido AS lector,
    c.nombre_club,
    p.id_pago_membresia AS recibo,
    p.fech_emision AS fecha_pago
FROM MEA_PAGOS_MEMBRESIAS p
JOIN MEA_LECTORES l ON p.id_lector = l.id_lector
JOIN MEA_CLUBES c ON p.id_club = c.id_club;

-- 6. Vista: V_AGENDA_REUNIONES
CREATE OR REPLACE VIEW MEA_v_agenda_reuniones AS
SELECT 
    r.fech_reunion, 
    c.nombre_club, 
    g.tipo AS tipo_grupo, 
    b.titulo_libro,
    r.realizada
FROM MEA_REUNIONES_CALENDARIO r
JOIN MEA_CLUBES c ON r.id_club = c.id_club
JOIN MEA_GRUPOS g ON r.id_club = g.id_club AND r.id_grupo = g.id_grupo
JOIN MEA_LIBROS b ON r.isbn = b.isbn;

-- 7. Vista: V_CONTACTOS_SISTEMA
CREATE OR REPLACE VIEW MEA_v_contactos_sistema AS
SELECT 
    'CLUB' AS origen,
    c.nombre_club AS entidad,
    '(' || t.cod_local || ') ' || t.cod_area || '-' || t.num_tlf AS numero_completo
FROM MEA_TELEFONOS t
JOIN MEA_CLUBES c ON t.id_club = c.id_club
UNION
SELECT 
    'LECTOR' AS origen,
    l.p_nombre || ' ' || l.p_apellido AS entidad,
    '(' || t.cod_local || ') ' || t.cod_area || '-' || t.num_tlf AS numero_completo
FROM MEA_TELEFONOS t
JOIN MEA_LECTORES l ON t.id_lector = l.id_lector;

-- 8. Vista: V_IDIOMAS_HABLADOS
CREATE OR REPLACE VIEW MEA_v_idiomas_hablados AS
SELECT 
    i.nom_idioma,
    'CLUB' AS tipo_entidad,
    c.nombre_club AS nombre_entidad
FROM MEA_HABLAN h
JOIN MEA_IDIOMAS i ON h.id_idioma = i.id_idioma
JOIN MEA_CLUBES c ON h.id_club = c.id_club
UNION
SELECT 
    i.nom_idioma,
    'LECTOR' AS tipo_entidad,
    l.p_nombre || ' ' || l.p_apellido AS nombre_entidad
FROM MEA_HABLAN h
JOIN MEA_IDIOMAS i ON h.id_idioma = i.id_idioma
JOIN MEA_LECTORES l ON h.id_lector = l.id_lector;

-- 9. Vista: V_LIBROS_FAVORITOS
CREATE OR REPLACE VIEW MEA_v_libros_favoritos AS
SELECT 
    l.p_nombre || ' ' || l.p_apellido AS lector,
    b.titulo_libro,
    f.orden AS rango_preferencia
FROM MEA_FAVORITOS f
JOIN MEA_LECTORES l ON f.id_lector = l.id_lector
JOIN MEA_LIBROS b ON f.isbn = b.isbn;

-- 10. Vista: V_REPORTE_INASISTENCIAS
CREATE OR REPLACE VIEW MEA_v_reporte_inasistencias AS
SELECT 
    i.fech_reunion AS fecha_reunion,
    l.p_nombre || ' ' || l.p_apellido AS socio_ausente,
    c.nombre_club,
    b.titulo_libro
FROM MEA_INASISTENTES i
JOIN MEA_LECTORES l ON i.id_lector = l.id_lector
JOIN MEA_CLUBES c ON i.id_club_soc = c.id_club
JOIN MEA_LIBROS b ON i.isbn = b.isbn;

-- 11. Vista: V_PRODUCCION_OBRAS
CREATE OR REPLACE VIEW MEA_v_produccion_obras AS
SELECT 
    o.nombre_obra,
    p.fech_presentacion,
    p.cantidad_asistentes,
    p.valoracion,
    o.precio AS costo_entrada
FROM MEA_OBRAS o
JOIN MEA_PRESENTACIONES p ON o.id_obra = p.id_obra;

-- 12. Vista: V_ELENCOS_Y_PREMIADOS
CREATE OR REPLACE VIEW MEA_v_elencos_y_premiados AS
SELECT 
    o.nombre_obra,
    l.p_nombre || ' ' || l.p_apellido AS actor,
    CASE WHEN m.id_lector IS NULL THEN 'No' ELSE 'SÍ' END AS fue_premiado,
    m.id_fech_presentacion AS fecha_premio
FROM MEA_ELENCOS e
JOIN MEA_OBRAS o ON e.id_obra = o.id_obra
JOIN MEA_LECTORES l ON e.id_lector = l.id_lector
LEFT JOIN MEA_MEJORES_ACTORES m ON e.id_lector = m.id_lector AND e.id_obra = m.id_obra_elenco;

-- 13. Vista: V_TRAYECTORIA_GRUPOS
CREATE OR REPLACE VIEW MEA_v_trayectoria_grupos AS
SELECT 
    l.p_nombre || ' ' || l.p_apellido AS socio,
    c.nombre_club,
    g.tipo AS tipo_grupo,
    hg.fech_i_hist_grupo AS fecha_inicio,
    hg.fech_f_hist_grupo AS fecha_fin
FROM MEA_HISTORICO_GRUPOS hg
JOIN MEA_LECTORES l ON hg.id_lector = l.id_lector
JOIN MEA_CLUBES c ON hg.id_club_soc = c.id_club
JOIN MEA_GRUPOS g ON hg.id_club_grupo = g.id_club AND hg.id_grupo = g.id_grupo;

-- 14. Vista: V_CLUBES_ASOCIADOS
CREATE OR REPLACE VIEW MEA_v_clubes_asociados AS
SELECT 
    c1.nombre_club AS club_principal,
    c2.nombre_club AS club_asociado
FROM MEA_ASOCIACIONES a
JOIN MEA_CLUBES c1 ON a.id_club1 = c1.id_club
JOIN MEA_CLUBES c2 ON a.id_club2 = c2.id_club;

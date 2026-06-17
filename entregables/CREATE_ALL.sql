-- =============================================================================
-- TIPOS DE DATOS PERSONALIZADOS (UDTs) - DEBEN IR AL PRINCIPIO
-- =============================================================================

CREATE OR REPLACE TYPE MEA_conversion_row AS OBJECT (
    id_pais       NUMBER,
    nom_pais      VARCHAR2(20),
    moneda        VARCHAR2(3),
    monto_origen  NUMBER,
    tasa_cambio   VARCHAR2(50),
    monto_usd     VARCHAR2(30)
);
/

CREATE OR REPLACE TYPE MEA_conversion_table AS TABLE OF MEA_conversion_row;
/

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

CREATE TABLE MEA_INSTITUCIONES (
    id_inst number(3,0) PRIMARY KEY,
    nom_inst varchar2(35) NOT NULL,
    tipo_inst varchar2(20) NOT NULL,
    CONSTRAINT MEA_chk_tipo_inst CHECK (tipo_inst IN ('colegio', 'biblioteca', 'universidad'))
);

CREATE TABLE MEA_IDIOMAS (
    id_idioma number(3,0) PRIMARY KEY,
    nom_idioma varchar2(20) NOT NULL
);

CREATE TABLE MEA_PAISES (
    id_pais number(3,0) PRIMARY KEY,
    nom_pais varchar2(20) NOT NULL,
    moneda varchar2(3) NOT NULL,
    nacionalidad varchar2(20) NOT NULL
);

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

CREATE TABLE MEA_CIUDADES (
    id_pais number(3,0) NOT NULL,
    id_ciudad number(3,0) NOT NULL,
    nom_ciudad varchar2(20) NOT NULL,
    CONSTRAINT MEA_fk_ciud_pais FOREIGN KEY (id_pais) REFERENCES MEA_PAISES(id_pais),
    CONSTRAINT MEA_pk_ciudades PRIMARY KEY (id_pais, id_ciudad)
);

CREATE TABLE MEA_CLUBES (
    id_club number (3,0) PRIMARY KEY,
    nombre_club varchar2(40) NOT NULL,
    fech_creacion date NOT NULL,
    direccion varchar2(30) NOT NULL,
    codigo_postal varchar2(5) NOT NULL,
    id_pais number(3,0) NOT NULL,
    id_ciudad number(3,0) NOT NULL,
    cuota_membresia number (10,2),
    id_inst number(3,0),
    CONSTRAINT MEA_fk_club_ciudad FOREIGN KEY (id_pais, id_ciudad) REFERENCES MEA_CIUDADES(id_pais, id_ciudad),
    CONSTRAINT MEA_fk_club_institucion FOREIGN KEY (id_inst) REFERENCES MEA_INSTITUCIONES(id_inst)
);

CREATE TABLE MEA_LECTORES (
    id_lector number(5,0) PRIMARY KEY,
    doc_identidad number(9,0) NOT NULL UNIQUE,
    p_nombre varchar2(15) NOT NULL,
    s_nombre varchar2(15) NOT NULL,
    p_apellido varchar2(15) NOT NULL,
    s_apellido varchar2(15) NOT NULL,
    f_nacimiento date NOT NULL,
    email varchar2(30) NOT NULL,
    id_lector_repre number(5,0),
    CONSTRAINT MEA_fk_lect_repre FOREIGN KEY (id_lector_repre) REFERENCES MEA_LECTORES(id_lector)
);

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

CREATE TABLE MEA_HABLAN (
    id_idioma number(3,0) NOT NULL,
    id_habla number(3,0) NOT NULL,
    id_club number(3,0),
    id_lector number(5,0),
    CONSTRAINT MEA_fk_habl_idioma FOREIGN KEY (id_idioma) REFERENCES MEA_IDIOMAS(id_idioma),
    CONSTRAINT MEA_fk_habl_lector FOREIGN KEY (id_lector) REFERENCES MEA_LECTORES(id_lector),
    CONSTRAINT MEA_fk_habl_club FOREIGN KEY (id_club) REFERENCES MEA_CLUBES(id_club),
    CONSTRAINT MEA_pk_hablan PRIMARY KEY (id_idioma, id_habla),
    CONSTRAINT MEA_chk_club_lector CHECK ((id_club IS NOT NULL AND id_lector IS NULL) OR (id_lector IS NOT NULL AND id_club IS NULL))
);

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

CREATE TABLE MEA_OBRAS (
    id_obra number(4,0) PRIMARY KEY,
    nombre_obra varchar2(50) NOT NULL,
    status_obra varchar2(10) NOT NULL,
    id_club number(3,0) NOT NULL,
    precio number(10,2),
    CONSTRAINT MEA_fk_obra_club FOREIGN KEY (id_club) REFERENCES MEA_CLUBES(id_club),
    CONSTRAINT MEA_chk_status_obra CHECK (status_obra IN ('activa', 'inactiva'))
);

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

CREATE TABLE MEA_PAGOS_MEMBRESIAS (
    id_club number(3,0) NOT NULL,
    id_lector number(5,0) NOT NULL,
    fech_i_socio date NOT NULL,
    id_pago_membresia number(10,0) NOT NULL,
    fech_emision date NOT NULL,
    CONSTRAINT MEA_fk_pago_memb_socios FOREIGN KEY (id_club, id_lector, fech_i_socio) REFERENCES MEA_SOCIOS (id_club, id_lector, fech_i_socio), 
    CONSTRAINT MEA_pk_pagos_memb PRIMARY KEY (id_club, id_lector, fech_i_socio, id_pago_membresia)
);

CREATE TABLE MEA_PRESENTACIONES(
    id_obra number(4,0) NOT NULL,
    fech_presentacion date NOT NULL,
    valoracion number(3,1) NOT NULL,
    cantidad_asistentes number(5,0) NOT NULL,
    CONSTRAINT MEA_fk_pres_obra FOREIGN KEY (id_obra) REFERENCES MEA_OBRAS(id_obra),
    CONSTRAINT MEA_pk_presentaciones PRIMARY KEY (id_obra, fech_presentacion)
);

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
    CONSTRAINT MEA_chk_hora_i_reunion CHECK (hora_i_reunion >= 17 and hora_i_reunion <= 19)
);

CREATE TABLE MEA_ELENCOS (
    id_obra number(4,0) NOT NULL,
    id_lector number(5,0) NOT NULL,
    CONSTRAINT MEA_fk_elen_obra FOREIGN KEY (id_obra) REFERENCES MEA_OBRAS(id_obra),
    CONSTRAINT MEA_fk_elen_lector FOREIGN KEY (id_lector) REFERENCES MEA_LECTORES(id_lector),
    CONSTRAINT MEA_pk_elencos PRIMARY KEY (id_obra, id_lector)
);

CREATE TABLE MEA_MEJORES_ACTORES (
    id_obra_presentacion number(4,0) NOT NULL,
    id_fech_presentacion date NOT NULL,
    id_obra_elenco number(4,0) NOT NULL,
    id_lector number(5,0) NOT NULL,
    CONSTRAINT MEA_fk_mej_act_presentacion FOREIGN KEY (id_obra_presentacion, id_fech_presentacion) REFERENCES MEA_PRESENTACIONES(id_obra, fech_presentacion),
    CONSTRAINT MEA_fk_mej_act_elenco FOREIGN KEY (id_obra_elenco, id_lector) REFERENCES MEA_ELENCOS(id_obra, id_lector),
    CONSTRAINT MEA_pk_mejor_actores PRIMARY KEY (id_obra_presentacion, id_fech_presentacion, id_obra_elenco, id_lector)
);

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

CREATE TABLE MEA_ASOCIACIONES (
    id_club1 number(3,0) NOT NULL,
    id_club2 number (3,0) NOT NULL,
    CONSTRAINT MEA_fk_asoc_club1 FOREIGN KEY (id_club1) REFERENCES MEA_CLUBES(id_club),
    CONSTRAINT MEA_fk_asoc_club2 FOREIGN KEY (id_club2) REFERENCES MEA_CLUBES(id_club),
    CONSTRAINT MEA_pk_asociaciones PRIMARY KEY (id_club1, id_club2)
);

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

CREATE TABLE MEA_REUNIONES_CALENDARIO (
    id_club number(3,0) NOT NULL,
    id_grupo number(3,0) NOT NULL,
    isbn number(13,0) NOT NULL,
    fech_reunion date NOT NULL,
    realizada varchar2(2) NOT NULL,
    id_club_hist number(3,0) NOT NULL,
    id_grupo_hist number(3,0) NOT NULL,
    id_club_soc number(3,0) NOT NULL,
    id_lector number(5,0) NOT NULL,
    fech_i_socio date NOT NULL,
    fech_i_hist_grupo date NOT NULL,
    conclusion varchar2(500),
    valoracion number(3,1),
    ult_discusion varchar2(2),
    CONSTRAINT MEA_fk_reun_grupo FOREIGN KEY (id_club, id_grupo) REFERENCES MEA_GRUPOS(id_club, id_grupo),
    CONSTRAINT MEA_fk_reun_libro FOREIGN KEY (isbn) REFERENCES MEA_LIBROS(isbn),
    CONSTRAINT MEA_fk_reun_historico_grupo FOREIGN KEY (id_club_hist, id_grupo_hist, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo) REFERENCES MEA_HISTORICO_GRUPOS(id_club_grupo, id_grupo, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo),
    CONSTRAINT MEA_pk_reuniones_calendario PRIMARY KEY (id_club, id_grupo, isbn, fech_reunion),
    CONSTRAINT MEA_chk_realizada CHECK (realizada IN ('SI', 'NO')),
    CONSTRAINT MEA_chk_ult_discusion CHECK (ult_discusion IN ('SI', 'NO') OR ult_discusion IS NULL),
    CONSTRAINT MEA_chk_valoracion CHECK (valoracion >= 0.0 AND valoracion <= 5.0)   
);

CREATE TABLE MEA_A_L (
    id_autor number(3,0) NOT NULL,
    isbn number(13,0) NOT NULL,
    CONSTRAINT MEA_fk_a_l_autor FOREIGN KEY (id_autor) REFERENCES MEA_AUTORES(id_autor),
    CONSTRAINT MEA_fk_a_l_libro FOREIGN KEY (isbn) REFERENCES MEA_LIBROS(isbn),
    CONSTRAINT MEA_pk_a_l PRIMARY KEY (id_autor, isbn)
);

CREATE TABLE MEA_REFERENCIAS(
    id_obra number(4,0) NOT NULL,
    isbn number(13,0) NOT NULL,
    CONSTRAINT MEA_fk_refe_obra FOREIGN KEY (id_obra) REFERENCES MEA_OBRAS(id_obra),
    CONSTRAINT MEA_fk_refe_libro FOREIGN KEY (isbn) REFERENCES MEA_LIBROS(isbn),
    CONSTRAINT MEA_pk_referencias PRIMARY KEY (id_obra, isbn)
);

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
--                             VISTAS
--=====================================================================

CREATE OR REPLACE VIEW MEA_v_detalle_lectores AS
SELECT l.id_lector, l.p_nombre || ' ' || l.p_apellido AS nombre_lector, l.email, r.p_nombre || ' ' || r.p_apellido AS nombre_representante
FROM MEA_LECTORES l LEFT JOIN MEA_REPRESENTANTES r ON l.id_lector = r.id_lector;

CREATE OR REPLACE VIEW MEA_v_clubes_instituciones AS
SELECT c.id_club, c.nombre_club, c.cuota_membresia, i.nom_inst AS nombre_institucion, i.tipo_inst
FROM MEA_CLUBES c LEFT JOIN MEA_INSTITUCIONES i ON c.id_inst = i.id_inst;

CREATE OR REPLACE VIEW MEA_v_socios_activos AS
SELECT s.id_club, c.nombre_club, l.p_nombre || ' ' || l.p_apellido AS nombre_socio, s.fech_i_socio AS fecha_ingreso
FROM MEA_SOCIOS s JOIN MEA_CLUBES c ON s.id_club = c.id_club JOIN MEA_LECTORES l ON s.id_lector = l.id_lector WHERE s.status_socio = 'activo';

CREATE OR REPLACE VIEW MEA_v_catalogo_libros AS
SELECT b.isbn, b.titulo_libro, a.p_nombre || ' ' || a.p_apellido AS autor, p.nom_pais AS pais_origen, b.tipo_narrativa
FROM MEA_LIBROS b JOIN MEA_A_L al ON b.isbn = al.isbn JOIN MEA_AUTORES a ON al.id_autor = a.id_autor JOIN MEA_PAISES p ON b.id_pais = p.id_pais;

CREATE OR REPLACE VIEW MEA_v_historial_pago_socios AS
SELECT l.p_nombre || ' ' || l.p_apellido AS lector, c.nombre_club, p.id_pago_membresia AS recibo, p.fech_emision AS fecha_pago
FROM MEA_PAGOS_MEMBRESIAS p JOIN MEA_LECTORES l ON p.id_lector = l.id_lector JOIN MEA_CLUBES c ON p.id_club = c.id_club;

CREATE OR REPLACE VIEW MEA_v_agenda_reuniones AS
SELECT r.fech_reunion, c.nombre_club, g.tipo AS tipo_grupo, b.titulo_libro, r.realizada
FROM MEA_REUNIONES_CALENDARIO r JOIN MEA_CLUBES c ON r.id_club = c.id_club JOIN MEA_GRUPOS g ON r.id_club = g.id_club AND r.id_grupo = g.id_grupo JOIN MEA_LIBROS b ON r.isbn = b.isbn;

CREATE OR REPLACE VIEW MEA_v_contactos_sistema AS
SELECT 'CLUB' AS origen, c.nombre_club AS entidad, '(' || t.cod_local || ') ' || t.cod_area || '-' || t.num_tlf AS numero_completo
FROM MEA_TELEFONOS t JOIN MEA_CLUBES c ON t.id_club = c.id_club UNION
SELECT 'LECTOR' AS origen, l.p_nombre || ' ' || l.p_apellido AS entidad, '(' || t.cod_local || ') ' || t.cod_area || '-' || t.num_tlf AS numero_completo
FROM MEA_TELEFONOS t JOIN MEA_LECTORES l ON t.id_lector = l.id_lector;

CREATE OR REPLACE VIEW MEA_v_idiomas_hablados AS
SELECT i.nom_idioma, 'CLUB' AS tipo_entidad, c.nombre_club AS nombre_entidad
FROM MEA_HABLAN h JOIN MEA_IDIOMAS i ON h.id_idioma = i.id_idioma JOIN MEA_CLUBES c ON h.id_club = c.id_club UNION
SELECT i.nom_idioma, 'LECTOR' AS tipo_entidad, l.p_nombre || ' ' || l.p_apellido AS nombre_entidad
FROM MEA_HABLAN h JOIN MEA_IDIOMAS i ON h.id_idioma = i.id_idioma JOIN MEA_LECTORES l ON h.id_lector = l.id_lector;

CREATE OR REPLACE VIEW MEA_v_libros_favoritos AS
SELECT l.p_nombre || ' ' || l.p_apellido AS lector, b.titulo_libro, f.orden AS rango_preferencia
FROM MEA_FAVORITOS f JOIN MEA_LECTORES l ON f.id_lector = l.id_lector JOIN MEA_LIBROS b ON f.isbn = b.isbn;

CREATE OR REPLACE VIEW MEA_v_reporte_inasistencias AS
SELECT i.fech_reunion AS fecha_reunion, l.p_nombre || ' ' || l.p_apellido AS socio_ausente, c.nombre_club, b.titulo_libro
FROM MEA_INASISTENTES i JOIN MEA_LECTORES l ON i.id_lector = l.id_lector JOIN MEA_CLUBES c ON i.id_club_soc = c.id_club JOIN MEA_LIBROS b ON i.isbn = b.isbn;

CREATE OR REPLACE VIEW MEA_v_produccion_obras AS
SELECT o.nombre_obra, p.fech_presentacion, p.cantidad_asistentes, p.valoracion, o.precio AS costo_entrada
FROM MEA_OBRAS o JOIN MEA_PRESENTACIONES p ON o.id_obra = p.id_obra;

CREATE OR REPLACE VIEW MEA_v_elencos_y_premiados AS
SELECT o.nombre_obra, l.p_nombre || ' ' || l.p_apellido AS actor, CASE WHEN m.id_lector IS NULL THEN 'No' ELSE 'SÍ' END AS fue_premiado, m.id_fech_presentacion AS fecha_premio
FROM MEA_ELENCOS e JOIN MEA_OBRAS o ON e.id_obra = o.id_obra JOIN MEA_LECTORES l ON e.id_lector = l.id_lector LEFT JOIN MEA_MEJORES_ACTORES m ON e.id_lector = m.id_lector AND e.id_obra = m.id_obra_elenco;

CREATE OR REPLACE VIEW MEA_v_trayectoria_grupos AS
SELECT l.p_nombre || ' ' || l.p_apellido AS socio, c.nombre_club, g.tipo AS tipo_grupo, hg.fech_i_hist_grupo AS fecha_inicio, hg.fech_f_hist_grupo AS fecha_fin
FROM MEA_HISTORICO_GRUPOS hg JOIN MEA_LECTORES l ON hg.id_lector = l.id_lector JOIN MEA_CLUBES c ON hg.id_club_soc = c.id_club JOIN MEA_GRUPOS g ON hg.id_club_grupo = g.id_club AND hg.id_grupo = g.id_grupo;

CREATE OR REPLACE VIEW MEA_v_clubes_asociados AS
SELECT c1.nombre_club AS club_principal, c2.nombre_club AS club_asociado
FROM MEA_ASOCIACIONES a JOIN MEA_CLUBES c1 ON a.id_club1 = c1.id_club JOIN MEA_CLUBES c2 ON a.id_club2 = c2.id_club;


--=====================================================================
--                            FUNCIONES
--=====================================================================

CREATE OR REPLACE FUNCTION MEA_conversion_monetaria(
    p_id_pais     IN NUMBER,
    p_monto       IN NUMBER,
    p_tasa_cambio IN NUMBER
) RETURN MEA_conversion_table PIPELINED IS
    v_monto_usd  NUMBER;
    v_moneda     VARCHAR2(3);
    v_pais       VARCHAR2(20);
BEGIN
    SELECT moneda, nom_pais INTO v_moneda, v_pais
    FROM MEA_PAISES WHERE id_pais = p_id_pais;

    IF v_moneda = 'USD' THEN v_monto_usd := p_monto;
    ELSE v_monto_usd := ROUND(p_monto / p_tasa_cambio, 2);
    END IF;

    PIPE ROW (MEA_conversion_row(p_id_pais, v_pais, v_moneda, p_monto, 
        CASE WHEN v_moneda = 'USD' THEN 'Misma moneda (USD)' ELSE '1 USD = ' || p_tasa_cambio || ' ' || v_moneda END,
        v_monto_usd || ' USD'));
    RETURN;
END;
/

CREATE OR REPLACE FUNCTION MEA_promedio_part_mensual_tipo(
    p_id_club IN NUMBER,
    p_tipo_grupo IN VARCHAR2, 
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
    BEGIN
        SELECT nombre_club INTO v_nom_club FROM MEA_CLUBES WHERE id_club = p_id_club;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN raise_application_error(-20010, 'Club no existe.');
    END;
    IF p_mes < 1 OR p_mes > 12 THEN raise_application_error(-20011, 'Mes inválido.'); END IF;
    v_fecha_consulta := TO_DATE('01/' || p_mes || '/' || p_anio, 'DD/MM/YYYY');
    IF v_fecha_consulta > SYSDATE THEN raise_application_error(-20012, 'Fecha futura.'); END IF;

    SELECT COUNT(*) INTO v_total_esperado
    FROM MEA_REUNIONES_CALENDARIO r, MEA_GRUPOS g, MEA_HISTORICO_GRUPOS h
    WHERE r.id_club = g.id_club AND r.id_grupo = g.id_grupo AND h.id_club_grupo = g.id_club 
      AND h.id_grupo = g.id_grupo AND r.fech_reunion >= h.fech_i_hist_grupo 
      AND (h.fech_f_hist_grupo IS NULL OR r.fech_reunion <= h.fech_f_hist_grupo)
      AND g.id_club = p_id_club AND g.tipo = v_tipo_normalizado
      AND EXTRACT(MONTH FROM r.fech_reunion) = p_mes AND EXTRACT(YEAR FROM r.fech_reunion) = p_anio
      AND r.realizada = 'SI';

    SELECT COUNT(*) INTO v_total_inasistencias
    FROM MEA_INASISTENTES i, MEA_GRUPOS g
    WHERE i.id_club_reu = g.id_club AND i.id_grupo_reu = g.id_grupo AND g.id_club = p_id_club
      AND g.tipo = v_tipo_normalizado AND EXTRACT(MONTH FROM i.fech_reunion) = p_mes
      AND EXTRACT(YEAR FROM i.fech_reunion) = p_anio;

    IF v_total_esperado > 0 THEN v_promedio := ((v_total_esperado - v_total_inasistencias) / v_total_esperado) * 100;
    ELSE v_promedio := 0; END IF;

    RETURN ROUND(v_promedio, 2);
END;
/

CREATE OR REPLACE FUNCTION MEA_edad_miembro(p_id_lector IN NUMBER) 
RETURN NUMBER IS
    v_f_nacimiento DATE;
BEGIN
    SELECT f_nacimiento INTO v_f_nacimiento FROM MEA_LECTORES WHERE id_lector = p_id_lector;
    RETURN TRUNC(MONTHS_BETWEEN(SYSDATE, v_f_nacimiento) / 12);
EXCEPTION
    WHEN NO_DATA_FOUND THEN raise_application_error(-20015, 'Lector no existe.');
END;
/

CREATE OR REPLACE FUNCTION MEA_antiguedad_miembro(p_id_lector IN NUMBER)
RETURN NUMBER IS
    v_fech_i DATE;
BEGIN
    SELECT MIN(fech_i_socio) INTO v_fech_i FROM MEA_SOCIOS WHERE id_lector = p_id_lector;
    IF v_fech_i IS NULL THEN RETURN 0; END IF;
    RETURN TRUNC(MONTHS_BETWEEN(SYSDATE, v_fech_i) / 12);
END;
/

CREATE OR REPLACE FUNCTION MEA_participacion_bimestre_miembro (p_id_lector NUMBER, p_bimestre NUMBER, p_anio NUMBER)
RETURN NUMBER IS
    v_inasistencias NUMBER;
    v_total_reuniones NUMBER;
BEGIN
    IF p_bimestre < 1 OR p_bimestre > 6 THEN raise_application_error(-20014, 'Bimestre 1-6.'); END IF;

    SELECT count(*) INTO v_inasistencias FROM mea_inasistentes
    WHERE p_id_lector = id_lector AND EXTRACT(YEAR FROM fech_reunion) = p_anio
      AND EXTRACT(MONTH FROM fech_reunion) BETWEEN (p_bimestre - 1) * 2 + 1 AND p_bimestre * 2;

    SELECT count(*) INTO v_total_reuniones FROM mea_historico_grupos h, mea_reuniones_calendario r 
    WHERE p_id_lector = h.id_lector AND h.id_club_grupo = r.id_club AND h.id_grupo = r.id_grupo 
      AND r.fech_reunion >= h.fech_i_hist_grupo AND (h.fech_f_hist_grupo IS NULL OR r.fech_reunion <= h.fech_f_hist_grupo) 
      AND EXTRACT(YEAR FROM r.fech_reunion) = p_anio AND EXTRACT(MONTH FROM r.fech_reunion) BETWEEN (p_bimestre - 1) * 2 + 1 AND p_bimestre * 2
      AND r.realizada = 'SI';

    IF v_total_reuniones = 0 THEN RETURN 0;
    ELSE RETURN ((v_total_reuniones - v_inasistencias) / v_total_reuniones) * 100;
    END IF;
END;
/

--=====================================================================
--                            PROCEDIMIENTOS
--=====================================================================

-- 1. ASIGNAR LIBROS FAVORITOS (Debe ir antes de Inscribir)
CREATE OR REPLACE PROCEDURE MEA_asignar_favoritos(
    p_id_lector IN NUMBER, p_isbn_fav1 IN NUMBER, p_isbn_fav2 IN NUMBER, p_isbn_fav3 IN NUMBER
) IS
BEGIN
    DELETE FROM MEA_FAVORITOS WHERE id_lector = p_id_lector;
    IF p_isbn_fav1 IS NOT NULL THEN INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (p_id_lector, p_isbn_fav1, 1); END IF;
    IF p_isbn_fav2 IS NOT NULL THEN INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (p_id_lector, p_isbn_fav2, 2); END IF;
    IF p_isbn_fav3 IS NOT NULL THEN INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (p_id_lector, p_isbn_fav3, 3); END IF;
END;
/

-- 2. DIVIDIR GRUPO (Debe ir antes de Inscribir)
CREATE OR REPLACE PROCEDURE MEA_dividir_grupo(p_id_club IN NUMBER, p_id_grupo IN NUMBER) IS
    v_nuevo_id_grupo NUMBER; v_conteo_actual NUMBER; v_mitad NUMBER; v_fecha_actual DATE := SYSDATE; v_tipo VARCHAR2(10); v_dia NUMBER; v_hora NUMBER; v_reuniones_pendientes NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_reuniones_pendientes FROM MEA_REUNIONES_CALENDARIO WHERE id_club = p_id_club AND id_grupo = p_id_grupo AND ult_discusion = 'SI' AND realizada = 'NO';
    IF v_reuniones_pendientes > 0 THEN raise_application_error(-20050, 'Grupo en discusión.'); END IF;
    SELECT tipo, dia_reunion, hora_i_reunion INTO v_tipo, v_dia, v_hora FROM MEA_GRUPOS WHERE id_club = p_id_club AND id_grupo = p_id_grupo;
    SELECT COUNT(*) INTO v_conteo_actual FROM MEA_HISTORICO_GRUPOS WHERE id_club_grupo = p_id_club AND id_grupo = p_id_grupo AND fech_f_hist_grupo IS NULL;
    IF v_conteo_actual < 2 THEN RETURN; END IF;
    v_nuevo_id_grupo := MEA_seq_grupos.NEXTVAL;
    INSERT INTO MEA_GRUPOS (id_club, id_grupo, fech_creacion, tipo, dia_reunion, hora_i_reunion) VALUES (p_id_club, v_nuevo_id_grupo, v_fecha_actual, v_tipo, v_dia, v_hora);
    v_mitad := FLOOR(v_conteo_actual / 2);
    FOR rec IN (SELECT id_lector, fech_i_socio FROM MEA_HISTORICO_GRUPOS WHERE id_club_grupo = p_id_club AND id_grupo = p_id_grupo AND fech_f_hist_grupo IS NULL ORDER BY MEA_antiguedad_miembro(id_lector) ASC, fech_i_socio DESC FETCH FIRST v_mitad ROWS ONLY) LOOP
        INSERT INTO MEA_HISTORICO_GRUPOS (id_club_grupo, id_grupo, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo) VALUES (p_id_club, v_nuevo_id_grupo, p_id_club, rec.id_lector, rec.fech_i_socio, v_fecha_actual);
    END LOOP;
END;
/

-- 3. INSCRIBIR MIEMBRO
CREATE OR REPLACE PROCEDURE MEA_inscribir_miembro(
    p_doc_identidad IN NUMBER, p_p_nombre IN VARCHAR2, p_s_nombre IN VARCHAR2, p_p_apellido IN VARCHAR2, p_s_apellido IN VARCHAR2, p_f_nacimiento IN DATE, p_email IN VARCHAR2, p_id_club IN NUMBER, p_isbn_fav1 IN NUMBER, p_isbn_fav2 IN NUMBER, p_isbn_fav3 IN NUMBER, p_id_repre_lector IN NUMBER DEFAULT NULL, p_doc_repre_ext IN NUMBER DEFAULT NULL, p_nom_repre_ext IN VARCHAR2 DEFAULT NULL, p_ape_repre_ext IN VARCHAR2 DEFAULT NULL, p_sape_repre_ext IN VARCHAR2 DEFAULT NULL
) IS
    v_id_lector NUMBER; v_edad NUMBER; v_tipo_grupo VARCHAR2(10); v_max_miembros NUMBER; v_id_grupo NUMBER; v_conteo_actual NUMBER; v_fecha_actual DATE := SYSDATE;
BEGIN
    v_edad := TRUNC(MONTHS_BETWEEN(v_fecha_actual, p_f_nacimiento) / 12);
    IF v_edad < 18 AND p_id_repre_lector IS NULL AND p_doc_repre_ext IS NULL THEN raise_application_error(-20040, 'Menor sin representante.'); END IF;
    BEGIN
        SELECT id_lector INTO v_id_lector FROM MEA_LECTORES WHERE doc_identidad = p_doc_identidad;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            v_id_lector := MEA_seq_lectores.NEXTVAL;
            INSERT INTO MEA_LECTORES (id_lector, doc_identidad, p_nombre, s_nombre, p_apellido, s_apellido, f_nacimiento, email, id_lector_repre) VALUES (v_id_lector, p_doc_identidad, p_p_nombre, p_s_nombre, p_p_apellido, p_s_apellido, p_f_nacimiento, p_email, p_id_repre_lector);
            IF p_doc_repre_ext IS NOT NULL THEN INSERT INTO MEA_REPRESENTANTES (id_lector, id_representante, doc_identidad, p_nombre, p_apellido, s_apellido) VALUES (v_id_lector, MEA_seq_representantes.NEXTVAL, p_doc_repre_ext, p_nom_repre_ext, p_ape_repre_ext, p_sape_repre_ext); END IF;
    END;
    MEA_asignar_favoritos(v_id_lector, p_isbn_fav1, p_isbn_fav2, p_isbn_fav3);
    v_edad := MEA_edad_miembro(v_id_lector);
    IF v_edad BETWEEN 6 AND 12 THEN v_tipo_grupo := 'infantil'; v_max_miembros := 15; ELSIF v_edad BETWEEN 13 AND 24 THEN v_tipo_grupo := 'joven'; v_max_miembros := 15; ELSIF v_edad >= 25 THEN v_tipo_grupo := 'adulto'; v_max_miembros := 30; ELSE raise_application_error(-20001, 'Edad insuficiente.'); END IF;
    INSERT INTO MEA_SOCIOS (id_club, id_lector, fech_i_socio, status_socio) VALUES (p_id_club, v_id_lector, v_fecha_actual, 'activo');
    BEGIN
        SELECT MIN(id_grupo) INTO v_id_grupo FROM MEA_GRUPOS g WHERE g.id_club = p_id_club AND g.tipo = v_tipo_grupo AND NOT EXISTS (SELECT 1 FROM MEA_REUNIONES_CALENDARIO r WHERE r.id_club = g.id_club AND r.id_grupo = g.id_grupo AND r.realizada = 'NO');
        IF v_id_grupo IS NULL THEN raise_application_error(-20002, 'Sin grupos.'); END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN raise_application_error(-20002, 'Sin grupos.');
    END;
    INSERT INTO MEA_HISTORICO_GRUPOS (id_club_grupo, id_grupo, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo) VALUES (p_id_club, v_id_grupo, p_id_club, v_id_lector, v_fecha_actual, v_fecha_actual);
    SELECT COUNT(*) INTO v_conteo_actual FROM MEA_HISTORICO_GRUPOS WHERE id_club_grupo = p_id_club AND id_grupo = v_id_grupo AND fech_f_hist_grupo IS NULL;
    IF v_conteo_actual > v_max_miembros THEN MEA_dividir_grupo(p_id_club, v_id_grupo); END IF;
END;
/

CREATE OR REPLACE PROCEDURE MEA_generar_calendario(p_id_club IN NUMBER, p_id_grupo IN NUMBER, p_isbn IN NUMBER, p_fecha_inicio IN DATE, p_cant_reun IN NUMBER, p_id_lector IN NUMBER) IS
    v_fecha_iterada DATE; v_id_club_soc NUMBER; v_fech_i_socio DATE; v_fech_i_hist DATE;
BEGIN
    SELECT id_club_soc, fech_i_socio, fech_i_hist_grupo INTO v_id_club_soc, v_fech_i_socio, v_fech_i_hist FROM MEA_HISTORICO_GRUPOS WHERE id_lector = p_id_lector AND fech_f_hist_grupo IS NULL;
    FOR i IN 0..(p_cant_reun - 1) LOOP
        v_fecha_iterada := p_fecha_inicio + (i * 7);
        INSERT INTO MEA_REUNIONES_CALENDARIO (id_club, id_grupo, isbn, fech_reunion, realizada, id_club_hist, id_grupo_hist, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo, ult_discusion) VALUES (p_id_club, p_id_grupo, p_isbn, v_fecha_iterada, 'NO', p_id_club, p_id_grupo, v_id_club_soc, p_id_lector, v_fech_i_socio, v_fech_i_hist, 'NO');
    END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE MEA_realizar_reunion(p_id_club IN NUMBER, p_id_grupo IN NUMBER, p_isbn IN NUMBER, p_fecha IN DATE) IS
BEGIN
    UPDATE MEA_REUNIONES_CALENDARIO SET realizada = 'SI' WHERE id_club = p_id_club AND id_grupo = p_id_grupo AND isbn = p_isbn AND fech_reunion = p_fecha;
END;
/

CREATE OR REPLACE PROCEDURE MEA_cerrar_calendario(p_id_club IN NUMBER, p_id_grupo IN NUMBER, p_isbn IN NUMBER, p_fecha_cierre IN DATE, p_valoracion IN NUMBER, p_conclusion IN VARCHAR2) IS
BEGIN
    UPDATE MEA_REUNIONES_CALENDARIO SET realizada = 'SI', ult_discusion = 'SI', valoracion = p_valoracion, conclusion = p_conclusion WHERE id_club = p_id_club AND id_grupo = p_id_grupo AND isbn = p_isbn AND fech_reunion = p_fecha_cierre;
    DELETE FROM MEA_REUNIONES_CALENDARIO WHERE id_club = p_id_club AND id_grupo = p_id_grupo AND isbn = p_isbn AND fech_reunion > p_fecha_cierre;
END;
/

CREATE OR REPLACE PROCEDURE MEA_retirar_miembro(p_id_club IN NUMBER, p_id_lector IN NUMBER, p_motivo IN VARCHAR2) IS
BEGIN
    UPDATE MEA_SOCIOS SET status_socio = 'inactivo', fech_f_socio = SYSDATE, motivo_retiro = LOWER(p_motivo) WHERE id_club = p_id_club AND id_lector = p_id_lector AND status_socio = 'activo';
    UPDATE MEA_HISTORICO_GRUPOS SET fech_f_hist_grupo = SYSDATE WHERE id_lector = p_id_lector AND fech_f_hist_grupo IS NULL;
END;
/

CREATE OR REPLACE PROCEDURE MEA_crear_club(p_nombre IN VARCHAR2, p_direccion IN VARCHAR2, p_codigo_postal IN VARCHAR2, p_id_pais IN NUMBER, p_id_ciudad IN NUMBER, p_id_inst IN NUMBER, p_cuota IN NUMBER) IS
    v_id_club NUMBER;
BEGIN
    IF p_id_inst IS NOT NULL AND p_cuota IS NOT NULL THEN raise_application_error(-20080, 'Error: Cuota en club institucional.'); END IF;
    v_id_club := MEA_seq_clubes.NEXTVAL;
    INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad, cuota_membresia, id_inst) VALUES (v_id_club, p_nombre, SYSDATE, p_direccion, p_codigo_postal, p_id_pais, p_id_ciudad, p_cuota, p_id_inst);
END;
/


-- =============================================================================
--                                TRIGGERS
-- =============================================================================

CREATE OR REPLACE TRIGGER MEA_TRG_TRASLADO_GRUPO
BEFORE INSERT ON MEA_HISTORICO_GRUPOS FOR EACH ROW
DECLARE PRAGMA AUTONOMOUS_TRANSACTION; 
BEGIN
    UPDATE MEA_HISTORICO_GRUPOS SET fech_f_hist_grupo = :new.fech_i_hist_grupo WHERE id_lector = :new.id_lector AND id_club_soc = :new.id_club_soc AND fech_f_hist_grupo IS NULL;
    COMMIT; :new.fech_f_hist_grupo := NULL; 
END;
/

CREATE OR REPLACE TRIGGER MEA_TRG_VALIDAR_DIA_FECHA
BEFORE INSERT OR UPDATE OF fech_reunion ON MEA_REUNIONES_CALENDARIO FOR EACH ROW
DECLARE v_dia_pautado NUMBER; v_dia_ingresado NUMBER;
BEGIN
    IF :new.fech_reunion < TO_DATE('01-01-2024','DD-MM-YYYY') THEN RAISE_APPLICATION_ERROR(-20030, 'Fecha antigua.'); END IF;
    SELECT dia_reunion INTO v_dia_pautado FROM MEA_GRUPOS WHERE id_club = :new.id_club AND id_grupo = :new.id_grupo;
    v_dia_ingresado := TO_NUMBER(TO_CHAR(:new.fech_reunion, 'D', 'NLS_DATE_LANGUAGE = SPANISH'));
    IF v_dia_ingresado <> v_dia_pautado THEN RAISE_APPLICATION_ERROR(-20031, 'Día inválido.'); END IF;
END;
/

CREATE OR REPLACE TRIGGER MEA_TRG_MODERADOR_REGLAS
BEFORE INSERT OR UPDATE OF id_lector, id_club, id_grupo ON MEA_REUNIONES_CALENDARIO FOR EACH ROW
DECLARE v_tipo_grupo_destino VARCHAR2(10); v_tipo_grupo_moderador VARCHAR2(10); v_conteo_ocupado NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_conteo_ocupado FROM MEA_REUNIONES_CALENDARIO WHERE id_lector = :new.id_lector AND (id_club <> :new.id_club OR id_grupo <> :new.id_grupo) AND (realizada = 'NO' OR ult_discusion = 'NO');
    IF v_conteo_ocupado > 0 THEN RAISE_APPLICATION_ERROR(-20032, 'Moderador ocupado.'); END IF;
    SELECT tipo INTO v_tipo_grupo_destino FROM MEA_GRUPOS WHERE id_club = :new.id_club AND id_grupo = :new.id_grupo;
    IF v_tipo_grupo_destino = 'infantil' THEN
        SELECT tipo INTO v_tipo_grupo_moderador FROM MEA_GRUPOS WHERE id_club = :new.id_club_hist AND id_grupo = :new.id_grupo_hist;
        IF v_tipo_grupo_moderador <> 'adulto' THEN RAISE_APPLICATION_ERROR(-20033, 'Solo adultos moderan infantiles.'); END IF;
    ELSE IF :new.id_grupo <> :new.id_grupo_hist THEN RAISE_APPLICATION_ERROR(-20034, 'Moderador del mismo grupo.'); END IF; END IF;
END;
/

CREATE OR REPLACE TRIGGER MEA_TRG_CALENDARIO_ACTIVO
BEFORE INSERT ON MEA_REUNIONES_CALENDARIO FOR EACH ROW
DECLARE v_activo NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_activo FROM MEA_REUNIONES_CALENDARIO WHERE id_club = :new.id_club AND id_grupo = :new.id_grupo AND isbn <> :new.isbn AND (ult_discusion IS NULL OR ult_discusion = 'NO');
    IF v_activo > 0 THEN RAISE_APPLICATION_ERROR(-20035, 'Libro activo.'); END IF;
END;
/

CREATE OR REPLACE TRIGGER MEA_TRG_PAGO_INICIAL
AFTER INSERT ON MEA_SOCIOS FOR EACH ROW
DECLARE v_cuota NUMBER;
BEGIN
    SELECT cuota_membresia INTO v_cuota FROM MEA_CLUBES WHERE id_club = :new.id_club;
    IF v_cuota IS NOT NULL THEN
        INSERT INTO MEA_PAGOS_MEMBRESIAS (id_club, id_lector, fech_i_socio, id_pago_membresia, fech_emision)
        VALUES (:new.id_club, :new.id_lector, :new.fech_i_socio, MEA_seq_pagos_membresias.NEXTVAL, :new.fech_i_socio);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER MEA_TRG_UN_CLUB_A_LA_VEZ
BEFORE INSERT OR UPDATE OF status_socio ON MEA_SOCIOS FOR EACH ROW
WHEN (new.status_socio = 'activo')
DECLARE v_activos NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_activos FROM MEA_SOCIOS WHERE id_lector = :new.id_lector AND status_socio = 'activo' AND (id_club <> :new.id_club OR fech_i_socio <> :new.fech_i_socio);
    IF v_activos > 0 THEN RAISE_APPLICATION_ERROR(-20060, 'Ya activo en un club.'); END IF;
END;
/

CREATE OR REPLACE TRIGGER MEA_TRG_UN_GRUPO_A_LA_VEZ
BEFORE INSERT OR UPDATE OF fech_f_hist_grupo ON MEA_HISTORICO_GRUPOS FOR EACH ROW
WHEN (new.fech_f_hist_grupo IS NULL)
DECLARE v_grupos_activos NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_grupos_activos FROM MEA_HISTORICO_GRUPOS WHERE id_lector = :new.id_lector AND fech_f_hist_grupo IS NULL AND (id_club_grupo <> :new.id_club_grupo OR id_grupo <> :new.id_grupo); 
    IF v_grupos_activos > 0 THEN RAISE_APPLICATION_ERROR(-20061, 'Ya en un grupo.'); END IF;
END;
/

CREATE OR REPLACE TRIGGER MEA_TRG_NO_UNIRSE_DURANTE_DISCUSION
BEFORE INSERT ON MEA_HISTORICO_GRUPOS FOR EACH ROW
WHEN (new.fech_f_hist_grupo IS NULL)
DECLARE v_pendientes NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_pendientes FROM MEA_REUNIONES_CALENDARIO WHERE id_club = :new.id_club_grupo AND id_grupo = :new.id_grupo AND realizada = 'NO';
    IF v_pendientes > 0 THEN RAISE_APPLICATION_ERROR(-20065, 'Grupo ocupado.'); END IF;
END;
/

CREATE OR REPLACE TRIGGER MEA_TRG_FAVORITOS_LIMITE
FOR INSERT OR UPDATE ON MEA_FAVORITOS COMPOUND TRIGGER
    TYPE t_lectores IS TABLE OF MEA_FAVORITOS.id_lector%TYPE INDEX BY PLS_INTEGER;
    v_lectores t_lectores; v_idx PLS_INTEGER := 0;
    BEFORE STATEMENT IS BEGIN v_idx := 0; v_lectores.DELETE; END BEFORE STATEMENT;
    AFTER EACH ROW IS BEGIN v_idx := v_idx + 1; v_lectores(v_idx) := :new.id_lector; END AFTER EACH ROW;
    AFTER STATEMENT IS v_cant NUMBER; v_duplicados NUMBER;
    BEGIN
        FOR i IN 1 .. v_idx LOOP
            SELECT COUNT(*) INTO v_cant FROM MEA_FAVORITOS WHERE id_lector = v_lectores(i);
            IF v_cant > 3 THEN RAISE_APPLICATION_ERROR(-20070, 'Max 3.'); END IF;
            SELECT COUNT(*) INTO v_duplicados FROM (SELECT isbn FROM MEA_FAVORITOS WHERE id_lector = v_lectores(i) GROUP BY isbn HAVING COUNT(*) > 1);
            IF v_duplicados > 0 THEN RAISE_APPLICATION_ERROR(-20071, 'Libro repetido.'); END IF;
            SELECT COUNT(*) INTO v_duplicados FROM (SELECT orden FROM MEA_FAVORITOS WHERE id_lector = v_lectores(i) GROUP BY orden HAVING COUNT(*) > 1);
            IF v_duplicados > 0 THEN RAISE_APPLICATION_ERROR(-20072, 'Orden repetido.'); END IF;
        END LOOP;
    END AFTER STATEMENT;
END MEA_TRG_FAVORITOS_LIMITE;
/

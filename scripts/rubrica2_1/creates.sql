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

--=====================================================================
--                      TABLAS INDEPENDIENTES
--=====================================================================

CREATE TABLE MEA_INSTITUCIONES (
    id_inst number(3,0) PRIMARY KEY,
    nom_inst varchar2(20) NOT NULL,
    tipo_inst varchar2(20) NOT NULL
    CONSTRAINT chk_tipo_inst CHECK (tipo_inst IN ('colegio', 'biblioteca', 'universidad')
)

CREATE TABLE MEA_IDIOMAS (
    id_idioma number(3,0) PRIMARY KEY,
    nom_idioma varchar2(20) NOT NULL
)

CREATE TABLE MEA_PAISES (
    id_pais number(3,0) PRIMARY KEY,
    nom_pais varchar2(20) NOT NULL,
    moneda varchar2(3) NOT NULL,
    nacionalidad varchar2(20) NOT NULL) 

CREATE TABLE MEA_AUTORES (
    id_autor number(3,0) PRIMARY KEY,
    p_nombre  varchar2(15) NOT NULL,
    s_nombre  varchar2(15),
    p_apellido varchar2(15) NOT NULL,
    s_apellido varchar2(15) NOT NULL
)

--=====================================================================
--                      TABLAS DEPENDIENTES
--=====================================================================
-- Si el constraint es aparte para ambos (PK y FK) primero el Fk, luego la PK
-- el nombre del PK deba estar en plural con el nombre de la entidad a la que pertenezca
-- el nombre de la FK debe nombrar la entidad en la que se encuentra (4 primeras letras), seguido del nombre de entidad que está referenciando

CREATE TABLE MEA_CIUDADES (
    id_pais number(3,0) NOT NULL,
    id_ciudad number(3,0) NOT NULL,
    nom_ciudad varchar2(20) NOT NULL,
    CONSTRAINT fk_ciud_pais FOREIGN KEY (id_pais) REFERENCES MEA_PAISES(id_pais),
    CONSTRAINT pk_ciudades PRIMARY KEY (id_pais, id_ciudad)
)

CREATE TABLE MEA_CLUBES (
    id_club number (3,0) PRIMARY KEY,
    nombre_club carchar2(20) NOT NULL,
    fech_creacion date NOT NULL,
    direccion vachar2(30) NOT NULL,
    codigo_postal number(5,0) NOT NULL,
    cuota_membresia number (5,0) NOT NULL,
    id_inst number(3,0) NOT NULL,
    CONSTRAINT fk_club_inst FOREIGN KEY (id_inst) REFERENCES MEA_INSTITUCIONES(id_inst)
)

CREATE TABLE MEA_LECTORES (
    id_lector number(5,0) PRIMARY KEY,
    doc_identidad number(9,0) NOT NULL UNIQUE,
    p_nombre varchar2(15) NOT NULL,
    s_nombre varchar2(15) NOT NULL,
    p_apellido varchar2(15) NOT NULL,
    s_apellido varchar2(15) NOT NULL,
    f_nacimiento date NOT NULL,
    email varchar2(30) NOT NULL,
    id_lector_repre number(3,0),
    CONSTRAINT fk_lect_repre FOREIGN KEY (id_lector_repre) REFERENCES LECTORES(id_lector)
)

CREATE TABLE REPRESENTANTES (
    id_lector number(5,0),
    id_representante number(3,0),
    doc_identidad number(9,0) NOT NULL,
    p_nombre varchar2(15) NOT NULL,
    p_apellido varchar2(15) NOT NULL,
    s_apellido varchar2(15) NOT NULL,
    CONSTRAINT fk_repr_lector FOREIGN KEY (id_lector) REFERENCES LECTORES(id_lector),
    CONSTRAINT pk_representantes PRIMARY KEY (id_lector, id_representante),
)

CREATE TABLE HABLAN (
    id_idioma number(3,0) NOT NULL,
    id_habla number(3,0) NOT NULL,
    id_club number(3,0),
    id_lector number(3,0),
    CONSTRAINT fk_habl_idioma FOREIGN KEY (id_idioma) REFERENCES IDIOMAS(id_idioma),
    CONSTRAINT fk_habl_lector FOREIGN KEY (id_lector) REFERENCES LECTORES(id_lector),
    CONSTRAINT fk_habl_club FOREIGN KEY (id_club) REFERENCES CLUBES(id_club),
    CONSTRAINT pk_hablan PRIMARY KEY (id_idioma, id_habla)
    --IMPLEMENTACIÖN DE ARCO EXCLUSIVO
    CONSTRAINT chk_club_lector CHECK (id_club IS NOT NULL AND id_lector IS NULL) OR (id_lector IS NOT NULL AND id_club IS NULL)
)

CREATE TABLE TELEFONOS (
    cod_local number(3,0) NOT NULL,
    cod_area number(3,0) NOT NULL,
    num_tlf number(7,0) NOT NULL,
    id_club number(3,0),
    id_lector number(5,0),
    CONSTRAINT fk_tele_club FOREIGN KEY (id_club) REFERENCES CLUBES(id_club),
    CONSTRAINT fk_tele_lector FOREIGN KEY (id_lector) REFERENCES LECTORES(id_lector)
    CONSTRAINT pk_telefonos PRIMARY KEY (cod_local, cod_area, num_tlf),
    --IMPLEMENTACIÖN DE ARCO EXCLUSIVO
    CONSTRAINT chk_club_lector CHECK (id_club IS NOT NULL AND id_lector IS NULL) OR (id_lector IS NOT NULL AND id_club IS NULL)
)

CREATE TABLE OBRAS (
    id_obra number(4,0) PRIMARY KEY,
    nombre_obra varchar2(30) NOT NULL,
    status_obra varchar2(10) NOT NULL,
    id_club number(3,0) NOT NULL,
    precio number(10,2),
    CONSTRAINT fk_obra_club FOREIGN KEY (id_club) REFERENCES CLUBES(id_club),
    CONSTRAINT chk_status_obra CHECK (status_obra IN ('activa', 'inactiva')
)

CREATE TABLE SOCIOS (
    id_club number(3,0) NOT NULL,
    id_lector number(5,0) NOT NULL,
    fech_i_socio date NOT NULL,
    status_socio varchar2(8) NOT NULL,
    fech_f_socio date,
    motivo_retiro varchar2(15),
    CONSTRAINT fk_soci_club FOREIGN KEY (id_club) REFERENCES CLUBES(id_club),
    CONSTRAINT fk_soci_lector FOREIGN KEY (id_lector) REFERENCES LECTORES(id_lector),
    CONSTRAINT pk_socios PRIMARY KEY (id_club, id_lector, fech_i_socio),
    CONSTRAINT chk_status_socio CHECK (status_socio IN ('activo', 'inactivo')),
    CONSTRAINT chk_motivo CHECK (motivo_retiro IN ('deuda', 'inasistencia', 'otro')) OR motivo_retiro IS NULL) --> SE PERMITE NULL PARA LOS SOCIOS ACTIVOS
)

CREATE TABLE PAGOS_MEMBRESIAS (
    id_club number(3,0) NOT NULL,
    id_lector number(5,0) NOT NULL,
    fech_i_socio date NOT NULL,
    id_pago_membresia number(3,0) NOT NULL,
    fech_emision date NOT NULL,
    CONSTRAINT fk_pago_memb_socios FOREIGN KEY (id_club, id_lector, fech_i_socio) REFERENCES SOCIOS (id_club, id_lector, fech_i_socio) 
    CONSTRAINT pk_pagos_memb PRIMARY KEY (id_club, id_lector, fech_i_socio, id_pago_membresia),
)

CREATE TABLE PRESENTACIONES(
    id_obra number(3,0) NOT NULL,
    fech_presentacion date NOT NULL,
    valoracion number(2,1) NOT NULL,
    cantidad_asistentes number(5,0) NOT NULL,
    CONSTRAINT fk_pres_obra FOREIGN KEY (id_obra) REFERENCES OBRAS(id_obra)
    CONSTRAINT pk_presentaciones PRIMARY KEY (id_obra, fech_presentacion),
) 

CREATE TABLE GRUPOS (
    id_club number(3,0) NOT NULL,
    id_grupo number(3,0) NOT NULL,
    fech_creacion date NOT NULL,
    tipo varchar2(10) NOT NULL,
    dia_reunion number(1,0) NOT NULL,
    hora_i_reunion number(2,0) NOT NULL,
    CONSTRAINT fk_club FOREIGN KEY (id_club) REFERENCES CLUBES(id_club),
    Constraint pk_grupos PRIMARY KEY (id_club, id_grupo),
    CONSTRAINT chk_tipo CHECK (tipo IN ('joven', 'adulto', 'infantil')),
    CONSTRAINT chk_dia_reunion CHECK (dia_reunion IN (2,3,4,5,6)),
    CONSTRAINT chk_hora_i_reunion CHECK (hora_i_reunion >= 17.00 and hora_i_reunion <= 19.00)
)

CREATE TABLE ELENCOS (
    id_obra number(3,0) NOT NULL,
    id_lector number(5,0) NOT NULL,
    CONSTRAINT fk_elen_obra FOREIGN KEY (id_obra) REFERENCES OBRAS(id_obra),
    CONSTRAINT fk_elen_lector FOREIGN KEY (id_lector) REFERENCES LECTORES(id_lector),
    CONSTRAINT pk_elencos PRIMARY KEY (id_obra, id_lector)
)

CREATE TABLE MEJORES_ACTORES (
    id_obra_presentacion number(3,0) NOT NULL,
    id_fech_presentacion date NOT NULL,
    id_obra_elenco number(3,0) NOT NULL,
    id_lector number(5,0) NOT NULL,
    CONSTRAINT fk_mej_act_presentacion FOREIGN KEY (id_obra_presentacion, id_fech_presentacion) REFERENCES PRESENTACIONES(id_obra, fech_presentacion),
    CONSTRAINT fk_mej_act_elenco FOREIGN KEY (id_obra_elenco, id_lector) REFERENCES ELENCOS(id_obra, id_lector),
    CONSTRAINT pk_mejor_actores PRIMARY KEY (id_obra_presentacion, id_fech_presentacion, id_obra_elenco, id_lector)
)


CREATE TABLE HISTORICO_GRUPOS (
    id_club_grupo number(3,0) NOT NULL,
    id_grupo number(3,0) NOT NULL,
    id_club_soc number(3,0) NOT NULL,
    id_lector number(5,0) NOT NULL,
    fech_i_socio date NOT NULL,
    fech_i_hist_grupo date NOT NULL, 
    fech_f_hist_grupo date,
    CONSTRAINT fk_hist_grup_grupo FOREIGN KEY (id_club_grupo, id_grupo) REFERENCES GRUPOS(id_club, id_grupo),
    CONSTRAINT fk_hist_grup_socio FOREIGN KEY (id_club_soc, id_lector, fech_i_socio) REFERENCES SOCIOS(id_club, id_lector, fech_i_socio),
    CONSTRAINT pk_historico_grupos PRIMARY KEY (id_club_grupo, id_grupo, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo)
)

CREATE TABLE ASOCIACIONES (
    id_club1 number(3,0) NOT NULL,
    id_club2 number (3,0) NOT NULL,
    CONSTRAINT fk_asoc_club1 FOREIGN KEY (id_club1) REFERENCES CLUBES(id_club),
    CONSTRAINT fk_asoc_club2 FOREIGN KEY (id_club2) REFERENCES CLUBES(id_club),
    CONSTRAINT pk_asociaciones PRIMARY KEY (id_club1, id_club2)
)

CREATE TABLE LIBROS (
    isbn number(13,0) PRIMARY KEY,
    titulo_libro varchar2(30) NOT NULL,
    año_publicacion number(4,0) NOT NULL,
    cant_paginas number(4,0) NOT NULL,
    resumen varchar2(500) NOT NULL,
    sinopsis varchar2(500) NOT NULL,
    tema varchar2(20) NOT NULL,
    tipo_narrativa varchar2(7) NOT NULL,
    id_pais number(3,0) NOT NULL,
    isbn_lib_anterior number(13,0),
    CONSTRAINT fk_libr_pais FOREIGN KEY (id_pais) REFERENCES PAISES(id_pais),
    CONSTRAINT fk_libr_anterior FOREIGN KEY (isbn_lib_anterior) REFERENCES LIBROS(isbn)
)

CREATE TABLE REUNIONES_CALENDARIO (
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
    valoracion number(1,1), -- Valoración de 0.0 a 5.0
    ult_discusion varchar2(2), -- 'SI' o 'NO'
    CONSTRAINT fk_reun_grupo FOREIGN KEY (id_grupo, id_club) REFERENCES GRUPOS(id_grupo, id_eclub),
    CONSTRAINT fk_reun_libro FOREIGN KEY (isbn) REFERENCES LIBROS(isbn),
    CONSTRAINT fk_reun_historico_grupo FOREIGN KEY (id_club_hist, id_grupo_hist, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo) REFERENCES HISTORICO_GRUPOS(id_club_grupo, id_grupo, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo),
    CONSTRAINT pk_reuniones_calendario PRIMARY KEY (id_club, id_grupo, isbn, fech_reunion),
    CONSTRAINT chk_realizada CHECK (realizada IN ('SI', 'NO')),
    CONSTRAINT chk_ult_discusion CHECK (ult_discusion IN ('SI', 'NO') OR ult_discusion IS NULL),
    CONSTRAINT chk_valoracion CHECK (valoracion >= 0.0 AND valoracion <= 5.0)   
)

CREATE TABLE A_L (
    id_autor number(3,0) NOT NULL,
    isbn number(13,0) NOT NULL,
    CONSTRAINT fk_a_l_autor FOREIGN KEY (id_autor) REFERENCES AUTORES(id_autor),
    CONSTRAINT fk_a_l_libro FOREIGN KEY (isbn) REFERENCES LIBROS(isbn),
    CONSTRAINT pk_a_l PRIMARY KEY (id_autor, isbn)
)

CREATE TABLE REFERENCIAS(
    id_obra number(3,0) NOT NULL,
    isbn number(13,0) NOT NULL,
    CONSTRAINT fk_refe_obra FOREIGN KEY (id_obra) REFERENCES OBRAS(id_obra),
    CONSTRAINT fk_refe_libro FOREIGN KEY (isbn) REFERENCES LIBROS(isbn),
    CONSTRAINT pk_referencias PRIMARY KEY (id_obra, isbn)
)

CREATE TABLE INASISTENTES(
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
    CONSTRAINT fk_inas_reunion FOREIGN KEY (id_club_reu, id_grupo_reu, isbn, fech_reunion) REFERENCES REUNIONES_CALENDARIO(id_club, id_grupo, isbn, fech_reunion),
    CONSTRAINT fk_inas_historico FOREIGN KEY (id_club_hist, id_grupo_hist, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo) REFERENCES HISTORICO_GRUPOS(id_club_grupo, id_grupo, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo),
    CONSTRAINT pk_inasistentes PRIMARY KEY (id_club_reu, id_grupo_reu, isbn, fech_reunion, id_club_hist, id_grupo_hist, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo)
)

CREATE TABLE FAVORITOS (
    id_lector number(5,0) NOT NULL,
    isbn number(13,0) NOT NULL,
    orden number(1,0) NOT NULL,
    CONSTRAINT fk_favo_lector FOREIGN KEY (id_lector) REFERENCES LECTORES(id_lector),
    CONSTRAINT fk_favo_libro FOREIGN KEY (isbn) REFERENCES LIBROS(isbn),
    CONSTRAINT pk_favoritos PRIMARY KEY (id_lector, isbn, orden)
)
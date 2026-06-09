--=====================================================================
--                     ÍNDICES ESTRATÉGICOS (CRITERIOS LUCÍA)
-- 1. Tablas No Volátiles o Poco Volátiles (Maestras)
-- 2. Filtro Frecuente
-- 3. Selectividad < 2%
--=====================================================================

-- 1. Búsqueda de Países por Nombre
-- Tabla: PAISES (No volátil)
-- Selectividad: ~0.5% (1 entre 200 países)
CREATE INDEX idx_paises_nom ON PAISES(nom_pais);

-- 2. Búsqueda de Autores por Apellido
-- Tabla: AUTORES (Poco volátil)
-- Selectividad: < 1% en una base de datos extensa de autores
CREATE INDEX idx_autores_apellido ON AUTORES(p_apellido);

-- 3. Búsqueda de Instituciones por Nombre
-- Tabla: INSTITUCIONES (Poco volátil)
-- Selectividad: < 2% (Un club busca su institución específica)
CREATE INDEX idx_inst_nombre ON INSTITUCIONES(nom_inst);

-- 4. Búsqueda de Libros por Título
-- Tabla: LIBROS (Poco volátil - Tabla Maestra)
-- Selectividad: Muy alta (Un título específico es una fracción mínima)
CREATE INDEX idx_libros_titulo ON LIBROS(titulo_libro);

CREATE INDEX idx_fk_club_ciudades ON CIUDADES(id_pais);
--=================================================================
-- indexes para fks que no forman parte de pks

CREATE INDEX idx_fk_clubes_inst ON CLUBES(id_inst);

CREATE INDEX idx_fk_lectores_repr ON LECTORES(id_lector_representante);

CREATE INDEX idx_fk_obras_club ON OBRAS(id_club);

CREATE INDEX idx_fk_libros_pais ON LIBROS(id_pais);

CREATE INDEX idx_fk_libros_anterior ON LIBROS(isbn_lib_anterior);

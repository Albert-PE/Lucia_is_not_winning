--=====================================================================
--                            ÍNDICES
--=====================================================================


CREATE INDEX idx_paises_nom ON PAISES(nom_pais);

CREATE INDEX idx_autores_apellido ON AUTORES(p_apellido);

CREATE INDEX idx_inst_nombre ON INSTITUCIONES(nom_inst);

CREATE INDEX idx_libros_titulo ON LIBROS(titulo_libro);

CREATE INDEX idx_fk_club_ciudades ON CIUDADES(id_pais);

CREATE INDEX idx_fk_clubes_inst ON CLUBES(id_inst);

CREATE INDEX idx_fk_lectores_repr ON LECTORES(id_lector_representante);

CREATE INDEX idx_fk_obras_club ON OBRAS(id_club);

CREATE INDEX idx_fk_libros_pais ON LIBROS(id_pais);

CREATE INDEX idx_fk_libros_anterior ON LIBROS(isbn_lib_anterior);

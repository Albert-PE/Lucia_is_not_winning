--=====================================================================
--                            ÍNDICES
--=====================================================================


CREATE INDEX idx_paises_nom ON MEA_PAISES(nom_pais);

CREATE INDEX idx_autores_apellido ON MEA_AUTORES(p_apellido);

CREATE INDEX idx_inst_nombre ON MEA_INSTITUCIONES(nom_inst);

CREATE INDEX idx_libros_titulo ON MEA_LIBROS(titulo_libro);

CREATE INDEX idx_fk_club_ciudades ON MEA_CIUDADES(id_pais);

CREATE INDEX idx_fk_clubes_inst ON MEA_CLUBES(id_inst);

CREATE INDEX idx_fk_lectores_repr ON MEA_LECTORES(id_lector_repre);

CREATE INDEX idx_fk_obras_club ON MEA_OBRAS(id_club);

CREATE INDEX idx_fk_libros_pais ON MEA_LIBROS(id_pais);

CREATE INDEX idx_fk_libros_anterior ON MEA_LIBROS(isbn_lib_anterior);

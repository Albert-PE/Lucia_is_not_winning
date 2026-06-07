
Tablas Independientes

-- 1. Tabla: INSTITUCIONES
INSERT INTO instituciones (id_inst, nom_inst, tipo_inst) 
VALUES (seq_id_inst.NEXTVAL, 'Biblioteca Central de la Ciudad', 'biblioteca');

INSERT INTO instituciones (id_inst, nom_inst, tipo_inst) 
VALUES (seq_id_inst.NEXTVAL, 'Universidad de las Artes', 'universidad');

-- 2. Tabla: IDIOMAS
INSERT INTO idiomas (id_idioma, nom_idioma) 
VALUES (seq_id_idioma.NEXTVAL, 'Español');

INSERT INTO idiomas (id_idioma, nom_idioma) 
VALUES (seq_id_idioma.NEXTVAL, 'Inglés');

INSERT INTO idiomas (id_idioma, nom_idioma) 
VALUES (seq_id_idioma.NEXTVAL, 'Francés');

-- 3. Tabla: PAISES
INSERT INTO paises (id_pais, nom_pais, moneda, nacionalidad) 
VALUES (seq_id_pais.NEXTVAL, 'Venezuela', 'Bolívar', 'Venezolana');

INSERT INTO paises (id_pais, nom_pais, moneda, nacionalidad) 
VALUES (seq_id_pais.NEXTVAL, 'España', 'Euro', 'Española');

-- 4. Tabla: AUTORES
INSERT INTO autores (id_autor, p_nombre, s_nombre, p_apellido, s_apellido) 
VALUES (seq_id_autor.NEXTVAL, 'Miguel', 'de', 'Cervantes', 'Saavedra');

INSERT INTO autores (id_autor, p_nombre, s_nombre, p_apellido, s_apellido) 
VALUES (seq_id_autor.NEXTVAL, 'Gabriel', 'José', 'García', 'Márquez');


COMMIT;

--------------------------------------------------------------------------------
Tablas Dependientes

-- 5. Tabla: CIUDADES 
INSERT INTO ciudades (id_ciudad, id_pais, nom_ciudad) 
VALUES (seq_id_ciudad.NEXTVAL, 1, 'Caracas');

INSERT INTO ciudades (id_ciudad, id_pais, nom_ciudad) 
VALUES (seq_id_ciudad.NEXTVAL, 2, 'Madrid');

-- 6. Tabla: CLUBES 
INSERT INTO clubes (id_club, nombre_club, fecha_creacion, direccion, codigo_postal, cuota_membresia, id_institucion) 
VALUES (seq_id_club.NEXTVAL, 'Círculo de Lectores Ávila', TO_DATE('10-01-2024', 'DD-MM-YYYY'), 'Av. Principal de las Mercedes', 1060, 25.00, 1);

INSERT INTO clubes (id_club, nombre_club, fecha_creacion, direccion, codigo_postal, cuota_membresia, id_institucion) 
VALUES (seq_id_club.NEXTVAL, 'Club Juvenil León', TO_DATE('15-02-2024', 'DD-MM-YYYY'), 'Urb. La Castellana', 1061, 15.00, 3);

-- 7. Tabla: LECTORES 
INSERT INTO lectores (id_lector, doc_identidad, p_nombre, s_nombre, p_apellido, s_apellido, f_nacimiento, email) 
VALUES (seq_id_lector.NEXTVAL, 11222333, 'Juan', 'Carlos', 'Pérez', 'Rodríguez', TO_DATE('15-05-1985', 'DD-MM-YYYY'), 'juan.perez@email.com');

INSERT INTO lectores (id_lector, doc_identidad, p_nombre, s_nombre, p_apellido, s_apellido, f_nacimiento, email) 
VALUES (seq_id_lector.NEXTVAL, 22333444, 'María', 'Elena', 'García', 'López', TO_DATE('20-10-1992', 'DD-MM-YYYY'), 'maria.garcia@email.com');

-- 8. Tabla: OBRAS 
INSERT INTO obras (id_obra, nombre_obra, precio, status, id_club) 
VALUES (seq_id_obra.NEXTVAL, 'Cien Años de Soledad: El Drama', 5.99, 'activa', 1);

-- 9. Tabla: HABLAN 
INSERT INTO hablan (id_habla, id_idioma, id_lector) 
VALUES (seq_id_habla.NEXTVAL, 1, 1);

INSERT INTO hablan (id_habla, id_idioma, id_club) 
VALUES (seq_id_habla.NEXTVAL, 2, 1);


-- 10. Tabla: REPRESENTANTES 
INSERT INTO representantes (id_lector, id_represent, doc_identidad, p_nombre, p_apellido, s_apellido) 
VALUES (1, seq_id_represent.NEXTVAL, 5556667, 'Roberto', 'Pérez', 'Díaz');

-- 11. Tabla: TELÉFONOS 
INSERT INTO telefonos (cod_local, cod_area, num_tlf, id_club) 
VALUES (58, 212, 1234567, 1);

INSERT INTO telefonos (cod_local, cod_area, num_tlf, id_lector) 
VALUES (34, 91, 9876543, 2);

-- 12. Tabla: LIBROS 
INSERT INTO libros (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
VALUES (seq_isbn.NEXTVAL, 'Cien Años de Soledad', TO_DATE('05-06-1967', 'DD-MM-YYYY'), 471, 'Épica de la familia Buendía', 'Realismo mágico en Macondo', 'Saga Familiar', 'novela', 3);

-- 13. Tabla: ASOCIACIONES 
INSERT INTO asociaciones (id_club1, id_club2) 
VALUES (1, 2);

-- 14. Tabla: A_L 
INSERT INTO a_l (id_autor, isbn) 
VALUES (2, 1);

-- 15. Tabla: REFERENCIAS 
INSERT INTO referencias (id_libro, id_obra) 
VALUES (1, 1);

-- 16. Tabla: ELENCOS 
INSERT INTO elencos (id_obra, id_lector) 
VALUES (1, 1);

-- 17. Tabla: MEJORES_ACTORES 
INSERT INTO mejores_actores (id_presentacion, id_obra, id_elenco, id_lector) 
VALUES (SYSDATE, 1, 1, 1);

-- 18. Tabla: Favoritos
INSERT INTO favoritos (id_lector, id_libro, id_orden) 
VALUES (1, 1, seq_id_orden.NEXTVAL);

COMMIT;
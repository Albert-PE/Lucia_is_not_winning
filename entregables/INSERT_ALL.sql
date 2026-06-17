--=====================================================================
-- SCRIPT DE INSERCIÓN DE DATOS - VERSIÓN DEFINITIVA CORREGIDA
-- Proyecto: Clubes de Lectura (MEA)
--=====================================================================

SET DEFINE OFF

--=====================================================================
--                      TABLAS INDEPENDIENTES
--=====================================================================

-- 1. Tabla: INSTITUCIONES
INSERT INTO MEA_INSTITUCIONES (id_inst, nom_inst, tipo_inst) VALUES (MEA_seq_instituciones.NEXTVAL, 'Biblioteca Central de la Ciudad', 'biblioteca');
INSERT INTO MEA_INSTITUCIONES (id_inst, nom_inst, tipo_inst) VALUES (MEA_seq_instituciones.NEXTVAL, 'Universidad de las Artes', 'universidad');
INSERT INTO MEA_INSTITUCIONES (id_inst, nom_inst, tipo_inst) VALUES (MEA_seq_instituciones.NEXTVAL, 'Colegio Nacional Simón Bolívar', 'colegio');
INSERT INTO MEA_INSTITUCIONES (id_inst, nom_inst, tipo_inst) VALUES (MEA_seq_instituciones.NEXTVAL, 'Biblioteca Nacional de España', 'biblioteca');
INSERT INTO MEA_INSTITUCIONES (id_inst, nom_inst, tipo_inst) VALUES (MEA_seq_instituciones.NEXTVAL, 'Universidad de Islandia', 'universidad');
INSERT INTO MEA_INSTITUCIONES (id_inst, nom_inst, tipo_inst) VALUES (MEA_seq_instituciones.NEXTVAL, 'Trinity College Dublin', 'universidad');
INSERT INTO MEA_INSTITUCIONES (id_inst, nom_inst, tipo_inst) VALUES (MEA_seq_instituciones.NEXTVAL, 'Biblioteca de Estambul', 'biblioteca');
INSERT INTO MEA_INSTITUCIONES (id_inst, nom_inst, tipo_inst) VALUES (MEA_seq_instituciones.NEXTVAL, 'Colegio Erasmus de Ámsterdam', 'colegio');

-- 2. Tabla: IDIOMAS
INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) VALUES (MEA_seq_idiomas.NEXTVAL, 'Español');
INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) VALUES (MEA_seq_idiomas.NEXTVAL, 'Inglés');
INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) VALUES (MEA_seq_idiomas.NEXTVAL, 'Islandés');
INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) VALUES (MEA_seq_idiomas.NEXTVAL, 'Irlandés');
INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) VALUES (MEA_seq_idiomas.NEXTVAL, 'Turco');
INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) VALUES (MEA_seq_idiomas.NEXTVAL, 'Checo');
INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) VALUES (MEA_seq_idiomas.NEXTVAL, 'Portugués');
INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) VALUES (MEA_seq_idiomas.NEXTVAL, 'Neerlandés');
INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) VALUES (MEA_seq_idiomas.NEXTVAL, 'Afrikáans');
INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) VALUES (MEA_seq_idiomas.NEXTVAL, 'Francés');

-- 3. Tabla: PAISES
INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) VALUES (MEA_seq_paises.NEXTVAL, 'Venezuela', 'VED', 'Venezolana');
INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) VALUES (MEA_seq_paises.NEXTVAL, 'España', 'EUR', 'Española');
INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) VALUES (MEA_seq_paises.NEXTVAL, 'Islandia', 'ISK', 'Islandesa');
INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) VALUES (MEA_seq_paises.NEXTVAL, 'Irlanda', 'EUR', 'Irlandesa');
INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) VALUES (MEA_seq_paises.NEXTVAL, 'Turquía', 'TRY', 'Turca');
INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) VALUES (MEA_seq_paises.NEXTVAL, 'Países Bajos', 'EUR', 'Neerlandesa');
INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) VALUES (MEA_seq_paises.NEXTVAL, 'Sudáfrica', 'ZAR', 'Sudafricana');
INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) VALUES (MEA_seq_paises.NEXTVAL, 'Portugal', 'EUR', 'Portuguesa');
INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) VALUES (MEA_seq_paises.NEXTVAL, 'Canadá', 'CAD', 'Canadiense');
INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) VALUES (MEA_seq_paises.NEXTVAL, 'República Checa', 'CZK', 'Checa');
INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) VALUES (MEA_seq_paises.NEXTVAL, 'Argentina', 'ARS', 'Argentina');
INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) VALUES (MEA_seq_paises.NEXTVAL, 'Uruguay', 'UYU', 'Uruguaya');
INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) VALUES (MEA_seq_paises.NEXTVAL, 'Francia', 'EUR', 'Francesa');
INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) VALUES (MEA_seq_paises.NEXTVAL, 'Estados Unidos', 'USD', 'Estadounidense');
INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) VALUES (MEA_seq_paises.NEXTVAL, 'Reino Unido', 'GBP', 'Británica');

-- 4. Tabla: AUTORES
INSERT INTO MEA_AUTORES (id_autor, p_nombre, s_nombre, p_apellido, s_apellido) VALUES (MEA_seq_autores.NEXTVAL, 'Jorge', 'Luis', 'Borges', 'Acevedo');
INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido) VALUES (MEA_seq_autores.NEXTVAL, 'Mario', 'Benedetti');
INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido, s_apellido) VALUES (MEA_seq_autores.NEXTVAL, 'Manuel', 'Puig', 'Beltran');
INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido, s_apellido) VALUES (MEA_seq_autores.NEXTVAL, 'Julio', 'Verne', 'Gaignon');
INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido, s_apellido) VALUES (MEA_seq_autores.NEXTVAL, 'Herman', 'Melville', 'Philer');
INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido) VALUES (MEA_seq_autores.NEXTVAL, 'Neil', 'Gaiman');
INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido) VALUES (MEA_seq_autores.NEXTVAL, 'Stephen', 'Chbosky');
INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido) VALUES (MEA_seq_autores.NEXTVAL, 'Rainbow', 'Rowell');
INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido) VALUES (MEA_seq_autores.NEXTVAL, 'Ernest', 'Cline');
INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido) VALUES (MEA_seq_autores.NEXTVAL, 'Andy', 'Weir');
INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido) VALUES (MEA_seq_autores.NEXTVAL, 'Matt', 'Haig');
INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido, s_apellido) VALUES (MEA_seq_autores.NEXTVAL, 'Taylor', 'Jenkins', 'Reid');
INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido, s_apellido) VALUES (MEA_seq_autores.NEXTVAL, 'Laura', 'Gallego', 'García');

COMMIT;

--=====================================================================
--                      TABLAS DEPENDIENTES
--=====================================================================

-- 5. Tabla: CIUDADES 
INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) VALUES (MEA_seq_ciudades.NEXTVAL, 1, 'Caracas');
INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) VALUES (MEA_seq_ciudades.NEXTVAL, 2, 'Madrid');
INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) VALUES (MEA_seq_ciudades.NEXTVAL, 3, 'Reikiavik');
INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) VALUES (MEA_seq_ciudades.NEXTVAL, 3, 'Akureyri');
INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) VALUES (MEA_seq_ciudades.NEXTVAL, 3, 'Reykjanesbær');
INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) VALUES (MEA_seq_ciudades.NEXTVAL, 4, 'Dublín');
INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) VALUES (MEA_seq_ciudades.NEXTVAL, 4, 'Galway');
INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) VALUES (MEA_seq_ciudades.NEXTVAL, 4, 'Cork');
INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) VALUES (MEA_seq_ciudades.NEXTVAL, 5, 'Estambul');
INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) VALUES (MEA_seq_ciudades.NEXTVAL, 5, 'Ankara');
INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) VALUES (MEA_seq_ciudades.NEXTVAL, 5, 'Esmirna');
INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) VALUES (MEA_seq_ciudades.NEXTVAL, 6, 'Ámsterdam');
INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) VALUES (MEA_seq_ciudades.NEXTVAL, 7, 'Ciudad del Cabo');
INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) VALUES (MEA_seq_ciudades.NEXTVAL, 8, 'Lisboa');
INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) VALUES (MEA_seq_ciudades.NEXTVAL, 9, 'Toronto');
INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) VALUES (MEA_seq_ciudades.NEXTVAL, 10, 'Praga');

-- 6. Tabla: CLUBES 
INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad, cuota_membresia)
VALUES (MEA_seq_clubes.NEXTVAL, 'Círculo de Lectura del Fin del Mundo', TO_DATE('10-01-2024', 'DD-MM-YYYY'), 'Calle Falsa 1','1060', 3, 4, 25.00);
INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
VALUES (MEA_seq_clubes.NEXTVAL, 'Sagas de Reikiavik', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 2','2050', 3, 3);
INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
VALUES (MEA_seq_clubes.NEXTVAL, 'La Tertulia del Faro', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 3','4861', 4, 6);
INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
VALUES (MEA_seq_clubes.NEXTVAL, 'Trébol Literario de Dublín', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 10','4868', 4, 6);
INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
VALUES (MEA_seq_clubes.NEXTVAL, 'Lectores del Bósforo', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 4','4862', 5, 10);
INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
VALUES (MEA_seq_clubes.NEXTVAL, 'Bazar de Libros de Estambul', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 11','4869', 5, 9);
INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
VALUES (MEA_seq_clubes.NEXTVAL, 'El Club de los Libros Olvidados', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 5','4863', 6, 12);
INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
VALUES (MEA_seq_clubes.NEXTVAL, 'Sociedad de Lectura del Cabo', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 6','4864', 7, 13);
INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
VALUES (MEA_seq_clubes.NEXTVAL, 'Hermandad de la Tinta Verde', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 7','4865', 8, 14);
INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
VALUES (MEA_seq_clubes.NEXTVAL, 'Los Nómadas del Papel', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 8','4866', 9, 15);
INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
VALUES (MEA_seq_clubes.NEXTVAL, 'Café Literario de Praga', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 9','4867', 10, 16);
INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
VALUES (MEA_seq_clubes.NEXTVAL, 'Bohemia Literaria', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 12','4870', 10, 16);
INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
VALUES (MEA_seq_clubes.NEXTVAL, 'Club Canadiense de Toronto', SYSDATE, 'Dirección 13','M5V', 9, 15);
INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
VALUES (MEA_seq_clubes.NEXTVAL, 'Club Portugués de Lisboa', SYSDATE, 'Dirección 14','1000', 8, 14);
INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
VALUES (MEA_seq_clubes.NEXTVAL, 'Club Sudafricano de Ciudad del Cabo', SYSDATE, 'Dirección 15','8001', 7, 13);

-- 7. Tabla: LECTORES 
INSERT INTO MEA_LECTORES (id_lector, doc_identidad, p_nombre, s_nombre, p_apellido, s_apellido, f_nacimiento, email) 
VALUES (MEA_seq_lectores.NEXTVAL, 11222333, 'Juan', 'Carlos', 'Pérez', 'Rodríguez', TO_DATE('15-05-1985', 'DD-MM-YYYY'), 'juan.perez@email.com');
INSERT INTO MEA_LECTORES (id_lector, doc_identidad, p_nombre, s_nombre, p_apellido, s_apellido, f_nacimiento, email) 
VALUES (MEA_seq_lectores.NEXTVAL, 22333444, 'María', 'Elena', 'García', 'López', TO_DATE('20-10-1992', 'DD-MM-YYYY'), 'maria.garcia@email.com');
INSERT INTO MEA_LECTORES (id_lector, doc_identidad, p_nombre, s_nombre, p_apellido, s_apellido, f_nacimiento, email) 
VALUES (MEA_seq_lectores.NEXTVAL, 33444555, 'Carlos', 'Alberto', 'Martínez', 'Suárez', TO_DATE('03-08-1978', 'DD-MM-YYYY'), 'carlos.martinez@email.com');
INSERT INTO MEA_LECTORES (id_lector, doc_identidad, p_nombre, s_nombre, p_apellido, s_apellido, f_nacimiento, email) 
VALUES (MEA_seq_lectores.NEXTVAL, 44555666, 'Ana', 'Sofía', 'Hernández', 'Ruiz', TO_DATE('12-03-1990', 'DD-MM-YYYY'), 'ana.hernandez@email.com');
INSERT INTO MEA_LECTORES (id_lector, doc_identidad, p_nombre, s_nombre, p_apellido, s_apellido, f_nacimiento, email) 
VALUES (MEA_seq_lectores.NEXTVAL, 55666777, 'Pedro', 'Luis', 'González', 'Díaz', TO_DATE('25-07-2000', 'DD-MM-YYYY'), 'pedro.gonzalez@email.com');
INSERT INTO MEA_LECTORES (id_lector, doc_identidad, p_nombre, s_nombre, p_apellido, s_apellido, f_nacimiento, email) 
VALUES (MEA_seq_lectores.NEXTVAL, 66777888, 'Lucía', 'María', 'Torres', 'Vargas', TO_DATE('18-11-1982', 'DD-MM-YYYY'), 'lucia.torres@email.com');
INSERT INTO MEA_LECTORES (id_lector, doc_identidad, p_nombre, s_nombre, p_apellido, s_apellido, f_nacimiento, email) 
VALUES (MEA_seq_lectores.NEXTVAL, 77888999, 'Diego', 'Andrés', 'Flores', 'Mora', TO_DATE('30-01-1995', 'DD-MM-YYYY'), 'diego.flores@email.com');
INSERT INTO MEA_LECTORES (id_lector, doc_identidad, p_nombre, s_nombre, p_apellido, s_apellido, f_nacimiento, email) 
VALUES (MEA_seq_lectores.NEXTVAL, 88999000, 'Elena', 'Isabel', 'Ramos', 'Castro', TO_DATE('05-09-1988', 'DD-MM-YYYY'), 'elena.ramos@email.com');
INSERT INTO MEA_LECTORES (id_lector, doc_identidad, p_nombre, s_nombre, p_apellido, s_apellido, f_nacimiento, email) 
VALUES (MEA_seq_lectores.NEXTVAL, 99222333, 'Alejandro', 'Javier', 'Ruiz', 'Pérez', TO_DATE('20-04-1981', 'DD-MM-YYYY'), 'alejandro.ruiz@email.com');
INSERT INTO MEA_LECTORES (id_lector, doc_identidad, p_nombre, s_nombre, p_apellido, s_apellido, f_nacimiento, email) 
VALUES (MEA_seq_lectores.NEXTVAL, 99333444, 'Valeria', 'Camila', 'Gómez', 'López', TO_DATE('05-11-1984', 'DD-MM-YYYY'), 'valeria.gomez@email.com');
INSERT INTO MEA_LECTORES (id_lector, doc_identidad, p_nombre, s_nombre, p_apellido, s_apellido, f_nacimiento, email, id_lector_repre) 
VALUES (MEA_seq_lectores.NEXTVAL, 99000111, 'Mateo', 'Alejandro', 'Ruiz', 'Gómez', TO_DATE('10-02-2009', 'DD-MM-YYYY'), 'mateo.ruiz@email.com', 7);
INSERT INTO MEA_LECTORES (id_lector, doc_identidad, p_nombre, s_nombre, p_apellido, s_apellido, f_nacimiento, email, id_lector_repre) 
VALUES (MEA_seq_lectores.NEXTVAL, 99111222, 'Valentina', 'Isabella', 'Ruiz', 'Gómez', TO_DATE('15-08-2015', 'DD-MM-YYYY'), 'valentina.ruiz@email.com', 8);

-- 8. Tabla: OBRAS 
INSERT INTO MEA_OBRAS (id_obra, nombre_obra, precio, status_obra, id_club) 
VALUES (MEA_seq_obras.NEXTVAL, 'Cien Años de Soledad: El Drama', 5.99, 'activa', 1);
INSERT INTO MEA_OBRAS (id_obra, nombre_obra, precio, status_obra, id_club) 
VALUES (MEA_seq_obras.NEXTVAL, 'Hamlet en la Niebla', 7.50, 'activa', 2);
INSERT INTO MEA_OBRAS (id_obra, nombre_obra, precio, status_obra, id_club) 
VALUES (MEA_seq_obras.NEXTVAL, 'El Sueño de una Noche de Verano', 6.00, 'activa', 3);
INSERT INTO MEA_OBRAS (id_obra, nombre_obra, precio, status_obra, id_club) 
VALUES (MEA_seq_obras.NEXTVAL, 'Los Miserables: Adaptación', 8.99, 'activa', 4);
INSERT INTO MEA_OBRAS (id_obra, nombre_obra, precio, status_obra, id_club) 
VALUES (MEA_seq_obras.NEXTVAL, 'La Casa de los Espíritus', 5.50, 'inactiva', 5);
INSERT INTO MEA_OBRAS (id_obra, nombre_obra, precio, status_obra, id_club) 
VALUES (MEA_seq_obras.NEXTVAL, 'Esperando a Godot', 4.99, 'activa', 6);
INSERT INTO MEA_OBRAS (id_obra, nombre_obra, precio, status_obra, id_club) 
VALUES (MEA_seq_obras.NEXTVAL, 'La Vida es Sueño', 6.50, 'activa', 7);
INSERT INTO MEA_OBRAS (id_obra, nombre_obra, precio, status_obra, id_club) 
VALUES (MEA_seq_obras.NEXTVAL, 'Bodas de Sangre', 5.00, 'activa', 8);

-- 9. Tabla: HABLAN 
INSERT INTO MEA_HABLAN (id_habla, id_idioma, id_lector) VALUES (MEA_seq_hablan.NEXTVAL, 1, 1);
INSERT INTO MEA_HABLAN (id_habla, id_idioma, id_club) VALUES (MEA_seq_hablan.NEXTVAL, 2, 1);
INSERT INTO MEA_HABLAN (id_habla, id_idioma, id_lector) VALUES (MEA_seq_hablan.NEXTVAL, 3, 3);
INSERT INTO MEA_HABLAN (id_habla, id_idioma, id_club) VALUES (MEA_seq_hablan.NEXTVAL, 3, 1);
INSERT INTO MEA_HABLAN (id_habla, id_idioma, id_lector) VALUES (MEA_seq_hablan.NEXTVAL, 4, 4);
INSERT INTO MEA_HABLAN (id_habla, id_idioma, id_club) VALUES (MEA_seq_hablan.NEXTVAL, 5, 3);
INSERT INTO MEA_HABLAN (id_habla, id_idioma, id_lector) VALUES (MEA_seq_hablan.NEXTVAL, 6, 5);
INSERT INTO MEA_HABLAN (id_habla, id_idioma, id_club) VALUES (MEA_seq_hablan.NEXTVAL, 7, 6);

-- 10. Tabla: REPRESENTANTES 
INSERT INTO MEA_REPRESENTANTES (id_lector, id_representante, doc_identidad, p_nombre, p_apellido, s_apellido) 
VALUES (1, MEA_seq_representantes.NEXTVAL, 5556667, 'Roberto', 'Pérez', 'Díaz');
INSERT INTO MEA_REPRESENTANTES (id_lector, id_representante, doc_identidad, p_nombre, p_apellido, s_apellido) 
VALUES (3, MEA_seq_representantes.NEXTVAL, 12345678, 'Marta', 'Fernández', 'López');
INSERT INTO MEA_REPRESENTANTES (id_lector, id_representante, doc_identidad, p_nombre, p_apellido, s_apellido) 
VALUES (4, MEA_seq_representantes.NEXTVAL, 23456789, 'José', 'Gutiérrez', 'Soto');
INSERT INTO MEA_REPRESENTANTES (id_lector, id_representante, doc_identidad, p_nombre, p_apellido, s_apellido) 
VALUES (5, MEA_seq_representantes.NEXTVAL, 34567890, 'Carmen', 'Jiménez', 'Ortega');
INSERT INTO MEA_REPRESENTANTES (id_lector, id_representante, doc_identidad, p_nombre, p_apellido, s_apellido) 
VALUES (6, MEA_seq_representantes.NEXTVAL, 56789012, 'Isabel', 'Navarro', 'Medina');
INSERT INTO MEA_REPRESENTANTES (id_lector, id_representante, doc_identidad, p_nombre, p_apellido, s_apellido) 
VALUES (7, MEA_seq_representantes.NEXTVAL, 67890123, 'Antonio', 'Romero', 'Herrera');
INSERT INTO MEA_REPRESENTANTES (id_lector, id_representante, doc_identidad, p_nombre, p_apellido, s_apellido) 
VALUES (8, MEA_seq_representantes.NEXTVAL, 78901234, 'Sofía', 'Domínguez', 'Rivas');

-- 11. Tabla: TELÉFONOS 
INSERT INTO MEA_TELEFONOS (cod_local, cod_area, num_tlf, id_club) VALUES (58, 212, 1234567, 1);
INSERT INTO MEA_TELEFONOS (cod_local, cod_area, num_tlf, id_lector) VALUES (34, 91, 9876543, 2);
INSERT INTO MEA_TELEFONOS (cod_local, cod_area, num_tlf, id_club) VALUES (354, 123, 4567890, 2);
INSERT INTO MEA_TELEFONOS (cod_local, cod_area, num_tlf, id_lector) VALUES (353, 1, 2345678, 3);
INSERT INTO MEA_TELEFONOS (cod_local, cod_area, num_tlf, id_club) VALUES (90, 212, 3456789, 3);
INSERT INTO MEA_TELEFONOS (cod_local, cod_area, num_tlf, id_lector) VALUES (31, 20, 4567890, 4);
INSERT INTO MEA_TELEFONOS (cod_local, cod_area, num_tlf, id_club) VALUES (27, 21, 5678901, 5);
INSERT INTO MEA_TELEFONOS (cod_local, cod_area, num_tlf, id_club) VALUES (351, 21, 6789012, 6);

-- 12. Tabla: LIBROS 
INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
VALUES (9788420633114, 'El Aleph', 1949, 152, 'Borges nos guía por relatos donde el tiempo, la inmortalidad y los laberintos son protagonistas.', 'Obra cumbre de la literatura fantástica.', 'Ficción filosófica', 'Cuentos', 11);
INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
VALUES (9788420633121, 'Ficciones', 1944, 192, 'Colección dividida en "El jardín de senderos que se bifurcan" y "Artificios".', 'Un hito del cuento moderno.', 'Realismo mágico', 'Cuentos', 11);
INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
VALUES (9788420423852, 'La tregua', 1960, 216, 'Martín Santomé, un viudo a punto de jubilarse.', 'Exploración conmovedora sobre la rutina.', 'Rutina y esperanza', 'Novela', 12);
INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
VALUES (9788432219764, 'El beso de la mujer araña', 1976, 288, 'En una celda argentina, dos presos muy distintos.', 'Crítica a la represión política y sexual.', 'Opresión/Libertad', 'Novela', 11);
INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
VALUES (9788420600734, 'La vuelta al mundo en 80 días', 1872, 320, 'Phileas Fogg apuesta su fortuna.', 'Clásico de aventuras.', 'Aventura/Progreso', 'Novela', 13);
INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
VALUES (9788420653068, 'Moby Dick', 1851, 824, 'Ismael se embarca en el ballenero Pequod.', 'Epopeya monumental.', 'Venganza y obsesión', 'Novela', 14);
INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
VALUES (9788498380811, 'Coraline', 2002, 160, 'Al mudarse a una nueva casa, Coraline descubre una puerta.', 'Relato sobre la valentía.', 'Fantasía oscura', 'Novela', 15);
INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
VALUES (9788415594048, 'El libro del cementerio', 2008, 304, 'Tras el asesinato de su familia, el bebé Nadie escapa.', 'Reimaginación de "El libro de la selva".', 'Fantasía juvenil', 'Novela', 15);
INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
VALUES (9786073111451, 'Las ventajas de ser invisible', 1999, 224, 'Charlie es un adolescente solitario.', 'Honesta historia de maduración.', 'Salud mental/Amor', 'Novela', 14);
INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
VALUES (9788420415703, 'Eleanor y Park', 2012, 336, 'Dos adolescentes inadaptados en los años 80.', 'Exploración del amor juvenil.', 'Primer amor', 'Novela', 14);
INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
VALUES (9788466649176, 'Ready Player One', 2011, 464, 'En un futuro distópico, la humanidad se refugia en OASIS.', 'Carta de amor a la cultura pop.', 'Realidad virtual', 'Novela', 14);
INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
VALUES (9788466655054, 'El marciano', 2011, 400, 'El astronauta Mark Watney es dado por muerto.', 'Thriller de ciencia ficción.', 'Supervivencia', 'Novela', 14);
INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
VALUES (9788418037130, 'Project Hail Mary', 2021, 496, 'Ryland Grace despierta sin memoria.', 'Fascinante odisea interestelar.', 'Cooperación y vida', 'Novela', 14);
INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
VALUES (9788412275957, 'La biblioteca de la medianoche', 2020, 336, 'Nora Seed intenta terminar con su vida.', 'Reflexión sobre posibilidades de la existencia.', 'Arrepentimiento', 'Novela', 15);
INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
VALUES (9788416327855, 'Los 7 maridos de Evelyn Hugo', 2017, 400, 'La mítica estrella Evelyn Hugo revela su biografía.', 'Retrato del glamour clásico.', 'Fama y ambición', 'Novela', 14);
INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
VALUES (9788467550037, 'Donde los árboles cantan', 2011, 480, 'Viana ve su vida destruida por bárbaros.', 'Historia de empoderamiento y magia.', 'Fantasía épica', 'Novela', 2);

-- 13. Tabla: ASOCIACIONES 
INSERT INTO MEA_ASOCIACIONES (id_club1, id_club2) VALUES (1, 2);
INSERT INTO MEA_ASOCIACIONES (id_club1, id_club2) VALUES (1, 3);
INSERT INTO MEA_ASOCIACIONES (id_club1, id_club2) VALUES (2, 4);
INSERT INTO MEA_ASOCIACIONES (id_club1, id_club2) VALUES (3, 5);
INSERT INTO MEA_ASOCIACIONES (id_club1, id_club2) VALUES (4, 6);
INSERT INTO MEA_ASOCIACIONES (id_club1, id_club2) VALUES (5, 7);
INSERT INTO MEA_ASOCIACIONES (id_club1, id_club2) VALUES (6, 8);
INSERT INTO MEA_ASOCIACIONES (id_club1, id_club2) VALUES (1, 8);

-- 14. Tabla: A_L 
INSERT INTO MEA_A_L (id_autor, isbn) VALUES (2, 9788420633114);
INSERT INTO MEA_A_L (id_autor, isbn) VALUES (2, 9788420633121);
INSERT INTO MEA_A_L (id_autor, isbn) VALUES (3, 9788420423852);
INSERT INTO MEA_A_L (id_autor, isbn) VALUES (4, 9788432219764);
INSERT INTO MEA_A_L (id_autor, isbn) VALUES (5, 9788420600734);
INSERT INTO MEA_A_L (id_autor, isbn) VALUES (6, 9788420653068);
INSERT INTO MEA_A_L (id_autor, isbn) VALUES (7, 9788498380811);
INSERT INTO MEA_A_L (id_autor, isbn) VALUES (7, 9788415594048);
INSERT INTO MEA_A_L (id_autor, isbn) VALUES (8, 9786073111451);
INSERT INTO MEA_A_L (id_autor, isbn) VALUES (9, 9788420415703);
INSERT INTO MEA_A_L (id_autor, isbn) VALUES (10, 9788466649176);
INSERT INTO MEA_A_L (id_autor, isbn) VALUES (11, 9788466655054);
INSERT INTO MEA_A_L (id_autor, isbn) VALUES (11, 9788418037130);
INSERT INTO MEA_A_L (id_autor, isbn) VALUES (12, 9788412275957);
INSERT INTO MEA_A_L (id_autor, isbn) VALUES (13, 9788416327855);

-- 15. Tabla: REFERENCIAS 
INSERT INTO MEA_REFERENCIAS (isbn, id_obra) VALUES (9788420633114, 1);
INSERT INTO MEA_REFERENCIAS (isbn, id_obra) VALUES (9788420633121, 2);
INSERT INTO MEA_REFERENCIAS (isbn, id_obra) VALUES (9788420423852, 3);
INSERT INTO MEA_REFERENCIAS (isbn, id_obra) VALUES (9788432219764, 4);
INSERT INTO MEA_REFERENCIAS (isbn, id_obra) VALUES (9788498380811, 5);
INSERT INTO MEA_REFERENCIAS (isbn, id_obra) VALUES (9788415594048, 6);
INSERT INTO MEA_REFERENCIAS (isbn, id_obra) VALUES (9788466649176, 7);
INSERT INTO MEA_REFERENCIAS (isbn, id_obra) VALUES (9788466655054, 8);

-- 16. Tabla: ELENCOS 
INSERT INTO MEA_ELENCOS (id_obra, id_lector) VALUES (1, 1);
INSERT INTO MEA_ELENCOS (id_obra, id_lector) VALUES (1, 2);
INSERT INTO MEA_ELENCOS (id_obra, id_lector) VALUES (2, 3);
INSERT INTO MEA_ELENCOS (id_obra, id_lector) VALUES (2, 4);
INSERT INTO MEA_ELENCOS (id_obra, id_lector) VALUES (3, 5);
INSERT INTO MEA_ELENCOS (id_obra, id_lector) VALUES (3, 1);
INSERT INTO MEA_ELENCOS (id_obra, id_lector) VALUES (4, 2);
INSERT INTO MEA_ELENCOS (id_obra, id_lector) VALUES (5, 6);

-- 17. Tabla: Favoritos
INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (1, 9788418037130, 1);
INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (1, 9788420633121, 2);
INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (1, 9788420423852, 3);
INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (2, 9788420423852, 1);
INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (2, 9788466649176, 2);
INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (2, 9788498380811, 3);
INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (3, 9788466649176, 1);
INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (3, 9788466655054, 2);
INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (3, 9788420423852, 3);
INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (4, 9788415594048, 1);
INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (4, 9788466649176, 2);
INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (4, 9788466655054, 3);
INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (5, 9788418037130, 1);
INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (5, 9788466649176, 2);
INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (5, 9788466655054, 3);
INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (6, 9788416327855, 1);
INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (6, 9788418037130, 2);
INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) VALUES (6, 9788466649176, 3);

-- 18. Tabla: GRUPOS
-- Club 1 (Lunes=2, Martes=3, Miércoles=4, Jueves=5, Viernes=6)
INSERT INTO MEA_GRUPOS VALUES (1, 3, TO_DATE('01-03-2024','DD-MM-YYYY'), 'infantil', 4, 17); -- Miércoles
INSERT INTO MEA_GRUPOS VALUES (1, 4, TO_DATE('01-04-2024','DD-MM-YYYY'), 'adulto', 6, 19);   -- Viernes
INSERT INTO MEA_GRUPOS VALUES (1, 5, TO_DATE('01-05-2024','DD-MM-YYYY'), 'joven', 2, 18);    -- Lunes
-- Club 2
INSERT INTO MEA_GRUPOS VALUES (2, 1, TO_DATE('11-01-2004','DD-MM-YYYY'), 'adulto', 3, 18); -- Martes
INSERT INTO MEA_GRUPOS VALUES (2, 2, TO_DATE('11-01-2004','DD-MM-YYYY'), 'joven', 5, 17);  -- Jueves
INSERT INTO MEA_GRUPOS VALUES (2, 3, TO_DATE('01-03-2004','DD-MM-YYYY'), 'infantil', 4, 18);
INSERT INTO MEA_GRUPOS VALUES (2, 4, TO_DATE('01-06-2004','DD-MM-YYYY'), 'adulto', 2, 19);
INSERT INTO MEA_GRUPOS VALUES (2, 5, TO_DATE('01-09-2004','DD-MM-YYYY'), 'joven', 6, 17);
-- Club 3
INSERT INTO MEA_GRUPOS VALUES (3, 1, TO_DATE('11-01-2004','DD-MM-YYYY'), 'adulto', 4, 18); -- Miércoles
INSERT INTO MEA_GRUPOS VALUES (3, 2, TO_DATE('11-01-2004','DD-MM-YYYY'), 'joven', 2, 17);  -- Lunes
INSERT INTO MEA_GRUPOS VALUES (3, 3, TO_DATE('01-04-2004','DD-MM-YYYY'), 'adulto', 5, 19);
INSERT INTO MEA_GRUPOS VALUES (3, 4, TO_DATE('01-07-2004','DD-MM-YYYY'), 'infantil', 3, 18);
INSERT INTO MEA_GRUPOS VALUES (3, 5, TO_DATE('01-10-2004','DD-MM-YYYY'), 'joven', 6, 17);
-- Club 4
INSERT INTO MEA_GRUPOS VALUES (4, 1, TO_DATE('11-01-2004','DD-MM-YYYY'), 'adulto', 3, 18); -- Martes
INSERT INTO MEA_GRUPOS VALUES (4, 2, TO_DATE('11-01-2004','DD-MM-YYYY'), 'joven', 5, 17);
INSERT INTO MEA_GRUPOS VALUES (4, 3, TO_DATE('01-05-2004','DD-MM-YYYY'), 'adulto', 4, 19);
INSERT INTO MEA_GRUPOS VALUES (4, 4, TO_DATE('01-08-2004','DD-MM-YYYY'), 'infantil', 2, 18);
INSERT INTO MEA_GRUPOS VALUES (4, 5, TO_DATE('01-11-2004','DD-MM-YYYY'), 'joven', 6, 17);
-- Clubes del 5 al 12
INSERT INTO MEA_GRUPOS VALUES (5, 1, TO_DATE('01-01-2024','DD-MM-YYYY'), 'adulto', 4, 18);
INSERT INTO MEA_GRUPOS VALUES (6, 1, TO_DATE('01-01-2024','DD-MM-YYYY'), 'adulto', 3, 18);
INSERT INTO MEA_GRUPOS VALUES (7, 1, TO_DATE('01-01-2024','DD-MM-YYYY'), 'adulto', 4, 18);
INSERT INTO MEA_GRUPOS VALUES (8, 1, TO_DATE('01-01-2024','DD-MM-YYYY'), 'adulto', 3, 18);
INSERT INTO MEA_GRUPOS VALUES (9, 1, TO_DATE('01-01-2024','DD-MM-YYYY'), 'adulto', 4, 18);
INSERT INTO MEA_GRUPOS VALUES (10, 1, TO_DATE('01-01-2024','DD-MM-YYYY'), 'adulto', 3, 18);
INSERT INTO MEA_GRUPOS VALUES (11, 1, TO_DATE('01-01-2024','DD-MM-YYYY'), 'adulto', 4, 18);
INSERT INTO MEA_GRUPOS VALUES (12, 1, TO_DATE('01-01-2024','DD-MM-YYYY'), 'adulto', 3, 18);
-- Clubes nuevos 13, 14, 15
INSERT INTO MEA_GRUPOS VALUES (13, 1, TO_DATE('15-03-2020','DD-MM-YYYY'), 'adulto', 4, 18);
INSERT INTO MEA_GRUPOS VALUES (14, 1, TO_DATE('01-09-2019','DD-MM-YYYY'), 'adulto', 3, 18);
INSERT INTO MEA_GRUPOS VALUES (15, 1, TO_DATE('20-06-2021','DD-MM-YYYY'), 'adulto', 4, 18);

-- 19. Tabla: SOCIOS
INSERT INTO MEA_SOCIOS VALUES (1, 1, TO_DATE('10-01-2024','DD-MM-YYYY'), 'activo', NULL, NULL);
INSERT INTO MEA_SOCIOS VALUES (1, 2, TO_DATE('10-01-2024','DD-MM-YYYY'), 'activo', NULL, NULL);
INSERT INTO MEA_SOCIOS VALUES (2, 3, TO_DATE('11-01-2004','DD-MM-YYYY'), 'activo', NULL, NULL);
INSERT INTO MEA_SOCIOS VALUES (2, 4, TO_DATE('11-01-2004','DD-MM-YYYY'), 'activo', NULL, NULL);
INSERT INTO MEA_SOCIOS VALUES (3, 5, TO_DATE('11-01-2004','DD-MM-YYYY'), 'activo', NULL, NULL);
INSERT INTO MEA_SOCIOS VALUES (3, 6, TO_DATE('11-01-2004','DD-MM-YYYY'), 'inactivo', TO_DATE('01-06-2025','DD-MM-YYYY'), 'deuda');
INSERT INTO MEA_SOCIOS VALUES (4, 7, TO_DATE('11-01-2004','DD-MM-YYYY'), 'activo', NULL, NULL);
INSERT INTO MEA_SOCIOS VALUES (4, 8, TO_DATE('11-01-2004','DD-MM-YYYY'), 'activo', NULL, NULL);

COMMIT;

-- 20. Tabla: HISTORICO_GRUPOS
INSERT INTO MEA_HISTORICO_GRUPOS VALUES (1, 3, 1, 1, TO_DATE('10-01-2024','DD-MM-YYYY'), TO_DATE('10-01-2024','DD-MM-YYYY'), NULL);
INSERT INTO MEA_HISTORICO_GRUPOS VALUES (1, 3, 1, 2, TO_DATE('10-01-2024','DD-MM-YYYY'), TO_DATE('10-01-2024','DD-MM-YYYY'), NULL);
INSERT INTO MEA_HISTORICO_GRUPOS VALUES (2, 1, 2, 3, TO_DATE('11-01-2004','DD-MM-YYYY'), TO_DATE('11-01-2004','DD-MM-YYYY'), NULL);
INSERT INTO MEA_HISTORICO_GRUPOS VALUES (2, 1, 2, 4, TO_DATE('11-01-2004','DD-MM-YYYY'), TO_DATE('11-01-2004','DD-MM-YYYY'), NULL);
INSERT INTO MEA_HISTORICO_GRUPOS VALUES (3, 1, 3, 5, TO_DATE('11-01-2004','DD-MM-YYYY'), TO_DATE('11-01-2004','DD-MM-YYYY'), NULL);
INSERT INTO MEA_HISTORICO_GRUPOS VALUES (3, 2, 3, 6, TO_DATE('11-01-2004','DD-MM-YYYY'), TO_DATE('11-01-2004','DD-MM-YYYY'), NULL);
INSERT INTO MEA_HISTORICO_GRUPOS VALUES (4, 1, 4, 7, TO_DATE('11-01-2004','DD-MM-YYYY'), TO_DATE('11-01-2004','DD-MM-YYYY'), NULL);
INSERT INTO MEA_HISTORICO_GRUPOS VALUES (4, 1, 4, 8, TO_DATE('11-01-2004','DD-MM-YYYY'), TO_DATE('11-01-2004','DD-MM-YYYY'), NULL);

COMMIT;

-- 21. Tabla: REUNIONES_CALENDARIO
-- 2026-06-17 = Miércoles (Día 4)
INSERT INTO MEA_REUNIONES_CALENDARIO VALUES (1, 3, 9788420633114, TO_DATE('17-06-2026','DD-MM-YYYY'), 'SI', 1, 3, 1, 1, TO_DATE('10-01-2024','DD-MM-YYYY'), TO_DATE('10-01-2024','DD-MM-YYYY'), 'Buena discusión', 4.5, 'NO');
-- 2026-06-24 = Miércoles (Día 4)
INSERT INTO MEA_REUNIONES_CALENDARIO VALUES (1, 3, 9788420633121, TO_DATE('24-06-2026','DD-MM-YYYY'), 'SI', 1, 3, 1, 2, TO_DATE('10-01-2024','DD-MM-YYYY'), TO_DATE('10-01-2024','DD-MM-YYYY'), NULL, 4.0, 'SI');
-- 2026-06-09 = Martes (Día 3)
INSERT INTO MEA_REUNIONES_CALENDARIO VALUES (2, 1, 9788420423852, TO_DATE('09-06-2026','DD-MM-YYYY'), 'SI', 2, 1, 2, 3, TO_DATE('11-01-2004','DD-MM-YYYY'), TO_DATE('11-01-2004','DD-MM-YYYY'), 'Muy emotiva', 5.0, 'NO');
-- 2026-06-16 = Martes (Día 3)
INSERT INTO MEA_REUNIONES_CALENDARIO VALUES (2, 1, 9788432219764, TO_DATE('16-06-2026','DD-MM-YYYY'), 'NO', 2, 1, 2, 4, TO_DATE('11-01-2004','DD-MM-YYYY'), TO_DATE('11-01-2004','DD-MM-YYYY'), NULL, NULL, 'NO');
-- 2026-06-03 = Miércoles (Día 4)
INSERT INTO MEA_REUNIONES_CALENDARIO VALUES (3, 1, 9788420600734, TO_DATE('03-06-2026','DD-MM-YYYY'), 'SI', 3, 1, 3, 5, TO_DATE('11-01-2004','DD-MM-YYYY'), TO_DATE('11-01-2004','DD-MM-YYYY'), 'Aventura comentada', 3.5, 'SI');
-- 2026-06-15 = Lunes (Día 2)
INSERT INTO MEA_REUNIONES_CALENDARIO VALUES (3, 2, 9788420653068, TO_DATE('15-06-2026','DD-MM-YYYY'), 'SI', 3, 2, 3, 6, TO_DATE('11-01-2004','DD-MM-YYYY'), TO_DATE('11-01-2004','DD-MM-YYYY'), NULL, 4.0, 'NO');
-- 2026-06-16 = Martes (Día 3)
INSERT INTO MEA_REUNIONES_CALENDARIO VALUES (4, 1, 9788498380811, TO_DATE('16-06-2026','DD-MM-YYYY'), 'SI', 4, 1, 4, 7, TO_DATE('11-01-2004','DD-MM-YYYY'), TO_DATE('11-01-2004','DD-MM-YYYY'), 'Terror juvenil', 4.5, 'NO');
-- 2026-06-23 = Martes (Día 3)
INSERT INTO MEA_REUNIONES_CALENDARIO VALUES (4, 1, 9788415594048, TO_DATE('23-06-2026','DD-MM-YYYY'), 'SI', 4, 1, 4, 8, TO_DATE('11-01-2004','DD-MM-YYYY'), TO_DATE('11-01-2004','DD-MM-YYYY'), NULL, 5.0, 'SI');

COMMIT;

-- 22. Tabla: PRESENTACIONES
INSERT INTO MEA_PRESENTACIONES VALUES (1, TO_DATE('01-03-2026','DD-MM-YYYY'), 4.5, 45);
INSERT INTO MEA_PRESENTACIONES VALUES (1, TO_DATE('15-04-2026','DD-MM-YYYY'), 4.0, 38);
INSERT INTO MEA_PRESENTACIONES VALUES (2, TO_DATE('10-03-2026','DD-MM-YYYY'), 5.0, 60);
INSERT INTO MEA_PRESENTACIONES VALUES (3, TO_DATE('20-04-2026','DD-MM-YYYY'), 3.5, 30);
INSERT INTO MEA_PRESENTACIONES VALUES (4, TO_DATE('05-05-2026','DD-MM-YYYY'), 4.0, 50);
INSERT INTO MEA_PRESENTACIONES VALUES (5, TO_DATE('01-02-2026','DD-MM-YYYY'), 3.0, 25);
INSERT INTO MEA_PRESENTACIONES VALUES (6, TO_DATE('15-06-2026','DD-MM-YYYY'), 4.5, 55);
INSERT INTO MEA_PRESENTACIONES VALUES (7, TO_DATE('10-05-2026','DD-MM-YYYY'), 5.0, 70);

-- 23. Tabla: MEJORES_ACTORES
INSERT INTO MEA_MEJORES_ACTORES VALUES (1, TO_DATE('01-03-2026','DD-MM-YYYY'), 1, 1);
INSERT INTO MEA_MEJORES_ACTORES VALUES (1, TO_DATE('15-04-2026','DD-MM-YYYY'), 1, 2);
INSERT INTO MEA_MEJORES_ACTORES VALUES (2, TO_DATE('10-03-2026','DD-MM-YYYY'), 2, 3);
INSERT INTO MEA_MEJORES_ACTORES VALUES (2, TO_DATE('10-03-2026','DD-MM-YYYY'), 2, 4);
INSERT INTO MEA_MEJORES_ACTORES VALUES (3, TO_DATE('20-04-2026','DD-MM-YYYY'), 3, 1);
INSERT INTO MEA_MEJORES_ACTORES VALUES (3, TO_DATE('20-04-2026','DD-MM-YYYY'), 3, 5);
INSERT INTO MEA_MEJORES_ACTORES VALUES (4, TO_DATE('05-05-2026','DD-MM-YYYY'), 4, 2);
INSERT INTO MEA_MEJORES_ACTORES VALUES (5, TO_DATE('01-02-2026','DD-MM-YYYY'), 5, 6);

COMMIT;

-- 24. Tabla: PAGOS_MEMBRESIAS (Manuales solo para el socio 2 en adelante, el socio 1 lo hace el trigger)
INSERT INTO MEA_PAGOS_MEMBRESIAS VALUES (1, 2, TO_DATE('10-01-2024','DD-MM-YYYY'), 2, TO_DATE('10-01-2024','DD-MM-YYYY'));
INSERT INTO MEA_PAGOS_MEMBRESIAS VALUES (2, 3, TO_DATE('11-01-2004','DD-MM-YYYY'), 2, TO_DATE('11-01-2004','DD-MM-YYYY'));
INSERT INTO MEA_PAGOS_MEMBRESIAS VALUES (2, 4, TO_DATE('11-01-2004','DD-MM-YYYY'), 2, TO_DATE('11-01-2004','DD-MM-YYYY'));
INSERT INTO MEA_PAGOS_MEMBRESIAS VALUES (3, 5, TO_DATE('11-01-2004','DD-MM-YYYY'), 2, TO_DATE('11-01-2004','DD-MM-YYYY'));
INSERT INTO MEA_PAGOS_MEMBRESIAS VALUES (3, 6, TO_DATE('11-01-2004','DD-MM-YYYY'), 2, TO_DATE('11-01-2004','DD-MM-YYYY'));
INSERT INTO MEA_PAGOS_MEMBRESIAS VALUES (4, 7, TO_DATE('11-01-2004','DD-MM-YYYY'), 2, TO_DATE('11-01-2004','DD-MM-YYYY'));
INSERT INTO MEA_PAGOS_MEMBRESIAS VALUES (4, 8, TO_DATE('11-01-2004','DD-MM-YYYY'), 2, TO_DATE('11-01-2004','DD-MM-YYYY'));

-- 25. Tabla: INASISTENTES (Fechas sincronizadas con REUNIONES_CALENDARIO)
INSERT INTO MEA_INASISTENTES VALUES (2, 1, 9788432219764, TO_DATE('16-06-2026','DD-MM-YYYY'), 2, 1, 2, 4, TO_DATE('11-01-2004','DD-MM-YYYY'), TO_DATE('11-01-2004','DD-MM-YYYY'));
INSERT INTO MEA_INASISTENTES VALUES (1, 3, 9788420633114, TO_DATE('17-06-2026','DD-MM-YYYY'), 1, 3, 1, 2, TO_DATE('10-01-2024','DD-MM-YYYY'), TO_DATE('10-01-2024','DD-MM-YYYY'));

COMMIT;

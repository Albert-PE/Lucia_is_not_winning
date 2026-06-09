SET DEFINE OFF;

/*
Libros
    1. El Aleph - Jorge Luis Borges (1949) Argentina 
    2. Ficciones - Jorge Luis Borges (1944) Argentina  
    3. La tregua - Mario Benedetti (1960) Uruguay  
    4. El beso de la mujer araña - Manuel Puig (1976) Argentina 
    5. La vuelta al mundo en 80 días - Julio Verne (1872) Francia 
    6. Moby Dick - Herman Melville (1851) Estados Unidos 
    7. Coraline - Neil Gaiman (2002) Reino Unido 
    8. El libro del cementerio - Neil Gaiman (2008) Reino Unido 
    9. Las ventajas de ser invisible - Stephen Chbosky (1999) Estados Unidos 
    10. Eleanor & Park - Rainbow Rowell (2012) Estados Unidos  
    11. Ready Player One - Ernest Cline (2011) Estados Unidos  
    12. El marciano - Andy Weir (2011) Estados Unido  
    13. Project Hail Mary - Andy Weir (2021) Estados Unidos  
    14. La biblioteca de la medianoche - Matt Haig (2020) Reino Unido  
    15. Los siete maridos de Evelyn Hugo - Taylor Jenkins Reid (2017) Estados Unidos  
    16. Donde los árboles cantan - Laura Gallego García (2011) España  
    
    Clubes de lectura
    1. Círculo de Lectura del Fin del Mundo – Islandia 3
    2. La Tertulia del Faro – Irlanda 4
    3. Lectores del Bósforo – Turquía 5
    4. El Club de los Libros Olvidados – Países Bajos 6
    5. Sociedad de Lectura del Cabo – Sudáfrica 7
    6. Hermandad de la Tinta Verde – Portugal 8
    7. Los Nómadas del Papel – Canadá 9
    8. Café Literario de Praga – República Checa 10

    9. Sagas de Reikiavik – Islandia 3(Nuevo - Inspirado en la capital) 3
    10. Trébol Literario de Dublín – Irlanda 4 (Nuevo - Inspirado en el símbolo nacional y su capital) 4
    11. Bazar de Libros de Estambul – Turquía 5 (Nuevo - Inspirado en sus espacios históricos) 5
    12. Bohemia Literaria – República Checa 10(Nuevo - Inspirado en la región histórica) 6
    
*/



--Tablas Independientes

-- 1. Tabla: INSTITUCIONES
    INSERT INTO MEA_INSTITUCIONES (id_inst, nom_inst, tipo_inst) 
    VALUES (MEA_seq_instituciones.NEXTVAL, 'Biblioteca Central de la Ciudad', 'biblioteca');

    INSERT INTO MEA_INSTITUCIONES (id_inst, nom_inst, tipo_inst) 
    VALUES (MEA_seq_instituciones.NEXTVAL, 'Universidad de las Artes', 'universidad');

    INSERT INTO MEA_INSTITUCIONES (id_inst, nom_inst, tipo_inst) 
    VALUES (MEA_seq_instituciones.NEXTVAL, 'Colegio Nacional Simón Bolívar', 'colegio');

    INSERT INTO MEA_INSTITUCIONES (id_inst, nom_inst, tipo_inst) 
    VALUES (MEA_seq_instituciones.NEXTVAL, 'Biblioteca Nacional de España', 'biblioteca');

    INSERT INTO MEA_INSTITUCIONES (id_inst, nom_inst, tipo_inst) 
    VALUES (MEA_seq_instituciones.NEXTVAL, 'Universidad de Islandia', 'universidad');

    INSERT INTO MEA_INSTITUCIONES (id_inst, nom_inst, tipo_inst) 
    VALUES (MEA_seq_instituciones.NEXTVAL, 'Trinity College Dublin', 'universidad');

    INSERT INTO MEA_INSTITUCIONES (id_inst, nom_inst, tipo_inst) 
    VALUES (MEA_seq_instituciones.NEXTVAL, 'Biblioteca de Estambul', 'biblioteca');

    INSERT INTO MEA_INSTITUCIONES (id_inst, nom_inst, tipo_inst) 
    VALUES (MEA_seq_instituciones.NEXTVAL, 'Colegio Erasmus de Ámsterdam', 'colegio');



-- 2. Tabla: IDIOMAS
    INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) 
    VALUES (MEA_seq_idiomas.NEXTVAL, 'Español');

    INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) 
    VALUES (MEA_seq_idiomas.NEXTVAL, 'Inglés');

    INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) 
    VALUES (MEA_seq_idiomas.NEXTVAL, 'Islandés');

    INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) 
    VALUES (MEA_seq_idiomas.NEXTVAL, 'Irlandés');

    INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) 
    VALUES (MEA_seq_idiomas.NEXTVAL, 'Turco');

    INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) 
    VALUES (MEA_seq_idiomas.NEXTVAL, 'Checo');

    INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) 
    VALUES (MEA_seq_idiomas.NEXTVAL, 'Portugués');

    INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) 
    VALUES (MEA_seq_idiomas.NEXTVAL, 'Neerlandés');

    INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) 
    VALUES (MEA_seq_idiomas.NEXTVAL, 'Afrikáans');

    INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) 
    VALUES (MEA_seq_idiomas.NEXTVAL, 'Francés');



-- 3. Tabla: PAISES
    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (MEA_seq_paises.NEXTVAL, 'Venezuela', 'VED', 'Venezolana');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (MEA_seq_paises.NEXTVAL, 'España', 'EUR', 'Española');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (MEA_seq_paises.NEXTVAL, 'Islandia', 'ISK', 'Islandesa');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (MEA_seq_paises.NEXTVAL, 'Irlanda', 'EUR', 'Irlandesa');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (MEA_seq_paises.NEXTVAL, 'Turquía', 'TRY', 'Turca');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (MEA_seq_paises.NEXTVAL, 'Países Bajos', 'EUR', 'Neerlandesa');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (MEA_seq_paises.NEXTVAL, 'Sudáfrica', 'ZAR', 'Sudafricana');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (MEA_seq_paises.NEXTVAL, 'Portugal', 'EUR', 'Portuguesa');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (MEA_seq_paises.NEXTVAL, 'Canadá', 'CAD', 'Canadiense');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (MEA_seq_paises.NEXTVAL, 'República Checa', 'CZK', 'Checa');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (MEA_seq_paises.NEXTVAL, 'Argentina', 'ARS', 'Argentina');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (MEA_seq_paises.NEXTVAL, 'Uruguay', 'UYU', 'Uruguaya');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (MEA_seq_paises.NEXTVAL, 'Francia', 'EUR', 'Francesa');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (MEA_seq_paises.NEXTVAL, 'Estados Unidos', 'USD', 'Estadounidense');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (MEA_seq_paises.NEXTVAL, 'Reino Unido', 'GBP', 'Británica');



-- 4. Tabla: AUTORES

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, s_nombre, p_apellido, s_apellido) 
    VALUES (MEA_seq_autores.NEXTVAL, 'Jorge', 'Luis', 'Borges', 'Acevedo');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido) 
    VALUES (MEA_seq_autores.NEXTVAL, 'Mario', 'Benedetti');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido, s_apellido) 
    VALUES (MEA_seq_autores.NEXTVAL, 'Manuel', 'Puig', 'Beltran');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido, s_apellido) 
    VALUES (MEA_seq_autores.NEXTVAL, 'Julio', 'Verne', 'Gaignon');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido, s_apellido) 
    VALUES (MEA_seq_autores.NEXTVAL, 'Herman', 'Melville', 'Philer');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido) 
    VALUES (MEA_seq_autores.NEXTVAL, 'Neil', 'Gaiman');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido) 
    VALUES (MEA_seq_autores.NEXTVAL, 'Stephen', 'Chbosky');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido) 
    VALUES (MEA_seq_autores.NEXTVAL, 'Rainbow', 'Rowell');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido) 
    VALUES (MEA_seq_autores.NEXTVAL, 'Ernest', 'Cline');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido) 
    VALUES (MEA_seq_autores.NEXTVAL, 'Andy', 'Weir');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido) 
    VALUES (MEA_seq_autores.NEXTVAL, 'Matt', 'Haig');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido, s_apellido) 
    VALUES (MEA_seq_autores.NEXTVAL, 'Taylor', 'Jenkins', 'Reid');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido, s_apellido) 
    VALUES (MEA_seq_autores.NEXTVAL, 'Laura', 'Gallego', 'García');
COMMIT;

--------------------------------------------------------------------------------
--Tablas Dependientes



-- 5. Tabla: CIUDADES 
    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --1
    VALUES (MEA_seq_ciudades.NEXTVAL, 1, 'Caracas');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --2
    VALUES (MEA_seq_ciudades.NEXTVAL, 2, 'Madrid');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --3
    VALUES (MEA_seq_ciudades.NEXTVAL, 3, 'Reikiavik');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --4
    VALUES (MEA_seq_ciudades.NEXTVAL, 3, 'Akureyri');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --5
    VALUES (MEA_seq_ciudades.NEXTVAL, 3, 'Reykjanesbær');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --6
    VALUES (MEA_seq_ciudades.NEXTVAL, 4, 'Dublín');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --7
    VALUES (MEA_seq_ciudades.NEXTVAL, 4, 'Galway');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --8
    VALUES (MEA_seq_ciudades.NEXTVAL, 4, 'Cork');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --9
    VALUES (MEA_seq_ciudades.NEXTVAL, 5, 'Estambul');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --10
    VALUES (MEA_seq_ciudades.NEXTVAL, 5, 'Ankara');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --11
    VALUES (MEA_seq_ciudades.NEXTVAL, 5, 'Esmirna');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --12
    VALUES (MEA_seq_ciudades.NEXTVAL, 6, 'Ámsterdam');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --13
    VALUES (MEA_seq_ciudades.NEXTVAL, 7, 'Ciudad del Cabo');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --14
    VALUES (MEA_seq_ciudades.NEXTVAL, 8, 'Lisboa');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --15
    VALUES (MEA_seq_ciudades.NEXTVAL, 9, 'Toronto');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --16
    VALUES (MEA_seq_ciudades.NEXTVAL, 10, 'Praga');



-- 6. Tabla: CLUBES 

    --Islandia
        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad, cuota_membresia)
        VALUES (MEA_seq_clubes.NEXTVAL, 'Círculo de Lectura del Fin del Mundo', TO_DATE('10-01-2024', 'DD-MM-YYYY'), 'Calle Falsa 1','1060', 3, 4, 25.00);

        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
        VALUES (MEA_seq_clubes.NEXTVAL, 'Sagas de Reikiavik', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 2','2050', 3, 3);

    -- Irlanda
        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
        VALUES (MEA_seq_clubes.NEXTVAL, 'La Tertulia del Faro', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 3','4861', 4, 6);

        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
        VALUES (MEA_seq_clubes.NEXTVAL, 'Trébol Literario de Dublín', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 10','4868', 4, 6);

    -- Turquía
        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
        VALUES (MEA_seq_clubes.NEXTVAL, 'Lectores del Bósforo', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 4','4862', 5, 10);

        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
        VALUES (MEA_seq_clubes.NEXTVAL, 'Bazar de Libros de Estambul', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 11','4869', 5, 9);

    -- Países Bajos
        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
        VALUES (MEA_seq_clubes.NEXTVAL, 'El Club de los Libros Olvidados', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 5','4863', 6, 12);

    -- Sudáfrica
        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
        VALUES (MEA_seq_clubes.NEXTVAL, 'Sociedad de Lectura del Cabo', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 6','4864', 7, 13);

    -- Portugal
        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
        VALUES (MEA_seq_clubes.NEXTVAL, 'Hermandad de la Tinta Verde', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 7','4865', 8, 14);

    -- Canadá
        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
        VALUES (MEA_seq_clubes.NEXTVAL, 'Los Nómadas del Papel', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 8','4866', 9, 15);

    -- República Checa
        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
        VALUES (MEA_seq_clubes.NEXTVAL, 'Café Literario de Praga', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 9','4867', 10, 16);

        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
        VALUES (MEA_seq_clubes.NEXTVAL, 'Bohemia Literaria', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 12','4870', 10, 16);



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
    INSERT INTO MEA_HABLAN (id_habla, id_idioma, id_lector) 
    VALUES (MEA_seq_hablan.NEXTVAL, 1, 1);

    INSERT INTO MEA_HABLAN (id_habla, id_idioma, id_club) 
    VALUES (MEA_seq_hablan.NEXTVAL, 2, 1);

    INSERT INTO MEA_HABLAN (id_habla, id_idioma, id_lector) 
    VALUES (MEA_seq_hablan.NEXTVAL, 3, 3);

    INSERT INTO MEA_HABLAN (id_habla, id_idioma, id_club) 
    VALUES (MEA_seq_hablan.NEXTVAL, 3, 1);

    INSERT INTO MEA_HABLAN (id_habla, id_idioma, id_lector) 
    VALUES (MEA_seq_hablan.NEXTVAL, 4, 4);

    INSERT INTO MEA_HABLAN (id_habla, id_idioma, id_club) 
    VALUES (MEA_seq_hablan.NEXTVAL, 5, 3);

    INSERT INTO MEA_HABLAN (id_habla, id_idioma, id_lector) 
    VALUES (MEA_seq_hablan.NEXTVAL, 6, 5);

    INSERT INTO MEA_HABLAN (id_habla, id_idioma, id_club) 
    VALUES (MEA_seq_hablan.NEXTVAL, 7, 6);



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
    VALUES (1, MEA_seq_representantes.NEXTVAL, 45678901, 'Francisco', 'Álvarez', 'Reyes');

    INSERT INTO MEA_REPRESENTANTES (id_lector, id_representante, doc_identidad, p_nombre, p_apellido, s_apellido) 
    VALUES (6, MEA_seq_representantes.NEXTVAL, 56789012, 'Isabel', 'Navarro', 'Medina');

    INSERT INTO MEA_REPRESENTANTES (id_lector, id_representante, doc_identidad, p_nombre, p_apellido, s_apellido) 
    VALUES (7, MEA_seq_representantes.NEXTVAL, 67890123, 'Antonio', 'Romero', 'Herrera');

    INSERT INTO MEA_REPRESENTANTES (id_lector, id_representante, doc_identidad, p_nombre, p_apellido, s_apellido)
    VALUES (8, MEA_seq_representantes.NEXTVAL, 78901234, 'Sofía', 'Domínguez', 'Rivas');



-- 11. Tabla: TELÉFONOS 
    INSERT INTO MEA_TELEFONOS (cod_local, cod_area, num_tlf, id_club) 
    VALUES (58, 212, 1234567, 1);

    INSERT INTO MEA_TELEFONOS (cod_local, cod_area, num_tlf, id_lector) 
    VALUES (34, 91, 9876543, 2);

    INSERT INTO MEA_TELEFONOS (cod_local, cod_area, num_tlf, id_club) 
    VALUES (354, 123, 4567890, 2);

    INSERT INTO MEA_TELEFONOS (cod_local, cod_area, num_tlf, id_lector) 
    VALUES (353, 1, 2345678, 3);

    INSERT INTO MEA_TELEFONOS (cod_local, cod_area, num_tlf, id_club) 
    VALUES (90, 212, 3456789, 3);

    INSERT INTO MEA_TELEFONOS (cod_local, cod_area, num_tlf, id_lector) 
    VALUES (31, 20, 4567890, 4);

    INSERT INTO MEA_TELEFONOS (cod_local, cod_area, num_tlf, id_club) 
    VALUES (27, 21, 5678901, 5);

    INSERT INTO MEA_TELEFONOS (cod_local, cod_area, num_tlf, id_club) 
    VALUES (351, 21, 6789012, 6);



-- 12. Tabla: LIBROS 
    INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
    VALUES (9788420633114, 'El Aleph', 1949, 152, 'Borges nos guía por relatos donde el tiempo, la inmortalidad y los laberintos son protagonistas. El cuento principal narra el descubrimiento de un punto en el espacio que contiene todos los puntos del universo simultáneamente.', 'Obra cumbre de la literatura fantástica. A través de la erudición y la ironía, el autor explora las obsesiones humanas y las paradojas matemáticas, invitando al lector a cuestionar la estructura de la realidad y la infinitud.', 'Ficción filosófica', 'Cuentos', 11);

    INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
    VALUES (9788420633121, 'Ficciones', 1944, 192, 'Colección dividida en "El jardín de senderos que se bifurcan" y "Artificios". Presenta universos paralelos, bibliotecas infinitas, detectives y falsificaciones literarias que alteran el curso de la historia.', 'Un hito del cuento moderno. Borges entrelaza filosofía, religión y mitología para crear mundos ficticios que desafían la lógica, demostrando que la literatura puede ser un inmenso juego intelectual de proporciones cósmicas.', 'Realismo mágico', 'Cuentos', 11);

    INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
    VALUES (9788420423852, 'La tregua', 1960, 216, 'Martín Santomé, un viudo a punto de jubilarse, lleva una vida gris en Montevideo hasta que conoce a Laura Avellaneda, una joven empleada con la que inicia un romance que le devuelve la esperanza y la alegría de vivir.', 'Escrita en formato de diario, es una exploración conmovedora sobre la rutina, el paso del tiempo, el amor tardío y lo efímero de la felicidad. Una obra magistral que retrata a la clase media uruguaya con dulce melancolía.', 'Rutina y esperanza', 'Novela', 12);

    INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
    VALUES (9788432219764, 'El beso de la mujer araña', 1976, 288, 'En una celda argentina, dos presos muy distintos —Molina, un romántico, y Valentín, un activista político— conviven. Forjan un vínculo profundo mientras Molina narra películas clásicas para evadir la dura realidad.', 'Una profunda crítica a la represión política y sexual. Mediante diálogos sin narrador tradicional, Puig examina la identidad, el heroísmo, los roles de género y el poder transformador de la empatía en el aislamiento.', 'Opresión/Libertad', 'Novela', 11);

    INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
    VALUES (9788420600734, 'La vuelta al mundo en 80 días', 1872, 320, 'Phileas Fogg, un caballero inglés, apuesta su fortuna a que puede dar la vuelta al mundo en 80 días. Junto a su sirviente Passepartout, sortea obstáculos increíbles y evade a un detective que lo confunde con un ladrón.', 'Un clásico de aventuras que captura la fascinación del siglo XIX por la tecnología y los nuevos transportes, celebrando la tenacidad humana, la precisión y la maravilla de un mundo que comenzaba a estar globalizado.', 'Aventura/Progreso', 'Novela', 13);

    INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
    VALUES (9788420653068, 'Moby Dick', 1851, 824, 'Ismael se embarca en el ballenero Pequod, comandado por el capitán Ahab. El viaje pronto revela su verdadero y oscuro propósito: la caza implacable y obsesiva de Moby Dick, una gigantesca y fiera ballena blanca.', 'Una epopeya monumental sobre la lucha del hombre contra la naturaleza y lo divino. Mezclando acción con profundas reflexiones filosóficas, aborda los límites de la cordura, el odio humano y la sed de retribución.', 'Venganza y obsesión', 'Novela', 14);

    INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
    VALUES (9788498380811, 'Coraline', 2002, 160, 'Al mudarse a una nueva casa, Coraline descubre una puerta a un mundo alternativo. Allí, sus "Otros Padres" son atentos pero tienen botones por ojos e intentarán atraparla para siempre en esa escalofriante y falsa utopía.', 'Un oscuro y brillante relato sobre la valentía. Gaiman construye una atmósfera aterradora con elementos de cuento de hadas para demostrar que el coraje real no es la ausencia de miedo, sino enfrentarlo pese a tenerlo.', 'Fantasía oscura', 'Novela', 15);

    INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
    VALUES (9788415594048, 'El libro del cementerio', 2008, 304, 'Tras el asesinato de su familia, el bebé Nadie escapa a un cementerio, donde es adoptado y criado por fantasmas y criaturas nocturnas. Al crecer, debe aprender a convivir y defenderse entre el mundo de los vivos y los muertos.', 'Una reimaginación de "El libro de la selva" en un entorno macabro. Aborda temas universales como el crecimiento, la identidad y la aceptación de la pérdida, mezclando folclore oscuro con una emotiva historia familiar.', 'Fantasía juvenil', 'Novela', 15);

    INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
    VALUES (9786073111451, 'Las ventajas de ser invisible', 1999, 224, 'Charlie es un adolescente solitario lidiando con traumas pasados. A través de cartas anónimas, relata su ingreso a la preparatoria y cómo conoce a Sam y Patrick, quienes lo introducen al mundo de la amistad y la música.', 'Una honesta historia de maduración que aborda el abuso, el despertar sexual y la importancia de pertenecer. Una obra de culto que captura con enorme sensibilidad la angustia, la vulnerabilidad y la intensidad adolescente.', 'Salud mental/Amor', 'Novela', 14);

    INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
    VALUES (9788420415703, 'Eleanor & Park', 2012, 336, 'Dos adolescentes inadaptados en los años 80, la excéntrica Eleanor y el callado Park, comparten un asiento en el autobús escolar. A través de cómics y casetes, desarrollan un profundo pero complicado primer amor.', 'Una exploración cruda y dulce del amor juvenil frente a la adversidad. La novela contrasta la ternura de la conexión adolescente con realidades duras como el acoso escolar y el abuso doméstico, dejando una fuerte huella.', 'Primer amor', 'Novela', 14);

    INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
    VALUES (9788466649176, 'Ready Player One', 2011, 464, 'En un futuro distópico, la humanidad se refugia en OASIS, un mundo virtual. Su creador dejó su inmensa fortuna escondida allí, y el joven Wade Watts compite contra corporaciones implacables para encontrar el "huevo de pascua".', 'Una trepidante carta de amor a la cultura pop de los ochenta. Mezcla ciencia ficción con estética ciberpunk y videojuegos, ofreciendo una aventura vertiginosa que advierte sutilmente sobre los peligros del escapismo.', 'Realidad virtual', 'Novela', 14);

    INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
    VALUES (9788466655054, 'El marciano', 2011, 400, 'El astronauta Mark Watney es dado por muerto y abandonado en Marte tras una tormenta de arena. Con escasos suministros, deberá usar todo su ingenio, botánica e ingeniería para sobrevivir e intentar contactar a la Tierra.', 'Un thriller de ciencia ficción centrado en la resolución de problemas lógicos. Con un humor sarcástico y una precisión científica asombrosa, celebra la capacidad del intelecto y la resiliencia frente a la hostilidad del cosmos.', 'Supervivencia', 'Novela', 14);

    INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
    VALUES (9788418037130, 'Project Hail Mary', 2021, 496, 'Ryland Grace despierta sin memoria en una nave a años luz de casa, junto a dos cadáveres. Al recordar, comprende que es la única esperanza para salvar a la Tierra de un letal microorganismo que está consumiendo al sol.', 'Una fascinante odisea interestelar que explora la soledad, el sacrificio y la amistad más allá de las barreras de las especies. Destaca por su rigor científico accesible y su emotivo mensaje de cooperación existencial.', 'Cooperación y vida', 'Novela', 14);

    INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
    VALUES (9788412275957, 'La biblioteca de la medianoche', 2020, 336, 'Nora Seed, sumida en la depresión, intenta terminar con su vida. Sin embargo, despierta en una mágica biblioteca donde cada libro le permite experimentar una versión de su vida si hubiera tomado decisiones diferentes.', 'Una novela reconfortante sobre las infinitas posibilidades de la existencia. Reflexiona sobre el enorme peso de los arrepentimientos, la salud mental y la verdadera definición del éxito, recordando que nunca es tarde para vivir.', 'Arrepentimiento', 'Novela', 15);

    INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
    VALUES (9788416327855, 'Los 7 maridos de Evelyn Hugo', 2017, 400, 'La mítica estrella de Hollywood Evelyn Hugo elige a la periodista Monique Grant para revelar su biografía no autorizada. Evelyn narra su meteórico ascenso a la cima, sus siete matrimonios y el verdadero gran amor de su vida.', 'Un retrato deslumbrante del glamour clásico del cine y sus secretos. Explora la ambición desenfrenada, el alto costo de la fama, los sacrificios personales y las complejidades de la identidad bajo el implacable ojo público.', 'Fama y ambición', 'Novela', 14);

    INSERT INTO MEA_LIBROS (isbn, titulo_libro, año_publicacion, cant_paginas, resumen, sinopsis, tema, tipo_narrativa, id_pais) 
    VALUES (9788467550037, 'Donde los árboles cantan', 2011, 480, 'Viana, una joven doncella educada para el matrimonio, ve su vida destruida cuando los bárbaros conquistan su reino de Nortia. Deberá huir al Gran Bosque, aprender a luchar y desentrañar sus misterios para recuperar su hogar.', 'Una historia de empoderamiento, magia y lealtad. La autora reinterpreta los cantares de gesta medievales a través de una heroína fuerte y en constante evolución, tejiendo un hermoso relato sobre la supervivencia y la naturaleza.', 'Fantasía épica', 'Novela', 2);



-- 13. Tabla: ASOCIACIONES 
    INSERT INTO MEA_ASOCIACIONES (id_club1, id_club2) 
    VALUES (1, 2);

    INSERT INTO MEA_ASOCIACIONES (id_club1, id_club2) 
    VALUES (1, 3);

    INSERT INTO MEA_ASOCIACIONES (id_club1, id_club2) 
    VALUES (2, 4);

    INSERT INTO MEA_ASOCIACIONES (id_club1, id_club2) 
    VALUES (3, 5);

    INSERT INTO MEA_ASOCIACIONES (id_club1, id_club2) 
    VALUES (4, 6);

    INSERT INTO MEA_ASOCIACIONES (id_club1, id_club2) 
    VALUES (5, 7);

    INSERT INTO MEA_ASOCIACIONES (id_club1, id_club2) 
    VALUES (6, 8);

    INSERT INTO MEA_ASOCIACIONES (id_club1, id_club2) 
    VALUES (1, 8);



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
    INSERT INTO MEA_REFERENCIAS (isbn, id_obra) 
    VALUES (9788420633114, 1);

    INSERT INTO MEA_REFERENCIAS (isbn, id_obra) 
    VALUES (9788420633121, 2);

    INSERT INTO MEA_REFERENCIAS (isbn, id_obra) 
    VALUES (9788420423852, 3);

    INSERT INTO MEA_REFERENCIAS (isbn, id_obra) 
    VALUES (9788432219764, 4);

    INSERT INTO MEA_REFERENCIAS (isbn, id_obra) 
    VALUES (9788498380811, 5);

    INSERT INTO MEA_REFERENCIAS (isbn, id_obra) 
    VALUES (9788415594048, 6);

    INSERT INTO MEA_REFERENCIAS (isbn, id_obra) 
    VALUES (9788466649176, 7);

    INSERT INTO MEA_REFERENCIAS (isbn, id_obra) 
    VALUES (9788466655054, 8);


-- 16. Tabla: ELENCOS 
    INSERT INTO MEA_ELENCOS (id_obra, id_lector) 
    VALUES (1, 1);

    INSERT INTO MEA_ELENCOS (id_obra, id_lector) 
    VALUES (1, 2);

    INSERT INTO MEA_ELENCOS (id_obra, id_lector) 
    VALUES (2, 3);

    INSERT INTO MEA_ELENCOS (id_obra, id_lector) 
    VALUES (2, 4);

    INSERT INTO MEA_ELENCOS (id_obra, id_lector) 
    VALUES (3, 5);

    INSERT INTO MEA_ELENCOS (id_obra, id_lector) 
    VALUES (3, 1);

    INSERT INTO MEA_ELENCOS (id_obra, id_lector) 
    VALUES (4, 2);

    INSERT INTO MEA_ELENCOS (id_obra, id_lector) 
    VALUES (5, 6);


-- 17. Tabla: Favoritos
    INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) 
    VALUES (1, 9788418037130, 1);

    INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) 
    VALUES (1, 9788420633121, 2);

    INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) 
    VALUES (2, 9788420423852, 1);

    INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) 
    VALUES (2, 9788498380811, 2);

    INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) 
    VALUES (3, 9788466649176, 1);

    INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) 
    VALUES (4, 9788415594048, 1);

    INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) 
    VALUES (5, 9788418037130, 1);

    INSERT INTO MEA_FAVORITOS (id_lector, isbn, orden) 
    VALUES (6, 9788416327855, 1);


COMMIT;
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
    INSERT INTO instituciones (id_inst, nom_inst, tipo_inst) 
    VALUES (seq_id_inst.NEXTVAL, 'Biblioteca Central de la Ciudad', 'biblioteca');

    INSERT INTO instituciones (id_inst, nom_inst, tipo_inst) 
    VALUES (seq_id_inst.NEXTVAL, 'Universidad de las Artes', 'universidad');



-- 2. Tabla: IDIOMAS
    INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) 
    VALUES (seq_id_idioma.NEXTVAL, 'Español');

    INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) 
    VALUES (seq_id_idioma.NEXTVAL, 'Inglés');

    INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) 
    VALUES (seq_id_idioma.NEXTVAL, 'Islandés');

    INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) 
    VALUES (seq_id_idioma.NEXTVAL, 'Irlandés');

    INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) 
    VALUES (seq_id_idioma.NEXTVAL, 'Turco');

    INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) 
    VALUES (seq_id_idioma.NEXTVAL, 'Checo');

    INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) 
    VALUES (seq_id_idioma.NEXTVAL, 'Portugués');

    INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) 
    VALUES (seq_id_idioma.NEXTVAL, 'Neerlandés');

    INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) 
    VALUES (seq_id_idioma.NEXTVAL, 'Afrikáans');

    INSERT INTO MEA_IDIOMAS (id_idioma, nom_idioma) 
    VALUES (seq_id_idioma.NEXTVAL, 'Francés');



-- 3. Tabla: PAISES
    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (seq_id_pais.NEXTVAL, 'Venezuela', 'VED', 'Venezolana');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (seq_id_pais.NEXTVAL, 'España', 'EUR', 'Española');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (seq_id_pais.NEXTVAL, 'Islandia', 'ISK', 'Islandesa');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (seq_id_pais.NEXTVAL, 'Irlanda', 'EUR', 'Irlandesa');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (seq_id_pais.NEXTVAL, 'Turquía', 'TRY', 'Turca');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (seq_id_pais.NEXTVAL, 'Países Bajos', 'EUR', 'Neerlandesa');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (seq_id_pais.NEXTVAL, 'Sudáfrica', 'ZAR', 'Sudafricana');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (seq_id_pais.NEXTVAL, 'Portugal', 'EUR', 'Portuguesa');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (seq_id_pais.NEXTVAL, 'Canadá', 'CAD', 'Canadiense');

    INSERT INTO MEA_PAISES (id_pais, nom_pais, moneda, nacionalidad) 
    VALUES (seq_id_pais.NEXTVAL, 'República Checa', 'CZK', 'Checa');



-- 4. Tabla: AUTORES
    INSERT INTO MEA_AUTORES (id_autor) 
    VALUES (seq_id_autor.NEXTVAL);

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, s_nombre, p_apellido, s_apellido) 
    VALUES (seq_id_autor.NEXTVAL, 'Jorge', 'Luis', 'Borges', 'Acevedo');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido,) 
    VALUES (seq_id_autor.NEXTVAL, 'Mario', 'Benedetti');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido, s_apellido) 
    VALUES (seq_id_autor.NEXTVAL, 'Manuel', 'Puig', 'Beltran');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido, s_apellido) 
    VALUES (seq_id_autor.NEXTVAL, 'Julio', 'Verne', 'Gaignon');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido, s_apellido) 
    VALUES (seq_id_autor.NEXTVAL, 'Herman', 'Melville', 'Philer');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido) 
    VALUES (seq_id_autor.NEXTVAL, 'Neil', 'Gaiman');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido) 
    VALUES (seq_id_autor.NEXTVAL, 'Stephen', 'Chbosky');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido) 
    VALUES (seq_id_autor.NEXTVAL, 'Rainbow', 'Rowell');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido) 
    VALUES (seq_id_autor.NEXTVAL, 'Ernest', 'Cline');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido) 
    VALUES (seq_id_autor.NEXTVAL, 'Andy', 'Weir');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido) 
    VALUES (seq_id_autor.NEXTVAL, 'Matt', 'Haig');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido, s_apellido) 
    VALUES (seq_id_autor.NEXTVAL, 'Taylor', 'Jenkins', 'Reid');

    INSERT INTO MEA_AUTORES (id_autor, p_nombre, p_apellido, s_apellido) 
    VALUES (seq_id_autor.NEXTVAL, 'Laura', 'Gallego', 'García');
COMMIT;

--------------------------------------------------------------------------------
--Tablas Dependientes



-- 5. Tabla: CIUDADES 
    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --1
    VALUES (seq_id_ciudad.NEXTVAL, 1, 'Caracas');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --2
    VALUES (seq_id_ciudad.NEXTVAL, 2, 'Madrid');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --3
    VALUES (seq_id_ciudad.NEXTVAL, 3, 'Reikiavik');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --4
    VALUES (seq_id_ciudad.NEXTVAL, 3, 'Akureyri');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --5
    VALUES (seq_id_ciudad.NEXTVAL, 3, 'Reykjanesbær');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --6
    VALUES (seq_id_ciudad.NEXTVAL, 4, 'Dublín');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --7
    VALUES (seq_id_ciudad.NEXTVAL, 4, 'Galway');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --8
    VALUES (seq_id_ciudad.NEXTVAL, 4, 'Cork');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --9
    VALUES (seq_id_ciudad.NEXTVAL, 5, 'Estambul');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --10
    VALUES (seq_id_ciudad.NEXTVAL, 5, 'Ankara');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --11
    VALUES (seq_id_ciudad.NEXTVAL, 5, 'Esmirna');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --12
    VALUES (seq_id_ciudad.NEXTVAL, 6, 'Ámsterdam');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --13
    VALUES (seq_id_ciudad.NEXTVAL, 7, 'Ciudad del Cabo');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --14
    VALUES (seq_id_ciudad.NEXTVAL, 8, 'Lisboa');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --15
    VALUES (seq_id_ciudad.NEXTVAL, 9, 'Toronto');

    INSERT INTO MEA_CIUDADES (id_ciudad, id_pais, nom_ciudad) --16
    VALUES (seq_id_ciudad.NEXTVAL, 10, 'Praga');



-- 6. Tabla: CLUBES 

    --Islandia
        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad, cuota_membresia)
        VALUES (seq_id_club.NEXTVAL, 'Círculo de Lectura del Fin del Mundo', TO_DATE('10-01-2024', 'DD-MM-YYYY'), 'Calle Falsa 1','1060', 3, 4, 25.00);

        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
        VALUES (seq_id_club.NEXTVAL, 'Sagas de Reikiavik', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 2','2050', 3, 3);

    -- Irlanda
        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
        VALUES (seq_id_club.NEXTVAL, 'La Tertulia del Faro', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 3','4861', 4, 6);

        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
        VALUES (seq_id_club.NEXTVAL, 'Trébol Literario de Dublín', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 10','4868', 4, 6);

    -- Turquía
        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
        VALUES (seq_id_club.NEXTVAL, 'Lectores del Bósforo', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 4','4862', 5, 10);

        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
        VALUES (seq_id_club.NEXTVAL, 'Bazar de Libros de Estambul', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 11','4869', 5, 9);

    -- Países Bajos
        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
        VALUES (seq_id_club.NEXTVAL, 'El Club de los Libros Olvidados', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 5','4863', 6, 12);

    -- Sudáfrica
        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
        VALUES (seq_id_club.NEXTVAL, 'Sociedad de Lectura del Cabo', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 6','4864', 7, 13);

    -- Portugal
        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
        VALUES (seq_id_club.NEXTVAL, 'Hermandad de la Tinta Verde', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 7','4865', 8, 14);

    -- Canadá
        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
        VALUES (seq_id_club.NEXTVAL, 'Los Nómadas del Papel', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 8','4866', 9, 15);

    -- República Checa
        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
        VALUES (seq_id_club.NEXTVAL, 'Café Literario de Praga', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 9','4867', 10, 16);

        INSERT INTO MEA_CLUBES (id_club, nombre_club, fech_creacion, direccion, codigo_postal, id_pais, id_ciudad)
        VALUES (seq_id_club.NEXTVAL, 'Bohemia Literaria', TO_DATE('11-01-2004', 'DD-MM-YYYY'), 'Calle Falsa 12','4870', 10, 16);



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
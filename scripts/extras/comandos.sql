
--Eliminar todos los registros que dependen directa o indirectamente de un Lector
DELETE FROM MEA_FAVORITOS;
DELETE FROM MEA_INASISTENTES;
DELETE FROM MEA_REUNIONES_CALENDARIO;
DELETE FROM MEA_HISTORICO_GRUPOS;
DELETE FROM MEA_MEJORES_ACTORES;
DELETE FROM MEA_ELENCOS;
DELETE FROM MEA_PAGOS_MEMBRESIAS;
DELETE FROM MEA_SOCIOS;
DELETE FROM MEA_TELEFONOS;
DELETE FROM MEA_HABLAN;
DELETE FROM MEA_REPRESENTANTES;

UPDATE MEA_LECTORES SET id_lector_repre = NULL;

DELETE FROM MEA_LECTORES;

COMMIT;

--------------------------------------------------------

--Mostrar grupos de un club
SELECT * 
FROM MEA_V_GRUPOS_CLUB 
WHERE id_club = &Que_club_desea_ver;

--Dividir un grupo
EXECUTE MEA_dividir_grupo(&id_club, &id_grupo);

--------------------------------------------------------

--Mostrar socios activos de un club especifico
SELECT *
FROM MEA_v_socios_activos
WHERE id_club = &id_club;

--Retirar un miembro del club
EXECUTE MEA_retirar_miembro(&id_lector, &motivo);
                            --deuda, inasistencia, otro
-------------------------------------------------------

--Consultar calendario reuniones
SELECT * 
FROM MEA_V_AGENDA_REUNIONES 
WHERE id_club = &id_club AND id_grupo = &id_grupo;

--Mostrar catalogo de libros
SELECT *
FROM MEA_v_catalogo_libros;

--Generar calendario de reuniones
EXECUTE MEA_generar_calendario(&id_club, &id_grupo, &isbn, &fecha_inicio, &cant_reuniones, &id_moderador);

--------------------------------------------------------

--Reuniones no realizadas
SELECT * 
FROM MEA_V_AGENDA_REUNIONES 
WHERE id_club = &id_club AND id_grupo = &id_grupo AND realizada = 'NO';

--Reuniones que ya se realizaron
SELECT * 
FROM MEA_V_AGENDA_REUNIONES 
WHERE id_club = &id_club AND id_grupo = &id_grupo AND realizada = 'SI';

--Realizar una reunion
EXECUTE MEA_realizar_reunion(&id_club, &id_grupo, &isbn, &fecha);

--------------------------------------------------------

--Mostrar catalogo de libros
SELECT *
FROM MEA_v_catalogo_libros;

--------------------------------------------------------

--Mostrar Reuniones
SELECT * 
FROM MEA_V_AGENDA_REUNIONES 
WHERE id_club = &id_club AND id_grupo = &id_grupo;

--Cerrar bloque de reuniones
EXECUTE MEA_cerrar_calendario(&id_club, &id_grupo, &isbn, &fecha_cierre, &valoracion, &conclusion); 

---------------------------------------------------------

--Mostrar libros favorites de un socio
SELECT *
FROM MEA_V_FAVORITOS
WHERE id_lector = &id_lector;

-- Cambiar libros favoritos de un lector
EXECUTE MEA_asignar_favoritos(&id_lector, &p_isbn_fav1, &p_isbn_fav2, &p_isbn_fav3);

--------------------------------------------------------

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

-------------------------------------------------------
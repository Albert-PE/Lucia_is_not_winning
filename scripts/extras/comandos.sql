
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
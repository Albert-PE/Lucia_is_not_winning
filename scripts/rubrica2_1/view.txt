-- 1. Vista: V_DETALLE_LECTORES 
-- Muestra la información de los lectores junto con el nombre de su representante (usando un self-join).

CREATE OR REPLACE VIEW v_detalle_lectores AS
SELECT 
    l.id_lector, 
    l.p_nombre || ' ' || l.p_apellido AS nombre_lector, 
    l.email,
    r.p_nombre || ' ' || r.p_apellido AS nombre_representante
FROM lectores l, representantes r
WHERE l.id_lector = r.id_lector (+); 

-- 2. Vista: V_CLUBES_INSTITUCIONES 
-- Combina los clubes con el nombre y tipo de la institución a la que pertenecen

CREATE OR REPLACE VIEW v_clubes_instituciones AS
SELECT 
    c.id_club, 
    c.nombre_club, 
    c.cuota_membresia,
    i.nom_inst AS nombre_institucion, 
    i.tipo_inst
FROM clubes c, instituciones i
WHERE c.id_institucion = i.id_inst;

-- 3. Vista: V_SOCIOS_ACTIVOS 
-- Filtra únicamente a los socios con estatus 'activo', mostrando sus nombres y el club asociado.

CREATE OR REPLACE VIEW v_socios_activos AS
SELECT 
    s.id_club, 
    c.nombre_club, 
    l.p_nombre || ' ' || l.p_apellido AS nombre_socio, 
    s.fech_i_soc AS fecha_ingreso
FROM socios s, clubes c, lectores l
WHERE s.status = 'activo'
  AND s.id_club = c.id_club
  AND s.id_lector = l.id_lector;

-- 4. Vista: V_CATALOGO_LIBROS 
-- Presenta un resumen de los libros, incluyendo el autor y el país de origen.

CREATE OR REPLACE VIEW v_catalogo_libros AS
SELECT 
    b.isbn, 
    b.titulo_libro, 
    a.p_nombre || ' ' || a.p_apellido AS autor,
    p.nom_pais AS pais_origen,
    b.tipo_narrativa
FROM libros b, a_l al, autores a, paises p
WHERE b.isbn = al.isbn
  AND al.id_autor = a.id_autor
  AND b.id_pais = p.id_pais;

-- 5. Vista: V_HISTORIAL_PAGOS 
-- Utiliza la tabla corregida con la columna 'fech_emision_pago' para listar los pagos de membresías.

CREATE OR REPLACE VIEW v_historial_pago_socios AS
SELECT 
    l.p_nombre || ' ' || l.p_apellido AS lector,
    c.nombre_club,
    p.id_pago_mem AS recibo,
    p.fech_emision_pago AS fecha_pago
FROM pagos_membresias p, lectores l, clubes c
WHERE p.id_lector = l.id_lector
  AND p.id_club = c.id_club;

-- 6. Vista: V_AGENDA_REUNIONES
-- Detalla las reuniones programadas, el libro a discutir y el grupo correspondiente.

CREATE OR REPLACE VIEW v_agenda_reuniones AS
SELECT 
    r.fecha_reunion, 
    c.nombre_club, 
    g.tipo AS tipo_grupo, 
    b.titulo_libro,
    r.realizada
FROM reuniones_calendario r, clubes c, grupos g, libros b
WHERE r.id_club_grupo = c.id_club
  AND r.id_grupo = g.id_grupo
  AND r.id_libro = b.isbn;

-- 7. Vista: V_CONTACTOS_SISTEMA 
-- Resuelve el arco exclusivo de la tabla TELÉFONOS para consolidar contactos de clubes y lectores.

CREATE OR REPLACE VIEW v_contactos_sistema AS
SELECT 
    'CLUB' AS origen,
    c.nombre_club AS entidad,
    '(' || t.cod_local || ') ' || t.cod_area || '-' || t.num_tlf AS numero_completo
FROM telefonos t, clubes c
WHERE t.id_club = c.id_club
UNION
SELECT 
    'LECTOR' AS origen,
    l.p_nombre || ' ' || l.p_apellido AS entidad,
    '(' || t.cod_local || ') ' || t.cod_area || '-' || t.num_tlf AS numero_completo
FROM telefonos t, lectores l
WHERE t.id_lector = l.id_lector;

-- 8. Vista: V_IDIOMAS_HABLADOS 
-- Resuelve el arco exclusivo de la tabla HABLAN para listar los idiomas manejados por cada entidad.

CREATE OR REPLACE VIEW v_idiomas_hablados AS
SELECT 
    i.nom_idioma,
    'CLUB' AS tipo_entidad,
    c.nombre_club AS nombre_entidad
FROM hablan h, idiomas i, clubes c
WHERE h.id_idioma = i.id_idioma
  AND h.id_club = c.id_club
UNION
SELECT 
    i.nom_idioma,
    'LECTOR' AS tipo_entidad,
    l.p_nombre || ' ' || l.p_apellido AS nombre_entidad
FROM hablan h, idiomas i, lectores l
WHERE h.id_idioma = i.id_idioma
  AND h.id_lector = l.id_lector;

-- 9. Vista: V_LIBROS_FAVORITOS 
-- Muestra el ranking de libros preferidos por cada lector según la tabla corregida.

CREATE OR REPLACE VIEW v_libros_favoritos AS
SELECT 
    l.p_nombre || ' ' || l.p_apellido AS lector,
    b.titulo_libro,
    f.id_orden AS rango_preferencia
FROM favoritos f, lectores l, libros b
WHERE f.id_lector = l.id_lector
  AND f.id_libro = b.isbn
ORDER BY lector, f.id_orden;

-- 10. Vista: V_REPORTE_INASISTENCIAS 
-- Detalla los socios que faltaron a reuniones específicas, vinculando la información de inasistentes.

CREATE OR REPLACE VIEW v_reporte_inasistencias AS
SELECT 
    i.r_fecha_reun AS fecha_reunion,
    l.p_nombre || ' ' || l.p_apellido AS socio_ausente,
    c.nombre_club,
    b.titulo_libro
FROM inasistentes i, lectores l, clubes c, libros b
WHERE i.id_lector = l.id_lector
  AND i.id_club_soc = c.id_club
  AND i.r_id_libro = b.isbn;

-- 11. Vista: V_PRODUCCION_OBRAS 
-- Resume el éxito de las obras teatrales basándose en sus presentaciones físicas.

CREATE OR REPLACE VIEW v_produccion_obras AS
SELECT 
    o.nombre_obra,
    p.fecha_presentacion,
    p.cantidad_asistentes,
    p.valoracion,
    o.precio AS costo_entrada
FROM obras o, presentaciones p
WHERE o.id_obra = p.id_obra;

-- 12. Vista: V_ELENCOS_Y_PREMIADOS 
-- Lista los lectores que participan en obras y destaca a los que han sido "Mejores Actores".

CREATE OR REPLACE VIEW v_elencos_y_premiados AS
SELECT 
    o.nombre_obra,
    l.p_nombre || ' ' || l.p_apellido AS actor,
    DECODE(m.id_lector, NULL, 'No', 'SÍ') AS fue_premiado,
    m.id_presentacion AS fecha_premio
FROM elencos e, obras o, lectores l, mejores_actores m
WHERE e.id_obra = o.id_obra
  AND e.id_lector = l.id_lector
  AND e.id_lector = m.id_lector (+)
  AND e.id_obra = m.id_obra (+);

-- 13. Vista: V_TRAYECTORIA_GRUPOS 
-- Muestra el historial de los socios a través de los diferentes grupos de lectura.

CREATE OR REPLACE VIEW v_trayectoria_grupos AS
SELECT 
    l.p_nombre || ' ' || l.p_apellido AS socio,
    c.nombre_club,
    g.tipo AS tipo_grupo,
    hg.fech_i_grupo AS fecha_inicio,
    hg.fecha_f_grupo AS fecha_fin
FROM historico_grupos hg, lectores l, clubes c, grupos g
WHERE hg.id_lector = l.id_lector
  AND hg.id_club_soc = c.id_club
  AND hg.id_grupo = g.id_grupo;

-- 14. Vista: V_CLUBES_ASOCIADOS 
-- Presenta las relaciones entre clubes registradas en la tabla asociaciones.

CREATE OR REPLACE VIEW v_clubes_asociados AS
SELECT 
    c1.nombre_club AS club_principal,
    c2.nombre_club AS club_asociado
FROM asociaciones a, clubes c1, clubes c2
WHERE a.id_club1 = c1.id_club
  AND a.id_club2 = c2.id_club;
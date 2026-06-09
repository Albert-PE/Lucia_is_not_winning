-- 1. Vista: V_DETALLE_LECTORES
CREATE OR REPLACE VIEW v_detalle_lectores AS
SELECT 
    l.id_lector, 
    l.p_nombre || ' ' || l.p_apellido AS nombre_lector, 
    l.email,
    r.p_nombre || ' ' || r.p_apellido AS nombre_representante
FROM MEA_LECTORES l
LEFT JOIN MEA_REPRESENTANTES r ON l.id_lector = r.id_lector;

SELECT * FROM v_detalle_lectores;

-- 2. Vista: V_CLUBES_INSTITUCIONES
CREATE OR REPLACE VIEW v_clubes_instituciones AS
SELECT 
    c.id_club, 
    c.nombre_club, 
    c.cuota_membresia,
    i.nom_inst AS nombre_institucion, 
    i.tipo_inst
FROM MEA_CLUBES c
LEFT JOIN MEA_INSTITUCIONES i ON c.id_inst = i.id_inst;

SELECT * FROM v_clubes_instituciones;

-- 3. Vista: V_SOCIOS_ACTIVOS
CREATE OR REPLACE VIEW v_socios_activos AS
SELECT 
    s.id_club, 
    c.nombre_club, 
    l.p_nombre || ' ' || l.p_apellido AS nombre_socio, 
    s.fech_i_socio AS fecha_ingreso
FROM MEA_SOCIOS s
JOIN MEA_CLUBES c ON s.id_club = c.id_club
JOIN MEA_LECTORES l ON s.id_lector = l.id_lector
WHERE s.status_socio = 'activo';

SELECT * FROM v_socios_activos;

-- 4. Vista: V_CATALOGO_LIBROS
CREATE OR REPLACE VIEW v_catalogo_libros AS
SELECT 
    b.isbn, 
    b.titulo_libro, 
    a.p_nombre || ' ' || a.p_apellido AS autor,
    p.nom_pais AS pais_origen,
    b.tipo_narrativa
FROM MEA_LIBROS b
JOIN MEA_A_L al ON b.isbn = al.isbn
JOIN MEA_AUTORES a ON al.id_autor = a.id_autor
JOIN MEA_PAISES p ON b.id_pais = p.id_pais;

SELECT * FROM v_catalogo_libros;

-- 5. Vista: V_HISTORIAL_PAGOS
CREATE OR REPLACE VIEW v_historial_pago_socios AS
SELECT 
    l.p_nombre || ' ' || l.p_apellido AS lector,
    c.nombre_club,
    p.id_pago_membresia AS recibo,
    p.fech_emision AS fecha_pago
FROM MEA_PAGOS_MEMBRESIAS p
JOIN MEA_LECTORES l ON p.id_lector = l.id_lector
JOIN MEA_CLUBES c ON p.id_club = c.id_club;

SELECT * FROM v_historial_pago_socios;

-- 6. Vista: V_AGENDA_REUNIONES
CREATE OR REPLACE VIEW v_agenda_reuniones AS
SELECT 
    r.fech_reunion, 
    c.nombre_club, 
    g.tipo AS tipo_grupo, 
    b.titulo_libro,
    r.realizada
FROM MEA_REUNIONES_CALENDARIO r
JOIN MEA_CLUBES c ON r.id_club = c.id_club
JOIN MEA_GRUPOS g ON r.id_club = g.id_club AND r.id_grupo = g.id_grupo
JOIN MEA_LIBROS b ON r.isbn = b.isbn;

SELECT * FROM v_agenda_reuniones;

-- 7. Vista: V_CONTACTOS_SISTEMA
CREATE OR REPLACE VIEW v_contactos_sistema AS
SELECT 
    'CLUB' AS origen,
    c.nombre_club AS entidad,
    '(' || t.cod_local || ') ' || t.cod_area || '-' || t.num_tlf AS numero_completo
FROM MEA_TELEFONOS t
JOIN MEA_CLUBES c ON t.id_club = c.id_club
UNION
SELECT 
    'LECTOR' AS origen,
    l.p_nombre || ' ' || l.p_apellido AS entidad,
    '(' || t.cod_local || ') ' || t.cod_area || '-' || t.num_tlf AS numero_completo
FROM MEA_TELEFONOS t
JOIN MEA_LECTORES l ON t.id_lector = l.id_lector;

SELECT * FROM v_contactos_sistema;

-- 8. Vista: V_IDIOMAS_HABLADOS
CREATE OR REPLACE VIEW v_idiomas_hablados AS
SELECT 
    i.nom_idioma,
    'CLUB' AS tipo_entidad,
    c.nombre_club AS nombre_entidad
FROM MEA_HABLAN h
JOIN MEA_IDIOMAS i ON h.id_idioma = i.id_idioma
JOIN MEA_CLUBES c ON h.id_club = c.id_club
UNION
SELECT 
    i.nom_idioma,
    'LECTOR' AS tipo_entidad,
    l.p_nombre || ' ' || l.p_apellido AS nombre_entidad
FROM MEA_HABLAN h
JOIN MEA_IDIOMAS i ON h.id_idioma = i.id_idioma
JOIN MEA_LECTORES l ON h.id_lector = l.id_lector;

SELECT * FROM v_idiomas_hablados;

-- 9. Vista: V_LIBROS_FAVORITOS
CREATE OR REPLACE VIEW v_libros_favoritos AS
SELECT 
    l.p_nombre || ' ' || l.p_apellido AS lector,
    b.titulo_libro,
    f.orden AS rango_preferencia
FROM MEA_FAVORITOS f
JOIN MEA_LECTORES l ON f.id_lector = l.id_lector
JOIN MEA_LIBROS b ON f.isbn = b.isbn
ORDER BY lector, f.orden;

SELECT * FROM v_libros_favoritos;

-- 10. Vista: V_REPORTE_INASISTENCIAS
CREATE OR REPLACE VIEW v_reporte_inasistencias AS
SELECT 
    i.fech_reunion AS fecha_reunion,
    l.p_nombre || ' ' || l.p_apellido AS socio_ausente,
    c.nombre_club,
    b.titulo_libro
FROM MEA_INASISTENTES i
JOIN MEA_LECTORES l ON i.id_lector = l.id_lector
JOIN MEA_CLUBES c ON i.id_club_soc = c.id_club
JOIN MEA_LIBROS b ON i.isbn = b.isbn;

SELECT * FROM v_reporte_inasistencias;

-- 11. Vista: V_PRODUCCION_OBRAS
CREATE OR REPLACE VIEW v_produccion_obras AS
SELECT 
    o.nombre_obra,
    p.fech_presentacion,
    p.cantidad_asistentes,
    p.valoracion,
    o.precio AS costo_entrada
FROM MEA_OBRAS o
JOIN MEA_PRESENTACIONES p ON o.id_obra = p.id_obra;

SELECT * FROM v_produccion_obras;

-- 12. Vista: V_ELENCOS_Y_PREMIADOS
CREATE OR REPLACE VIEW v_elencos_y_premiados AS
SELECT 
    o.nombre_obra,
    l.p_nombre || ' ' || l.p_apellido AS actor,
    CASE WHEN m.id_lector IS NULL THEN 'No' ELSE 'SÍ' END AS fue_premiado,
    m.id_fech_presentacion AS fecha_premio
FROM MEA_ELENCOS e
JOIN MEA_OBRAS o ON e.id_obra = o.id_obra
JOIN MEA_LECTORES l ON e.id_lector = l.id_lector
LEFT JOIN MEA_MEJORES_ACTORES m ON e.id_lector = m.id_lector AND e.id_obra = m.id_obra_elenco;

SELECT * FROM v_elencos_y_premiados;

-- 13. Vista: V_TRAYECTORIA_GRUPOS
CREATE OR REPLACE VIEW v_trayectoria_grupos AS
SELECT 
    l.p_nombre || ' ' || l.p_apellido AS socio,
    c.nombre_club,
    g.tipo AS tipo_grupo,
    hg.fech_i_hist_grupo AS fecha_inicio,
    hg.fech_f_hist_grupo AS fecha_fin
FROM MEA_HISTORICO_GRUPOS hg
JOIN MEA_LECTORES l ON hg.id_lector = l.id_lector
JOIN MEA_CLUBES c ON hg.id_club_soc = c.id_club
JOIN MEA_GRUPOS g ON hg.id_club_grupo = g.id_club AND hg.id_grupo = g.id_grupo;

SELECT * FROM v_trayectoria_grupos;

-- 14. Vista: V_CLUBES_ASOCIADOS
CREATE OR REPLACE VIEW v_clubes_asociados AS
SELECT 
    c1.nombre_club AS club_principal,
    c2.nombre_club AS club_asociado
FROM MEA_ASOCIACIONES a
JOIN MEA_CLUBES c1 ON a.id_club1 = c1.id_club
JOIN MEA_CLUBES c2 ON a.id_club2 = c2.id_club;

SELECT * FROM v_clubes_asociados;

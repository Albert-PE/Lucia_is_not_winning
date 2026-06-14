-- =============================================================================
-- INSERTS DE PRUEBA PARA FUNCIONES (TABLAS FALTANTES)
-- Basado en Club ID 1: Círculo de Lectura del Fin del Mundo
-- =============================================================================

-- 1. MEA_SOCIOS (Inscripción de lectores al Club 1)
INSERT INTO MEA_SOCIOS (id_club, id_lector, fech_i_socio, status_socio)
VALUES (1, 1, TO_DATE('01-01-2024', 'DD-MM-YYYY'), 'activo');
INSERT INTO MEA_SOCIOS (id_club, id_lector, fech_i_socio, status_socio)
VALUES (1, 2, TO_DATE('01-01-2024', 'DD-MM-YYYY'), 'activo');
INSERT INTO MEA_SOCIOS (id_club, id_lector, fech_i_socio, status_socio)
VALUES (1, 3, TO_DATE('01-01-2024', 'DD-MM-YYYY'), 'activo');
INSERT INTO MEA_SOCIOS (id_club, id_lector, fech_i_socio, status_socio)
VALUES (1, 4, TO_DATE('01-01-2024', 'DD-MM-YYYY'), 'activo');
INSERT INTO MEA_SOCIOS (id_club, id_lector, fech_i_socio, status_socio)
VALUES (1, 5, TO_DATE('01-01-2024', 'DD-MM-YYYY'), 'activo');

-- 2. MEA_GRUPOS (Creación de un grupo tipo 'adulto' para el Club 1)
-- Reunión los Martes (3) a las 18:00
INSERT INTO MEA_GRUPOS (id_club, id_grupo, fech_creacion, tipo, dia_reunion, hora_i_reunion)
VALUES (1, 1, TO_DATE('01-01-2024', 'DD-MM-YYYY'), 'adulto', 3, 18);

-- 3. MEA_HISTORICO_GRUPOS (Asignación de los socios al Grupo 1)
INSERT INTO MEA_HISTORICO_GRUPOS (id_club_grupo, id_grupo, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo)
VALUES (1, 1, 1, 1, TO_DATE('01-01-2024', 'DD-MM-YYYY'), TO_DATE('01-01-2024', 'DD-MM-YYYY'));
INSERT INTO MEA_HISTORICO_GRUPOS (id_club_grupo, id_grupo, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo)
VALUES (1, 1, 1, 2, TO_DATE('01-01-2024', 'DD-MM-YYYY'), TO_DATE('01-01-2024', 'DD-MM-YYYY'));
INSERT INTO MEA_HISTORICO_GRUPOS (id_club_grupo, id_grupo, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo)
VALUES (1, 1, 1, 3, TO_DATE('01-01-2024', 'DD-MM-YYYY'), TO_DATE('01-01-2024', 'DD-MM-YYYY'));
INSERT INTO MEA_HISTORICO_GRUPOS (id_club_grupo, id_grupo, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo)
VALUES (1, 1, 1, 4, TO_DATE('01-01-2024', 'DD-MM-YYYY'), TO_DATE('01-01-2024', 'DD-MM-YYYY'));
INSERT INTO MEA_HISTORICO_GRUPOS (id_club_grupo, id_grupo, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo)
VALUES (1, 1, 1, 5, TO_DATE('01-01-2024', 'DD-MM-YYYY'), TO_DATE('01-01-2024', 'DD-MM-YYYY'));

-- 4. MEA_REUNIONES_CALENDARIO (4 Reuniones en Mayo 2026 para el libro 'El Aleph')
-- Nota: id_lector 1 actúa como el moderador/responsable del registro
INSERT INTO MEA_REUNIONES_CALENDARIO (id_club, id_grupo, isbn, fech_reunion, realizada, id_club_hist, id_grupo_hist, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo, conclusion, valoracion, ult_discusion)
VALUES (1, 1, 9788420633114, TO_DATE('05-05-2026', 'DD-MM-YYYY'), 'SI', 1, 1, 1, 1, TO_DATE('01-01-2024', 'DD-MM-YYYY'), TO_DATE('01-01-2024', 'DD-MM-YYYY'), 'Excelente inicio', 4.5, 'NO');

INSERT INTO MEA_REUNIONES_CALENDARIO (id_club, id_grupo, isbn, fech_reunion, realizada, id_club_hist, id_grupo_hist, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo, conclusion, valoracion, ult_discusion)
VALUES (1, 1, 9788420633114, TO_DATE('12-05-2026', 'DD-MM-YYYY'), 'SI', 1, 1, 1, 1, TO_DATE('01-01-2024', 'DD-MM-YYYY'), TO_DATE('01-01-2024', 'DD-MM-YYYY'), 'Análisis de cuentos', 4.0, 'NO');

INSERT INTO MEA_REUNIONES_CALENDARIO (id_club, id_grupo, isbn, fech_reunion, realizada, id_club_hist, id_grupo_hist, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo, conclusion, valoracion, ult_discusion)
VALUES (1, 1, 9788420633114, TO_DATE('19-05-2026', 'DD-MM-YYYY'), 'SI', 1, 1, 1, 1, TO_DATE('01-01-2024', 'DD-MM-YYYY'), TO_DATE('01-01-2024', 'DD-MM-YYYY'), 'Debate profundo', 4.8, 'NO');

INSERT INTO MEA_REUNIONES_CALENDARIO (id_club, id_grupo, isbn, fech_reunion, realizada, id_club_hist, id_grupo_hist, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo, conclusion, valoracion, ult_discusion)
VALUES (1, 1, 9788420633114, TO_DATE('26-05-2026', 'DD-MM-YYYY'), 'SI', 1, 1, 1, 1, TO_DATE('01-01-2024', 'DD-MM-YYYY'), TO_DATE('01-01-2024', 'DD-MM-YYYY'), 'Cierre de lectura', 5.0, 'SI');

-- 5. MEA_INASISTENTES (Simulando ausencias para pruebas de porcentaje)
-- María (id 2) faltó el 5 y el 19 de Mayo
INSERT INTO MEA_INASISTENTES (id_club_reu, id_grupo_reu, isbn, fech_reunion, id_club_hist, id_grupo_hist, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo)
VALUES (1, 1, 9788420633114, TO_DATE('05-05-2026', 'DD-MM-YYYY'), 1, 1, 1, 2, TO_DATE('01-01-2024', 'DD-MM-YYYY'), TO_DATE('01-01-2024', 'DD-MM-YYYY'));
INSERT INTO MEA_INASISTENTES (id_club_reu, id_grupo_reu, isbn, fech_reunion, id_club_hist, id_grupo_hist, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo)
VALUES (1, 1, 9788420633114, TO_DATE('19-05-2026', 'DD-MM-YYYY'), 1, 1, 1, 2, TO_DATE('01-01-2024', 'DD-MM-YYYY'), TO_DATE('01-01-2024', 'DD-MM-YYYY'));

-- Carlos (id 3) faltó el 12 de Mayo
INSERT INTO MEA_INASISTENTES (id_club_reu, id_grupo_reu, isbn, fech_reunion, id_club_hist, id_grupo_hist, id_club_soc, id_lector, fech_i_socio, fech_i_hist_grupo)
VALUES (1, 1, 9788420633114, TO_DATE('12-05-2026', 'DD-MM-YYYY'), 1, 1, 1, 3, TO_DATE('01-01-2024', 'DD-MM-YYYY'), TO_DATE('01-01-2024', 'DD-MM-YYYY'));

COMMIT;

-- =============================================================================
-- QUERIES DE PRUEBA PARA EVALUACIÓN (12 CASOS - 3 POR FUNCIÓN)
-- Nota: Los casos 3 usan variables '&' para generar POPUPS interactivos.
-- =============================================================================

-- IMPORTANTE: Habilitamos DEFINE para que los popups funcionen
SET DEFINE ON;

-- -----------------------------------------------------------------------------
-- FUNCIÓN 1: MEA_conversion_monetaria(p_id_pais, p_monto, p_tasa)
-- -----------------------------------------------------------------------------

-- Caso 1.1: Convertir 1000 VED (Venezuela, ID 1) a USD con tasa de 40.
-- SELECT * FROM TABLE(MEA_conversion_monetaria(1, 1000, 40));

-- Caso 1.2: Convertir 50 EUR (España, ID 2) a USD con tasa de 0.92.
-- SELECT * FROM TABLE(MEA_conversion_monetaria(2, 50, 0.92));

-- Caso 1.3: INTERACTIVO (Popup)
-- Instrucción: Ingrese id_pais=14 (Reino Unido), monto=100, tasa_cambio=0.79
-- SELECT * FROM TABLE(MEA_conversion_monetaria(&id_pais, &monto, &tasa_cambio));


-- -----------------------------------------------------------------------------
-- FUNCIÓN 2: MEA_edad_miembro y MEA_antiguedad_miembro
-- -----------------------------------------------------------------------------

-- Caso 2.1: Edad de Juan Pérez (ID 1).
-- SELECT p_nombre, MEA_edad_miembro(id_lector) AS EDAD FROM MEA_LECTORES WHERE id_lector = 1;

-- Caso 2.2: Antigüedad de Juan Pérez (ID 1) en el club.
-- SELECT p_nombre, MEA_antiguedad_miembro(id_lector) AS ANIOS_EN_CLUB FROM MEA_LECTORES WHERE id_lector = 1;

-- Caso 2.3: INTERACTIVO (Popup)
-- Instrucción: Ingrese el ID del lector (ej. 1)
-- SELECT p_nombre, MEA_edad_miembro(id_lector) as edad, MEA_antiguedad_miembro(id_lector) as antiguedad FROM MEA_LECTORES WHERE id_lector = &id_lector;




-- -----------------------------------------------------------------------------
-- FUNCIÓN 3: MEA_promedio_part_mensual_tipo(id_club, mes, año)
-- -----------------------------------------------------------------------------

-- Caso 3.1: Club 1, Mayo 2026. (Retorna VARCHAR2 con promedios por tipo)
-- SELECT MEA_promedio_part_mensual_tipo(1, 5, 2026) AS PROMEDIO_CLUB_MAYO FROM DUAL;

-- Caso 3.2: Club 1, Abril 2026.
-- SELECT MEA_promedio_part_mensual_tipo(1, 4, 2026) AS PROMEDIO_CLUB_ABRIL FROM DUAL;

-- Caso 3.3: INTERACTIVO (Popup)
-- Instrucción: Ingrese id_club=1, mes=5, anio=2026
-- SELECT MEA_promedio_part_mensual_tipo(&id_club, &mes, &anio) AS PROMEDIO_INTERACTIVO FROM DUAL;


-- -----------------------------------------------------------------------------
-- FUNCIÓN 4: MEA_participacion_bimestre_miembro(id_lector, fecha_limite)
-- -----------------------------------------------------------------------------

-- Caso 4.1: Participación de María García (ID 2) al 01-06-2026. (Resultado: 50%)
-- SELECT MEA_participacion_bimestre_miembro(2, TO_DATE('01-06-2026', 'DD-MM-YYYY')) AS PART_MARIA FROM DUAL;

-- Caso 4.2: Participación de Juan Pérez (ID 1) al 01-06-2026. (Resultado: 100%)
-- SELECT MEA_participacion_bimestre_miembro(1, TO_DATE('01-06-2026', 'DD-MM-YYYY')) AS PART_JUAN FROM DUAL;

-- Caso 4.3: INTERACTIVO (Popup)
-- Instrucción: Ingrese id_lector=2, fecha_inicial_DD_MM_YYYY=01-06-2026
-- SELECT MEA_participacion_bimestre_miembro(&id_lector, TO_DATE('&fecha_inicial_DD_MM_YYYY', 'DD-MM-YYYY')) AS PARTICIPACIÓN FROM DUAL;



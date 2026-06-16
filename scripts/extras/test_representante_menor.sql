-- =============================================================================
-- PRUEBAS PARA TRIGGER MEA_TRG_REPRESENTANTE_MENOR Y MEA_inscribir_miembro
-- =============================================================================
SET SERVEROUTPUT ON SIZE 1000000;
SET FEEDBACK ON;

PROMPT =========================================================================
PROMPT CASO 1: Intentar inscribir menor de edad SIN representante
PROMPT (Debe fallar con ORA-20040)
PROMPT =========================================================================
BEGIN
    -- Intentamos inscribir un lector nacido en 2018 (tendrá ~8 años en 2026)
    -- Sin proveer p_id_repre_lector ni p_doc_repre_ext
    MEA_inscribir_miembro(
        p_doc_identidad   => 88811122,
        p_p_nombre        => 'Carlitos',
        p_s_nombre        => 'Jose',
        p_p_apellido      => 'Gomez',
        p_s_apellido      => 'Perez',
        p_f_nacimiento    => TO_DATE('15-05-2018', 'DD-MM-YYYY'),
        p_email           => 'carlitos@email.com',
        p_id_club         => 1
    );
    DBMS_OUTPUT.PUT_LINE('ERROR: Se permitio la inscripcion sin representante.');
    ROLLBACK;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('EXITO ESPERADO: Fallo controlado.');
        DBMS_OUTPUT.PUT_LINE('Mensaje de Oracle: ' || SQLERRM);
        ROLLBACK;
END;
/

PROMPT =========================================================================
PROMPT CASO 2: Inscribir menor de edad CON representante lector (Lector ID 1)
PROMPT (Debe completarse con EXITO)
PROMPT =========================================================================
BEGIN
    MEA_inscribir_miembro(
        p_doc_identidad   => 88811133,
        p_p_nombre        => 'Pedrito',
        p_s_nombre        => 'Luis',
        p_p_apellido      => 'Perez',
        p_s_apellido      => 'Gomez',
        p_f_nacimiento    => TO_DATE('10-10-2016', 'DD-MM-YYYY'),
        p_email           => 'pedrito@email.com',
        p_id_club         => 1,
        p_id_repre_lector => 1 -- Lector 1 es Adulto
    );
    DBMS_OUTPUT.PUT_LINE('EXITO: Pedrito fue inscrito correctamente.');
    ROLLBACK; -- Deshacemos para no alterar datos de prueba
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR INESPERADO: ' || SQLERRM);
        ROLLBACK;
END;
/

PROMPT =========================================================================
PROMPT CASO 3: Inscribir menor de edad CON representante externo
PROMPT (Debe completarse con EXITO)
PROMPT =========================================================================
BEGIN
    MEA_inscribir_miembro(
        p_doc_identidad   => 88811144,
        p_p_nombre        => 'Anita',
        p_s_nombre        => 'Maria',
        p_p_apellido      => 'Diaz',
        p_s_apellido      => 'Flores',
        p_f_nacimiento    => TO_DATE('20-12-2014', 'DD-MM-YYYY'),
        p_email           => 'anita@email.com',
        p_id_club         => 1,
        p_doc_repre_ext   => 12345678,
        p_nom_repre_ext   => 'Carlos',
        p_ape_repre_ext   => 'Diaz',
        p_sape_repre_ext  => 'Flores'
    );
    DBMS_OUTPUT.PUT_LINE('EXITO: Anita fue inscrita correctamente.');
    ROLLBACK; -- Deshacemos para no alterar datos de prueba
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR INESPERADO: ' || SQLERRM);
        ROLLBACK;
END;
/

SET SERVEROUTPUT ON SIZE 1000000
SET VERIFY OFF
SET FEEDBACK OFF
SET LINESIZE 200
SET PAGESIZE 50

UNDEFINE v_doc_identidad
UNDEFINE v_p_nombre
UNDEFINE v_s_nombre
UNDEFINE v_p_apellido
UNDEFINE v_s_apellido
UNDEFINE v_f_nacimiento
UNDEFINE v_email
UNDEFINE v_id_club

CLEAR SCREEN
PROMPT
PROMPT ######################################################################
PROMPT #                 INSCRIPCION DE NUEVO MIEMBRO                       #
PROMPT ######################################################################
PROMPT

ACCEPT v_doc_identidad PROMPT '>> Ingrese Documento de Identidad (ej. 12345678): '
ACCEPT v_p_nombre      PROMPT '>> Ingrese Primer Nombre: '
ACCEPT v_s_nombre      PROMPT '>> Ingrese Segundo Nombre: '
ACCEPT v_p_apellido    PROMPT '>> Ingrese Primer Apellido: '
ACCEPT v_s_apellido    PROMPT '>> Ingrese Segundo Apellido: '
PROMPT (Formato Fecha: YYYY-MM-DD)
ACCEPT v_f_nacimiento  PROMPT '>> Ingrese Fecha de Nacimiento (ej. 2005-05-10): '
ACCEPT v_email         PROMPT '>> Ingrese Email: '
ACCEPT v_id_club       PROMPT '>> Ingrese ID del Club al que se une: '

PROMPT
PROMPT Procesando inscripcion...

BEGIN
    MEA_inscribir_miembro(
        p_doc_identidad      => &v_doc_identidad,
        p_p_nombre           => '&v_p_nombre',
        p_s_nombre           => '&v_s_nombre',
        p_p_apellido         => '&v_p_apellido',
        p_s_apellido         => '&v_s_apellido',
        p_f_nacimiento       => TO_DATE('&v_f_nacimiento', 'YYYY-MM-DD'),
        p_email              => '&v_email',
        p_id_club            => &v_id_club
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('!!! ERROR EN LA INSCRIPCION !!!');
        DBMS_OUTPUT.PUT_LINE('Mensaje Oracle: ' || SQLERRM);
        ROLLBACK;
END;
/

PROMPT
PROMPT Presione ENTER para terminar...
PAUSE

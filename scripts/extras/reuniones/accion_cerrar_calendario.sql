PROMPT >>> CIERRE DE DISCUSIÓN DE LIBRO
PROMPT

SET FEEDBACK OFF
SET SERVEROUTPUT ON

BEGIN
    MEA_cerrar_calendario(
        p_id_club      => &ID_Club, 
        p_id_grupo     => &ID_Grupo, 
        p_isbn         => &ISBN_Libro, 
        p_fecha_cierre => TO_DATE('&Fecha_Cierre_DD_MM_YYYY','DD-MM-YYYY'), 
        p_valoracion   => &Valoracion_0_a_5, 
        p_conclusion   => '&Conclusion_Final'
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' ');
        DBMS_OUTPUT.PUT_LINE('!!! ERROR DETECTADO !!!');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        DBMS_OUTPUT.PUT_LINE(' ');
END;
/

PROMPT Cierre procesado. Volviendo al menú...
@@menu_reuniones.sql

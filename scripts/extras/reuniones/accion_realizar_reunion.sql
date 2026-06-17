PROMPT >>> MARCAR REUNIÓN COMO REALIZADA
PROMPT

SET FEEDBACK OFF
SET SERVEROUTPUT ON

BEGIN
    MEA_realizar_reunion(
        p_id_club  => &ID_Club, 
        p_id_grupo => &ID_Grupo, 
        p_isbn     => &ISBN_Libro, 
        p_fecha    => TO_DATE('&Fecha_Reunion_DD_MM_YYYY','DD-MM-YYYY')
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' ');
        DBMS_OUTPUT.PUT_LINE('!!! ERROR DETECTADO !!!');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        DBMS_OUTPUT.PUT_LINE(' ');
END;
/

PROMPT Volviendo al menú...
@@menu_reuniones.sql

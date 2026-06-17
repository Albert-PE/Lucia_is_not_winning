PROMPT >>> GENERAR NUEVO CALENDARIO DE DISCUSIÓN
PROMPT

SET FEEDBACK OFF
SET SERVEROUTPUT ON

BEGIN
    MEA_generar_calendario(
        p_id_club      => &ID_Club, 
        p_id_grupo     => &ID_Grupo, 
        p_isbn         => &ISBN_Libro, 
        p_fecha_inicio => TO_DATE('&Fecha_Inicio_DD_MM_YYYY','DD-MM-YYYY'), 
        p_cant_reun    => &Cant_Reuniones, 
        p_id_lector    => &ID_Lector_Moderador
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

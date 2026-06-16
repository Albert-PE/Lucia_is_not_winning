PROMPT >>> CIERRE DE DISCUSIÓN DE LIBRO
PROMPT

EXEC MEA_cerrar_calendario(&ID_Club, &ID_Grupo, &ISBN_Libro, TO_DATE('&Fecha_Cierre_DD_MM_YYYY','DD-MM-YYYY'), &Valoracion_0_a_5, '&Conclusion_Final');

PROMPT Cierre procesado. Volviendo al menú...
@@menu_reuniones.sql

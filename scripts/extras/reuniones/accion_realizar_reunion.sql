PROMPT >>> MARCAR REUNIÓN COMO REALIZADA
PROMPT

EXEC MEA_realizar_reunion(&ID_Club, &ID_Grupo, &ISBN_Libro, TO_DATE('&Fecha_Reunion_DD_MM_YYYY','DD-MM-YYYY'));

PROMPT Proceso completado. Volviendo al menú...
@@menu_reuniones.sql

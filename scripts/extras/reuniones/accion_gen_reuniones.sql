PROMPT >>> GENERAR NUEVO CALENDARIO DE DISCUSIÓN
PROMPT

-- Los parámetros se pedirán automáticamente al ejecutar el bloque
EXEC MEA_generar_calendario(&ID_Club, &ID_Grupo, &ISBN_Libro, TO_DATE('&Fecha_Inicio_DD_MM_YYYY','DD-MM-YYYY'), &Cant_Reuniones, &ID_Lector_Moderador);

PROMPT Proceso completado. Volviendo al menú...
@@menu_reuniones.sql

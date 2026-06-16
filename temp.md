1) Generar Calendario de reuniones (REUNIONES_CALENDARIO)
2) Control de Calendario de reuniones 
3) Control de asistencia
4) Cierre de discusiones de libro (Registrar Valoración y comentarios)

tener en cuenta que: 
-GRUPOS DISTINTOS PUEDEN ESTAR DISCUTIENDO SOBRE EL MISMO LIBRO.
-EL MISMO GRUPO SOLO PUEDE TENER 1 CALENDARIO ACTIVO (un calendario se considera ACTIVO hasta que exista alguna reunión dentro del mismo que tenga realizada='SI' y ult_discusion='SI'. Si no se ha marcado ninguna reunión como la última y realizada, el calendario completo para ese grupo sigue activo).
-Grupos del mismo club pueden agendar reuniones la misma semana o el mismo día; también grupos de distintos clubes sin problemas. Lo que no puede pasar es que el calendario de un mismo grupo agende 2 reuniones exactamente el mismo día (esto está protegido por la combinación de claves primarias en la tabla REUNIONES_CALENDARIO, donde la fecha_reunion forma parte de la PK). Adicionalmente, por lógica de negocio, se asume el límite de 1 reunión por semana para el mismo grupo.

1) Generación: Se debe pedir el ID del club e ID del grupo. Luego, tras validar que NO tienen un calendario activo actualmente, se debe preguntar al usuario la cantidad de reuniones que habrá para discutir el libro y la FECHA DE LA PRIMERA REUNIÓN. NO SE PUEDEN CREAR REUNIONES EN FECHAS QUE YA PASARON, solo en fechas a futuro. 
El programa DEBE VALIDAR que esa fecha inicial coincida con el día de la semana pautado por el GRUPO en la tabla MEA_GRUPOS (ej: si el grupo se reúne los martes, la fecha ingresada debe caer en martes, de lo contrario se lanza un error y se rechaza la operación).
Si la fecha de inicio es válida, el sistema generará automáticamente todas las reuniones solicitadas, sumando iterativamente +7 días a la fecha inicial. 
Sin importar cuántas reuniones se generen, al momento de crearlas NUNCA se le pone a ninguna ult_discusion = 'SI' (eso se hace exclusivamente en la fase de cierre).
Se debe pedir el ID del lector que actuará como MODERADOR. Este moderador debe ser exclusivamente miembro activo de ese mismo club y grupo. LA ÚNICA EXCEPCIÓN es para los grupos infantiles ('infantil'), cuyo moderador debe ser obligatoriamente un adulto del mismo club (se debe comprobar que pertenece a un grupo de adultos). El moderador asignado será el mismo para todas las reuniones de ese calendario y NO PUEDE estar moderando otro grupo simultáneamente (restringido por trigger). Un moderador ocupado solo puede participar en otros grupos como lector, no como moderador.

2) Dividida en 3 sub opciones:

-Realizar reuniones: Permite marcar las reuniones como realizadas. Primero pregunta al usuario un id de grupo y de club, mostrando sus reuniones de su calendario. Muestra solo las reuniones pasadas y NO realizadas y por fecha y por ID, y luego de mostrar pregunta al usuario un único ID de reunion del calendario para marcar como realizada. //TODO: Roxana dice que las reuniones futuras también deberian mostrarse.

-Modificar fecha reuniones: Permite cambiar la fecha de una reunión futura, manteniendo la validación del día de la semana del grupo.

-Agregar reuniones: utilizado en caso de que se hayan pautado X reuniones pero no alcanzó para terminar de discutir el libro. Se agregan al final del calendario sumando semanas.

3) Se debe poder saber el porcentaje de asistencia por bimestre y por tipo de grupos (reutilizar las funciones ya creadas). También se quiere saber la cantidad de miembros de un grupo y en comparación a esa cantidad, los asistentes por todas las reuniones que han habido (Realizadas=si). De forma que el resultado de la consulta queda:

Miembros: 
ASISTENTES REUNION 1:
ASISTENTES REUNION 2:
.
.
.
ASISTENTES REUNION N:  

4) Cierre: Se pide al usuario el ID del grupo, el ID del club y la fecha de la reunión que marcará el final de la discusión. 
- Si la reunión estaba marcada como realizada='NO', se cambia a 'SI'.
- Se marca esa reunión como la última (ult_discusion='SI').
- AL CERRAR, EL SISTEMA DEBE ELIMINAR AUTOMÁTICAMENTE CUALQUIER REUNIÓN FUTURA O PENDIENTE QUE HAYA QUEDADO EN EL CALENDARIO PARA ESE LIBRO Y GRUPO (limpieza de registros "en el aire").
- Se debe validar que el calendario no esté ya cerrado.
- Al cerrar, se deben pedir obligatoriamente los valores de Valoración (0-5) y Conclusión mediante inputs (&).

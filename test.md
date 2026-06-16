# Hoja de Ruta - Automatización de Reuniones (Rúbrica 2.2)

## Fase 1: Blindaje Físico (Triggers)
Objetivo: Garantizar que ninguna entrada manual o automática viole las reglas de integridad.
- [ ] Trigger de Validación de Día: La fecha de reunión debe coincidir con el día pautado por el grupo.
- [ ] Trigger de Moderador: Validar que sea del mismo grupo o adulto para grupos infantiles.
- [ ] Trigger de Calendario Único: Impedir iniciar un nuevo libro si hay uno activo.

## Fase 2: Motor Lógico (Stored Procedures)
Objetivo: Automatizar los procesos de negocio.
- [ ] `MEA_generar_calendario`: Generación automática de N reuniones (+7 días).
- [ ] `MEA_realizar_reunion`: Marcado de realización.
- [ ] `MEA_modificar_fecha`: Cambio de fecha con validación de día.
- [ ] `MEA_cerrar_calendario`: Cierre de ciclo y limpieza de registros huérfanos.

## Fase 3: Interfaz de Usuario (SQL Scripts)
Objetivo: Crear el sistema de menús interactivos.
- [ ] Actualización de `menu_reuniones.sql`.
- [ ] Creación de acciones (`accion_*.sql`) con captación de datos `&`.

## Fase 4: Integración
- [ ] Consolidación en archivo final TXT.

---
## Casos de Prueba (Defensa con Lúcia)
1. **Día Erróneo**: Intentar insertar reunión un jueves cuando el grupo es de los martes. (Falla esperado).
2. **Moderador Inválido**: Niño moderando a niños. (Falla esperado).
3. **Generación Auto**: Pedir 3 reuniones y ver las fechas +7 días creadas. (Éxito esperado).
4. **Limpieza de Cierre**: Cerrar en reunión 1 de 3 y verificar que las otras 2 se borran. (Éxito esperado).

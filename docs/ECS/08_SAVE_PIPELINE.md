# SAVE PIPELINE

**Documento:** 08_SAVE_PIPELINE.md

**Fase:** ECS Framework

**Estado:** Draft

**Versión:** 1.0

---

# Objetivo

Este documento define la arquitectura del Save Pipeline del Framework ECS de Survivors Lords.

El Save Pipeline es responsable de transformar el estado completo del mundo en una representación persistente y, posteriormente, reconstruir dicho estado durante la carga.

Este documento no define formatos específicos de archivo ni la lógica del Save System.

Define exclusivamente el pipeline interno del Framework ECS.

---

# Alcance

Este documento define:

- Arquitectura del Save Pipeline.
- Serialización.
- Deserialización.
- Save Context.
- Load Context.
- Entity Mapping.
- Component Serialization.
- Resource References.
- Versionado.
- Validación.
- Integración con ECS.
- Integración con Resource Registry.
- Integración con Multiplayer.
- Debug.
- Profiling.

---

# Filosofía

El Save Pipeline debe ser completamente independiente del gameplay.

Los Systems nunca escriben directamente archivos de guardado.

Los Systems únicamente exponen el estado que debe persistirse.

El Framework coordina todo el proceso.

---

# Objetivos

El Save Pipeline debe garantizar:

- Persistencia determinista.
- Restauración consistente.
- Compatibilidad entre versiones.
- Bajo acoplamiento.
- Escalabilidad.
- Validación automática.
- Integridad de datos.

---

# Arquitectura General

Conceptualmente.

```text
World

↓

Save Pipeline

↓

Serialization

↓

Save Data

↓

Storage
```

Durante la carga:

```text
Storage

↓

Load Data

↓

Deserialization

↓

Rebuild ECS

↓

World Ready
```

---

# Principios Fundamentales

El Save Pipeline únicamente persiste el estado dinámico del mundo.

Nunca almacena:

- Systems.
- Queries.
- Events.
- Schedulers.
- Resources completos.

Solo almacena la información necesaria para reconstruir el estado del ECS.

---

# Estado Persistente

Entre los datos persistentes se incluyen:

- Entities.
- Components.
- Relaciones.
- IDs.
- Estado del mundo.
- Tiempo de simulación.
- Variables globales.

Todo dato persistente debe ser determinista.

---

# Estado No Persistente

No forman parte del guardado:

- Event Queue.
- Deferred Commands.
- Query Cache.
- Result Sets.
- Pools.
- Profiling.
- Métricas temporales.

Estos elementos se reconstruyen automáticamente al cargar.

---

# Save Pipeline

Conceptualmente.

```text
Freeze World

↓

Collect Data

↓

Serialize

↓

Validate

↓

Write Save
```

Cada etapa posee responsabilidades claramente definidas.

---

# Save Context

El Save Context representa el estado interno utilizado durante el proceso de guardado.

Puede contener información como:

- Mapeo de Entities.
- Recursos temporales.
- Estadísticas.
- Versiones.
- Opciones del proceso.

El Save Context existe únicamente durante la operación de guardado.

---

# Load Context

Durante la carga se crea un Load Context independiente.

Su responsabilidad consiste en coordinar:

- Reconstrucción de Entities.
- Restauración de referencias.
- Resolución de Resources.
- Validaciones.

---

# Congelación del Mundo

Antes de iniciar la serialización, el Framework debe garantizar que el estado del mundo permanezca estable.

Conceptualmente.

```text
Scheduler

↓

Finish Frame

↓

Flush Commands

↓

Dispatch Events

↓

Freeze World

↓

Save
```

Nunca debe iniciarse un guardado con modificaciones estructurales pendientes.

---

# Recolección de Datos

Una vez congelado el mundo, el Framework recopila:

- Todas las Entities persistentes.
- Todos los Components persistentes.
- Estado global.
- Referencias a Resources.

La recolección nunca modifica el ECS.

---

# Serialización

Cada Component persistente transforma su estado en una representación serializable.

El proceso debe ser:

- Determinista.
- Reproducible.
- Independiente de la plataforma.

---

# Continúa en la Parte 2

La siguiente parte desarrollará:

- Serialización de Components.
- Entity Mapping.
- Referencias entre Entities.
- Resource IDs.
- Validación.
- Versionado.
- Integridad de datos.
- Pipeline de restauración.
---

# Serialización de Components

Cada Component persistente es responsable de exponer exclusivamente los datos necesarios para reconstruir su estado.

La serialización nunca debe incluir:

- Lógica.
- Referencias a Systems.
- Cachés.
- Datos temporales.
- Estado derivado que pueda recalcularse.

El objetivo es minimizar el tamaño del archivo y garantizar consistencia.

---

# Componentes Persistentes

No todos los Components forman parte del archivo de guardado.

Cada Component debe definir explícitamente si su estado es:

- Persistente.
- Temporal.

Solo los Components persistentes participan del Save Pipeline.

---

# Componentes Temporales

Los Components temporales representan información válida únicamente durante la ejecución.

Ejemplos conceptuales:

- Pathfinding temporal.
- Estado de navegación.
- Datos de depuración.
- Buffers internos.
- Resultados de Queries.

Estos Components se recrean automáticamente cuando sea necesario.

---

# Entity Mapping

Las referencias entre Entities no pueden almacenarse mediante punteros o referencias de memoria.

El Framework utiliza un sistema de mapeo.

Conceptualmente.

```text
Runtime Entity

↓

Persistent Entity ID

↓

Save File
```

Durante la carga:

```text
Persistent Entity ID

↓

Runtime Entity

↓

Restore References
```

---

# Persistent Entity ID

Toda Entity persistente debe poseer un identificador estable dentro del archivo de guardado.

Este identificador existe únicamente para el proceso de serialización.

No reemplaza al Entity ID utilizado durante la ejecución.

---

# Restauración de Referencias

Muchas Entities contienen referencias a otras Entities.

Ejemplo.

```text
Follower

↓

Leader Entity
```

Durante la serialización se almacena el Persistent Entity ID.

Durante la carga:

```text
Leader Persistent ID

↓

Lookup

↓

Runtime Entity
```

De esta forma se reconstruyen correctamente todas las relaciones.

---

# Referencias a Resources

Los Resources nunca se serializan completos.

Únicamente se almacena su identificador.

Ejemplo.

```text
Weapon Component

↓

weapon.iron_sword
```

Durante la carga:

```text
weapon.iron_sword

↓

Resource Registry

↓

Weapon Resource
```

---

# Orden de Serialización

El orden de escritura debe ser completamente determinista.

Conceptualmente.

```text
World Data

↓

Entities

↓

Components

↓

Global State

↓

Metadata
```

Este orden debe mantenerse entre versiones compatibles.

---

# Validación

Antes de escribir el archivo, el Framework debe comprobar:

- IDs válidos.
- Referencias resueltas.
- Components persistentes válidos.
- Datos obligatorios presentes.
- Integridad estructural.

Si la validación falla, el guardado debe cancelarse.

---

# Integridad

El Save Pipeline debe garantizar que:

- Ninguna Entity aparezca duplicada.
- Ningún Component inválido sea serializado.
- Ninguna referencia quede rota.
- Ningún dato obligatorio falte.

---

# Versionado

Todo archivo de guardado debe incluir información de versión.

Ejemplo conceptual.

```text
Save Version

World Version

Data Version

Framework Version
```

Esto permite detectar incompatibilidades antes de iniciar la carga.

---

# Compatibilidad

Cuando sea posible, el Framework puede migrar archivos generados por versiones anteriores.

Conceptualmente.

```text
Save v1

↓

Migration

↓

Save v2
```

Las migraciones deben ser explícitas y estar documentadas.

---

# Pipeline de Carga

El proceso de restauración sigue el siguiente flujo.

```text
Read Save

↓

Validate

↓

Create Context

↓

Create Entities

↓

Restore Components

↓

Resolve References

↓

Finalize World
```

Cada etapa debe completarse antes de iniciar la siguiente.

---

# Creación de Entities

En primer lugar se crean todas las Entities persistentes.

Todavía no contienen Components.

Únicamente se establece el mapeo entre:

- Persistent Entity ID.
- Runtime Entity ID.

Esto permite resolver referencias posteriormente.

---

# Restauración de Components

Una vez creadas las Entities, el Framework restaura todos sus Components persistentes.

Cada Component recupera exclusivamente el estado almacenado en el archivo.

Las validaciones deben ejecutarse antes de incorporar el Component al ECS.

---

# Resolución de Referencias

Cuando todas las Entities y Components existen, el Framework reconstruye las relaciones internas.

Ejemplos:

- Padre / Hijo.
- Inventarios.
- Equipamiento.
- Objetivos.
- Seguimiento.
- Relaciones entre NPCs.

En este punto todas las referencias persistentes deben quedar completamente resueltas.

---

# Estado Final

Una vez finalizado el proceso:

- Todas las Entities existen.
- Todos los Components persistentes fueron restaurados.
- Todas las referencias son válidas.
- El mundo puede volver a integrarse al Scheduler.

---

# Continúa en la Parte 3

La siguiente parte desarrollará:

- Integración con Resource Registry.
- Integración con Multiplayer.
- Recuperación ante errores.
- Herramientas de Debug.
- Profiling.
- Optimización.
- Buenas prácticas.
- Anti-patrones.
- Convenciones.
- Estado final del documento.
---

# Integración con Resource Registry

El Save Pipeline depende del Resource Registry para reconstruir correctamente todas las referencias a datos estáticos.

Los Resources siempre deben encontrarse completamente cargados antes de iniciar el proceso de restauración.

Conceptualmente.

```text
Load Resources

↓

Resource Registry Ready

↓

Load Save

↓

Resolve Resource IDs
```

Si el Resource Registry no está disponible, la carga no puede continuar.

---

# Integración con ECS

La restauración del mundo debe respetar el ciclo de vida del Framework ECS.

Conceptualmente.

```text
Create Entities

↓

Restore Components

↓

Update Signatures

↓

Rebuild Queries

↓

World Ready
```

El Scheduler no debe ejecutar ningún System hasta que el proceso haya finalizado.

---

# Integración con Query System

Durante la carga, el Query System permanece inactivo.

Una vez restaurados todos los Components, el Framework reconstruye automáticamente:

- Signatures.
- Result Sets.
- Cachés.
- Índices internos.

Los Systems nunca participan de este proceso.

---

# Integración con Event Bus

La restauración del estado del mundo no debe generar Events de gameplay.

Ejemplos incorrectos:

- EntityCreated.
- ItemEquipped.
- DamageApplied.
- QuestCompleted.

Estos eventos representan hechos ocurridos durante la simulación, no durante la reconstrucción del mundo.

Si el Framework necesita comunicar el progreso del proceso de carga, deberá utilizar eventos internos del pipeline, independientes del Event Bus de gameplay.

---

# Integración con Multiplayer

El Save Pipeline es independiente del Multiplayer Pipeline.

El servidor puede utilizar el mismo mecanismo para:

- Guardado automático.
- Persistencia del mundo.
- Backups.
- Migraciones.

Los clientes no deben reconstruir el estado mediante archivos de guardado durante una sesión multijugador.

Reciben el estado exclusivamente a través del Multiplayer Pipeline.

---

# Recuperación ante Errores

Si ocurre un error durante la carga, el Framework debe cancelar la restauración de forma segura.

Conceptualmente.

```text
Load

↓

Validation Error

↓

Abort

↓

Cleanup

↓

Report Error
```

Nunca debe quedar un mundo parcialmente restaurado.

---

# Rollback

Si la carga falla después de crear Entities o Components, el Framework debe:

- Liberar las Entities creadas.
- Limpiar Components.
- Vaciar Contexts temporales.
- Restablecer el ECS a un estado consistente.

El rollback debe ser completamente automático.

---

# Debug Tools

El Framework debe proporcionar herramientas para inspeccionar el proceso de guardado y carga.

Estas herramientas son exclusivas del entorno de desarrollo.

---

# Save Inspector

El Save Inspector permite visualizar:

- Metadata.
- Entities persistidas.
- Components persistidos.
- Versiones.
- Referencias.
- Tamaño de los datos.

Esta herramienta facilita la validación del contenido almacenado.

---

# Load Report

Al finalizar una carga el Framework puede generar un informe con:

- Entities creadas.
- Components restaurados.
- Referencias resueltas.
- Tiempo de restauración.
- Advertencias.
- Errores detectados.

---

# Profiling

El Save Pipeline debe recopilar métricas como:

- Tiempo de serialización.
- Tiempo de escritura.
- Tiempo de lectura.
- Tiempo de deserialización.
- Tiempo de reconstrucción.
- Tiempo total del proceso.

Estas métricas permiten optimizar el rendimiento del pipeline.

---

# Optimización

El Save Pipeline debe minimizar:

- Copias de memoria.
- Asignaciones dinámicas.
- Conversión innecesaria de datos.
- Accesos redundantes al Resource Registry.

El objetivo es mantener tiempos de guardado y carga predecibles incluso en mundos de gran tamaño.

---

# Buenas Prácticas

Se recomienda:

- Persistir únicamente el estado necesario.
- Utilizar identificadores estables.
- Evitar datos derivados.
- Validar automáticamente antes de guardar.
- Mantener compatibilidad entre versiones mediante migraciones documentadas.
- Separar claramente datos persistentes y temporales.

---

# Anti-Patrones

El Framework prohíbe expresamente:

- Guardar Resources completos.
- Serializar Systems.
- Serializar Queries.
- Serializar Events.
- Serializar Deferred Commands.
- Acceder directamente al sistema de archivos desde un System.
- Modificar el ECS mientras el mundo se encuentra congelado.

---

# Convenciones

Todo proceso de guardado deberá cumplir las siguientes reglas:

- Es determinista.
- Es reproducible.
- No modifica el estado del mundo.
- Utiliza el Resource Registry para resolver datos estáticos.
- Mantiene separación entre datos persistentes y temporales.
- Finaliza con un ECS completamente consistente.

---

# Resumen del Pipeline

```text
Finish Frame
        │
        ▼
Flush Deferred Commands
        │
        ▼
Freeze World
        │
        ▼
Collect Persistent Data
        │
        ▼
Serialize
        │
        ▼
Validate
        │
        ▼
Write Save
```

Proceso de carga:

```text
Read Save
        │
        ▼
Validate
        │
        ▼
Create Entities
        │
        ▼
Restore Components
        │
        ▼
Resolve References
        │
        ▼
Rebuild ECS
        │
        ▼
World Ready
```

---

# Garantías del Save Pipeline

Al finalizar un guardado el Framework garantiza que:

- El archivo representa un estado consistente del mundo.
- Todas las referencias persistentes son válidas.
- Todos los Resources se almacenan mediante identificadores.
- El estado dinámico puede reconstruirse completamente.

Al finalizar una carga el Framework garantiza que:

- Todas las Entities fueron recreadas.
- Todos los Components persistentes fueron restaurados.
- Todas las referencias fueron resueltas.
- El Query System fue reconstruido.
- El Scheduler puede reanudar la simulación con seguridad.

---

# Relación con el Framework

El Save Pipeline interactúa con:

- ECS.
- Scheduler.
- Resource Registry.
- Query System.
- Entity Registry.
- Component Registry.
- Multiplayer Pipeline.
- Debug Tools.

Sin embargo, mantiene una única responsabilidad:

**Persistir y restaurar el estado dinámico del mundo de forma determinista, consistente e independiente del gameplay.**

---

# Estado

**Estado actual:** Especificación del Save Pipeline.

Este documento define el contrato técnico para la implementación del sistema de persistencia del Framework ECS de Survivors Lords.

Todo proceso de guardado y carga deberá utilizar exclusivamente el pipeline aquí descrito. Cualquier modificación al modelo de serialización, restauración, versionado o resolución de referencias deberá documentarse mediante una DEC (Design Engineering Change) antes de su implementación.
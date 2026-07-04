# QUERY SYSTEM

**Documento:** 06_QUERY_SYSTEM.md

**Fase:** ECS Framework

**Estado:** Draft

**Versión:** 1.0

---

# Objetivo

Este documento define la arquitectura completa del Query System del Framework ECS de Survivors Lords.

El Query System constituye el mecanismo oficial mediante el cual los Systems acceden a las Entities y Components del mundo.

Su diseño debe permitir consultas altamente eficientes, deterministas y completamente desacopladas de la implementación interna del ECS.

No describe gameplay.

No define Components.

No define Systems.

Únicamente especifica la infraestructura responsable del acceso a los datos del mundo.

---

# Alcance

Este documento define:

- Arquitectura del Query System.
- Query Registry.
- Query Builder.
- Query Cache.
- Entity Matching.
- Component Matching.
- Signatures.
- Actualización automática.
- Iteración.
- Acceso Read / Write.
- Optimización.
- Integración con Scheduler.
- Integración con Event Bus.
- Integración con Save.
- Integración con Multiplayer.
- Debug.
- Profiling.

---

# Filosofía

Uno de los principios fundamentales del Framework ECS es que los Systems nunca conocen cómo están almacenados los datos.

Los Systems únicamente conocen Queries.

Toda búsqueda, filtrado e iteración pertenece exclusivamente al Query System.

---

# Objetivos

El Query System debe garantizar:

- Alto rendimiento.
- Bajo acoplamiento.
- Determinismo.
- Escalabilidad.
- Iteración eficiente.
- Actualización automática.
- Consistencia.
- Compatibilidad Multiplayer.
- Compatibilidad Save.
- Compatibilidad Replay.

---

# Principios Fundamentales

Todo acceso a Components debe realizarse mediante Queries.

Los Systems nunca deben:

- Buscar Entities manualmente.
- Recorrer listas completas.
- Acceder directamente a Storages.
- Acceder al Entity Registry.
- Acceder al Component Registry.

Toda interacción ocurre mediante el Query System.

---

# Arquitectura General

Conceptualmente.

```text
System

↓

Query

↓

Query System

↓

Entity Matching

↓

Result Set

↓

Iteración
```

---

# ¿Qué es una Query?

Una Query representa una descripción de las Entities que un System desea procesar.

No representa datos.

No representa lógica.

Representa únicamente un criterio de selección.

---

# Filosofía de una Query

Una Query responde a la pregunta:

> ¿Qué Entities cumplen determinadas condiciones?

Nunca responde:

> ¿Qué debe hacer el System?

---

# Componentes de una Query

Conceptualmente una Query se compone de:

```text
Required Components

Excluded Components

Optional Components

Filters

Access Mode
```

Cada uno cumple una función específica.

---

# Required Components

Representan los Components obligatorios.

Ejemplo conceptual.

```text
Transform

Velocity
```

La Entity debe poseer ambos Components para pertenecer al resultado.

---

# Excluded Components

Permiten excluir determinadas Entities.

Ejemplo.

```text
Dead
```

Las Entities que posean este Component no serán incluidas.

---

# Optional Components

Representan información adicional.

La Entity puede poseerlos o no.

Su ausencia nunca elimina la Entity del resultado.

---

# Filters

Los Filters representan condiciones adicionales.

Ejemplos conceptuales:

- Distancia.
- Equipo.
- Nivel.
- Estado.
- Autoridad.
- Zona.

Los filtros nunca modifican el ECS.

---

# Access Mode

Toda Query declara cómo accederá a los datos.

Existen dos modos.

## Read

Solo lectura.

---

## Read / Write

Lectura y escritura.

Esta información será utilizada por el Scheduler para resolver dependencias y preparar la futura ejecución paralela.

---

# Query System

El Query System constituye un servicio central del Framework.

Conceptualmente.

```text
Query System

├── Query Registry
├── Query Builder
├── Matcher
├── Cache
├── Iterators
└── Metrics
```

---

# Responsabilidades

El Query System es responsable de:

- Registrar Queries.
- Resolver coincidencias.
- Mantener resultados actualizados.
- Optimizar iteraciones.
- Gestionar cachés.
- Detectar cambios estructurales.
- Mantener determinismo.

Nunca ejecuta gameplay.

---

# Query Registry

Todas las Queries permanentes se registran durante la inicialización del Framework.

Ejemplo conceptual.

```text
Movement Query

Combat Query

Inventory Query

Enemy Query
```

El Scheduler reutiliza estas Queries durante toda la ejecución.

---

# Query Builder

El Query Builder es responsable de construir una Query válida a partir de los criterios definidos por un System.

Conceptualmente.

```text
Builder

↓

Required

↓

Excluded

↓

Optional

↓

Build Query
```

El resultado es una definición inmutable.

---

# Inmutabilidad

Una vez construida, una Query nunca modifica su estructura.

Si un System necesita otro criterio de búsqueda, deberá construir una nueva Query.

Esto garantiza consistencia y facilita el almacenamiento en caché.

---

# Query Handle

Cada Query registrada recibe un identificador único.

Los Systems conservan este identificador y lo utilizan para acceder al resultado correspondiente.

Nunca interactúan directamente con la implementación interna del Query System.

---

# Continúa en la Parte 2

La siguiente parte desarrollará:

- Entity Matching.
- Signatures.
- Archetypes conceptuales.
- Query Cache.
- Actualización automática.
- Detección de cambios estructurales.
- Consistencia del resultado.
- Ciclo de vida de una Query.
---

# Entity Matching

El objetivo principal del Query System consiste en determinar qué Entities satisfacen una determinada Query.

Este proceso se denomina **Entity Matching**.

El Matching debe ser:

- Determinista.
- Incremental.
- Altamente eficiente.
- Transparente para los Systems.

---

# Filosofía

Una Query nunca recorre todas las Entities del mundo en cada Frame.

En su lugar, el Framework mantiene un conjunto de resultados actualizado automáticamente.

Los Systems únicamente iteran dicho conjunto.

---

# Signatures

Cada Entity posee una Signature que describe su composición de Components.

Conceptualmente.

```text
Entity

↓

Signature

↓

[Transform]
[Velocity]
[Health]
```

La Signature representa únicamente la presencia o ausencia de Components.

Nunca almacena datos.

---

# Objetivo de la Signature

Las Signatures permiten determinar rápidamente si una Entity cumple una Query.

No es necesario inspeccionar cada Component individualmente.

---

# Matching por Signature

Conceptualmente.

```text
Query

Requires

Transform

Velocity

↓

Entity Signature

Transform ✔

Velocity ✔

Health ✔

↓

MATCH
```

---

# Ejemplo de No Coincidencia

```text
Query

Requires

Transform

Velocity

↓

Entity Signature

Transform ✔

Velocity ✖

Health ✔

↓

NO MATCH
```

La Entity no pertenece al resultado.

---

# Components Requeridos

Todos los Components marcados como **Required** deben estar presentes.

La ausencia de uno solo invalida el Matching.

---

# Components Excluidos

Si una Signature contiene un Component excluido por la Query, la Entity queda descartada.

Ejemplo.

```text
Required

Transform

↓

Excluded

Dead

↓

Entity

Transform ✔

Dead ✔

↓

NO MATCH
```

---

# Components Opcionales

Los Components opcionales nunca afectan al Matching.

Únicamente proporcionan información adicional al System.

---

# Matching Determinista

Una misma Signature siempre produce el mismo resultado para una Query determinada.

No depende de:

- Frame.
- Orden de ejecución.
- Hardware.
- Multiplayer.

Esto garantiza reproducibilidad.

---

# Query Result Set

El resultado de una Query recibe el nombre de **Result Set**.

Conceptualmente.

```text
Movement Query

↓

Entity 4

Entity 18

Entity 41

Entity 63
```

Los Systems iteran únicamente este conjunto.

---

# Persistencia del Result Set

El Result Set permanece almacenado mientras la Query exista.

No se reconstruye completamente en cada Frame.

Solo se actualiza cuando cambia la composición del ECS.

---

# Actualización Incremental

Cuando una Entity cambia de Signature:

```text
Add Component

↓

Nueva Signature

↓

Reevaluar Matching

↓

Actualizar Result Set
```

No es necesario recalcular todas las Queries.

---

# Cambios Estructurales

Las siguientes operaciones obligan a reevaluar el Matching:

- Crear Entity.
- Destruir Entity.
- Agregar Component.
- Eliminar Component.
- Activar Entity.
- Desactivar Entity.

Las modificaciones de valores internos de un Component no afectan al Matching.

---

# Integración con Deferred Commands

Las reevaluaciones nunca ocurren inmediatamente.

Siempre se ejecutan durante el Flush de Deferred Commands.

Conceptualmente.

```text
Simulation

↓

Deferred Commands

↓

Actualizar Signatures

↓

Actualizar Queries

↓

Continuar Frame
```

Esto garantiza un estado consistente para todos los Systems.

---

# Query Cache

Cada Query mantiene un caché con su Result Set.

Conceptualmente.

```text
Query Cache

Movement

↓

[4]

[18]

[41]

[63]
```

El Scheduler reutiliza este resultado durante la ejecución.

---

# Objetivos del Caché

El Query Cache permite:

- Evitar búsquedas repetidas.
- Reducir recorridos completos.
- Mejorar localidad de memoria.
- Minimizar costo por Frame.

---

# Invalidación del Caché

El caché únicamente se invalida cuando ocurre un cambio estructural relevante.

Ejemplos:

- Nuevo Component requerido.
- Eliminación de Component.
- Creación de Entity.
- Destrucción de Entity.

En ausencia de estos cambios, el Result Set permanece intacto.

---

# Ciclo de Vida de una Query

Toda Query sigue el mismo ciclo.

```text
Create

↓

Register

↓

Build

↓

Match

↓

Cache

↓

Iterate

↓

Update

↓

Dispose
```

---

# Registro

Durante el Startup, el Query Registry registra todas las Queries permanentes.

Cada Query recibe:

- Identificador.
- Definición.
- Acceso.
- Result Set.
- Estadísticas.

---

# Construcción

El Query Builder transforma la definición lógica en una estructura optimizada para el Matching.

Este proceso ocurre una sola vez.

---

# Matching Inicial

Al registrarse una Query:

```text
Todas las Entities

↓

Matching

↓

Result Set Inicial
```

A partir de ese momento solo se aplican actualizaciones incrementales.

---

# Actualización Automática

El Framework mantiene cada Query sincronizada automáticamente.

Los Systems nunca solicitan una actualización manual.

Esto elimina una fuente importante de errores.

---

# Consistencia

Durante la ejecución de un System, el Result Set nunca cambia.

Todas las modificaciones estructurales esperan al siguiente Flush.

Por lo tanto, cada iteración observa una vista completamente consistente del mundo.

---

# Garantías

El Query System garantiza que:

- Ninguna Entity aparece duplicada.
- Ninguna Entity inválida permanece en el Result Set.
- Toda Entity válida aparece exactamente una vez.
- Todas las Queries permanecen sincronizadas con el ECS.

---

# Continúa en la Parte 3

La siguiente parte desarrollará:

- Iteradores.
- Acceso Read / Write.
- Seguridad durante la iteración.
- Optimización de memoria.
- Índices internos.
- Localidad de datos.
- Rendimiento esperado.
- Integración con el Scheduler.
---

# Iteración

Una vez obtenido el Result Set, los Systems procesan las Entities mediante Iteradores.

El objetivo del Iterador es proporcionar un recorrido seguro, eficiente y determinista sobre el conjunto de resultados.

Los Systems nunca iteran directamente sobre los Storages internos.

---

# Filosofía

La iteración debe ser:

- Determinista.
- Cache Friendly.
- Predecible.
- Segura.
- Independiente de la implementación interna.

Desde la perspectiva de un System, iterar una Query siempre presenta la misma interfaz.

---

# Flujo General

Conceptualmente.

```text
Query

↓

Result Set

↓

Iterator

↓

Entity

↓

Components

↓

Process

↓

Next Entity
```

---

# Orden de Iteración

El Query System debe garantizar un orden estable de iteración.

Una misma Query, bajo el mismo estado del mundo, debe recorrer las Entities siempre en el mismo orden.

Esto es fundamental para:

- Multiplayer determinista.
- Replay.
- Debug.
- Testing.

---

# Orden Estable

El Framework puede utilizar distintos criterios internos para ordenar el Result Set.

Por ejemplo:

- Entity ID.
- Orden de creación.
- Índice interno.

La estrategia elegida debe mantenerse consistente durante toda la ejecución.

---

# Acceso a Components

Durante la iteración, el System obtiene acceso únicamente a los Components definidos por la Query.

Ejemplo conceptual.

```text
Query

Requires

Transform

Velocity
```

Durante la iteración:

```text
Entity

↓

Transform

↓

Velocity
```

El System no accede automáticamente a otros Components.

---

# Acceso Read Only

Las Queries de solo lectura garantizan que los Components no serán modificados.

Esto permite:

- Compartir datos entre múltiples Systems.
- Preparar la futura ejecución paralela.
- Reducir sincronizaciones.

---

# Acceso Read / Write

Cuando una Query declara acceso de escritura, el System puede modificar los Components obtenidos.

Ejemplo.

```text
Transform

↓

Actualizar Posición
```

El Scheduler utilizará esta información para evitar conflictos entre Systems.

---

# Restricciones Durante la Iteración

Mientras un System recorre una Query:

No puede:

- Crear Entities.
- Destruir Entities.
- Agregar Components.
- Eliminar Components.

Estas operaciones deben utilizar Deferred Commands.

---

# Modificación de Valores

Sí está permitido modificar el contenido de un Component cuando la Query posee acceso Read / Write.

Ejemplo.

```text
Health

100

↓

75
```

La composición de la Entity permanece inalterada.

---

# Cambios Estructurales

Los cambios estructurales nunca afectan una iteración en curso.

Ejemplo.

```text
Iterator

↓

Deferred Command

↓

Flush

↓

Actualizar Queries
```

La modificación se observa únicamente en la siguiente iteración.

---

# Seguridad

El Query System garantiza que durante una iteración:

- Ninguna Entity desaparece.
- Ningún Result Set cambia.
- Ningún índice se invalida.
- Ningún Iterador pierde consistencia.

---

# Query Iterator

Conceptualmente.

```text
Iterator

↓

Current Entity

↓

Next

↓

Next

↓

Next

↓

End
```

El Iterador mantiene el estado interno del recorrido.

---

# Finalización

Al terminar la iteración:

- Se liberan referencias temporales.
- Se actualizan métricas.
- El control vuelve al Scheduler.

No quedan referencias persistentes al Result Set.

---

# Localidad de Datos

Uno de los principales objetivos del Query System es favorecer la localidad de memoria.

Siempre que sea posible, los Components utilizados conjuntamente deben recorrerse de forma contigua.

Esto mejora:

- Uso de caché del procesador.
- Rendimiento.
- Escalabilidad.

---

# Índices Internos

El Query System puede mantener índices auxiliares para acelerar el Matching y la iteración.

Ejemplos conceptuales:

```text
Component Index
```

```text
Signature Index
```

```text
Entity Index
```

Estos índices forman parte de la implementación interna y permanecen ocultos para los Systems.

---

# Optimización de Iteración

El objetivo es minimizar:

- Saltos de memoria.
- Búsquedas.
- Asignaciones dinámicas.
- Conversión de estructuras.

Cada recorrido debe implicar la menor cantidad posible de operaciones adicionales.

---

# Reutilización

Los Iteradores deben reutilizar estructuras internas siempre que sea posible.

Esto reduce:

- Allocations.
- Garbage Collection.
- Fragmentación de memoria.

---

# Integración con el Scheduler

El Scheduler garantiza que un System nunca comience a iterar una Query mientras ésta se encuentre siendo actualizada.

Flujo conceptual.

```text
Flush

↓

Actualizar Queries

↓

Barrier

↓

Scheduler

↓

System

↓

Iteración
```

---

# Integración con Deferred Commands

Durante la iteración, los Deferred Commands únicamente se almacenan en el Command Buffer.

Nunca alteran el Result Set actual.

El cambio será visible después del siguiente Flush.

---

# Integración con el Event Bus

Los Systems pueden publicar Events durante la iteración.

Ejemplo.

```text
Iteración

↓

EnemyKilled

↓

Publish Event

↓

Continuar Iteración
```

La publicación de Events no modifica el Query System.

---

# Rendimiento Esperado

El Query System debe aspirar a:

- Iteración lineal respecto al tamaño del Result Set.
- Sin búsquedas adicionales durante el recorrido.
- Acceso directo a los Components solicitados.
- Excelente localidad de memoria.
- Costo constante para avanzar al siguiente elemento del Iterador.

---

# Garantías

Durante toda iteración el Framework garantiza que:

- El Result Set permanece estable.
- Las referencias son válidas.
- Ninguna Entity aparece duplicada.
- Ninguna Entity inválida es procesada.
- Los Components entregados corresponden exactamente a la definición de la Query.

---

# Continúa en la Parte 4

La siguiente parte desarrollará:

- Consultas dinámicas.
- Queries temporales.
- Composición de Queries.
- Integración con Multiplayer.
- Integración con Save.
- Query Pools.
- Profiling.
- Debug Tools.
- Validaciones.
- Convenciones.
- Anti-patrones.
- Estado final del documento.
---

# Queries Permanentes

Las Queries permanentes son aquellas registradas durante la inicialización del Framework.

Permanecen activas durante toda la ejecución del juego.

Ejemplos:

- Movement Query.
- Combat Query.
- Inventory Query.
- Building Query.
- AI Query.

Estas Queries representan la mayoría de las consultas del Framework.

---

# Queries Temporales

En determinadas situaciones un System puede necesitar una consulta puntual.

Estas Queries existen únicamente durante una operación específica.

Ejemplo.

```text
Create Query

↓

Execute

↓

Dispose
```

Una vez finalizada la operación, la Query deja de existir.

---

# Uso Recomendado

Las Queries temporales deben utilizarse únicamente cuando:

- No exista una Query permanente equivalente.
- El costo de mantenerla registrada no sea justificable.
- La operación sea excepcional.

No deben utilizarse dentro de la lógica principal ejecutada en cada Frame.

---

# Composición de Queries

Una Query puede combinar múltiples criterios.

Conceptualmente.

```text
Required

Transform

Health

Faction

↓

Excluded

Dead

Sleeping

↓

Optional

Equipment
```

La composición permanece inmutable una vez construida.

---

# Reutilización

Siempre que sea posible, un mismo System debe reutilizar la misma Query.

Crear Queries repetidamente implica:

- Mayor consumo de memoria.
- Mayor costo de construcción.
- Mayor trabajo para el Query Registry.

---

# Query Pools

El Framework puede reutilizar Queries temporales mediante Pools.

Conceptualmente.

```text
Acquire

↓

Configure

↓

Execute

↓

Reset

↓

Release
```

Esto reduce significativamente las asignaciones dinámicas.

---

# Integración con Multiplayer

El Query System nunca replica Queries.

Las Queries son estructuras locales del Framework.

Cada instancia del juego construye sus propias Queries utilizando el mismo conjunto de Components.

---

# Determinismo

Siempre que:

- Las Entities.
- Los Components.
- Las Signatures.

Sean idénticos, todas las instancias producirán exactamente el mismo Result Set.

Esta propiedad es esencial para el modelo Server Authoritative.

---

# Integración con Save Pipeline

Las Queries tampoco forman parte del archivo de guardado.

Durante la carga:

```text
Load Save

↓

Recrear Entities

↓

Recrear Components

↓

Reconstruir Signatures

↓

Reconstruir Queries
```

El Result Set se genera nuevamente a partir del estado reconstruido del ECS.

---

# Compatibilidad con Replay

El Query System debe producir exactamente los mismos resultados cuando:

- El estado inicial es idéntico.
- Los Commands son idénticos.
- El Scheduler ejecuta el mismo pipeline.

No depende del hardware ni del Frame Rate.

---

# Debug Tools

El Framework debe proporcionar herramientas para inspeccionar el estado del Query System.

Estas herramientas son exclusivas del modo Debug.

Nunca forman parte de la lógica de producción.

---

# Query Inspector

El Query Inspector permite visualizar todas las Queries registradas.

Ejemplo.

```text
Movement Query

Combat Query

Inventory Query

Enemy Query
```

También debe mostrar:

- Estado.
- Result Set.
- Estadísticas.
- Acceso.
- Número de Entities.

---

# Result Set Inspector

Debe ser posible visualizar el contenido de cualquier Result Set.

Ejemplo.

```text
Movement Query

↓

Entity 12

Entity 19

Entity 43

Entity 88
```

Esto facilita la validación del Matching.

---

# Signature Inspector

El Framework puede mostrar la Signature de una Entity.

Ejemplo.

```text
Entity 25

↓

Transform

Velocity

Health

Equipment
```

Esta herramienta resulta especialmente útil para detectar errores de composición.

---

# Métricas

El Query System debe recopilar estadísticas como:

- Número total de Queries.
- Queries activas.
- Queries temporales.
- Tiempo promedio de Matching.
- Tiempo de actualización.
- Cantidad de Result Sets.
- Tamaño promedio de cada Result Set.

---

# Profiling

En modo Debug el Framework puede registrar:

- Tiempo de construcción.
- Tiempo de Matching.
- Tiempo de actualización.
- Tiempo de iteración.
- Invalidaciones del caché.
- Cambios de Signature.

Estas métricas permiten localizar cuellos de botella.

---

# Validaciones

Durante desarrollo el Query System debe detectar automáticamente:

- Components inexistentes.
- Queries duplicadas.
- Access Modes incompatibles.
- Signatures inválidas.
- Result Sets inconsistentes.
- Iteradores inválidos.

---

# Buenas Prácticas

Se recomienda:

- Reutilizar Queries permanentes.
- Mantener Queries simples.
- Utilizar Components específicos.
- Evitar filtros innecesarios.
- Declarar correctamente el Access Mode.
- Utilizar Deferred Commands para modificaciones estructurales.

---

# Anti-Patrones

El Framework prohíbe expresamente:

- Buscar Entities manualmente.
- Recorrer todas las Entities del mundo.
- Acceder directamente al Entity Registry.
- Acceder directamente al Component Registry.
- Modificar Result Sets manualmente.
- Modificar Signatures desde un System.
- Construir Queries repetidamente en cada Frame cuando pueden reutilizarse.

---

# Convenciones

Toda Query deberá cumplir las siguientes reglas:

- Es inmutable.
- Describe únicamente criterios de selección.
- No contiene lógica.
- No conoce Systems.
- No conoce Entities específicas.
- No modifica el ECS.
- No administra memoria del Framework.

---

# Resumen del Ciclo de Vida

```text
Create Query
        │
        ▼
Register
        │
        ▼
Build
        │
        ▼
Match Entities
        │
        ▼
Generate Result Set
        │
        ▼
Iterate
        │
        ▼
Structural Changes
        │
        ▼
Update Result Set
        │
        ▼
Dispose (Temporary Queries)
```

---

# Garantías del Query System

Al finalizar cada Frame el Framework garantiza que:

- Todas las Queries reflejan el estado actual del ECS.
- Todos los Result Sets son consistentes.
- Ninguna Entity aparece duplicada.
- Ninguna Entity inválida permanece en un Result Set.
- Los Iteradores utilizados durante el Frame finalizaron correctamente.
- Los cachés permanecen sincronizados con las Signatures.

---

# Relación con el Framework

El Query System interactúa con:

- Scheduler.
- Entity Registry.
- Component Registry.
- Deferred Commands.
- Event Bus.
- Save Pipeline.
- Multiplayer Pipeline.
- Debug Tools.

Sin embargo, mantiene una única responsabilidad:

**Proporcionar un mecanismo eficiente, determinista y desacoplado para acceder a las Entities y Components del mundo.**

---

# Estado

**Estado actual:** Especificación de la arquitectura del Query System.

Este documento define el contrato técnico para la implementación del sistema de consultas del Framework ECS de Survivors Lords.

Toda lectura de datos del ECS deberá realizarse exclusivamente mediante Queries. Cualquier modificación al modelo de Matching, Result Sets, Signatures, cachés o acceso a Components deberá documentarse mediante una DEC (Design Engineering Change) antes de su implementación.
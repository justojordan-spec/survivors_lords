# COMPONENT LIFECYCLE

**Documento:** 03_COMPONENT_LIFECYCLE.md

**Fase:** ECS Framework

**Estado:** Draft

**Versión:** 1.0

---

# Objetivo

Este documento define el ciclo de vida completo de los Components dentro del Framework ECS de Survivors Lords.

Establece cómo los Components son creados, registrados, asociados a una Entity, modificados, sincronizados, eliminados y reciclados durante toda la ejecución del juego.

No describe ningún Component específico del juego.

No define reglas de gameplay.

Su propósito es especificar exclusivamente el comportamiento interno del Framework ECS.

---

# Alcance

Este documento define:

- Arquitectura del Component Registry.
- Component Storage.
- Asociación con Entities.
- Creación.
- Registro.
- Inicialización.
- Modificación.
- Dirty State.
- Versionado.
- Eliminación.
- Reciclado.
- Integración con Queries.
- Integración con Systems.
- Integración con Save.
- Integración con Multiplayer.

No define:

- Contenido de los Components.
- Gameplay.
- Lógica de Systems.
- Resources.

---

# Filosofía

Los Components representan únicamente datos.

Nunca contienen comportamiento.

Nunca ejecutan lógica.

Nunca conocen otros Components.

Nunca conocen Systems.

Nunca conocen Queries.

Nunca conocen Managers.

Nunca conocen Events.

Su única responsabilidad consiste en almacenar estado.

Toda modificación de dicho estado pertenece exclusivamente a los Systems.

---

# Principios de Diseño

El sistema de Components debe cumplir los siguientes principios.

- Data Only.
- Determinista.
- Cache Friendly.
- Escalable.
- Bajo acoplamiento.
- Server Authoritative.
- Serializable.
- Replicable.
- Seguro.
- Extensible.

---

# Definición de Component

Un Component representa una unidad mínima de información asociada a una Entity.

Ejemplos conceptuales:

- Position
- Rotation
- Velocity
- Health
- Inventory
- Hunger
- Stamina
- Equipment
- AI State

Para el Framework todos poseen exactamente el mismo tratamiento.

El Framework nunca distingue Components por gameplay.

Solo por su tipo.

---

# Características Fundamentales

Todo Component debe cumplir las siguientes reglas.

- Contener únicamente datos.
- No ejecutar lógica.
- No emitir eventos.
- No acceder a otros Components.
- No modificar Entities.
- No realizar Queries.
- No contener referencias a Systems.
- No depender del SceneTree.

---

# Arquitectura General

Cada tipo de Component posee su propio almacenamiento.

```text
Entity

↓

Component Registry

↓

Component Storage

↓

Component Data
```

Las Entities nunca almacenan directamente los Components.

Solo mantienen la relación lógica con ellos.

---

# Component Registry

El Component Registry constituye la autoridad sobre todos los Components registrados.

Es responsable de:

- Registrar tipos.
- Registrar Storage.
- Validar operaciones.
- Gestionar asociaciones.
- Actualizar Queries.
- Mantener índices.
- Coordinar cambios estructurales.

---

# Responsabilidades

El Registry debe garantizar:

- Integridad.
- Consistencia.
- Seguridad.
- Rendimiento.
- Compatibilidad con Save.
- Compatibilidad con Multiplayer.
- Compatibilidad con Debug.

---

# Arquitectura del Storage

Cada tipo de Component posee un Storage independiente.

Ejemplo conceptual.

```text
Health Storage

Entity 1

Entity 8

Entity 23

Entity 92
```

Otro ejemplo.

```text
Transform Storage

Entity 1

Entity 2

Entity 3

Entity 5
```

Nunca se mezclan distintos tipos de Components.

---

# Organización del Storage

Conceptualmente cada Storage mantiene dos estructuras.

```text
Dense Array

+

Lookup Table
```

El objetivo es permitir acceso constante.

---

# Dense Array

El Dense Array almacena únicamente los datos.

Ejemplo.

```text
Transform

0

1

2

3

4

5

6
```

Los datos permanecen contiguos en memoria.

Esto mejora significativamente el uso de caché del procesador.

---

# Lookup Table

La Lookup Table relaciona:

```text
Entity

↓

Dense Index
```

Ejemplo.

```text
Entity 14

↓

Index 2
```

La búsqueda es O(1).

---

# Asociación Entity → Component

Cuando una Entity recibe un Component ocurre el siguiente flujo.

```text
Create Component

↓

Store Data

↓

Register Lookup

↓

Update Signature

↓

Notify Query System
```

El proceso completo debe ser atómico.

---

# Creación de un Component

La creación nunca ocurre directamente desde una Entity.

Siempre es solicitada por un System.

```text
System

↓

Component Registry

↓

Storage

↓

Entity Update
```

Esto mantiene el desacoplamiento del Framework.

---

# Inicialización

Todo Component posee una fase de inicialización.

Durante esta fase:

- Se asignan valores iniciales.
- Se valida la configuración.
- Se reserva espacio.
- Se registra en el Storage.

Todavía no participa en Queries.

---

# Registro

Una vez inicializado:

- Se crea la relación con la Entity.
- Se actualiza la Signature.
- Se actualizan índices.
- Se notifican las Queries.

Solo entonces el Component pasa a formar parte del mundo lógico.

---

# Modificación

Modificar un Component no altera su existencia.

Únicamente cambia sus datos.

Ejemplo.

```text
Health

100

↓

85
```

La relación Entity → Component permanece exactamente igual.

---

# Cambios Estructurales

Existen únicamente dos operaciones estructurales.

- AddComponent
- RemoveComponent

Modificar valores internos no constituye un cambio estructural.

Esta diferencia es fundamental para el rendimiento del Framework.

---

# Integridad

Una Entity nunca puede poseer dos Components del mismo tipo.

Ejemplo inválido.

```text
Entity

Health

Health
```

El Registry debe impedir esta situación.

---

# Restricciones

Los Components nunca pueden:

- Crear Entities.
- Destruir Entities.
- Publicar Events.
- Ejecutar lógica.
- Modificar otros Components.
- Acceder al Registry.

Toda modificación debe pasar por un System.

---

# Costes Esperados

Las siguientes operaciones deben tener complejidad constante siempre que sea posible.

- Obtener Component.
- Agregar Component.
- Eliminar Component.
- Validar existencia.
- Obtener índice.

Objetivo.

```text
O(1)
```

---

# Componentos Vacíos (Tag Components)

El Framework admite Components sin datos.

Ejemplos.

```text
Player

Boss

Flying

Interactable

QuestTarget
```

Su existencia representa únicamente una característica lógica.

No almacenan información adicional.

---

# Beneficios de los Tag Components

Permiten:

- Simplificar Queries.
- Reducir memoria.
- Evitar enumeraciones innecesarias.
- Mejorar legibilidad.

Internamente solo modifican la Signature de la Entity.

---

# Componentos Compartidos

Algunos datos pueden compartirse entre múltiples Entities.

Ejemplo conceptual.

```text
WeaponDefinition

↓

Sword_01

↓

500 Entities
```

El Component almacena únicamente una referencia al Resource.

Nunca copia la configuración.

---

# Continúa en la Parte 2

La siguiente parte desarrollará:

- Component Pools.
- Add Component Pipeline.
- Remove Component Pipeline.
- Dirty Flags.
- Versionado.
- Change Detection.
- Invalidación de Queries.
- Deferred Operations.
- Component Dependencies.
- Validaciones internas.
---

# Component Pools

Cada tipo de Component debe disponer de un Pool propio administrado por el Component Registry.

El objetivo principal del Pool es minimizar:

- Allocations.
- Fragmentación de memoria.
- Creación de objetos temporales.
- Presión sobre el Garbage Collector.

El Pool nunca modifica la lógica del Framework.

Únicamente optimiza la administración de memoria.

---

# Arquitectura del Pool

Conceptualmente cada Storage administra su propio Pool.

```text
Transform Storage

├── Dense Array
├── Sparse Lookup
└── Free Slots
```

No existe un Pool global para todos los Components.

Cada tipo mantiene su propia estrategia de reutilización.

---

# Reserva de Memoria

El Storage puede reservar memoria por bloques.

Ejemplo conceptual:

```text
Capacidad Inicial

1024 Components

↓

Expansión

2048 Components

↓

Expansión

4096 Components
```

El crecimiento debe minimizar la cantidad de realocaciones.

---

# Reutilización

Cuando un Component es eliminado:

- El espacio queda disponible.
- El índice puede reutilizarse.
- No se destruye necesariamente la memoria.

Esto reduce considerablemente el costo de futuras inserciones.

---

# Add Component Pipeline

Agregar un Component constituye una modificación estructural.

Siempre debe seguir exactamente el mismo pipeline.

```text
Solicitud

↓

Validación

↓

Crear espacio

↓

Construcción

↓

Registro

↓

Actualizar Signature

↓

Actualizar Queries

↓

Actualizar Versiones

↓

Emitir Evento Interno
```

Ningún paso puede omitirse.

---

# Validaciones Previas

Antes de agregar un Component el Registry debe verificar:

- La Entity existe.
- El Handle es válido.
- La Entity está activa.
- El Component no existe previamente.
- El tipo está registrado.
- El Storage está disponible.

Si alguna validación falla la operación debe cancelarse.

---

# Inserción en el Storage

Una vez aprobada la operación:

```text
Dense Array

↓

Nuevo índice

↓

Guardar datos

↓

Actualizar Lookup
```

La inserción debe mantener la contigüidad del almacenamiento.

---

# Actualización de la Signature

Después de registrar el Component:

```text
Signature

↓

Agregar Bit

↓

Nueva Signature
```

Esta operación permite que las Queries detecten inmediatamente la nueva composición de la Entity.

---

# Actualización de Índices

Todo cambio estructural obliga al Registry a actualizar:

- Lookup Tables.
- Dense Index.
- Sparse Index.
- Query Cache.
- Versiones.

El Framework debe garantizar consistencia total antes de continuar.

---

# Remove Component Pipeline

Eliminar un Component sigue un proceso similar.

```text
Solicitud

↓

Validación

↓

Eliminar Lookup

↓

Liberar Storage

↓

Actualizar Signature

↓

Actualizar Queries

↓

Actualizar Versiones

↓

Emitir Evento Interno
```

---

# Eliminación Física

El Framework debe evitar dejar espacios vacíos dentro del Dense Array.

La estrategia recomendada es:

```text
Swap Back Removal
```

---

# Swap Back Removal

Ejemplo.

Antes:

```text
0 A

1 B

2 C

3 D
```

Eliminar B.

Después:

```text
0 A

1 D

2 C
```

Finalmente se actualiza el Lookup correspondiente.

Esta estrategia mantiene la memoria compacta.

---

# Ventajas

Beneficios del Swap Back:

- Eliminación O(1).
- Sin fragmentación.
- Excelente localidad de memoria.
- Alto rendimiento.

La única consecuencia es que el orden interno puede cambiar.

El Framework nunca debe depender del orden físico de los Components.

---

# Dirty State

Modificar un Component puede requerir que otros Systems conozcan el cambio.

Para ello cada Component puede marcarse como Dirty.

Ejemplo.

```text
Transform

Dirty = True
```

---

# Objetivo del Dirty State

Permite evitar trabajo innecesario.

Ejemplo.

Si un Transform no cambió:

No es necesario:

- recalcular matrices
- actualizar físicas
- sincronizar red
- recalcular navegación

---

# Dirty Flags

Cada Storage puede mantener un conjunto de Flags.

Ejemplo conceptual.

```text
Clean

↓

Dirty

↓

Processed

↓

Clean
```

---

# Ciclo de un Dirty Flag

```text
Modificar Component

↓

Dirty

↓

System Consume

↓

Clean
```

Los Systems nunca deben olvidar limpiar el estado cuando corresponda.

---

# Versionado

Además del Dirty Flag cada Component posee un número de versión.

Ejemplo.

```text
Health

Version

15
```

Cada modificación incrementa la versión.

---

# Objetivo del Versionado

Las versiones permiten:

- Detectar cambios.
- Optimizar Queries.
- Optimizar Networking.
- Optimizar Save.
- Optimizar Render.

Sin necesidad de comparar estructuras completas.

---

# Incremento de Versión

Ejemplo.

```text
Version 10

↓

Modificar

↓

Version 11
```

Nunca disminuye.

Nunca se reutiliza.

---

# Dirty vs Version

Ambos mecanismos cumplen funciones distintas.

Dirty:

- Indica que cambió recientemente.

Version:

- Identifica exactamente qué revisión posee el Component.

Pueden utilizarse conjuntamente.

---

# Change Detection

El Framework puede detectar cambios comparando versiones.

Ejemplo.

```text
Frame Anterior

Version 14

↓

Frame Actual

Version 15

↓

El Component cambió
```

Esto evita comparar todos los campos del Component.

---

# Invalidación de Cachés

Cuando cambia un Component puede ser necesario invalidar información almacenada.

Ejemplos:

- Query Cache.
- Navigation Cache.
- Visibility Cache.
- Physics Cache.

La invalidación debe realizarse únicamente cuando sea necesaria.

---

# Deferred Operations

Durante la ejecución de determinados Systems algunas modificaciones deben diferirse.

Ejemplos:

- AddComponent.
- RemoveComponent.
- DestroyEntity.

En lugar de ejecutarse inmediatamente:

```text
Solicitud

↓

Deferred Queue

↓

Fin de la fase

↓

Aplicación
```

---

# Beneficios de las Deferred Operations

Permiten:

- Evitar modificar colecciones durante iteraciones.
- Mantener determinismo.
- Reducir errores.
- Facilitar paralelización futura.

---

# Component Dependencies

Algunos Components requieren la existencia de otros.

Ejemplo conceptual.

```text
WeaponComponent

↓

Requiere

↓

InventoryComponent
```

Estas dependencias deben validarse en el Registry.

---

# Tipos de Dependencias

El Framework reconoce tres categorías.

## Requerida

El Component no puede existir sin otro.

---

## Opcional

Puede aprovechar otro Component si existe.

---

## Exclusiva

Dos Components no pueden coexistir.

Ejemplo conceptual.

```text
Alive

×

Dead
```

---

# Validación de Dependencias

Toda operación AddComponent debe verificar:

- Dependencias requeridas.
- Exclusiones.
- Compatibilidad.

La validación ocurre antes de modificar el Storage.

---

# Continúa en la Parte 3

La siguiente parte desarrollará:

- Integración con Query System.
- Integración con Systems.
- Integración con Save Pipeline.
- Integración con Multiplayer.
- Replicación de Components.
- Serialización.
- Casos límite.
- Manejo de errores.
- Buenas prácticas.
- Anti-patrones.
- Estado final del documento.
---

# Integración con el Query System

El Query System es el único mecanismo autorizado para acceder a Components durante la ejecución.

Los Systems nunca deben recorrer manualmente los Storages.

Toda obtención de Components debe realizarse mediante una Query.

Esto permite:

- Reutilizar cachés.
- Optimizar iteraciones.
- Reducir búsquedas.
- Mantener desacoplamiento.

---

# Registro Automático

Cuando un Component es agregado:

```text
Add Component

↓

Actualizar Signature

↓

Actualizar Índices

↓

Actualizar Queries

↓

Disponible para los Systems
```

No existe intervención manual.

Todo el proceso es responsabilidad del Framework.

---

# Eliminación Automática

Cuando un Component es eliminado:

```text
Remove Component

↓

Actualizar Signature

↓

Actualizar Índices

↓

Actualizar Queries

↓

Deja de ser visible
```

El cambio debe reflejarse antes del siguiente ciclo de ejecución.

---

# Integración con los Systems

Los Systems son los únicos autorizados para modificar Components.

Un flujo típico es:

```text
Query

↓

Obtener Components

↓

Ejecutar lógica

↓

Modificar datos

↓

Actualizar Version

↓

Marcar Dirty
```

Los Components nunca ejecutan lógica por sí mismos.

---

# Lectura de Components

Los Systems pueden solicitar acceso de solo lectura.

En este modo:

- No modifican datos.
- No incrementan versiones.
- No marcan Dirty Flags.

Este acceso debe priorizarse cuando sea posible.

---

# Escritura de Components

Cuando un System modifica un Component:

- Debe hacerlo durante su fase de ejecución.
- Debe respetar el Scheduler.
- Debe incrementar la versión.
- Debe marcar Dirty cuando corresponda.

Nunca debe modificar el Storage directamente.

---

# Acceso Concurrente

El Framework debe diseñarse pensando en una futura ejecución paralela.

Por ello:

- Los accesos de lectura pueden coexistir.
- Los accesos de escritura deben estar controlados.
- Ningún Storage debe quedar en un estado inconsistente.

Aunque inicialmente la ejecución sea secuencial, esta restricción debe respetarse desde el diseño.

---

# Integración con el Save Pipeline

El sistema de guardado no serializa el Storage completo.

Únicamente serializa los datos de los Components.

Flujo conceptual:

```text
Entity

↓

Component

↓

Serializable Data

↓

Save File
```

Toda la estructura interna del Storage se reconstruye al cargar.

---

# Datos Persistentes

Se almacenan únicamente:

- Valores del Component.
- EntityId asociado.
- Información necesaria para reconstrucción.

No se almacenan:

- Índices internos.
- Dirty Flags.
- Versiones temporales.
- Cachés.
- Buffers.
- Lookup Tables.

---

# Restauración

Durante la carga:

```text
Crear Entity

↓

Crear Component

↓

Restaurar Datos

↓

Registrar Storage

↓

Actualizar Signature

↓

Actualizar Queries
```

El resultado debe ser idéntico al estado previo al guardado.

---

# Integración con Multiplayer

El sistema de replicación utiliza los Components como fuente oficial de estado.

Los clientes nunca modifican directamente el estado autoritativo.

Flujo:

```text
Servidor

↓

Modificar Component

↓

Detectar Cambio

↓

Serializar

↓

Enviar

↓

Cliente

↓

Aplicar Cambio
```

---

# Replicación Selectiva

No todos los Components requieren sincronización.

Ejemplos:

Replicables:

- Transform
- Health
- Inventory
- Equipment

Locales:

- Debug
- Editor
- Gizmos
- Datos temporales de cliente

Cada tipo de Component debe indicar explícitamente su política de replicación.

---

# Serialización

Cada Component debe poder convertirse en una representación serializable.

El Framework no debe depender de la implementación concreta de cada Component.

Proceso:

```text
Component

↓

Serialize

↓

Binary / Save Data

↓

Deserialize

↓

Component
```

---

# Componentes No Serializables

Algunos Components existen únicamente durante la ejecución.

Ejemplos:

- Buffers temporales.
- Cachés.
- Datos de depuración.
- Resultados intermedios.

Estos Components nunca deben guardarse ni replicarse.

---

# Componentes Derivados

Existen Components cuyo contenido puede reconstruirse a partir de otros.

Ejemplo conceptual:

```text
Transform

↓

World Matrix
```

La matriz mundial puede recalcularse.

No es necesario serializarla.

---

# Manejo de Errores

El Component Registry debe detectar situaciones inválidas.

Ejemplos:

- Agregar un Component duplicado.
- Eliminar un Component inexistente.
- Modificar un Component destruido.
- Acceder mediante un Handle inválido.
- Registrar un tipo inexistente.

Toda operación inválida debe detectarse inmediatamente.

---

# Validaciones Obligatorias

Antes de cualquier operación el Framework debe comprobar:

- Entity válida.
- Handle válido.
- Storage existente.
- Tipo registrado.
- Dependencias satisfechas.
- Exclusiones respetadas.

Nunca debe asumirse que una operación es correcta.

---

# Casos Especiales

## Agregar y eliminar en el mismo Frame

Si un Component es agregado y eliminado durante el mismo ciclo:

- Nunca llega a ser visible para otros Systems.
- Nunca participa en Queries.
- Nunca se replica.

El Registry resuelve internamente ambas operaciones.

---

## Eliminar un Component inexistente

La operación debe rechazarse.

Nunca debe alterar el estado interno del Storage.

---

## Agregar un Component duplicado

Una Entity no puede contener dos Components del mismo tipo.

El Registry debe impedirlo antes de modificar cualquier estructura.

---

# Consistencia

Después de cada modificación el Framework debe garantizar que:

- La Signature es correcta.
- El Lookup es válido.
- El Dense Array es consistente.
- Las Queries están actualizadas.
- La versión es correcta.
- El Dirty State refleja la realidad.

No pueden existir estados parcialmente actualizados.

---

# Objetivos de Rendimiento

La implementación debe priorizar:

- Acceso O(1) por Entity.
- Inserción O(1).
- Eliminación O(1) mediante Swap Back.
- Excelente localidad de memoria.
- Mínimas asignaciones dinámicas.
- Máxima reutilización de memoria.

---

# Buenas Prácticas

Se recomienda:

- Mantener Components pequeños.
- Separar datos por responsabilidad.
- Evitar campos innecesarios.
- Favorecer múltiples Components simples frente a uno monolítico.
- Utilizar Tag Components cuando solo se requiera identificar una característica.
- Mantener los Components completamente independientes entre sí.

---

# Anti-Patrones

El Framework prohíbe expresamente:

- Lógica dentro de Components.
- Referencias a Systems.
- Referencias a Nodes.
- Referencias directas a otras Entities.
- Acceso al SceneTree.
- Llamadas a Events.
- Consultas al Registry.
- Dependencias circulares entre Components.

---

# Resumen del Ciclo de Vida

```text
Create Request
        │
        ▼
Validación
        │
        ▼
Crear Storage
        │
        ▼
Registrar Lookup
        │
        ▼
Actualizar Signature
        │
        ▼
Actualizar Queries
        │
        ▼
Disponible para Systems
        │
        ▼
Lectura / Escritura
        │
        ▼
Incrementar Version
        │
        ▼
Dirty Flag
        │
        ▼
Procesamiento
        │
        ▼
Remove Component
        │
        ▼
Actualizar Signature
        │
        ▼
Actualizar Queries
        │
        ▼
Liberar Storage
        │
        ▼
Reutilización del Slot
```

---

# Convenciones

El Framework adopta las siguientes convenciones para todos los Components:

- Los Components contienen únicamente datos.
- Ningún Component ejecuta lógica.
- Todo acceso pasa por el Component Registry.
- Todo cambio estructural actualiza la Signature.
- Toda modificación incrementa la versión.
- Los Dirty Flags representan cambios pendientes de procesar.
- Los Components nunca conocen el contexto del juego.
- El orden físico del Storage nunca tiene significado funcional.

---

# Estado

**Estado actual:** Especificación del ciclo de vida de los Components.

Este documento define el contrato técnico que deberá respetar toda implementación del Component Registry y de los Component Storages dentro del Framework ECS de Survivors Lords.

Cualquier modificación de las reglas aquí establecidas deberá documentarse mediante una DEC (Design Engineering Change) para preservar la coherencia del framework y mantener la compatibilidad con el resto de la arquitectura ECS.

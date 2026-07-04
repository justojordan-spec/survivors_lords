# ENTITY LIFECYCLE

**Documento:** 02_ENTITY_LIFECYCLE.md

**Fase:** ECS Framework

**Estado:** Draft

**Versión:** 1.0

---

# Objetivo

Este documento define el ciclo de vida completo de una Entity dentro del Framework ECS de Survivors Lords.

Su propósito es especificar cómo se crean, registran, inicializan, activan, modifican, desactivan y destruyen las entidades durante la ejecución del juego.

Este documento no describe reglas de gameplay.

Define exclusivamente el comportamiento interno del framework.

---

# Alcance

Este documento especifica:

- Arquitectura del Entity Registry.
- Identidad de las entidades.
- Ciclo de vida completo.
- Registro de componentes.
- Estados internos.
- Activación y desactivación.
- Destrucción.
- Reciclado.
- Validación.
- Integración con Queries.
- Integración con Systems.
- Integración con Save.
- Integración con Multiplayer.

No define:

- Componentes.
- Systems.
- Eventos.
- Recursos.
- Gameplay.

Cada uno posee su propia documentación.

---

# Filosofía

Una Entity representa únicamente una identidad dentro del mundo.

No posee comportamiento.

No ejecuta lógica.

No conoce otros objetos.

No mantiene referencias a Systems.

No procesa eventos.

No realiza consultas.

Su única responsabilidad es actuar como propietario lógico de un conjunto de Components.

Toda la lógica pertenece exclusivamente a los Systems.

---

# Principios de Diseño

El ciclo de vida de una Entity debe cumplir los siguientes principios:

- Determinista.
- Seguro.
- Escalable.
- Reutilizable.
- Server Authoritative.
- Compatible con Save.
- Compatible con Multiplayer.
- Compatible con Replay.
- Bajo costo de memoria.
- Bajo costo de CPU.

---

# Conceptos Fundamentales

## Entity

Una Entity representa un identificador lógico dentro del mundo.

Puede representar cualquier objeto del juego.

Ejemplos:

- Jugador.
- NPC.
- Animal.
- Enemigo.
- Árbol.
- Roca.
- Proyectil.
- Cofre.
- Construcción.
- Item.

Para el framework todas las entidades son exactamente iguales.

Su comportamiento está definido únicamente por sus Components.

---

## EntityId

Cada Entity posee un identificador único.

Características:

- Inmutable.
- Persistente.
- Serializable.
- Replicable.
- Único durante su vida útil.

El EntityId nunca contiene lógica.

Nunca almacena referencias.

Nunca almacena estado.

---

## EntityHandle

Los Systems nunca trabajan directamente con EntityId.

Trabajan mediante EntityHandle.

El Handle permite:

- Detectar referencias inválidas.
- Evitar acceso a entidades destruidas.
- Validar generación.
- Mejorar seguridad del framework.

---

## EntityRecord

Internamente el Registry mantiene un registro para cada entidad.

Ejemplo conceptual:

```text
EntityRecord

EntityId

Generation

State

Component Mask

Storage Index

Flags
```

Este registro nunca es expuesto al gameplay.

---

# Estados de una Entity

Toda Entity pasa por una serie de estados perfectamente definidos.

```text
Created

↓

Initializing

↓

Registered

↓

Active

↓

Disabled

↓

Pending Destroy

↓

Destroyed

↓

Recycled
```

Una Entity nunca puede saltarse estados.

Todas las transiciones son controladas por el Entity Registry.

---

# Estado: Created

La entidad acaba de ser creada.

Características:

- Tiene un EntityId.
- No posee Components.
- No es visible para Queries.
- No es visible para Systems.
- No recibe eventos.

Todavía no existe dentro del mundo lógico.

---

# Estado: Initializing

Durante este estado se agregan los Components iniciales.

Ejemplo:

- TransformComponent
- HealthComponent
- InventoryComponent
- AIComponent

Durante esta fase todavía no puede ser procesada.

Esto garantiza que ninguna Entity exista parcialmente construida.

---

# Estado: Registered

Una vez agregados todos los Components:

- Se registran en los Storages.
- Se actualizan los índices.
- Se genera la Signature.
- Se actualizan las Queries.

La Entity continúa sin ser procesada hasta finalizar el registro completo.

---

# Estado: Active

La entidad ya forma parte del mundo.

Puede:

- Participar en Queries.
- Ser procesada por Systems.
- Recibir eventos.
- Emitir eventos.
- Sincronizarse por red.
- Guardarse.

Este es el estado normal de ejecución.

---

# Estado: Disabled

Una Entity deshabilitada permanece registrada.

Sin embargo:

- No participa en gameplay.
- Puede ser ignorada por determinados Systems.
- Conserva todos sus Components.
- Puede reactivarse posteriormente.

Ejemplos:

- Objetos fuera del rango.
- Pool de enemigos.
- Objetos temporalmente ocultos.

---

# Estado: Pending Destroy

La destrucción nunca ocurre inmediatamente.

Cuando un System solicita destruir una Entity:

- Se marca para destrucción.
- Deja de aceptar modificaciones.
- Se elimina de las Queries.
- Espera el final del frame.

Esto evita referencias inválidas durante la ejecución.

---

# Estado: Destroyed

La Entity deja de existir.

Acciones realizadas:

- Eliminación de Components.
- Eliminación de índices.
- Eliminación de cachés.
- Cancelación de eventos pendientes.
- Invalidación de Handles.

---

# Estado: Recycled

Una vez destruida:

- El registro queda libre.
- El índice puede reutilizarse.
- El Handle anterior permanece inválido gracias al número de generación.

---

# Ciclo General

```text
Create Entity

↓

Assign EntityId

↓

Initialize Components

↓

Register Components

↓

Generate Signature

↓

Register Queries

↓

Activate

↓

Gameplay

↓

Disable (Opcional)

↓

Enable (Opcional)

↓

Destroy Request

↓

Pending Destroy

↓

Destroy

↓

Recycle
```

---

# Entity Registry

El Entity Registry es la autoridad absoluta sobre todas las entidades.

Ningún otro sistema puede:

- Crear Entities.
- Destruir Entities.
- Registrar Components.
- Invalidar Handles.
- Reciclar IDs.

Toda operación pasa obligatoriamente por el Registry.

---

# Responsabilidades del Registry

El Registry es responsable de:

- Crear entidades.
- Destruir entidades.
- Registrar Components.
- Mantener índices.
- Mantener generaciones.
- Validar Handles.
- Mantener Signatures.
- Actualizar Queries.
- Emitir eventos internos.
- Gestionar reciclado.
- Detectar errores de consistencia.

---

# Restricciones

Una Entity nunca puede:

- Ejecutar lógica.
- Conocer otros Systems.
- Modificar Components directamente.
- Crear otras Entities.
- Destruir Entities.
- Realizar Queries.
- Publicar eventos.

Toda operación debe ser realizada por un System autorizado.

---

# Consideraciones de Rendimiento

El ciclo de vida de las entidades debe minimizar:

- Allocations.
- Copias de memoria.
- Fragmentación.
- Invalidaciones de caché.
- Búsquedas lineales.

Se prioriza:

- Reutilización de memoria.
- Pools de registros.
- Índices contiguos.
- Validación O(1).
- Inserciones O(1).
- Eliminaciones O(1) cuando sea posible.

---

# Continúa en la Parte 2

La siguiente parte desarrollará:

- Arquitectura interna del Entity Registry.
- Generación de EntityId.
- Generaciones y validación.
- Component Signatures.
- Registro de Components.
- Activación.
- Desactivación.
- Destrucción diferida.
- Object Pooling.
- Diagramas de flujo completos.
- Integración con Queries y Systems.
---

# Arquitectura Interna del Entity Registry

El Entity Registry constituye el núcleo del Framework ECS.

Es el único responsable de administrar el ciclo de vida de todas las entidades existentes durante la ejecución del juego.

Ningún System, Manager o componente externo puede modificar directamente el estado interno de una Entity.

Toda operación debe pasar obligatoriamente por el Registry.

---

# Objetivos del Registry

El Registry debe garantizar:

- Creación determinista.
- Destrucción segura.
- Validación constante.
- Acceso O(1) a las entidades.
- Compatibilidad con Multiplayer.
- Compatibilidad con Save.
- Compatibilidad con Replay.
- Compatibilidad con Object Pooling.
- Compatibilidad con futuras optimizaciones.

---

# Organización Interna

Conceptualmente, el Registry mantiene tres estructuras principales.

```text
Entity Registry

├── Entity Records
├── Free List
└── Generation Table
```

Cada una cumple una responsabilidad específica.

---

# Entity Records

Cada Entity existente posee un registro interno.

Conceptualmente contiene:

```text
Entity Record

EntityId

Generation

State

Component Signature

Flags

Storage Index
```

Este registro nunca es accesible desde gameplay.

Solo el Framework puede modificarlo.

---

# Free List

La Free List contiene todos los registros disponibles para reutilización.

Ejemplo:

```text
Free List

5

9

15

22

31
```

Cuando una Entity es destruida:

- Su registro vuelve a la Free List.
- Sus componentes son eliminados.
- Sus índices son liberados.

El próximo CreateEntity reutilizará uno de esos registros.

---

# Generation Table

Cada Entity posee un número de generación.

Ejemplo:

```text
Entity 14

Generation = 3
```

Si la Entity es destruida:

```text
Entity 14

Generation = 4
```

Todos los Handles anteriores dejan de ser válidos automáticamente.

---

# ¿Por qué utilizar generaciones?

Sin generaciones podría ocurrir el siguiente problema:

```text
Frame 10

Entity 25 existe.

↓

Un System guarda una referencia.

↓

Frame 30

Entity 25 es destruida.

↓

Frame 35

Se crea una nueva Entity reutilizando el ID 25.

↓

El System antiguo cree que sigue apuntando
a la Entity original.
```

Este error produce referencias inválidas extremadamente difíciles de detectar.

Las generaciones eliminan completamente este problema.

---

# Validación de Handles

Cada Handle almacena:

```text
EntityId

Generation
```

Antes de acceder a una Entity el Registry compara:

```text
Handle Generation

==

Registry Generation
```

Si son diferentes:

```text
Handle Inválido
```

La operación es cancelada inmediatamente.

---

# Coste de Validación

La validación consiste únicamente en comparar dos enteros.

Complejidad:

```text
O(1)
```

No requiere búsquedas.

No requiere asignaciones.

No requiere memoria adicional.

---

# Component Signature

Cada Entity mantiene una Signature.

La Signature representa el conjunto exacto de Components que posee.

Ejemplo:

```text
Transform

Health

Inventory

Weapon
```

La Signature no almacena datos.

Solo indica qué componentes existen.

---

# Función de la Signature

Las Signatures permiten:

- Resolver Queries.
- Detectar cambios.
- Actualizar cachés.
- Optimizar búsquedas.
- Filtrar Systems.

Nunca contienen estado.

---

# Actualización de la Signature

La Signature cambia únicamente cuando ocurre alguna de las siguientes operaciones:

- AddComponent
- RemoveComponent

Modificar un Component existente no altera la Signature.

---

# Registro de Componentes

Cuando un Component es agregado:

```text
Create Component

↓

Store Component

↓

Actualizar Signature

↓

Actualizar Índices

↓

Actualizar Queries

↓

Emitir Evento Interno
```

Todo el proceso es atómico.

---

# Eliminación de Componentes

Cuando un Component es eliminado:

```text
Remove Component

↓

Eliminar del Storage

↓

Actualizar Signature

↓

Actualizar Índices

↓

Actualizar Queries

↓

Emitir Evento Interno
```

La Entity permanece válida.

Solo cambia su composición.

---

# Activación de una Entity

Una Entity recién creada nunca entra inmediatamente al mundo.

Primero debe completar el proceso de registro.

```text
Create

↓

Initialize

↓

Register

↓

Update Signature

↓

Update Queries

↓

Activate
```

Solo entonces puede ser procesada por los Systems.

---

# Desactivación

Una Entity puede desactivarse sin destruirse.

Durante este estado:

- Conserva Components.
- Conserva EntityId.
- Conserva Signature.
- Conserva referencias.

Pero deja de participar en la lógica correspondiente.

Esto resulta especialmente útil para Object Pooling.

---

# Reactivación

La reactivación sigue el siguiente flujo:

```text
Disabled

↓

Validate

↓

Update Queries

↓

Enable

↓

Visible para Systems
```

No requiere reconstruir la Entity.

---

# Destrucción Diferida

Las Entities nunca se destruyen durante la ejecución de un System.

En su lugar:

```text
Destroy()

↓

Pending Destroy Queue

↓

Fin del Frame

↓

Destroy Pipeline
```

Esto evita modificar las colecciones mientras están siendo recorridas.

---

# Cola de Destrucción

El Registry mantiene internamente una cola.

Ejemplo:

```text
Pending Destroy Queue

Entity 14

Entity 92

Entity 108

Entity 255
```

Al finalizar el frame:

Cada Entity es destruida siguiendo el mismo procedimiento.

---

# Pipeline de Destrucción

```text
Pending Destroy

↓

Remove Queries

↓

Emit Destroy Event

↓

Destroy Components

↓

Release Storage

↓

Increment Generation

↓

Recycle Record

↓

Push Free List
```

El orden nunca debe modificarse.

---

# Garantías del Pipeline

Al finalizar la destrucción se garantiza que:

- Ningún Handle continúa siendo válido.
- Ninguna Query devuelve la Entity.
- Ningún Component permanece registrado.
- Ningún índice conserva referencias.
- El registro queda listo para reutilizarse.

---

# Object Pooling

El Framework debe favorecer la reutilización de entidades.

En lugar de:

```text
Crear

↓

Destruir

↓

Crear

↓

Destruir
```

Puede utilizar:

```text
Crear

↓

Disable

↓

Enable

↓

Disable

↓

Enable
```

Reduciendo significativamente las asignaciones de memoria.

---

# Cuándo utilizar Pooling

El Pooling resulta recomendable para:

- Proyectiles.
- Enemigos frecuentes.
- Objetos temporales.
- Partículas lógicas.
- Efectos.
- Loot.
- Spawn dinámico.

No todas las entidades requieren Pooling.

---

# Continúa en la Parte 3

La siguiente parte desarrollará:

- Integración con Query System.
- Integración con Scheduler.
- Integración con Event Bus.
- Integración con Save Pipeline.
- Integración con Multiplayer.
- Manejo de errores.
- Casos límite.
- Convenciones.
- Diagramas completos del ciclo de vida.
- Estado final del documento.
---

# Integración con el Query System

El Query System constituye el mecanismo oficial mediante el cual los Systems obtienen acceso a las Entities.

Los Systems nunca recorren directamente el Entity Registry.

Toda consulta debe realizarse mediante Queries.

Esta separación permite mantener bajo acoplamiento y optimizar el rendimiento del framework.

---

# Visibilidad de una Entity

Una Entity no es visible para el Query System inmediatamente después de ser creada.

Debe completar completamente su proceso de registro.

```text
Create

↓

Attach Components

↓

Update Signature

↓

Register Storage

↓

Register Query

↓

Visible
```

Hasta completar este proceso la Entity no puede ser obtenida por ninguna Query.

---

# Eliminación de Queries

Antes de destruir una Entity debe eliminarse de todas las Queries activas.

```text
Destroy Request

↓

Remove Query Entries

↓

Destroy Components

↓

Recycle
```

Esto garantiza que ninguna Query pueda devolver referencias inválidas.

---

# Actualización de Queries

Cada modificación estructural obliga al Registry a actualizar las Queries afectadas.

Operaciones que requieren actualización:

- AddComponent
- RemoveComponent
- EnableEntity
- DisableEntity
- DestroyEntity
- CreateEntity

Modificar únicamente los datos de un Component no requiere reconstruir las Queries.

---

# Integración con los Systems

Los Systems nunca poseen entidades.

Siempre trabajan con resultados temporales obtenidos desde el Query System.

Ejemplo conceptual:

```text
MovementSystem

↓

Query

↓

Transform

Velocity

↓

Actualizar posición
```

Finalizada la ejecución del System, la colección deja de utilizarse.

---

# Restricciones para los Systems

Durante la ejecución de un System:

Puede:

- Leer Components.
- Modificar Components.
- Crear nuevas Entities.
- Solicitar destrucción.
- Publicar Events.

No puede:

- Destruir inmediatamente una Entity.
- Modificar el Registry directamente.
- Alterar Queries manualmente.
- Invalidar Handles.

Todas estas operaciones pertenecen al Framework.

---

# Integración con el Event Bus

El Entity Registry publica eventos internos para informar cambios en el ciclo de vida.

Ejemplos:

```text
EntityCreated

EntityActivated

EntityDisabled

EntityDestroyed

ComponentAdded

ComponentRemoved
```

Estos eventos permiten que otros Systems reaccionen sin depender directamente del Registry.

---

# Eventos Internos vs Eventos de Gameplay

Es importante distinguir ambos tipos.

## Eventos Internos

Describen cambios del Framework.

Ejemplos:

- EntityCreated
- ComponentAdded
- EntityDestroyed

Son utilizados por el propio ECS.

---

## Eventos de Gameplay

Representan hechos ocurridos durante el juego.

Ejemplos:

- DamageApplied
- QuestCompleted
- EnemyKilled
- BuildingConstructed
- LevelUp

Estos eventos pertenecen a la lógica del juego.

---

# Integración con Save Pipeline

El sistema de guardado nunca serializa el Entity Registry completo.

Únicamente serializa el estado necesario para reconstruir el mundo.

Conceptualmente:

```text
Entity

↓

EntityId

↓

Components

↓

Serializable Data

↓

Save File
```

Toda la información temporal del Registry se reconstruye al cargar la partida.

---

# Información No Persistente

Los siguientes datos no deben almacenarse en el archivo de guardado:

- Handles.
- Índices internos.
- Cachés.
- Free List.
- Colas temporales.
- Referencias internas.
- Buffers de ejecución.

Toda esta información pertenece exclusivamente al Runtime.

---

# Restauración

Durante la carga de una partida el flujo es el siguiente:

```text
Load Save

↓

Create Entity

↓

Assign EntityId

↓

Restore Components

↓

Register

↓

Update Signature

↓

Update Queries

↓

Activate
```

El resultado debe ser equivalente al estado previo al guardado.

---

# Integración con Multiplayer

En modo multijugador únicamente el servidor puede crear o destruir Entities autoritativas.

Los clientes nunca modifican el ciclo de vida oficial.

Flujo simplificado:

```text
Cliente

↓

Solicitud

↓

Servidor

↓

Validación

↓

Create Entity

↓

Replicación

↓

Clientes
```

---

# Replicación

La creación de una Entity genera un mensaje de replicación.

La destrucción también.

Los clientes únicamente reconstruyen el resultado enviado por el servidor.

---

# Autoridad

Toda Entity posee una autoridad claramente definida.

Puede ser:

- Servidor.
- Cliente propietario (cuando el modelo de red lo permita).
- Sistema local (para objetos exclusivamente visuales).

El Entity Registry debe conocer esta información para decidir qué operaciones están permitidas.

---

# Entidades Locales

No todas las Entities requieren sincronización.

Ejemplos:

- Efectos visuales.
- Animaciones temporales.
- Partículas.
- Sonidos.
- Elementos de interfaz.

Estas entidades pueden existir únicamente en el cliente.

---

# Manejo de Errores

El Framework debe detectar y reportar situaciones inválidas.

Ejemplos:

- Crear una Entity con un Handle inválido.
- Agregar un Component duplicado.
- Eliminar un Component inexistente.
- Acceder a una Entity destruida.
- Activar una Entity ya activa.
- Destruir una Entity inexistente.

Siempre que sea posible, el error debe detectarse inmediatamente.

---

# Validaciones Obligatorias

Toda operación pública del Registry debe validar:

- Handle válido.
- Generation correcta.
- Estado permitido.
- Component existente.
- Component compatible.
- Permisos de autoridad.

Nunca debe asumirse que la entrada es válida.

---

# Casos Especiales

## Crear y destruir en el mismo Frame

Si una Entity es creada y destruida antes de finalizar el frame:

- Nunca llega a ser visible para los Systems.
- Nunca participa en Queries.
- Nunca se replica.

El Registry simplemente elimina el registro antes de finalizar la actualización.

---

## Destruir una Entity ya destruida

La operación debe ignorarse o registrar un error de desarrollo.

Nunca debe producir corrupción del Registry.

---

## Handle Obsoleto

Si un System intenta acceder mediante un Handle antiguo:

```text
Generation != Registry Generation
```

La operación debe cancelarse inmediatamente.

---

# Reglas del Framework

El Framework establece las siguientes reglas:

- Todas las Entities pasan por el Registry.
- Toda destrucción es diferida.
- Toda activación actualiza Queries.
- Toda modificación estructural actualiza Signatures.
- Ningún System modifica directamente el Registry.
- Ningún Component conoce su Entity.
- Ninguna Query devuelve Entities destruidas.
- Ningún Handle antiguo vuelve a ser válido.

Estas reglas son obligatorias.

---

# Buenas Prácticas

Se recomienda:

- Reutilizar Entities cuando sea posible.
- Evitar crear miles de Entities por frame.
- Mantener bajo el número de cambios estructurales.
- Agrupar operaciones similares.
- Utilizar Queries en lugar de búsquedas manuales.
- Validar Handles en modo Debug.

---

# Anti-Patrones

El Framework prohíbe expresamente:

- Guardar referencias directas a Components fuera del frame.
- Guardar punteros al Registry.
- Destruir Entities durante una iteración.
- Modificar Storages manualmente.
- Saltarse el Entity Registry.
- Crear lógica dentro de una Entity.

---

# Resumen del Ciclo de Vida

```text
Create Request
        │
        ▼
Assign EntityId
        │
        ▼
Initialize Components
        │
        ▼
Register Storages
        │
        ▼
Generate Signature
        │
        ▼
Register Queries
        │
        ▼
Activate
        │
        ▼
Gameplay
        │
        ├──────────────┐
        ▼              │
Disable          Component Changes
        │              │
        └──────┬───────┘
               ▼
        Destroy Request
               │
               ▼
      Pending Destroy Queue
               │
               ▼
Remove From Queries
               │
               ▼
Destroy Components
               │
               ▼
Increment Generation
               │
               ▼
Recycle Record
               │
               ▼
Available For Reuse
```

---

# Estado

**Estado actual:** Especificación del ciclo de vida de las Entities.

Este documento define el contrato técnico que deberá respetar toda implementación del Entity Registry dentro del Framework ECS de Survivors Lords.

Ninguna implementación podrá alterar el orden del ciclo de vida, las responsabilidades del Registry o las reglas de validación aquí descritas sin una decisión arquitectónica formal (DEC/ADR) que mantenga la coherencia con el resto del framework.
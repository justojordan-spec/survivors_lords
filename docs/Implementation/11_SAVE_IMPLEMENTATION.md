# 11 - SAVE IMPLEMENTATION

# Parte 1 — Arquitectura General

---

# Objetivo

Este documento define la implementación completa del sistema de persistencia del Framework ECS de **Survivors Lords**.

El Save System constituye la infraestructura responsable de capturar, serializar, almacenar, restaurar y validar todo el estado dinámico del Runtime.

No define gameplay.

No define Components.

No define Resources.

No define lógica de Systems.

Únicamente define cómo el Framework guarda y recupera el estado completo del mundo.

---

# Alcance

Este documento especifica:

- Save Architecture
- Save Pipeline
- Save Manager
- Save Registry
- Save Serializer
- Save Deserializer
- Snapshot System
- Save Slots
- Save Metadata
- Entity Serialization
- Component Serialization
- World Serialization
- Chunk Persistence
- Versionado
- Migraciones
- Auto Save
- Async Save
- Multiplayer Save
- Recovery
- Debug
- Profiling
- Testing

---

# Fuera de Alcance

Este documento no define:

- formato interno de cada Component
- configuración de Resources
- lógica de gameplay
- lógica de IA
- sincronización de red
- reglas de persistencia de cada System

Cada System únicamente informa qué datos deben persistirse.

La infraestructura de Save decide cómo hacerlo.

---

# Filosofía

Guardar una partida significa capturar una fotografía consistente del Runtime.

No consiste en guardar escenas.

No consiste en guardar nodos.

No consiste en guardar objetos Godot.

Se guarda exclusivamente el estado ECS.

---

# Principio Fundamental

Todo el estado persistente pertenece al Runtime.

Nunca pertenece al SceneTree.

Conceptualmente:

```text
Runtime

↓

Entities

↓

Components

↓

Serializer

↓

Save File
```

---

# Principios Arquitectónicos

El Save System debe cumplir los siguientes principios.

---

## Desacoplamiento

Los Systems nunca escriben archivos.

Los Systems nunca leen archivos.

Toda persistencia ocurre mediante el Save Pipeline.

---

## Determinismo

Dos estados idénticos del Runtime deben producir exactamente el mismo resultado lógico.

---

## Atomicidad

Una operación de Save nunca debe dejar archivos parcialmente escritos.

Debe completarse o cancelarse completamente.

---

## Consistencia

Todo Save representa un estado válido del Runtime.

Nunca puede contener:

- entidades parcialmente serializadas
- Components incompletos
- referencias inválidas

---

## Recuperabilidad

Todo Save válido debe poder restaurarse completamente.

---

## Escalabilidad

La arquitectura debe soportar:

- miles de entidades
- millones de Components
- mundos persistentes
- múltiples jugadores

Sin modificar la arquitectura.

---

# Arquitectura General

El sistema se divide en módulos especializados.

```text
                  ISaveService
                        │
                        ▼
                  Save Manager
──────────────────────────────────────────────
                        │
      ┌──────────┬──────────┬──────────┬──────────┐
      ▼          ▼          ▼          ▼
 Save Registry
 Serializer
 Deserializer
 Snapshot System
                        │
                        ▼
                Save Storage Layer
                        │
                        ▼
                  Save Files
```

Cada módulo posee una única responsabilidad.

---

# Save Manager

## Responsabilidad

Es la fachada pública del sistema.

Coordina todo el proceso de guardado y carga.

Nunca serializa directamente.

Nunca escribe archivos directamente.

Nunca interpreta Components.

---

# Save Registry

## Responsabilidad

Mantiene el catálogo de todos los Serializers registrados.

Relaciona:

- Component Type
- Serializer correspondiente

---

# Save Serializer

## Responsabilidad

Convierte datos ECS en datos persistentes.

Conceptualmente:

```text
Component

↓

Serialize

↓

Binary/Data
```

---

# Save Deserializer

## Responsabilidad

Reconstruye el estado ECS desde el archivo.

Conceptualmente:

```text
Save Data

↓

Deserialize

↓

Component
```

---

# Snapshot System

## Responsabilidad

Capturar una fotografía consistente del Runtime.

Nunca escribe archivos.

Nunca comprime datos.

Únicamente obtiene el estado actual.

---

# Save Storage Layer

## Responsabilidad

Administrar:

- escritura
- lectura
- slots
- archivos
- backups

No conoce ECS.

No conoce Components.

---

# Flujo General

Conceptualmente:

```text
Save Request

↓

Snapshot

↓

Serialization

↓

Storage

↓

Save Complete
```

---

# Flujo de Carga

```text
Load Request

↓

Read File

↓

Deserialize

↓

Rebuild Runtime

↓

Resume Simulation
```

---

# Estado del Runtime

El Runtime puede encontrarse en:

```text
Running

↓

Saving

↓

Running
```

o

```text
Stopped

↓

Loading

↓

Ready
```

Nunca deben coexistir procesos incompatibles.

---

# Datos Persistentes

El sistema guarda únicamente información dinámica.

Ejemplos:

- entidades
- Components
- mundo generado
- inventarios
- progreso
- construcciones
- tiempo
- clima
- estados activos

---

# Datos No Persistentes

Nunca deben guardarse:

- Resources
- configuración
- lógica
- escenas
- nodos temporales
- caches
- profiler
- debug

Todo ello puede reconstruirse automáticamente.

---

# Integración con ECS

El Save System opera exclusivamente mediante interfaces del Framework.

Nunca accede directamente a Systems específicos.

Toda información proviene de:

- Entity Registry
- Component Registry
- Resource Registry (solo IDs)
- Runtime Services

---

# Integración con Resources

Los Resources nunca se serializan.

Únicamente se guarda:

```text
Resource ID
```

Durante la carga:

```text
ID

↓

Resource Registry

↓

Resource
```

---

# Integración con Systems

Los Systems nunca conocen:

- formato del Save
- ubicación de archivos
- serialización
- compresión

Únicamente participan proporcionando acceso al estado ECS.

---

# Ciclo de Vida

El Save Manager posee el siguiente ciclo.

```text
Created

↓

Initialized

↓

Ready

↓

Saving

↓

Ready

↓

Loading

↓

Ready

↓

Disposed
```

---

# Estados

## Ready

Puede iniciar operaciones.

---

## Saving

Existe un proceso de guardado activo.

---

## Loading

Existe un proceso de restauración activo.

---

## Disposed

Toda la infraestructura fue liberada.

---

# Garantías

El Save System garantiza:

- desacoplamiento completo
- serialización consistente
- recuperación determinista
- independencia del gameplay
- compatibilidad con ECS
- integración con Multiplayer
- soporte para crecimiento futuro

---

# Dependencias Permitidas

El Save System puede depender únicamente de:

- IECSContext
- Runtime Services
- Registries
- Storage Layer
- Scheduler

Siempre mediante interfaces.

---

# Dependencias Prohibidas

Nunca debe depender de:

- escenas
- UI
- gameplay
- Nodes
- Systems concretos

---

# Objetivos Arquitectónicos

La implementación debe permitir:

- múltiples slots
- Auto Save
- Async Save
- Quick Save
- Multiplayer Save
- Versionado
- Migraciones
- Recuperación ante errores
- Herramientas de Debug
- Profiling completo

---

# Resultado Esperado

Al finalizar esta primera parte queda definida la arquitectura general del **Save System** del Framework ECS.

El sistema se establece como una infraestructura completamente desacoplada del gameplay, responsable de capturar snapshots consistentes del Runtime, serializar el estado dinámico de entidades y Components, administrar el almacenamiento persistente y reconstruir el mundo de forma determinista durante la carga, utilizando módulos especializados con responsabilidades claramente definidas.
# 11 - SAVE IMPLEMENTATION

# Parte 2 — Save Lifecycle, Save Pipeline, Snapshot System y Save Manager

---

# Objetivo

Esta sección define el ciclo de vida completo de una operación de guardado, el funcionamiento del **Save Pipeline**, el proceso de captura de Snapshots y la responsabilidad del **Save Manager** como coordinador principal del sistema.

El objetivo es garantizar que toda operación de persistencia sea:

- determinista;
- consistente;
- atómica;
- desacoplada;
- independiente del gameplay.

---

# Filosofía

Un Save nunca se construye directamente desde los archivos del juego.

Primero se captura un Snapshot consistente del Runtime.

Ese Snapshot posteriormente se serializa y finalmente se almacena.

Esto desacopla completamente la captura del estado del proceso de escritura física.

---

# Flujo General

Toda operación de Save sigue exactamente el mismo proceso.

```text
Save Request

↓

Validate

↓

Freeze Snapshot

↓

Collect Data

↓

Serialize

↓

Write Storage

↓

Finalize

↓

Save Complete
```

Cada etapa posee una responsabilidad específica.

---

# Save Lifecycle

Toda operación atraviesa los siguientes estados.

```text
Requested

↓

Preparing

↓

Snapshot

↓

Serializing

↓

Writing

↓

Completed

↓

Ready
```

Si ocurre un error:

```text
Writing

↓

Failed

↓

Rollback

↓

Ready
```

El Runtime nunca debe permanecer en un estado inconsistente.

---

# Requested

Un consumidor solicita iniciar un proceso de guardado.

Ejemplos:

- Auto Save;
- Quick Save;
- Save Manual;
- Guardado al salir del juego.

En este estado todavía no se realiza ninguna operación sobre el Runtime.

---

# Preparing

El Save Manager verifica que el Runtime pueda iniciar un proceso de persistencia.

Como mínimo debe comprobar:

- Runtime inicializado;
- Scheduler en estado estable;
- ausencia de otra operación de Save activa;
- almacenamiento disponible.

---

# Snapshot

Se captura una fotografía lógica del estado actual del Runtime.

Durante esta etapa todavía no existe serialización.

Únicamente se recopila información.

---

# Serializing

Toda la información del Snapshot se convierte al formato persistente definido por el Framework.

---

# Writing

Los datos serializados se escriben en el almacenamiento correspondiente.

---

# Completed

La operación finalizó correctamente.

El Save queda disponible para futuras operaciones de Load.

---

# Ready

El Save Manager vuelve al estado normal y puede aceptar nuevas solicitudes.

---

# Atomicidad

Toda operación de Save debe comportarse como una unidad indivisible.

Conceptualmente:

```text
Save

↓

Complete
```

o

```text
Save

↓

Cancel
```

Nunca:

```text
Half Save
```

---

# Snapshot System

## Responsabilidad

El Snapshot System captura una representación consistente del Runtime.

No escribe archivos.

No comprime información.

No interpreta el contenido.

Su única responsabilidad consiste en congelar el estado lógico del mundo.

---

# Filosofía del Snapshot

El Snapshot representa una fotografía del Runtime en un instante determinado.

Conceptualmente:

```text
Running World

↓

Snapshot

↓

Immutable Snapshot
```

Una vez capturado, el Snapshot no debe modificarse.

---

# Contenido del Snapshot

El Snapshot puede contener:

- entidades activas;
- Components persistentes;
- estado del mundo;
- tiempo;
- clima;
- datos globales;
- metadatos del Runtime.

Nunca contiene Resources completos.

---

# Momento de Captura

La captura debe realizarse únicamente cuando el Scheduler garantice un estado consistente.

Conceptualmente:

```text
Systems Finished

↓

Scheduler Barrier

↓

Capture Snapshot
```

Esto evita inconsistencias entre Components relacionados.

---

# Congelación Lógica

El Runtime no necesita detener completamente la ejecución.

Sin embargo, el Snapshot debe observar un estado estable.

La estrategia concreta dependerá del Scheduler y del modelo de ejecución.

---

# Save Pipeline

## Responsabilidad

El Save Pipeline coordina todas las etapas necesarias para transformar el estado del Runtime en un archivo persistente.

Cada etapa posee una única responsabilidad.

---

# Etapas del Pipeline

```text
Prepare

↓

Snapshot

↓

Serialize

↓

Compress (Optional)

↓

Write

↓

Verify

↓

Finalize
```

---

# Prepare

Valida las condiciones iniciales.

---

# Snapshot

Captura el estado del Runtime.

---

# Serialize

Convierte el Snapshot en datos persistentes.

---

# Compress

Etapa opcional encargada de reducir el tamaño del archivo.

No modifica la información lógica.

---

# Write

Escribe los datos en el almacenamiento.

---

# Verify

Comprueba que el archivo generado sea válido y completo.

---

# Finalize

Marca la operación como finalizada y libera los recursos temporales utilizados durante el proceso.

---

# Save Manager

## Responsabilidad

El Save Manager constituye la fachada pública del sistema de persistencia.

Toda solicitud de Save o Load debe pasar por este módulo.

---

# Responsabilidades Principales

El Save Manager debe:

- iniciar operaciones;
- cancelar operaciones cuando sea necesario;
- coordinar el Pipeline;
- informar el estado actual;
- impedir operaciones incompatibles.

Nunca serializa datos directamente.

---

# Coordinación

Conceptualmente:

```text
System

↓

Save Manager

↓

Pipeline

↓

Result
```

El resto del Runtime desconoce los detalles internos.

---

# Operaciones Simultáneas

El Save Manager nunca debe permitir:

```text
Save

+

Save
```

o

```text
Save

+

Load
```

simultáneamente sobre el mismo Runtime.

---

# Cola de Solicitudes

La implementación podrá incorporar una cola interna para administrar solicitudes múltiples.

Conceptualmente:

```text
Save Request

↓

Queue

↓

Execute

↓

Complete
```

La política concreta queda desacoplada de la API pública.

---

# Cancelación

Una operación podrá cancelarse únicamente antes de comenzar la escritura física.

Una vez iniciada la etapa **Writing**, la operación deberá completarse o fallar de forma controlada.

---

# Integración con el Scheduler

El Scheduler define el momento seguro para capturar un Snapshot.

El Save Manager nunca debe forzar la captura de información mientras existan modificaciones estructurales en curso.

---

# Integración con el Runtime

Durante el proceso de Save:

- los Resources permanecen inmutables;
- los Registries conservan su consistencia;
- el Snapshot representa el estado oficial del mundo.

---

# Integración con Auto Save

El Auto Save únicamente solicita una operación de guardado.

Toda la lógica continúa perteneciendo al Save Manager.

Conceptualmente:

```text
Auto Save Timer

↓

Save Manager

↓

Save Pipeline
```

---

# Integración con Quick Save

El Quick Save reutiliza exactamente el mismo Pipeline.

Únicamente cambia el destino del almacenamiento.

---

# Restricciones

El Snapshot System nunca debe:

- escribir archivos;
- comprimir datos;
- modificar Components;
- crear entidades;
- destruir entidades.

El Save Manager nunca debe:

- serializar directamente;
- acceder al almacenamiento físico;
- interpretar Components.

Cada módulo mantiene una única responsabilidad.

---

# Garantías

El Save Pipeline garantiza que:

- todas las operaciones siguen el mismo flujo;
- el Snapshot siempre representa un estado consistente;
- el Save Manager coordina el proceso sin acoplarse a la serialización;
- las operaciones son atómicas y deterministas.

---

# Flujo Completo

Conceptualmente:

```text
Save Request

↓

Save Manager

↓

Validate

↓

Capture Snapshot

↓

Serialize

↓

Write

↓

Verify

↓

Complete
```

Este flujo representa el comportamiento oficial del proceso de guardado dentro del Framework ECS.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificado el **Save Lifecycle**, el **Save Pipeline**, el **Snapshot System** y el funcionamiento del **Save Manager**.

La arquitectura establece un proceso uniforme para todas las operaciones de guardado, basado en la captura de un Snapshot consistente del Runtime y en una secuencia controlada de etapas que garantizan la integridad de los datos, el desacoplamiento entre módulos y la posibilidad de extender el sistema con nuevas estrategias de persistencia sin modificar la API pública.
# 11 - SAVE IMPLEMENTATION

# Parte 3 — Save Registry, Component Serialization, Entity Serialization y World Serialization

---

# Objetivo

Esta sección define la implementación del **Save Registry**, el proceso de serialización de Components, la reconstrucción de Entidades y la persistencia del estado global del mundo.

El objetivo es establecer un mecanismo uniforme para convertir el estado ECS del Runtime en una representación persistente y posteriormente reconstruirlo de forma determinista.

---

# Filosofía

El Save System no conoce los detalles internos de cada Component.

Cada tipo de Component posee su propio Serializer especializado.

Esto mantiene el desacoplamiento entre la infraestructura de persistencia y el gameplay.

---

# Flujo General

Conceptualmente:

```text
Entity

↓

Components

↓

Component Serializers

↓

Serialized Data

↓

Save File
```

Durante la carga:

```text
Save File

↓

Serialized Data

↓

Component Deserializers

↓

Components

↓

Entity
```

---

# Save Registry

## Responsabilidad

El Save Registry mantiene el catálogo oficial de todos los Serializers disponibles.

Relaciona:

- tipo de Component;
- Serializer correspondiente;
- Deserializer correspondiente.

No serializa información.

No interpreta datos.

---

# Organización Conceptual

```text
Component Type

↓

Serializer
```

Ejemplo:

```text
InventoryComponent

↓

InventorySerializer
```

---

# Registro

Durante el Bootstrap:

```text
Serializer

↓

Register

↓

Save Registry
```

Una vez registrado, el Serializer puede participar en cualquier operación de Save o Load.

---

# Registro Único

Cada tipo de Component debe poseer exactamente un Serializer.

Configuración válida:

```text
HealthComponent

↓

HealthSerializer
```

Configuración inválida:

```text
HealthComponent

↓

Serializer A

↓

Serializer B
```

El Save Registry debe detectar duplicados durante la inicialización.

---

# Component Serializer

## Responsabilidad

Transformar un Component en un formato persistente.

Conceptualmente:

```text
Component

↓

Serialize

↓

Persistent Data
```

---

# Component Deserializer

## Responsabilidad

Reconstruir un Component a partir de los datos persistentes.

Conceptualmente:

```text
Persistent Data

↓

Deserialize

↓

Component
```

---

# Responsabilidad Única

Cada Serializer debe conocer únicamente un tipo de Component.

Nunca debe serializar múltiples tipos diferentes.

---

# Serialización de Components

Cada Component persistente sigue exactamente el mismo flujo.

```text
Read Component

↓

Serialize

↓

Persistent Representation
```

---

# Componentes Persistentes

Como regla general, se serializa únicamente el estado dinámico.

Ejemplos:

- vida actual;
- inventario;
- posición;
- estados activos;
- progreso;
- energía.

---

# Componentes No Persistentes

No deben serializarse datos derivados o temporales.

Ejemplos:

- caches;
- resultados de Queries;
- datos de Debug;
- métricas;
- buffers internos;
- referencias reconstruibles.

Estos datos deben regenerarse automáticamente durante la carga.

---

# Resources

Los Resources nunca se serializan.

Únicamente se almacena su identificador.

Ejemplo:

```text
WeaponComponent

↓

Weapon ID
```

Durante la carga:

```text
Weapon ID

↓

Resource Registry

↓

Weapon Resource
```

---

# Entity Serialization

## Responsabilidad

Persistir la existencia y estructura de cada entidad.

---

# Información Persistente

Cada entidad puede almacenar:

- Entity ID;
- Components persistentes;
- estado general;
- metadatos necesarios para su reconstrucción.

---

# Entity ID

El identificador constituye la referencia principal durante la restauración.

Debe mantenerse estable durante todo el proceso de Save y Load.

---

# Flujo de Serialización

Conceptualmente:

```text
Entity

↓

Read Components

↓

Serialize Components

↓

Serialized Entity
```

---

# Flujo de Restauración

```text
Serialized Entity

↓

Create Entity

↓

Deserialize Components

↓

Attach Components

↓

Runtime Ready
```

---

# Orden de Restauración

La reconstrucción debe seguir un orden determinista.

Conceptualmente:

```text
Create Entity

↓

Attach Components

↓

Resolve References

↓

Activate
```

Esto evita referencias incompletas entre entidades.

---

# Referencias entre Entidades

Cuando un Component referencia otra entidad:

```text
Entity A

↓

Entity ID

↓

Entity B
```

La restauración debe resolver esas referencias una vez creadas todas las entidades necesarias.

---

# World Serialization

## Responsabilidad

Persistir el estado global del mundo.

No pertenece a ninguna entidad específica.

---

# Información Global

Ejemplos:

- tiempo del mundo;
- clima;
- semilla utilizada;
- ciclo día/noche;
- progreso global;
- configuraciones dinámicas.

---

# Datos Globales

Conceptualmente:

```text
World State

↓

Serialize

↓

World Data
```

Durante la carga:

```text
World Data

↓

Deserialize

↓

Restore World
```

---

# Chunk Persistence

Para mundos de gran tamaño, el estado podrá dividirse conceptualmente en Chunks.

Ejemplo:

```text
World

↓

Chunk A

Chunk B

Chunk C
```

Cada Chunk podrá serializarse de forma independiente.

La estrategia concreta de almacenamiento queda desacoplada de la arquitectura.

---

# Separación de Responsabilidades

La persistencia del mundo nunca debe mezclarse con la persistencia de entidades.

Conceptualmente:

```text
World State

↓

World Serializer
```

```text
Entities

↓

Entity Serializer
```

---

# Orden General de Serialización

El Pipeline debe seguir un orden consistente.

```text
World

↓

Global Data

↓

Entities

↓

Components

↓

Finalize
```

---

# Orden General de Restauración

Durante la carga:

```text
Read Save

↓

Restore World

↓

Create Entities

↓

Deserialize Components

↓

Resolve References

↓

Activate Runtime
```

---

# Integración con el Resource Registry

Toda referencia a configuración se restaura utilizando identificadores.

Nunca se reconstruyen Resources desde el archivo de Save.

---

# Integración con Query Engine

Las Queries no forman parte del proceso de serialización.

Toda la información necesaria proviene directamente de los Registries y de los Components.

---

# Integración con Systems

Los Systems no serializan Components.

Los Serializers especializados realizan todo el trabajo de persistencia.

---

# Restricciones

El Save Registry nunca debe:

- escribir archivos;
- cargar archivos;
- modificar Components;
- crear entidades.

Los Serializers nunca deben:

- acceder directamente al almacenamiento;
- modificar el Runtime;
- ejecutar lógica de gameplay.

Cada módulo conserva una única responsabilidad.

---

# Garantías

El Save Registry garantiza que:

- cada Component persistente posee un único Serializer;
- la serialización permanece desacoplada del gameplay;
- las entidades pueden reconstruirse de forma determinista;
- el estado global del mundo se persiste independientemente del estado de las entidades.

---

# Flujo Completo

Conceptualmente:

```text
Runtime

↓

Entities

↓

Components

↓

Serializers

↓

Persistent Data

↓

Save File
```

Durante la carga:

```text
Save File

↓

Persistent Data

↓

Deserializers

↓

Entities

↓

Runtime Ready
```

Este flujo representa el comportamiento oficial del proceso de serialización dentro del Framework ECS.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificada la implementación del **Save Registry**, la **serialización de Components**, la **persistencia de Entidades** y la **serialización del estado global del mundo**.

La arquitectura garantiza un mecanismo uniforme para transformar el estado dinámico del Runtime en datos persistentes y reconstruir posteriormente el mundo de forma determinista, utilizando Serializers especializados y manteniendo una estricta separación entre infraestructura de persistencia, configuración Data Driven y lógica de gameplay.
# 11 - SAVE IMPLEMENTATION

# Parte 4 — Save Storage, Save Files, Save Slots, Metadata y Versionado

---

# Objetivo

Esta sección define la implementación de la capa de almacenamiento del Save System, la organización de los archivos de guardado, la administración de Save Slots, el manejo de metadatos y el sistema de versionado.

El objetivo es desacoplar completamente la persistencia física del resto del Framework ECS, permitiendo que la arquitectura pueda evolucionar sin modificar el funcionamiento interno del Runtime.

---

# Filosofía

El Runtime nunca debe conocer:

- rutas de archivos;
- nombres físicos;
- formato del almacenamiento;
- organización del disco.

Toda interacción con el almacenamiento ocurre exclusivamente mediante la **Save Storage Layer**.

---

# Arquitectura General

Conceptualmente:

```text
Save Manager

↓

Save Storage Layer

↓

Storage Backend

↓

Save Files
```

La infraestructura superior desconoce completamente los detalles del almacenamiento físico.

---

# Save Storage Layer

## Responsabilidad

La Save Storage Layer constituye la única responsable de:

- crear archivos;
- abrir archivos;
- escribir datos;
- leer datos;
- eliminar archivos;
- gestionar directorios;
- administrar slots.

No conoce:

- Entities;
- Components;
- Systems;
- Gameplay.

---

# Responsabilidad Única

La capa de almacenamiento nunca interpreta información serializada.

Su única responsabilidad consiste en almacenar y recuperar bloques de datos.

---

# Save File

## Definición

Un Save File representa una instantánea persistente completa del Runtime.

Conceptualmente:

```text
Save File

↓

Metadata

↓

World Data

↓

Entity Data

↓

Component Data
```

La organización interna puede evolucionar sin modificar la arquitectura.

---

# Organización Lógica

Todo archivo de guardado debe separar claramente:

- información descriptiva;
- estado global;
- estado ECS;
- datos auxiliares.

Esta separación facilita futuras migraciones y herramientas de depuración.

---

# Save Slots

## Objetivo

Los Save Slots permiten administrar múltiples partidas independientes.

Cada Slot representa un estado persistente completamente autónomo.

---

# Concepto

```text
Slot 1

↓

Save File
```

```text
Slot 2

↓

Save File
```

```text
Slot 3

↓

Save File
```

Los Slots nunca comparten información persistente.

---

# Administración de Slots

La infraestructura debe permitir:

- crear Slots;
- sobrescribir Slots;
- eliminar Slots;
- enumerar Slots;
- consultar metadatos.

Toda operación ocurre mediante el Save Manager.

---

# Slot Activo

Durante la ejecución solo existe un Slot activo.

Conceptualmente:

```text
Selected Slot

↓

Save

↓

Load
```

Cambiar de Slot implica iniciar una nueva operación de carga.

---

# Save Metadata

## Objetivo

Los metadatos describen el contenido del archivo sin necesidad de reconstruir el Runtime.

Esto permite mostrar información en la interfaz sin cargar completamente la partida.

---

# Información Típica

Ejemplos de metadatos:

- nombre del mundo;
- fecha de creación;
- fecha del último guardado;
- tiempo de juego;
- versión del Save;
- identificador del Slot.

La lista exacta podrá ampliarse en el futuro.

---

# Separación

Los metadatos deben almacenarse independientemente del estado ECS.

Conceptualmente:

```text
Metadata

+

Runtime Snapshot
```

Esto permite leer información descriptiva rápidamente.

---

# Miniaturas

La arquitectura admite almacenar información adicional asociada al Save.

Ejemplos:

- captura de pantalla;
- icono;
- imagen representativa.

Estos elementos no forman parte del Snapshot del Runtime.

---

# Save Manifest

Opcionalmente puede mantenerse un manifiesto conceptual:

```text
Slot

↓

Metadata

↓

Status
```

Facilitando la enumeración de partidas disponibles.

---

# Versionado

## Objetivo

Todo archivo de guardado debe indicar claramente la versión de la estructura utilizada para serializarlo.

Esto permite detectar incompatibilidades y realizar migraciones.

---

# Filosofía

La versión pertenece al formato de persistencia.

No representa la versión del juego.

---

# Flujo Conceptual

```text
Save File

↓

Version

↓

Deserializer
```

El Deserializer determina cómo interpretar el contenido.

---

# Compatibilidad

La infraestructura debe contemplar tres escenarios:

```text
Current Version
```

Compatible.

```text
Older Version
```

Requiere migración.

```text
Future Version
```

Debe rechazarse de forma segura.

---

# Migraciones

Cuando el formato cambia:

```text
Old Save

↓

Migration

↓

Current Save
```

Las migraciones deben realizarse antes de reconstruir el Runtime.

---

# Estrategia

Cada versión deberá conocer cómo migrar desde versiones compatibles anteriores.

La implementación concreta queda desacoplada de la arquitectura.

---

# Integridad del Archivo

Antes de iniciar la deserialización deben verificarse:

- formato reconocido;
- versión válida;
- estructura mínima;
- datos obligatorios.

Un archivo inválido nunca debe llegar al Runtime.

---

# Escritura Segura

La creación de un Save debe evitar dejar archivos incompletos.

Conceptualmente:

```text
Temporary File

↓

Write Complete

↓

Replace Previous Save
```

Este comportamiento garantiza atomicidad frente a interrupciones.

---

# Backups

La infraestructura puede mantener una copia de seguridad del Save anterior.

Conceptualmente:

```text
Current Save

↓

Backup

↓

Write New Save
```

Si la escritura falla, el Backup permanece disponible.

---

# Eliminación

Eliminar un Slot únicamente afecta al almacenamiento persistente.

Nunca modifica el Runtime actualmente cargado.

---

# Enumeración

La Storage Layer puede proporcionar:

```text
List Saves

↓

Metadata

↓

Available Slots
```

Sin necesidad de cargar completamente cada archivo.

---

# Integración con Save Manager

El Save Manager delega todas las operaciones físicas.

Conceptualmente:

```text
Save Manager

↓

Storage Layer

↓

Filesystem
```

---

# Integración con Serializer

Los Serializers desconocen completamente dónde se almacenan los datos.

Ellos únicamente producen una representación persistente.

---

# Integración con Deserializer

El Deserializer recibe datos ya leídos por la Storage Layer.

Nunca abre archivos directamente.

---

# Restricciones

La Save Storage Layer nunca debe:

- interpretar Components;
- crear entidades;
- modificar Resources;
- ejecutar lógica de gameplay.

El Versionado nunca debe modificar el Runtime directamente.

Toda migración ocurre antes de la reconstrucción del estado ECS.

---

# Garantías

La Save Storage Layer garantiza:

- aislamiento del almacenamiento físico;
- administración uniforme de Save Slots;
- acceso eficiente a metadatos;
- escritura atómica;
- soporte para versionado y migraciones futuras.

---

# Flujo Completo

Conceptualmente:

```text
Save Manager

↓

Serialize Snapshot

↓

Storage Layer

↓

Temporary File

↓

Validation

↓

Final Save File
```

Durante la carga:

```text
Save File

↓

Read Metadata

↓

Check Version

↓

Read Data

↓

Deserialize

↓

Restore Runtime
```

Este flujo representa el comportamiento oficial de la capa de almacenamiento del Save System.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificada la implementación de la **Save Storage Layer**, la organización de los **Save Files**, la administración de **Save Slots**, el manejo de **Metadata** y el sistema de **Versionado**.

La arquitectura establece una separación clara entre la persistencia física y la lógica del Framework ECS, permitiendo administrar múltiples partidas, realizar migraciones de formato y mantener la integridad de los archivos mediante una estrategia de escritura segura y completamente desacoplada del Runtime.
# 11 - SAVE IMPLEMENTATION

# Parte 5 — Async Save, Auto Save, Quick Save, Recovery e Integridad de Datos

---

# Objetivo

Esta sección define la implementación de las operaciones de **Async Save**, **Auto Save**, **Quick Save**, los mecanismos de recuperación ante fallos y las garantías de integridad de datos del Save System.

El objetivo es permitir operaciones de guardado eficientes y seguras sin comprometer la consistencia del Runtime ni la experiencia del jugador.

---

# Filosofía

Todas las variantes de guardado utilizan exactamente el mismo Save Pipeline.

La diferencia entre ellas no está en la serialización.

La diferencia reside únicamente en:

- quién inicia la operación;
- cuándo se ejecuta;
- dónde se almacena el resultado.

---

# Arquitectura

Conceptualmente:

```text
Manual Save

↓

Save Manager
```

```text
Auto Save

↓

Save Manager
```

```text
Quick Save

↓

Save Manager
```

Todos convergen en el mismo Pipeline.

---

# Async Save

## Objetivo

Permitir que la escritura física del archivo no bloquee innecesariamente la ejecución del Runtime.

---

# Filosofía

La captura del Snapshot y la escritura del archivo representan responsabilidades diferentes.

Una vez obtenido un Snapshot consistente, la persistencia puede realizarse de forma desacoplada.

Conceptualmente:

```text
Runtime

↓

Snapshot

↓

Background Save
```

---

# Flujo Conceptual

```text
Capture Snapshot

↓

Freeze Snapshot

↓

Resume Runtime

↓

Serialize

↓

Write File

↓

Complete
```

El Runtime continúa utilizando su estado actual mientras el Snapshot permanece inmutable.

---

# Restricciones

El Snapshot nunca debe modificarse durante la operación asíncrona.

Toda la información utilizada por el proceso de guardado debe ser completamente independiente del estado activo del Runtime.

---

# Beneficios

El Async Save permite:

- minimizar interrupciones;
- reducir pausas perceptibles;
- desacoplar escritura y simulación;
- mejorar la experiencia del jugador.

---

# Auto Save

## Objetivo

Guardar automáticamente el progreso del jugador en momentos seguros definidos por el juego.

---

# Filosofía

El Auto Save nunca implementa lógica de persistencia.

Únicamente solicita una operación estándar al Save Manager.

---

# Flujo

Conceptualmente:

```text
Auto Save Trigger

↓

Save Manager

↓

Standard Save Pipeline
```

---

# Disparadores

La arquitectura admite múltiples desencadenantes.

Ejemplos:

- intervalo de tiempo;
- descanso del jugador;
- cambio de zona;
- eventos importantes;
- cierre del juego.

La selección concreta pertenece al gameplay.

---

# Condiciones

Antes de iniciar un Auto Save deben verificarse condiciones como:

- Runtime estable;
- ausencia de otro Save activo;
- almacenamiento disponible;
- Scheduler en estado seguro.

---

# Cancelación

Si las condiciones no son válidas:

```text
Auto Save

↓

Rejected
```

El Runtime continúa normalmente.

---

# Quick Save

## Objetivo

Permitir al jugador guardar rápidamente el estado actual utilizando un Slot específico.

---

# Filosofía

El Quick Save reutiliza exactamente el mismo Pipeline.

No introduce un mecanismo especial de serialización.

---

# Flujo

```text
Quick Save Request

↓

Save Manager

↓

Quick Save Slot

↓

Standard Pipeline
```

---

# Quick Load

La restauración sigue exactamente el mismo proceso que cualquier operación de Load.

Únicamente cambia el Slot utilizado.

---

# Integridad de Datos

## Objetivo

Garantizar que todo archivo generado represente un estado válido del Runtime.

---

# Filosofía

La integridad debe verificarse antes y después de escribir el archivo.

---

# Verificaciones Previas

Antes de comenzar la escritura deben comprobarse:

- Snapshot válido;
- serialización completa;
- ausencia de errores críticos.

---

# Verificaciones Posteriores

Una vez finalizada la escritura pueden comprobarse:

- tamaño esperado;
- estructura válida;
- encabezado correcto;
- metadatos completos.

---

# Escritura Atómica

Toda operación debe seguir un flujo similar al siguiente:

```text
Create Temporary File

↓

Write Data

↓

Verify

↓

Replace Previous Save
```

Si ocurre un error:

```text
Delete Temporary File
```

El Save anterior permanece intacto.

---

# Recovery

## Objetivo

Permitir recuperar el sistema ante interrupciones o archivos dañados.

---

# Escenarios

Ejemplos:

- interrupción del proceso;
- falta de energía;
- cierre inesperado;
- escritura incompleta;
- corrupción del archivo.

---

# Estrategia General

El Recovery nunca intenta reconstruir información parcial.

Únicamente utiliza archivos completamente válidos.

---

# Flujo Conceptual

```text
Load Save

↓

Validate

↓

Valid?

↓

Yes → Continue

↓

No

↓

Recovery
```

---

# Backup

Cuando exista una copia de seguridad:

```text
Primary Save

↓

Invalid

↓

Load Backup
```

Esto incrementa la tolerancia a fallos.

---

# Recuperación Fallida

Si no existe ninguna versión válida:

```text
Recovery Failed

↓

Report Error

↓

Abort Load
```

El Runtime nunca debe continuar utilizando datos inconsistentes.

---

# Corrupción

Un archivo corrupto nunca debe deserializarse parcialmente.

La operación debe finalizar inmediatamente.

---

# Integridad Lógica

Además de la estructura física, deben comprobarse:

- referencias válidas;
- identificadores únicos;
- Components consistentes;
- datos obligatorios presentes.

---

# Reintentos

La política de reintentos queda desacoplada del Save Pipeline.

Puede implementarse mediante herramientas superiores sin modificar la infraestructura.

---

# Integración con Save Manager

El Save Manager coordina:

- operaciones asíncronas;
- Auto Save;
- Quick Save;
- Recovery.

Sin asumir responsabilidades de serialización ni almacenamiento.

---

# Integración con Scheduler

El Scheduler continúa siendo el responsable de indicar cuándo puede capturarse un Snapshot consistente.

Las operaciones asíncronas nunca modifican esta regla.

---

# Integración con Storage Layer

La Storage Layer permanece completamente responsable de:

- archivos temporales;
- reemplazo seguro;
- eliminación;
- backups.

---

# Integración con Serializer

El Serializer desconoce completamente si el Save es:

- manual;
- automático;
- rápido;
- asíncrono.

Siempre produce la misma representación persistente.

---

# Restricciones

El Async Save nunca debe acceder al Runtime activo una vez capturado el Snapshot.

El Auto Save nunca debe contener lógica de gameplay.

El Recovery nunca debe intentar reparar estructuras parcialmente válidas.

La consistencia siempre tiene prioridad sobre la recuperación.

---

# Garantías

La arquitectura garantiza que:

- todas las variantes de Save utilizan un único Pipeline;
- el Async Save desacopla la escritura del Runtime;
- el Auto Save y el Quick Save reutilizan exactamente la misma infraestructura;
- la escritura es atómica;
- los mecanismos de Recovery preservan la consistencia de los datos.

---

# Flujo Completo

Conceptualmente:

```text
Save Trigger

↓

Save Manager

↓

Capture Snapshot

↓

Async Serialize

↓

Write Temporary File

↓

Verify

↓

Replace Save

↓

Complete
```

En caso de error:

```text
Validation Failed

↓

Recovery

↓

Previous Save Preserved
```

Este flujo representa el comportamiento oficial de las operaciones avanzadas del Save System.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificada la implementación del **Async Save**, **Auto Save**, **Quick Save**, los mecanismos de **Recovery** y las garantías de **Integridad de Datos** del Framework ECS.

La arquitectura proporciona una infraestructura robusta para realizar operaciones de guardado seguras, eficientes y tolerantes a fallos, reutilizando un único Save Pipeline para todas las modalidades de persistencia y garantizando que el Runtime nunca quede expuesto a estados inconsistentes o archivos parcialmente escritos.
# 11 - SAVE IMPLEMENTATION

# Parte 6 — Integración con Scheduler, Systems, Event Bus, Multiplayer y Resource Registry

---

# Objetivo

Esta sección define cómo el Save System se integra con el resto de la arquitectura del Framework ECS.

El Save System no funciona como un módulo aislado.

Debe coordinarse correctamente con:

- Scheduler
- Systems
- Entity Registry
- Component Registry
- Resource Registry
- Query Engine
- Event Bus
- Multiplayer Pipeline
- Debug Tools

Todo ello manteniendo el desacoplamiento definido en las fases anteriores.

---

# Filosofía

El Save System nunca accede directamente a la lógica de gameplay.

Toda la información persistente proviene del estado ECS.

Los distintos módulos del Framework colaboran mediante interfaces claramente definidas.

---

# Integración con el Scheduler

## Responsabilidad

El Scheduler determina cuándo el Runtime se encuentra en un estado seguro para capturar un Snapshot.

El Save System nunca debe decidir este momento por sí mismo.

---

# Punto Seguro

Conceptualmente:

```text
Systems Finished

↓

Scheduler Barrier

↓

Snapshot Allowed
```

Esto garantiza que todos los Systems hayan finalizado sus modificaciones antes del proceso de guardado.

---

# Barrera de Sincronización

La captura del Snapshot debe realizarse únicamente después de completar todas las fases programadas del Frame.

Nunca durante la ejecución de un System.

---

# Integración con Systems

Los Systems no participan directamente en la persistencia.

Su responsabilidad consiste únicamente en mantener actualizado el estado ECS.

---

# Flujo Conceptual

```text
System

↓

Modify Components

↓

Scheduler

↓

Snapshot

↓

Save
```

Los Systems nunca conocen el formato del archivo de guardado.

---

# Responsabilidades de los Systems

Los Systems pueden:

- crear entidades;
- modificar Components;
- eliminar entidades.

No pueden:

- serializar datos;
- escribir archivos;
- abrir Saves;
- reconstruir entidades.

---

# Integración con Entity Registry

El Entity Registry constituye la fuente oficial de entidades persistentes.

Durante el Snapshot:

```text
Entity Registry

↓

Enumerate Entities

↓

Snapshot
```

Toda la información estructural proviene del Registry.

---

# Integración con Component Registry

El Component Registry proporciona acceso a los Components persistentes de cada entidad.

Conceptualmente:

```text
Entity

↓

Component Registry

↓

Components

↓

Serializer
```

El Save System nunca inspecciona directamente el almacenamiento interno de los Components.

---

# Integración con Resource Registry

Los Resources nunca forman parte del Save.

Únicamente se persisten sus identificadores.

---

# Flujo

Durante el guardado:

```text
Component

↓

Resource ID

↓

Save
```

Durante la carga:

```text
Resource ID

↓

Resource Registry

↓

Resource Reference
```

Esto garantiza que toda la configuración continúe siendo Data Driven.

---

# Integración con Query Engine

Las Queries no participan en el proceso de persistencia.

Toda la información necesaria para el Save proviene directamente de los Registries.

Si un proceso de carga requiere información derivada, esta debe reconstruirse después de restaurar el Runtime.

---

# Integración con Event Bus

## Filosofía

El Save System nunca utiliza eventos para serializar Components.

Sin embargo, el Runtime puede publicar eventos relacionados con el ciclo de vida del proceso de guardado.

---

# Eventos Conceptuales

Ejemplos:

```text
Save Started
```

```text
Save Completed
```

```text
Load Started
```

```text
Load Completed
```

```text
Save Failed
```

Estos eventos permiten que otros módulos reaccionen sin acoplarse al Save System.

---

# Responsabilidad

El Event Bus únicamente distribuye los eventos.

No participa en la serialización.

---

# Integración con Multiplayer

## Filosofía

La persistencia del mundo pertenece al servidor.

Los clientes nunca generan el estado oficial del Save.

---

# Servidor

Conceptualmente:

```text
Server Runtime

↓

Snapshot

↓

Save File
```

El servidor representa la única fuente autorizada para persistir el estado global.

---

# Cliente

El cliente únicamente mantiene una representación local del estado sincronizado.

La persistencia local, cuando exista, no reemplaza al Save oficial del servidor.

---

# Restauración

Durante una carga en modo Server Authoritative:

```text
Load Save

↓

Restore Server Runtime

↓

Replicate State

↓

Clients Updated
```

Los clientes nunca reconstruyen el mundo de manera independiente.

---

# Integración con Auto Save en Multiplayer

El disparador del Auto Save pertenece al servidor.

Los clientes únicamente reciben el estado actualizado mediante el sistema de replicación.

---

# Integración con Debug Tools

Las herramientas de Debug pueden consultar:

- estado del Save Manager;
- último Snapshot;
- duración del Save;
- tamaño del archivo;
- tiempo de serialización;
- estado de recuperación.

Toda esta información es de solo lectura.

---

# Integración con Profiling

El sistema de profiling puede registrar:

- tiempo de Snapshot;
- tiempo de serialización;
- tiempo de escritura;
- tiempo de restauración;
- cantidad de entidades;
- cantidad de Components;
- tamaño del archivo generado.

Estas métricas permiten optimizar futuras implementaciones.

---

# Integración con Testing

Las pruebas automatizadas pueden simular:

```text
Runtime

↓

Snapshot

↓

Serialize

↓

Deserialize

↓

Restore
```

Comparando el estado original con el restaurado.

---

# Dependencias Permitidas

El Save System puede depender de:

- Scheduler
- Entity Registry
- Component Registry
- Resource Registry
- Runtime Services
- Storage Layer

Siempre mediante interfaces.

---

# Dependencias Prohibidas

El Save System nunca debe depender de:

- gameplay;
- UI;
- escenas;
- Nodes;
- lógica específica de un System.

Toda interacción ocurre mediante abstracciones del Framework.

---

# Restricciones

El Save System nunca debe:

- modificar Resources;
- emitir lógica de gameplay;
- ejecutar Queries para reconstruir el mundo;
- acceder directamente al SceneTree.

Toda la información persistente proviene exclusivamente del estado ECS.

---

# Garantías

La integración del Save System garantiza que:

- el Scheduler controla el momento seguro para capturar Snapshots;
- los Systems permanecen completamente desacoplados de la persistencia;
- el Resource Registry continúa siendo la única fuente de configuración;
- el Multiplayer mantiene un modelo Server Authoritative;
- el Event Bus distribuye únicamente eventos relacionados con el ciclo de vida del Save.

---

# Flujo Completo

Conceptualmente:

```text
Scheduler Barrier

↓

Snapshot

↓

Entity Registry

↓

Component Registry

↓

Serializers

↓

Storage Layer

↓

Save File
```

Durante la carga:

```text
Save File

↓

Deserializer

↓

Entity Registry

↓

Component Registry

↓

Resolve Resources

↓

Runtime Ready
```

Este flujo representa la integración oficial del Save System con el resto del Framework ECS.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificada la integración del **Save System** con el Scheduler, los Systems, los Registries, el Resource Registry, el Event Bus y el Multiplayer Pipeline.

La arquitectura garantiza una persistencia completamente desacoplada del gameplay, basada exclusivamente en el estado ECS del Runtime, preservando el modelo Data Driven, la autoridad del servidor en entornos multijugador y la separación estricta de responsabilidades entre todos los subsistemas del Framework.
# 11 - SAVE IMPLEMENTATION

# Parte 7 — Performance, Optimización, Compresión, Memoria y Escalabilidad

---

# Objetivo

Esta sección define las consideraciones de rendimiento del Save System, las estrategias de optimización, el uso de compresión, la administración de memoria y los criterios de escalabilidad para proyectos de gran tamaño.

El objetivo es garantizar que el sistema de persistencia pueda manejar desde pequeños mundos hasta servidores con millones de entidades sin modificar la arquitectura del Framework.

---

# Filosofía

La optimización nunca debe comprometer:

- consistencia;
- determinismo;
- integridad;
- desacoplamiento.

La prioridad siempre será generar un Save correcto.

Después se optimizará su rendimiento.

---

# Objetivos

La implementación debe minimizar:

- tiempo de Snapshot;
- tiempo de serialización;
- tiempo de escritura;
- consumo de memoria;
- tamaño del archivo;
- pausas perceptibles.

---

# Separación de Costos

Las operaciones del Save Pipeline poseen costos diferentes.

Conceptualmente:

```text
Snapshot

↓

CPU
```

```text
Serialization

↓

CPU
```

```text
Compression

↓

CPU
```

```text
Write File

↓

I/O
```

Cada etapa puede optimizarse de forma independiente.

---

# Snapshot

El Snapshot debe capturar únicamente información persistente.

Nunca debe incluir:

- caches;
- buffers;
- datos temporales;
- estructuras reconstruibles.

Reducir el tamaño del Snapshot reduce automáticamente el costo del resto del Pipeline.

---

# Serialización

Los Serializers deben producir únicamente la información estrictamente necesaria para reconstruir el Runtime.

No deben incluir valores derivados.

Ejemplo conceptual:

Correcto:

```text
Health = 75
```

Incorrecto:

```text
Health = 75

Percentage = 75%

UI State

Cached Values
```

---

# Compresión

## Objetivo

Reducir el tamaño del archivo persistente.

La compresión constituye una etapa independiente del proceso de serialización.

---

# Flujo

Conceptualmente:

```text
Serialized Data

↓

Compression

↓

Compressed Save
```

Durante la carga:

```text
Compressed Save

↓

Decompression

↓

Deserializer
```

---

# Independencia

Los Serializers nunca deben conocer si el Save será comprimido.

Toda la compresión pertenece exclusivamente al Save Pipeline.

---

# Estrategia

La implementación concreta del algoritmo queda desacoplada de la arquitectura.

La infraestructura debe permitir reemplazar el algoritmo sin modificar el resto del sistema.

---

# Compresión Opcional

El Pipeline debe permitir:

```text
Serialize

↓

Compress?
```

Si la compresión se encuentra deshabilitada:

```text
Serialize

↓

Write
```

La lógica superior permanece idéntica.

---

# Administración de Memoria

## Objetivo

Evitar el crecimiento innecesario del consumo de memoria durante operaciones de Save.

---

# Snapshot Inmutable

Mientras el proceso se encuentra activo:

```text
Snapshot

↓

Read Only
```

Esto permite compartir información de forma segura durante la serialización.

---

# Liberación

Una vez completado el proceso:

```text
Save Completed

↓

Release Snapshot

↓

Free Temporary Buffers
```

Toda la memoria temporal debe liberarse inmediatamente.

---

# Buffers Temporales

Los buffers utilizados durante:

- serialización;
- compresión;
- escritura;

deben existir únicamente durante la operación correspondiente.

Nunca deben mantenerse durante todo el Runtime.

---

# Archivos Grandes

La arquitectura debe admitir archivos de gran tamaño sin modificar el Pipeline.

Ejemplo conceptual:

```text
Large World

↓

Snapshot

↓

Serialize

↓

Write
```

El tamaño del mundo no altera el flujo arquitectónico.

---

# Chunk Serialization

En mundos persistentes de gran escala puede resultar conveniente dividir la información.

Conceptualmente:

```text
World

↓

Chunk A

Chunk B

Chunk C

↓

Serialize Independently
```

Esto facilita futuras optimizaciones.

---

# Serialización Incremental

La arquitectura admite una futura evolución hacia serialización incremental.

Ejemplo:

```text
Modified Chunk

↓

Serialize Only Modified Data
```

El Pipeline principal permanece inalterado.

---

# Streaming

También podrá incorporarse:

```text
Chunk

↓

Background Save

↓

Storage
```

Manteniendo la misma interfaz pública.

---

# Paralelización

Las etapas independientes podrán ejecutarse de manera concurrente cuando la implementación lo permita.

Ejemplos:

- serialización de Chunks;
- compresión;
- escritura.

Siempre respetando el determinismo del resultado.

---

# Límites

La paralelización nunca debe alterar:

- orden lógico;
- consistencia;
- integridad del Snapshot.

---

# Escalabilidad

La arquitectura debe soportar:

- millones de Components;
- cientos de miles de entidades;
- múltiples mundos;
- servidores persistentes.

Sin modificar la API pública.

---

# Costos Esperados

Durante el Runtime la operación más costosa debe ser la escritura física del archivo.

Las consultas al estado ECS deben mantenerse eficientes mediante los Registries.

---

# Optimización del Save

Los Serializers deben evitar:

- duplicación de datos;
- referencias redundantes;
- información reconstruible;
- almacenamiento de configuración.

Toda configuración pertenece al Resource Registry.

---

# Optimización del Load

Durante la restauración deben minimizarse:

- asignaciones innecesarias;
- reconstrucciones duplicadas;
- búsquedas repetidas.

La infraestructura debe aprovechar los Registries existentes.

---

# Integración con Resource Registry

Los Resources nunca incrementan significativamente el tamaño del Save.

Únicamente se almacenan identificadores.

Esto representa una de las principales optimizaciones de la arquitectura ECS Data Driven.

---

# Integración con Multiplayer

El servidor puede generar Snapshots completos mientras los clientes continúan recibiendo replicación.

El Save Pipeline permanece completamente independiente del sistema de red.

---

# Profiling

El Profiler debe recopilar métricas como:

- duración del Snapshot;
- tiempo de serialización;
- tiempo de compresión;
- tiempo de escritura;
- memoria temporal utilizada;
- tamaño del archivo final.

Estas métricas permiten identificar cuellos de botella.

---

# Restricciones

Las optimizaciones nunca deben:

- modificar el estado del Runtime;
- alterar el orden lógico;
- eliminar información persistente;
- comprometer la capacidad de restauración.

Toda optimización debe producir exactamente el mismo resultado funcional.

---

# Garantías

La arquitectura garantiza que:

- el Save Pipeline puede optimizarse por etapas;
- la compresión permanece completamente desacoplada;
- la memoria temporal se libera al finalizar la operación;
- la infraestructura puede escalar a mundos persistentes de gran tamaño;
- futuras optimizaciones no requieren modificar la API pública.

---

# Flujo Completo

Conceptualmente:

```text
Snapshot

↓

Serialize

↓

Compress (Optional)

↓

Write

↓

Release Buffers

↓

Complete
```

Durante la carga:

```text
Read File

↓

Decompress

↓

Deserialize

↓

Restore Runtime
```

Este flujo representa el comportamiento oficial de las optimizaciones del Save System.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificada la estrategia de **Performance**, **Compresión**, **Administración de Memoria** y **Escalabilidad** del Save System.

La arquitectura permite optimizar cada etapa del proceso de persistencia de forma independiente, manteniendo un Pipeline determinista y desacoplado, preparado para gestionar mundos persistentes de gran tamaño, operaciones asíncronas y futuras estrategias como serialización incremental, almacenamiento por Chunks y procesamiento concurrente sin comprometer la integridad del Runtime.
# 11 - SAVE IMPLEMENTATION

# Parte 8 — Debug, Testing, Evolución Futura, Restricciones Permanentes y Resumen Arquitectónico

---

# Objetivo

Esta sección define las herramientas de depuración del Save System, la estrategia oficial de testing, las posibilidades de evolución futura de la arquitectura y el conjunto de restricciones permanentes que deberán respetarse durante toda la vida del Framework ECS.

El objetivo es garantizar que el sistema de persistencia pueda evolucionar sin romper la compatibilidad con el resto del Runtime y manteniendo un comportamiento determinista y verificable.

---

# Filosofía

El Save System constituye una infraestructura crítica del Framework.

Toda modificación debe poder:

- verificarse mediante pruebas automatizadas;
- inspeccionarse mediante herramientas de Debug;
- medirse mediante Profiling;
- evolucionar sin modificar la API pública.

---

# Herramientas de Debug

## Objetivo

Permitir inspeccionar el funcionamiento interno del Save Pipeline durante el desarrollo.

Las herramientas de Debug nunca modifican el estado del Runtime.

Toda la información es de solo lectura.

---

# Save Inspector

El Save Inspector permite visualizar:

- estado del Save Manager;
- Snapshot actual;
- tamaño del Snapshot;
- cantidad de entidades;
- cantidad de Components;
- tiempo de serialización.

Conceptualmente:

```text
Save Manager

↓

Save Inspector

↓

Runtime Information
```

---

# Snapshot Viewer

El Snapshot Viewer permite inspeccionar el contenido lógico capturado antes de la serialización.

Ejemplo conceptual:

```text
Snapshot

↓

Entities

↓

Components

↓

Persistent Data
```

Nunca modifica el Snapshot.

---

# Serializer Inspector

Permite visualizar:

- Serializers registrados;
- tipos soportados;
- cobertura de persistencia;
- errores de registro.

Conceptualmente:

```text
Save Registry

↓

Serializer List
```

---

# Storage Inspector

Permite consultar:

- Slots existentes;
- Metadata;
- tamaño de archivos;
- fecha de creación;
- fecha de modificación;
- estado de Backups.

---

# Recovery Inspector

Puede mostrar:

- archivos inválidos;
- Backups disponibles;
- resultados de validaciones;
- historial de errores.

Facilitando el diagnóstico durante el desarrollo.

---

# Logging

El Save System únicamente debe registrar información relevante.

Ejemplos:

- inicio del Save;
- finalización;
- errores;
- recuperación;
- tiempos importantes.

Nunca debe registrar la serialización de cada Component individual durante el Runtime normal.

---

# Profiling

## Objetivo

Medir el comportamiento del Save Pipeline.

El Profiler nunca modifica el funcionamiento del sistema.

---

# Métricas

Como mínimo pueden recopilarse:

- tiempo de Snapshot;
- tiempo de serialización;
- tiempo de compresión;
- tiempo de escritura;
- tiempo de carga;
- tiempo de restauración;
- memoria temporal utilizada;
- tamaño del archivo final.

---

# Comparación

El Profiler puede comparar múltiples operaciones.

Ejemplo conceptual:

```text
Save A

↓

Metrics
```

```text
Save B

↓

Metrics
```

Esto facilita detectar regresiones de rendimiento.

---

# Testing

## Filosofía

Toda funcionalidad del Save System debe poder probarse de manera completamente aislada.

Las pruebas nunca deben depender del gameplay.

---

# Bootstrap Tests

Verifican:

- creación del Save Manager;
- inicialización del Save Registry;
- registro de Serializers;
- disponibilidad del Storage Layer.

---

# Snapshot Tests

Comprueban:

- captura correcta;
- consistencia;
- determinismo;
- ausencia de datos temporales.

---

# Serializer Tests

Cada Serializer debe validar:

- serialización correcta;
- deserialización correcta;
- restauración idéntica;
- manejo de errores.

---

# Entity Tests

Verifican:

- creación;
- restauración;
- referencias;
- identificadores;
- Components persistentes.

---

# World Tests

Comprueban:

- estado global;
- tiempo;
- clima;
- datos persistentes;
- reconstrucción completa.

---

# Save File Tests

Validan:

- escritura;
- lectura;
- Metadata;
- integridad;
- Versionado.

---

# Recovery Tests

Simulan:

- archivos corruptos;
- interrupciones;
- Backups;
- recuperación.

El Runtime nunca debe quedar en un estado inconsistente.

---

# Async Tests

Verifican:

- Snapshot inmutable;
- escritura en segundo plano;
- finalización correcta;
- ausencia de conflictos.

---

# Multiplayer Tests

Comprueban:

Servidor:

```text
Save

↓

Restore

↓

Replicate
```

Cliente:

```text
Receive State
```

Los clientes nunca generan el estado persistente oficial.

---

# Stress Tests

La infraestructura debe probarse con:

- cientos de miles de entidades;
- millones de Components;
- grandes mundos persistentes;
- múltiples Slots;
- múltiples operaciones consecutivas.

---

# Memory Tests

Verifican:

- liberación de Snapshots;
- liberación de Buffers;
- ausencia de pérdidas de memoria;
- reutilización de estructuras.

---

# Evolución Futura

La arquitectura admite futuras extensiones sin modificar la API pública.

---

# Save Incremental

Ejemplo conceptual:

```text
World

↓

Modified Data

↓

Incremental Save
```

---

# Cloud Saves

También podrá incorporarse:

```text
Save File

↓

Cloud Provider

↓

Synchronization
```

La Storage Layer encapsulará completamente esta funcionalidad.

---

# Replicación Persistente

En servidores persistentes podrá implementarse:

```text
Runtime

↓

Continuous Snapshots

↓

Persistent Storage
```

Sin alterar el Save Pipeline.

---

# Streaming Worlds

La arquitectura admite:

```text
Chunk

↓

Background Save

↓

Storage
```

Utilizando exactamente las mismas interfaces.

---

# Migraciones Avanzadas

Podrán añadirse:

- conversión automática;
- múltiples formatos;
- herramientas de reparación;
- actualización entre versiones.

---

# Restricciones Permanentes

El Save System nunca deberá:

- contener lógica de gameplay;
- depender de escenas;
- depender del SceneTree;
- modificar Resources;
- acceder directamente a Systems específicos;
- almacenar configuración Data Driven.

Toda configuración pertenece al Resource Registry.

---

# Buenas Prácticas

Todo consumidor del Save System debería:

- utilizar exclusivamente el Save Manager;
- respetar el Save Pipeline;
- almacenar únicamente datos persistentes;
- evitar duplicación de información.

---

# Antipatrones

Las siguientes prácticas deben evitarse.

---

## Serializar Resources

Incorrecto:

```text
Component

↓

Entire Resource
```

Correcto:

```text
Component

↓

Resource ID
```

---

## Escribir Archivos desde un System

Incorrecto:

```text
Gameplay System

↓

Write Save
```

Toda escritura debe pasar por el Save Manager.

---

## Persistir Datos Reconstruibles

Incorrecto:

```text
Cached Query

↓

Save File
```

Estos datos deben regenerarse automáticamente.

---

## Restauración Parcial del Runtime

Nunca debe activarse la simulación antes de finalizar completamente el proceso de restauración.

Conceptualmente:

Incorrecto:

```text
Restore

↓

Run Systems

↓

Continue Restore
```

Correcto:

```text
Restore

↓

Complete Runtime

↓

Resume Simulation
```

---

# Resumen Arquitectónico

El Save System queda compuesto por los siguientes módulos especializados:

- Save Manager
- Save Pipeline
- Snapshot System
- Save Registry
- Component Serializers
- Component Deserializers
- Save Storage Layer
- Recovery System
- Save Profiler

Cada módulo mantiene una única responsabilidad claramente definida.

---

# Flujo Completo

El comportamiento general del sistema puede resumirse como:

```text
Save Request

↓

Scheduler Barrier

↓

Snapshot

↓

Serialize

↓

Compress

↓

Storage Layer

↓

Verify

↓

Save Complete
```

Durante la carga:

```text
Load Request

↓

Read Save

↓

Validate

↓

Deserialize

↓

Restore Entities

↓

Restore Components

↓

Resolve Resources

↓

Runtime Ready

↓

Resume Simulation
```

Este flujo representa el comportamiento oficial del Save System dentro del Framework ECS.

---

# Relación con el Siguiente Documento

El siguiente documento de esta fase será:

**12_MULTIPLAYER_IMPLEMENTATION.md**

Mientras el Save System define cómo persistir y restaurar el estado completo del Runtime, el documento de Multiplayer especificará la infraestructura encargada de sincronizar ese estado entre servidor y clientes, manteniendo el modelo **Server Authoritative**, el desacoplamiento entre Systems y una replicación determinista basada en ECS.

---

# Resultado Esperado

Con este documento queda completamente especificada la implementación del **Save System** del Framework ECS de Survivors Lords.

La arquitectura establece una infraestructura robusta, escalable y completamente desacoplada para capturar Snapshots consistentes del Runtime, serializar el estado dinámico del mundo, administrar el almacenamiento persistente, restaurar entidades y Components de forma determinista y evolucionar hacia futuras capacidades como persistencia incremental, almacenamiento en la nube y mundos persistentes, manteniendo siempre la separación de responsabilidades definida por el Framework ECS.

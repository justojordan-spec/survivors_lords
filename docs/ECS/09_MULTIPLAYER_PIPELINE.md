# MULTIPLAYER PIPELINE

**Documento:** 09_MULTIPLAYER_PIPELINE.md

**Fase:** ECS Framework

**Estado:** Draft

**Versión:** 1.0

---

# Objetivo

Este documento define la arquitectura del Multiplayer Pipeline del Framework ECS de Survivors Lords.

Su objetivo es especificar cómo el estado del ECS se sincroniza entre el servidor y los clientes manteniendo un modelo Server Authoritative, determinista y escalable.

Este documento no define mecánicas de juego.

No define protocolos de transporte.

No define servicios online.

Define exclusivamente el pipeline interno utilizado por el Framework para sincronizar el estado del mundo.

---

# Alcance

Este documento define:

- Arquitectura Server Authoritative.
- Multiplayer Pipeline.
- World Snapshots.
- Replicación de Components.
- Replicación de Entities.
- Authority.
- Ownership.
- Sincronización.
- Predicción.
- Reconciliación.
- Interpolación.
- Interest Management.
- Integración con ECS.
- Integración con Scheduler.
- Integración con Save.
- Debug.
- Profiling.

---

# Filosofía

El estado oficial del mundo existe únicamente en el servidor.

Los clientes mantienen una representación local del mundo utilizada para:

- Renderizado.
- Predicción.
- Interfaz.
- Audio.
- Simulación parcial cuando corresponda.

Ningún cliente posee autoridad sobre el estado global.

---

# Objetivos

El Multiplayer Pipeline debe garantizar:

- Consistencia.
- Determinismo.
- Escalabilidad.
- Bajo consumo de ancho de banda.
- Baja latencia percibida.
- Seguridad.
- Compatibilidad con Replay.
- Compatibilidad con Save.

---

# Modelo Arquitectónico

El Framework adopta un modelo estrictamente Server Authoritative.

Conceptualmente.

```text
Client

↓

Input

↓

Server

↓

Simulation

↓

Snapshot

↓

Clients
```

Toda modificación permanente del mundo ocurre en el servidor.

---

# Principios Fundamentales

El servidor:

- Ejecuta todos los Systems.
- Posee el ECS oficial.
- Decide el estado del mundo.
- Resuelve conflictos.
- Valida acciones.
- Genera Snapshots.

Los clientes nunca sustituyen estas responsabilidades.

---

# Responsabilidades del Cliente

El cliente es responsable de:

- Capturar Input.
- Renderizar.
- Mostrar UI.
- Reproducir audio.
- Ejecutar predicción cuando corresponda.
- Aplicar Snapshots recibidos.

Nunca valida acciones definitivas.

---

# Responsabilidades del Servidor

El servidor es responsable de:

- Ejecutar el Scheduler.
- Ejecutar Systems.
- Actualizar Components.
- Resolver Commands.
- Gestionar Authority.
- Replicar el estado del mundo.

---

# Arquitectura General

Conceptualmente.

```text
Client Input

↓

Network Layer

↓

Server

↓

Scheduler

↓

Systems

↓

ECS

↓

Replication Pipeline

↓

Snapshot

↓

Clients
```

---

# Multiplayer Pipeline

El pipeline completo sigue la siguiente secuencia.

```text
Receive Input

↓

Validate

↓

Execute Simulation

↓

Update ECS

↓

Replication

↓

Serialize

↓

Send Snapshot

↓

Apply Snapshot
```

Cada etapa posee una única responsabilidad.

---

# Authority

La Authority representa quién tiene permiso para modificar un determinado estado del mundo.

En Survivors Lords la Authority pertenece al servidor.

Los clientes únicamente realizan solicitudes.

---

# Filosofía de Authority

Modificar un Component requiere Authority.

Ejemplo.

```text
Client

↓

Move Request

↓

Server

↓

Position Updated
```

El cliente nunca modifica directamente la posición oficial.

---

# Ownership

Ownership indica qué cliente controla una Entity determinada.

Ejemplo.

```text
Player Entity

↓

Owner

↓

Client A
```

El Ownership no implica Authority.

El servidor continúa siendo la autoridad final.

---

# Authority vs Ownership

Conceptualmente.

```text
Ownership

↓

Quién controla

Authority

↓

Quién decide
```

Ambos conceptos deben permanecer completamente separados.

---

# World Snapshot

El Snapshot representa el estado sincronizable del mundo en un instante determinado.

No contiene la simulación completa.

Contiene únicamente la información necesaria para actualizar los clientes.

---

# Contenido de un Snapshot

Conceptualmente un Snapshot puede incluir:

- Entities visibles.
- Components replicables.
- Estado global.
- Tick de simulación.
- Metadata.

Nunca incluye:

- Queries.
- Event Queue.
- Deferred Commands.
- Systems.
- Resources completos.

---

# Tick de Simulación

Cada Snapshot está asociado a un Tick de simulación.

Ejemplo.

```text
Tick

15240
```

Este identificador permite:

- Reconciliación.
- Debug.
- Replay.
- Sincronización.

---

# Snapshot Pipeline

Conceptualmente.

```text
Simulation

↓

Collect Replicated Components

↓

Build Snapshot

↓

Serialize

↓

Compress

↓

Network

↓

Client
```

---

# Snapshot Inmutable

Una vez construido, un Snapshot nunca debe modificarse.

Todos los clientes reciben exactamente el mismo contenido correspondiente a ese Tick.

---

# Integración con ECS

El Multiplayer Pipeline nunca modifica directamente los Systems.

Interactúa exclusivamente mediante:

- Components.
- Entity Registry.
- Resource IDs.
- Scheduler.

Esto mantiene el desacoplamiento del Framework.

---

# Continúa en la Parte 2

La siguiente parte desarrollará:

- Replicación de Components.
- Replicación de Entities.
- Componentes sincronizables.
- Delta Replication.
- Interest Management.
- Prioridades de replicación.
- Frecuencia de actualización.
---

# Replicación de Entities

No todas las Entities existentes en el servidor deben sincronizarse con todos los clientes.

El Multiplayer Pipeline determina qué Entities forman parte de cada Snapshot.

La replicación es completamente independiente del ECS.

---

# Filosofía

La existencia de una Entity dentro del servidor no implica automáticamente su existencia en todos los clientes.

Cada cliente recibe únicamente las Entities que necesita conocer.

---

# Entities Replicables

Una Entity puede encontrarse en uno de los siguientes estados conceptuales.

```text
Replicated

Not Replicated

Pending Creation

Pending Destruction
```

Estos estados pertenecen exclusivamente al Multiplayer Pipeline.

No forman parte del ECS.

---

# Ciclo de Vida

Conceptualmente.

```text
Entity Created

↓

Visible

↓

Replicated

↓

Updated

↓

Hidden

↓

Destroyed
```

Cada transición genera cambios en los Snapshots posteriores.

---

# Replicación de Components

Cada Component define explícitamente si participa o no del proceso de sincronización.

Ejemplo conceptual.

```text
Health

Replicated ✔

------------

DebugComponent

Replicated ✖
```

Esta decisión forma parte del contrato del Component.

---

# Componentes Replicables

Un Component replicable debe cumplir las siguientes reglas:

- Contiene únicamente estado sincronizable.
- Es serializable.
- Es determinista.
- Posee un formato estable.
- Puede reconstruirse en el cliente.

---

# Componentes No Replicables

Ejemplos típicos:

- Cachés.
- Datos temporales.
- Información de Debug.
- Buffers internos.
- Resultados de Queries.
- Estado del Editor.

Estos Components existen únicamente en la instancia local correspondiente.

---

# Estado Replicable

No necesariamente todo el contenido de un Component debe sincronizarse.

Ejemplo.

```text
Health Component

Current Health ✔

Max Health ✔

Cached UI Color ✖
```

Solo deben enviarse los datos necesarios para reconstruir el estado del mundo.

---

# Replication Pipeline

Para cada Tick, el servidor ejecuta el siguiente proceso.

```text
Collect Entities

↓

Collect Components

↓

Filter

↓

Serialize

↓

Compress

↓

Send
```

Este proceso ocurre después de finalizar la simulación del Tick.

---

# Delta Replication

Enviar el estado completo del mundo en cada Snapshot resulta ineficiente.

El Framework utiliza Delta Replication.

Conceptualmente.

```text
Snapshot 100

↓

Snapshot 101

↓

Only Differences
```

Solo se transmiten los cambios.

---

# Objetivos del Delta

La Delta Replication permite:

- Reducir ancho de banda.
- Disminuir tamaño de paquetes.
- Mejorar escalabilidad.
- Reducir latencia.

---

# Dirty State

Cada Component replicable mantiene un estado conceptual.

```text
Clean

Dirty
```

Cuando un Component cambia:

```text
Modify Component

↓

Dirty
```

El Replication Pipeline utiliza esta información para decidir qué enviar.

---

# Dirty Tracking

El seguimiento de cambios debe ser automático.

Los Systems nunca marcan manualmente un Component como Dirty.

El Framework detecta las modificaciones durante la simulación.

---

# Snapshot Baseline

Para calcular un Delta, el servidor conserva una referencia al último Snapshot confirmado por cada cliente.

Conceptualmente.

```text
Baseline

↓

Current Snapshot

↓

Delta
```

Cada cliente puede tener un Baseline diferente.

---

# Frecuencia de Replicación

No todos los Components requieren la misma frecuencia de actualización.

Ejemplos conceptuales.

```text
Transform

30 Hz

------------

Health

On Change

------------

Quest

On Change
```

La frecuencia forma parte de la configuración del Multiplayer Pipeline.

---

# Prioridades

Los Components pueden clasificarse según su importancia.

Conceptualmente.

```text
Critical

↓

High

↓

Normal

↓

Low
```

Cuando el ancho de banda es limitado, las prioridades determinan qué información se envía primero.

---

# Interest Management

Cada cliente recibe únicamente la información relevante para su contexto.

Conceptualmente.

```text
Server

↓

Interest Filter

↓

Relevant Entities

↓

Snapshot
```

---

# Objetivos del Interest Management

Permite:

- Reducir tráfico.
- Mejorar escalabilidad.
- Disminuir uso de CPU.
- Disminuir uso de memoria.
- Evitar transmitir información innecesaria.

---

# Criterios de Interés

El Framework puede combinar múltiples criterios.

Ejemplos:

- Distancia.
- Región.
- Visibilidad.
- Equipo.
- Instancia.
- Nivel de detalle.
- Estado de conexión.

La estrategia exacta pertenece al Multiplayer System y no al ECS.

---

# Creación de Entities

Cuando una Entity entra por primera vez en el área de interés de un cliente:

```text
Server

↓

Create Entity Message

↓

Client

↓

Instantiate Local Entity
```

A partir de ese momento comienza la replicación incremental.

---

# Destrucción de Entities

Cuando una Entity deja de existir o deja de ser relevante:

```text
Server

↓

Destroy Entity Message

↓

Client

↓

Remove Local Entity
```

El ECS local elimina la Entity correspondiente.

---

# Consistencia

Al finalizar cada Tick el Multiplayer Pipeline garantiza que:

- Todos los Components Dirty fueron evaluados.
- Todos los Deltas fueron calculados.
- Todos los Snapshots permanecen consistentes.
- Ningún cliente recibe datos estructuralmente inválidos.

---

# Continúa en la Parte 3

La siguiente parte desarrollará:

- Client Prediction.
- Server Reconciliation.
- Interpolation.
- Extrapolation.
- Latency Compensation.
- Input Pipeline.
- Network Commands.
- Integración con el Scheduler.
---

# Client Prediction

El modelo Server Authoritative introduce latencia entre el momento en que el jugador realiza una acción y el instante en que el servidor responde.

Para reducir la latencia percibida, el Framework permite Client Prediction para acciones autorizadas.

La predicción nunca reemplaza la simulación oficial.

---

# Filosofía

La predicción únicamente mejora la respuesta visual del cliente.

El estado definitivo siempre pertenece al servidor.

Conceptualmente.

```text
Input

↓

Local Prediction

↓

Visual Response

↓

Server Validation

↓

Correction
```

---

# Objetivos

La Client Prediction debe:

- Reducir la sensación de latencia.
- Mantener consistencia.
- Evitar divergencias permanentes.
- Integrarse con la reconciliación.
- Ser transparente para los Systems.

---

# Flujo General

```text
Player Input

↓

Send Input

↓

Predict Local State

↓

Receive Snapshot

↓

Compare

↓

Reconcile
```

---

# Alcance de la Predicción

No todas las acciones deben predecirse.

Ejemplos adecuados:

- Movimiento.
- Rotación.
- Animaciones locales.
- Cámara.

Ejemplos que no deben predecirse:

- Daño definitivo.
- Inventario.
- Economía.
- Crafting.
- Investigación.
- Diplomacia.

Estas acciones requieren confirmación del servidor.

---

# Input Pipeline

Los clientes nunca envían cambios de estado.

Únicamente envían Input.

Conceptualmente.

```text
Move Forward

Jump

Attack

Interact
```

El servidor interpreta el Input y ejecuta la simulación.

---

# Input Buffer

Cada cliente mantiene un historial temporal de Inputs enviados.

Conceptualmente.

```text
Tick 200

Move

↓

Tick 201

Move

↓

Tick 202

Jump
```

Este historial permite reconstruir la simulación durante la reconciliación.

---

# Input Sequence

Cada Input debe incluir un identificador secuencial.

Ejemplo.

```text
Input #1845
```

El servidor utiliza esta información para confirmar qué Inputs ya fueron procesados.

---

# Server Reconciliation

Cuando el cliente recibe un Snapshot oficial:

```text
Snapshot

↓

Compare

↓

Rollback

↓

Replay Inputs

↓

Current State
```

La reconciliación elimina diferencias entre la simulación local y la simulación oficial.

---

# Rollback

Si existe una diferencia significativa:

El cliente restaura el estado oficial recibido.

Posteriormente vuelve a ejecutar todos los Inputs pendientes.

Conceptualmente.

```text
Server State

↓

Rollback

↓

Replay Inputs

↓

Current Prediction
```

---

# Objetivos de la Reconciliación

Permite:

- Eliminar errores acumulados.
- Corregir desincronizaciones.
- Mantener una experiencia fluida.
- Preservar la autoridad del servidor.

---

# Interpolation

La información recibida desde el servidor puede visualizarse mediante interpolación.

Conceptualmente.

```text
Snapshot A

↓

Interpolation

↓

Snapshot B
```

El objetivo es suavizar el movimiento de las Entities remotas.

---

# Extrapolation

Cuando no se recibe un Snapshot a tiempo, el cliente puede extrapolar temporalmente el movimiento.

Conceptualmente.

```text
Last Velocity

↓

Estimate Position
```

La extrapolación debe utilizarse únicamente durante intervalos muy cortos.

---

# Corrección Visual

Cuando la diferencia entre el estado predicho y el estado oficial es pequeña, la corrección debe realizarse de forma gradual.

Ejemplo.

```text
Predicted Position

↓

Blend

↓

Server Position
```

Esto evita movimientos bruscos visibles.

---

# Corrección Inmediata

Si la diferencia supera un umbral definido por el Framework:

```text
Prediction

↓

Large Error

↓

Snap To Server
```

La prioridad es mantener la consistencia del mundo.

---

# Compensación de Latencia

El Multiplayer Pipeline puede incorporar mecanismos de compensación para acciones sensibles al tiempo.

Ejemplos:

- Disparos.
- Golpes cuerpo a cuerpo.
- Interacciones rápidas.

La implementación concreta pertenece al Multiplayer System, pero el Pipeline debe permitir su integración.

---

# Integración con el Scheduler

El Scheduler coordina el orden de ejecución de la simulación de red.

Conceptualmente.

```text
Receive Network

↓

Process Inputs

↓

Simulation

↓

Generate Snapshot

↓

Send Snapshot
```

Todos los clientes y el servidor deben respetar este orden lógico.

---

# Integración con ECS

La predicción nunca modifica la arquitectura del ECS.

Los Systems continúan operando sobre Components.

La diferencia radica en el origen de los datos:

- Estado oficial.
- Estado predicho.
- Estado reconciliado.

---

# Consistencia

El Multiplayer Pipeline garantiza que:

- Todos los Inputs son procesados en orden.
- La reconciliación utiliza Snapshots oficiales.
- La predicción nunca reemplaza la autoridad del servidor.
- Las correcciones mantienen la coherencia del ECS.

---

# Continúa en la Parte 4

La siguiente parte desarrollará:

- Serialización de red.
- Compresión.
- Optimización del ancho de banda.
- Seguridad.
- Validaciones.
- Debug Tools.
- Profiling.
- Buenas prácticas.
- Anti-patrones.
- Estado final del documento.
---

# Serialización de Red

Antes de transmitir un Snapshot, el Multiplayer Pipeline transforma el estado replicable del ECS en un formato optimizado para la red.

Este proceso es independiente del Save Pipeline.

Aunque ambos serializan datos, sus objetivos son diferentes.

- El Save Pipeline prioriza persistencia.
- El Multiplayer Pipeline prioriza velocidad y tamaño.

---

# Objetivos

La serialización de red debe garantizar:

- Bajo consumo de ancho de banda.
- Baja latencia.
- Formato determinista.
- Compatibilidad entre versiones.
- Alto rendimiento.

---

# Pipeline de Serialización

Conceptualmente.

```text
Snapshot

↓

Serialize

↓

Compress

↓

Packet Builder

↓

Network Layer
```

Cada etapa posee una única responsabilidad.

---

# Formato de Datos

El formato utilizado por el Multiplayer Pipeline debe ser:

- Compacto.
- Determinista.
- Versionable.
- Independiente de la plataforma.

Los Systems nunca conocen este formato.

---

# Serialización Incremental

Siempre que sea posible, el Framework debe serializar únicamente la información modificada.

Conceptualmente.

```text
Snapshot

↓

Dirty Components

↓

Serialize Delta
```

Esto reduce significativamente el tamaño de cada paquete.

---

# Compresión

Después de serializar los datos, el Framework puede aplicar compresión.

Objetivos:

- Reducir ancho de banda.
- Reducir tamaño de paquetes.
- Mantener tiempos de procesamiento aceptables.

La estrategia concreta dependerá de la implementación final.

---

# Packet Builder

El Packet Builder organiza la información antes de enviarla.

Conceptualmente.

```text
Header

↓

Tick

↓

Entities

↓

Components

↓

Metadata
```

La capa de red transmite únicamente paquetes completos.

---

# Fragmentación

Cuando un Snapshot supera el tamaño máximo permitido por el transporte utilizado, el Framework debe fragmentarlo.

Conceptualmente.

```text
Snapshot

↓

Fragment A

Fragment B

Fragment C
```

El cliente reconstruye el Snapshot antes de procesarlo.

---

# Validación de Paquetes

Todo paquete recibido debe validarse antes de incorporarse al Multiplayer Pipeline.

Las comprobaciones mínimas incluyen:

- Versión.
- Tamaño.
- Integridad.
- Tick.
- Formato.
- Consistencia estructural.

Los paquetes inválidos deben descartarse.

---

# Seguridad

El servidor nunca debe confiar en los datos enviados por un cliente.

Toda información recibida debe validarse antes de afectar el ECS.

Ejemplos:

- Inputs.
- Solicitudes de interacción.
- Acciones de jugador.

Nunca deben modificar directamente Components.

---

# Protección del ECS

El ECS oficial solo puede modificarse mediante el Scheduler y los Systems autorizados.

La capa de red nunca modifica directamente:

- Components.
- Queries.
- Event Queue.
- Resource Registry.

---

# Tolerancia a Pérdidas

El Multiplayer Pipeline debe tolerar:

- Paquetes perdidos.
- Llegada fuera de orden.
- Retransmisiones.
- Latencia variable.

La simulación debe permanecer consistente incluso bajo condiciones de red imperfectas.

---

# Integración con Save Pipeline

Ambos pipelines comparten principios de serialización, pero mantienen responsabilidades completamente separadas.

Save Pipeline:

```text
Persistencia
```

Multiplayer Pipeline:

```text
Sincronización
```

Ninguno depende del otro.

---

# Debug Tools

El Framework debe proporcionar herramientas para inspeccionar el comportamiento de la sincronización de red.

Estas herramientas pertenecen exclusivamente al entorno de desarrollo.

---

# Network Inspector

El Network Inspector permite visualizar:

- Clientes conectados.
- Snapshots enviados.
- Snapshots recibidos.
- Latencia.
- Pérdida de paquetes.
- Ancho de banda.

---

# Replication Inspector

Debe ser posible inspeccionar:

- Entities replicadas.
- Components replicados.
- Estado Dirty.
- Frecuencia de actualización.
- Baseline utilizado.

Esto facilita detectar problemas de sincronización.

---

# Prediction Inspector

Durante el desarrollo el Framework puede mostrar:

- Estado predicho.
- Estado oficial.
- Error acumulado.
- Número de reconciliaciones.
- Rollbacks realizados.

Estas métricas ayudan a ajustar la predicción y la reconciliación.

---

# Profiling

El Multiplayer Pipeline debe recopilar métricas como:

- Tiempo de serialización.
- Tiempo de compresión.
- Tiempo de construcción del Snapshot.
- Tiempo de reconciliación.
- Cantidad de Components replicados.
- Tamaño promedio de paquetes.
- Ancho de banda utilizado.

---

# Optimización

El Pipeline debe minimizar:

- Datos redundantes.
- Allocations.
- Copias de memoria.
- Componentes innecesarios.
- Frecuencia de actualización excesiva.

El objetivo es mantener un rendimiento estable con un gran número de jugadores y Entities.

---

# Buenas Prácticas

Se recomienda:

- Replicar únicamente información necesaria.
- Mantener Components pequeños.
- Utilizar Delta Replication siempre que sea posible.
- Configurar correctamente el Interest Management.
- Evitar predicción sobre sistemas complejos o críticos.
- Validar toda información proveniente del cliente.

---

# Anti-Patrones

El Framework prohíbe expresamente:

- Permitir que un cliente modifique directamente el ECS oficial.
- Replicar Queries.
- Replicar Events.
- Replicar Systems.
- Replicar Resources completos.
- Enviar el estado completo del mundo en cada Tick.
- Confiar en datos no validados provenientes de clientes.

---

# Convenciones

Todo proceso de sincronización deberá cumplir las siguientes reglas:

- El servidor es la única autoridad.
- Los clientes envían Inputs, no estados.
- Los Snapshots son inmutables.
- La replicación es determinista.
- Toda validación ocurre antes de modificar el ECS.
- El Multiplayer Pipeline permanece desacoplado del gameplay.

---

# Resumen del Pipeline

```text
Client Input
        │
        ▼
Server Validation
        │
        ▼
Simulation
        │
        ▼
Update ECS
        │
        ▼
Collect Replicated Components
        │
        ▼
Build Snapshot
        │
        ▼
Serialize
        │
        ▼
Compress
        │
        ▼
Send
        │
        ▼
Receive
        │
        ▼
Reconcile
        │
        ▼
Update Client World
```

---

# Garantías del Multiplayer Pipeline

Al finalizar cada Tick el Framework garantiza que:

- El servidor mantiene el estado oficial del mundo.
- Todos los Snapshots representan un estado consistente del ECS.
- Los clientes reciben únicamente la información correspondiente a su área de interés.
- La reconciliación preserva la autoridad del servidor.
- El ECS permanece desacoplado de la capa de transporte.
- La sincronización es determinista y reproducible.

---

# Relación con el Framework

El Multiplayer Pipeline interactúa con:

- Scheduler.
- ECS.
- Entity Registry.
- Component Registry.
- Resource Registry.
- Save Pipeline.
- Event Bus.
- Query System.
- Debug Tools.

Sin embargo, mantiene una única responsabilidad:

**Sincronizar el estado del ECS entre servidor y clientes de forma eficiente, determinista y completamente Server Authoritative.**

---

# Estado

**Estado actual:** Especificación del Multiplayer Pipeline.

Este documento define el contrato técnico para la implementación de la infraestructura multijugador del Framework ECS de Survivors Lords.

Toda sincronización de estado entre servidor y clientes deberá realizarse exclusivamente mediante el pipeline aquí descrito. Cualquier modificación al modelo de replicación, snapshots, predicción, reconciliación o serialización de red deberá documentarse mediante una DEC (Design Engineering Change) antes de su implementación.
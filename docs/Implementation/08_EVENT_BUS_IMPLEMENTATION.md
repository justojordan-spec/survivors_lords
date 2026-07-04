# 08 - EVENT BUS IMPLEMENTATION

# Parte 1 — Arquitectura General

---

# Objetivo

Este documento define la implementación del Event Bus del Framework ECS de Survivors Lords.

El Event Bus constituye el mecanismo oficial de comunicación entre los distintos Systems del Runtime.

Su implementación debe proporcionar una infraestructura desacoplada, determinista y escalable que permita intercambiar información sin crear dependencias directas entre Systems.

El Event Bus no implementa gameplay.

No interpreta el significado de los eventos.

No contiene lógica del juego.

Únicamente coordina el flujo de comunicación dentro del Runtime.

---

# Alcance

Este documento define:

- Arquitectura del Event Bus.
- Registro de suscripciones.
- Gestión de eventos.
- Ciclo de vida de los eventos.
- Despacho.
- Integración con el Scheduler.
- Validaciones.
- Profiling.
- Debug.
- Testing.

No define:

- Gameplay.
- Systems concretos.
- Components.
- Queries.
- Save.
- Multiplayer.

---

# Filosofía

El Framework adopta un modelo completamente **Event Driven**.

Los Systems nunca deben comunicarse directamente entre sí.

Toda interacción entre Systems debe realizarse mediante eventos o consultas (Queries).

Este principio garantiza:

- bajo acoplamiento;
- alta cohesión;
- facilidad de mantenimiento;
- modularidad;
- escalabilidad.

---

# Principios Arquitectónicos

Toda implementación del Event Bus debe cumplir los siguientes principios.

- Desacoplamiento total.
- Comunicación unidireccional.
- Determinismo.
- Orden estable.
- Seguridad durante el despacho.
- Escalabilidad.
- Compatibilidad con Multiplayer.
- Compatibilidad con Replay.
- Compatibilidad con herramientas de Debug.

---

# Qué es un Evento

Un evento representa un hecho ocurrido dentro del Runtime.

Ejemplos conceptuales:

```text
Entity Spawned

Inventory Changed

Damage Applied

Health Changed

Item Crafted

Building Completed
```

Un evento describe algo que ya ocurrió.

No representa una solicitud.

No representa un comando.

---

# Eventos vs Commands

Es importante distinguir ambos conceptos.

## Command

Representa una intención.

Ejemplo:

```text
Create Entity
```

Todavía no ocurrió.

---

## Event

Representa un hecho consumado.

Ejemplo:

```text
Entity Created
```

Ya ocurrió.

---

# Responsabilidad del Event Bus

El Event Bus es responsable exclusivamente de:

- recibir eventos;
- almacenarlos temporalmente;
- administrar suscripciones;
- despacharlos;
- mantener el orden;
- proporcionar herramientas de diagnóstico.

No interpreta el contenido del evento.

---

# Arquitectura General

Internamente el Event Bus se divide en varios módulos especializados.

```text
                    IEventBus
                         │
                         ▼
                     EventBus
──────────────────────────────────────────────────────
                         │
      ┌────────────┬──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
      ▼            ▼              ▼              ▼              ▼              ▼
 EventQueue
 EventDispatcher
 SubscriptionRegistry
 EventValidator
 EventProfiler
 EventHistory
```

Cada módulo posee una única responsabilidad.

---

# EventBus

## Responsabilidad

Actúa como fachada pública del sistema.

Coordina los distintos módulos internos.

Expone la API utilizada por el Runtime.

Nunca implementa el despacho directamente.

Nunca almacena eventos directamente.

Nunca mantiene listas de suscriptores.

Toda responsabilidad específica se delega.

---

# Event Queue

## Responsabilidad

Almacenar los eventos pendientes de despacho.

Características:

- orden determinista;
- inserción rápida;
- lectura secuencial;
- integración con el Scheduler.

La cola no interpreta eventos.

---

# Event Dispatcher

## Responsabilidad

Entregar cada evento a los suscriptores correspondientes.

Conceptualmente:

```text
Event

↓

Subscribers

↓

Invoke Handlers
```

No mantiene estado permanente.

---

# Subscription Registry

## Responsabilidad

Mantener todas las suscripciones activas.

Conceptualmente:

```text
DamageEvent

↓

CombatSystem

↓

UISystem

↓

AudioSystem
```

El Dispatcher consulta este Registry para conocer los receptores.

---

# Event Validator

## Responsabilidad

Verificar que los eventos puedan procesarse correctamente.

Ejemplos:

- tipo registrado;
- suscriptores válidos;
- datos mínimos disponibles;
- estado consistente.

---

# Event Profiler

## Responsabilidad

Recopilar estadísticas relacionadas con el Event Bus.

Ejemplos:

- eventos emitidos;
- eventos despachados;
- tiempo de despacho;
- eventos por Frame;
- tamaño medio de la cola.

No modifica el comportamiento del Runtime.

---

# Event History

## Responsabilidad

Mantener un historial temporal de eventos para herramientas de depuración.

Ejemplo conceptual:

```text
Frame 450

↓

EntitySpawned

↓

DamageApplied

↓

InventoryUpdated

↓

EntityDestroyed
```

Este módulo puede deshabilitarse en compilaciones Release.

---

# Flujo General

Conceptualmente:

```text
System

↓

Emit Event

↓

Event Bus

↓

Queue

↓

Scheduler Barrier

↓

Dispatcher

↓

Subscribers
```

Todos los eventos siguen exactamente este flujo.

---

# Integración con el Scheduler

El Event Bus nunca decide cuándo despachar eventos.

La sincronización pertenece exclusivamente al Scheduler.

Conceptualmente:

```text
Systems

↓

Emit Events

↓

Queue

↓

Scheduler Flush

↓

Dispatch
```

---

# Integración con Systems

Los Systems únicamente pueden:

- emitir eventos;
- suscribirse a eventos.

Nunca deben:

- acceder internamente al Event Bus;
- modificar la cola;
- ejecutar el Dispatcher;
- alterar las suscripciones de otros Systems.

---

# Integración con Components

Los Components nunca generan eventos.

Los Components contienen únicamente datos.

Toda decisión de emitir eventos pertenece exclusivamente a los Systems.

---

# Integración con Queries

Queries y Events son mecanismos diferentes.

Las Queries:

- solicitan información.

Los Events:

- notifican hechos ocurridos.

Ambos mecanismos son complementarios.

---

# Ciclo de Vida

El Event Bus posee un ciclo de vida propio.

```text
Created

↓

Initialized

↓

Ready

↓

Running

↓

Paused

↓

Stopped

↓

Disposed
```

---

# Created

El objeto existe.

Todavía no posee módulos internos.

---

# Initialized

Todos los módulos internos fueron creados.

Todavía no procesa eventos.

---

# Ready

El Runtime puede comenzar a emitir eventos.

---

# Running

El Event Bus procesa eventos normalmente.

---

# Paused

La cola puede seguir aceptando eventos si la política del Scheduler lo permite.

No se realiza despacho hasta reanudar la ejecución.

---

# Stopped

No se aceptan nuevos eventos.

La cola puede vaciarse antes de finalizar.

---

# Disposed

Todos los recursos internos fueron liberados.

Las suscripciones desaparecen.

La cola deja de existir.

---

# Garantías

Toda implementación debe garantizar:

- un único Event Bus activo;
- una única cola oficial;
- orden determinista;
- ausencia de referencias directas entre Systems;
- consistencia durante todo el Runtime.

---

# Separación de Responsabilidades

| Módulo | Responsabilidad |
|----------|----------------|
| EventBus | API pública |
| EventQueue | Cola de eventos |
| EventDispatcher | Despacho |
| SubscriptionRegistry | Suscripciones |
| EventValidator | Validaciones |
| EventProfiler | Métricas |
| EventHistory | Historial Debug |

Ningún módulo debe asumir responsabilidades pertenecientes a otro.

---

# Dependencias Permitidas

El Event Bus puede depender de:

- IECSContext;
- Scheduler (para sincronización);
- interfaces internas del Runtime.

No debe depender de:

- gameplay;
- Components específicos;
- Systems concretos;
- Nodes de Godot;
- escenas;
- UI.

---

# Objetivos Arquitectónicos

La implementación debe permitir:

- miles de eventos por Frame;
- cientos de suscriptores;
- orden determinista;
- bajo coste de despacho;
- fácil instrumentación;
- compatibilidad con Replay;
- compatibilidad con Multiplayer;
- futuras optimizaciones sin modificar la API pública.

---

# Resultado Esperado

Al finalizar esta primera parte queda definida la arquitectura general del Event Bus del Framework ECS.

El Event Bus se establece como el único mecanismo oficial de comunicación basada en eventos entre los Systems, organizando su funcionamiento mediante módulos especializados para la gestión de la cola, el despacho, las suscripciones, la validación, el profiling y las herramientas de depuración, manteniendo un diseño completamente desacoplado y preparado para la evolución futura del Runtime.
# 08 - EVENT BUS IMPLEMENTATION

# Parte 2 — Event Queue y Event Lifecycle

---

# Objetivo

Esta sección define el funcionamiento de la cola de eventos (Event Queue) y el ciclo de vida completo que sigue un evento desde su creación hasta su eliminación del Runtime.

El objetivo principal es garantizar que todos los eventos sean procesados de forma:

- determinista;
- consistente;
- desacoplada;
- segura;
- independiente del orden de ejecución de los Systems.

---

# Filosofía

Un evento nunca debe despacharse inmediatamente después de ser emitido.

Los eventos representan información pendiente de distribución.

Todos los eventos pasan obligatoriamente por la Event Queue antes de llegar a sus suscriptores.

Este principio evita:

- recursividad inesperada;
- modificaciones durante iteraciones;
- dependencias ocultas;
- diferencias entre ejecución local y Multiplayer.

---

# Principio Fundamental

Todo evento sigue exactamente el siguiente recorrido:

```text
System

↓

Create Event

↓

Event Queue

↓

Scheduler Barrier

↓

Dispatcher

↓

Subscribers

↓

Destroy Event
```

Ningún evento puede omitir una etapa.

---

# ¿Qué es la Event Queue?

La Event Queue es una estructura temporal que almacena todos los eventos emitidos durante un Frame.

Su única responsabilidad consiste en conservar dichos eventos hasta que el Scheduler determine que pueden despacharse.

No interpreta información.

No ejecuta lógica.

No conoce a los suscriptores.

---

# Responsabilidades

La Event Queue únicamente debe:

- aceptar nuevos eventos;
- conservar el orden de inserción;
- permitir su lectura durante el Flush;
- eliminar eventos ya procesados;
- reutilizar memoria cuando sea posible.

Nada más.

---

# Flujo General

Conceptualmente:

```text
Systems

↓

Emit Event

↓

Queue

↓

Wait

↓

Scheduler Flush

↓

Dispatcher
```

---

# Emisión de Eventos

Cuando un System detecta un hecho relevante:

```text
Health Changed

↓

Create Event

↓

Queue.Push()
```

El evento queda pendiente.

Todavía nadie lo recibe.

---

# Inmutabilidad

Una vez emitido:

- el evento no debe modificarse;
- su contenido permanece constante;
- todos los suscriptores observan exactamente la misma información.

Esto garantiza consistencia durante el despacho.

---

# Orden de Inserción

La Queue conserva el orden exacto de creación.

Ejemplo:

```text
Damage Event

↓

Health Changed

↓

Entity Destroyed
```

Ese mismo orden deberá respetarse durante el despacho, salvo que futuras políticas de prioridad indiquen lo contrario.

---

# Cola FIFO

La implementación base utiliza un modelo FIFO.

```text
First In

↓

First Out
```

Este comportamiento resulta simple, determinista y suficiente para la mayoría de los casos.

---

# Compatibilidad con Prioridades

Aunque la implementación inicial sea FIFO, la arquitectura debe permitir incorporar prioridades en el futuro.

Ejemplo conceptual:

```text
Critical

↓

High

↓

Normal

↓

Low
```

La API pública no debe cambiar si se incorpora esta capacidad.

---

# Estado del Evento

Todo evento atraviesa una serie de estados.

```text
Created

↓

Queued

↓

Pending Dispatch

↓

Dispatching

↓

Completed

↓

Removed
```

Cada transición posee un significado específico.

---

# Created

El evento acaba de ser construido.

Todavía no pertenece al Event Bus.

---

# Queued

El evento fue aceptado por la Event Queue.

Permanece almacenado hasta el siguiente Flush.

---

# Pending Dispatch

El Scheduler ha seleccionado la cola para procesamiento.

Todavía no comenzó el despacho.

---

# Dispatching

El Dispatcher está notificando a todos los suscriptores registrados.

Durante este estado:

- el evento es de solo lectura;
- no debe modificarse;
- no puede volver a encolarse.

---

# Completed

Todos los suscriptores finalizaron correctamente.

El evento ya no volverá a utilizarse.

---

# Removed

El evento se elimina de la Queue.

La memoria puede reutilizarse.

---

# Duración

Los eventos son objetos de vida corta.

Su existencia normalmente se limita a un único Frame.

Conceptualmente:

```text
Frame N

↓

Create

↓

Dispatch

↓

Destroy
```

---

# Eventos Persistentes

La implementación base no contempla eventos persistentes.

Si en el futuro fueran necesarios, deberán implementarse mediante un mecanismo específico y no modificando el comportamiento estándar de la Event Queue.

---

# Eventos Diferidos

Todos los eventos son diferidos.

Esto significa que:

```text
Emit

≠

Dispatch
```

Existe siempre una separación temporal entre ambos momentos.

---

# Emisión Durante el Despacho

Un System puede emitir nuevos eventos mientras procesa otro evento.

Ejemplo:

```text
Damage Event

↓

Combat System

↓

Emit Death Event
```

El nuevo evento nunca debe procesarse inmediatamente.

Debe incorporarse a la Queue y esperar el siguiente punto de despacho definido por el Scheduler.

---

# Evitar Recursividad

El modelo diferido elimina situaciones como:

```text
A

↓

B

↓

C

↓

A
```

donde los eventos podrían generar ciclos infinitos de llamadas.

---

# Integración con el Scheduler

La Event Queue nunca decide cuándo procesar sus eventos.

Únicamente responde a la orden del Scheduler.

Conceptualmente:

```text
Scheduler

↓

Flush Events

↓

Queue

↓

Dispatcher
```

---

# Cancelación

Antes del Flush el Scheduler puede descartar eventos pendientes.

Ejemplos:

- reinicio del Runtime;
- rollback futuro;
- cierre del juego;
- limpieza de pruebas automatizadas.

Mientras permanezcan en la Queue representan únicamente notificaciones pendientes.

---

# Limpieza

Una vez finalizado el despacho:

```text
Dispatch Complete

↓

Clear Queue

↓

Reuse Memory
```

La Queue debe quedar vacía antes del siguiente ciclo.

---

# Reutilización de Memoria

La implementación debe evitar crear y destruir estructuras constantemente.

Siempre que sea posible:

```text
Allocate Once

↓

Fill

↓

Dispatch

↓

Clear

↓

Reuse
```

Esto reduce la presión sobre el recolector de basura.

---

# Tamaño de la Cola

El Framework no debe imponer un límite fijo al número de eventos.

No obstante, el Profiler podrá registrar:

- tamaño máximo;
- tamaño medio;
- eventos por Frame;
- crecimiento anómalo.

Estas métricas ayudan a detectar problemas de diseño.

---

# Integridad

Durante toda su existencia un evento debe cumplir:

- tipo válido;
- datos completos;
- estado coherente;
- propietario exclusivo de la Queue.

---

# Restricciones

La Event Queue nunca debe:

- ejecutar lógica;
- invocar Systems;
- modificar Components;
- consultar Queries;
- acceder al SceneTree;
- interpretar el contenido del evento.

Su única responsabilidad consiste en almacenar eventos pendientes.

---

# Garantías

La Event Queue garantiza que:

- todos los eventos siguen el mismo ciclo de vida;
- el orden de inserción permanece estable;
- el despacho ocurre únicamente en puntos seguros del Pipeline;
- ningún evento puede procesarse dos veces;
- los eventos permanecen inmutables durante el despacho.

---

# Flujo Completo

Conceptualmente:

```text
System

↓

Create Event

↓

Queue

↓

Wait

↓

Scheduler Flush

↓

Dispatch

↓

Subscribers

↓

Remove Event

↓

Ready For Next Frame
```

Este flujo representa el ciclo de vida oficial de todos los eventos del Framework.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificada la arquitectura de la **Event Queue** y el **Event Lifecycle** del Framework ECS.

Todos los eventos generados por los Systems siguen un ciclo de vida uniforme, completamente desacoplado del momento de su emisión, garantizando un modelo de comunicación determinista, seguro y preparado para integrarse con el Scheduler, el Multiplayer y futuras optimizaciones del Runtime.
# 08 - EVENT BUS IMPLEMENTATION

# Parte 3 — Subscription Registry y Event Dispatching

---

# Objetivo

Esta sección define cómo el Event Bus administra las suscripciones de los Systems y cómo distribuye los eventos utilizando el Event Dispatcher.

El objetivo es proporcionar un mecanismo de comunicación completamente desacoplado, donde los emisores no conozcan a los receptores y los receptores no conozcan a los emisores.

Toda la comunicación se realiza exclusivamente a través del Event Bus.

---

# Filosofía

Un evento no tiene destinatarios explícitos.

Un System no envía un evento a otro System.

Simplemente informa que ocurrió un hecho.

El Event Bus determina automáticamente qué Systems deben recibir esa información.

---

# Arquitectura

El proceso completo puede representarse de la siguiente forma.

```text
Emit Event

↓

Event Queue

↓

Scheduler Flush

↓

Event Dispatcher

↓

Subscription Registry

↓

Subscribers

↓

Invoke
```

Cada módulo posee una responsabilidad claramente definida.

---

# Subscription Registry

## Responsabilidad

El Subscription Registry mantiene todas las relaciones entre:

- tipos de eventos;
- Systems suscriptos;
- manejadores registrados.

No almacena eventos.

No ejecuta lógica.

No realiza el despacho.

---

# Organización

Conceptualmente:

```text
Event Type

↓

Subscribers
```

Ejemplo:

```text
DamageEvent

↓

CombatSystem

↓

UISystem

↓

AudioSystem
```

---

# Registro

Durante la inicialización del Runtime:

```text
System

↓

Register Subscription

↓

Subscription Registry
```

Las suscripciones quedan disponibles antes del primer Frame.

---

# Cancelación

Cuando un System finaliza su ciclo de vida:

```text
Dispose

↓

Remove Subscription
```

El Registry elimina todas sus referencias.

---

# Ciclo de Vida de una Suscripción

```text
Created

↓

Registered

↓

Active

↓

Removed
```

No existen estados intermedios.

---

# Registro Único

Una misma suscripción no debe registrarse más de una vez.

El Registry debe detectar duplicados.

Ejemplo inválido:

```text
Combat System

↓

DamageEvent

↓

DamageEvent
```

---

# Suscripciones Independientes

Un mismo System puede suscribirse a múltiples eventos.

Ejemplo:

```text
Combat System

↓

Damage Event

Health Event

Death Event

Critical Hit Event
```

Cada suscripción se administra de forma independiente.

---

# Múltiples Suscriptores

Un mismo evento puede tener múltiples receptores.

Ejemplo:

```text
Inventory Changed

↓

Inventory UI

↓

Craft System

↓

Quest System

↓

Statistics System
```

El emisor desconoce esta información.

---

# Event Dispatcher

## Responsabilidad

Distribuir un evento a todos los suscriptores registrados.

No modifica el evento.

No interpreta su contenido.

No altera las suscripciones.

---

# Flujo del Dispatcher

Conceptualmente:

```text
Event

↓

Find Subscribers

↓

Invoke

↓

Finished
```

---

# Orden del Despacho

El Dispatcher debe mantener un orden determinista.

Todos los Frames equivalentes deben invocar los manejadores en el mismo orden.

---

# Orden Estable

Si varios Systems están suscriptos al mismo evento:

```text
System A

System B

System C
```

El orden de ejecución debe permanecer constante.

Nunca debe depender de:

- memoria;
- hardware;
- orden de registro accidental.

---

# Política de Orden

La implementación puede utilizar:

- orden de registro;
- prioridad de System;
- orden calculado por el Scheduler.

La política elegida debe mantenerse constante durante todo el Runtime.

---

# Invocación

Para cada suscriptor:

```text
Event

↓

Handler

↓

Return
```

El Dispatcher continúa con el siguiente receptor únicamente cuando finaliza la invocación anterior.

---

# Independencia

Cada suscriptor procesa el evento de forma completamente independiente.

Un System nunca debe modificar el flujo del Dispatcher.

---

# Errores

Si un suscriptor produce un error:

```text
Handler

↓

Exception

↓

Dispatcher

↓

Continue
```

La política exacta pertenece al Runtime.

Siempre que sea posible, un fallo aislado no debe impedir que el resto de los suscriptores reciban el evento.

---

# Emisión de Nuevos Eventos

Durante el procesamiento de un evento:

```text
Handler

↓

Emit Event

↓

Queue
```

El nuevo evento nunca debe despacharse inmediatamente.

Debe incorporarse a la Event Queue.

---

# Reentrada

El Dispatcher nunca debe entrar nuevamente en sí mismo.

Ejemplo inválido:

```text
Dispatch

↓

Emit

↓

Dispatch

↓

Emit
```

Todo nuevo evento espera el siguiente ciclo de despacho.

---

# Modificación de Suscripciones

Mientras el Dispatcher procesa un evento:

- no deben agregarse suscripciones activas;
- no deben eliminarse suscripciones activas.

Las modificaciones se aplican posteriormente mediante un mecanismo seguro.

---

# Snapshot de Suscriptores

Antes de comenzar el despacho, el Dispatcher puede trabajar sobre una instantánea de las suscripciones.

Conceptualmente:

```text
Subscription Registry

↓

Snapshot

↓

Dispatch
```

Esto evita inconsistencias si posteriormente cambian las suscripciones.

---

# Eventos Sin Suscriptores

Puede ocurrir que un evento no tenga receptores.

Ejemplo:

```text
Event

↓

No Subscribers

↓

Complete
```

Esto no representa un error.

---

# Eventos Masivos

El Dispatcher debe ser capaz de procesar grandes cantidades de eventos consecutivos.

Ejemplo conceptual:

```text
1000 Events

↓

Dispatcher

↓

Subscribers

↓

Complete
```

La arquitectura no debe asumir un volumen reducido.

---

# Compatibilidad con el Scheduler

El Dispatcher nunca inicia el despacho por iniciativa propia.

Siempre responde a una solicitud del Scheduler.

Conceptualmente:

```text
Scheduler

↓

Flush Events

↓

Dispatcher
```

---

# Compatibilidad con Multiplayer

En un entorno Server Authoritative:

```text
Simulation

↓

Events

↓

Dispatcher

↓

Replication
```

El despacho ocurre antes de la generación de información destinada a los clientes.

---

# Restricciones

El Dispatcher nunca debe:

- modificar Registries;
- crear entidades;
- eliminar entidades;
- ejecutar Queries;
- interpretar gameplay;
- acceder al SceneTree.

Su única responsabilidad consiste en distribuir eventos.

---

# Garantías

El Subscription Registry garantiza que:

- todas las suscripciones permanecen organizadas;
- no existen duplicados;
- los registros pueden añadirse y eliminarse de forma segura.

El Event Dispatcher garantiza que:

- todos los eventos llegan a sus receptores válidos;
- el orden de despacho es determinista;
- los nuevos eventos nunca provocan reentrada;
- el fallo de un suscriptor no compromete necesariamente el resto del despacho.

---

# Flujo Completo

Conceptualmente:

```text
Event

↓

Queue

↓

Scheduler Flush

↓

Dispatcher

↓

Lookup Subscribers

↓

Invoke Handlers

↓

Complete

↓

Next Event
```

Este proceso se repite para todos los eventos pendientes del Frame.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificada la implementación del **Subscription Registry** y del **Event Dispatcher**.

El Framework dispone ahora de un mecanismo de distribución de eventos completamente desacoplado, capaz de administrar múltiples suscriptores por evento, mantener un orden determinista de despacho y garantizar que la comunicación entre Systems se realice sin dependencias directas y de forma segura durante toda la ejecución del Runtime.
# 08 - EVENT BUS IMPLEMENTATION

# Parte 4 — Integración con el Scheduler, Systems, Queries, Save y Multiplayer

---

# Objetivo

Esta sección define cómo el Event Bus se integra con el resto del Framework ECS.

El Event Bus no funciona como un sistema aislado.

Forma parte del Runtime y debe coordinarse con:

- Scheduler
- Systems
- Entity Registry
- Component Registry
- Query Engine
- Save Pipeline
- Multiplayer Pipeline
- Debug Tools

La integración debe mantener el desacoplamiento entre todos los subsistemas.

---

# Filosofía

El Event Bus constituye un mecanismo de comunicación.

No reemplaza:

- Queries.
- Commands.
- Registries.
- Save.
- Networking.

Cada subsistema conserva una responsabilidad única.

El Event Bus únicamente comunica hechos ocurridos dentro del Runtime.

---

# Integración con el Scheduler

El Scheduler posee el control absoluto sobre el momento en que los eventos son despachados.

El Event Bus nunca ejecuta eventos por iniciativa propia.

Conceptualmente:

```text
Systems

↓

Emit Events

↓

Event Queue

↓

Scheduler Barrier

↓

Dispatch Events

↓

Continue Frame
```

---

# Sincronización

El Scheduler garantiza que:

- todos los Systems finalizaron;
- todas las operaciones diferidas fueron aplicadas;
- el mundo es consistente.

Recién entonces el Event Bus comienza el despacho.

---

# Orden Oficial

La secuencia oficial del Runtime es:

```text
Execute Systems

↓

Flush Commands

↓

Update Registries

↓

Flush Events

↓

Next Frame
```

Este orden nunca debe alterarse.

---

# Integración con los Systems

Los Systems interactúan con el Event Bus mediante una interfaz pública.

Las únicas operaciones permitidas son:

- Emitir eventos.
- Registrar suscripciones.
- Cancelar suscripciones.

Ningún System debe acceder a módulos internos del Event Bus.

---

# Emisión

Cuando un System detecta un cambio relevante:

```text
Gameplay Logic

↓

Create Event

↓

EventBus.Emit()
```

La operación finaliza inmediatamente.

El evento permanece pendiente hasta el siguiente Flush.

---

# Recepción

Cuando un evento es despachado:

```text
Dispatcher

↓

Handler

↓

System
```

El System recibe una copia lógica del evento para procesarlo.

No obtiene acceso a la Event Queue.

---

# Comunicación entre Systems

El siguiente flujo representa el modelo oficial:

```text
Movement System

↓

Emit Event

↓

Event Bus

↓

Combat System
```

En ningún momento existe una referencia directa entre ambos Systems.

---

# Integración con Entity Registry

Los eventos nunca modifican directamente el Entity Registry.

Si un evento requiere cambios estructurales:

```text
Event

↓

System

↓

Command Buffer

↓

Scheduler Barrier

↓

Registry
```

Toda modificación continúa realizándose mediante Commands.

---

# Integración con Component Registry

Los manejadores de eventos pueden modificar datos contenidos en Components.

Sin embargo:

- no deben realizar cambios estructurales inmediatos;
- las operaciones estructurales siempre utilizan el Command Buffer.

---

# Integración con Queries

Las Queries y los Events cumplen funciones diferentes.

## Query

Solicita información.

```text
System

↓

Query

↓

Result
```

---

## Event

Notifica un hecho.

```text
System

↓

Event

↓

Subscribers
```

---

# Uso Combinado

Es habitual que un System combine ambos mecanismos.

Ejemplo conceptual:

```text
Receive Event

↓

Execute Query

↓

Apply Gameplay Logic
```

El Event Bus permanece completamente independiente del Query Engine.

---

# Integración con Save

El Event Bus no forma parte de la información persistente del mundo.

No deben serializarse:

- Event Queue;
- Event History;
- eventos pendientes.

Todos estos elementos representan estado temporal del Runtime.

---

# Momento Seguro para Guardar

El Scheduler determina cuándo el mundo es consistente.

Conceptualmente:

```text
Flush Commands

↓

Flush Events

↓

Save
```

De esta forma no existen eventos pendientes durante el guardado.

---

# Restauración

Después de cargar una partida:

```text
Load Save

↓

Restore World

↓

Empty Event Queue

↓

Continue Runtime
```

La cola comienza siempre vacía.

---

# Integración con Multiplayer

En un modelo Server Authoritative:

```text
Server Simulation

↓

Events

↓

Dispatcher

↓

Replication

↓

Clients
```

El Event Bus continúa siendo una infraestructura interna del servidor.

---

# Eventos Locales

La mayoría de los eventos nunca abandonan el servidor.

Ejemplos:

- limpieza interna;
- mantenimiento;
- sincronización local;
- estadísticas.

Estos eventos no requieren replicación.

---

# Eventos Replicables

Algunos eventos pueden utilizarse como disparadores para la generación de mensajes de red.

Ejemplo conceptual:

```text
Health Changed Event

↓

Replication System

↓

Network Packet
```

El propio Event Bus nunca construye paquetes de red.

---

# Integración con Debug

Las herramientas de Debug pueden consultar:

- tamaño de la cola;
- eventos pendientes;
- eventos procesados;
- suscriptores registrados;
- historial de eventos.

Toda esta información es de solo lectura.

---

# Integración con Profiling

El Profiler obtiene información del Event Bus.

Ejemplos:

- eventos emitidos;
- eventos despachados;
- tiempo medio de despacho;
- tamaño máximo de la cola;
- Systems que generan mayor cantidad de eventos.

---

# Integración con Testing

Las pruebas automatizadas pueden:

- emitir eventos;
- registrar Systems simulados;
- validar el orden del despacho;
- verificar suscripciones.

Todo ello utilizando únicamente interfaces públicas.

---

# Dependencias Permitidas

El Event Bus puede depender de:

- IECSContext;
- Scheduler;
- interfaces internas del Runtime.

No debe depender de:

- gameplay;
- escenas;
- UI;
- Components específicos;
- Nodes del SceneTree.

---

# Restricciones

El Event Bus nunca debe:

- ejecutar Queries;
- crear entidades;
- destruir entidades;
- modificar Registries;
- serializar información;
- construir paquetes de red;
- contener lógica de gameplay.

Debe limitarse estrictamente a coordinar la comunicación basada en eventos.

---

# Garantías

La integración del Event Bus garantiza que:

- todos los Systems permanecen desacoplados;
- el Scheduler conserva el control del Pipeline;
- los Registries únicamente cambian mediante Commands;
- Save captura un estado consistente del mundo;
- Multiplayer puede utilizar los eventos como origen de la replicación sin acoplar la infraestructura de red al Event Bus.

---

# Flujo Completo

Conceptualmente:

```text
System

↓

Emit Event

↓

Event Queue

↓

Scheduler Flush

↓

Dispatcher

↓

Subscribers

↓

Gameplay Logic

↓

Optional Commands

↓

Next Frame
```

Este flujo representa la integración oficial del Event Bus con el resto del Framework ECS.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificada la integración del **Event Bus** con el Scheduler, los Systems, los Registries, el Query Engine, el Save Pipeline y el Multiplayer Pipeline.

El Event Bus permanece como una infraestructura de comunicación completamente desacoplada, mientras que cada subsistema conserva su responsabilidad exclusiva dentro del Runtime, manteniendo un diseño modular, determinista y preparado para futuras ampliaciones del Framework.
# 08 - EVENT BUS IMPLEMENTATION

# Parte 5 — Performance, Validaciones, Debug y Profiling

---

# Objetivo

Esta sección define todas las consideraciones relacionadas con el rendimiento, la validación, la instrumentación y las herramientas de depuración del Event Bus.

El objetivo es garantizar que el Event Bus pueda procesar grandes volúmenes de eventos manteniendo un comportamiento:

- determinista;
- eficiente;
- escalable;
- fácilmente diagnosticable.

---

# Filosofía

El Event Bus será utilizado continuamente por prácticamente todos los Systems del Runtime.

Por este motivo debe diseñarse bajo las siguientes premisas:

- minimizar asignaciones de memoria;
- minimizar búsquedas;
- minimizar trabajo repetitivo;
- reutilizar estructuras internas;
- mantener bajo coste incluso con miles de eventos.

---

# Objetivos de Rendimiento

La implementación debe optimizar especialmente:

- inserción de eventos;
- búsqueda de suscriptores;
- despacho;
- limpieza de la cola;
- reutilización de memoria.

---

# Event Queue

La Event Queue debe comportarse como una estructura de escritura rápida.

Las operaciones más frecuentes serán:

```text
Push

↓

Push

↓

Push

↓

Flush

↓

Clear
```

La inserción debe tener un coste constante siempre que sea posible.

---

# Subscription Registry

Las búsquedas de suscriptores deben ser extremadamente rápidas.

El Dispatcher consulta este Registry para cada evento.

Por lo tanto:

- debe minimizar recorridos;
- debe evitar búsquedas lineales innecesarias;
- debe mantener estructuras optimizadas para acceso frecuente.

---

# Reutilización de Memoria

Siempre que sea posible deberán reutilizarse:

- buffers;
- listas temporales;
- estructuras auxiliares;
- colecciones internas.

Debe evitarse la creación constante de objetos durante cada Frame.

---

# Garbage Collection

El Event Bus no debe generar presión innecesaria sobre el recolector de basura.

Se recomienda:

- reutilizar Arrays;
- limpiar colecciones existentes;
- reservar capacidad cuando resulte apropiado.

---

# Eventos Temporales

Los eventos poseen un ciclo de vida corto.

Una vez finalizado el despacho:

```text
Dispatch

↓

Remove

↓

Reuse Memory
```

No deben permanecer referencias innecesarias.

---

# Búsquedas

Durante el despacho:

```text
Event

↓

Subscribers

↓

Invoke
```

La búsqueda de los suscriptores debe realizarse utilizando estructuras preparadas previamente durante la inicialización.

Nunca debe reconstruirse esta información para cada evento.

---

# Validaciones

El Event Bus debe validar tanto su configuración como la información recibida.

Las validaciones se dividen en:

- inicialización;
- registro;
- ejecución;
- depuración.

---

# Validaciones de Inicialización

Durante el Bootstrap deben comprobarse:

- Event Bus inicializado;
- módulos internos creados;
- Subscription Registry disponible;
- Queue disponible.

---

# Validaciones de Registro

Al registrar una suscripción debe verificarse:

- tipo de evento válido;
- System válido;
- ausencia de duplicados;
- Handler existente.

---

# Validaciones de Emisión

Cuando un System emite un evento deben comprobarse, como mínimo:

- tipo válido;
- evento correctamente construido;
- Runtime activo.

---

# Validaciones Durante el Despacho

Antes de invocar un Handler deben verificarse:

- suscriptor existente;
- System activo;
- Handler disponible.

---

# Errores

El Event Bus debe detectar situaciones como:

- tipos de eventos desconocidos;
- suscripciones inválidas;
- referencias eliminadas;
- registros duplicados;
- eventos mal construidos.

---

# Comportamiento ante Errores

Cuando una validación crítica falle:

```text
Validation

↓

Failure

↓

Log

↓

Continue Policy
```

La política concreta pertenece al Runtime.

Siempre que sea posible, un error aislado no debe comprometer el resto del despacho.

---

# Logging

El Logging debe limitarse a:

- errores;
- advertencias importantes;
- configuraciones inválidas.

No debe registrarse información durante cada evento en ejecución normal.

---

# Debug Mode

En modo Debug podrán habilitarse validaciones adicionales.

Ejemplos:

- comprobación de duplicados;
- consistencia de la Queue;
- estados del Dispatcher;
- integridad del Registry.

Estas comprobaciones pueden omitirse en Release.

---

# Event Profiler

El Event Profiler recopila información estadística sobre el funcionamiento del Event Bus.

No modifica el comportamiento del Runtime.

---

# Métricas Generales

Como mínimo deberán registrarse:

- eventos emitidos;
- eventos despachados;
- eventos descartados;
- eventos pendientes;
- tamaño máximo de la Queue;
- tamaño medio de la Queue.

---

# Métricas por Tipo

Opcionalmente pueden recopilarse:

```text
DamageEvent

↓

1250
```

```text
InventoryChanged

↓

480
```

```text
CraftCompleted

↓

90
```

Esto permite identificar eventos excesivamente frecuentes.

---

# Métricas por System

También resulta útil registrar:

- eventos emitidos por System;
- eventos recibidos por System;
- tiempo consumido por Handler.

Estas estadísticas facilitan la optimización del Runtime.

---

# Tiempo de Despacho

El Profiler debe poder medir:

```text
Dispatch Begin

↓

Dispatch

↓

Dispatch End
```

Esto permite detectar cuellos de botella.

---

# Historial

En modo Debug puede mantenerse un historial temporal.

Ejemplo:

```text
Frame 150

↓

Events

↓

Dispatch Time
```

Esta información resulta especialmente útil durante el desarrollo.

---

# Event History

El historial puede almacenar:

- tipo de evento;
- Frame;
- momento del despacho;
- número de suscriptores;
- duración del procesamiento.

Este módulo puede deshabilitarse completamente en Release.

---

# Herramientas de Debug

Las herramientas del Framework deben poder consultar:

- Event Queue;
- Subscription Registry;
- Dispatcher;
- estadísticas;
- historial.

Toda la información expuesta debe ser de solo lectura.

---

# Panel de Diagnóstico

Un panel de Debug podría mostrar conceptualmente:

```text
Current Queue

↓

Pending Events

↓

Subscribers

↓

Dispatch Order

↓

Profiler
```

Esto facilita enormemente la inspección del Runtime.

---

# Escalabilidad

La implementación debe ser capaz de soportar:

- miles de eventos por Frame;
- cientos de tipos de eventos;
- cientos de suscriptores;
- crecimiento futuro del proyecto.

Sin modificar la arquitectura del Event Bus.

---

# Restricciones

El Event Bus nunca debe sacrificar:

- determinismo;
- orden de despacho;
- desacoplamiento;

a cambio de optimizaciones de rendimiento.

Toda optimización debe preservar el comportamiento funcional.

---

# Garantías

El Event Bus garantiza que:

- las validaciones detectan configuraciones inválidas;
- el rendimiento puede medirse objetivamente;
- las herramientas de Debug disponen de información suficiente;
- la infraestructura puede escalar manteniendo un comportamiento consistente;
- la instrumentación puede deshabilitarse sin afectar la lógica del Runtime.

---

# Resultado Esperado

Al finalizar esta sección quedan completamente especificadas las consideraciones de **Performance**, **Validación**, **Debug** y **Profiling** del Event Bus.

La infraestructura queda preparada para operar con grandes volúmenes de eventos, proporcionando mecanismos sólidos de diagnóstico y optimización sin comprometer el desacoplamiento ni el determinismo del Framework ECS.
# 08 - EVENT BUS IMPLEMENTATION

# Parte 6 — Testing, Evolución Futura, Restricciones y Resumen Arquitectónico

---

# Objetivo

Esta sección define las consideraciones finales para la implementación del Event Bus, incluyendo su estrategia de testing, posibilidades de evolución futura, restricciones arquitectónicas y el resumen de su integración dentro del Framework ECS.

El objetivo es asegurar que el Event Bus permanezca estable, desacoplado y mantenible a medida que el proyecto evolucione.

---

# Filosofía

El Event Bus constituye una pieza fundamental de la infraestructura del Runtime.

Su comportamiento debe poder verificarse mediante pruebas automatizadas.

Su arquitectura debe permitir incorporar nuevas capacidades sin romper la compatibilidad con los Systems existentes.

---

# Compatibilidad con Testing

Toda implementación debe poder probarse de forma aislada.

Las pruebas nunca deben depender de:

- escenas;
- nodos del SceneTree;
- gameplay;
- interfaz gráfica;
- recursos del proyecto.

Únicamente deben utilizar las interfaces públicas del Framework.

---

# Objetivos del Testing

Las pruebas deben verificar:

- funcionamiento correcto;
- determinismo;
- rendimiento básico;
- estabilidad;
- integración con el Scheduler.

---

# Escenarios de Prueba

Como mínimo deberán contemplarse los siguientes casos.

---

# Inicialización

Verificar:

- creación del Event Bus;
- creación de todos los módulos internos;
- estado Ready;
- Queue vacía;
- Registry vacío.

---

# Registro de Suscripciones

Registrar múltiples Systems.

Verificar:

- almacenamiento correcto;
- ausencia de duplicados;
- recuperación de suscriptores.

---

# Cancelación de Suscripciones

Registrar y eliminar suscripciones.

Verificar:

- eliminación correcta;
- ausencia de referencias huérfanas;
- consistencia del Registry.

---

# Emisión de Eventos

Emitir múltiples eventos.

Verificar:

- inserción en la Queue;
- orden FIFO;
- tamaño esperado.

---

# Despacho

Emitir varios eventos con múltiples suscriptores.

Verificar:

- orden correcto;
- invocación única;
- finalización correcta.

---

# Eventos Sin Suscriptores

Emitir eventos sin receptores.

Verificar:

- ausencia de errores;
- eliminación correcta de la Queue.

---

# Emisión Durante el Despacho

Emitir nuevos eventos desde un Handler.

Verificar:

- incorporación a la Queue;
- ausencia de reentrada;
- procesamiento en el siguiente ciclo.

---

# Integración con Scheduler

Simular un Frame completo.

Verificar:

- emisión;
- almacenamiento;
- Flush;
- despacho;
- limpieza.

---

# Pruebas de Rendimiento

Generar grandes volúmenes de eventos.

Ejemplos:

```text
10 000 Events

↓

Dispatch

↓

Measure
```

Verificar:

- tiempo de despacho;
- consumo de memoria;
- estabilidad.

---

# Pruebas de Errores

Simular:

- suscripciones inválidas;
- tipos inexistentes;
- referencias eliminadas;
- eventos corruptos.

Verificar que el Runtime mantiene un estado consistente.

---

# Evolución del Framework

La arquitectura debe permitir incorporar nuevas capacidades sin modificar las interfaces públicas del Event Bus.

Entre ellas:

- prioridades de eventos;
- filtros de suscripción;
- canales de eventos;
- eventos persistentes;
- eventos retrasados;
- eventos programados;
- eventos distribuidos.

---

# Priorización

Una futura implementación puede permitir:

```text
Critical

↓

High

↓

Normal

↓

Low
```

La Queue deberá soportarlo sin romper el modelo actual.

---

# Filtros

Podrán incorporarse filtros para reducir el número de eventos entregados a cada suscriptor.

Ejemplo conceptual:

```text
DamageEvent

↓

Only Critical Damage
```

El Dispatcher continuará siendo independiente del contenido del evento.

---

# Canales

La arquitectura también permite introducir canales.

Ejemplo:

```text
Gameplay

UI

Audio

Networking

Debug
```

Los canales facilitan la organización sin modificar la filosofía Event Driven.

---

# Eventos Programados

Futuras versiones podrán permitir:

```text
Create Event

↓

Delay

↓

Future Dispatch
```

El Scheduler continuará controlando el momento del despacho.

---

# Replay

El historial de eventos puede utilizarse como apoyo para herramientas de Replay.

Siempre que se combine con:

- Commands;
- Save;
- Scheduler.

---

# Rollback

La separación entre emisión y despacho facilita futuras estrategias de rollback.

No obstante, la implementación concreta pertenece al Multiplayer Pipeline.

---

# Restricciones

El Event Bus nunca debe:

- contener lógica de gameplay;
- modificar Registries;
- ejecutar Queries;
- conocer Components específicos;
- acceder al SceneTree;
- crear dependencias directas entre Systems;
- almacenar estado persistente del mundo.

Debe permanecer como una infraestructura de comunicación.

---

# Buenas Prácticas

Todo System debería:

- emitir únicamente los eventos necesarios;
- evitar eventos redundantes;
- utilizar tipos de eventos claramente definidos;
- mantener Handlers pequeños y especializados;
- minimizar el trabajo realizado durante el despacho.

---

# Antipatrones

Las siguientes prácticas deben evitarse.

---

## Eventos como Commands

No utilizar eventos para solicitar acciones.

Incorrecto:

```text
Move Player Event
```

Correcto:

```text
Player Moved Event
```

Los eventos representan hechos consumados.

---

## Eventos Gigantes

No crear eventos con grandes cantidades de información innecesaria.

Cada evento debe contener únicamente los datos relevantes para sus suscriptores.

---

## Dependencias Implícitas

Un System nunca debe asumir que otro System reaccionará a un evento determinado.

La arquitectura debe seguir funcionando incluso si no existe ningún suscriptor.

---

## Cascadas Incontroladas

Evitar secuencias excesivas del tipo:

```text
Event

↓

Event

↓

Event

↓

Event
```

Aunque el modelo diferido elimina la recursividad inmediata, una cascada excesiva puede afectar el rendimiento.

---

## Uso Excesivo

No todo cambio del mundo requiere un evento.

Los eventos deben utilizarse únicamente cuando sea necesario comunicar información a otros Systems.

---

# Resumen Arquitectónico

El Event Bus está compuesto por los siguientes módulos especializados:

- Event Bus
- Event Queue
- Event Dispatcher
- Subscription Registry
- Event Validator
- Event Profiler
- Event History

Cada módulo mantiene una única responsabilidad.

---

# Flujo General

El funcionamiento completo puede resumirse conceptualmente como:

```text
System

↓

Emit Event

↓

Event Queue

↓

Scheduler Flush

↓

Dispatcher

↓

Lookup Subscribers

↓

Invoke Handlers

↓

Complete

↓

Clear Queue

↓

Next Frame
```

Este flujo representa el comportamiento oficial del Framework.

---

# Relación con el Query Engine

El siguiente documento de esta fase será:

`09_QUERY_ENGINE_IMPLEMENTATION.md`

Mientras el Event Bus implementa comunicación basada en notificaciones, el Query Engine implementará comunicación basada en solicitudes de información.

Ambos mecanismos son complementarios y constituyen los dos pilares principales de comunicación entre Systems dentro del Framework ECS.

---

# Resultado Esperado

Con este documento queda completamente especificada la implementación del **Event Bus** del Framework ECS de Survivors Lords.

La arquitectura propuesta establece un sistema de comunicación desacoplado, determinista y escalable, compuesto por módulos especializados para la gestión de eventos, suscripciones, despacho, validación, profiling y depuración, integrándose de forma consistente con el Scheduler y el resto del Runtime, y proporcionando una base sólida para soportar la evolución futura del Framework sin comprometer sus principios arquitectónicos.

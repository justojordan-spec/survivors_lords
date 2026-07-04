# EVENT BUS

**Documento:** 05_EVENT_BUS.md

**Fase:** ECS Framework

**Estado:** Draft

**Versión:** 1.0

---

# Objetivo

Este documento define la arquitectura completa del Event Bus utilizado por el Framework ECS de Survivors Lords.

Su objetivo es establecer el mecanismo oficial mediante el cual los distintos Systems del Framework intercambian información sin depender directamente unos de otros.

El Event Bus constituye el principal mecanismo de comunicación del Framework y es uno de los pilares de la arquitectura Event Driven.

Este documento no describe eventos específicos de gameplay.

Define únicamente la infraestructura encargada de transportar dichos eventos.

---

# Alcance

Este documento especifica:

- Arquitectura del Event Bus.
- Event Queue.
- Publicación de Events.
- Suscripción de Systems.
- Ciclo de vida de un Event.
- Dispatch.
- Prioridades.
- Orden de procesamiento.
- Integración con ECS.
- Integración con Scheduler.
- Integración con Save.
- Integración con Multiplayer.
- Rendimiento.
- Debug.
- Profiling.

No define:

- Eventos específicos del juego.
- Componentes.
- Systems.
- Gameplay.
- Resources.

---

# Filosofía

El Framework adopta una arquitectura Event Driven.

Los Systems nunca deben comunicarse directamente entre sí.

En su lugar, toda comunicación se realiza mediante Events publicados en el Event Bus.

Este enfoque proporciona:

- Bajo acoplamiento.
- Alta escalabilidad.
- Mayor mantenibilidad.
- Mejor capacidad de pruebas.
- Mejor extensibilidad.

---

# Objetivos del Event Bus

El Event Bus debe garantizar:

- Comunicación desacoplada.
- Orden determinista.
- Procesamiento consistente.
- Compatibilidad con Multiplayer.
- Compatibilidad con Replay.
- Compatibilidad con Save.
- Alto rendimiento.
- Baja asignación de memoria.
- Fácil depuración.

---

# Arquitectura General

Conceptualmente.

```text
System

↓

Publish Event

↓

Event Bus

↓

Event Queue

↓

Dispatch

↓

Subscribers

↓

Systems
```

Ningún System conoce quién recibirá un Event.

---

# ¿Qué es un Event?

Un Event representa un hecho ocurrido dentro del mundo.

Describe algo que ya sucedió.

Nunca representa una orden.

Ejemplos conceptuales:

- EntityCreated
- DamageApplied
- ItemCrafted
- QuestCompleted
- BuildingDestroyed

---

# Características

Todo Event debe cumplir las siguientes reglas.

- Es inmutable.
- Contiene únicamente datos.
- No ejecuta lógica.
- No conoce Subscribers.
- No conoce Publishers.
- No modifica Systems.

Una vez creado, su contenido nunca cambia.

---

# Filosofía de los Events

Un Event responde siempre a la pregunta:

> ¿Qué ocurrió?

Nunca responde a:

> ¿Qué debe hacerse?

Esta diferencia evita acoplamiento innecesario entre Systems.

---

# Eventos vs Commands

Es importante distinguir ambos conceptos.

## Event

Representa un hecho ocurrido.

```text
PlayerDied
```

---

## Command

Representa una solicitud de acción.

```text
KillPlayer
```

Los Commands pertenecen al Scheduler.

Los Events pertenecen al Event Bus.

---

# Arquitectura del Event Bus

El Event Bus constituye un servicio central del Framework.

Conceptualmente.

```text
Event Bus

├── Queue
├── Subscribers
├── Dispatcher
└── Metrics
```

Cada módulo posee responsabilidades claramente definidas.

---

# Responsabilidades

El Event Bus es responsable de:

- Recibir Events.
- Almacenarlos temporalmente.
- Ordenarlos.
- Distribuirlos.
- Gestionar Subscribers.
- Registrar estadísticas.
- Detectar errores.
- Mantener determinismo.

Nunca ejecuta lógica de gameplay.

---

# Publicadores (Publishers)

Cualquier System puede publicar Events.

Ejemplo conceptual.

```text
Combat System

↓

DamageApplied
```

El System desconoce completamente quién recibirá dicho Event.

---

# Suscriptores (Subscribers)

Un Subscriber representa un System interesado en un tipo específico de Event.

Ejemplo.

```text
Quest System

↓

EnemyKilled
```

El Quest System será notificado únicamente cuando ese Event sea despachado.

---

# Registro de Suscriptores

Durante la inicialización, cada System registra los Events que desea recibir.

Conceptualmente.

```text
Quest System

↓

Subscribe

↓

EnemyKilled
```

Este registro ocurre una única vez durante el Startup.

---

# Event Queue

Los Events publicados no son procesados inmediatamente.

Se almacenan temporalmente dentro de la Event Queue.

Conceptualmente.

```text
Event Queue

DamageApplied

EnemyKilled

ItemCrafted

QuestCompleted
```

---

# Objetivo de la Queue

La Queue permite:

- Mantener orden.
- Evitar recursión.
- Reducir acoplamiento.
- Facilitar paralelización.
- Garantizar consistencia.

---

# Ciclo de Vida de un Event

Todo Event sigue exactamente el mismo ciclo.

```text
Create

↓

Publish

↓

Queue

↓

Dispatch

↓

Consume

↓

Dispose
```

Ningún Event puede saltarse etapas.

---

# Estado: Created

El Event acaba de ser construido.

Todavía no pertenece al Event Bus.

No posee Subscribers.

---

# Estado: Published

El Event fue enviado al Event Bus.

Ahora espera dentro de la Queue.

Todavía no fue procesado.

---

# Estado: Queued

El Event permanece almacenado esperando su turno.

Todos los Events conservan el orden definido por el Scheduler.

---

# Estado: Dispatching

El Dispatcher comienza a distribuir el Event.

Cada Subscriber registrado recibe una notificación.

El Event continúa siendo inmutable.

---

# Estado: Consumed

Todos los Subscribers terminaron de procesarlo.

El Event deja de participar en la ejecución del Frame.

---

# Estado: Disposed

El Framework libera el Event.

Puede:

- Reciclar memoria.
- Reutilizar Pools.
- Limpiar referencias temporales.

El Event deja de existir.

---

# Reglas Generales

Todo Event debe cumplir las siguientes reglas:

- Es inmutable.
- Tiene un único tipo.
- Posee un único ciclo de vida.
- Nunca modifica directamente el mundo.
- Nunca ejecuta Systems.
- Nunca genera Queries.

---

# Integración con ECS

Los Events forman parte del Framework ECS pero no pertenecen a ninguna Entity.

No poseen identidad.

No participan en Queries.

No almacenan Components.

Representan únicamente información temporal.

---

# Integración con Systems

Los Systems interactúan con el Event Bus mediante dos operaciones:

```text
Publish(Event)

Subscribe(EventType)
```

No existen otras formas oficiales de interacción.

---

# Beneficios Arquitectónicos

El uso del Event Bus permite:

- Eliminar dependencias directas entre Systems.
- Reducir el acoplamiento.
- Facilitar la reutilización.
- Mejorar la escalabilidad.
- Simplificar las pruebas unitarias.
- Centralizar la comunicación del Framework.

---

# Continúa en la Parte 2

La siguiente parte desarrollará:

- Dispatcher.
- Prioridades.
- Orden de procesamiento.
- Propagación.
- Event Filters.
- Immediate Events.
- Deferred Events.
- Event Channels.
- Integración con el Scheduler.
- Garantías de procesamiento.
---

# Event Dispatcher

El Event Dispatcher es el componente responsable de distribuir los Events publicados hacia todos los Subscribers registrados.

Su única responsabilidad consiste en coordinar la entrega de los Events.

Nunca ejecuta lógica de gameplay.

Nunca modifica Entities.

Nunca modifica Components.

---

# Responsabilidades

El Dispatcher debe garantizar:

- Orden determinista.
- Entrega consistente.
- Bajo acoplamiento.
- Alto rendimiento.
- Compatibilidad con Deferred Events.
- Compatibilidad con Multiplayer.
- Compatibilidad con Replay.

---

# Flujo General

Todo Event sigue el siguiente flujo.

```text
Publish

↓

Queue

↓

Dispatcher

↓

Subscribers

↓

Dispose
```

El Publisher nunca conoce este proceso interno.

---

# Orden de Procesamiento

Los Events se procesan siguiendo exactamente el orden en el que fueron aceptados por el Event Bus.

Ejemplo.

```text
Frame

↓

DamageApplied

↓

HealthChanged

↓

PlayerDied
```

El orden nunca debe modificarse durante el Dispatch.

---

# FIFO

La Event Queue utiliza una política FIFO (First In, First Out).

Conceptualmente.

```text
Publish A

↓

Publish B

↓

Publish C

↓

Dispatch A

↓

Dispatch B

↓

Dispatch C
```

Esta política garantiza determinismo.

---

# Prioridades

Aunque la Queue mantiene un orden FIFO, el Framework admite prioridades para determinadas categorías de Events.

Las prioridades nunca alteran el orden interno de Events pertenecientes a la misma categoría.

---

# Categorías de Prioridad

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

El Scheduler procesa completamente una prioridad antes de continuar con la siguiente.

---

# Objetivos de las Prioridades

Permiten:

- Procesar eventos críticos antes.
- Reducir latencia.
- Mantener determinismo.
- Evitar bloqueos innecesarios.

---

# Event Channels

El Event Bus puede organizar los Events mediante canales lógicos.

Ejemplo conceptual.

```text
Gameplay

Combat

UI

Networking

Debug

Audio
```

Los canales no representan distintas colas.

Únicamente clasifican los Events.

---

# Beneficios de los Channels

Permiten:

- Organización.
- Filtrado.
- Métricas.
- Depuración.
- Profiling.

No afectan la lógica del Framework.

---

# Event Filters

Los Subscribers pueden definir filtros adicionales.

Ejemplo conceptual.

```text
EnemyKilled

↓

Solo Bosses
```

El Dispatcher evalúa el filtro antes de entregar el Event.

---

# Objetivo de los Filtros

Reducen trabajo innecesario.

Evitan que un System procese información irrelevante.

Mejoran el rendimiento general.

---

# Propagación

Un mismo Event puede ser entregado a múltiples Subscribers.

Ejemplo.

```text
EnemyKilled

↓

Quest System

↓

Loot System

↓

Achievement System

↓

Statistics System
```

Todos reciben exactamente la misma instancia del Event.

---

# Inmutabilidad

Durante la propagación ningún Subscriber puede modificar el Event.

El Event constituye una estructura de solo lectura.

Esto garantiza que todos los Systems observen exactamente la misma información.

---

# Orden de los Subscribers

El Dispatcher mantiene un orden estable entre Subscribers.

Ejemplo.

```text
Quest

↓

Loot

↓

Achievements

↓

Analytics
```

Este orden se calcula durante la inicialización.

Nunca cambia durante la ejecución.

---

# Dependencias entre Subscribers

Si dos Systems requieren un orden específico:

```text
Loot

↓

Inventory
```

La dependencia debe resolverse mediante el Scheduler.

Nunca mediante el Event Bus.

---

# Immediate Events

Algunos Events requieren procesamiento inmediato.

Ejemplo conceptual.

```text
Fatal Error

↓

Immediate Dispatch
```

Estos casos deben ser excepcionales.

---

# Restricciones de Immediate Events

Los Immediate Events:

- No modifican el ECS.
- No ejecutan Deferred Commands.
- No alteran Queries.
- No interrumpen el Scheduler.

Su uso debe limitarse a necesidades muy específicas del Framework.

---

# Deferred Events

La mayoría de los Events pertenecen a esta categoría.

Flujo.

```text
Publish

↓

Queue

↓

Dispatch

↓

Subscribers
```

Este mecanismo constituye el comportamiento normal del Framework.

---

# Publicación Durante el Dispatch

Un Subscriber puede publicar nuevos Events.

Ejemplo.

```text
EnemyKilled

↓

Quest Updated

↓

Achievement Progress
```

Los nuevos Events nunca interrumpen el Dispatch actual.

Se agregan al final de la Queue.

---

# Procesamiento por Oleadas

Conceptualmente.

```text
Queue Inicial

↓

Dispatch

↓

Nuevos Events

↓

Nueva Oleada

↓

Dispatch
```

Cada oleada se procesa únicamente cuando la anterior ha finalizado.

---

# Prevención de Recursión

Esta estrategia evita situaciones como:

```text
A

↓

B

↓

C

↓

A
```

El Dispatcher nunca procesa inmediatamente un Event recién publicado.

Siempre espera la siguiente iteración.

---

# Cancelación

Los Events no pueden cancelarse.

Una vez publicados:

- Permanecen en la Queue.
- Son despachados.
- Llegan a todos los Subscribers válidos.

Esto mantiene un comportamiento determinista y predecible.

---

# Consumo

Consumir un Event no implica eliminarlo.

Todos los Subscribers registrados tienen derecho a recibirlo.

No existe el concepto de "Event Consumido Exclusivamente".

---

# Garantías

El Dispatcher garantiza que:

- Todo Event publicado será procesado.
- Ningún Subscriber recibirá el mismo Event dos veces.
- Todos los Subscribers observarán exactamente el mismo contenido.
- El orden de procesamiento será estable.
- La Queue permanecerá consistente durante todo el Frame.

---

# Integración con el Scheduler

El Scheduler decide cuándo se ejecuta el Dispatcher.

Conceptualmente.

```text
Simulation

↓

Flush Commands

↓

Dispatch Events

↓

Networking

↓

Cleanup
```

El Event Bus nunca decide por sí mismo cuándo comenzar el procesamiento.

---

# Continúa en la Parte 3

La siguiente parte desarrollará:

- Integración con Multiplayer.
- Replicación de Events.
- Integración con Save Pipeline.
- Compatibilidad con Replay.
- Pools de Events.
- Optimización de memoria.
- Rendimiento.
- Instrumentación.
- Métricas.
- Profiling.
---

# Integración con Multiplayer

El Event Bus forma parte del Framework local de ejecución.

Los Events **no son sincronizados automáticamente** entre cliente y servidor.

El modelo Server Authoritative establece que únicamente se sincroniza el **estado del mundo**, no el flujo interno de Events.

Esto garantiza:

- Menor tráfico de red.
- Mayor estabilidad.
- Reproducibilidad.
- Desacoplamiento entre la simulación y la capa de transporte.

---

# Filosofía

Un Event representa un hecho ocurrido dentro de una instancia del juego.

No representa un mensaje de red.

Por esta razón, el Multiplayer Pipeline nunca replica directamente el Event Bus.

---

# Flujo Correcto

```text
Servidor

↓

Modificar Components

↓

Replicar Estado

↓

Cliente

↓

Actualizar Components

↓

Cliente genera sus propios Events internos
```

Los clientes reconstruyen el estado y, cuando corresponde, generan los Events derivados localmente.

---

# Ejemplo

El servidor aplica daño.

```text
Combat System

↓

HealthComponent = 25
```

El Multiplayer sincroniza:

```text
HealthComponent
```

Cuando el cliente recibe el nuevo estado:

```text
HealthComponent

↓

HealthChanged Event
```

El Event se genera localmente.

Nunca viaja por la red.

---

# Beneficios

Este enfoque:

- Reduce ancho de banda.
- Evita duplicación de información.
- Mantiene independencia entre red y Framework.
- Facilita Replay.
- Simplifica Debug.

---

# Eventos Replicables

Existen situaciones excepcionales donde un evento representa una decisión autoritativa.

Ejemplos:

- Inicio de partida.
- Cambio de escenario.
- Inicio de cinemática.
- Cambio de modo de juego.

Estos casos no deben utilizar el Event Bus directamente.

Deben implementarse mediante el Multiplayer Pipeline.

---

# Integración con Save Pipeline

El Event Bus representa información temporal.

Por lo tanto:

Los Events **no forman parte del archivo de guardado**.

---

# ¿Por qué?

Al guardar una partida únicamente interesa el estado final del mundo.

No interesa el conjunto de Events que produjo dicho estado.

Ejemplo.

```text
DamageApplied

↓

Health = 40
```

Solo debe persistirse:

```text
Health = 40
```

El Event deja de existir.

---

# Queue de Events

La Event Queue nunca se serializa.

Durante la carga:

- Se crea una Queue vacía.
- Se reconstruyen las Entities.
- Se reconstruyen los Components.
- Los Systems generan nuevos Events cuando corresponda.

---

# Compatibilidad con Replay

El Framework debe permitir implementar Replay determinista.

Para ello el Event Bus debe mantener un comportamiento completamente reproducible.

Esto requiere:

- Orden estable.
- Dispatch determinista.
- Sin aleatoriedad.
- Sin dependencias del reloj del sistema.

---

# Registro para Replay

Opcionalmente el Framework puede registrar:

```text
Frame

↓

Event Type

↓

Payload
```

Este registro permite:

- Depuración.
- Análisis.
- Herramientas de Replay.
- Testing automatizado.

---

# Event Pools

Para minimizar asignaciones dinámicas el Event Bus debe reutilizar memoria mediante Pools.

Cada tipo de Event puede disponer de su propio Pool.

Ejemplo conceptual.

```text
Damage Events

↓

Pool
```

---

# Ciclo del Pool

```text
Acquire

↓

Populate

↓

Publish

↓

Dispatch

↓

Reset

↓

Release
```

La memoria permanece reservada.

Solo cambia el contenido del Event.

---

# Reinicialización

Antes de devolver un Event al Pool el Framework debe:

- Limpiar referencias temporales.
- Restablecer valores.
- Invalidar datos internos.
- Prepararlo para su reutilización.

---

# Optimización de Memoria

El Event Bus debe minimizar:

- Allocations.
- Garbage Collection.
- Copias de memoria.
- Fragmentación.

Siempre que sea posible debe reutilizar estructuras existentes.

---

# Tamaño de los Events

Los Events deben permanecer pequeños.

Se recomienda almacenar:

- IDs.
- Valores.
- Referencias ligeras.

No deben contener estructuras complejas ni grandes colecciones de datos.

---

# Payload

El Payload representa la información transportada por el Event.

Debe contener únicamente los datos necesarios para describir el hecho ocurrido.

Ejemplo.

```text
DamageApplied

Entity

Amount

Source
```

No debe incluir información redundante.

---

# Instrumentación

El Event Bus puede recopilar estadísticas de ejecución.

Ejemplos:

- Events publicados.
- Events procesados.
- Tiempo de Dispatch.
- Tiempo promedio.
- Tiempo máximo.
- Cantidad de Subscribers.

---

# Métricas

Conceptualmente.

```text
DamageApplied

Published

1542

Processed

1542

Average

0.01 ms
```

---

# Profiling

En modo Debug el Framework puede registrar:

- Orden de publicación.
- Orden de Dispatch.
- Tiempo de espera en Queue.
- Tiempo de procesamiento.
- Subscribers involucrados.

Esta información facilita el diagnóstico de problemas.

---

# Rendimiento Esperado

Los objetivos mínimos del Event Bus son:

- Publicación O(1).
- Inserción en Queue O(1).
- Obtención de Subscribers O(1) u O(log n), según la implementación.
- Dispatch lineal respecto al número de Subscribers.

---

# Escalabilidad

El diseño debe soportar:

- Miles de Events por Frame.
- Cientos de tipos de Event.
- Decenas de Systems suscritos.
- Grandes mundos multijugador.

Sin necesidad de modificar la API pública.

---

# Validaciones

Antes de publicar un Event el Framework debe comprobar:

- Tipo registrado.
- Payload válido.
- Event correctamente inicializado.
- Pool disponible (si corresponde).

Los Events inválidos nunca deben ingresar a la Queue.

---

# Continúa en la Parte 4

La siguiente parte desarrollará:

- Debug Tools.
- Visualización del flujo de Events.
- Validaciones del Framework.
- Manejo de errores.
- Buenas prácticas.
- Anti-patrones.
- Convenciones.
- Resumen del ciclo de vida.
- Estado final del documento.
---

# Debug Tools

El Framework debe proporcionar herramientas específicas para inspeccionar el funcionamiento del Event Bus durante el desarrollo.

Estas herramientas nunca deben formar parte de la lógica de producción.

Su objetivo es facilitar:

- Depuración.
- Diagnóstico.
- Optimización.
- Validación del Framework.

---

# Event Monitor

El Event Monitor permite visualizar en tiempo real los Events publicados durante la ejecución.

Conceptualmente.

```text
Frame 1542

DamageApplied

HealthChanged

EnemyKilled

QuestUpdated

LootSpawned
```

Esta herramienta resulta especialmente útil para comprender la secuencia de eventos del juego.

---

# Event Timeline

Además del listado, el Framework puede representar la secuencia temporal.

Ejemplo conceptual.

```text
Frame

↓

DamageApplied

↓

HealthChanged

↓

EnemyKilled

↓

QuestUpdated
```

Esto facilita detectar problemas de orden de ejecución.

---

# Subscriber Inspector

El Framework debe permitir inspeccionar los Subscribers registrados para cada tipo de Event.

Ejemplo.

```text
EnemyKilled

↓

Quest System

Loot System

Achievement System

Statistics System
```

Esto simplifica la detección de suscripciones incorrectas.

---

# Queue Inspector

Durante el modo Debug debe ser posible visualizar el contenido actual de la Event Queue.

Ejemplo.

```text
Pending Events

DamageApplied

ItemCrafted

BuildingPlaced
```

Esta información permite detectar acumulaciones inesperadas.

---

# Dispatch Statistics

El Dispatcher puede mostrar métricas como:

- Events publicados.
- Events procesados.
- Tiempo promedio.
- Tiempo máximo.
- Subscribers notificados.
- Longitud máxima de la Queue.

---

# Validaciones del Framework

Durante desarrollo el Event Bus debe detectar automáticamente situaciones inválidas.

Ejemplos:

- Publicar un tipo de Event no registrado.
- Registrar un Subscriber duplicado.
- Publicar un Event incompleto.
- Suscribirse a un tipo inexistente.
- Modificar un Event durante el Dispatch.

Estas comprobaciones pueden deshabilitarse en compilaciones de producción.

---

# Manejo de Errores

Ante un error el Framework debe:

- Registrar información detallada.
- Identificar el System responsable.
- Mostrar el tipo de Event involucrado.
- Mantener el Event Bus en un estado consistente.

Siempre que sea posible, debe evitarse la detención completa del juego.

---

# Recuperación

Los errores en un Subscriber no deben impedir el procesamiento del resto.

Conceptualmente.

```text
Dispatch

↓

Subscriber A

↓

Error

↓

Registrar Error

↓

Continuar

↓

Subscriber B

↓

Subscriber C
```

El Event Bus debe aislar el fallo y continuar la distribución.

---

# Consistencia

Después de finalizar el Dispatch se garantiza que:

- Todos los Subscribers válidos fueron notificados.
- La Queue quedó consistente.
- No existen referencias pendientes al Event.
- El Pool puede reutilizar la memoria.

---

# Buenas Prácticas

Se recomienda:

- Publicar únicamente Events significativos.
- Mantener los Payloads pequeños.
- Evitar publicar múltiples Events redundantes.
- Utilizar nombres claros y consistentes.
- Mantener un único propósito por Event.
- Favorecer Events específicos frente a Events genéricos.

---

# Recomendaciones de Diseño

Un Event debe describir un único hecho.

Ejemplo correcto.

```text
BuildingConstructed
```

Ejemplo incorrecto.

```text
BuildingConstructedAndPlayerLeveledUp
```

Cada hecho debe representarse mediante un Event independiente.

---

# Anti-Patrones

El Framework prohíbe expresamente:

- Modificar un Event después de publicarlo.
- Utilizar Events como Commands.
- Ejecutar lógica dentro de un Event.
- Utilizar el Event Bus para reemplazar llamadas directas cuando exista una dependencia obligatoria.
- Publicar Events desde Components.
- Publicar Events durante la construcción o destrucción del Event Bus.
- Crear dependencias circulares mediante cadenas de Events.

---

# Convenciones de Nomenclatura

Todos los Events deben nombrarse en tiempo pasado, representando un hecho ya ocurrido.

Ejemplos:

Correcto.

```text
DamageApplied

EntityCreated

QuestCompleted

ResearchFinished
```

Incorrecto.

```text
ApplyDamage

CreateEntity

CompleteQuest

FinishResearch
```

---

# Convenciones del Framework

Todos los Events deberán cumplir las siguientes reglas:

- Son inmutables.
- Contienen únicamente datos.
- No contienen lógica.
- No conocen Publishers.
- No conocen Subscribers.
- No conocen el Scheduler.
- No modifican el ECS.
- No realizan Queries.

---

# Resumen del Ciclo de Vida

```text
Create Event
        │
        ▼
Publish
        │
        ▼
Insert into Queue
        │
        ▼
Wait for Dispatch
        │
        ▼
Notify Subscribers
        │
        ▼
All Subscribers Finished
        │
        ▼
Dispose / Return to Pool
```

---

# Garantías del Event Bus

Al finalizar cada Frame el Framework garantiza que:

- Todos los Events publicados fueron procesados o permanecen correctamente en la Queue según el pipeline.
- Ningún Subscriber recibió un Event duplicado.
- Ningún Event fue modificado durante su ciclo de vida.
- Todos los Events finalizaron en un estado consistente.
- Los Pools quedaron preparados para reutilización.
- Las métricas del Dispatcher fueron actualizadas.

---

# Relación con el Resto del Framework

El Event Bus interactúa con:

- Scheduler.
- Entity Registry.
- Component Registry.
- Query System.
- Save Pipeline.
- Multiplayer Pipeline.
- Debug Tools.

Sin embargo, mantiene una única responsabilidad:

**Transportar información entre Systems de forma desacoplada y determinista.**

---

# Estado

**Estado actual:** Especificación de la arquitectura del Event Bus.

Este documento define el contrato técnico para la implementación del sistema de eventos del Framework ECS de Survivors Lords.

Toda comunicación basada en eventos deberá utilizar exclusivamente la infraestructura aquí descrita. Cualquier modificación al modelo de publicación, despacho, prioridades o ciclo de vida de los Events deberá documentarse mediante una DEC (Design Engineering Change) para preservar la coherencia de la arquitectura ECS.
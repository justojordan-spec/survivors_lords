# 09 - QUERY ENGINE IMPLEMENTATION

# Parte 1 — Arquitectura General

---

# Objetivo

Este documento define la implementación del **Query Engine** del Framework ECS de Survivors Lords.

El Query Engine constituye el mecanismo oficial mediante el cual los Systems pueden solicitar información a otros Systems sin crear dependencias directas entre ellos.

Su implementación debe proporcionar una infraestructura:

- completamente desacoplada;
- determinista;
- síncrona;
- eficiente;
- escalable.

El Query Engine no implementa gameplay.

No contiene lógica de negocio.

No conoce Components específicos.

Únicamente coordina la ejecución de consultas.

---

# Alcance

Este documento define:

- Arquitectura del Query Engine.
- Registro de Queries.
- Registro de Query Handlers.
- Ejecución.
- Validaciones.
- Integración con el Runtime.
- Performance.
- Debug.
- Testing.

No define:

- Gameplay.
- Components.
- Systems concretos.
- Save.
- Multiplayer.
- Queries específicas.

---

# Filosofía

El Framework utiliza dos mecanismos oficiales de comunicación entre Systems.

## Comunicación Asíncrona

Mediante Events.

```text
System

↓

Event Bus

↓

Subscribers
```

---

## Comunicación Síncrona

Mediante Queries.

```text
System

↓

Query Engine

↓

Result
```

Ambos mecanismos son complementarios.

Nunca deben sustituirse entre sí.

---

# Diferencia Fundamental

Los Events notifican que algo ocurrió.

Las Queries solicitan información.

Ejemplo conceptual:

Evento:

```text
Inventory Changed
```

Query:

```text
Get Inventory
```

El primero comunica un hecho.

El segundo solicita un estado.

---

# Principio Fundamental

Las Queries siempre son:

- síncronas;
- inmediatas;
- deterministas;
- de solo lectura.

Nunca utilizan colas.

Nunca esperan un Flush.

Nunca son diferidas.

---

# Flujo General

Toda Query sigue exactamente el siguiente recorrido.

```text
System

↓

Execute Query

↓

Query Engine

↓

Registry

↓

Handler

↓

Result

↓

Return
```

No existen pasos adicionales.

---

# Arquitectura General

El Query Engine se divide en módulos especializados.

```text
                   IQueryEngine
                         │
                         ▼
                    QueryEngine
──────────────────────────────────────────────────────────
                         │
      ┌─────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
      ▼             ▼              ▼              ▼              ▼
 QueryRegistry
 QueryDispatcher
 QueryValidator
 QueryCache
 QueryProfiler
```

Cada módulo posee una única responsabilidad.

---

# Query Engine

## Responsabilidad

Actúa como fachada pública.

Expone la API utilizada por los Systems.

Coordina los módulos internos.

Nunca ejecuta Queries directamente.

Nunca almacena resultados.

Nunca interpreta la información solicitada.

---

# Query Registry

## Responsabilidad

Mantener el registro de todas las Queries disponibles.

Relaciona:

- tipo de Query;
- Query Handler correspondiente.

No ejecuta lógica.

No conoce Systems.

---

# Query Dispatcher

## Responsabilidad

Coordinar la ejecución de una Query.

Su flujo es:

```text
Receive Query

↓

Locate Handler

↓

Execute

↓

Return Result
```

No interpreta el resultado.

---

# Query Validator

## Responsabilidad

Verificar que una Query pueda ejecutarse correctamente.

Ejemplos:

- Query registrada;
- Handler válido;
- parámetros correctos;
- Runtime disponible.

---

# Query Cache

## Responsabilidad

Almacenar temporalmente resultados reutilizables cuando una Query sea apta para ello.

El uso del Cache es completamente opcional.

La API pública nunca depende de su existencia.

---

# Query Profiler

## Responsabilidad

Registrar estadísticas relacionadas con la ejecución de Queries.

Ejemplos:

- cantidad de Queries;
- tiempo medio;
- tiempo máximo;
- Queries por Frame;
- utilización del Cache.

---

# Qué es una Query

Una Query representa una solicitud de información.

Ejemplos conceptuales:

```text
Get Player Inventory

Get Current Health

Get Equipped Weapon

Get Active Quests

Get Nearby Enemies
```

Todas representan consultas.

Nunca producen cambios en el mundo.

---

# Qué NO es una Query

Una Query nunca representa:

- una acción;
- un comando;
- una notificación;
- un evento.

Ejemplos incorrectos:

```text
Spawn Entity

Destroy Item

Apply Damage

Create Save
```

Todas ellas modifican el estado del mundo.

Por lo tanto no son Queries.

---

# Solo Lectura

Toda Query debe comportarse como una operación de lectura.

Conceptualmente:

```text
World

↓

Read

↓

Return Result
```

Nunca:

```text
World

↓

Modify
```

---

# Inmutabilidad

La ejecución de una Query no debe modificar:

- entidades;
- Components;
- Resources;
- Registries;
- Systems.

Su única responsabilidad consiste en devolver información.

---

# Determinismo

Una Query ejecutada dos veces sobre exactamente el mismo estado del Runtime debe producir exactamente el mismo resultado.

El resultado nunca debe depender de:

- FPS;
- hardware;
- orden de ejecución de otros Systems.

---

# Sin Estado

El Query Engine no conserva contexto entre consultas.

Cada Query es independiente.

Conceptualmente:

```text
Query A

↓

Result

↓

Finish

↓

Query B
```

No existe relación obligatoria entre ambas.

---

# Comunicación Desacoplada

El siguiente flujo representa el modelo oficial.

```text
Combat System

↓

Query

↓

Query Engine

↓

Inventory System

↓

Result
```

Combat System nunca conoce Inventory System.

Inventory System nunca conoce Combat System.

Ambos únicamente conocen el Query Engine.

---

# Integración con Systems

Los Systems únicamente pueden:

- ejecutar Queries;
- registrar Query Handlers;
- cancelar registros durante su destrucción.

No deben acceder a módulos internos.

---

# Integración con Components

Los Components nunca ejecutan Queries.

Los Components únicamente almacenan datos.

Toda decisión de consultar información pertenece a los Systems.

---

# Integración con Events

Events y Queries pueden utilizarse conjuntamente.

Ejemplo:

```text
Receive Event

↓

Execute Query

↓

Apply Gameplay Logic
```

El Event Bus continúa siendo completamente independiente.

---

# Ciclo de Vida

El Query Engine posee un ciclo de vida propio.

```text
Created

↓

Initialized

↓

Ready

↓

Running

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

Todos los módulos fueron creados.

Todavía no acepta consultas.

---

# Ready

El Runtime puede comenzar a ejecutar Queries.

---

# Running

Las Queries pueden ejecutarse normalmente.

---

# Stopped

No se aceptan nuevas consultas.

---

# Disposed

Todos los recursos internos fueron liberados.

---

# Garantías

Toda implementación debe garantizar:

- una única instancia del Query Engine;
- ejecución síncrona;
- ausencia de efectos secundarios;
- determinismo;
- desacoplamiento total entre Systems;
- integración consistente con el resto del Framework.

---

# Separación de Responsabilidades

| Módulo | Responsabilidad |
|----------|----------------|
| QueryEngine | API pública |
| QueryRegistry | Registro de Queries |
| QueryDispatcher | Ejecución |
| QueryValidator | Validaciones |
| QueryCache | Cache opcional |
| QueryProfiler | Métricas |

Cada módulo mantiene una única responsabilidad.

---

# Dependencias Permitidas

El Query Engine puede depender únicamente de:

- IECSContext;
- interfaces internas del Runtime;
- Scheduler (si necesita consultar el estado del Runtime).

No debe depender de:

- gameplay;
- escenas;
- Nodes;
- UI;
- Components específicos.

---

# Objetivos Arquitectónicos

La implementación debe permitir:

- miles de Queries por Frame;
- ejecución inmediata;
- bajo coste de búsqueda;
- integración transparente con Systems;
- instrumentación para Debug;
- futuras optimizaciones sin modificar la API pública.

---

# Resultado Esperado

Al finalizar esta primera parte queda definida la arquitectura general del **Query Engine** del Framework ECS.

El Query Engine se establece como el mecanismo oficial para la comunicación síncrona y de solo lectura entre Systems, organizado mediante módulos especializados para el registro, la ejecución, la validación, el almacenamiento opcional en caché y el profiling, manteniendo un diseño completamente desacoplado, determinista y preparado para la evolución futura del Runtime.
# 09 - QUERY ENGINE IMPLEMENTATION

# Parte 2 — Query Lifecycle, Query Registry y Registro de Query Handlers

---

# Objetivo

Esta sección define el ciclo de vida completo de una Query, el funcionamiento interno del Query Registry y el proceso de registro de los Query Handlers.

El objetivo es garantizar que todas las consultas del Framework sean:

- deterministas;
- rápidas;
- desacopladas;
- fácilmente localizables;
- completamente independientes del gameplay.

---

# Filosofía

Una Query no existe de manera permanente.

Es una solicitud temporal de información que nace, se ejecuta y finaliza inmediatamente.

El Query Engine únicamente coordina ese proceso.

---

# Principio Fundamental

Cada Query sigue exactamente el mismo flujo.

```text
Create Query

↓

Validate

↓

Locate Handler

↓

Execute

↓

Return Result

↓

Destroy Query
```

La Query no permanece almacenada dentro del Runtime.

---

# Query Lifecycle

Toda Query atraviesa los siguientes estados.

```text
Created

↓

Validated

↓

Dispatched

↓

Executing

↓

Completed

↓

Disposed
```

Cada transición posee un significado específico.

---

# Created

La Query acaba de ser creada por un System.

Todavía no ha sido enviada al Query Engine.

---

# Validated

El Query Engine verifica que:

- el tipo exista;
- el Handler esté registrado;
- el Runtime esté disponible;
- los parámetros mínimos sean válidos.

---

# Dispatched

La Query fue entregada al Dispatcher.

Aún no comenzó su ejecución.

---

# Executing

El Query Handler está procesando la consulta.

Durante esta etapa únicamente se realizan operaciones de lectura.

---

# Completed

El Handler finalizó.

Existe un resultado disponible.

---

# Disposed

La Query deja de existir.

Toda memoria temporal puede reutilizarse.

---

# Duración

Una Query normalmente vive únicamente durante una llamada.

Conceptualmente:

```text
System

↓

Create Query

↓

Execute

↓

Return

↓

Destroy
```

No existen Queries pendientes entre Frames.

---

# Query Registry

## Responsabilidad

El Query Registry mantiene el catálogo completo de todas las Queries disponibles en el Runtime.

Relaciona:

- tipo de Query;
- Query Handler correspondiente.

No ejecuta consultas.

No interpreta resultados.

---

# Organización Conceptual

```text
Query Type

↓

Handler
```

Ejemplo:

```text
GetInventoryQuery

↓

InventoryQueryHandler
```

---

# Registro

Durante la inicialización del Runtime:

```text
Query Handler

↓

Register

↓

Query Registry
```

A partir de ese momento la Query puede ejecutarse.

---

# Registro Único

Cada tipo de Query debe poseer exactamente un Handler.

Ejemplo válido:

```text
GetHealthQuery

↓

HealthQueryHandler
```

Ejemplo inválido:

```text
GetHealthQuery

↓

Handler A

↓

Handler B
```

El Query Engine debe detectar esta situación durante la inicialización.

---

# Un Handler por Query

La arquitectura establece una relación:

```text
1 Query Type

↓

1 Handler
```

Esto elimina ambigüedades durante la ejecución.

---

# Un Handler, Muchas Consultas

Un mismo Handler puede ejecutarse miles de veces.

Conceptualmente:

```text
Handler

↓

Query

↓

Result

↓

Query

↓

Result

↓

Query

↓

Result
```

El Handler permanece registrado.

Las Queries son temporales.

---

# Registro Durante el Bootstrap

Todos los Query Handlers deben registrarse antes del primer Frame.

Conceptualmente:

```text
Bootstrap

↓

Create Systems

↓

Register Queries

↓

Runtime Ready
```

Esto evita búsquedas dinámicas posteriores.

---

# Eliminación

Cuando un System es destruido:

```text
Dispose

↓

Unregister Query Handler
```

El Registry elimina la asociación correspondiente.

---

# Integridad

El Registry debe garantizar:

- ausencia de duplicados;
- ausencia de referencias inválidas;
- coherencia del catálogo;
- consistencia durante toda la ejecución.

---

# Consulta del Registry

Cuando llega una Query:

```text
Query Type

↓

Registry Lookup

↓

Handler
```

La operación debe ser rápida.

---

# Complejidad

El Registry debe optimizar especialmente:

- búsqueda;
- registro;
- eliminación.

Las búsquedas son la operación más frecuente.

---

# Modificaciones del Registry

El Registry únicamente puede modificarse durante momentos seguros del Runtime.

Ejemplos:

- Bootstrap;
- destrucción controlada de Systems;
- recarga del Runtime.

Nunca durante la ejecución normal de una Query.

---

# Thread Safety

Aunque la implementación inicial sea secuencial, el Registry no debe asumir que siempre existirá un único hilo de ejecución.

Su diseño debe facilitar futuras mejoras sin modificar la API pública.

---

# Query Handlers

## Responsabilidad

Un Query Handler contiene la lógica necesaria para responder una Query específica.

Ejemplo conceptual:

```text
GetInventoryQuery

↓

InventoryQueryHandler

↓

InventoryData
```

---

# Especialización

Cada Handler debe especializarse en una única Query.

No debe responder múltiples tipos diferentes.

---

# Responsabilidad Única

El Handler únicamente debe:

- recibir la Query;
- consultar el estado necesario;
- construir el resultado;
- devolver la respuesta.

No debe realizar ninguna otra tarea.

---

# Operaciones Permitidas

Un Handler puede:

- consultar Components;
- ejecutar Queries auxiliares (si la arquitectura lo permite);
- leer Resources;
- acceder al contexto del Runtime mediante interfaces.

---

# Operaciones Prohibidas

Un Handler nunca debe:

- modificar Components;
- crear entidades;
- destruir entidades;
- emitir Commands;
- emitir Events;
- serializar información;
- modificar Registries.

Debe comportarse como una operación pura de lectura.

---

# Independencia

Los Handlers nunca deben conocerse entre sí.

Toda coordinación continúa realizándose mediante el Query Engine.

---

# Reutilización

Un mismo Handler puede responder miles de consultas durante una sesión.

No debe almacenar información temporal entre ejecuciones.

---

# Estado

Los Query Handlers deben ser esencialmente **stateless**.

No deben depender de información almacenada en ejecuciones anteriores.

---

# Validaciones del Registro

Al registrar un Handler deben comprobarse:

- tipo de Query válido;
- Handler válido;
- ausencia de duplicados;
- compatibilidad entre Query y Handler.

---

# Restricciones

El Query Registry nunca debe:

- ejecutar Queries;
- construir resultados;
- interpretar datos;
- acceder al gameplay.

Su única responsabilidad consiste en administrar el catálogo de Queries disponibles.

---

# Garantías

El Query Registry garantiza que:

- cada Query posee exactamente un Handler;
- las búsquedas son deterministas;
- el registro permanece consistente;
- no existen asociaciones ambiguas.

Los Query Handlers garantizan que:

- las consultas permanecen encapsuladas;
- las operaciones son de solo lectura;
- cada Query posee una implementación claramente definida.

---

# Flujo Completo

Conceptualmente:

```text
Bootstrap

↓

Register Query Handler

↓

Query Registry

↓

Runtime Ready

↓

Execute Query

↓

Locate Handler

↓

Continue Execution
```

Este flujo representa el comportamiento oficial del registro y resolución de Queries dentro del Framework.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificado el **Query Lifecycle**, el **Query Registry** y el proceso de registro de **Query Handlers**.

La arquitectura garantiza un mecanismo determinista para localizar la implementación correspondiente a cada Query, manteniendo un único Handler por tipo de consulta y asegurando que todas las operaciones permanezcan desacopladas, de solo lectura y preparadas para escalar junto con el resto del Framework ECS.
# 09 - QUERY ENGINE IMPLEMENTATION

# Parte 3 — Query Dispatcher, Ejecución y Devolución de Resultados

---

# Objetivo

Esta sección define el funcionamiento interno del Query Dispatcher, el proceso completo de ejecución de una Query y el mecanismo oficial mediante el cual el resultado es devuelto al System solicitante.

El Query Dispatcher constituye el núcleo operativo del Query Engine.

Su responsabilidad consiste únicamente en coordinar la ejecución de las consultas.

No contiene lógica de gameplay.

No interpreta resultados.

No modifica el estado del Runtime.

---

# Filosofía

El Query Dispatcher funciona como un intermediario completamente transparente.

Recibe una Query.

Localiza el Handler correspondiente.

Ejecuta la consulta.

Devuelve el resultado.

Finaliza.

Todo el proceso ocurre durante una única llamada.

---

# Flujo General

Conceptualmente:

```text
System

↓

Execute Query

↓

Query Engine

↓

Validate

↓

Registry Lookup

↓

Handler

↓

Execute

↓

Build Result

↓

Return
```

Todo el flujo es completamente síncrono.

---

# Responsabilidad

El Query Dispatcher únicamente debe:

- recibir Queries;
- solicitar validaciones;
- localizar Handlers;
- ejecutar consultas;
- devolver resultados.

Nada más.

---

# Recepción

Cuando un System ejecuta una Query:

```text
Combat System

↓

Execute Query
```

La petición llega inmediatamente al Dispatcher.

---

# Validación

Antes de cualquier ejecución:

```text
Query

↓

Validator

↓

Valid
```

Si la Query resulta inválida:

```text
Query

↓

Validator

↓

Invalid

↓

Abort
```

Nunca debe ejecutarse un Handler inválido.

---

# Resolución

Después de validar:

```text
Query Type

↓

Registry

↓

Handler
```

El Dispatcher obtiene el Handler correspondiente.

---

# Ejecución

Una vez localizado:

```text
Handler

↓

Execute
```

El Handler procesa la consulta.

---

# Resultado

El Handler construye un resultado.

Conceptualmente:

```text
Handler

↓

Query Result
```

El Dispatcher no modifica dicho resultado.

---

# Retorno

Finalmente:

```text
Result

↓

System
```

El flujo termina.

---

# Naturaleza Sincrónica

La ejecución ocurre completamente dentro de una única llamada.

Conceptualmente:

```text
Call

↓

Execute

↓

Return
```

No existen:

- esperas;
- colas;
- procesamiento diferido.

---

# Tiempo de Ejecución

Una Query debe finalizar antes de que continúe la ejecución del System.

Ejemplo:

```text
Execute Query

↓

Receive Result

↓

Continue Gameplay
```

---

# Atomicidad

Toda Query debe comportarse como una operación atómica.

Durante su ejecución:

- comienza;
- obtiene información;
- devuelve resultado;
- finaliza.

Nunca permanece parcialmente ejecutada.

---

# Reentrancia

El Dispatcher debe ser capaz de ejecutar múltiples Queries consecutivas.

Ejemplo:

```text
Query A

↓

Result

↓

Query B

↓

Result

↓

Query C

↓

Result
```

Cada ejecución es independiente.

---

# Queries Encadenadas

Un Handler puede necesitar consultar otra información.

Conceptualmente:

```text
Handler

↓

Execute Query

↓

Result

↓

Continue
```

Esto únicamente es válido si la arquitectura lo permite explícitamente y no introduce dependencias circulares.

---

# Dependencias Circulares

Debe evitarse una situación como:

```text
Query A

↓

Query B

↓

Query C

↓

Query A
```

El Query Validator podrá detectar este tipo de configuraciones durante el Bootstrap cuando sea posible.

---

# Resultados

Toda Query devuelve exactamente un resultado.

Ese resultado puede ser:

- un valor;
- una estructura;
- una colección;
- un objeto de datos;
- un resultado vacío válido.

---

# Resultado Vacío

No encontrar información no representa necesariamente un error.

Ejemplo:

```text
Get Equipped Weapon

↓

No Weapon Equipped
```

La Query continúa siendo válida.

---

# Errores

Los errores representan situaciones excepcionales.

Ejemplos:

- Handler inexistente;
- Query inválida;
- Runtime detenido.

No deben utilizarse para indicar ausencia de datos.

---

# Inmutabilidad

Una vez construido:

```text
Query Result
```

debe tratarse como información de solo lectura.

El Dispatcher nunca debe modificarlo.

---

# Ownership

El resultado pertenece al System que ejecutó la Query.

El Query Engine no conserva referencias permanentes.

---

# Sin Persistencia

Después del retorno:

```text
Return Result

↓

Finish
```

El Query Engine no almacena el resultado salvo que exista un mecanismo explícito de Cache.

---

# Integración con el Scheduler

El Scheduler no coordina la ejecución de Queries.

Las Queries pueden ejecutarse en cualquier momento permitido por el Runtime.

Ejemplo:

```text
System Execution

↓

Execute Query

↓

Continue
```

No existe un Query Flush.

---

# Integración con Systems

Los Systems pueden ejecutar tantas Queries como necesiten.

No obstante, deben evitar consultas redundantes.

Ejemplo recomendable:

```text
Query Once

↓

Reuse Result
```

En lugar de:

```text
Query

↓

Query

↓

Query

↓

Same Data
```

---

# Integración con Components

Los Handlers pueden consultar Components.

Nunca modificarlos.

Conceptualmente:

```text
Component Data

↓

Read

↓

Return
```

---

# Integración con Resources

Los Handlers también pueden consultar:

- configuración;
- tablas;
- datos Data Driven.

Siempre en modo lectura.

---

# Integración con Registries

Los Registries pueden consultarse para localizar información.

Nunca deben modificarse durante una Query.

---

# Restricciones

Durante una Query está prohibido:

- emitir Events;
- emitir Commands;
- crear entidades;
- destruir entidades;
- modificar Components;
- modificar Resources;
- modificar Registries;
- iniciar procesos de Save.

---

# Consistencia

Una Query siempre observa un estado consistente del Runtime.

El Dispatcher nunca debe ejecutar consultas mientras un Registry se encuentre en transición estructural.

Esta garantía es proporcionada por el Scheduler y por las barreras de sincronización definidas en el Framework.

---

# Garantías

El Query Dispatcher garantiza:

- ejecución inmediata;
- resolución determinista;
- un único Handler por Query;
- ausencia de efectos secundarios;
- retorno inmediato del resultado;
- independencia entre consultas consecutivas.

---

# Flujo Completo

Conceptualmente:

```text
System

↓

Execute Query

↓

Validator

↓

Registry

↓

Handler

↓

Execute

↓

Build Result

↓

Return

↓

Continue System
```

Este flujo representa el comportamiento oficial de todas las Queries dentro del Framework ECS.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificada la implementación del **Query Dispatcher** y del proceso de ejecución de Queries.

El Framework dispone de un mecanismo de consulta completamente síncrono, determinista y de solo lectura, capaz de localizar el Handler adecuado, ejecutar la consulta y devolver inmediatamente un resultado al System solicitante, manteniendo el desacoplamiento entre Systems y preservando la consistencia del Runtime.
# 09 - QUERY ENGINE IMPLEMENTATION

# Parte 4 — Integración con Systems, Scheduler, Registries, Save y Multiplayer

---

# Objetivo

Esta sección define cómo el Query Engine se integra con el resto de la arquitectura del Framework ECS.

El Query Engine no constituye un subsistema aislado.

Su funcionamiento depende de una correcta interacción con:

- Scheduler
- Systems
- Entity Registry
- Component Registry
- Resource Registry
- Event Bus
- Save Pipeline
- Multiplayer Pipeline
- Debug Tools

La integración debe mantener el desacoplamiento arquitectónico definido en las fases anteriores.

---

# Filosofía

El Query Engine proporciona acceso controlado al estado actual del Runtime.

No reemplaza:

- Event Bus;
- Commands;
- Registries;
- Save;
- Networking.

Cada subsistema conserva una única responsabilidad.

---

# Integración con Systems

Los Systems representan los consumidores principales del Query Engine.

Toda solicitud de información debe realizarse mediante la interfaz pública del Query Engine.

Nunca mediante referencias directas a otros Systems.

---

# Comunicación Oficial

El flujo permitido es:

```text
System A

↓

Execute Query

↓

Query Engine

↓

Query Handler

↓

Result

↓

System A
```

Nunca:

```text
System A

↓

System B
```

Las dependencias directas entre Systems permanecen prohibidas.

---

# Integración con el Scheduler

A diferencia del Event Bus, el Scheduler no controla el momento de ejecución de las Queries.

Las Queries son operaciones síncronas.

Pueden ejecutarse en cualquier punto permitido durante la ejecución de un System.

Conceptualmente:

```text
Scheduler

↓

Execute System

↓

Query

↓

Continue
```

---

# Barreras del Scheduler

Aunque el Scheduler no coordina las Queries, sí garantiza que estas se ejecuten sobre un estado consistente del Runtime.

Las Queries nunca deben ejecutarse:

- durante un Flush del Command Buffer;
- durante modificaciones estructurales;
- mientras un Registry se encuentre en transición.

---

# Estado Consistente

Toda Query debe observar una instantánea lógica consistente del mundo.

Conceptualmente:

```text
Stable Runtime

↓

Execute Query

↓

Return Result
```

Esta garantía pertenece al Scheduler.

---

# Integración con Entity Registry

Los Query Handlers pueden consultar el Entity Registry para:

- localizar entidades;
- verificar existencia;
- recorrer identificadores;
- obtener referencias válidas.

Nunca deben modificar su contenido.

---

# Integración con Component Registry

Los Query Handlers pueden acceder al Component Registry para:

- leer Components;
- localizar información;
- construir resultados.

Está prohibido:

- agregar Components;
- eliminar Components;
- modificar Components.

---

# Integración con Resource Registry

Los Handlers pueden consultar información Data Driven.

Ejemplos:

```text
Item Definitions

Craft Recipes

Biome Configuration

AI Profiles
```

Toda consulta debe realizarse en modo lectura.

---

# Integración con Event Bus

Queries y Events representan mecanismos complementarios.

Ejemplo conceptual:

```text
Receive Event

↓

Execute Query

↓

Gameplay Logic
```

El Query Engine nunca genera eventos automáticamente.

---

# Integración con Commands

Las Queries nunca generan Commands.

Si un System necesita modificar el mundo:

```text
Query

↓

Decision

↓

Create Command
```

La modificación continúa realizándose mediante el Command Buffer.

---

# Integración con Save

El Query Engine no participa directamente del proceso de serialización.

Sin embargo, el Save Pipeline puede utilizar Queries para obtener información específica del Runtime.

Ejemplo conceptual:

```text
Save System

↓

Execute Query

↓

Collect Data

↓

Serialize
```

La responsabilidad de serializar continúa perteneciendo al Save Pipeline.

---

# Integración con Load

Durante la carga:

```text
Restore World

↓

Registries Ready

↓

Enable Queries
```

Las Queries únicamente deben habilitarse cuando el Runtime se encuentre completamente inicializado.

---

# Integración con Multiplayer

En un modelo Server Authoritative:

```text
Server System

↓

Execute Query

↓

Authoritative Result
```

El resultado representa siempre el estado oficial del servidor.

---

# Cliente

En el cliente:

```text
Client System

↓

Execute Query

↓

Local State
```

El Query Engine no realiza sincronización de red.

Únicamente consulta el estado disponible localmente.

---

# Replicación

Las Queries nunca producen replicación.

Si una consulta genera una decisión que requiere sincronización:

```text
Query

↓

Gameplay Logic

↓

Network System
```

La responsabilidad continúa perteneciendo al Multiplayer Pipeline.

---

# Integración con AI

Los AI Systems pueden utilizar Queries para:

- localizar objetivos;
- obtener información del mundo;
- consultar amenazas;
- acceder a configuración.

La IA nunca debe acceder directamente a otros Systems.

---

# Integración con Debug

Las herramientas de Debug pueden consultar:

- Queries registradas;
- Query Handlers;
- estadísticas;
- tiempos de ejecución;
- utilización del Cache.

Toda la información debe exponerse como solo lectura.

---

# Integración con Profiling

El Query Profiler recopila:

- Queries ejecutadas;
- tiempo medio;
- tiempo máximo;
- tiempo mínimo;
- frecuencia por tipo.

Estas métricas facilitan la optimización del Runtime.

---

# Integración con Testing

Las pruebas automatizadas pueden:

- registrar Handlers simulados;
- ejecutar Queries;
- validar resultados;
- medir tiempos;
- comprobar errores.

Todo utilizando exclusivamente interfaces públicas.

---

# Dependencias Permitidas

El Query Engine puede depender de:

- IECSContext;
- Registries;
- Scheduler;
- Runtime Services.

Siempre mediante interfaces.

---

# Dependencias Prohibidas

El Query Engine nunca debe depender de:

- gameplay;
- escenas;
- UI;
- Nodes;
- Components concretos;
- Systems específicos.

Toda dependencia debe permanecer abstraída.

---

# Restricciones

El Query Engine nunca debe:

- emitir Events;
- ejecutar Commands;
- modificar Registries;
- modificar Components;
- serializar información;
- construir paquetes de red;
- acceder directamente al SceneTree.

Su única responsabilidad consiste en coordinar consultas de solo lectura.

---

# Garantías

La integración del Query Engine garantiza que:

- los Systems permanecen completamente desacoplados;
- todas las consultas se realizan sobre un estado consistente del Runtime;
- los Registries únicamente son leídos;
- Save puede utilizar Queries sin acoplarse al gameplay;
- Multiplayer puede consultar el estado del mundo sin modificar la infraestructura del Query Engine.

---

# Flujo Completo

Conceptualmente:

```text
System

↓

Execute Query

↓

Query Engine

↓

Locate Handler

↓

Read Runtime

↓

Build Result

↓

Return

↓

Continue Gameplay
```

Este flujo representa la integración oficial del Query Engine con el resto del Framework ECS.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificada la integración del **Query Engine** con el Scheduler, los Systems, los Registries, el Event Bus, el Save Pipeline y el Multiplayer Pipeline.

El Query Engine permanece como una infraestructura de consultas síncronas y de solo lectura, completamente desacoplada del gameplay y preparada para interactuar con el resto del Runtime mediante interfaces bien definidas, preservando la consistencia, el determinismo y la escalabilidad del Framework.
# 09 - QUERY ENGINE IMPLEMENTATION

# Parte 5 — Performance, Query Cache, Validaciones, Debug y Profiling

---

# Objetivo

Esta sección define las consideraciones relacionadas con el rendimiento, el sistema opcional de Query Cache, las validaciones internas, las herramientas de depuración y el sistema de profiling del Query Engine.

El objetivo es garantizar que el Query Engine pueda responder miles de consultas por Frame manteniendo un comportamiento:

- determinista;
- eficiente;
- escalable;
- fácilmente diagnosticable.

---

# Filosofía

El Query Engine será utilizado constantemente por los Systems del Runtime.

Por este motivo su implementación debe minimizar:

- tiempo de búsqueda;
- asignaciones dinámicas;
- validaciones redundantes;
- consumo de memoria;
- trabajo repetitivo.

---

# Objetivos de Rendimiento

La implementación debe optimizar especialmente:

- resolución de Queries;
- localización de Handlers;
- ejecución;
- devolución de resultados;
- reutilización de estructuras internas.

---

# Query Registry

El Query Registry constituye uno de los puntos críticos de rendimiento.

Las búsquedas deben ser extremadamente rápidas.

Conceptualmente:

```text
Query Type

↓

Handler
```

La resolución nunca debe depender de recorridos lineales sobre todos los Handlers registrados.

---

# Query Dispatcher

El Dispatcher debe añadir el menor coste posible.

Su responsabilidad consiste únicamente en coordinar:

```text
Validate

↓

Lookup

↓

Execute

↓

Return
```

No debe introducir procesamiento adicional.

---

# Asignaciones de Memoria

Siempre que sea posible deberán evitarse asignaciones innecesarias durante cada consulta.

La implementación debe favorecer:

- reutilización de buffers;
- reutilización de estructuras temporales;
- reutilización de objetos auxiliares.

---

# Garbage Collection

El Query Engine no debe generar presión innecesaria sobre el recolector de basura.

Las estructuras internas deben mantenerse estables durante toda la ejecución del Runtime.

---

# Query Cache

## Objetivo

Reducir el coste de determinadas consultas de solo lectura.

El Cache es completamente opcional.

La arquitectura del Query Engine nunca debe depender de su existencia.

---

# Filosofía del Cache

No todas las Queries son aptas para utilizar Cache.

El uso del Cache debe limitarse a información:

- estable;
- inmutable durante un intervalo conocido;
- costosa de calcular.

---

# Ejemplos Apropiados

```text
Biome Definitions

↓

Cache
```

```text
Craft Recipes

↓

Cache
```

```text
Static Configuration

↓

Cache
```

---

# Ejemplos No Apropiados

No deberían cachearse consultas relacionadas con:

```text
Current Health

Player Position

Inventory Contents

Nearby Enemies
```

Estos datos cambian continuamente.

---

# Transparencia

Desde el punto de vista del System:

```text
Execute Query

↓

Result
```

El System nunca debe conocer si el resultado proviene del Cache o del Handler.

---

# Cache Hit

Cuando existe un resultado válido:

```text
Query

↓

Cache

↓

Result
```

El Handler no necesita ejecutarse.

---

# Cache Miss

Cuando el resultado no existe:

```text
Query

↓

Handler

↓

Build Result

↓

Optional Cache

↓

Return
```

---

# Invalidación

Cuando un dato cacheado deja de ser válido:

```text
Runtime Change

↓

Invalidate Cache

↓

Next Query

↓

Execute Handler
```

La política de invalidación pertenece al Query Cache.

---

# Consistencia

El Cache nunca debe devolver información obsoleta.

La consistencia del resultado tiene prioridad sobre el rendimiento.

---

# Query Validator

## Responsabilidad

Comprobar que una Query pueda ejecutarse correctamente antes de llegar al Dispatcher.

---

# Validaciones Obligatorias

Como mínimo deben verificarse:

- tipo registrado;
- Handler existente;
- Runtime inicializado;
- parámetros válidos;
- estado Ready.

---

# Validaciones del Resultado

Después de la ejecución pueden verificarse:

- resultado válido;
- tipo esperado;
- ausencia de referencias inválidas.

---

# Errores

El Validator debe detectar situaciones como:

- Query inexistente;
- Handler duplicado;
- Handler eliminado;
- Runtime detenido.

---

# Logging

El Query Engine únicamente debe registrar:

- errores;
- advertencias relevantes;
- configuraciones inválidas.

Nunca debe registrar cada consulta durante la ejecución normal.

---

# Debug Mode

Durante el desarrollo pueden habilitarse comprobaciones adicionales.

Ejemplos:

- tiempo máximo permitido;
- validaciones de integridad;
- comprobación de referencias;
- detección de Handlers duplicados.

Estas verificaciones pueden omitirse en Release.

---

# Query Profiler

## Responsabilidad

Recopilar métricas relacionadas con la utilización del Query Engine.

No modifica el comportamiento del Runtime.

---

# Métricas Generales

Como mínimo deberán registrarse:

- número total de Queries;
- Queries por Frame;
- tiempo medio;
- tiempo mínimo;
- tiempo máximo;
- tiempo acumulado.

---

# Métricas por Tipo

Ejemplo conceptual:

```text
GetInventoryQuery

↓

1800 Calls
```

```text
GetHealthQuery

↓

3200 Calls
```

Esto permite detectar consultas excesivamente frecuentes.

---

# Métricas por Handler

También resulta útil registrar:

- tiempo medio por Handler;
- tiempo máximo;
- número de ejecuciones.

Estas métricas facilitan la optimización de la lógica de consulta.

---

# Métricas del Cache

Si el Cache está habilitado:

```text
Cache Hits

Cache Misses

Hit Ratio

Invalidations
```

Estas estadísticas permiten evaluar si el Cache resulta realmente beneficioso.

---

# Historial

En modo Debug puede mantenerse un historial limitado de consultas.

Ejemplo:

```text
Frame 200

↓

Executed Queries

↓

Execution Time
```

Este historial no debe mantenerse en Release salvo que sea estrictamente necesario.

---

# Herramientas de Debug

Las herramientas del Framework podrán consultar:

- Queries registradas;
- Query Handlers;
- métricas;
- tiempos;
- estado del Cache;
- estadísticas de uso.

Toda esta información debe exponerse mediante interfaces de solo lectura.

---

# Panel de Diagnóstico

Un panel de Debug podría representar conceptualmente:

```text
Registered Queries

↓

Executed Queries

↓

Execution Time

↓

Cache Statistics

↓

Profiler
```

Esta información facilita el análisis del Runtime.

---

# Escalabilidad

El Query Engine debe soportar:

- miles de consultas por Frame;
- cientos de tipos de Query;
- cientos de Handlers;
- crecimiento continuo del proyecto.

Sin modificar la arquitectura general.

---

# Restricciones

El Query Engine nunca debe sacrificar:

- determinismo;
- consistencia;
- simplicidad;
- desacoplamiento;

con el objetivo de mejorar el rendimiento.

Toda optimización debe preservar el comportamiento funcional.

---

# Garantías

El Query Engine garantiza que:

- todas las consultas son validadas antes de ejecutarse;
- el rendimiento puede medirse objetivamente;
- el Cache permanece completamente transparente para los Systems;
- las herramientas de Debug disponen de información suficiente para diagnosticar problemas;
- la instrumentación puede deshabilitarse sin modificar la lógica del Runtime.

---

# Resultado Esperado

Al finalizar esta sección quedan completamente especificadas las consideraciones de **Performance**, **Query Cache**, **Validación**, **Debug** y **Profiling** del Query Engine.

La infraestructura queda preparada para responder un elevado volumen de consultas de forma eficiente y determinista, proporcionando mecanismos de optimización, diagnóstico y medición que permiten escalar el Framework ECS sin comprometer su arquitectura ni el desacoplamiento entre Systems.
# 09 - QUERY ENGINE IMPLEMENTATION

# Parte 6 — Testing, Evolución Futura, Restricciones y Resumen Arquitectónico

---

# Objetivo

Esta sección define las consideraciones finales para la implementación del Query Engine, incluyendo su estrategia de testing, posibilidades de evolución futura, restricciones arquitectónicas y el resumen de su funcionamiento dentro del Framework ECS.

El objetivo es garantizar que el Query Engine permanezca estable, mantenible y preparado para evolucionar junto con el resto de la arquitectura sin romper la compatibilidad con los Systems existentes.

---

# Filosofía

El Query Engine constituye uno de los pilares fundamentales de comunicación del Framework ECS.

Toda su implementación debe poder verificarse mediante pruebas automatizadas.

La incorporación de nuevas funcionalidades no debe requerir modificaciones en la API pública utilizada por los Systems.

---

# Compatibilidad con Testing

El Query Engine debe poder probarse completamente de forma aislada.

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
- estabilidad;
- rendimiento básico;
- integración con el Runtime.

---

# Escenarios de Prueba

Como mínimo deberán contemplarse los siguientes casos.

---

# Inicialización

Verificar:

- creación del Query Engine;
- creación de todos los módulos internos;
- estado Ready;
- Registry vacío;
- Cache inicializado (si existe).

---

# Registro de Handlers

Registrar múltiples Query Handlers.

Verificar:

- almacenamiento correcto;
- ausencia de duplicados;
- resolución correcta.

---

# Eliminación de Handlers

Registrar y eliminar Handlers.

Verificar:

- eliminación correcta;
- consistencia del Registry;
- ausencia de referencias inválidas.

---

# Ejecución

Ejecutar múltiples Queries.

Verificar:

- localización correcta;
- ejecución inmediata;
- devolución del resultado esperado.

---

# Queries Sin Handler

Intentar ejecutar una Query no registrada.

Verificar:

- detección del error;
- comportamiento definido por el Runtime;
- mantenimiento de la consistencia interna.

---

# Resultados Vacíos

Ejecutar Queries cuyo resultado sea inexistente.

Verificar:

- ausencia de errores;
- devolución correcta de un resultado vacío válido.

---

# Query Cache

Si el Cache está habilitado:

Verificar:

- Cache Hit;
- Cache Miss;
- invalidación;
- actualización del contenido.

---

# Integración con Systems

Simular varios Systems ejecutando Queries.

Verificar:

- desacoplamiento;
- ausencia de referencias directas;
- resultados consistentes.

---

# Integración con Registries

Simular consultas sobre:

- Entity Registry;
- Component Registry;
- Resource Registry.

Verificar que todas las operaciones permanezcan en modo lectura.

---

# Pruebas de Rendimiento

Generar grandes volúmenes de consultas.

Ejemplo:

```text
100 000 Queries

↓

Execute

↓

Measure
```

Verificar:

- tiempo medio;
- consumo de memoria;
- estabilidad del Runtime.

---

# Pruebas de Errores

Simular:

- Handler inexistente;
- Query inválida;
- parámetros incorrectos;
- Runtime detenido.

Verificar que el Query Engine detecta correctamente cada situación.

---

# Evolución del Framework

La arquitectura debe permitir incorporar nuevas capacidades sin modificar la interfaz pública.

Entre ellas:

- políticas avanzadas de Cache;
- optimizaciones de búsqueda;
- métricas adicionales;
- instrumentación avanzada;
- herramientas de análisis;
- soporte para ejecución paralela controlada.

---

# Cache Avanzado

Versiones futuras podrán incorporar:

```text
Time Based Cache

Size Limited Cache

LRU Cache

Dependency Cache
```

La API utilizada por los Systems permanecerá inalterada.

---

# Optimización del Dispatcher

La implementación futura podrá incorporar:

- resolución más rápida;
- estructuras especializadas;
- optimizaciones específicas del Runtime.

Sin modificar el comportamiento observable.

---

# Profiling Avanzado

El Query Profiler podrá ampliarse para incluir:

- distribución temporal;
- coste acumulado por System;
- consultas más costosas;
- estadísticas históricas.

---

# Herramientas de Diagnóstico

Podrán desarrollarse herramientas capaces de representar:

```text
System

↓

Queries

↓

Handlers

↓

Execution Time
```

Facilitando el análisis completo del Runtime.

---

# Ejecución Paralela

Aunque la implementación inicial es secuencial, la arquitectura no debe impedir futuras estrategias de paralelización.

Cualquier evolución deberá preservar:

- determinismo;
- consistencia;
- ausencia de efectos secundarios.

---

# Restricciones

El Query Engine nunca debe:

- modificar Components;
- modificar Registries;
- crear entidades;
- destruir entidades;
- emitir Events;
- emitir Commands;
- serializar información;
- acceder al SceneTree;
- contener lógica de gameplay.

Debe permanecer exclusivamente como una infraestructura de consultas.

---

# Buenas Prácticas

Todo System debería:

- ejecutar únicamente las Queries necesarias;
- reutilizar resultados cuando sea posible;
- evitar consultas redundantes;
- mantener Queries pequeñas y especializadas;
- utilizar resultados inmutables.

---

# Antipatrones

Las siguientes prácticas deben evitarse.

---

## Queries con Efectos Secundarios

Incorrecto:

```text
Get Inventory

↓

Modify Inventory
```

Una Query nunca debe alterar el estado del Runtime.

---

## Queries Demasiado Grandes

Evitar consultas que intenten obtener una cantidad excesiva de información.

Ejemplo incorrecto:

```text
Get Entire World State
```

Las Queries deben ser específicas.

---

## Dependencias Implícitas

Un System nunca debe asumir detalles internos del Handler que responde una Query.

Toda interacción debe producirse exclusivamente mediante la interfaz pública del Query Engine.

---

## Abuso del Cache

No cachear información que cambia continuamente.

El Cache debe utilizarse únicamente cuando aporte un beneficio real sin comprometer la consistencia.

---

## Queries Repetidas

Evitar patrones como:

```text
Same Query

↓

Same Query

↓

Same Query
```

Durante un mismo flujo lógico.

Siempre que sea posible, reutilizar el resultado ya obtenido.

---

# Resumen Arquitectónico

El Query Engine está compuesto por los siguientes módulos especializados:

- Query Engine
- Query Registry
- Query Dispatcher
- Query Validator
- Query Cache
- Query Profiler

Cada módulo mantiene una única responsabilidad claramente definida.

---

# Flujo General

El funcionamiento completo puede resumirse conceptualmente como:

```text
System

↓

Create Query

↓

Query Engine

↓

Validate

↓

Locate Handler

↓

Execute

↓

Build Result

↓

Return Result

↓

Continue Execution
```

Este flujo representa el comportamiento oficial del Framework.

---

# Relación con el Resource Registry

El siguiente documento de esta fase será:

`10_RESOURCE_REGISTRY_IMPLEMENTATION.md`

Mientras el Query Engine coordina la comunicación síncrona entre Systems, el Resource Registry implementará la infraestructura responsable de cargar, registrar, resolver y proporcionar acceso a todos los Resources Data Driven utilizados por el Framework ECS.

Ambos subsistemas son independientes, pero complementarios dentro del Runtime.

---

# Resultado Esperado

Con este documento queda completamente especificada la implementación del **Query Engine** del Framework ECS de Survivors Lords.

La arquitectura establece un mecanismo de consultas síncronas, deterministas y de solo lectura, compuesto por módulos especializados para el registro, resolución, ejecución, validación, almacenamiento opcional en caché y profiling de Queries, integrándose de forma consistente con el Scheduler, los Registries y el resto del Runtime, proporcionando una base sólida y escalable para toda la comunicación de lectura entre Systems del proyecto.

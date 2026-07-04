# 06 - SYSTEM BASE

# Parte 1 — Arquitectura General y Ciclo de Vida

---

# Objetivo

Este documento define la implementación base de todos los Systems del Framework ECS de Survivors Lords.

El objetivo de `SystemBase` es proporcionar una infraestructura común para todos los Systems del proyecto, garantizando un ciclo de vida uniforme, integración consistente con el Runtime y una separación clara entre la infraestructura del Framework y la lógica de gameplay.

Este documento no define Systems concretos.

No describe mecánicas del juego.

No contiene lógica de negocio.

Define únicamente la implementación base sobre la que se construirán todos los Systems.

---

# Alcance

Este documento define:

- Arquitectura base de un System.
- Ciclo de vida.
- Inicialización.
- Estados.
- Integración con el Runtime.
- Contratos internos.
- Restricciones arquitectónicas.

No define:

- Scheduler.
- Event Bus.
- Query Engine.
- Gameplay.
- Components específicos.

---

# Filosofía

Dentro del Framework, un System representa una unidad de lógica especializada.

Cada System posee una única responsabilidad.

Toda la lógica del juego pertenece a Systems.

Los Systems nunca almacenan datos persistentes del mundo.

Los datos pertenecen a los Components.

---

# Responsabilidad Única

Un System es responsable exclusivamente de:

- procesar entidades;
- consultar Components;
- modificar Components;
- emitir Events;
- consumir Events;
- coordinar lógica relacionada con su responsabilidad.

Nada más.

---

# Qué NO es un System

Un System no es:

- un contenedor de datos;
- un Resource;
- un Manager global;
- un Singleton;
- un Node del gameplay;
- un controlador de escenas.

Su única función es ejecutar lógica.

---

# Arquitectura General

Todos los Systems heredan de una implementación común.

```text
                ISystem
                   │
                   ▼
               SystemBase
                   │
    ┌──────────────┼──────────────┬──────────────┬──────────────┐
    ▼              ▼              ▼              ▼
SystemMetadata
SystemContext
SystemState
SystemProfiler
SystemValidator
```

Cada módulo posee una responsabilidad claramente definida.

---

# SystemBase

## Responsabilidad

Representa la implementación común utilizada por todos los Systems.

Es responsable de:

- implementar `ISystem`;
- coordinar el ciclo de vida;
- mantener el estado interno;
- exponer la API común.

No implementa lógica de gameplay.

---

# SystemMetadata

## Responsabilidad

Contiene toda la información estática del System.

Ejemplos:

- nombre;
- identificador;
- descripción;
- fase de ejecución;
- prioridad;
- etiquetas;
- dependencias declaradas.

Esta información no cambia durante la ejecución.

---

# SystemContext

## Responsabilidad

Proporciona acceso controlado al Runtime.

Permite acceder a:

- Entity Registry;
- Component Registry;
- Event Bus;
- Query Engine;
- Resource Registry;
- otros contratos públicos definidos por el Framework.

Nunca expone implementaciones concretas.

---

# SystemState

## Responsabilidad

Representa el estado operativo del System.

Ejemplos conceptuales:

```text
Created

Initialized

Running

Paused

Disabled

Disposed
```

El Scheduler utilizará este estado para determinar si un System puede ejecutarse.

---

# SystemProfiler

## Responsabilidad

Recopilar métricas relacionadas con la ejecución del System.

Ejemplos:

- tiempo medio;
- tiempo máximo;
- llamadas;
- tiempo acumulado;
- desviación.

No modifica el comportamiento del System.

---

# SystemValidator

## Responsabilidad

Verificar que el System se encuentra en condiciones válidas para ejecutarse.

Ejemplos:

- dependencias satisfechas;
- contexto válido;
- Resources cargados;
- Queries preparadas.

---

# Herencia

Todos los Systems del proyecto deberán derivar de `SystemBase`.

Ejemplo conceptual:

```text
SystemBase

↓

MovementSystem

↓

CombatSystem

↓

InventorySystem

↓

BuildingSystem
```

Todos comparten la misma infraestructura.

---

# Identidad

Todo System posee una identidad única dentro del Runtime.

Esta identidad permanece constante durante toda la ejecución.

No depende del nombre de la clase.

---

# Instancia Única

Cada tipo de System tendrá una única instancia activa dentro del Runtime.

No deben existir múltiples instancias del mismo System ejecutándose simultáneamente, salvo que una futura extensión del Framework lo documente explícitamente.

---

# Ciclo de Vida

Todo System atraviesa el siguiente ciclo.

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

Running

↓

Disposed
```

Cada transición posee reglas específicas.

---

# Estado Created

El objeto existe.

Todavía no forma parte del Runtime.

No posee dependencias resueltas.

No debe ejecutar lógica.

---

# Estado Initialized

El Bootstrap resolvió las dependencias necesarias.

El System dispone de un contexto válido.

Todavía no participa del Game Loop.

---

# Estado Ready

El System finalizó correctamente su preparación.

Puede ser registrado por el Scheduler.

Todavía no ejecuta lógica.

---

# Estado Running

El Scheduler puede ejecutar el System durante cada ciclo correspondiente.

Este es el estado operativo normal.

---

# Estado Paused

El System permanece cargado.

Conserva su estado interno.

No recibe ciclos de ejecución.

Puede volver al estado Running sin reconstruirse.

---

# Estado Disposed

El System deja de formar parte del Runtime.

Todas sus referencias internas deben liberarse.

No puede volver a ejecutarse sin una nueva inicialización.

---

# Transiciones Válidas

Las transiciones permitidas son:

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

Running

↓

Disposed
```

No deben existir transiciones arbitrarias.

Ejemplo inválido:

```text
Created

↓

Running
```

Toda transición debe respetar el ciclo de vida definido.

---

# Inicialización

La inicialización de un System ocurre exclusivamente durante el Bootstrap.

Nunca debe inicializarse automáticamente al construirse.

Esto garantiza un orden determinista entre todos los subsistemas.

---

# Destrucción

La destrucción de un System ocurre durante el cierre del Runtime.

El System debe liberar:

- referencias;
- suscripciones;
- recursos temporales;
- buffers internos.

Nunca debe destruir entidades ni Components durante su propio proceso de liberación.

---

# Independencia

Cada System debe poder desarrollarse, probarse y mantenerse de forma independiente.

No debe requerir conocimiento interno de otros Systems.

Toda colaboración ocurre mediante:

- Events;
- Queries;
- Interfaces públicas.

---

# Integración con el Runtime

El Runtime administra el ciclo de vida de los Systems.

Los Systems nunca controlan directamente su propia ejecución.

Toda coordinación corresponde al Scheduler y al Bootstrap.

---

# Garantías

Toda implementación derivada de `SystemBase` debe garantizar que:

- respeta el ciclo de vida definido;
- mantiene un estado consistente;
- no ejecuta lógica fuera del Scheduler;
- utiliza únicamente contratos públicos del Framework;
- permanece desacoplada del resto de los Systems.

---

# Resultado Esperado

Al finalizar esta primera parte queda definida la arquitectura general de `SystemBase` y el ciclo de vida común de todos los Systems del Framework.

Esta infraestructura proporciona una base uniforme para la ejecución de la lógica del juego, manteniendo un modelo consistente de estados, responsabilidades y dependencias que será utilizado por el Scheduler y el resto de los subsistemas del Runtime.
# 06 - SYSTEM BASE

# Parte 2 — Ejecución, Estados y Validaciones

---

# Objetivo

Esta sección define cómo se ejecuta un System dentro del Runtime, cuáles son sus estados operativos y qué validaciones deben realizarse antes, durante y después de cada ciclo de ejecución.

El objetivo es garantizar que todos los Systems se comporten de manera uniforme, independientemente de la lógica específica que implementen.

---

# Filosofía

Un System nunca ejecuta lógica por iniciativa propia.

Toda ejecución es iniciada por el Scheduler.

Esto garantiza:

- orden determinista;
- sincronización entre Systems;
- compatibilidad con Multiplayer;
- facilidad para depuración;
- facilidad para profiling.

---

# Ciclo de Ejecución

Conceptualmente, cada ejecución sigue el siguiente flujo.

```text
Scheduler

↓

Validate System

↓

Prepare Execution

↓

Execute Logic

↓

Finalize Execution

↓

Profiler Update
```

Cada etapa debe completarse correctamente antes de iniciar la siguiente.

---

# Control de Ejecución

Los Systems no contienen bucles propios.

Ejemplo incorrecto:

```text
while true:
    process()
```

Ejemplo correcto:

```text
Scheduler

↓

Execute(System)
```

El Scheduler controla completamente la frecuencia de ejecución.

---

# Frecuencia

La frecuencia de ejecución no pertenece al System.

Puede depender de:

- fase del Scheduler;
- configuración;
- prioridades;
- estado del Runtime.

El System permanece completamente agnóstico a estos detalles.

---

# Método Principal

Todo System expone un único punto de entrada para la ejecución lógica.

Conceptualmente:

```text
Execute()
```

Este método representa el ciclo completo de trabajo del System.

No debe ser invocado directamente por otros Systems.

---

# Flujo Interno

Durante una ejecución normal:

```text
Validate

↓

Read Queries

↓

Read Components

↓

Process Logic

↓

Write Components

↓

Emit Events

↓

Finish
```

El orden puede variar ligeramente según el tipo de System, pero siempre debe mantener consistencia.

---

# Lectura

Los Systems pueden consultar:

- Queries;
- Components;
- Resources;
- estado del Runtime.

Las lecturas nunca deben modificar el estado del mundo.

---

# Escritura

Cuando un System modifica datos:

- únicamente modifica Components;
- nunca modifica directamente otro System;
- nunca altera el Runtime fuera de los contratos públicos.

---

# Eventos

Los Systems pueden emitir eventos durante su ejecución.

Conceptualmente:

```text
Execute

↓

State Changed

↓

Emit Event
```

Los eventos se entregan mediante el Event Bus.

Nunca mediante referencias directas.

---

# Estados Operativos

Además del ciclo de vida general, cada System posee un estado operativo.

Los estados permitidos son:

```text
Ready

Running

Paused

Disabled

Error
```

---

# Ready

El System está preparado para ejecutarse.

Todavía no ha comenzado el ciclo actual.

---

# Running

El Scheduler está ejecutando actualmente el System.

Mientras permanezca en este estado:

- no debe iniciarse una segunda ejecución;
- no deben modificarse sus dependencias.

---

# Paused

El System permanece cargado.

No ejecuta lógica.

Conserva todo su estado interno.

Puede volver a Running inmediatamente.

---

# Disabled

El System ha sido deshabilitado.

El Scheduler lo omite completamente.

No consume tiempo de ejecución.

Puede volver a habilitarse mediante los mecanismos definidos por el Runtime.

---

# Error

El System detectó una condición que impide continuar de forma segura.

El Scheduler decidirá cómo gestionar esta situación.

El propio System no debe intentar recuperarse modificando el estado global del Runtime.

---

# Reentrada

Los Systems no son reentrantes.

Nunca debe producirse:

```text
Execute()

↓

Execute()
```

sobre la misma instancia.

El Scheduler debe impedir este escenario.

---

# Validaciones Previas

Antes de ejecutar un System, el `SystemValidator` debe comprobar como mínimo:

- contexto válido;
- estado Running permitido;
- dependencias satisfechas;
- Queries disponibles;
- Resources requeridos.

Si alguna validación falla, la ejecución no debe comenzar.

---

# Validación del Contexto

El `SystemContext` debe contener referencias válidas a todos los contratos requeridos.

Ejemplo conceptual:

```text
Entity Registry

✓

Component Registry

✓

Query Engine

✓

Event Bus

✓
```

---

# Validación de Dependencias

Si un System declara dependencias arquitectónicas, estas deben encontrarse disponibles.

Ejemplo conceptual:

```text
MovementSystem

↓

Requires Transform Query

↓

Available
```

El Validator verifica esta condición antes de cada ejecución cuando sea necesario.

---

# Validación de Estado

Solo un System en estado `Running` puede ejecutar lógica.

Estados como:

- Created;
- Initialized;
- Ready;
- Paused;
- Disabled;
- Disposed;

no deben ejecutar el método principal.

---

# Validación de Queries

Las Queries requeridas deben encontrarse correctamente registradas.

Si una Query crítica no está disponible:

- el Validator debe detectar el problema;
- la ejecución debe cancelarse de forma controlada.

---

# Validación de Resources

Cuando un System depende de Resources obligatorios:

```text
System

↓

Resource Registry

↓

Resource Available
```

La ausencia de dichos Resources debe impedir la ejecución.

---

# Errores de Validación

Las validaciones nunca deben producir estados parcialmente ejecutados.

Si una comprobación falla:

```text
Validate

↓

Failure

↓

Cancel Execution
```

El estado del mundo permanece inalterado.

---

# Operaciones Atómicas

Cada ciclo de ejecución debe considerarse una operación lógica completa.

Las validaciones deben finalizar antes de modificar cualquier Component.

Esto reduce la posibilidad de inconsistencias.

---

# Excepciones

Los errores inesperados deben propagarse al Scheduler o al sistema de gestión de errores definido por el Runtime.

Un System no debe capturar silenciosamente excepciones que comprometan la consistencia del Framework.

---

# Cancelación

El Scheduler puede decidir no ejecutar un System.

Ejemplos:

- Runtime detenido;
- fase omitida;
- System deshabilitado;
- dependencia incumplida.

El System nunca interpreta esta situación como un error.

---

# Reinicio

Un System pausado puede volver a ejecutarse sin reconstruir su instancia.

Conceptualmente:

```text
Paused

↓

Running
```

La transición debe preservar el estado interno cuando corresponda.

---

# Consistencia

Durante toda la ejecución deben mantenerse las siguientes reglas:

- una única ejecución activa por instancia;
- validaciones previas obligatorias;
- ausencia de modificaciones fuera del contrato público;
- estado interno consistente;
- determinismo entre ejecuciones equivalentes.

---

# Reglas de Implementación

Toda implementación derivada de `SystemBase` debe garantizar:

- un único punto de entrada para la lógica;
- ejecución controlada exclusivamente por el Scheduler;
- validaciones centralizadas mediante `SystemValidator`;
- estados operativos bien definidos;
- ausencia de reentrada;
- cancelación segura cuando una validación falle.

---

# Resultado Esperado

Al finalizar esta sección queda completamente definido el modelo de ejecución de un System dentro del Runtime.

Todos los Systems comparten un mismo flujo de validación, ejecución y finalización, permitiendo que el Scheduler controle el orden y la frecuencia de trabajo de forma determinista, mientras el `SystemValidator` garantiza que cada ciclo comienza únicamente cuando se cumplen todas las condiciones necesarias para una ejecución segura y consistente.
# 06 - SYSTEM BASE

# Parte 3 — Integración con el Framework

---

# Objetivo

Esta sección define cómo se integra un System con el resto del Framework ECS.

El objetivo es establecer un conjunto uniforme de reglas para garantizar que todos los Systems colaboren entre sí sin introducir dependencias directas ni acoplamiento innecesario.

Los Systems representan la capa de lógica del Runtime.

Toda interacción con el resto de la arquitectura debe realizarse mediante contratos públicos.

---

# Filosofía

Un System nunca trabaja de forma aislada.

Interactúa continuamente con:

- ECS Context
- Entity Registry
- Component Registry
- Scheduler
- Event Bus
- Query Engine
- Resource Registry

Sin embargo, dicha interacción siempre ocurre mediante interfaces.

Nunca mediante implementaciones concretas.

---

# Integración con el Bootstrap

Durante el Bootstrap cada System sigue el siguiente flujo conceptual.

```text
Create System

↓

Inject Context

↓

Resolve Dependencies

↓

Initialize

↓

Register in Scheduler

↓

Ready
```

El Bootstrap es el único responsable de construir Systems.

---

# Inyección del Contexto

Todo System recibe un único contexto común.

```text
IECSContext
```

A través de dicho contexto obtiene acceso a todos los servicios del Runtime.

Esto evita dependencias individuales.

---

# System Context

El System Context actúa como fachada del Runtime.

Conceptualmente proporciona acceso a:

```text
Entity Registry

Component Registry

Event Bus

Query Engine

Resource Registry

Save Service

Multiplayer Service

Debug Service
```

La implementación concreta permanece oculta.

---

# Integración con el Scheduler

El Scheduler es el único responsable de ejecutar Systems.

Nunca debe existir código similar a:

```text
CombatSystem.execute()

MovementSystem.execute()
```

desde otro System.

Siempre ocurre:

```text
Scheduler

↓

Execute System
```

---

# Orden de Ejecución

El orden nunca depende del código de los Systems.

Es responsabilidad exclusiva del Scheduler.

Los Systems únicamente declaran metadatos.

Ejemplo:

```text
Priority

Execution Phase

Dependencies
```

La resolución pertenece al Scheduler.

---

# Integración con el Event Bus

Todo intercambio de información asíncrona ocurre mediante el Event Bus.

Un System puede:

- emitir eventos;
- suscribirse a eventos;
- cancelar suscripciones durante la liberación.

Nunca conoce quién consume dichos eventos.

---

# Publicación de Eventos

Conceptualmente:

```text
Combat System

↓

Damage Applied

↓

Event Bus

↓

Subscribers
```

El Combat System desconoce completamente los consumidores.

---

# Consumo de Eventos

Los eventos recibidos deben tratarse como entradas externas.

Nunca debe asumirse:

- orden de recepción;
- cantidad de receptores;
- existencia de consumidores.

---

# Integración con el Query Engine

Los Systems obtienen entidades mediante Queries.

Conceptualmente:

```text
Movement System

↓

Transform + Velocity

↓

Query Engine

↓

Matching Entities
```

Los Systems nunca recorren directamente todos los Components.

---

# Uso de Queries

Las Queries deben representar únicamente criterios de selección.

No contienen lógica.

No modifican datos.

Su única responsabilidad consiste en localizar entidades compatibles.

---

# Lectura de Components

Una vez obtenidos los resultados de una Query:

```text
Query Result

↓

Component Registry

↓

Read Components
```

El acceso siempre ocurre mediante contratos públicos.

---

# Escritura de Components

Cuando un System necesita modificar datos:

```text
Component Registry

↓

Write Component

↓

Storage Updated
```

Nunca modifica directamente el almacenamiento interno.

---

# Integración con el Entity Registry

Los Systems pueden:

- crear entidades;
- destruir entidades;
- validar entidades.

Siempre mediante:

```text
IEntityRegistry
```

Nunca administran identificadores.

Nunca manipulan generaciones.

---

# Integración con el Resource Registry

Los datos de configuración deben obtenerse exclusivamente desde Resources.

Conceptualmente:

```text
Movement System

↓

MovementConfig

↓

Resource Registry
```

Los Systems nunca almacenan configuraciones duplicadas.

---

# Integración con Save

Los Systems no escriben partidas.

No serializan datos.

No conocen formatos de archivo.

Únicamente modifican Components.

El Save Pipeline obtiene posteriormente dichos datos.

---

# Integración con Multiplayer

Los Systems deben ser compatibles con un modelo Server Authoritative.

Conceptualmente:

```text
Server

↓

Execute Systems

↓

Replicate Changes

↓

Clients
```

Los Systems nunca implementan replicación.

---

# Autoridad

Un System nunca decide:

- quién posee autoridad;
- cuándo sincronizar;
- cómo enviar paquetes.

Estas responsabilidades pertenecen al Multiplayer Pipeline.

---

# Integración con Debug

Las herramientas de Debug pueden consultar:

- estado;
- métricas;
- tiempo de ejecución;
- dependencias;
- Queries utilizadas.

Nunca modifican la lógica del System.

---

# Integración con Profiling

El Profiler registra información como:

```text
Execution Count

Average Time

Maximum Time

Minimum Time

Total Time

Execution Frequency
```

El propio System nunca interpreta estas métricas.

---

# Integración con Testing

Todos los Systems deben poder ejecutarse utilizando implementaciones simuladas del Runtime.

Ejemplo:

```text
Mock Entity Registry

Mock Component Registry

Mock Event Bus

Mock Query Engine
```

Esto permite pruebas completamente aisladas.

---

# Desacoplamiento

Nunca debe existir código similar a:

```text
CombatSystem.attack()

InventorySystem.add_item()

WeatherSystem.update()
```

Los Systems nunca se llaman entre sí.

Toda colaboración ocurre mediante:

- Events;
- Queries;
- Components;
- Interfaces.

---

# Dependencias Permitidas

Un System puede depender de:

- IECSContext
- IEntityRegistry
- IComponentRegistry
- IQueryEngine
- IEventBus
- IResourceRegistry
- Interfaces oficiales del Framework

Nunca debe depender de:

- otros Systems;
- escenas;
- nodos de gameplay;
- UI;
- Singletons específicos del juego.

---

# Garantías Arquitectónicas

Toda implementación basada en `SystemBase` debe garantizar que:

- nunca ejecuta lógica fuera del Scheduler;
- nunca accede directamente al almacenamiento interno;
- nunca mantiene referencias a otros Systems;
- utiliza únicamente contratos públicos;
- permanece completamente desacoplada del resto del Runtime.

---

# Flujo Completo de Integración

Conceptualmente, un ciclo completo de trabajo es:

```text
Scheduler

↓

Execute System

↓

Query Engine

↓

Matching Entities

↓

Component Registry

↓

Read Components

↓

Process Logic

↓

Write Components

↓

Emit Events

↓

Finish
```

Cada subsistema conserva su responsabilidad específica.

---

# Resultado Esperado

Al finalizar esta sección queda completamente definida la integración de `SystemBase` con el resto del Framework ECS.

Todos los Systems operan sobre una infraestructura común basada en interfaces públicas, manteniendo un alto grado de desacoplamiento, compatibilidad con Multiplayer y Save, integración con el Scheduler y el Event Bus, y una separación estricta entre la lógica de juego y la infraestructura del Runtime.
# 06 - SYSTEM BASE

# Parte 4 — Rendimiento, Profiling, Depuración y Consideraciones de Implementación

---

# Objetivo

Esta sección define las consideraciones relacionadas con el rendimiento, profiling, depuración, testing y evolución futura de todos los Systems del Framework.

Estas reglas son comunes para cualquier implementación derivada de `SystemBase`.

Su objetivo es garantizar un comportamiento uniforme, escalable y fácil de mantener durante toda la vida del proyecto.

---

# Filosofía

El Framework puede contener decenas de Systems ejecutándose continuamente.

Por este motivo, cada System debe diseñarse para ser:

- determinista;
- desacoplado;
- predecible;
- eficiente;
- fácilmente perfilable.

El rendimiento global del Runtime depende de la suma del rendimiento individual de todos los Systems.

---

# Principios de Rendimiento

Un System debe dedicar la mayor parte de su tiempo a procesar lógica.

No debe desperdiciar tiempo en:

- búsquedas innecesarias;
- validaciones repetidas;
- asignaciones constantes de memoria;
- consultas redundantes.

---

# Uso de Queries

Las Queries representan el mecanismo principal para localizar entidades.

Un System nunca debe recorrer todas las entidades del mundo para encontrar las que necesita.

Incorrecto:

```text
For Every Entity

↓

Check Components

↓

Continue
```

Correcto:

```text
Query Engine

↓

Matching Entities

↓

Process
```

---

# Acceso a Components

Siempre que sea posible:

- obtener referencias una sola vez;
- reutilizar resultados durante la ejecución;
- evitar consultas repetidas al Registry.

---

# Resources

Los Resources deben considerarse datos de solo lectura.

Un System puede consultarlos tantas veces como sea necesario, pero nunca modificarlos.

---

# Asignaciones Dinámicas

Durante la ejecución normal de un System deben evitarse:

- creación constante de Arrays;
- creación continua de Dictionaries;
- construcción innecesaria de objetos temporales;
- reservas repetidas de memoria.

Siempre que sea posible deberán reutilizarse estructuras existentes.

---

# Estado Interno

El estado interno de un System debe mantenerse al mínimo indispensable.

Los datos persistentes del mundo pertenecen exclusivamente a los Components.

Los Systems únicamente pueden almacenar información relacionada con su propia ejecución.

Ejemplos:

- temporizadores internos;
- cachés temporales;
- estadísticas;
- buffers reutilizables.

---

# Cachés

Un System puede mantener cachés únicamente cuando:

- reducen significativamente el coste de ejecución;
- pueden invalidarse correctamente;
- no duplican el estado del mundo.

Los cachés nunca deben convertirse en una segunda fuente de verdad.

---

# Determinismo

Dos ejecuciones equivalentes deben producir exactamente el mismo resultado.

El comportamiento nunca debe depender de:

- velocidad del hardware;
- orden de memoria;
- plataforma;
- número de FPS.

Este principio es especialmente importante para Multiplayer y Replay.

---

# Profiling

Todo System debe integrarse con el `SystemProfiler`.

Como mínimo deberán recopilarse las siguientes métricas:

- tiempo total;
- tiempo medio;
- tiempo mínimo;
- tiempo máximo;
- cantidad de ejecuciones;
- tiempo acumulado.

---

# Métricas Opcionales

La implementación podrá ampliar las métricas con información como:

- entidades procesadas;
- Components leídos;
- Components modificados;
- eventos emitidos;
- eventos recibidos;
- Queries ejecutadas.

Estas métricas facilitan el análisis del comportamiento del Runtime.

---

# Instrumentación

La recopilación de métricas debe poder habilitarse y deshabilitarse.

Cuando esté desactivada:

- no debe modificar el comportamiento;
- el coste adicional debe ser mínimo.

---

# Logging

Los Systems no deben registrar información continuamente durante la ejecución normal.

El Logging debe reservarse para:

- errores críticos;
- advertencias relevantes;
- estados inesperados;
- fallos de inicialización.

---

# Depuración

Las herramientas de Debug deben poder consultar información de cualquier System.

Ejemplos:

- estado actual;
- prioridad;
- fase de ejecución;
- tiempo de ejecución;
- dependencias;
- Queries utilizadas;
- eventos procesados.

Las herramientas nunca deben modificar directamente el estado interno.

---

# Validaciones en Debug

Durante el desarrollo pueden habilitarse validaciones adicionales.

Ejemplos:

- Queries inexistentes;
- Components faltantes;
- Resources no cargados;
- dependencias incumplidas;
- ejecución fuera del Scheduler.

Estas comprobaciones ayudan a detectar errores tempranamente.

---

# Modo Release

En compilaciones Release podrán omitirse determinadas validaciones costosas.

Sin embargo, deberán mantenerse aquellas necesarias para preservar la consistencia del Runtime.

---

# Compatibilidad con Testing

Todo System debe poder ejecutarse en aislamiento.

Para ello, todas sus dependencias deberán obtenerse mediante interfaces.

Ejemplo:

```text
Mock Context

↓

Mock Registries

↓

Execute System

↓

Validate Results
```

---

# Escenarios de Prueba

Como mínimo deberán contemplarse los siguientes casos.

## Inicialización

Verificar:

- contexto válido;
- estado Ready;
- dependencias resueltas.

---

## Ejecución

Verificar:

- ejecución correcta;
- modificación esperada de Components;
- emisión de eventos cuando corresponda.

---

## Pausa

Verificar:

- el Scheduler deja de ejecutar el System;
- el estado interno permanece consistente.

---

## Reactivación

Verificar:

- el System vuelve a Running;
- continúa funcionando sin reinicialización.

---

## Finalización

Verificar:

- liberación de referencias;
- cancelación de suscripciones;
- limpieza de buffers temporales.

---

## Errores

Simular:

- Queries inválidas;
- Components inexistentes;
- Resources faltantes.

Verificar que:

- la ejecución se cancela correctamente;
- el Runtime permanece consistente.

---

# Evolución del Framework

La arquitectura de `SystemBase` debe permitir incorporar futuras capacidades sin modificar el contrato `ISystem`.

Ejemplos:

- ejecución paralela;
- ejecución distribuida;
- Systems condicionales;
- Systems dinámicos;
- ejecución por demanda;
- perfiles de actualización;
- optimizaciones específicas para servidor o cliente.

Todas estas mejoras deberán ser transparentes para los Systems ya existentes.

---

# Restricciones de Implementación

Una implementación derivada de `SystemBase` no debe:

- acceder directamente al SceneTree;
- mantener referencias a Nodes de gameplay;
- comunicarse directamente con otros Systems;
- modificar Registries internos;
- serializar datos;
- gestionar paquetes de red;
- depender de clases concretas del Framework.

---

# Buenas Prácticas

Todo System debería:

- tener una única responsabilidad;
- ser pequeño y especializado;
- utilizar Queries específicas;
- minimizar el trabajo por actualización;
- emitir únicamente los eventos necesarios;
- documentar claramente sus dependencias;
- mantener bajo acoplamiento con el resto del Runtime.

---

# Antipatrones

Las siguientes prácticas deben evitarse.

## System Dios

Un único System que concentra múltiples responsabilidades.

---

## Comunicación Directa

Un System llamando métodos de otro System.

---

## Estado Compartido

Compartir datos internos entre Systems.

---

## Lógica en Components

Mover lógica desde un System hacia un Component.

---

## Dependencias Ocultas

Acceder a Singletons o servicios globales sin utilizar el `IECSContext`.

---

## Queries Genéricas

Crear Queries excesivamente amplias que procesen entidades innecesarias.

---

# Resumen Arquitectónico

`SystemBase` constituye la infraestructura común sobre la que se implementan todos los Systems del Framework.

Su diseño proporciona:

- un ciclo de vida uniforme;
- validaciones centralizadas;
- integración con el Runtime;
- soporte para profiling;
- compatibilidad con testing;
- bajo acoplamiento;
- escalabilidad.

Gracias a esta infraestructura, todos los Systems comparten un comportamiento consistente sin imponer restricciones sobre la lógica específica que implementan.

---

# Relación con el Scheduler

El siguiente documento de esta fase será:

`07_SCHEDULER_IMPLEMENTATION.md`

Toda la arquitectura definida para `SystemBase` está diseñada para ser administrada por el Scheduler.

El Scheduler será responsable de:

- ordenar Systems;
- resolver dependencias;
- ejecutar fases;
- controlar frecuencias;
- administrar pausas;
- coordinar la ejecución completa del Runtime.

---

# Resultado Esperado

Con este documento queda completamente especificada la implementación base de los Systems del Framework ECS de Survivors Lords.

`SystemBase` proporciona una infraestructura uniforme, desacoplada y preparada para soportar decenas de Systems especializados, integrándose de forma consistente con el Scheduler, los Registries, el Event Bus, el Query Engine y el resto del Runtime, manteniendo un diseño extensible y preparado para futuras optimizaciones del Framework.
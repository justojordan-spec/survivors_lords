# 07 - SCHEDULER IMPLEMENTATION

# Parte 1 — Arquitectura General

---

# Objetivo

Este documento define la implementación del Scheduler del Framework ECS de Survivors Lords.

El Scheduler constituye el núcleo de ejecución del Runtime.

Su responsabilidad es coordinar la ejecución completa de todos los Systems respetando el orden, las dependencias, las fases de ejecución y las restricciones arquitectónicas definidas por el Framework.

No contiene gameplay.

No implementa lógica de negocio.

No interpreta Components.

No interpreta Events.

Únicamente coordina la ejecución del Runtime.

---

# Alcance

Este documento define:

- Arquitectura del Scheduler.
- Pipeline de ejecución.
- Planificación de Systems.
- Resolución de dependencias.
- Barreras de sincronización.
- Deferred Commands.
- Gestión del tiempo.
- Integración con el Runtime.
- Profiling.
- Validaciones.

No define:

- Gameplay.
- Systems concretos.
- Queries.
- Save.
- Multiplayer.

---

# Filosofía

El Scheduler representa la autoridad absoluta sobre la ejecución del Runtime.

Ningún System controla cuándo ejecutarse.

Ningún System ejecuta otro System.

Ningún Registry modifica el orden de ejecución.

Todo ocurre bajo el control del Scheduler.

---

# Principios

Toda implementación del Scheduler debe cumplir los siguientes principios.

- Determinista.
- Desacoplada.
- Escalable.
- Modular.
- Predecible.
- Server Authoritative Ready.
- Compatible con paralelización futura.

---

# Responsabilidad Única

El Scheduler es responsable exclusivamente de:

- ejecutar Systems;
- respetar el orden de ejecución;
- aplicar barreras;
- sincronizar operaciones diferidas;
- controlar el tiempo;
- validar el Runtime antes de cada ciclo.

Nada más.

---

# Qué NO es el Scheduler

El Scheduler no:

- contiene gameplay;
- administra entidades;
- almacena Components;
- procesa Queries;
- interpreta Events;
- serializa datos;
- sincroniza Multiplayer.

Únicamente coordina.

---

# Arquitectura General

Internamente el Scheduler se divide en varios módulos especializados.

```text
                     IScheduler
                          │
                          ▼
                     Scheduler
──────────────────────────────────────────────
                          │
      ┌───────────┬──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
      ▼           ▼              ▼              ▼              ▼              ▼
ExecutionPipeline
ExecutionPlanner
DependencyResolver
CommandBuffer
TimeManager
ExecutionProfiler
ExecutionValidator
```

El Scheduler actúa únicamente como fachada.

---

# Scheduler

## Responsabilidad

Es la implementación pública del contrato `IScheduler`.

Coordina todos los módulos internos.

Nunca ejecuta directamente la lógica de un System.

Nunca calcula dependencias.

Nunca administra tiempo.

Toda responsabilidad se delega.

---

# Execution Pipeline

## Responsabilidad

Define el flujo completo de un Frame del Runtime.

Controla:

- inicio del Frame;
- fases de ejecución;
- barreras;
- sincronización;
- finalización.

No decide el orden de los Systems.

---

# Execution Planner

## Responsabilidad

Construye el plan de ejecución del Frame.

Su trabajo consiste en determinar:

- qué Systems deben ejecutarse;
- en qué orden;
- en qué fase;
- bajo qué condiciones.

No ejecuta lógica.

---

# Dependency Resolver

## Responsabilidad

Analiza las dependencias declaradas por los Systems.

Construye un grafo dirigido.

Detecta:

- ciclos;
- referencias inválidas;
- dependencias faltantes.

Su salida es utilizada por el Execution Planner.

---

# Command Buffer

## Responsabilidad

Almacena operaciones diferidas generadas por los Systems.

Ejemplos:

- Create Entity
- Destroy Entity
- Add Component
- Remove Component

Estas operaciones nunca se aplican inmediatamente.

---

# Time Manager

## Responsabilidad

Centraliza toda la administración del tiempo del Runtime.

Gestiona:

- delta time;
- fixed timestep;
- acumuladores;
- ticks;
- pausas;
- escalado temporal.

Ningún System calcula tiempo por su cuenta.

---

# Execution Profiler

## Responsabilidad

Recopilar estadísticas relacionadas con la ejecución global.

Ejemplos:

- tiempo por fase;
- tiempo por System;
- tiempo del Frame;
- utilización;
- rendimiento acumulado.

---

# Execution Validator

## Responsabilidad

Verificar que el Runtime se encuentra en condiciones válidas antes de iniciar un ciclo de ejecución.

Ejemplos:

- Scheduler inicializado;
- dependencias resueltas;
- Runtime consistente;
- Systems válidos;
- Queries disponibles.

---

# Relación con SystemBase

Todo System registrado en el Runtime es administrado exclusivamente por el Scheduler.

Conceptualmente:

```text
SystemBase

↓

Scheduler Registration

↓

Execution Planning

↓

Execution
```

Los Systems nunca controlan su propia frecuencia de actualización.

---

# Registro de Systems

Durante el Bootstrap:

```text
Create Systems

↓

Initialize

↓

Validate

↓

Register Scheduler

↓

Ready
```

El Scheduler únicamente administra Systems correctamente inicializados.

---

# Ciclo de Vida

El Scheduler posee un ciclo de vida propio.

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

Cada transición posee reglas específicas.

---

# Estado Created

El Scheduler existe.

Todavía no administra Systems.

No posee un plan de ejecución.

---

# Estado Initialized

Todos los módulos internos fueron creados.

Todavía no comienza el Runtime.

---

# Estado Ready

Las dependencias fueron resueltas.

Los Systems fueron registrados.

El Runtime puede comenzar.

---

# Estado Running

El Scheduler controla completamente la ejecución del Framework.

Todos los Frames atraviesan su Pipeline.

---

# Estado Paused

El Scheduler suspende la ejecución de Systems.

Mantiene:

- Runtime;
- Registries;
- estado interno.

Puede reanudar la ejecución posteriormente.

---

# Estado Stopped

El Runtime deja de ejecutar nuevos Frames.

No se aceptan nuevas solicitudes de ejecución.

---

# Estado Disposed

Todos los recursos internos fueron liberados.

El Scheduler deja de existir.

---

# Garantías

Toda implementación debe garantizar:

- un único Scheduler activo;
- un único Pipeline;
- una única autoridad sobre la ejecución;
- orden determinista;
- ausencia de reentrada.

---

# Separación de Responsabilidades

Cada módulo posee una única responsabilidad.

| Módulo | Responsabilidad |
|----------|----------------|
| Scheduler | API pública |
| ExecutionPipeline | Flujo del Frame |
| ExecutionPlanner | Orden de ejecución |
| DependencyResolver | Dependencias |
| CommandBuffer | Operaciones diferidas |
| TimeManager | Tiempo |
| ExecutionProfiler | Métricas |
| ExecutionValidator | Validaciones |

Ningún módulo debe invadir responsabilidades ajenas.

---

# Integración con el Runtime

El Scheduler forma parte del Runtime desde el Bootstrap.

Permanece activo durante toda la ejecución.

Nunca debe recrearse mientras el Runtime permanezca activo.

---

# Dependencias Permitidas

El Scheduler puede depender de:

- IECSContext
- ISystem
- Interfaces internas del Runtime

Nunca debe depender de:

- gameplay;
- Components específicos;
- Systems concretos;
- escenas;
- UI;
- lógica del juego.

---

# Objetivos Arquitectónicos

La implementación del Scheduler debe permitir:

- cientos de Systems;
- miles de entidades;
- ejecución determinista;
- Multiplayer Server Authoritative;
- Replay determinista;
- futuras optimizaciones;
- paralelización.

---

# Resultado Esperado

Al finalizar esta primera parte queda definida la arquitectura general del Scheduler.

El Scheduler se establece como la autoridad única sobre la ejecución del Runtime, delegando responsabilidades específicas en módulos especializados para el Pipeline de ejecución, planificación, resolución de dependencias, gestión del tiempo, operaciones diferidas, profiling y validación.

Esta separación proporciona una base robusta, escalable y preparada para la implementación del resto de la infraestructura del Framework ECS.
# 07 - SCHEDULER IMPLEMENTATION

# Parte 2 — Execution Pipeline

---

# Objetivo

Esta sección define el flujo completo de ejecución del Runtime.

El **Execution Pipeline** representa la secuencia oficial mediante la cual el Scheduler coordina todos los Systems durante cada Frame.

Su objetivo es garantizar:

- determinismo;
- consistencia;
- sincronización;
- separación de responsabilidades;
- compatibilidad con Multiplayer;
- compatibilidad con Replay;
- preparación para paralelización futura.

El Pipeline constituye la "columna vertebral" del Runtime.

---

# Filosofía

Todo Frame del juego debe recorrer exactamente el mismo Pipeline.

Los Systems nunca alteran el Pipeline.

Los Systems únicamente ejecutan la lógica correspondiente a su fase.

La estructura del Pipeline pertenece exclusivamente al Scheduler.

---

# Principios

El Pipeline debe cumplir:

- orden fijo;
- fases claramente definidas;
- barreras explícitas;
- operaciones diferidas;
- sincronización consistente;
- repetibilidad absoluta.

---

# Flujo General

Todo Frame sigue la siguiente estructura conceptual.

```text
Begin Frame

↓

Update Time

↓

Validate Runtime

↓

Pre Update

↓

Simulation

↓

Post Update

↓

Late Update

↓

Flush Commands

↓

Flush Events

↓

Finalize Frame

↓

End Frame
```

Cada etapa posee una responsabilidad única.

---

# Pipeline Inmutable

La secuencia de fases debe permanecer constante durante la ejecución del Runtime.

No deben agregarse ni eliminarse fases dinámicamente.

Esto garantiza un comportamiento determinista.

---

# Begin Frame

Representa el inicio oficial de un nuevo Frame.

Responsabilidades:

- registrar inicio;
- preparar métricas;
- reiniciar información temporal;
- comenzar el profiling del Frame.

Todavía no se ejecuta ningún System.

---

# Update Time

El `TimeManager` actualiza:

- delta time;
- tiempo acumulado;
- fixed timestep;
- ticks pendientes;
- escalado temporal.

Todos los Systems utilizarán posteriormente esta información.

---

# Validate Runtime

Antes de ejecutar cualquier System, el `ExecutionValidator` verifica que:

- Runtime válido;
- Scheduler activo;
- Systems registrados;
- Queries disponibles;
- Registries consistentes;
- Resources cargados.

Si alguna validación crítica falla, el Frame puede cancelarse.

---

# Fases de Ejecución

El Runtime divide la lógica en fases claramente diferenciadas.

Conceptualmente:

```text
Pre Update

↓

Simulation

↓

Post Update

↓

Late Update
```

Cada System pertenece exactamente a una fase.

---

# Principio de Fases

Las fases permiten separar distintos tipos de lógica.

Ejemplos:

- preparación;
- simulación;
- sincronización;
- limpieza.

El significado concreto depende de la arquitectura del juego.

El Scheduler únicamente garantiza el orden.

---

# Pre Update

Primera fase del Runtime.

Se utiliza para preparar información necesaria para la simulación.

Ejemplos conceptuales:

- actualización de entradas;
- preparación de datos;
- limpieza temporal;
- sincronización inicial.

No deben ejecutarse tareas que dependan de resultados de la simulación del mismo Frame.

---

# Simulation

Constituye la fase principal del Runtime.

Aquí ocurre la mayor parte de la lógica del juego.

Ejemplos:

- movimiento;
- combate;
- IA;
- construcción;
- inventarios;
- habilidades.

La mayor parte de los Systems pertenecerán a esta fase.

---

# Post Update

Procesa tareas posteriores a la simulación.

Ejemplos:

- ajustes finales;
- generación de eventos derivados;
- consolidación de estados;
- preparación para Rendering o Networking.

---

# Late Update

Última fase de ejecución de Systems.

Se utiliza para operaciones que deben ocurrir después de todas las demás fases.

Ejemplos:

- limpieza;
- estadísticas;
- validaciones finales;
- mantenimiento interno.

---

# Orden dentro de una Fase

Dentro de una misma fase:

```text
Planner

↓

Dependency Resolver

↓

Execution Order

↓

Execute Systems
```

El Scheduler respeta el orden calculado.

Los Systems nunca modifican dicho orden.

---

# Barreras

Entre determinadas fases existen barreras de sincronización.

Conceptualmente:

```text
Phase

↓

Barrier

↓

Next Phase
```

Una barrera garantiza que todas las operaciones de la fase anterior finalizaron correctamente antes de continuar.

---

# Propósito de las Barreras

Las barreras permiten:

- aplicar operaciones diferidas;
- sincronizar cambios estructurales;
- mantener consistencia entre Systems;
- preparar el siguiente bloque de ejecución.

---

# Flush Commands

Una vez finalizada la ejecución de los Systems, el Scheduler procesa el `CommandBuffer`.

Conceptualmente:

```text
Deferred Commands

↓

Apply Changes

↓

Registries Updated
```

Hasta este momento ninguna operación estructural afecta al mundo.

---

# Operaciones Procesadas

Ejemplos de operaciones aplicadas durante esta etapa:

- crear entidades;
- destruir entidades;
- añadir Components;
- eliminar Components;
- reemplazar Components.

Todas ellas fueron generadas previamente por los Systems.

---

# Flush Events

Después de aplicar los cambios estructurales, el Event Bus procesa los eventos pendientes.

Conceptualmente:

```text
Queued Events

↓

Dispatch

↓

Subscribers
```

Esto garantiza que los eventos reflejan el estado definitivo del mundo tras aplicar los comandos diferidos.

---

# Finalize Frame

Última etapa lógica del Pipeline.

Responsabilidades:

- cerrar métricas;
- finalizar profiling;
- limpiar buffers temporales;
- preparar el siguiente Frame.

---

# End Frame

Marca el cierre oficial del Frame.

El Scheduler queda preparado para iniciar nuevamente el Pipeline.

---

# Pipeline Completo

El flujo completo puede representarse de la siguiente forma.

```text
Begin Frame

↓

Update Time

↓

Validate Runtime

↓

Pre Update

↓

Simulation

↓

Post Update

↓

Late Update

↓

Barrier

↓

Flush Commands

↓

Barrier

↓

Flush Events

↓

Finalize Frame

↓

End Frame
```

Esta secuencia debe repetirse exactamente en todos los Frames.

---

# Pipeline Determinista

Dos ejecuciones equivalentes deben recorrer exactamente las mismas etapas.

No deben existir:

- fases opcionales ocultas;
- modificaciones dinámicas del Pipeline;
- ejecución dependiente del hardware.

---

# Errores Durante una Fase

Si un System produce un error crítico:

```text
System

↓

Error

↓

Scheduler

↓

Runtime Policy
```

La estrategia concreta de recuperación pertenece al Scheduler y al sistema global de gestión de errores.

El Pipeline no debe quedar en un estado inconsistente.

---

# Cancelación del Frame

En situaciones excepcionales el Scheduler puede cancelar un Frame completo.

Ejemplos:

- fallo crítico de inicialización;
- Runtime inconsistente;
- pérdida de dependencias esenciales.

La cancelación debe producirse antes de modificar el estado del mundo.

---

# Restricciones

El Pipeline nunca debe permitir:

- modificar Registries mientras se ejecutan Queries activas;
- aplicar Commands durante la iteración de Systems;
- alterar el orden de las fases;
- ejecutar un mismo System dos veces dentro de una misma fase, salvo que una política específica del Scheduler lo permita explícitamente.

---

# Garantías

El Execution Pipeline garantiza que:

- todos los Systems se ejecutan en un orden determinista;
- las modificaciones estructurales se aplican únicamente en puntos seguros;
- los eventos se despachan una vez consolidado el estado del mundo;
- cada Frame sigue exactamente la misma secuencia de ejecución;
- el Runtime permanece consistente entre fases.

---

# Resultado Esperado

Al finalizar esta sección queda completamente definido el **Execution Pipeline** del Scheduler.

El Pipeline establece un flujo de ejecución uniforme, determinista y desacoplado, proporcionando los puntos de sincronización necesarios para coordinar Systems, Registries, Commands y Events, y sirviendo como base para la planificación de ejecución y la resolución de dependencias que se desarrollarán en las siguientes secciones del documento.
# 07 - SCHEDULER IMPLEMENTATION

# Parte 3 — Dependency Resolution y Execution Planning

---

# Objetivo

Esta sección define cómo el Scheduler determina el orden de ejecución de los Systems.

La ejecución de los Systems nunca depende del orden en que fueron creados ni del orden en que fueron registrados.

El Scheduler construye un plan de ejecución determinista antes de iniciar el Runtime y lo utiliza durante todo el ciclo de vida del Framework.

---

# Filosofía

Los Systems únicamente describen sus características.

Nunca deciden cuándo ejecutarse.

Nunca ejecutan otros Systems.

Nunca modifican el orden de ejecución.

Toda la planificación pertenece exclusivamente al Scheduler.

---

# Arquitectura

La planificación está compuesta por dos módulos independientes.

```text
System Metadata

↓

Dependency Resolver

↓

Execution Planner

↓

Execution Pipeline
```

Cada módulo posee una responsabilidad claramente definida.

---

# Dependency Resolver

## Responsabilidad

Analizar las dependencias declaradas por todos los Systems.

Construir un grafo dirigido.

Detectar errores arquitectónicos.

Generar un orden válido.

---

# Execution Planner

## Responsabilidad

Utilizar la información generada por el Dependency Resolver para construir el plan definitivo de ejecución.

El resultado será utilizado posteriormente por el Execution Pipeline.

---

# Información Utilizada

El Planner trabaja únicamente con los metadatos del System.

Ejemplo conceptual:

```text
System

↓

Metadata

↓

Execution Phase

Priority

Dependencies

Tags

Execution Mode
```

Nunca analiza la lógica interna del System.

---

# Metadata

Todo System debe declarar información estática.

Ejemplo conceptual:

```text
Movement System

↓

Phase

Simulation

Priority

100

Dependencies

Physics

Tags

Gameplay
```

Estos datos permanecen constantes durante toda la ejecución.

---

# Dependencias

Un System puede declarar dependencias sobre otros Systems.

Conceptualmente:

```text
Combat

↓

Depends On

Health
```

Esto indica únicamente el orden relativo.

No implica comunicación directa.

---

# Grafo de Dependencias

Las dependencias forman un grafo dirigido.

Ejemplo:

```text
Input

↓

Movement

↓

Combat

↓

Animation
```

El Resolver utiliza este grafo para calcular el orden válido.

---

# Restricciones

Las dependencias deben formar un grafo acíclico.

No se permiten ciclos.

Ejemplo inválido:

```text
Movement

↓

Combat

↓

Inventory

↓

Movement
```

El Runtime debe rechazar esta configuración.

---

# Orden Topológico

El Resolver debe generar un orden topológico estable.

Conceptualmente:

```text
Dependency Graph

↓

Topological Sort

↓

Execution Order
```

Este proceso se realiza durante la inicialización del Runtime.

---

# Orden Estable

Cuando dos Systems no poseen dependencias directas:

```text
System A

System B
```

el Planner debe producir siempre el mismo orden.

El resultado nunca debe depender del orden de inserción ni del hardware.

---

# Prioridades

Además de las dependencias, cada System puede declarar una prioridad.

Ejemplo:

```text
Priority

0

↓

100

↓

500

↓

1000
```

Las prioridades solo se comparan entre Systems de la misma fase.

Nunca reemplazan a las dependencias.

---

# Fases

La planificación ocurre independientemente para cada fase.

Conceptualmente:

```text
Pre Update

↓

Planner

↓

Simulation

↓

Planner

↓

Post Update

↓

Planner
```

Esto evita dependencias cruzadas entre fases.

---

# Orden Final

El orden definitivo se obtiene combinando:

```text
Execution Phase

↓

Dependencies

↓

Priority

↓

Stable Ordering
```

El resultado permanece fijo hasta que cambie la composición del Runtime.

---

# Replanificación

El Scheduler no recalcula el orden en cada Frame.

El plan de ejecución debe reutilizarse.

Solo debe reconstruirse cuando:

- se registra un nuevo System;
- se elimina un System;
- cambia la configuración del Runtime;
- una futura extensión del Framework permita Systems dinámicos.

---

# Cache del Plan

El Execution Planner debe mantener una representación optimizada del plan.

Conceptualmente:

```text
Execution Plan

↓

Cached

↓

Execute Every Frame
```

Esto evita cálculos repetitivos.

---

# Validación

Antes de aceptar el plan de ejecución deben comprobarse:

- ausencia de ciclos;
- Systems duplicados;
- dependencias inexistentes;
- fases válidas;
- prioridades válidas.

---

# Errores

El Resolver debe detectar como mínimo:

## Dependencia inexistente

```text
Combat

↓

Requires

Physics

↓

Not Found
```

---

## Ciclo

```text
A

↓

B

↓

C

↓

A
```

---

## Duplicados

Dos Systems del mismo tipo registrados simultáneamente.

---

## Metadata inválida

Ejemplos:

- prioridad fuera de rango;
- fase inexistente;
- identificador duplicado.

---

# Comportamiento ante Errores

Si el plan no puede construirse:

```text
Build Plan

↓

Validation Failed

↓

Runtime Initialization Failed
```

El Runtime no debe comenzar con un plan inconsistente.

---

# Ejecución Condicional

El Planner puede marcar determinados Systems como:

```text
Always

Conditional

Disabled
```

La condición de ejecución se evalúa antes de incluir el System en el plan activo.

La lógica concreta pertenece al Scheduler.

---

# Agrupación

Los Systems pueden organizarse conceptualmente en grupos.

Ejemplo:

```text
Gameplay

Physics

AI

Networking

Debug
```

Los grupos facilitan la organización, pero no modifican por sí mismos el orden de ejecución.

---

# Compatibilidad con Paralelización

Aunque la implementación inicial sea secuencial, el plan debe permitir identificar Systems independientes.

Ejemplo:

```text
Movement

AI

Audio
```

Si no existen dependencias entre ellos, el plan puede marcarlos como potencialmente paralelizables.

La decisión de ejecutar en paralelo pertenece a futuras versiones del Scheduler.

---

# Complejidad

La construcción del plan ocurre con poca frecuencia.

El coste de esta operación es aceptable siempre que el resultado pueda reutilizarse durante todos los Frames posteriores.

El objetivo principal es minimizar el trabajo realizado durante la ejecución continua del Runtime.

---

# Garantías

El Execution Planner garantiza que:

- todos los Systems poseen una posición válida dentro del plan;
- las dependencias siempre se respetan;
- el orden es estable y determinista;
- el plan puede reutilizarse durante toda la ejecución;
- cualquier configuración inválida es detectada antes de iniciar el Runtime.

---

# Restricciones

El Planner nunca debe:

- ejecutar Systems;
- modificar Registries;
- emitir Events;
- interpretar gameplay;
- consultar Components;
- acceder al SceneTree.

Su única responsabilidad consiste en construir el plan de ejecución.

---

# Flujo Completo

Conceptualmente:

```text
Registered Systems

↓

Read Metadata

↓

Build Dependency Graph

↓

Validate Graph

↓

Topological Sort

↓

Apply Priorities

↓

Generate Stable Order

↓

Cache Execution Plan

↓

Runtime Ready
```

Este proceso ocurre antes del primer Frame del Runtime.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificado el proceso de **Dependency Resolution** y **Execution Planning** del Scheduler.

El Runtime dispone ahora de un plan de ejecución estable, determinista y validado, construido a partir de los metadatos declarados por los Systems y preparado para ser utilizado por el Execution Pipeline durante toda la vida del Framework, además de servir como base para futuras optimizaciones como la ejecución paralela o la planificación dinámica.
# 07 - SCHEDULER IMPLEMENTATION

# Parte 4 — Command Buffer y Deferred Operations

---

# Objetivo

Esta sección define el funcionamiento del **Command Buffer**, el mecanismo oficial del Framework para realizar modificaciones estructurales sobre el mundo ECS de forma diferida.

El Command Buffer elimina el acoplamiento entre la ejecución de los Systems y la modificación de los Registries, garantizando la consistencia del Runtime y preparando la arquitectura para futuras optimizaciones como ejecución paralela, rollback, replay y simulación determinista.

---

# Filosofía

Durante la ejecución de un System, el mundo debe considerarse estructuralmente inmutable.

Un System puede solicitar cambios.

Nunca debe aplicarlos inmediatamente.

Toda modificación estructural ocurre únicamente en puntos de sincronización definidos por el Scheduler.

---

# Principio Fundamental

Un System nunca modifica directamente:

- Entity Registry
- Component Registry

En su lugar genera comandos.

Conceptualmente:

```text
System

↓

Generate Command

↓

Command Buffer

↓

Scheduler Barrier

↓

Apply Command
```

---

# Beneficios

La utilización de un Command Buffer proporciona:

- consistencia durante las iteraciones;
- eliminación de modificaciones concurrentes;
- orden determinista;
- desacoplamiento entre lógica y almacenamiento;
- facilidad para depuración;
- compatibilidad con paralelización futura.

---

# Responsabilidad

El Command Buffer es responsable exclusivamente de:

- almacenar comandos;
- mantener su orden;
- exponerlos al Scheduler;
- vaciarse durante las barreras.

No interpreta gameplay.

No valida reglas del juego.

No ejecuta lógica.

---

# Arquitectura

Conceptualmente:

```text
Systems

↓

Generate Commands

↓

Command Buffer

↓

Execution Barrier

↓

Apply Commands

↓

Registries Updated
```

El Scheduler controla completamente este flujo.

---

# Naturaleza de los Comandos

Un comando representa una intención de modificar el mundo.

Ejemplos:

```text
Create Entity

Destroy Entity

Add Component

Remove Component

Replace Component
```

El comando no realiza la operación.

Únicamente la describe.

---

# Inmutabilidad

Una vez generado, un comando no debe modificarse.

Debe tratarse como un objeto inmutable hasta su aplicación o descarte.

---

# Orden de Inserción

El Buffer conserva el orden en que fueron generados los comandos.

Conceptualmente:

```text
Command 1

↓

Command 2

↓

Command 3
```

Este orden será utilizado posteriormente por el Scheduler.

---

# Barreras de Sincronización

Los comandos únicamente pueden aplicarse durante una barrera del Pipeline.

Ejemplo conceptual:

```text
Simulation

↓

Barrier

↓

Flush Commands

↓

Continue
```

Fuera de una barrera ningún comando debe ejecutarse.

---

# Aplicación

Cuando el Scheduler alcanza una barrera:

```text
Command Buffer

↓

Read Commands

↓

Execute

↓

Clear Buffer
```

Una vez finalizado el proceso el Buffer queda vacío.

---

# Atomicidad

La aplicación de los comandos debe considerarse una operación lógica única.

Conceptualmente:

```text
Begin Flush

↓

Apply All Commands

↓

End Flush
```

El mundo nunca debe quedar parcialmente actualizado entre ambos extremos.

---

# Validación

Antes de aplicar cada comando deben verificarse sus precondiciones.

Ejemplos:

- entidad válida;
- Component registrado;
- operación permitida;
- ausencia de conflictos.

Las validaciones pertenecen a los Registries correspondientes.

---

# Tipos de Operaciones

Las operaciones estructurales incluyen:

## Entidades

- crear;
- destruir.

---

## Components

- añadir;
- eliminar;
- reemplazar.

---

## Operaciones Futuras

La arquitectura permite incorporar nuevos tipos de comandos.

Ejemplos:

- activar entidad;
- desactivar entidad;
- instanciar prefabs;
- operaciones masivas;
- comandos personalizados del Runtime.

El Scheduler permanece independiente del tipo concreto.

---

# Aislamiento

Mientras un System se encuentra ejecutándose:

- las entidades permanecen estables;
- los Components permanecen estables;
- las Queries permanecen estables.

Esto elimina inconsistencias durante las iteraciones.

---

# Ejemplo Conceptual

Durante un mismo Frame:

```text
Movement System

↓

Destroy Entity
```

y simultáneamente:

```text
Combat System

↓

Read Entity
```

La entidad continúa existiendo hasta el Flush.

De esta forma ambos Systems observan el mismo estado del mundo.

---

# Conflictos

Pueden producirse situaciones como:

```text
Destroy Entity

↓

Add Component
```

sobre la misma entidad.

La política de resolución pertenece al Scheduler y a los Registries.

El Command Buffer únicamente conserva las solicitudes.

---

# Duplicados

Pueden existir múltiples comandos dirigidos a una misma entidad.

El orden de aplicación determinará el resultado final.

El Runtime puede detectar configuraciones inválidas durante la fase de validación.

---

# Cancelación

Antes del Flush el Scheduler puede descartar comandos.

Ejemplos:

- parada del Runtime;
- reinicio de la simulación;
- rollback futuro.

Mientras no hayan sido aplicados, los comandos representan únicamente intenciones.

---

# Reutilización

El Buffer debe reutilizar su memoria siempre que sea posible.

No debe reconstruirse completamente en cada Frame.

Conceptualmente:

```text
Allocate Once

↓

Fill

↓

Flush

↓

Clear

↓

Reuse
```

---

# Fragmentación

La implementación debe minimizar:

- asignaciones dinámicas;
- copias;
- fragmentación.

El Buffer puede reservar capacidad anticipadamente para reducir costes durante la ejecución.

---

# Compatibilidad con Paralelización

En futuras versiones varios Systems podrán generar comandos simultáneamente.

Por este motivo el diseño del Buffer no debe asumir una única fuente de producción.

La estrategia concreta de sincronización podrá evolucionar sin modificar la API pública.

---

# Compatibilidad con Replay

El Command Buffer representa una secuencia determinista de cambios estructurales.

Esto facilita:

- replay;
- rollback;
- simulaciones reproducibles;
- depuración temporal.

---

# Compatibilidad con Multiplayer

En un modelo Server Authoritative:

```text
Systems

↓

Generate Commands

↓

Server Flush

↓

World Updated

↓

Replication
```

La replicación ocurre únicamente después de consolidar el estado del mundo.

---

# Restricciones

El Command Buffer nunca debe:

- ejecutar lógica de gameplay;
- consultar Queries;
- emitir Events;
- acceder al SceneTree;
- modificar Registries inmediatamente.

Su única responsabilidad consiste en almacenar operaciones diferidas.

---

# Garantías

El Command Buffer garantiza que:

- todas las modificaciones estructurales ocurren en puntos seguros;
- los Systems trabajan sobre un estado consistente del mundo;
- el orden de aplicación es determinista;
- las operaciones pueden validarse antes de ejecutarse;
- el Runtime queda preparado para futuras optimizaciones como paralelización y rollback.

---

# Flujo Completo

Conceptualmente:

```text
Execute Systems

↓

Generate Commands

↓

Store in Buffer

↓

Execution Barrier

↓

Validate Commands

↓

Apply Commands

↓

Update Registries

↓

Clear Buffer

↓

Continue Pipeline
```

Este flujo debe repetirse en cada Frame del Runtime.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificada la arquitectura del **Command Buffer** y del modelo de **Deferred Operations** del Scheduler.

Todas las modificaciones estructurales del mundo ECS pasan por este mecanismo, garantizando consistencia, determinismo y un desacoplamiento completo entre la lógica ejecutada por los Systems y la actualización efectiva de los Registries, sentando además las bases para futuras capacidades avanzadas del Framework.
# 07 - SCHEDULER IMPLEMENTATION

# Parte 5 — Time Management, Profiling y Validación

---

# Objetivo

Esta sección define los subsistemas responsables de la administración del tiempo, el profiling del Runtime y las validaciones previas a la ejecución de cada Frame.

Estos módulos permiten que el Scheduler mantenga una ejecución determinista, medible y segura sin trasladar estas responsabilidades a los Systems.

---

# Filosofía

Los Systems deben concentrarse exclusivamente en ejecutar lógica.

No deben:

- calcular tiempo;
- medir rendimiento;
- validar el estado global del Runtime.

Estas responsabilidades pertenecen al Scheduler.

---

# Arquitectura

Conceptualmente:

```text
Scheduler
      │
      ├──────────────► Time Manager
      │
      ├──────────────► Execution Profiler
      │
      └──────────────► Execution Validator
```

Cada módulo posee una única responsabilidad.

---

# Time Manager

## Responsabilidad

El Time Manager centraliza toda la información temporal del Runtime.

Proporciona una única fuente de verdad para:

- delta time;
- tiempo acumulado;
- fixed timestep;
- ticks;
- pausas;
- escalado temporal.

---

# Objetivos

El Time Manager debe garantizar:

- determinismo;
- estabilidad;
- independencia del hardware;
- consistencia entre Systems.

---

# Delta Time

Cada Frame posee un delta oficial.

Conceptualmente:

```text
Frame

↓

Delta Time

↓

All Systems
```

Todos los Systems reciben exactamente el mismo valor.

---

# Tiempo Acumulado

Además del delta, el Runtime mantiene un tiempo acumulado.

Ejemplo conceptual:

```text
0.0

↓

0.016

↓

0.032

↓

0.048
```

Este valor representa el tiempo total transcurrido desde el inicio del Runtime.

---

# Fixed Timestep

El Framework debe soportar un paso de simulación fijo.

Conceptualmente:

```text
Accumulator

↓

Fixed Tick

↓

Simulation
```

El Time Manager determina cuándo deben ejecutarse estos ticks.

Los Systems no realizan este cálculo.

---

# Acumulador

Cuando el tiempo real supera el tamaño del tick:

```text
Delta

↓

Accumulator

↓

Tick

↓

Remaining Time
```

El tiempo sobrante permanece acumulado para el siguiente Frame.

---

# Escalado Temporal

El Runtime puede modificar la velocidad global de simulación.

Ejemplos:

```text
0.0

Paused

0.5

Half Speed

1.0

Normal

2.0

Double Speed
```

El Time Manager aplica el escalado antes de exponer el tiempo a los Systems.

---

# Pausa

Durante una pausa:

- el Scheduler deja de ejecutar las fases configuradas como pausables;
- el tiempo de simulación deja de avanzar;
- el Runtime conserva su estado.

La política exacta pertenece al Scheduler.

---

# Tiempo Determinista

Todos los cálculos temporales deben producir exactamente los mismos resultados bajo las mismas condiciones.

El comportamiento nunca debe depender de:

- FPS;
- velocidad de CPU;
- sistema operativo.

---

# Execution Profiler

## Responsabilidad

Registrar información relacionada con el rendimiento del Runtime.

No modifica la ejecución.

Únicamente recopila datos.

---

# Métricas Globales

Como mínimo deberán recopilarse:

- tiempo del Frame;
- tiempo por fase;
- tiempo por System;
- tiempo total acumulado;
- número de Frames;
- FPS medio.

---

# Métricas por System

Para cada System pueden registrarse:

```text
Execution Count

Average Time

Minimum Time

Maximum Time

Total Time
```

Estas métricas permiten detectar cuellos de botella.

---

# Métricas por Fase

Cada fase del Pipeline puede registrar:

```text
Pre Update

Simulation

Post Update

Late Update

Flush Commands

Flush Events
```

Esto facilita el análisis del coste del Runtime.

---

# Instrumentación

El Profiler debe poder activarse o desactivarse.

Cuando se encuentre deshabilitado:

- el impacto sobre el rendimiento debe ser mínimo;
- el comportamiento funcional no debe modificarse.

---

# Historial

Opcionalmente, el Profiler puede mantener un historial de Frames.

Ejemplo:

```text
Frame 100

↓

Frame 101

↓

Frame 102
```

Este historial facilita herramientas gráficas de análisis.

---

# Exportación

Las métricas deben poder ser consultadas por:

- herramientas de Debug;
- paneles de Profiling;
- pruebas automáticas;
- futuras herramientas de telemetría.

El Profiler nunca interpreta estos datos.

---

# Execution Validator

## Responsabilidad

Verificar que el Runtime se encuentra en un estado consistente antes de iniciar un nuevo ciclo de ejecución.

---

# Validaciones Obligatorias

Como mínimo deben comprobarse:

- Scheduler inicializado;
- Systems registrados;
- plan de ejecución válido;
- Registries disponibles;
- Contexto válido.

---

# Validaciones del Plan

Antes de comenzar un Frame:

```text
Execution Plan

↓

Valid

↓

Execute
```

Si el plan resulta inválido:

```text
Invalid

↓

Cancel Frame
```

---

# Validación de Dependencias

El Validator verifica que:

- todas las dependencias existen;
- ninguna dependencia fue eliminada;
- el plan continúa siendo consistente.

---

# Validación del Contexto

Todos los servicios del Runtime deben encontrarse disponibles.

Ejemplo:

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

# Validación de Systems

Cada System debe encontrarse en un estado ejecutable.

Ejemplos válidos:

```text
Ready

Running
```

Ejemplos no válidos:

```text
Disposed

Created

Error
```

---

# Validación de Buffers

Antes de iniciar un Frame pueden verificarse:

- Command Buffer limpio;
- Buffers temporales consistentes;
- estructuras auxiliares preparadas.

---

# Comportamiento ante Errores

Si una validación crítica falla:

```text
Validate

↓

Failure

↓

Abort Frame
```

El Runtime no debe continuar con información inconsistente.

---

# Logging

Las validaciones críticas pueden generar registros de error.

Las validaciones exitosas no deben producir Logging continuo.

---

# Integración

El Scheduler utiliza estos módulos durante cada ciclo.

Conceptualmente:

```text
Update Time

↓

Validate Runtime

↓

Execute Pipeline

↓

Collect Metrics

↓

Finalize Frame
```

Ningún System interactúa directamente con estos módulos.

---

# Restricciones

Ni el Time Manager, ni el Profiler, ni el Validator deben:

- modificar Components;
- ejecutar Systems;
- acceder al SceneTree;
- interpretar gameplay;
- emitir Events de juego.

Son subsistemas puramente de infraestructura.

---

# Garantías

Estos módulos garantizan que:

- todos los Systems reciben la misma información temporal;
- el rendimiento del Runtime puede analizarse objetivamente;
- el Scheduler nunca ejecuta un Frame sobre un estado inconsistente;
- el comportamiento permanece determinista y reproducible.

---

# Resultado Esperado

Al finalizar esta sección quedan completamente especificados los subsistemas de **Time Management**, **Execution Profiling** y **Execution Validation**.

Con ellos el Scheduler dispone de una infraestructura sólida para administrar el tiempo del Runtime, recopilar métricas de rendimiento y verificar la consistencia del Framework antes de cada Frame, manteniendo estas responsabilidades completamente separadas de la lógica implementada por los Systems.
# 07 - SCHEDULER IMPLEMENTATION

# Parte 6 — Integración con el Runtime, Debug, Testing y Consideraciones de Implementación

---

# Objetivo

Esta sección define la integración del Scheduler con el resto del Framework ECS, así como las consideraciones relacionadas con depuración, pruebas automatizadas, rendimiento y evolución futura de la implementación.

El Scheduler constituye el punto central de coordinación del Runtime.

Su correcta implementación condiciona el comportamiento de todos los subsistemas del Framework.

---

# Filosofía

El Scheduler debe actuar como un orquestador.

No implementa gameplay.

No contiene lógica de negocio.

No interpreta datos.

Coordina la ejecución de componentes especializados manteniendo el menor acoplamiento posible.

---

# Integración con el Runtime

Durante el Bootstrap el Runtime crea el Scheduler.

Conceptualmente:

```text
Runtime

↓

Create Scheduler

↓

Initialize Modules

↓

Register Systems

↓

Build Execution Plan

↓

Ready
```

A partir de este momento el Scheduler permanece activo durante toda la vida del Runtime.

---

# Integración con SystemBase

Todos los Systems registrados son administrados exclusivamente por el Scheduler.

El flujo conceptual es:

```text
SystemBase

↓

Scheduler Registration

↓

Execution Plan

↓

Pipeline

↓

Execution
```

Los Systems nunca controlan su propia frecuencia ni el momento de ejecución.

---

# Integración con el Entity Registry

El Scheduler nunca modifica directamente el Entity Registry.

Toda modificación estructural ocurre mediante el Command Buffer.

Conceptualmente:

```text
Systems

↓

Deferred Commands

↓

Scheduler Barrier

↓

Entity Registry
```

---

# Integración con el Component Registry

La relación es idéntica.

Los cambios estructurales únicamente se consolidan durante el Flush.

Las modificaciones de datos de los Components continúan siendo responsabilidad de los Systems durante su ejecución.

---

# Integración con el Query Engine

El Scheduler no ejecuta Queries.

Únicamente garantiza que:

- el Query Engine esté inicializado;
- las Queries puedan utilizarse durante la ejecución;
- los cambios estructurales ocurran únicamente después de finalizar las iteraciones.

Esto evita invalidar resultados mientras los Systems se encuentran ejecutándose.

---

# Integración con el Event Bus

El Scheduler coordina el momento en que los eventos pendientes son despachados.

Conceptualmente:

```text
Systems

↓

Emit Events

↓

Event Queue

↓

Flush Events

↓

Subscribers
```

El orden del despacho forma parte del Pipeline oficial.

---

# Integración con Save

El Scheduler no serializa información.

Sin embargo, constituye un punto seguro para iniciar procesos de guardado.

Ejemplo conceptual:

```text
End Frame

↓

World Consistent

↓

Save Pipeline
```

Esto evita capturar estados parcialmente actualizados.

---

# Integración con Multiplayer

En un modelo Server Authoritative:

```text
Scheduler

↓

Execute Simulation

↓

Flush Commands

↓

Flush Events

↓

Replication

↓

Clients
```

La replicación siempre ocurre sobre un estado consistente del mundo.

---

# Compatibilidad con Rollback

La arquitectura del Scheduler debe permitir incorporar, en futuras versiones:

- rollback;
- replay;
- resimulación;
- predicción del cliente.

El uso del Command Buffer y del Pipeline determinista facilita estas capacidades.

---

# Compatibilidad con Paralelización

La implementación inicial puede ser completamente secuencial.

No obstante, el diseño debe permitir identificar grupos de Systems independientes.

Conceptualmente:

```text
Execution Plan

↓

Independent Groups

↓

Future Parallel Execution
```

La incorporación de un Job System no debe requerir modificar la API pública del Scheduler.

---

# Compatibilidad con Herramientas de Debug

El Scheduler debe exponer información útil para inspección.

Ejemplos:

- estado actual;
- Frame activo;
- fase en ejecución;
- plan de ejecución;
- Systems registrados;
- tiempo por fase;
- tiempo por System;
- Commands pendientes;
- Events pendientes.

Toda esta información debe ser de solo lectura.

---

# Herramientas de Diagnóstico

El Framework podrá proporcionar herramientas capaces de visualizar:

```text
Execution Pipeline

↓

Current Phase

↓

Current System

↓

Execution Order

↓

Profiler Data
```

Estas herramientas deben consumir únicamente interfaces públicas.

---

# Logging

El Scheduler debe registrar únicamente información relevante.

Ejemplos:

- errores de inicialización;
- fallos del plan de ejecución;
- dependencias inválidas;
- excepciones críticas.

No debe registrar información de cada Frame durante la ejecución normal.

---

# Compatibilidad con Testing

Toda la implementación debe poder probarse mediante pruebas automatizadas.

El Scheduler debe aceptar implementaciones simuladas de:

- Systems;
- Registries;
- Query Engine;
- Event Bus;
- Runtime Context.

Esto permite verificar su comportamiento de forma aislada.

---

# Escenarios de Prueba

Como mínimo deberán contemplarse los siguientes casos.

## Inicialización

Verificar:

- creación de módulos;
- construcción del plan;
- estado Ready.

---

## Ejecución

Verificar:

- orden correcto;
- respeto de las fases;
- ejecución única por Frame.

---

## Dependencias

Registrar múltiples Systems con dependencias.

Verificar:

- orden topológico;
- ausencia de ciclos;
- estabilidad del plan.

---

## Command Buffer

Generar operaciones diferidas.

Verificar:

- almacenamiento;
- aplicación durante la barrera;
- limpieza posterior.

---

## Event Flush

Emitir eventos desde varios Systems.

Verificar:

- despacho en el momento correcto;
- consistencia del estado del mundo.

---

## Time Manager

Modificar:

- delta;
- pausas;
- escalado temporal.

Verificar que todos los Systems reciben exactamente la misma información.

---

## Profiling

Ejecutar múltiples Frames.

Verificar:

- tiempos registrados;
- métricas acumuladas;
- estadísticas por fase.

---

## Validator

Introducir errores deliberados.

Ejemplos:

- dependencia inexistente;
- System inválido;
- Runtime inconsistente.

Verificar que el Scheduler cancela correctamente la ejecución.

---

# Rendimiento

El Scheduler debe minimizar:

- asignaciones dinámicas;
- reconstrucción del plan;
- validaciones innecesarias;
- búsquedas repetidas.

La mayor parte del trabajo pesado debe realizarse durante la inicialización.

---

# Escalabilidad

La arquitectura debe soportar:

- cientos de Systems;
- miles de entidades;
- múltiples fases;
- grandes volúmenes de Commands;
- alta frecuencia de actualización.

Sin modificar la estructura general del Scheduler.

---

# Restricciones de Implementación

El Scheduler no debe:

- contener gameplay;
- almacenar estado del mundo;
- acceder directamente al SceneTree;
- conocer Components concretos;
- depender de Systems específicos;
- ejecutar Queries;
- serializar datos.

Debe limitarse estrictamente a coordinar el Runtime.

---

# Resumen Arquitectónico

El Scheduler constituye la autoridad absoluta sobre la ejecución del Framework ECS.

Su implementación se basa en módulos especializados:

- Execution Pipeline;
- Execution Planner;
- Dependency Resolver;
- Command Buffer;
- Time Manager;
- Execution Profiler;
- Execution Validator.

Esta organización mantiene una clara separación de responsabilidades y facilita la evolución del Framework.

---

# Relación con el Event Bus

El siguiente documento de esta fase será:

`08_EVENT_BUS_IMPLEMENTATION.md`

El Event Bus utilizará el Pipeline definido por el Scheduler para determinar:

- cuándo se encolan los eventos;
- cuándo se despachan;
- cómo se garantiza el orden;
- cómo mantener un modelo completamente desacoplado entre los Systems.

La coordinación entre ambos subsistemas es fundamental para preservar el determinismo del Runtime.

---

# Resultado Esperado

Con este documento queda completamente especificada la implementación del **Scheduler** del Framework ECS de Survivors Lords.

La arquitectura propuesta establece un sistema de planificación y ejecución determinista, modular y desacoplado, preparado para coordinar todos los Systems del Runtime mediante un Pipeline estable, planificación basada en dependencias, operaciones diferidas, administración centralizada del tiempo y herramientas de validación y profiling, proporcionando una base sólida para el resto de la infraestructura del Framework ECS.

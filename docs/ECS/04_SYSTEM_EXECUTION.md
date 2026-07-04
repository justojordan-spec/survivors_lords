# SYSTEM EXECUTION

**Documento:** 04_SYSTEM_EXECUTION.md

**Fase:** ECS Framework

**Estado:** Draft

**Versión:** 1.0

---

# Objetivo

Este documento define cómo el Framework ECS ejecuta los Systems durante la vida del juego.

Especifica el Scheduler, el orden de ejecución, las fases del Frame, la coordinación entre Systems y las reglas que garantizan un comportamiento determinista.

No define lógica de gameplay.

No define Systems específicos.

Únicamente define la infraestructura responsable de ejecutar todos los Systems del proyecto.

---

# Alcance

Este documento define:

- Scheduler.
- Registro de Systems.
- Pipeline de ejecución.
- Orden de ejecución.
- Prioridades.
- Dependencias.
- Grupos de ejecución.
- Barreras.
- Deferred Commands.
- Startup.
- Shutdown.
- Runtime.
- Fixed Tick.
- Variable Tick.
- Integración con Multiplayer.
- Integración con Save.
- Integración con Debug.

---

# Filosofía

El Scheduler constituye el corazón del Framework ECS.

Todos los Systems son completamente independientes.

Ningún System ejecuta otro System.

Ningún System conoce el orden de ejecución.

Ningún System controla el Frame.

Toda la coordinación pertenece exclusivamente al Scheduler.

---

# Objetivos del Scheduler

El Scheduler debe garantizar:

- Determinismo.
- Escalabilidad.
- Bajo acoplamiento.
- Alto rendimiento.
- Ejecución consistente.
- Compatibilidad Multiplayer.
- Compatibilidad Save.
- Compatibilidad Replay.
- Fácil depuración.
- Extensibilidad.

---

# Principios Fundamentales

Todo System debe cumplir las siguientes reglas.

- No almacenar estado permanente.
- No ejecutar otros Systems.
- No controlar el tiempo.
- No modificar el Scheduler.
- No modificar el orden de ejecución.
- No acceder directamente al Entity Registry.
- No acceder directamente a otros Systems.

Toda interacción ocurre mediante:

- Queries.
- Events.
- Interfaces públicas.

---

# Arquitectura General

```text
Game Loop

↓

Scheduler

↓

Execution Pipeline

↓

Execution Phase

↓

Systems

↓

Queries

↓

Component Updates

↓

Deferred Operations

↓

End Frame
```

---

# Scheduler

El Scheduler representa el coordinador central del Framework.

Es responsable de:

- Registrar Systems.
- Ordenarlos.
- Resolver dependencias.
- Ejecutarlos.
- Medir tiempos.
- Detectar errores.
- Ejecutar barreras.
- Aplicar Deferred Operations.

---

# Responsabilidades

El Scheduler nunca ejecuta gameplay.

Su única responsabilidad consiste en coordinar la ejecución del Framework.

---

# System Registry

Todos los Systems deben registrarse antes del inicio del juego.

Ejemplo conceptual.

```text
System Registry

MovementSystem

CombatSystem

InventorySystem

BuildingSystem

WeatherSystem
```

Una vez registrado, un System permanece disponible hasta finalizar la sesión.

---

# Información almacenada

Cada registro de System contiene conceptualmente:

```text
SystemId

Nombre

Execution Group

Priority

Dependencies

Enabled

Runtime Flags
```

No almacena lógica.

Solo metadatos.

---

# Pipeline General

Cada Frame sigue exactamente el mismo flujo.

```text
Frame Start

↓

Input

↓

Early Systems

↓

Simulation

↓

Late Simulation

↓

Networking

↓

Save Snapshot

↓

Cleanup

↓

Frame End
```

Este orden nunca debe alterarse durante la ejecución.

---

# Startup

Antes de comenzar el primer Frame se ejecutan los Startup Systems.

Responsabilidades:

- Inicializar datos.
- Registrar Resources.
- Crear entidades iniciales.
- Preparar el mundo.
- Configurar cachés.

Los Startup Systems solo se ejecutan una vez.

---

# Runtime

Los Runtime Systems constituyen la ejecución normal del juego.

Son ejecutados cada Frame según el Scheduler.

Representan la mayor parte de la lógica del proyecto.

---

# Shutdown

Al finalizar la ejecución se ejecutan los Shutdown Systems.

Responsabilidades:

- Liberar recursos.
- Guardar información pendiente.
- Vaciar buffers.
- Finalizar conexiones.
- Limpiar memoria temporal.

---

# Tipos de Systems

El Framework reconoce tres categorías.

## Startup

Solo una ejecución.

---

## Runtime

Cada Frame.

---

## Shutdown

Solo al finalizar la aplicación.

---

# Estados de un System

Todo System posee uno de los siguientes estados.

```text
Created

↓

Registered

↓

Initialized

↓

Running

↓

Paused

↓

Stopped

↓

Disposed
```

El Scheduler controla todas las transiciones.

---

# Inicialización

Antes de ejecutarse un System:

- Se registra.
- Se validan dependencias.
- Se inicializan recursos internos.
- Se crean Queries permanentes.

Solo entonces puede comenzar su ejecución.

---

# Ejecución

Cada ciclo de ejecución sigue el siguiente flujo.

```text
Scheduler

↓

Validate

↓

Execute

↓

Flush Commands

↓

Finish
```

El System nunca controla este flujo.

---

# Finalización

Cuando un System termina:

- Libera recursos temporales.
- Vacía buffers internos.
- Finaliza Deferred Commands locales.
- Devuelve el control al Scheduler.

---

# Continúa en la Parte 2

La siguiente parte desarrollará:

- Execution Groups.
- Prioridades.
- Dependencias entre Systems.
- Ordenamiento del Scheduler.
- Barreras de sincronización.
- Pipeline completo del Frame.
- Fixed Tick.
- Variable Tick.
- Gestión del tiempo.
---

# Execution Groups

El Scheduler organiza los Systems en grupos de ejecución.

Cada grupo representa una fase específica del Frame.

Los Systems únicamente pueden ejecutarse dentro de un único grupo.

Esta organización permite:

- Mantener un orden determinista.
- Reducir dependencias.
- Facilitar la depuración.
- Preparar el Framework para ejecución paralela.

---

# Objetivos de los Execution Groups

Los grupos de ejecución permiten:

- Separar responsabilidades.
- Evitar conflictos entre Systems.
- Definir barreras naturales.
- Garantizar consistencia del estado del mundo.

Cada grupo representa una etapa completamente finalizada antes de comenzar la siguiente.

---

# Pipeline General

Conceptualmente el Scheduler organiza el Frame de la siguiente forma.

```text
Startup

↓

Input

↓

Pre Simulation

↓

Simulation

↓

Post Simulation

↓

Networking

↓

Save

↓

Cleanup

↓

Rendering

↓

End Frame
```

Cada grupo posee un propósito claramente definido.

---

# Startup Group

Responsable de preparar el mundo.

Ejemplos:

- Inicialización.
- Bootstrap.
- Registro de Queries.
- Creación de entidades iniciales.
- Configuración de Systems.

Solo se ejecuta una vez.

---

# Input Group

Procesa toda la entrada del jugador.

Ejemplos:

- Input local.
- Input remoto.
- Controles.
- Acciones.

El Input nunca modifica directamente el mundo.

Únicamente genera Commands o Events.

---

# Pre Simulation Group

Permite preparar información antes de la simulación principal.

Ejemplos:

- Validaciones.
- Actualización de buffers.
- Sincronización temporal.
- Preparación de Queries.

---

# Simulation Group

Representa el núcleo del gameplay.

Aquí se ejecutan Systems como:

- Movimiento.
- Combate.
- IA.
- Inventario.
- Construcción.
- Economía.
- Clima.

La mayor parte del tiempo del Frame ocurre en este grupo.

---

# Post Simulation Group

Procesa resultados de la simulación.

Ejemplos:

- Eventos.
- Efectos.
- Reacciones.
- Actualización de estados.

No debería modificar decisiones tomadas durante Simulation.

---

# Networking Group

Responsable de:

- Recibir paquetes.
- Validar mensajes.
- Replicar Components.
- Replicar Entities.
- Generar snapshots.

Nunca ejecuta gameplay.

---

# Save Group

Procesa:

- Auto Save.
- Snapshots.
- Serialización.
- Persistencia.

Debe ejecutarse una vez que el estado del mundo es completamente consistente.

---

# Cleanup Group

Responsable de:

- Liberar memoria temporal.
- Vaciar buffers.
- Eliminar entidades pendientes.
- Aplicar operaciones diferidas.
- Reiniciar estados temporales.

---

# Rendering Group

Aunque Rendering pertenece a Godot, el Framework puede preparar información para la capa visual.

Ejemplos:

- Sincronizar Transform.
- Actualizar animaciones.
- Actualizar proxies visuales.

Nunca contiene lógica de gameplay.

---

# Prioridades

Dentro de cada grupo los Systems poseen una prioridad.

Ejemplo conceptual.

```text
Priority

0

100

200

300

400
```

Menor número implica ejecución anterior.

---

# Reglas de Prioridad

Las prioridades únicamente ordenan Systems dentro del mismo grupo.

Nunca permiten cambiar de grupo.

Ejemplo:

Incorrecto.

```text
Networking

↓

Simulation
```

La prioridad nunca puede producir esta situación.

---

# Dependencias

Un System puede depender de otro.

Ejemplo.

```text
CombatSystem

↓

Requiere

↓

HealthSystem
```

El Scheduler utiliza estas relaciones para construir el orden de ejecución.

---

# Objetivos de las Dependencias

Permiten:

- Evitar errores.
- Garantizar datos válidos.
- Simplificar configuración.
- Eliminar orden manual.

---

# Dependencias Directas

Ejemplo.

```text
Inventory

↓

Equipment

↓

Combat
```

Combat nunca comenzará antes que Equipment.

---

# Dependencias Transitivas

Ejemplo.

```text
A

↓

B

↓

C
```

Automáticamente:

```text
C

↓

Depende de A
```

Aunque no exista una dependencia explícita.

---

# Resolución de Dependencias

Antes del inicio del juego el Scheduler calcula el orden completo.

Proceso conceptual.

```text
Registrar Systems

↓

Leer Dependencias

↓

Construir Grafo

↓

Resolver Orden

↓

Validar

↓

Guardar Pipeline
```

Este cálculo ocurre una sola vez.

---

# Grafo de Dependencias

Conceptualmente.

```text
Movement

↓

Animation

↓

Rendering
```

Cada nodo representa un System.

Cada conexión representa una dependencia.

---

# Dependencias Circulares

No están permitidas.

Ejemplo inválido.

```text
A

↓

B

↓

C

↓

A
```

El Scheduler debe detectar este caso durante la inicialización.

La aplicación no debe comenzar si existen ciclos.

---

# Orden Topológico

Una vez construido el grafo se genera un orden topológico.

Ejemplo.

```text
Input

↓

Movement

↓

Combat

↓

Animation

↓

Rendering
```

Este orden permanece estable durante toda la ejecución.

---

# Barreras

Entre grupos existen Barreras de Sincronización.

Conceptualmente.

```text
Simulation

↓

Barrier

↓

Networking
```

Hasta que todos los Systems del grupo finalicen, el siguiente grupo no puede comenzar.

---

# Objetivos de las Barreras

Garantizan:

- Estado consistente.
- Queries completas.
- Components válidos.
- Eventos procesados.

Son fundamentales para la futura paralelización.

---

# Cambios de Grupo

Un System nunca puede cambiar de grupo durante la ejecución.

La pertenencia al grupo se define durante el registro.

Esto mantiene el comportamiento determinista.

---

# Habilitar y Deshabilitar Systems

El Scheduler permite habilitar o deshabilitar un System.

Estados posibles.

```text
Enabled

Disabled

Paused
```

---

# Enabled

El System participa normalmente en el Scheduler.

---

# Disabled

El System permanece registrado.

No ejecuta lógica.

No recibe actualización.

Puede habilitarse posteriormente.

---

# Paused

El System conserva su estado temporal.

Simplemente deja de ejecutarse hasta ser reanudado.

---

# Validaciones del Scheduler

Antes de ejecutar un grupo el Scheduler debe comprobar:

- Dependencias resueltas.
- Systems válidos.
- Systems habilitados.
- Queries disponibles.
- Recursos cargados.
- Barreras anteriores completadas.

Solo entonces comienza la ejecución.

---

# Garantías

Al finalizar un Execution Group se garantiza que:

- Todos sus Systems finalizaron.
- Las Queries fueron actualizadas.
- Los Components son consistentes.
- Las operaciones diferidas permanecen pendientes hasta la fase correspondiente.
- El siguiente grupo recibe un estado válido del mundo.

---

# Continúa en la Parte 3

La siguiente parte desarrollará:

- Pipeline completo del Frame.
- Fixed Tick.
- Variable Tick.
- Gestión del tiempo.
- Acumulador de tiempo.
- Actualización de Physics.
- Sincronización con Godot.
- Control del Delta Time.
- Determinismo temporal.
```
---

# Pipeline Completo del Frame

El Scheduler ejecuta exactamente el mismo pipeline en cada Frame.

Este comportamiento garantiza:

- Determinismo.
- Consistencia.
- Reproducibilidad.
- Compatibilidad con Replay.
- Compatibilidad con Multiplayer.

Ningún System puede alterar este pipeline durante la ejecución.

---

# Flujo General del Frame

Conceptualmente un Frame sigue la siguiente secuencia.

```text
Frame Begin

↓

Update Time

↓

Process Input

↓

Receive Network

↓

Execute Early Systems

↓

Execute Simulation

↓

Execute Late Simulation

↓

Apply Deferred Commands

↓

Process Event Queue

↓

Replicate Network

↓

Create Save Snapshot

↓

Cleanup

↓

Render Sync

↓

Frame End
```

Cada etapa posee una responsabilidad específica.

---

# Frame Begin

Al comenzar un nuevo Frame el Scheduler realiza las siguientes tareas.

- Incrementar Frame Number.
- Actualizar reloj interno.
- Reiniciar métricas temporales.
- Preparar buffers.
- Preparar estadísticas.

Todavía no se ejecuta ningún System.

---

# Actualización del Tiempo

El Time System actualiza:

- Delta Time.
- Elapsed Time.
- Fixed Time Accumulator.
- Frame Counter.
- Tick Counter.

Todos los Systems utilizan esta misma información.

Ningún System obtiene el tiempo directamente desde Godot.

---

# Delta Time

El Framework diferencia claramente entre:

- Real Delta.
- Fixed Delta.

```text
Real Delta

↓

0.0164

↓

0.0158

↓

0.0171
```

Este valor puede variar entre Frames.

---

# Fixed Delta

El Fixed Delta permanece constante.

Ejemplo.

```text
1 / 60

↓

0.016666666
```

Este valor nunca cambia durante la ejecución.

---

# Acumulador de Tiempo

El Scheduler mantiene un acumulador interno.

```text
Accumulator

+=

Real Delta
```

Mientras el acumulador sea mayor que el Fixed Delta:

```text
Accumulator >= Fixed Delta
```

Debe ejecutarse un nuevo Fixed Tick.

---

# Fixed Tick

El Fixed Tick representa una actualización completamente determinista.

Durante esta fase normalmente se ejecutan Systems como:

- Movimiento.
- Física lógica.
- Combate.
- IA.
- Navegación.
- Economía.
- Producción.

---

# Variable Tick

El Variable Tick representa la actualización dependiente del Frame Rate.

Ejemplos:

- Animaciones.
- Cámara.
- Audio.
- Interfaz.
- Efectos visuales.

Estos Systems pueden utilizar el Delta Time real.

---

# Separación de Actualizaciones

Conceptualmente.

```text
Real Frame

↓

Update()

↓

Variable Systems

↓

Accumulator

↓

Fixed Systems

↓

Render
```

Esta separación evita diferencias entre equipos con distintos FPS.

---

# Ventajas del Fixed Tick

Permite:

- Simulación determinista.
- Multiplayer estable.
- Replays exactos.
- IA consistente.
- Física independiente del Frame Rate.

---

# Orden Interno del Fixed Tick

Cada Tick fijo sigue el siguiente flujo.

```text
Begin Tick

↓

Simulation

↓

Deferred Commands

↓

Event Queue

↓

End Tick
```

El orden nunca cambia.

---

# Múltiples Fixed Ticks

Si el acumulador contiene suficiente tiempo pueden ejecutarse varios Fixed Ticks dentro de un mismo Frame.

Ejemplo.

```text
Frame

↓

Tick 1

↓

Tick 2

↓

Render
```

El usuario continúa viendo un único Frame.

---

# Límite Máximo

Para evitar el fenómeno conocido como **Spiral of Death**, el Scheduler debe limitar la cantidad máxima de Fixed Ticks ejecutados por Frame.

Ejemplo conceptual.

```text
Máximo

5 Ticks
```

Si el acumulador continúa creciendo:

- El exceso puede descartarse.
- O ajustarse mediante una estrategia configurada por el Framework.

---

# Time Scale

El Framework admite un multiplicador global del tiempo.

Ejemplo.

```text
Time Scale

1.0
```

Tiempo normal.

```text
0.5
```

Mitad de velocidad.

```text
2.0
```

Doble velocidad.

---

# Pausa

Durante una pausa:

- El tiempo de simulación deja de avanzar.
- Los Fixed Systems no se ejecutan.
- Los Systems marcados como "Run While Paused" pueden continuar.

Ejemplos:

- UI.
- Menús.
- Audio.
- Networking.

---

# Sincronización con Godot

Godot continúa siendo responsable del Game Loop.

El Framework ECS se ejecuta dentro del ciclo proporcionado por Godot.

Conceptualmente.

```text
Godot

↓

_process()

↓

Scheduler

↓

Systems
```

Para los Systems de simulación fija.

```text
Godot

↓

_physics_process()

↓

Scheduler

↓

Fixed Pipeline
```

La lógica ECS nunca depende directamente de `_process()` o `_physics_process()`.

Siempre pasa por el Scheduler.

---

# Sincronización con Physics

El Framework no modifica directamente el motor físico.

Los Systems producen el estado lógico.

Posteriormente, un System de integración sincroniza dicho estado con los Nodes físicos correspondientes.

Esto mantiene desacopladas ambas capas.

---

# Sincronización con Rendering

El Rendering nunca consulta directamente los Components.

El flujo recomendado es:

```text
Simulation

↓

Transform Component

↓

Render Sync System

↓

Godot Nodes
```

Esto evita que Rendering afecte la simulación.

---

# Orden de Ejecución del Tiempo

Cada Frame.

```text
Actualizar Tiempo

↓

Actualizar Acumulador

↓

Ejecutar Fixed Tick(s)

↓

Ejecutar Variable Systems

↓

Preparar Render
```

Todos los Systems observan exactamente el mismo tiempo para un mismo ciclo.

---

# Determinismo Temporal

Para garantizar resultados reproducibles:

- Todos los Systems reciben el mismo Delta.
- Ningún System calcula su propio tiempo.
- Ningún System consulta directamente el reloj del sistema operativo.
- El Scheduler constituye la única fuente oficial de tiempo.

---

# Validaciones

Antes de comenzar un Tick el Scheduler debe comprobar:

- Tiempo válido.
- Acumulador válido.
- No existen Ticks pendientes inconsistentes.
- Las fases anteriores finalizaron correctamente.

---

# Garantías del Pipeline Temporal

Al finalizar cada Frame se garantiza que:

- Todos los Fixed Ticks requeridos fueron ejecutados.
- El acumulador conserva únicamente el tiempo restante.
- Los Systems observaron un tiempo consistente.
- El mundo lógico permanece sincronizado.

---

# Continúa en la Parte 4

La siguiente parte desarrollará:

- Deferred Commands.
- Command Buffers.
- Barreras de sincronización.
- Flush de operaciones.
- Integración con Event Bus.
- Integración con Query System.
- Consistencia entre fases.
- Reglas para modificaciones estructurales.
---

# Deferred Commands

Durante la ejecución de un System existen operaciones que no pueden aplicarse inmediatamente.

Modificar la estructura del mundo mientras otros Systems la están recorriendo produciría estados inconsistentes.

Para resolver este problema, el Framework utiliza **Deferred Commands**.

---

# Objetivo

Los Deferred Commands permiten:

- Mantener la consistencia del mundo.
- Evitar modificaciones durante iteraciones.
- Facilitar la paralelización futura.
- Garantizar determinismo.
- Reducir condiciones de carrera.

Toda modificación estructural debe pasar por este mecanismo.

---

# ¿Qué es un Deferred Command?

Un Deferred Command representa una operación pendiente de aplicar sobre el mundo.

Ejemplos:

- CreateEntity
- DestroyEntity
- AddComponent
- RemoveComponent
- EnableEntity
- DisableEntity

Mientras el Command permanezca en la cola, el estado del mundo no cambia.

---

# Filosofía

Los Systems **no modifican directamente** la estructura del ECS.

En su lugar:

```text
System

↓

Create Command

↓

Command Buffer

↓

Scheduler

↓

Flush

↓

World Update
```

Esto desacopla completamente la ejecución de la modificación.

---

# Command Buffer

Cada Frame dispone de un Command Buffer.

Conceptualmente:

```text
Command Buffer

├── Create Entity
├── Destroy Entity
├── Add Component
├── Remove Component
├── Enable Entity
└── Disable Entity
```

El Scheduler es el único autorizado para vaciar este buffer.

---

# Tipos de Commands

El Framework reconoce dos grandes categorías.

## Commands Estructurales

Modifican la composición del ECS.

Ejemplos:

- Crear Entity.
- Destruir Entity.
- Agregar Component.
- Eliminar Component.

---

## Commands de Estado

Modifican únicamente el estado de una Entity.

Ejemplos:

- Enable.
- Disable.
- Activate.
- Deactivate.

No alteran la composición de Components.

---

# Flujo General

Toda operación sigue el mismo pipeline.

```text
Solicitud

↓

Validación

↓

Crear Command

↓

Insertar Buffer

↓

Esperar Flush

↓

Aplicar Cambios

↓

Actualizar Queries

↓

Publicar Eventos
```

---

# Inserción en el Buffer

Agregar un Command debe ser una operación de costo constante.

Objetivo:

```text
O(1)
```

No deben realizarse búsquedas ni reorganizaciones durante la inserción.

---

# Orden de Inserción

Los Commands mantienen el orden en el que fueron solicitados.

Ejemplo:

```text
Create Entity

↓

Add Component

↓

Enable Entity
```

Durante el Flush se respetará exactamente ese orden.

---

# Flush del Command Buffer

El Flush representa el momento en el que las operaciones pendientes se vuelven efectivas.

Conceptualmente:

```text
Simulation

↓

Barrier

↓

Flush Commands

↓

Actualizar Mundo

↓

Continuar Pipeline
```

Durante el Flush no se ejecutan Systems.

---

# Momento del Flush

El Framework puede realizar Flush en puntos bien definidos del pipeline.

Ejemplo:

```text
Simulation

↓

Flush

↓

Post Simulation

↓

Flush

↓

Networking

↓

Flush
```

Nunca ocurre de forma arbitraria.

---

# Barreras de Sincronización

Antes de aplicar los Commands el Scheduler establece una barrera.

Esto garantiza que:

- Ningún System permanezca ejecutándose.
- Ninguna Query esté siendo recorrida.
- Ningún Storage esté siendo modificado.

Solo entonces puede comenzar el Flush.

---

# Actualización del Mundo

Durante el Flush el Scheduler:

- Ejecuta los Commands.
- Actualiza Storages.
- Actualiza Signatures.
- Actualiza Queries.
- Actualiza índices.
- Invalida cachés necesarias.

Al finalizar el mundo vuelve a ser consistente.

---

# Integración con el Query System

Las Queries nunca observan un estado parcialmente actualizado.

Secuencia:

```text
Commands Pendientes

↓

Flush

↓

Actualizar Queries

↓

Queries Consistentes
```

Un System siempre trabaja con una vista coherente del mundo.

---

# Integración con el Event Bus

Una vez aplicados los cambios estructurales, el Framework publica los eventos correspondientes.

Ejemplo:

```text
Create Entity

↓

Flush

↓

EntityCreated
```

Esto evita emitir eventos sobre entidades que aún no existen oficialmente.

---

# Integración con el Entity Registry

El Scheduler nunca modifica directamente las estructuras internas.

Toda operación estructural es delegada al Entity Registry.

Flujo:

```text
Scheduler

↓

Command

↓

Entity Registry

↓

Actualizar ECS
```

---

# Integración con el Component Registry

Cuando un Command implica Components:

```text
Command

↓

Component Registry

↓

Storage

↓

Signature

↓

Queries
```

El Scheduler únicamente coordina el proceso.

---

# Atomicidad

Cada Command debe aplicarse completamente o no aplicarse.

Nunca puede quedar una operación a medio ejecutar.

Ejemplo inválido:

```text
Component agregado

↓

Signature NO actualizada
```

Este estado nunca debe existir.

---

# Consistencia

Después de cada Flush el Framework garantiza:

- Todas las Entities son válidas.
- Todas las Signatures son correctas.
- Todos los Storages son consistentes.
- Todas las Queries están actualizadas.
- Todos los Handles siguen siendo válidos o han sido invalidados correctamente.

---

# Commands Anidados

Durante el Flush pueden generarse nuevos Commands.

Ejemplo:

```text
Destroy Entity

↓

OnDestroyed

↓

Spawn Loot
```

Estos nuevos Commands **no deben ejecutarse inmediatamente**.

Se agregan al siguiente ciclo de procesamiento del buffer para evitar recursión y mantener el determinismo.

---

# Límite de Iteraciones

Para evitar bucles infinitos, el Scheduler debe limitar la cantidad de ciclos consecutivos de Flush por Frame.

Si se supera el límite:

- Registrar error de desarrollo.
- Detener el procesamiento adicional.
- Mantener el Framework en un estado consistente.

---

# Validaciones

Antes de ejecutar un Command el Scheduler debe verificar:

- Handle válido.
- Entity existente.
- Component registrado.
- Permisos de autoridad.
- Dependencias satisfechas.
- Estado permitido.

Los Commands inválidos nunca deben modificar el ECS.

---

# Objetivos de Rendimiento

El sistema de Deferred Commands debe ofrecer:

- Inserción O(1).
- Procesamiento secuencial.
- Mínimas asignaciones dinámicas.
- Excelente localidad de memoria.
- Bajo costo de sincronización.

---

# Continúa en la Parte 5

La siguiente parte desarrollará:

- Ejecución paralela (futuro).
- Thread Safety.
- Barreras para multithreading.
- Profiling.
- Instrumentación.
- Métricas del Scheduler.
- Optimización.
- Buenas prácticas.
- Anti-patrones.
- Estado final del documento.
---

# Ejecución Paralela

Aunque la primera implementación del Framework ejecutará los Systems de forma secuencial, toda la arquitectura debe diseñarse para permitir paralelización futura sin cambios en la API pública.

El objetivo es que la transición hacia múltiples hilos requiera modificar únicamente el Scheduler, sin afectar a los Systems existentes.

---

# Objetivos

La futura ejecución paralela debe permitir:

- Aprovechar procesadores multinúcleo.
- Incrementar el rendimiento de simulaciones complejas.
- Reducir el tiempo total del Frame.
- Mantener el comportamiento determinista.
- Conservar la compatibilidad con Multiplayer y Save.

---

# Filosofía

La paralelización es responsabilidad exclusiva del Scheduler.

Los Systems nunca crean Threads.

Los Systems nunca sincronizan Threads.

Los Systems nunca conocen si están ejecutándose en paralelo o de forma secuencial.

Desde la perspectiva de un System, el comportamiento siempre es idéntico.

---

# Requisitos para Paralelización

Un System podrá ejecutarse en paralelo únicamente cuando:

- No tenga dependencias pendientes.
- No escriba sobre los mismos Components que otro System.
- No modifique estructuras del ECS.
- No viole las barreras definidas por el Scheduler.

---

# Acceso a Components

El Scheduler debe conocer el tipo de acceso que realiza cada System.

Existen dos categorías.

## Read Only

El System únicamente consulta datos.

Puede ejecutarse simultáneamente con otros lectores.

---

## Read / Write

El System modifica Components.

Requiere exclusividad sobre los datos afectados.

---

# Ejemplo Conceptual

```text
Movement System

Lee:
Velocity

Escribe:
Transform
```

```text
Animation System

Lee:
Transform

No escribe
```

El Scheduler detectará que ambos no pueden ejecutarse al mismo tiempo si existe una dependencia de escritura.

---

# Conflictos de Escritura

Dos Systems nunca deben escribir simultáneamente sobre el mismo tipo de Component.

Ejemplo inválido.

```text
Movement

↓

Transform
```

```text
Physics

↓

Transform
```

En este caso el Scheduler deberá ejecutarlos en distintos momentos.

---

# Lecturas Concurrentes

Las lecturas simultáneas sí son válidas.

Ejemplo.

```text
Combat

↓

Health
```

```text
UI

↓

Health
```

Ambos pueden ejecutarse en paralelo porque ninguno modifica el Component.

---

# Barreras de Sincronización

Las barreras representan puntos donde todos los Threads deben finalizar antes de continuar.

Conceptualmente.

```text
Grupo A

↓

Barrier

↓

Grupo B
```

Esto garantiza un estado consistente del mundo.

---

# Sincronización de Datos

Después de cada barrera el Scheduler garantiza:

- Todos los Components escritos son visibles.
- Las Queries están actualizadas.
- Los Buffers fueron sincronizados.
- Los Deferred Commands permanecen pendientes hasta el Flush correspondiente.

---

# Thread Safety

El Framework debe diseñarse para evitar condiciones de carrera.

Las siguientes estructuras deben permanecer protegidas:

- Entity Registry.
- Component Registry.
- Query Registry.
- Command Buffers.
- Event Queue.

Los Systems nunca deben acceder directamente a estas estructuras internas.

---

# Inmutabilidad Temporal

Durante la ejecución de un grupo, el conjunto de Entities y Components visibles debe permanecer estable.

Los cambios estructurales se difieren mediante Command Buffers.

Esto elimina una gran cantidad de problemas de concurrencia.

---

# Profiling

El Scheduler debe recopilar información de rendimiento durante la ejecución.

Cada System debe registrar, como mínimo:

- Tiempo de inicio.
- Tiempo de finalización.
- Duración.
- Cantidad de ejecuciones.
- Promedio.
- Tiempo máximo.
- Tiempo mínimo.

---

# Métricas

Conceptualmente.

```text
Movement System

Average

0.18 ms

Max

0.42 ms

Calls

600
```

Estas métricas permiten detectar cuellos de botella.

---

# Estadísticas del Frame

Al finalizar cada Frame el Scheduler puede calcular:

- Tiempo total.
- Tiempo por grupo.
- Tiempo por System.
- Cantidad de Queries.
- Cantidad de Commands.
- Cantidad de Events.
- Cantidad de Entities activas.
- Cantidad de Components activos.

---

# Instrumentación

En modo Debug el Scheduler puede instrumentar automáticamente la ejecución.

Ejemplos:

- Inicio de System.
- Fin de System.
- Tiempo consumido.
- Dependencias resueltas.
- Barreras ejecutadas.
- Flush realizados.

Esta información resulta fundamental para el análisis de rendimiento.

---

# Optimización

El Scheduler debe minimizar:

- Cambios de contexto.
- Sincronizaciones innecesarias.
- Esperas entre grupos.
- Recorridos redundantes.
- Invalidaciones de caché.

Siempre debe priorizar la estabilidad sobre una optimización agresiva.

---

# Manejo de Errores

El Scheduler debe detectar situaciones como:

- Dependencias circulares.
- Systems duplicados.
- Ejecuciones fuera de grupo.
- Escrituras concurrentes no permitidas.
- Barreras incompletas.
- Commands sin procesar al finalizar el Frame.

Estos errores deben detectarse durante desarrollo siempre que sea posible.

---

# Buenas Prácticas

Se recomienda que los Systems:

- Sean pequeños y especializados.
- Ejecuten una única responsabilidad.
- Utilicen Queries en lugar de búsquedas manuales.
- Eviten asignaciones dinámicas durante la ejecución.
- No conserven referencias temporales entre Frames.
- Utilicen Deferred Commands para cambios estructurales.

---

# Anti-Patrones

El Framework prohíbe expresamente:

- Un System ejecutando otro System.
- Modificar el Scheduler desde un System.
- Alterar manualmente el orden de ejecución.
- Acceder directamente al Entity Registry.
- Acceder directamente al Component Registry.
- Crear Threads dentro de un System.
- Esperar activamente (`busy waiting`) durante la ejecución.
- Modificar Queries manualmente.

---

# Garantías del Scheduler

Al finalizar cada Frame el Scheduler garantiza que:

- Todos los Systems habilitados fueron ejecutados exactamente una vez en su fase correspondiente.
- Las dependencias fueron respetadas.
- Las barreras fueron completadas.
- Los Deferred Commands fueron procesados en el punto definido del pipeline.
- El estado del mundo es consistente.
- Las Queries reflejan la composición actual de las Entities.
- Los Events pendientes fueron despachados según las reglas del Event Bus.
- El Framework está listo para iniciar el siguiente Frame.

---

# Resumen del Pipeline de Ejecución

```text
Frame Begin
        │
        ▼
Actualizar Tiempo
        │
        ▼
Input
        │
        ▼
Pre Simulation
        │
        ▼
Simulation
        │
        ▼
Barrier
        │
        ▼
Flush Deferred Commands
        │
        ▼
Actualizar Queries
        │
        ▼
Process Event Queue
        │
        ▼
Networking
        │
        ▼
Save Snapshot
        │
        ▼
Cleanup
        │
        ▼
Render Sync
        │
        ▼
Frame End
```

---

# Convenciones

Todo System del Framework deberá respetar las siguientes convenciones:

- Un System tiene una única responsabilidad.
- La lógica reside exclusivamente en los Systems.
- Los Systems nunca almacenan referencias persistentes a Components.
- Toda modificación estructural utiliza Deferred Commands.
- Toda interacción entre Systems ocurre mediante Queries, Events o Interfaces públicas.
- El Scheduler es la única autoridad sobre el orden de ejecución.
- Ningún System puede asumir el orden de otros Systems salvo mediante dependencias explícitas.

---

# Estado

**Estado actual:** Especificación del Scheduler y del modelo de ejecución de Systems.

Este documento define el contrato técnico para la implementación del Scheduler del Framework ECS de Survivors Lords y establece las reglas obligatorias para la ejecución determinista de todos los Systems. Cualquier modificación al pipeline, al modelo de dependencias o al mecanismo de ejecución deberá documentarse mediante una DEC (Design Engineering Change) antes de su implementación.
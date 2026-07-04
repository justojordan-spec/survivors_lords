# 01 - PROJECT BOOTSTRAP

---

# Objetivo

Este documento define la arquitectura de inicialización del Framework ECS de Survivors Lords.

Su propósito es especificar, de forma técnica y detallada, cómo debe arrancar el Framework dentro de Godot 4.4, estableciendo el orden de creación de los subsistemas, las dependencias permitidas, los estados del proceso de bootstrap y las condiciones necesarias antes de iniciar la ejecución del mundo ECS.

Este documento **no describe gameplay**, **no implementa Systems**, **no define Components** y **no modifica la arquitectura conceptual documentada en la carpeta `docs/ECS`**.

Actúa exclusivamente como la especificación de implementación del proceso de arranque.

---

# Alcance

Este documento define:

- Inicialización del Framework.
- Creación del Core ECS.
- Orden de registro de subsistemas.
- Estados del Bootstrap.
- Dependencias permitidas.
- Gestión de errores durante el arranque.
- Validaciones previas al inicio.
- Inicio del Scheduler.
- Inicio del ciclo principal del Framework.

No define:

- Gameplay.
- Mecánicas.
- IA.
- Componentes.
- Resources específicos.
- Implementación interna de los Registries.
- Implementación del Event Bus.
- Implementación del Query Engine.
- Implementación del Scheduler.

Cada uno de esos elementos será desarrollado en documentos posteriores.

---

# Filosofía

El Bootstrap debe ser completamente determinista.

Dos ejecuciones del Framework bajo las mismas condiciones deben producir exactamente el mismo estado inicial.

El Bootstrap nunca debe depender del orden de carga automático de escenas de Godot.

El Bootstrap nunca debe depender de `_ready()` de múltiples nodos dispersos.

Todo el Framework debe inicializarse desde un único punto de entrada claramente definido.

---

# Principios

El proceso de Bootstrap debe cumplir las siguientes reglas:

- Un único punto de entrada.
- Orden fijo de inicialización.
- Dependencias explícitas.
- Sin referencias circulares.
- Sin inicializaciones implícitas.
- Sin lógica de gameplay.
- Sin creación automática de entidades del juego.
- Sin acceso a escenas específicas.
- Sin dependencias con UI.
- Sin dependencias con mapas.

El Framework debe poder arrancar incluso sin cargar ningún mundo.

---

# Responsabilidades

El Bootstrap únicamente debe encargarse de:

- Crear el Core ECS.
- Crear los Registries.
- Crear el Event Bus.
- Crear el Scheduler.
- Crear el Query Engine.
- Crear el Resource Registry.
- Registrar los Systems.
- Validar dependencias.
- Inicializar los servicios base.
- Dejar el Framework listo para ejecutar.

Nada más.

---

# Punto de Entrada

El proyecto debe poseer un único punto de entrada del Framework.

Ejemplo conceptual:

```
Main.tscn

↓

Bootstrap Node

↓

Framework Initialization

↓

Game Ready
```

Toda inicialización debe comenzar desde este nodo.

No deben existir múltiples Bootstraps.

---

# Bootstrap Node

Debe existir un nodo responsable exclusivamente del arranque del Framework.

Este nodo no contiene gameplay.

No contiene lógica ECS.

No ejecuta Systems.

Su única responsabilidad es coordinar la inicialización.

---

# Responsabilidad del Bootstrap Node

El Bootstrap Node:

- crea el Core;
- solicita la creación de servicios;
- espera la finalización de cada etapa;
- detecta errores;
- cancela el arranque si existe una dependencia inválida;
- inicia el Scheduler únicamente cuando todo el Framework está listo.

---

# Flujo General

El Framework sigue siempre el mismo flujo.

```
Engine

↓

Bootstrap

↓

Core

↓

Registries

↓

Resources

↓

Systems

↓

Scheduler

↓

World Ready

↓

Game Loop
```

No existen caminos alternativos.

---

# Bootstrap State Machine

El proceso de inicialización posee una máquina de estados interna.

Esto facilita:

- depuración;
- medición de tiempos;
- reinicios;
- servidores dedicados;
- pruebas automáticas;
- hot reload futuro.

---

# Estados

## UNINITIALIZED

Estado inicial.

Nada del Framework existe.

No hay servicios disponibles.

No pueden realizarse Queries.

No pueden emitirse Events.

---

## ENGINE_READY

Godot terminó de inicializar el árbol de nodos.

El Bootstrap obtiene control.

Todavía no existe ECS.

---

## CORE_CREATED

Se crea el objeto principal del Framework.

A partir de este momento existe un contexto ECS válido.

Todavía no existen Registries.

---

## REGISTRIES_INITIALIZED

Se crean:

- Entity Registry
- Component Registry
- Resource Registry

Los registros existen pero están vacíos.

---

## RESOURCES_LOADED

Se cargan todos los Resources necesarios para iniciar el Framework.

No se crean entidades.

No se ejecutan Systems.

---

## SYSTEMS_REGISTERED

Todos los Systems son registrados.

Todavía no se ejecutan.

No reciben eventos.

No realizan Queries.

---

## EVENT_BUS_READY

El Event Bus queda disponible.

Los Systems ya pueden suscribirse.

Todavía no existe ejecución.

---

## QUERY_ENGINE_READY

El motor de consultas queda operativo.

Las Queries pueden construirse.

Todavía no existe Game Loop.

---

## SAVE_PIPELINE_READY

La infraestructura de Save queda preparada.

No se carga ninguna partida todavía.

---

## NETWORK_READY

Se inicializa la infraestructura Multiplayer.

Dependiendo del modo:

- Single Player
- Host
- Dedicated Server
- Client

Se habilitan únicamente los servicios necesarios.

---

## WORLD_READY

Todo el Framework se encuentra preparado.

Todavía no se ejecuta ningún System.

Es el último punto seguro antes del Game Loop.

---

## RUNNING

Comienza el Scheduler.

A partir de este momento el Framework entra en ejecución normal.

No debe volver a ejecutarse el Bootstrap.

---

# Orden Obligatorio de Inicialización

El siguiente orden es obligatorio.

```
Bootstrap

↓

Core

↓

Entity Registry

↓

Component Registry

↓

Resource Registry

↓

Load Resources

↓

Register Systems

↓

Event Bus

↓

Query Engine

↓

Save Pipeline

↓

Networking

↓

Scheduler

↓

Framework Running
```

No puede alterarse.

---

# Dependencias

Cada etapa únicamente puede depender de etapas anteriores.

Nunca de etapas futuras.

Ejemplo:

```
Scheduler

depende de

Systems

Event Bus

Query Engine
```

Pero:

```
Query Engine

NO depende del Scheduler
```

Esto evita dependencias circulares.

---

# Validaciones

Antes de avanzar al siguiente estado el Bootstrap debe validar:

- inicialización correcta;
- dependencias satisfechas;
- registros creados;
- recursos disponibles;
- ausencia de duplicados;
- consistencia del Framework.

Si una validación falla el Bootstrap debe detenerse inmediatamente.

---

# Gestión de Errores

El Bootstrap nunca debe continuar después de un fallo crítico.

Los errores de inicialización son considerados fatales.

El Framework debe permanecer en un estado consistente.

Nunca parcialmente inicializado.

---

# Política de Fallos

Si ocurre un error crítico:

- detener el Scheduler;
- cancelar el Bootstrap;
- registrar el error;
- liberar recursos parcialmente creados;
- informar el motivo del fallo.

Nunca debe intentarse continuar.

---

# Idempotencia

El Bootstrap debe ejecutarse una única vez por ciclo de vida del Framework.

No debe ser reutilizado.

Para reiniciar el mundo deberá destruirse completamente el Framework actual antes de crear uno nuevo.

---

# Tiempo de Vida

El Bootstrap existe únicamente durante la inicialización.

Una vez alcanzado el estado **RUNNING**, su responsabilidad finaliza.

No participa del Game Loop.

No procesa eventos.

No actualiza entidades.

---

# Instrumentación

Cada etapa debe registrar:

- nombre de la etapa;
- hora de inicio;
- hora de finalización;
- duración;
- resultado;
- errores detectados.

Esto permitirá construir herramientas de diagnóstico sin modificar el Bootstrap.

---

# Consideraciones para Servidor Dedicado

El proceso de Bootstrap debe ser independiente de la existencia de una interfaz gráfica.

Debe poder ejecutarse en un servidor dedicado utilizando exactamente la misma secuencia de inicialización, omitiendo únicamente los servicios gráficos que no formen parte del Framework ECS.

---

# Consideraciones para Pruebas

El diseño del Bootstrap debe permitir:

- iniciar únicamente el Core;
- iniciar un subconjunto de servicios;
- reemplazar implementaciones por dobles de prueba (mocks o stubs);
- medir tiempos de inicialización;
- verificar dependencias automáticamente.

Estas capacidades serán utilizadas por la infraestructura de pruebas definida en `14_TESTING_IMPLEMENTATION.md`.

---

# Resultado Esperado

Al finalizar correctamente el Bootstrap deben cumplirse todas las siguientes condiciones:

- El Core ECS existe.
- Todos los Registries están inicializados.
- El Event Bus está disponible.
- El Query Engine está operativo.
- Los Resources requeridos fueron cargados.
- Los Systems fueron registrados.
- La infraestructura de Save está preparada.
- La infraestructura Multiplayer está preparada según el modo de ejecución.
- El Scheduler puede comenzar su ciclo de actualización.
- El Framework se encuentra en estado **RUNNING**.

A partir de este punto, la responsabilidad del Bootstrap concluye y el control pasa al Scheduler, que gestionará el ciclo de vida normal del Framework.
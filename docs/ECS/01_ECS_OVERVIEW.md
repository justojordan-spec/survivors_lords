# ECS Framework Overview

**Documento:** 01_ECS_OVERVIEW.md

**Fase:** ECS Framework

**Estado:** Draft

**Versión:** 1.0

---

# Objetivo

Este documento define la arquitectura general del Framework ECS que servirá como base para la implementación de Survivors Lords en Godot.

No describe reglas de gameplay.

No define mecánicas del juego.

Su propósito es establecer la organización interna del framework, las responsabilidades de cada elemento y la forma en que interactúan entre sí.

Todos los documentos posteriores de esta fase dependen de las definiciones establecidas aquí.

---

# Filosofía del Framework

El Framework ECS debe cumplir los siguientes principios:

- Modular
- Determinista
- Escalable
- Data Driven
- Event Driven
- Multiplayer Ready
- Server Authoritative
- Fácil de depurar
- Fácil de extender
- Bajo acoplamiento
- Alto rendimiento

Cada decisión técnica debe respetar estos principios.

---

# Principios Fundamentales

El framework se basa en cuatro elementos principales.

## Entity

Representa una entidad del mundo.

No contiene lógica.

No contiene comportamiento.

Solo identifica un conjunto de componentes.

Una Entity puede representar:

- jugador
- enemigo
- NPC
- edificio
- proyectil
- árbol
- roca
- animal
- item
- objeto del mundo
- efecto temporal

Todas son exactamente iguales para el framework.

La diferencia está determinada únicamente por sus componentes.

---

## Component

Los Components contienen únicamente datos.

Nunca ejecutan lógica.

Nunca llaman Systems.

Nunca realizan consultas.

Nunca conocen otros Components.

Nunca conocen Entities.

Nunca conocen Managers.

Son estructuras de datos puras.

---

## System

Los Systems contienen toda la lógica.

Toda.

No existen excepciones.

Los Systems:

- leen Components
- modifican Components
- generan Events
- realizan Queries
- crean Entities
- destruyen Entities

Nunca almacenan estado permanente.

---

## Resource

Los Resources contienen configuración.

Nunca contienen estado dinámico.

Son completamente Data Driven.

Toda configuración del framework y del juego debe provenir de Resources.

---

# Arquitectura General

El framework puede representarse mediante la siguiente relación lógica:

```text
                Resources
                     │
                     ▼
              Systems ejecutan lógica
                     │
      ┌──────────────┼──────────────┐
      ▼              ▼              ▼
 Components      Event Bus      Queries
      │              │              │
      └──────────────┼──────────────┘
                     ▼
                  Entities
```

Los Systems constituyen el núcleo del framework.

---

# Responsabilidades

## Entity

Responsable de:

- identidad
- ciclo de vida
- asociación de componentes

No es responsable de:

- comportamiento
- IA
- movimiento
- física
- networking
- rendering

---

## Component

Responsable de:

- almacenar datos

No es responsable de:

- validar datos
- actualizar datos
- sincronizar datos
- serializar datos
- enviar eventos

---

## System

Responsable de:

- ejecutar lógica
- procesar entidades
- modificar componentes
- emitir eventos
- responder eventos
- coordinar otros sistemas

---

## Resource

Responsable de:

- configuración
- parámetros
- datos estáticos

Nunca estado dinámico.

---

# Arquitectura Interna

El framework se divide en varias capas.

```text
Gameplay

↓

Systems

↓

Query Layer

↓

Component Storage

↓

Entity Registry

↓

Memory
```

Cada capa solo conoce la inmediatamente inferior.

Esto reduce el acoplamiento.

---

# Entity Registry

El Entity Registry es la autoridad sobre todas las entidades existentes.

Responsabilidades:

- crear entidades
- destruir entidades
- registrar componentes
- mantener índices
- reciclar IDs
- validar referencias

Ningún otro sistema puede crear entidades directamente.

---

# Component Storage

Los Components no viven dentro de las entidades.

Viven en almacenes especializados.

Ejemplo:

```text
Health Storage

Entity 1 → Health

Entity 5 → Health

Entity 12 → Health
```

Otro ejemplo:

```text
Transform Storage

Entity 1

Entity 2

Entity 8
```

Cada tipo de componente posee su propio almacenamiento.

---

# Separación Entity / EntityId / EntityHandle

## EntityId

Identificador persistente.

Se utiliza para:

- Save
- Multiplayer
- Logs
- Referencias

Nunca cambia.

---

## EntityHandle

Referencia temporal utilizada por el framework.

Puede invalidarse automáticamente.

Permite detectar:

- entidades destruidas
- reciclado de IDs
- referencias inválidas

---

## Entity

Representación lógica utilizada por el Entity Registry.

Nunca debe circular libremente entre Systems.

Los Systems trabajan mediante Handles y Queries.

---

# Flujo General

Cada frame sigue el siguiente flujo.

```text
Input

↓

Events

↓

Systems

↓

Queries

↓

Component Updates

↓

Generated Events

↓

Late Systems

↓

Network

↓

Save Snapshot
```

Este flujo será detallado en documentos posteriores.

---

# Comunicación

El framework prohíbe la comunicación directa entre Systems.

Toda comunicación debe realizarse mediante:

- Events
- Queries
- Interfaces públicas

Nunca mediante referencias directas.

---

# Queries

Los Systems nunca recorren manualmente todas las entidades.

Siempre utilizan el Query System.

Ejemplo conceptual:

```text
Todos los enemigos con:

Health

Transform

EnemyAI
```

La consulta devuelve únicamente las entidades válidas.

---

# Events

Los Events representan hechos ocurridos.

Ejemplos:

- EntityCreated
- ComponentAdded
- DamageApplied
- ItemPicked
- QuestCompleted

Los Events nunca contienen lógica.

Solo información.

---

# Scheduler

Todos los Systems son ejecutados por un Scheduler central.

Los Systems nunca se ejecutan entre sí.

El Scheduler controla:

- orden
- prioridades
- dependencias
- fases
- ejecución paralela futura

---

# Determinismo

Todo el framework debe producir el mismo resultado si recibe:

- mismo estado inicial
- mismos inputs
- mismo orden de ejecución

Este requisito es obligatorio para:

- Multiplayer
- Replay
- Save
- Debug

---

# Separación entre Datos y Lógica

El framework impone una separación estricta.

| Datos | Lógica |
|--------|--------|
| Components | Systems |
| Resources | Systems |
| Configuración | Systems |
| Estado | Systems |

Nunca debe existir lógica fuera de los Systems.

---

# Gestión de Estado

El estado del juego está distribuido en:

- Components
- World State
- Global Systems
- Runtime Registries

Nunca dentro de las entidades.

---

# Ciclo de Vida General

```text
Create Entity

↓

Attach Components

↓

Register

↓

Visible to Queries

↓

Processed by Systems

↓

Modified

↓

Events

↓

Destroy

↓

Recycle
```

---

# Integración con Godot

El framework utiliza Godot únicamente como plataforma.

Godot proporciona:

- SceneTree
- Rendering
- Physics
- Audio
- Input
- Networking
- ResourceLoader

El gameplay nunca depende directamente del SceneTree.

---

# Relación con Nodes

Los Nodes representan la visualización.

Las Entities representan la lógica.

Ambos mundos permanecen desacoplados.

Ejemplo:

```text
Entity

↓

TransformComponent

↓

RenderSystem

↓

Sprite2D
```

Nunca al revés.

---

# Data Driven

Todo comportamiento configurable proviene de Resources.

Ejemplos:

- armas
- enemigos
- recetas
- edificios
- buffs
- tecnologías

Los Systems únicamente interpretan dichos datos.

---

# Server Authoritative

El servidor es la autoridad absoluta.

Los clientes:

- solicitan acciones
- reciben resultados
- predicen cuando sea necesario

Nunca modifican el estado oficial.

---

# Escalabilidad

El framework debe permitir:

- decenas de miles de entidades
- cientos de componentes
- cientos de Systems
- múltiples mundos
- múltiples escenas
- servidores dedicados

Sin modificaciones estructurales.

---

# Objetivos de Rendimiento

El diseño debe minimizar:

- allocations
- búsqueda de componentes
- acceso indirecto
- consultas repetidas
- creación de objetos temporales

Se prioriza:

- cachés
- índices
- acceso contiguo
- reutilización de memoria

---

# Convenciones

El framework adopta las siguientes convenciones:

- Los Systems son los únicos que modifican estado.
- Los Components son estructuras de datos puras.
- Las Entities no contienen comportamiento.
- Los Resources son inmutables durante la ejecución.
- Todas las consultas pasan por el Query System.
- Toda comunicación pasa por el Event Bus o Interfaces.
- Toda creación y destrucción de entidades pasa por el Entity Registry.
- Ningún System depende directamente de otro System.
- El Scheduler es el único responsable del orden de ejecución.

---

# Dependencias del Framework

El resto de la documentación de esta fase amplía los conceptos introducidos aquí:

- **02_ENTITY_LIFECYCLE.md**: ciclo de vida y gestión de entidades.
- **03_COMPONENT_LIFECYCLE.md**: creación, modificación y eliminación de componentes.
- **04_SYSTEM_EXECUTION.md**: Scheduler, fases y orden de ejecución.
- **05_EVENT_BUS.md**: infraestructura de eventos.
- **06_QUERY_SYSTEM.md**: consultas, índices y cachés.
- **07_RESOURCE_LOADING.md**: carga y validación de Resources.
- **08_SAVE_PIPELINE.md**: serialización y restauración del estado ECS.
- **09_MULTIPLAYER_PIPELINE.md**: replicación y sincronización de entidades y componentes.
- **10_DEBUG_TOOLS.md**: inspección, profiling y herramientas de depuración.
- **11_TESTING_GUIDE.md**: estrategia de pruebas y validación del framework.

---

# Estado

**Estado actual:** Especificación base del Framework ECS.

Este documento constituye el contrato arquitectónico sobre el que se implementará el motor ECS de Survivors Lords. Cualquier evolución del framework deberá preservar los principios aquí definidos o justificar explícitamente su modificación mediante una decisión arquitectónica documentada (ADR/DEC), garantizando la coherencia con las fases previas del proyecto.
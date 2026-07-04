# 13. IMPLEMENTATION ROADMAP

---

# 1. Purpose

This document defines the official implementation roadmap for the Survivors Lords ECS Framework.

Unlike the architecture documents, this file does **not** describe how the engine is designed internally. Instead, it establishes **how the framework should be built**, in which order each subsystem should be implemented, which dependencies exist between modules, which milestones define progress, and which technical criteria determine completion.

The objective is to provide a long-term implementation strategy that enables multiple contributors to develop the framework consistently while preserving the architectural decisions already established.

This roadmap assumes that all architectural specifications have already been finalized and approved. No architectural redesign should occur during implementation unless explicitly authorized through a formal architecture revision process.

---

# 2. Scope

This roadmap covers the implementation of the complete Survivors Lords ECS Framework, including:

- Runtime Core
- ECS Core
- Scheduler
- Registry System
- Query Engine
- Event Bus
- Save System
- Multiplayer Foundation
- Tooling
- Testing
- Continuous Integration
- Documentation
- Release Strategy

Game-specific systems, gameplay mechanics, UI, rendering, audio, and content pipelines are outside the scope of this document.

---

# 3. Roadmap Objectives

The implementation roadmap has several primary objectives.

## 3.1 Predictable Development

Development should progress through well-defined phases with clear objectives.

Every implementation task should belong to a milestone.

No subsystem should be implemented "ad hoc".

---

## 3.2 Stable Foundations

Lower-level modules must be completed before higher-level systems begin implementation.

This minimizes architectural churn and reduces cascading changes.

---

## 3.3 Independent Verification

Every module should become fully testable before other systems depend on it.

Subsystem validation must occur continuously rather than at the end of development.

---

## 3.4 Controlled Integration

Integration should occur progressively.

Large integration phases involving multiple unfinished modules should be avoided.

---

## 3.5 Long-Term Maintainability

The roadmap prioritizes:

- deterministic behavior
- modularity
- documentation
- automated testing
- backwards compatibility
- safe refactoring

---

# 4. Implementation Principles

The following principles govern every implementation phase.

---

## 4.1 Architecture First

Architecture documents define the source of truth.

Implementation must conform to architecture.

Architecture must not be modified to simplify implementation.

---

## 4.2 Vertical Stability

A module is considered complete only when:

- implementation is finished
- unit tests pass
- integration tests pass
- documentation exists
- public API is stable

Coding alone does not constitute completion.

---

## 4.3 Incremental Complexity

Always implement the simplest deterministic version first.

Optimization occurs only after correctness has been validated.

---

## 4.4 Test Before Expansion

Every completed subsystem becomes part of the permanent regression suite before the next subsystem begins.

---

## 4.5 No Hidden Dependencies

Every dependency between modules must be explicit.

Circular dependencies are prohibited.

---

## 4.6 Deterministic Development

Implementation decisions must preserve:

- deterministic execution
- deterministic scheduling
- deterministic serialization
- deterministic networking

Performance improvements must never compromise determinism.

---

# 5. Global Development Strategy

The implementation progresses through successive dependency layers.

```
Infrastructure
      ↓
Core Runtime
      ↓
ECS Core
      ↓
Scheduler
      ↓
Registries
      ↓
Query Engine
      ↓
Event Bus
      ↓
Persistence
      ↓
Networking
      ↓
Optimization
      ↓
Release
```

Each layer assumes the previous one is complete.

---

# 6. Dependency Graph

The following dependency graph governs the implementation order.

```
Runtime
│
├──────── ECS
│          │
│          ├──────── Scheduler
│          │              │
│          │              ├──────── Registries
│          │              │
│          │              ├──────── Query Engine
│          │              │
│          │              ├──────── Event Bus
│          │              │
│          │              ├──────── Save System
│          │              │
│          │              └──────── Multiplayer
│          │
│          └──────── Tooling
│
└──────── Documentation
```

Dependencies always flow downward.

Reverse dependencies are prohibited.

---

# 7. Parallel Development Strategy

Not every module requires strict sequential implementation.

After foundational milestones are completed, several subsystems may be developed simultaneously.

---

## Phase A

Sequential only.

```
Infrastructure

↓

Runtime

↓

ECS
```

---

## Phase B

Limited parallelization.

```
Scheduler

↓

Registries
```

may proceed while internal ECS testing continues.

---

## Phase C

Parallel implementation becomes feasible.

```
Query Engine

Event Bus

Developer Tooling
```

can be developed independently.

---

## Phase D

Persistence and networking become independent work streams.

```
Save System

Multiplayer
```

may evolve concurrently once all runtime dependencies are stable.

---

# 8. Global Milestones

The implementation is divided into major milestones.

---

## Milestone M0

Project Infrastructure Ready

Deliverables:

- repository structure
- build system
- CI pipeline
- formatting
- linting
- testing framework

---

## Milestone M1

Runtime Operational

Deliverables:

- application lifecycle
- runtime loop
- module initialization
- shutdown pipeline

---

## Milestone M2

ECS Functional

Deliverables:

- entities
- components
- archetypes
- storage
- entity lifecycle

---

## Milestone M3

Scheduler Operational

Deliverables:

- stages
- schedules
- execution graph
- dependency validation

---

## Milestone M4

Core Gameplay Infrastructure

Deliverables:

- registries
- query engine
- event bus

---

## Milestone M5

Persistence

Deliverables:

- serialization
- save files
- loading
- version migration

---

## Milestone M6

Networking

Deliverables:

- replication
- snapshots
- synchronization
- rollback support

---

## Milestone M7

Framework Stabilization

Deliverables:

- optimization
- documentation
- benchmarks
- regression suite

---

## Milestone M8

Framework v1.0

Production-ready release.

---

# 9. Complexity Classification

Each subsystem receives an estimated implementation complexity.

| Complexity | Description |
|------------|-------------|
| Very Low | Self-contained implementation |
| Low | Limited dependencies |
| Medium | Multiple internal modules |
| High | Significant coordination required |
| Very High | Core framework subsystem |

Initial estimates:

| Module | Complexity |
|----------|-----------|
| Runtime | Medium |
| ECS | Very High |
| Scheduler | High |
| Registries | Medium |
| Query Engine | High |
| Event Bus | Medium |
| Save System | High |
| Multiplayer | Very High |
| Tooling | Medium |
| Documentation | Medium |

These estimates serve planning purposes only.

---

# 10. Phase 0 — Project Preparation

Objective:

Prepare a professional development environment before implementing any engine functionality.

No gameplay code.

No ECS implementation.

Only infrastructure.

---

## Goals

Establish a reproducible development environment.

Ensure every contributor produces identical builds.

Guarantee deterministic automation.

---

## Deliverables

### Repository organization

Create the complete repository hierarchy.

Examples include:

- source
- documentation
- tests
- benchmarks
- examples
- tools
- CI configuration

---

### Build system

Configure the official build pipeline.

Requirements:

- reproducible builds
- debug configuration
- release configuration
- warning configuration
- platform abstraction

---

### Formatting

Configure automatic formatting.

Formatting becomes mandatory before every merge.

---

### Static Analysis

Configure:

- compiler warnings
- static analyzers
- lint rules

Warnings should be treated as errors whenever practical.

---

### Unit Testing Framework

Establish the testing framework before engine code exists.

Every future subsystem will integrate into this environment.

---

### Benchmark Framework

Prepare benchmark infrastructure.

Performance tracking begins early.

---

### Continuous Integration

Configure automated pipelines for:

- build verification
- formatting verification
- lint verification
- unit tests
- integration tests

---

### Documentation Pipeline

Prepare documentation generation.

Documentation should be version-controlled alongside source code.

---

## Acceptance Criteria

Phase 0 is complete when:

- project builds successfully
- CI executes automatically
- formatting is enforced
- testing executes automatically
- benchmark framework exists
- documentation pipeline operates correctly

---

## Exit Checklist

- [ ] Repository initialized
- [ ] Build system operational
- [ ] CI configured
- [ ] Unit testing configured
- [ ] Benchmark framework configured
- [ ] Documentation structure created
- [ ] Coding standards published
- [ ] Contribution guidelines available

Completion of every item is mandatory before Phase 1.

---

# 11. Phase 1 — Runtime Foundation

Objective:

Implement the minimal runtime required to host every future subsystem.

The runtime acts as the execution environment of the framework.

No ECS behavior is implemented during this phase.

---

## Scope

The Runtime Foundation includes:

- engine startup
- shutdown
- initialization sequence
- module registration
- lifecycle management
- execution loop
- service bootstrap
- configuration loading
- error handling infrastructure
- logging infrastructure

Gameplay systems remain outside this phase.

---

## Primary Responsibilities

The runtime must provide a stable execution environment for every subsequent subsystem.

At the conclusion of this phase:

- the engine starts correctly,
- modules initialize deterministically,
- execution order is deterministic,
- graceful shutdown is guaranteed,
- diagnostic logging is operational.

---

## Internal Work Packages

### Package 1 — Core Bootstrap

Responsibilities:

- application entry point
- runtime creation
- initialization orchestration
- bootstrap sequencing

Acceptance Criteria:

- deterministic startup
- deterministic shutdown
- repeatable initialization

---

### Package 2 — Module Lifecycle

Implement lifecycle management.

Lifecycle states should include:

- Created
- Initialized
- Running
- Stopped
- Destroyed

Acceptance Criteria:

- state transitions validated
- invalid transitions rejected
- lifecycle logging available

---

### Package 3 — Runtime Loop

Implement the primary execution loop.

Responsibilities include:

- frame execution
- timing control
- update orchestration
- shutdown detection

Acceptance Criteria:

- loop executes continuously
- deterministic frame ordering
- clean termination

---

### Package 4 — Configuration System Integration

Integrate runtime configuration loading.

Responsibilities:

- load configuration
- validate configuration
- expose configuration services

Acceptance Criteria:

- invalid configuration detected safely
- defaults supported
- configuration accessible by future modules

---

### Package 5 — Logging Infrastructure

Implement centralized logging.

Logging should support:

- information
- warnings
- errors
- fatal failures
- diagnostics

Acceptance Criteria:

- thread-safe logging
- configurable verbosity
- structured output

---

### Package 6 — Error Infrastructure

Implement the common error handling layer.

Responsibilities:

- recoverable errors
- fatal errors
- assertions
- diagnostics

Acceptance Criteria:

- consistent reporting
- deterministic failure behavior
- meaningful debugging information

---

## Runtime Dependencies

The Runtime Foundation depends only on Phase 0 infrastructure.

No ECS module may depend on unfinished runtime features.

Runtime completion is therefore the first functional milestone of the framework.

---

## Runtime Testing Strategy

Testing should include:

### Unit Tests

- lifecycle transitions
- configuration loading
- logger behavior
- error propagation
- bootstrap validation

### Integration Tests

- full startup sequence
- repeated initialization
- repeated shutdown
- invalid initialization order
- configuration failures

### Stress Tests

- thousands of startup/shutdown cycles
- repeated module registration
- logging under heavy load
- error recovery scenarios

---

## Runtime Acceptance Criteria

The Runtime Foundation is considered complete only when:

- all lifecycle states are operational
- deterministic startup is verified
- deterministic shutdown is verified
- runtime loop executes reliably
- configuration loading is validated
- logging infrastructure is complete
- error infrastructure is operational
- automated tests pass consistently
- CI remains green throughout the phase

---

## Phase 1 Exit Checklist

- [x] Bootstrap complete
- [x] Runtime loop operational
- [x] Module lifecycle implemented
- [x] Configuration integrated
- [x] Logging completed
- [x] Error handling completed
- [ ] Unit tests passing
- [ ] Integration tests passing
- [ ] Stress tests passing
- [x] Documentation updated

**Estado (Sprint 1 — Runtime Foundation):** Implementado y verificado manualmente
(ejecución headless en Godot 4.7: arranque determinista hasta `RUNNING`,
5 frames de Runtime Loop, cierre limpio hasta `DESTROYED`, sin errores ni
advertencias). Código en `game/core/ecs/{bootstrap,core,interfaces,exceptions,utilities}/`.

Las pruebas unitarias, de integración y de stress quedaron deliberadamente
diferidas a la Fase 0B (Infraestructura profesional: CI, testing automatizado,
lint, benchmarks), por decisión explícita del Director tras la auditoría de
Fase 1 — se priorizó validar que el Framework arranca dentro de Godot antes de
construir la infraestructura de pruebas.

Completion of Phase 1 authorizes implementation of the ECS Core, which constitutes the first major functional subsystem of the Survivors Lords Framework.
# 12. Phase 2 — ECS Core

## Objective

Implement the complete Entity Component System (ECS) foundation exactly as defined in the architecture documentation.

This phase establishes the central data model upon which every remaining subsystem depends.

No higher-level framework feature (Scheduler, Query Engine, Event Bus, Save System, Multiplayer) may begin implementation until the ECS Core satisfies its acceptance criteria.

---

# 12.1 Scope

The ECS Core includes the implementation of:

- Entity management
- Component registration
- Component metadata
- Archetype management
- Chunk storage
- Entity migration
- Entity lifecycle
- Component lifecycle
- Component access
- Structural changes
- Storage validation
- Internal memory management

Game systems are **not** part of this phase.

---

# 12.2 Dependencies

Required:

- Runtime Foundation (Phase 1)

Consumers of this phase:

- Scheduler
- Query Engine
- Event Bus
- Save System
- Multiplayer
- Tooling
- Editor integrations

---

# 12.3 Internal Work Packages

Implementation should follow the dependency order below.

---

## Package 1 — Entity System

Responsibilities

- Entity identifiers
- Entity allocation
- Entity destruction
- Generation/version handling
- Entity validation
- Free list management

Deliverables

- Stable entity IDs
- Safe reuse of destroyed entities
- Invalid entity detection

Acceptance Criteria

- IDs remain unique
- Generation overflow handled safely
- Destroyed entities cannot be accessed
- Entity validation is deterministic

**Estado (Sprint 2):** Implementado y verificado. Código en
`game/core/ecs/entities/` (`EntityId`, `EntityStorage`, `EntityAllocator`,
`EntityValidator`, `EntityRegistry`) e interfaz `IEntityRegistry` en
`game/core/ecs/interfaces/`. `Bootstrap` inicializa el `EntityRegistry`
real en la etapa `REGISTRIES_INITIALIZED` y lo expone en `ECSContext`.
Verificado mediante `game/core/ecs/testing/entity_registry_dev_check.gd`
(script de desarrollo, no framework de pruebas automatizado) y una
ejecución headless completa del Bootstrap. Package 2 (Component Metadata)
en adelante permanece pendiente.

---

## Package 2 — Component Metadata

Responsibilities

- Component registration
- Component identifiers
- Type metadata
- Size metadata
- Alignment metadata
- Reflection metadata (if defined by architecture)

Acceptance Criteria

- Every component registered exactly once
- Duplicate registration rejected
- Metadata immutable after registration
- Component lookup deterministic

**Estado (Sprint 3A):** Implementado y verificado sólo el sistema de
tipos (Component registration / identifiers / type metadata / lookup).
Código en `game/core/ecs/components/` (`ComponentId`, `ComponentType`,
`ComponentMetadata`, `ComponentTypeRegistry`) y
`DuplicateRegistrationException` en `game/core/ecs/exceptions/`.
Size/Alignment/Reflection metadata no aplican a GDScript y no se
implementaron (no definidas por la arquitectura para este lenguaje).
Deliberadamente sin almacenamiento de Components, pools, sparse sets,
signatures ni integración con Bootstrap/ECSContext todavía — eso
corresponde a los siguientes sprints de este mismo Package.

**Estado (Sprint 3B):** Implementado y verificado el almacenamiento
interno de Components: `ComponentStorage` (sparse set: array denso +
disperso, swap-remove), `ComponentAllocator` (capacidad/crecimiento) y
`ComponentValidator` (entidad válida, tipo válido, componente existente),
en `game/core/ecs/components/`. Integrado con `EntityRegistry`/`IEntityRegistry`
(Sprint 2) y `ComponentTypeRegistry` (Sprint 3A) sólo a nivel de
validación, ejercitado con hasta 20.000 componentes en el script de
desarrollo. Todavía sin fachada `ComponentRegistry`/`IComponentRegistry`
ni integración con Bootstrap/ECSContext — corresponde al próximo sprint
de este Package.

**Estado (Sprint 3C):** Implementada la fachada `ComponentRegistry` /
`IComponentRegistry` en `game/core/ecs/components/component_registry.gd`
e interfaz en `game/core/ecs/interfaces/i_component_registry.gd`. API
pública (`register_component_type`, `add_component`, `replace_component`,
`remove_component`, `has_component`, `get_component`) trabaja
exclusivamente con `EntityId`/`ComponentId`; `ComponentStorage` deja de
usarse externamente y pasa a ser creado/administrado internamente por la
fachada (uno por tipo, de forma perezosa). Verificado con script de
desarrollo que sólo usa la API de `ComponentRegistry` (20.000 Components
en alta/baja masiva). Sin integración con Bootstrap/ECSContext, sin
destrucción automática de Components al destruir una entidad, sin
Signatures/Archetypes/Query Engine — corresponde a sprints posteriores.

**Estado (Sprint 4 — ECS Runtime Integration):** `ComponentRegistry`
integrado en `ECSContext` (campo tipado, junto a `EntityRegistry`) y
ensamblado por `Bootstrap` en la etapa `REGISTRIES_INITIALIZED`.
`EntityRegistry` expone `set_destruction_listener(callback: Callable)`
(sin dependencia de tipo hacia `ComponentRegistry`); `Bootstrap` conecta
`entity_registry.set_destruction_listener(component_registry.remove_all_components)`.
Al procesar destrucciones diferidas, `EntityRegistry` notifica antes de
reciclar el índice, y `ComponentRegistry.remove_all_components()` elimina
los Components de la entidad en todos los `ComponentStorage` creados.
`ECSContext.dispose()` (invocado en cascada desde `ECSRuntime.dispose()`)
libera `ComponentRegistry` y `EntityRegistry` en orden. Verificado con
script de desarrollo (`core/ecs/testing/runtime_integration_dev_check.gd`)
y ejecución completa del Bootstrap. **Cierra el Package Components
(Package 2) de la Fase 2.** Persisten como limitación conocida y
aceptada (ver informe del sprint): `remove_all_components()` es O(tipos
de Component con Storage creado), no O(componentes de la entidad) —
pendiente de resolver junto con Signatures/Archetypes si las métricas lo
justifican.

---

## Package 3 — Archetype Model

Responsibilities

- Archetype creation
- Archetype lookup
- Archetype hashing
- Signature comparison
- Archetype transitions

Acceptance Criteria

- Equal signatures produce identical archetypes
- Duplicate archetypes prevented
- Signature comparison deterministic
- Transition graph validated

---

## Package 4 — Chunk Storage

Responsibilities

- Chunk allocation
- Chunk reuse
- Component packing
- Capacity tracking
- Memory alignment
- Cache locality

Acceptance Criteria

- Components stored contiguously
- Alignment guaranteed
- Capacity limits enforced
- No invalid memory access

---

## Package 5 — Entity Migration

Responsibilities

- Add component
- Remove component
- Move entity between archetypes
- Copy component data
- Destroy obsolete records

Acceptance Criteria

- Data preserved during migration
- Entity identity unchanged
- Destination archetype valid
- Source cleanup verified

---

## Package 6 — Component Access

Responsibilities

- Read access
- Mutable access
- Validation
- Lookup
- Safety checks

Acceptance Criteria

- Invalid access rejected
- Missing components detected
- Access complexity matches architecture
- No undefined behavior

---

## Package 7 — Structural Changes

Responsibilities

- Deferred structural changes (if specified)
- Immediate structural changes
- Synchronization points
- Consistency guarantees

Acceptance Criteria

- Storage remains valid
- Deferred operations processed correctly
- Structural consistency preserved

---

## Package 8 — Memory Validation

Responsibilities

- Internal consistency verification
- Chunk validation
- Archetype validation
- Entity validation

Acceptance Criteria

- Corruption detected automatically
- Invalid states reported
- Debug diagnostics available

---

# 12.4 ECS Testing Strategy

Testing must begin alongside implementation.

Testing is not deferred.

---

## Unit Tests

Entity lifecycle

- Create entity
- Destroy entity
- Reuse entity
- Invalid entity detection

Component management

- Register component
- Duplicate registration
- Metadata lookup
- Component removal

Archetypes

- Signature creation
- Equality
- Transition validation
- Lookup

Chunks

- Allocation
- Deallocation
- Capacity
- Packing
- Alignment

Migration

- Add component
- Remove component
- Multi-component migration
- Large migrations

---

## Integration Tests

Scenarios

- Millions of entity creations
- Massive archetype transitions
- Repeated component additions
- Repeated removals
- Mixed workloads

---

## Stress Tests

Examples

- 10 million entity operations
- Continuous archetype migration
- Large memory fragmentation scenarios
- Random structural changes
- Long-running stability execution

---

## Performance Benchmarks

Metrics should include

- Entity creation time
- Entity destruction time
- Component lookup
- Component insertion
- Component removal
- Archetype migration
- Memory usage
- Cache efficiency

Benchmark baselines become permanent regression references.

---

# 12.5 ECS Acceptance Criteria

The ECS Core is complete only if:

- Entity management is stable
- Component registration finalized
- Archetype storage operational
- Chunk storage validated
- Migration verified
- Structural changes validated
- Unit tests pass
- Integration tests pass
- Benchmarks collected
- Documentation updated

---

# 12.6 ECS Exit Checklist

- [ ] Entity lifecycle complete
- [ ] Component metadata complete
- [ ] Archetypes complete
- [ ] Chunk storage complete
- [ ] Entity migration complete
- [ ] Component access complete
- [ ] Structural changes complete
- [ ] Validation tools complete
- [ ] Unit tests passing
- [ ] Integration tests passing
- [ ] Stress tests passing
- [ ] Benchmarks recorded
- [ ] Documentation updated

Completion of Phase 2 authorizes implementation of the Scheduler.

---

# Milestone M2 — ECS Functional

Deliverables

- Fully operational ECS
- Deterministic storage
- Stable archetypes
- Validated memory model
- Production-ready entity management

---

# 13. Phase 3 — Scheduler

## Objective

Implement the deterministic execution scheduler responsible for orchestrating every system in the framework.

The scheduler executes systems, enforces execution order, validates dependencies and guarantees deterministic behavior.

No gameplay scheduling should occur before this phase is complete.

**Estado (Sprint 5 — ECS System Foundation, prerrequisito de esta Fase):**
Implementada la infraestructura base de Systems que `docs/Implementation/
06_SYSTEM_BASE.md` exige antes del Scheduler: `ISystem` e `IECSContext`
(`game/core/ecs/interfaces/`), `SystemBase`, `SystemState` (ciclo de vida
mínimo: `CREATED → INITIALIZED → DISPOSED`) y `SystemPhase` (metadato
declarativo, sin comportamiento) en `game/core/ecs/systems/`. `ECSContext`
ahora extiende `IECSContext` y expone `get_entity_registry()`/
`get_component_registry()`. Ningún System conoce `ComponentStorage`,
`ComponentAllocator`, `EntityStorage` ni `EntityAllocator` — sólo los
contratos que expone el Context. Deliberadamente **no** implementados
todavía (dependen del Scheduler real): estados `Ready`/`Running`/
`Paused`/`Disabled`/`Error`, `SystemMetadata`, `SystemProfiler`,
`SystemValidator`, System Registry, ejecución por Queries. Ver el informe
del Sprint 5 para el detalle de las decisiones de simplificación.

---

# 13.1 Scope

Includes

- Schedule creation
- Stage management
- System registration
- Dependency graph
- Ordering validation
- Execution pipeline
- Conflict detection
- Deferred command synchronization
- Runtime scheduling interfaces

---

# 13.2 Dependencies

Requires

- Runtime
- ECS Core

Used by

- Query Engine
- Event Bus
- Save System
- Multiplayer
- Gameplay

---

# 13.3 Internal Work Packages

---

## Package 1 — Schedule Infrastructure

Responsibilities

- Schedule definitions
- Schedule registry
- Runtime ownership
- Schedule lifecycle

Acceptance Criteria

- Multiple schedules supported
- Registration deterministic
- Duplicate detection implemented

---

## Package 2 — Stage Management

Responsibilities

- Stage creation
- Stage ordering
- Stage execution
- Stage validation

Acceptance Criteria

- Order preserved
- Missing stages detected
- Invalid configurations rejected

---

## Package 3 — System Registration

Responsibilities

- Register systems
- Remove systems
- Metadata
- Identification

Acceptance Criteria

- Duplicate registration prevented
- Deterministic identifiers
- Stable registration lifecycle

---

## Package 4 — Dependency Graph

Responsibilities

- Directed dependency graph
- Dependency resolution
- Cycle detection
- Ordering validation

Acceptance Criteria

- Cycles rejected
- Stable execution graph
- Deterministic ordering

---

## Package 5 — Execution Engine

Responsibilities

- Execute schedules
- Execute stages
- Execute systems
- Error propagation
- Synchronization points

Acceptance Criteria

- Execution order validated
- Runtime failures isolated
- Deterministic execution verified

---

## Package 6 — Conflict Validation

Responsibilities

- Read/write conflicts
- Resource conflicts
- Scheduling diagnostics

Acceptance Criteria

- Invalid access detected
- Safe execution guaranteed
- Diagnostics available

---

## Package 7 — Deferred Command Synchronization

Responsibilities

- Apply deferred ECS changes
- Synchronization barriers
- Flush ordering

Acceptance Criteria

- Commands applied once
- Ordering deterministic
- ECS consistency maintained

---

# 13.4 Scheduler Testing

Unit Tests

- Schedule creation
- Stage ordering
- Registration
- Dependency resolution
- Cycle detection
- Deferred synchronization

Integration Tests

- Large execution graphs
- Thousands of systems
- Mixed dependencies
- Runtime scheduling

Stress Tests

- Continuous execution
- Random dependency graphs
- Invalid scheduling attempts
- Large-scale conflict detection

Performance Benchmarks

- Schedule execution overhead
- Dependency resolution cost
- Graph construction
- Synchronization cost
- Scheduling scalability

---

# 13.5 Scheduler Acceptance Criteria

The scheduler is complete when

- schedules execute correctly
- stage ordering validated
- dependency graph stable
- conflict detection operational
- deferred synchronization verified
- tests passing
- benchmarks recorded
- documentation finalized

---

# 13.6 Scheduler Exit Checklist

- [ ] Schedule infrastructure complete
- [ ] Stages complete
- [ ] System registry complete
- [ ] Dependency graph complete
- [ ] Execution engine complete
- [ ] Conflict validation complete
- [ ] Deferred synchronization complete
- [ ] Tests passing
- [ ] Benchmarks complete
- [ ] Documentation updated

Completion authorizes implementation of framework-level services.

---

# Milestone M3 — Scheduler Operational

Deliverables

- Stable scheduler
- Deterministic execution
- Dependency validation
- Production-ready scheduling

---

# 14. Phase 4 — Registry Systems

## Objective

Implement every registry described by the architecture as centralized providers of immutable metadata and runtime lookups.

Registries must expose stable APIs, deterministic behavior and efficient lookup operations while remaining independent from gameplay logic.

---

# 14.1 Scope

This phase includes all registry implementations defined by the architecture, such as:

- Component Registry
- Resource Registry
- System Registry
- Event Registry
- Serialization Registry
- Network Registry
- Any additional architecture-defined registries

The exact registry set must match the approved architecture documentation.

---

# 14.2 Dependencies

Requires

- Runtime
- ECS Core
- Scheduler

Used by

- Query Engine
- Event Bus
- Save System
- Multiplayer
- Developer Tooling

---

# 14.3 Internal Work Packages

## Package 1 — Registry Infrastructure

Responsibilities

- Common registry interfaces
- Registration lifecycle
- Validation
- Lookup APIs
- Internal storage

Acceptance Criteria

- Shared behavior consistent
- Duplicate registration prevented
- Immutable runtime state after initialization

---

## Package 2 — Individual Registry Implementation

Each registry should be implemented independently following the same validation strategy.

Acceptance Criteria

- Registration verified
- Lookup deterministic
- Invalid requests handled safely
- Public API documented

---

## Package 3 — Cross-Registry Validation

Responsibilities

- Dependency consistency
- Reference validation
- Initialization ordering

Acceptance Criteria

- Invalid references detected
- Registry initialization deterministic
- Circular dependencies prevented

---

# 14.4 Registry Testing

Unit Tests

- Registration
- Duplicate detection
- Lookup
- Removal (if applicable)
- Validation rules

Integration Tests

- Runtime initialization
- Scheduler interaction
- ECS interaction
- Cross-registry consistency

Stress Tests

- Large registration counts
- Repeated lookups
- Startup validation
- Long-running registry access

Performance Benchmarks

- Registration cost
- Lookup latency
- Memory footprint
- Initialization time

---

# 14.5 Registry Acceptance Criteria

Registries are complete when

- all architecture-defined registries are implemented
- deterministic initialization verified
- lookup performance validated
- duplicate protection operational
- integration tests pass
- benchmarks completed
- documentation finalized

---

# 14.6 Registry Exit Checklist

- [ ] Registry infrastructure complete
- [ ] All registries implemented
- [ ] Validation complete
- [ ] Integration verified
- [ ] Tests passing
- [ ] Benchmarks recorded
- [ ] Documentation updated

---

# Milestone M4 (Partially Complete)

At the end of Phase 4, the framework possesses:

- A production-ready Runtime
- A validated ECS Core
- A deterministic Scheduler
- Fully operational Registry Systems

These subsystems form the stable foundation required to begin implementation of higher-level framework services, including the Query Engine and Event Bus, which are covered in the next phase of the roadmap.
# 15. Phase 5 — Query Engine

## Objective

Implement the Query Engine responsible for efficiently retrieving entities that satisfy specific component constraints.

The Query Engine provides the primary interface through which systems iterate over ECS data. It must preserve deterministic behavior while maximizing cache efficiency and minimizing query overhead.

This implementation must strictly follow the architecture previously defined.

---

# 15.1 Scope

This phase includes:

- Query creation
- Query registration
- Query descriptors
- Query compilation
- Archetype matching
- Query caching
- Iteration interfaces
- Query invalidation
- Runtime query execution
- Internal optimization mechanisms defined by the architecture

No gameplay-specific queries should be introduced.

---

# 15.2 Dependencies

Requires:

- Runtime
- ECS Core
- Scheduler
- Registry Systems

Consumers:

- Event Bus
- Save System
- Multiplayer
- Gameplay Systems
- AI
- Physics
- Rendering
- Debug Tools

---

# 15.3 Internal Work Packages

---

## Package 1 — Query Representation

Responsibilities

- Query descriptors
- Component filters
- Include filters
- Exclude filters
- Read/write access metadata

Acceptance Criteria

- Query representation deterministic
- Filters validated
- Invalid definitions rejected

---

## Package 2 — Query Compilation

Responsibilities

- Compile descriptors
- Resolve metadata
- Produce executable query objects

Acceptance Criteria

- Compilation deterministic
- Duplicate compilation avoided
- Invalid metadata detected

---

## Package 3 — Archetype Matching

Responsibilities

- Signature matching
- Archetype discovery
- Matching cache
- Archetype updates

Acceptance Criteria

- Matching accuracy verified
- New archetypes detected correctly
- No stale references

---

## Package 4 — Query Cache

Responsibilities

- Cache compiled queries
- Cache archetype matches
- Invalidation rules

Acceptance Criteria

- Cache consistency maintained
- Correct invalidation
- Deterministic cache state

---

## Package 5 — Query Iteration

Responsibilities

- Iterate matching chunks
- Iterate matching entities
- Access component references
- Iterator validation

Acceptance Criteria

- Stable iteration order
- No invalid entities returned
- No duplicate iteration

---

## Package 6 — Runtime Updates

Responsibilities

- Detect structural ECS changes
- Refresh cached queries
- Synchronize with Scheduler barriers

Acceptance Criteria

- Query results always consistent
- Structural updates reflected correctly
- Deterministic synchronization

---

# 15.4 Query Testing Strategy

## Unit Tests

- Query creation
- Query compilation
- Filter validation
- Archetype matching
- Cache invalidation
- Iterator correctness

---

## Integration Tests

- Query execution across multiple archetypes
- Structural changes during execution
- Deferred command interaction
- Scheduler synchronization

---

## Stress Tests

- Millions of entities
- Thousands of archetypes
- Continuous structural mutations
- Massive query reuse

---

## Performance Benchmarks

Metrics include:

- Query compilation time
- Query execution time
- Cache hit ratio
- Cache invalidation cost
- Iteration throughput
- Archetype matching latency

Benchmark thresholds become part of future regression testing.

---

# 15.5 Query Engine Acceptance Criteria

The Query Engine is complete when:

- Query compilation is stable
- Archetype matching verified
- Cache validated
- Iteration deterministic
- Runtime synchronization operational
- Unit tests passing
- Integration tests passing
- Benchmarks recorded
- Documentation completed

---

# 15.6 Query Engine Exit Checklist

- [ ] Query descriptors complete
- [ ] Compiler complete
- [ ] Archetype matching complete
- [ ] Cache implemented
- [ ] Iterators validated
- [ ] Runtime synchronization complete
- [ ] Unit tests passing
- [ ] Integration tests passing
- [ ] Benchmarks recorded
- [ ] Documentation updated

Completion authorizes Event Bus implementation.

---

# 16. Phase 6 — Event Bus

## Objective

Implement the framework-wide event system used for deterministic communication between systems.

The Event Bus must provide predictable ordering, efficient dispatching and strict synchronization with the Scheduler.

Architectural decisions regarding event lifetime, buffering and execution order must not be modified during implementation.

---

# 16.1 Scope

Includes:

- Event definitions
- Event registration
- Event queues
- Event publishing
- Event subscriptions
- Dispatch pipeline
- Event buffering
- Scheduler synchronization
- Event lifetime management

---

# 16.2 Dependencies

Requires:

- Runtime
- ECS Core
- Scheduler
- Registry Systems
- Query Engine

Consumers:

- Save System
- Multiplayer
- Gameplay
- Tooling
- Diagnostics

---

# 16.3 Internal Work Packages

---

## Package 1 — Event Metadata

Responsibilities

- Event registration
- Metadata lookup
- Validation

Acceptance Criteria

- Duplicate registration prevented
- Metadata immutable
- Deterministic identifiers

---

## Package 2 — Subscription System

Responsibilities

- Subscriber registration
- Subscription validation
- Lifetime management

Acceptance Criteria

- Subscription ordering deterministic
- Duplicate subscriptions handled correctly
- Invalid subscriptions rejected

---

## Package 3 — Event Queues

Responsibilities

- Queue creation
- Buffer management
- Event insertion
- Queue cleanup

Acceptance Criteria

- FIFO guarantees preserved (or architecture-defined ordering)
- Queue integrity verified
- Memory usage bounded

---

## Package 4 — Dispatch Pipeline

Responsibilities

- Dispatch events
- Invoke subscribers
- Scheduler synchronization
- Error propagation

Acceptance Criteria

- Dispatch order deterministic
- Failed handlers isolated
- Queue consistency preserved

---

## Package 5 — Runtime Synchronization

Responsibilities

- Stage synchronization
- Deferred dispatch
- Frame barriers

Acceptance Criteria

- Events dispatched at correct synchronization points
- Scheduler integration validated
- Deterministic execution verified

---

# 16.4 Event Bus Testing

## Unit Tests

- Registration
- Subscription
- Queue operations
- Publishing
- Dispatch ordering
- Queue cleanup

---

## Integration Tests

- Scheduler integration
- ECS interaction
- Query interaction
- Large subscriber counts

---

## Stress Tests

- Millions of events
- Thousands of subscribers
- Continuous event production
- Mixed workloads

---

## Performance Benchmarks

Measure:

- Publish latency
- Dispatch throughput
- Queue allocation
- Subscription lookup
- Memory overhead

---

# 16.5 Event Bus Acceptance Criteria

Complete when:

- Registration validated
- Queue implementation stable
- Dispatch deterministic
- Scheduler integration complete
- Runtime synchronization verified
- Tests passing
- Benchmarks completed
- Documentation finalized

---

# 16.6 Event Bus Exit Checklist

- [ ] Registration complete
- [ ] Subscription system complete
- [ ] Queue implementation complete
- [ ] Dispatch complete
- [ ] Synchronization complete
- [ ] Unit tests passing
- [ ] Integration tests passing
- [ ] Benchmarks recorded
- [ ] Documentation updated

---

# Milestone M4 — Core Gameplay Infrastructure

At this milestone the framework provides:

- Runtime
- ECS Core
- Scheduler
- Registries
- Query Engine
- Event Bus

The engine is now capable of supporting deterministic gameplay execution.

Persistence and networking become the next major objectives.

---

# 17. Phase 7 — Save System

## Objective

Implement the complete persistence layer responsible for serializing and restoring framework state.

The Save System must preserve deterministic world reconstruction while supporting future schema evolution exactly as defined by the architecture.

No gameplay-specific serialization logic belongs in this phase.

---

# 17.1 Scope

Includes:

- Serialization pipeline
- Save creation
- Save loading
- World reconstruction
- Version handling
- Schema migration
- Validation
- Integrity verification
- Serialization registries defined by architecture

---

# 17.2 Dependencies

Requires:

- Runtime
- ECS Core
- Scheduler
- Registry Systems
- Query Engine
- Event Bus

Consumers:

- Multiplayer
- Gameplay
- Editor
- Tooling

---

# 17.3 Internal Work Packages

---

## Package 1 — Serialization Infrastructure

Responsibilities

- Serialization interfaces
- Serialization contexts
- Type resolution
- Runtime serialization services

Acceptance Criteria

- Deterministic serialization
- Stable interfaces
- Architecture compliance

---

## Package 2 — Save Writer

Responsibilities

- Serialize world
- Serialize entities
- Serialize components
- Serialize resources

Acceptance Criteria

- Complete world captured
- Stable output
- Deterministic ordering

---

## Package 3 — Save Loader

Responsibilities

- Parse save data
- Reconstruct entities
- Restore archetypes
- Restore resources

Acceptance Criteria

- Exact world reconstruction
- Validation performed
- Invalid saves rejected safely

---

## Package 4 — Version Management

Responsibilities

- Version identifiers
- Compatibility validation
- Schema migration hooks

Acceptance Criteria

- Older versions detected
- Migration path respected
- Unsupported versions rejected

---

## Package 5 — Integrity Validation

Responsibilities

- Consistency verification
- Corruption detection
- Diagnostics

Acceptance Criteria

- Corrupted saves detected
- Partial loads prevented
- Diagnostics available

---

# 17.4 Save System Testing Strategy

## Unit Tests

- Serialization
- Deserialization
- Version handling
- Integrity verification
- Metadata lookup

---

## Integration Tests

- Save/load complete worlds
- Large ECS worlds
- Runtime restoration
- Scheduler restart
- Registry reconstruction

---

## Stress Tests

- Extremely large saves
- Frequent save/load cycles
- Randomized world states
- Long-running persistence testing

---

## Performance Benchmarks

Track:

- Save duration
- Load duration
- Serialization throughput
- Compression overhead (if applicable)
- Memory consumption

---

# 17.5 Save System Acceptance Criteria

Complete when:

- Serialization validated
- Loading deterministic
- World reconstruction exact
- Version handling operational
- Integrity validation complete
- Tests passing
- Benchmarks recorded
- Documentation finalized

---

# 17.6 Save System Exit Checklist

- [ ] Serialization infrastructure complete
- [ ] Save writer complete
- [ ] Save loader complete
- [ ] Version management complete
- [ ] Integrity validation complete
- [ ] Unit tests passing
- [ ] Integration tests passing
- [ ] Stress tests passing
- [ ] Benchmarks recorded
- [ ] Documentation updated

---

# Milestone M5 — Persistence Complete

Deliverables

- Deterministic save pipeline
- Deterministic load pipeline
- Version-aware serialization
- Stable persistence layer
- Production-ready save infrastructure

With persistence completed, the framework has every major single-player subsystem required for deterministic execution.

The remaining large functional milestone is the Multiplayer Foundation, followed by framework stabilization, optimization, documentation, release engineering and the definition of Framework v1.0.
# 18. Phase 8 — Multiplayer Foundation

## Objective

Implement the deterministic multiplayer infrastructure exactly as defined in the Multiplayer Architecture document.

The purpose of this phase is **not** to build gameplay networking, but to provide the framework-level services required for authoritative simulation, synchronization, replication and long-term scalability.

No architectural redesign should occur during this phase.

---

# 18.1 Scope

This phase includes:

- Network runtime integration
- Connection management
- Session management
- Replication pipeline
- Snapshot generation
- Snapshot application
- State synchronization
- Interest management (if defined)
- Prediction support
- Rollback support (if defined)
- Network serialization integration
- Reliability layer integration (architecture-defined)
- Multiplayer diagnostics

---

# 18.2 Dependencies

Requires:

- Runtime
- ECS Core
- Scheduler
- Registries
- Query Engine
- Event Bus
- Save System

Consumers:

- Gameplay
- Dedicated Server
- Client Runtime
- Replay System
- Debug Tools

---

# 18.3 Internal Work Packages

## Package 1 — Network Runtime

Responsibilities

- Startup
- Shutdown
- Session lifecycle
- Runtime services

Acceptance Criteria

- Deterministic initialization
- Clean shutdown
- Runtime diagnostics available

---

## Package 2 — Replication

Responsibilities

- Entity replication
- Component replication
- Replication metadata
- Replication filtering

Acceptance Criteria

- Stable replication
- No duplicate replication
- Architecture-compliant behavior

---

## Package 3 — Snapshot System

Responsibilities

- Snapshot generation
- Snapshot serialization
- Snapshot restoration
- Delta support (if applicable)

Acceptance Criteria

- Deterministic snapshots
- Exact reconstruction
- Stable bandwidth characteristics

---

## Package 4 — Synchronization

Responsibilities

- Client synchronization
- Server synchronization
- State validation
- Time synchronization

Acceptance Criteria

- Predictable synchronization
- Stable latency handling
- Correct conflict resolution

---

## Package 5 — Prediction / Rollback

Implement only if specified by the architecture.

Acceptance Criteria

- Prediction deterministic
- Rollback deterministic
- State restoration validated

---

## Package 6 — Diagnostics

Responsibilities

- Network metrics
- Replication statistics
- Synchronization diagnostics
- Error reporting

Acceptance Criteria

- Runtime visibility
- Actionable diagnostics
- Stable monitoring interfaces

---

# 18.4 Multiplayer Testing Strategy

## Unit Tests

- Serialization
- Replication metadata
- Snapshot generation
- Synchronization rules
- Version compatibility

---

## Integration Tests

- Client/server startup
- Session lifecycle
- Entity replication
- Component updates
- World synchronization
- Save/Load interaction
- Event synchronization

---

## Stress Tests

Examples

- Thousands of replicated entities
- Continuous snapshot generation
- Long-running sessions
- Frequent joins/leaves
- High packet volume
- Artificial latency scenarios
- Packet loss scenarios

---

## Performance Benchmarks

Metrics

- Snapshot generation time
- Replication throughput
- Serialization cost
- Synchronization latency
- CPU overhead
- Memory consumption
- Bandwidth usage

---

# 18.5 Multiplayer Acceptance Criteria

Multiplayer is complete when:

- Replication validated
- Synchronization deterministic
- Snapshot pipeline operational
- Network diagnostics complete
- Integration tests passing
- Stress tests passing
- Benchmarks recorded
- Documentation finalized

---

# 18.6 Multiplayer Exit Checklist

- [ ] Runtime integration complete
- [ ] Replication complete
- [ ] Snapshot system complete
- [ ] Synchronization complete
- [ ] Prediction/Rollback complete (if applicable)
- [ ] Diagnostics complete
- [ ] Unit tests passing
- [ ] Integration tests passing
- [ ] Stress tests passing
- [ ] Benchmarks recorded
- [ ] Documentation updated

---

# Milestone M6 — Multiplayer Foundation Complete

The framework now contains every core subsystem defined by the architecture.

From this point onward, development shifts from feature implementation to stabilization, optimization and production readiness.

---

# 19. Phase 9 — Framework Stabilization

## Objective

Transform the completed implementation into a production-quality framework suitable for long-term maintenance.

This phase focuses on quality rather than functionality.

No new architectural features should be introduced.

---

# 19.1 Primary Activities

- Regression elimination
- Performance profiling
- Memory optimization
- API stabilization
- Documentation completion
- Benchmark validation
- Cross-platform verification
- Release preparation

---

# 19.2 Optimization Strategy

Optimization must follow a strict workflow:

1. Measure
2. Identify bottlenecks
3. Optimize
4. Benchmark
5. Verify correctness

No optimization should be accepted without measurable improvement.

---

## Optimization Priorities

1. ECS iteration
2. Archetype transitions
3. Scheduler overhead
4. Query execution
5. Event dispatch
6. Serialization
7. Networking
8. Memory allocation

---

# 19.3 Regression Testing

The regression suite must include:

- Unit tests
- Integration tests
- Stress tests
- Performance benchmarks
- Memory validation
- Determinism verification
- Cross-platform verification

Every bug fixed must introduce at least one regression test.

---

# 20. Continuous Integration Strategy

Continuous Integration becomes mandatory for all branches intended for integration.

---

## CI Pipeline Stages

1. Source checkout
2. Dependency validation
3. Formatting verification
4. Static analysis
5. Compilation
6. Unit tests
7. Integration tests
8. Stress tests (scheduled or nightly)
9. Benchmark execution (scheduled)
10. Documentation validation
11. Artifact generation

A merge into the primary branch is permitted only if all required stages succeed.

---

## Nightly Builds

Nightly automation should execute:

- Full benchmark suite
- Extended stress tests
- Memory leak detection
- Long-duration runtime validation
- Determinism verification

---

# 21. Safe Refactoring Strategy

Refactoring is permitted only when it does not alter the approved architecture.

Every refactor must satisfy the following conditions:

- Public behavior unchanged
- Tests remain green
- Benchmarks do not regress beyond accepted thresholds
- Documentation updated if APIs change
- Code review completed

Large refactors should be isolated into dedicated pull requests.

---

# 22. Documentation Strategy

Documentation evolves alongside implementation.

Documentation is considered part of the deliverable—not a post-release task.

---

## Documentation Levels

### Architecture

Already completed.

Must remain synchronized with implementation.

---

### API Documentation

Every public type should include:

- Purpose
- Responsibilities
- Parameters
- Return values
- Thread-safety (if applicable)
- Usage notes

---

### Developer Guides

Maintain guides covering:

- Framework initialization
- ECS usage
- Scheduler usage
- Query creation
- Event publishing
- Serialization
- Multiplayer integration
- Testing workflows

---

### Changelog

Every release must include:

- New features
- Fixes
- Breaking changes
- Migration notes
- Known issues

---

# 23. Versioning Strategy

The framework should follow **Semantic Versioning (SemVer)**.

Format:

```
MAJOR.MINOR.PATCH
```

---

## Major

Increment when introducing breaking API or behavioral changes.

Example:

```
1.x.x → 2.0.0
```

---

## Minor

Increment when adding backwards-compatible functionality.

Example:

```
1.2.0 → 1.3.0
```

---

## Patch

Increment when fixing bugs without changing public behavior.

Example:

```
1.2.3 → 1.2.4
```

---

## Release Candidates

Before major releases:

```
1.0.0-alpha
1.0.0-beta
1.0.0-rc1
1.0.0
```

---

# 24. Risk Assessment

| Risk | Impact | Mitigation |
|------|--------|------------|
| Architectural drift | High | Enforce architecture reviews before structural changes |
| Regression introduction | High | Comprehensive automated testing |
| Performance degradation | High | Benchmark-based validation |
| API instability | High | Freeze APIs before release candidates |
| Memory corruption | Critical | Validation tools, assertions and stress testing |
| Non-deterministic execution | Critical | Determinism regression suite |
| Incomplete documentation | Medium | Documentation required for milestone completion |
| Technical debt accumulation | Medium | Continuous refactoring and code reviews |

---

# 25. Complexity Summary

| Module | Complexity |
|--------|------------|
| Runtime | Medium |
| ECS Core | Very High |
| Scheduler | High |
| Registry Systems | Medium |
| Query Engine | High |
| Event Bus | Medium |
| Save System | High |
| Multiplayer | Very High |
| Tooling | Medium |
| Documentation | Medium |
| Testing Infrastructure | High |
| Release Engineering | Medium |

These estimates should be reviewed only if implementation scope changes through an approved architectural revision.

---

# 26. Definition of Framework v1.0

The Survivors Lords ECS Framework reaches **v1.0** only when all of the following conditions are satisfied.

---

## Functional Requirements

- Runtime fully operational
- ECS Core complete
- Scheduler complete
- Registry Systems complete
- Query Engine complete
- Event Bus complete
- Save System complete
- Multiplayer Foundation complete

---

## Quality Requirements

- No known critical defects
- All acceptance criteria satisfied
- Public APIs stabilized
- Performance benchmarks established
- Memory validation passing
- Determinism verified across supported platforms

---

## Testing Requirements

- Unit tests passing
- Integration tests passing
- Stress tests passing
- Regression suite passing
- Performance benchmarks recorded
- Nightly validation stable

---

## Documentation Requirements

- Architecture documents complete
- API documentation complete
- Developer guides complete
- Migration guides complete
- Release notes prepared

---

## Release Requirements

- CI pipeline stable
- Automated builds operational
- Version tagging established
- Release artifacts reproducible
- Licensing verified
- Repository prepared for public or internal production use

---

# Milestone M7 — Framework Stabilized

Deliverables

- Production-quality implementation
- Stable APIs
- Comprehensive automated testing
- Performance baselines
- Complete documentation
- Release candidate readiness

---

# Milestone M8 — Framework v1.0

Framework v1.0 represents the completion of the implementation roadmap defined in this document.

At this milestone the framework is considered a stable, deterministic and production-ready foundation for the long-term development of **Survivors Lords**.

Future development should prioritize:

- New features through incremental releases
- Backwards-compatible enhancements
- Performance improvements validated by benchmarks
- Expanded tooling
- Editor integrations
- Additional platform support
- Continuous maintenance under Semantic Versioning

No future work should compromise the architectural principles, determinism guarantees or implementation standards established throughout this roadmap.

---

# 27. Final Statement

This roadmap defines the official implementation strategy for the Survivors Lords ECS Framework.

Its purpose is to ensure that every subsystem is developed in a predictable, testable and maintainable manner while preserving the integrity of the approved architecture.

By adhering to this phased implementation plan, the framework can evolve over multiple years with controlled complexity, consistent engineering practices and a stable foundation suitable for both single-player and multiplayer game development.

Any deviation from this roadmap should be evaluated through the project's formal architecture governance process before implementation begins.

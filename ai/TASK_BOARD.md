# TASK BOARD

## TODO

- Fase 0B: CI, testing automatizado, lint, benchmarks
- ECS Core (Fase 2 del roadmap) — Package 3: Archetype Model / Signatures
- Scheduler (Fase 3): System Registry, Dependency Graph, Execution Engine
- GameManager
- SaveManager
- SceneManager
- Player Controller
- Cámara
- Combate
- IA enemiga
- Sistema de experiencia
- Inventario

---

## DOING

- (nada en curso — Sprint 5 cerrado, a la espera de aprobación para el siguiente sprint)

---

## DONE

- Configuración Git
- Configuración Godot
- Primer Commit
- Organización del proyecto
- Documentación inicial
- Auditoría técnica de Fase 1 (Fase 0A/0B definidas)
- Sprint 1 — Runtime Foundation: Bootstrap, Core/Runtime stub, Module Lifecycle,
  Runtime Loop, Configuration, Logging y Error Infrastructure
  (`game/core/ecs/`), verificado con ejecución headless de Godot 4.7
- Sprint 2 — ECS Core, Package 1 (Entity System): EntityId, EntityStorage,
  EntityAllocator, EntityValidator, EntityRegistry / IEntityRegistry
  (`game/core/ecs/entities/`), integrado en Bootstrap/ECSContext, verificado
  con script de desarrollo (`core/ecs/testing/entity_registry_dev_check.gd`)
  y ejecución headless completa
- Sprint 3A — ECS Core, Package 2 (Component Type System, sólo tipos):
  ComponentId, ComponentType, ComponentMetadata, ComponentTypeRegistry
  (`game/core/ecs/components/`), DuplicateRegistrationException
  (`game/core/ecs/exceptions/`), verificado con script de desarrollo
  (`core/ecs/testing/component_type_registry_dev_check.gd`); sin
  almacenamiento de Components ni integración con Bootstrap todavía
- Sprint 3B — ECS Core, Package 2 (Component Storage): ComponentStorage
  (sparse set), ComponentAllocator, ComponentValidator
  (`game/core/ecs/components/`), integrados con EntityRegistry/IEntityRegistry
  y ComponentTypeRegistry sólo para validación; verificado con script de
  desarrollo hasta 20.000 componentes
  (`core/ecs/testing/component_storage_dev_check.gd`); sin fachada
  ComponentRegistry ni integración con Bootstrap todavía
- Sprint 3C — ECS Core, Package 2 (Component Registry, fachada):
  ComponentRegistry / IComponentRegistry (`game/core/ecs/components/`,
  `game/core/ecs/interfaces/`), API pública basada en EntityId/ComponentId;
  ComponentStorage deja de usarse externamente (creado internamente, uno
  por tipo, de forma perezosa); verificado con script de desarrollo que
  sólo usa la API de la fachada (`core/ecs/testing/component_registry_dev_check.gd`,
  20.000 Components); sin integración con Bootstrap ni destrucción
  automática de Components todavía
- Sprint 4 — ECS Runtime Integration (cierra el Package Components):
  ComponentRegistry integrado en ECSContext y ensamblado por Bootstrap en
  REGISTRIES_INITIALIZED; EntityRegistry.set_destruction_listener()
  (Callable, sin dependencia de tipo) conecta la destrucción de entidades
  con ComponentRegistry.remove_all_components(); ECSContext.dispose() /
  ECSRuntime.dispose() en cascada; verificado con script de desarrollo
  (`core/ecs/testing/runtime_integration_dev_check.gd`) y ejecución
  completa del Bootstrap
- Sprint 5 — ECS System Foundation (prerrequisito del Scheduler):
  ISystem, IECSContext (`game/core/ecs/interfaces/`), SystemBase,
  SystemState, SystemPhase (`game/core/ecs/systems/`); ECSContext ahora
  implementa IECSContext; ningún System conoce Storage/Allocator internos;
  verificado con script de desarrollo (`core/ecs/testing/system_base_dev_check.gd`)
  y ejecución completa del Bootstrap; sin Query Engine, Scheduler,
  Event Bus ni gameplay todavía
# TASK BOARD

## TODO

- Fase 0B: CI, testing automatizado, lint, benchmarks
- ECS Core (Fase 2 del roadmap) — Package 2: Component Metadata en adelante
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

- (nada en curso — Sprint 2 cerrado, a la espera de aprobación para el Sprint 3)

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
## Contexto global del Runtime ECS (IECSContext).
##
## Punto de acceso controlado a los servicios principales del Framework.
## No crea servicios, no los destruye y no administra su ciclo de vida:
## eso es responsabilidad del Bootstrap y de cada servicio individual.
##
## Ver docs/Implementation/03_CORE_INTERFACES.md (IECSContext).
##
## En Sprint 1 (Runtime Foundation) ninguno de estos servicios existe
## todavía: los campos permanecen en null hasta que la fase del roadmap
## correspondiente (docs/Implementation/13_IMPLEMENTATION_ROADMAP.md) los
## implemente y el Bootstrap los registre aquí.
class_name ECSContext
extends RefCounted

var entity_registry: Object = null       ## TODO(Fase 2 - ECS Core)
var component_registry: Object = null    ## TODO(Fase 2 - ECS Core)
var system_registry: Object = null       ## TODO(Fase 3 - Scheduler)
var scheduler: Object = null             ## TODO(Fase 3 - Scheduler)
var event_bus: Object = null             ## TODO(Fase 6 - Event Bus)
var query_engine: Object = null          ## TODO(Fase 5 - Query Engine)
var resource_registry: Object = null     ## TODO(Fase 4 - Registries)
var save_pipeline: Object = null         ## TODO(Fase 7 - Save System)
var multiplayer_runtime: Object = null   ## TODO(Fase 8 - Multiplayer)

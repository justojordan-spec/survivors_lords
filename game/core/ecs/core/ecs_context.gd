## Contexto global del Runtime ECS (IECSContext).
##
## Punto de acceso controlado a los servicios principales del Framework.
## No crea servicios (eso es responsabilidad exclusiva del Bootstrap, que
## ensambla las dependencias y las registra aquí). Sí coordina su ciclo
## de vida compartido de cierre: dispose() libera todos los servicios que
## posee, en el orden inverso al que dependen entre sí (Sprint 4, "ECS
## Runtime Integration").
##
## Ver docs/Implementation/03_CORE_INTERFACES.md (IECSContext).
##
## Los servicios que todavía no existen permanecen en null hasta que la
## fase del roadmap correspondiente (docs/Implementation/
## 13_IMPLEMENTATION_ROADMAP.md) los implemente y el Bootstrap los
## registre aquí.
##
## Extiende IECSContext (herencia real: no hereda de Node) desde el
## Sprint 5, para que los Systems puedan depender únicamente de la
## abstracción y nunca de esta clase concreta.
class_name ECSContext
extends IECSContext

var entity_registry: EntityRegistry = null        ## Fase 2, Package 1 (Sprint 2)
var component_registry: ComponentRegistry = null  ## Fase 2, Package 2 (Sprint 3C/4)
var system_registry: Object = null       ## TODO(Fase 3 - Scheduler)
var scheduler: Object = null             ## TODO(Fase 3 - Scheduler)
var event_bus: Object = null             ## TODO(Fase 6 - Event Bus)
var query_engine: Object = null          ## TODO(Fase 5 - Query Engine)
var resource_registry: Object = null     ## TODO(Fase 4 - Registries)
var save_pipeline: Object = null         ## TODO(Fase 7 - Save System)
var multiplayer_runtime: Object = null   ## TODO(Fase 8 - Multiplayer)


## Libera los servicios que este Context posee, en orden inverso al de
## sus dependencias (Component Registry depende de Entity Registry para
## validar, así que se libera primero). Servicios todavía no
## implementados (null) se ignoran sin error.
func dispose() -> void:
	if component_registry != null:
		component_registry.dispose()
	if entity_registry != null:
		entity_registry.dispose()


## IECSContext.get_entity_registry() — acceso abstracto para consumidores
## (Systems) que no deben depender de la clase concreta ECSContext.
func get_entity_registry() -> IEntityRegistry:
	return entity_registry


## IECSContext.get_component_registry() — ídem para ComponentRegistry.
func get_component_registry() -> IComponentRegistry:
	return component_registry

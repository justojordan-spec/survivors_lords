## Contrato: IECSContext.
##
## Punto de acceso controlado a los servicios principales del Runtime,
## expuesto a consumidores que sólo deben depender de abstracciones (en
## este Sprint, los Systems). Nunca expone implementaciones concretas de
## almacenamiento (ComponentStorage, ComponentAllocator, EntityStorage,
## EntityAllocator): sólo los contratos públicos de los Registries.
##
## Ver docs/Implementation/03_CORE_INTERFACES.md (IECSContext) y
## docs/Implementation/06_SYSTEM_BASE.md ("Inyección del Contexto",
## "System Context").
class_name IECSContext
extends RefCounted


func get_entity_registry() -> IEntityRegistry:
	push_error("IECSContext.get_entity_registry() no implementado por %s" % [get_script()])
	return null


func get_component_registry() -> IComponentRegistry:
	push_error("IECSContext.get_component_registry() no implementado por %s" % [get_script()])
	return null

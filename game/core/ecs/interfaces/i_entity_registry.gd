## Contrato: IEntityRegistry.
##
## Autoridad única sobre el ciclo de vida de las Entities del Runtime.
## Ningún otro módulo puede crear o destruir entidades directamente.
##
## Ver docs/Implementation/03_CORE_INTERFACES.md (IEntityRegistry) y
## docs/Implementation/04_ENTITY_REGISTRY.md.
class_name IEntityRegistry
extends RefCounted


## Crea una nueva Entity y devuelve su EntityId. Debe quedar ALIVE.
func create_entity() -> int:
	push_error("IEntityRegistry.create_entity() no implementado por %s" % [get_script()])
	return EntityId.INVALID


## Solicita la destrucción de una Entity (destrucción diferida).
## Devuelve false si el identificador ya era inválido.
func destroy_entity(_id: int) -> bool:
	push_error("IEntityRegistry.destroy_entity() no implementado por %s" % [get_script()])
	return false


## true si el identificador corresponde a una Entity actualmente viva.
func is_alive(_id: int) -> bool:
	push_error("IEntityRegistry.is_alive() no implementado por %s" % [get_script()])
	return false


## Ejecuta el pipeline de destrucción diferida sobre las entidades
## pendientes. Devuelve la cantidad de entidades procesadas.
func process_pending_destructions() -> int:
	push_error("IEntityRegistry.process_pending_destructions() no implementado por %s" % [get_script()])
	return 0

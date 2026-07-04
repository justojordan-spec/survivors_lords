## Contrato: IComponentRegistry.
##
## Único punto de entrada autorizado para interactuar con los Components
## del ECS. Toda la API pública trabaja con EntityId y ComponentId
## opacos; ningún consumidor externo conoce índices internos ni el
## ComponentStorage subyacente.
##
## Ver docs/Implementation/05_COMPONENT_REGISTRY.md (IComponentRegistry,
## "Arquitectura Interna").
class_name IComponentRegistry
extends RefCounted


## Registra un nuevo tipo de Component y devuelve su ComponentId estable.
func register_component_type(_type_name: StringName) -> int:
	push_error("IComponentRegistry.register_component_type() no implementado por %s" % [get_script()])
	return ComponentId.INVALID


## Añade un Component de un tipo ya registrado a una entidad viva.
func add_component(_entity_id: int, _component_id: int, _data: Variant) -> bool:
	push_error("IComponentRegistry.add_component() no implementado por %s" % [get_script()])
	return false


## Sobrescribe el dato de un Component que la entidad ya posee.
func replace_component(_entity_id: int, _component_id: int, _data: Variant) -> bool:
	push_error("IComponentRegistry.replace_component() no implementado por %s" % [get_script()])
	return false


## Elimina el Component de un tipo determinado de una entidad.
func remove_component(_entity_id: int, _component_id: int) -> bool:
	push_error("IComponentRegistry.remove_component() no implementado por %s" % [get_script()])
	return false


## true si la entidad posee un Component de ese tipo.
func has_component(_entity_id: int, _component_id: int) -> bool:
	push_error("IComponentRegistry.has_component() no implementado por %s" % [get_script()])
	return false


## Devuelve el dato del Component, o null si la entidad no lo posee.
func get_component(_entity_id: int, _component_id: int) -> Variant:
	push_error("IComponentRegistry.get_component() no implementado por %s" % [get_script()])
	return null

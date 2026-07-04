## Validaciones centralizadas para operaciones sobre Components
## (ComponentValidator).
##
## Responsabilidad:
##   Verificar de forma consistente que una entidad está viva, que un
##   tipo de Component está registrado y que un Storage determinado ya
##   posee (o no) un componente para una entidad — evitando duplicar
##   estas comprobaciones en el resto del Framework
##   (docs/Implementation/05_COMPONENT_REGISTRY.md, "Component Validator",
##   "Validaciones"). No realiza lógica de gameplay ni decide qué hacer
##   con el resultado: sólo responde preguntas.
##
## Dependencias: IEntityRegistry (validar entidad viva), ComponentTypeRegistry
##   (validar tipo registrado), EntityId (extraer el índice físico de un
##   EntityId). No depende de Query Engine, Systems, Scheduler, Bootstrap
##   ni Gameplay.
##
## Invariantes:
##   - Nunca modifica el estado de EntityRegistry, ComponentTypeRegistry
##     ni de ningún ComponentStorage recibido por parámetro.
##
## Complejidad: is_entity_valid(), is_type_valid() y has_component() son
##   O(1).
class_name ComponentValidator
extends RefCounted

var _entity_registry: IEntityRegistry
var _type_registry: ComponentTypeRegistry


func _init(entity_registry: IEntityRegistry, type_registry: ComponentTypeRegistry) -> void:
	_entity_registry = entity_registry
	_type_registry = type_registry


## true si el EntityId corresponde a una entidad actualmente viva. O(1).
func is_entity_valid(entity_id: int) -> bool:
	return _entity_registry.is_alive(entity_id)


## true si el ComponentId corresponde a un tipo registrado. O(1).
func is_type_valid(component_id: int) -> bool:
	return _type_registry.get_metadata(component_id) != null


## true si la entidad ya posee un componente en el Storage indicado.
## Se usa tanto para detectar duplicados (antes de insertar) como para
## confirmar existencia (antes de leer o eliminar). O(1).
func has_component(entity_id: int, storage: ComponentStorage) -> bool:
	return storage.has(EntityId.index_of(entity_id))

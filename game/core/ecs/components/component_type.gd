## Declaración de un tipo de Component a registrar (ComponentType).
##
## Responsabilidad:
##   Representar, antes de su registro, el nombre estable que identifica
##   a un tipo de Component (docs/Implementation/05_COMPONENT_REGISTRY.md,
##   "Component Type Registry": "TransformComponent → Type ID 1"). Es un
##   objeto de valor puro: no contiene lógica ni se modifica una vez
##   creado.
##
## Dependencias: ninguna.
##
## Invariantes:
##   - type_name nunca cambia después de construido.
##
## Complejidad: is_valid() es O(1).
class_name ComponentType
extends RefCounted

var type_name: StringName


func _init(p_type_name: StringName) -> void:
	type_name = p_type_name


## Una declaración es válida si posee un nombre no vacío. O(1).
func is_valid() -> bool:
	return type_name != &""

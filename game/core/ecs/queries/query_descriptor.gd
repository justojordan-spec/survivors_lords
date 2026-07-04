## Descripción inmutable de una consulta ECS (QueryDescriptor / IQuery).
##
## Responsabilidad:
##   Representar qué Components necesita un System — nunca cómo
##   obtenerlos. No ejecuta ninguna búsqueda, no conoce EntityStorage,
##   ComponentStorage, ComponentAllocator, Dense/Sparse Arrays, índices
##   internos ni el Scheduler (docs/ECS/06_QUERY_SYSTEM.md, "¿Qué es una
##   Query?", "Componentes de una Query", "Inmutabilidad").
##
## Dependencias: ninguna. Describe ComponentId (enteros ya asignados por
##   ComponentTypeRegistry), nunca clases ni Scripts de Component — ver
##   "Decisión: ComponentId vs. referencias de clase" en el informe del
##   Sprint 6.
##
## Invariantes:
##   - Inmutable tras construirse: los tres arrays internos se congelan
##     con Array.make_read_only() en el constructor; cualquier intento
##     externo de modificarlos falla en tiempo de ejecución en lugar de
##     corromper silenciosamente el descriptor.
##   - Segura para compartirse y reutilizarse entre múltiples Systems de
##     forma simultánea: no existe ningún estado mutable que proteger.
##   - Un ComponentId nunca aparece simultáneamente en requeridos y
##     excluidos (QueryBuilder.build() lo valida antes de construir).
##
## Complejidad: get_required_components(), get_excluded_components(),
##   get_optional_components(), requires(), excludes() e is_optional()
##   son O(1) — devuelven/consultan arrays ya construidos, sin recalcular
##   ni duplicar nada en cada llamada.
class_name QueryDescriptor
extends IQuery

var _required: Array[int]
var _excluded: Array[int]
var _optional: Array[int]


## Los arrays recibidos se duplican una única vez (para no compartir
## referencia con el array mutable del QueryBuilder que los originó) y
## luego se congelan permanentemente.
func _init(required: Array[int], excluded: Array[int], optional: Array[int]) -> void:
	_required = required.duplicate()
	_required.make_read_only()
	_excluded = excluded.duplicate()
	_excluded.make_read_only()
	_optional = optional.duplicate()
	_optional.make_read_only()


func get_required_components() -> Array[int]:
	return _required


func get_excluded_components() -> Array[int]:
	return _excluded


func get_optional_components() -> Array[int]:
	return _optional


func requires(component_id: int) -> bool:
	return _required.has(component_id)


func excludes(component_id: int) -> bool:
	return _excluded.has(component_id)


func is_optional(component_id: int) -> bool:
	return _optional.has(component_id)

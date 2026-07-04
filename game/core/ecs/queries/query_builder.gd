## Constructor de QueryDescriptor con API fluida y segura (QueryBuilder).
##
## Responsabilidad:
##   Permitir declarar de forma clara qué ComponentId requiere, excluye u
##   opcionalmente admite un System, y producir un QueryDescriptor
##   inmutable a partir de esa declaración (docs/ECS/06_QUERY_SYSTEM.md,
##   "Query Builder"). Nunca ejecuta ninguna búsqueda ni conoce el
##   almacenamiento.
##
## Dependencias: QueryDescriptor, ComponentId (sólo para is_valid()).
##   Ninguna otra: no depende de ComponentTypeRegistry, ComponentRegistry,
##   EntityRegistry ni de ningún almacenamiento — trabaja exclusivamente
##   con ComponentId ya resueltos por el llamador.
##
## Invariantes:
##   - with_component()/without_component()/with_optional_component()
##     ignoran (con warning) un ComponentId inválido (ComponentId.INVALID)
##     y nunca agregan duplicados dentro de la misma lista.
##   - build() rechaza (con error, devolviendo null) un ComponentId que
##     aparezca simultáneamente como requerido y excluido: sería una
##     condición de coincidencia imposible de satisfacer.
##   - El Builder puede reutilizarse después de build() para construir
##     descriptors adicionales; cada QueryDescriptor producido es
##     independiente e inmutable.
##
## Complejidad: with_component(), without_component() y
##   with_optional_component() son O(1) amortizado (chequeo de
##   duplicados + append). build() es O(n) sobre la cantidad total de
##   Components declarados, por la validación de solapamiento.
class_name QueryBuilder
extends RefCounted

var _required: Array[int] = []
var _excluded: Array[int] = []
var _optional: Array[int] = []


## Declara un ComponentId requerido. Devuelve self para encadenar llamadas.
func with_component(component_id: int) -> QueryBuilder:
	_append_unique(_required, component_id, "with_component")
	return self


## Declara un ComponentId excluido. Devuelve self para encadenar llamadas.
func without_component(component_id: int) -> QueryBuilder:
	_append_unique(_excluded, component_id, "without_component")
	return self


## Declara un ComponentId opcional: su presencia nunca descarta la
## Entity ni es obligatoria. Devuelve self para encadenar llamadas.
func with_optional_component(component_id: int) -> QueryBuilder:
	_append_unique(_optional, component_id, "with_optional_component")
	return self


## Construye el QueryDescriptor inmutable. Devuelve null (con error) si
## la configuración es contradictoria: un mismo ComponentId no puede
## estar simultáneamente en requeridos y excluidos.
func build() -> QueryDescriptor:
	for component_id in _required:
		if _excluded.has(component_id):
			push_error("QueryBuilder.build(): ComponentId %d declarado como requerido y excluido a la vez" % component_id)
			return null
	return QueryDescriptor.new(_required, _excluded, _optional)


func _append_unique(list: Array[int], component_id: int, caller: String) -> void:
	if not ComponentId.is_valid(component_id):
		push_warning("QueryBuilder.%s(): ComponentId inválido, se ignora" % caller)
		return
	if not list.has(component_id):
		list.append(component_id)

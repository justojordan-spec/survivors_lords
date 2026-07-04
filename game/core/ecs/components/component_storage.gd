## Almacenamiento físico de un tipo de Component (ComponentStorage).
##
## Responsabilidad:
##   Almacenar de forma contigua (sparse set: array denso + array
##   disperso) los datos de UN único tipo de Component, indexados por el
##   índice físico de la entidad propietaria. No interpreta los datos que
##   almacena (docs/Implementation/05_COMPONENT_REGISTRY.md, "Component
##   Storage", "Organización del Almacenamiento", "Localidad de Memoria").
##
## Dependencias: ComponentAllocator (política de capacidad del array
##   denso). No conoce EntityId, EntityRegistry, ComponentTypeRegistry,
##   Query Engine, Systems, Gameplay, Bootstrap ni Scheduler: recibe
##   siempre el índice físico de la entidad ya resuelto por el llamador
##   (ver ComponentValidator).
##
## Invariantes:
##   - El array denso nunca contiene huecos: toda posición [0, count())
##     corresponde a un componente vivo (mantenido mediante swap-remove).
##   - Una entidad posee como máximo una posición en el array denso de
##     este Storage a la vez.
##   - _sparse[entity_index] == _NONE si y sólo si esa entidad no tiene
##     componente en este Storage.
##   - add() asume que la entidad NO posee ya un componente aquí; remove()
##     y replace() asumen que SÍ lo posee. Verificarlo es responsabilidad
##     del llamador (ComponentValidator), no de este Storage.
##
## Complejidad: has(), get_data(), add(), replace() y remove() son O(1)
##   amortizado. reserve() es O(n) sobre la capacidad solicitada.
class_name ComponentStorage
extends RefCounted

const _NONE: int = -1

var _allocator: ComponentAllocator
var _dense_data: Array = []
var _dense_entities: PackedInt64Array = PackedInt64Array()
var _sparse: PackedInt64Array = PackedInt64Array()


func _init(allocator: ComponentAllocator) -> void:
	_allocator = allocator


## Pre-reserva capacidad en el array denso para reducir reasignaciones
## durante inserciones masivas. Nunca crea Components. O(n).
func reserve(capacity: int) -> void:
	_allocator.reserve(capacity)
	_grow_dense_arrays_if_needed()


func count() -> int:
	return _allocator.used_count()


## true si la entidad (por índice físico) posee un componente aquí. O(1).
func has(entity_index: int) -> bool:
	return entity_index >= 0 and entity_index < _sparse.size() and _sparse[entity_index] != _NONE


## Devuelve el dato almacenado, o null si la entidad no posee componente
## en este Storage. O(1).
func get_data(entity_index: int) -> Variant:
	if not has(entity_index):
		return null
	return _dense_data[_sparse[entity_index]]


## Inserta un nuevo dato para la entidad indicada. O(1) amortizado.
func add(entity_index: int, data: Variant) -> void:
	_ensure_sparse_capacity(entity_index)
	var slot := _allocator.allocate_slot()
	_grow_dense_arrays_if_needed()
	_dense_data[slot] = data
	_dense_entities[slot] = entity_index
	_sparse[entity_index] = slot


## Sobrescribe el dato de una entidad que ya posee componente aquí, sin
## reubicarla en el array denso. Devuelve false si la entidad no tenía
## componente (en ese caso debe usarse add()). O(1).
func replace(entity_index: int, data: Variant) -> bool:
	if not has(entity_index):
		return false
	_dense_data[_sparse[entity_index]] = data
	return true


## Elimina el componente de una entidad mediante swap-remove: mueve el
## último elemento denso a la posición liberada, manteniendo el array
## siempre compacto (sin huecos). O(1).
func remove(entity_index: int) -> void:
	var slot: int = _sparse[entity_index]
	var last_slot := _allocator.used_count() - 1

	if slot != last_slot:
		_dense_data[slot] = _dense_data[last_slot]
		_dense_entities[slot] = _dense_entities[last_slot]
		_sparse[_dense_entities[slot]] = slot

	_dense_data[last_slot] = null
	_dense_entities[last_slot] = _NONE
	_sparse[entity_index] = _NONE
	_allocator.release_slot()


func _ensure_sparse_capacity(entity_index: int) -> void:
	while _sparse.size() <= entity_index:
		_sparse.append(_NONE)


func _grow_dense_arrays_if_needed() -> void:
	var capacity := _allocator.capacity()
	if _dense_data.size() < capacity:
		_dense_data.resize(capacity)
	if _dense_entities.size() < capacity:
		_dense_entities.resize(capacity)

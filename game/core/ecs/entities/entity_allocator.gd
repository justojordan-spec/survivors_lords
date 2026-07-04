## Asignador de identificadores de Entity (EntityAllocator).
##
## Responsabilidad:
##   Generar EntityId nuevos y reciclar índices liberados, incrementando
##   su generación para invalidar automáticamente cualquier EntityId
##   anterior que apuntara al mismo índice. No conoce Components ni
##   Systems (docs/Implementation/04_ENTITY_REGISTRY.md, "Entity Allocator").
##
## Dependencias: EntityStorage (para reservar slots nuevos y consultar/
##   incrementar generaciones). No depende de EntityValidator ni de
##   EntityRegistry.
##
## Invariantes:
##   - Un índice nunca aparece dos veces simultáneamente en la lista de
##     libres.
##   - Un índice cuya generación alcanza EntityId.MAX_GENERATION se retira
##     permanentemente (nunca vuelve a la lista de libres), evitando que
##     un EntityId antiguo vuelva a ser válido por desbordamiento de la
##     generación ("Generaciones", "Reutilización de Identificadores").
##
## Complejidad: allocate() y release() son O(1) amortizado.
class_name EntityAllocator
extends RefCounted

var _storage: EntityStorage
var _free_indices: Array[int] = []
var _retired_count: int = 0


func _init(storage: EntityStorage) -> void:
	_storage = storage


## Reserva un EntityId, reutilizando un índice reciclado cuando hay alguno
## disponible; si no, reserva un slot nuevo en el Storage. O(1) amortizado.
func allocate() -> int:
	var index: int
	if _free_indices.is_empty():
		index = _storage.allocate_slot()
	else:
		index = _free_indices.pop_back()
		_storage.set_state(index, EntityStorage.State.ALLOCATED)
	return EntityId.pack(index, _storage.get_generation(index))


## Libera un índice para su futura reutilización, incrementando su
## generación. Si la generación alcanza el máximo representable, el
## índice se retira permanentemente en lugar de reciclarse. O(1).
func release(index: int) -> void:
	_storage.increment_generation(index)
	if _storage.get_generation(index) >= EntityId.MAX_GENERATION:
		_retired_count += 1
		return
	_free_indices.append(index)


func free_count() -> int:
	return _free_indices.size()


func retired_count() -> int:
	return _retired_count

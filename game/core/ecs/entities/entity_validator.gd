## Validador centralizado de EntityId (EntityValidator).
##
## Responsabilidad:
##   Verificar de forma consistente si un EntityId corresponde a una
##   Entity actualmente viva, evitando duplicar esta comprobación en el
##   resto del Framework (docs/Implementation/04_ENTITY_REGISTRY.md,
##   "Entity Validator", "Validación", "Entidades Inválidas").
##
## Dependencias: EntityStorage (sólo lectura).
##
## Invariantes:
##   - Nunca modifica el estado de EntityStorage.
##   - Un EntityId cuya generación no coincide con la almacenada siempre
##     se considera inválido, sin excepción ("Handle Obsoleto").
##
## Complejidad: is_alive() es O(1).
class_name EntityValidator
extends RefCounted

var _storage: EntityStorage


func _init(storage: EntityStorage) -> void:
	_storage = storage


## true si el identificador existe, su generación coincide con la
## almacenada y su estado actual es ALIVE. O(1).
func is_alive(id: int) -> bool:
	if not EntityId.is_valid(id):
		return false
	var index := EntityId.index_of(id)
	if not _storage.is_index_in_range(index):
		return false
	if _storage.get_generation(index) != EntityId.generation_of(id):
		return false
	return _storage.get_state(index) == EntityStorage.State.ALIVE

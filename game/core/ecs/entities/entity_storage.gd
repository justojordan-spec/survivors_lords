## Almacenamiento interno de los registros de Entity (EntityStorage).
##
## Responsabilidad:
##   Mantener, para cada índice físico, la información mínima necesaria
##   para administrar el ciclo de vida de una Entity: generación y estado.
##   No almacena Components ni ningún dato de gameplay
##   (docs/Implementation/04_ENTITY_REGISTRY.md, "Entity Storage").
##
## Dependencias: ninguna. No conoce EntityAllocator, EntityValidator ni
##   EntityRegistry.
##
## Invariantes:
##   - _generations y _states siempre tienen el mismo tamaño.
##   - Un índice fuera de rango nunca se expone fuera de esta clase.
##
## Complejidad: todas las operaciones públicas son O(1) (allocate_slot()
##   es O(1) amortizado, ya que el array interno puede reasignarse
##   ocasionalmente al crecer).
class_name EntityStorage
extends RefCounted

enum State {
	ALLOCATED,
	ALIVE,
	PENDING_DESTROY,
	DESTROYED,
}

var _generations: PackedInt64Array = PackedInt64Array()
var _states: Array[State] = []


## Reserva un nuevo slot al final del almacenamiento, en estado ALLOCATED.
## Devuelve su índice. O(1) amortizado.
func allocate_slot() -> int:
	_generations.append(0)
	_states.append(State.ALLOCATED)
	return _generations.size() - 1


func slot_count() -> int:
	return _generations.size()


func is_index_in_range(index: int) -> bool:
	return index >= 0 and index < _generations.size()


func get_generation(index: int) -> int:
	return _generations[index]


func get_state(index: int) -> State:
	return _states[index]


func set_state(index: int, state: State) -> void:
	_states[index] = state


## Incrementa la generación del slot (se invoca al reciclar el índice). O(1).
func increment_generation(index: int) -> void:
	_generations[index] += 1

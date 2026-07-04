## Política de capacidad y crecimiento del array denso de un
## ComponentStorage (ComponentAllocator).
##
## Responsabilidad:
##   Decidir cuántas posiciones lógicas están en uso y cuándo/cuánto debe
##   crecer la capacidad reservada, para minimizar reasignaciones durante
##   inserciones masivas (docs/Implementation/05_COMPONENT_REGISTRY.md,
##   "Component Allocator", "Reserva de Capacidad", "Crecimiento"). No
##   posee ni conoce ningún array físico: sólo decide capacidad y conteo;
##   quien la use es responsable de redimensionar sus propias estructuras
##   según capacity().
##
## Dependencias: ninguna.
##
## Invariantes:
##   - capacity() nunca disminuye.
##   - used_count() nunca supera capacity().
##   - reserve(n) nunca reduce una capacidad ya alcanzada.
##
## Complejidad: reserve(), allocate_slot(), release_slot(), used_count()
##   y capacity() son O(1).
class_name ComponentAllocator
extends RefCounted

const MIN_CAPACITY: int = 8
const GROWTH_FACTOR: int = 2

var _capacity: int = 0
var _used_count: int = 0


## Garantiza al menos la capacidad indicada. Nunca crea Components: sólo
## reserva espacio lógico para reducir reasignaciones futuras. O(1).
func reserve(capacity: int) -> void:
	if capacity > _capacity:
		_capacity = capacity


## Reserva el siguiente slot lógico, creciendo la capacidad si hace
## falta (duplicando, con un mínimo de MIN_CAPACITY). O(1).
func allocate_slot() -> int:
	if _used_count >= _capacity:
		_capacity = maxi(MIN_CAPACITY, _capacity * GROWTH_FACTOR)
	var slot := _used_count
	_used_count += 1
	return slot


## Libera el último slot lógico. ComponentStorage sólo libera la última
## posición del array denso (swap-remove), por lo que no se requiere
## indicar cuál índice se libera. O(1).
func release_slot() -> void:
	_used_count -= 1


func used_count() -> int:
	return _used_count


func capacity() -> int:
	return _capacity

## Fachada pública del Entity Registry (EntityRegistry / IEntityRegistry).
##
## Responsabilidad:
##   Punto de entrada único para crear, destruir y validar Entities.
##   Coordina EntityAllocator, EntityStorage y EntityValidator sin
##   implementar directamente ninguna de sus responsabilidades internas
##   (docs/Implementation/04_ENTITY_REGISTRY.md, "Arquitectura Interna").
##
## Dependencias: EntityAllocator, EntityStorage, EntityValidator,
##   FrameworkLogger. No depende de Components, Systems, Queries, Event
##   Bus, Scheduler ni SceneTree.
##
## Invariantes:
##   - Toda Entity devuelta por create_entity() queda en estado ALIVE.
##   - destroy_entity() nunca destruye la Entity de inmediato: la marca
##     PENDING_DESTROY. La destrucción física sólo ocurre dentro de
##     process_pending_destructions() ("Destrucción Diferida").
##   - Un EntityId reciclado nunca vuelve a ser válido (su generación
##     cambió) — verificado por EntityValidator.
##   - Solicitar la destrucción de una Entity ya inválida o ya destruida
##     se ignora de forma segura y nunca corrompe el Registry.
##
## Complejidad: create_entity(), destroy_entity() e is_alive() son O(1)
##   amortizado. process_pending_destructions() es O(n) sobre la
##   cantidad de destrucciones pendientes.
##
## Extiende IEntityRegistry (herencia real: no hereda de Node, por lo que
## no hay conflicto de herencia múltiple). IInitializable/IDisposable/
## IDebuggable se implementan por duck typing (mismos nombres de método),
## ya que GDScript no permite heredar de varias clases base a la vez —
## ver core/ecs/interfaces/.
class_name EntityRegistry
extends IEntityRegistry

var _storage: EntityStorage = null
var _allocator: EntityAllocator = null
var _validator: EntityValidator = null
var _logger: FrameworkLogger

var _pending_destroy: Array[int] = []
var _active_count: int = 0


func _init(logger: FrameworkLogger) -> void:
	_logger = logger


## IInitializable.initialize() — crea Storage/Allocator/Validator internos.
func initialize() -> void:
	_storage = EntityStorage.new()
	_allocator = EntityAllocator.new(_storage)
	_validator = EntityValidator.new(_storage)


func is_initialized() -> bool:
	return _storage != null


## Crea una nueva Entity y la deja en estado ALIVE. O(1) amortizado.
func create_entity() -> int:
	var id := _allocator.allocate()
	var index := EntityId.index_of(id)
	_storage.set_state(index, EntityStorage.State.ALIVE)
	_active_count += 1
	return id


## Solicita la destrucción de una Entity (destrucción diferida): la marca
## PENDING_DESTROY hasta el siguiente process_pending_destructions().
## Ignora de forma segura solicitudes sobre entidades ya inválidas o ya
## destruidas ("Destruir una Entity ya destruida" nunca debe corromper el
## Registry). O(1).
func destroy_entity(id: int) -> bool:
	if not _validator.is_alive(id):
		_logger.warning("entity_registry", "Solicitud de destrucción sobre Entity inválida", {"id": id})
		return false
	var index := EntityId.index_of(id)
	_storage.set_state(index, EntityStorage.State.PENDING_DESTROY)
	_pending_destroy.append(id)
	return true


## true si el identificador corresponde a una Entity actualmente viva. O(1).
func is_alive(id: int) -> bool:
	return _validator.is_alive(id)


## Ejecuta el pipeline de destrucción diferida sobre todas las entidades
## marcadas PENDING_DESTROY: recicla su índice e incrementa su generación.
##
## TODO(Fase 3 - Scheduler): debe invocarse desde un punto seguro del
## ciclo de ejecución del Scheduler. Hasta que exista, se invoca
## manualmente (ver core/ecs/testing/entity_registry_dev_check.gd).
## TODO(Fase 2 - Package 2, Component Registry): antes de reciclar el
## índice corresponde eliminar los Components asociados; no se
## implementa aquí porque el Component Registry todavía no existe.
##
## Complejidad: O(n) sobre la cantidad de destrucciones pendientes.
func process_pending_destructions() -> int:
	var processed := _pending_destroy.size()
	for id in _pending_destroy:
		var index := EntityId.index_of(id)
		_storage.set_state(index, EntityStorage.State.DESTROYED)
		_allocator.release(index)
		_active_count -= 1
	_pending_destroy.clear()
	return processed


func get_active_count() -> int:
	return _active_count


func get_pending_destroy_count() -> int:
	return _pending_destroy.size()


## IDebuggable.get_debug_info() — información de diagnóstico; nunca
## modifica el estado interno.
func get_debug_info() -> Dictionary:
	return {
		"active_entities": _active_count,
		"pending_destroy": _pending_destroy.size(),
		"free_indices": _allocator.free_count() if _allocator else 0,
		"retired_indices": _allocator.retired_count() if _allocator else 0,
		"slot_count": _storage.slot_count() if _storage else 0,
	}


## IDisposable.dispose() — libera las referencias internas.
func dispose() -> void:
	_pending_destroy.clear()
	_storage = null
	_allocator = null
	_validator = null

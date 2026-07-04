## Fachada pública del sistema de Components (ComponentRegistry /
## IComponentRegistry).
##
## Responsabilidad:
##   Único punto de entrada autorizado para registrar tipos, y para
##   añadir, reemplazar, eliminar y consultar Components de una entidad.
##   Coordina ComponentTypeRegistry, ComponentValidator y un
##   ComponentStorage por tipo registrado, sin implementar directamente
##   ninguna de sus responsabilidades internas (docs/Implementation/
##   05_COMPONENT_REGISTRY.md, "Arquitectura Interna", "Component Registry").
##   Reacciona a la destrucción de entidades (remove_all_components()),
##   pero nunca decide cuándo una entidad se destruye — eso pertenece
##   exclusivamente a EntityRegistry (Sprint 4, "ECS Runtime Integration").
##
##   A partir de este Sprint, ComponentStorage deja de ser de uso externo:
##   todo acceso a los Components debe pasar por esta fachada.
##
## Dependencias: IEntityRegistry (inyectado; se delega en ComponentValidator
##   para validar entidades vivas), FrameworkLogger, ComponentTypeRegistry,
##   ComponentValidator, ComponentType, ComponentId, ComponentAllocator,
##   ComponentStorage, EntityId (para convertir EntityId → índice físico
##   antes de delegar en ComponentStorage). No depende de Bootstrap,
##   ECSContext, Event Bus, Scheduler, Query Engine, Signatures, Archetypes,
##   World ni Gameplay.
##
## Invariantes:
##   - Ningún consumidor externo recibe ni necesita conocer índices
##     físicos de entidad: la conversión EntityId → índice ocurre
##     exclusivamente dentro de esta fachada.
##   - Existe como máximo un ComponentStorage por ComponentId, creado de
##     forma perezosa en el primer add_component() para ese tipo.
##   - add_component() nunca sobrescribe un Component existente (usar
##     replace_component() para eso); replace_component()/remove_component()
##     nunca crean un Component nuevo.
##
## Complejidad: register_component_type(), add_component(),
##   replace_component(), remove_component(), has_component() y
##   get_component() son O(1) amortizado (delegan en ComponentStorage,
##   ver ese archivo para el detalle). remove_all_components() es O(T)
##   sobre la cantidad de ComponentStorage creados — ver ese método.
##
## Extiende IComponentRegistry (herencia real: no hereda de Node, sin
## conflicto de herencia múltiple). IInitializable/IDisposable/IDebuggable
## se implementan por duck typing, misma convención que EntityRegistry y
## ComponentTypeRegistry.
class_name ComponentRegistry
extends IComponentRegistry

var _entity_registry: IEntityRegistry
var _logger: FrameworkLogger
var _type_registry: ComponentTypeRegistry = null
var _validator: ComponentValidator = null
var _storages: Dictionary = {}  # ComponentId (int) -> ComponentStorage
var _initialized: bool = false


func _init(entity_registry: IEntityRegistry, logger: FrameworkLogger) -> void:
	_entity_registry = entity_registry
	_logger = logger


## IInitializable.initialize() — crea ComponentTypeRegistry y ComponentValidator.
func initialize() -> void:
	_type_registry = ComponentTypeRegistry.new(_logger)
	_type_registry.initialize()
	_validator = ComponentValidator.new(_entity_registry, _type_registry)
	_storages = {}
	_initialized = true


func is_initialized() -> bool:
	return _initialized


## Registra un nuevo tipo de Component. Devuelve ComponentId.INVALID si
## el nombre es inválido o ya estaba registrado (ver ComponentTypeRegistry).
func register_component_type(type_name: StringName) -> int:
	return _type_registry.register_type(ComponentType.new(type_name))


## Añade un Component de un tipo ya registrado a una entidad viva.
## Rechaza (con log y sin efecto) entidades inválidas, tipos no
## registrados y altas duplicadas.
func add_component(entity_id: int, component_id: int, data: Variant) -> bool:
	if not _validator.is_entity_valid(entity_id):
		_logger.warning("component_registry", "add_component sobre entidad inválida", {"entity_id": entity_id})
		return false
	if not _validator.is_type_valid(component_id):
		_logger.warning("component_registry", "add_component con tipo no registrado", {"component_id": component_id})
		return false

	var storage := _get_or_create_storage(component_id)
	if _validator.has_component(entity_id, storage):
		_logger.warning("component_registry", "add_component duplicado", {
			"entity_id": entity_id, "component_id": component_id,
		})
		return false

	storage.add(EntityId.index_of(entity_id), data)
	return true


## Sobrescribe el dato de un Component que la entidad ya posee. No crea
## un Component nuevo: usar add_component() para eso.
func replace_component(entity_id: int, component_id: int, data: Variant) -> bool:
	if not _validator.is_entity_valid(entity_id) or not _validator.is_type_valid(component_id):
		return false
	var storage := _get_storage(component_id)
	if storage == null:
		return false
	return storage.replace(EntityId.index_of(entity_id), data)


## Elimina el Component de un tipo determinado de una entidad. Rechaza de
## forma segura solicitudes sobre entidades/tipos/Components inexistentes.
func remove_component(entity_id: int, component_id: int) -> bool:
	if not _validator.is_entity_valid(entity_id) or not _validator.is_type_valid(component_id):
		return false
	var storage := _get_storage(component_id)
	if storage == null or not _validator.has_component(entity_id, storage):
		return false
	storage.remove(EntityId.index_of(entity_id))
	return true


## true si la entidad posee un Component de ese tipo.
func has_component(entity_id: int, component_id: int) -> bool:
	if not _validator.is_entity_valid(entity_id) or not _validator.is_type_valid(component_id):
		return false
	var storage := _get_storage(component_id)
	return storage != null and _validator.has_component(entity_id, storage)


## Devuelve el dato del Component, o null si la entidad no lo posee.
func get_component(entity_id: int, component_id: int) -> Variant:
	if not has_component(entity_id, component_id):
		return null
	return _get_storage(component_id).get_data(EntityId.index_of(entity_id))


## Elimina todos los Components de una entidad, en cualquier tipo
## registrado. Pensado para invocarse exclusivamente como reacción a la
## destrucción de una entidad (ver EntityRegistry.set_destruction_listener()),
## nunca para uso de gameplay: por eso no valida is_entity_valid() — en el
## momento en que se invoca, la entidad ya dejó de estar ALIVE
## (EntityRegistry la marca DESTROYED antes de notificar). No forma parte
## de IComponentRegistry porque no es parte del contrato de consumo
## normal, sino un punto de integración entre Packages.
##
## Complejidad: O(T), donde T es la cantidad de tipos de Component que
## alguna vez recibieron al menos un alta (es decir, la cantidad de
## ComponentStorage creados), NO la cantidad de componentes que posee
## esta entidad en particular. Ver "Decisiones técnicas del Sprint 4" y
## "Performance Review" en el informe de este sprint: se documenta como
## limitación conocida y aceptada; resolverla con una estructura auxiliar
## (p. ej. un mapa de tipos por entidad) queda pospuesto hasta el diseño
## de Signatures/Archetypes, cuando existan métricas reales que lo
## justifiquen.
func remove_all_components(entity_id: int) -> int:
	var index := EntityId.index_of(entity_id)
	var removed := 0
	for storage in _storages.values():
		if storage.has(index):
			storage.remove(index)
			removed += 1
	return removed


## IDebuggable.get_debug_info() — información de diagnóstico; nunca
## modifica el estado interno.
func get_debug_info() -> Dictionary:
	var total_components := 0
	for storage in _storages.values():
		total_components += storage.count()
	return {
		"registered_types": _type_registry.get_registered_count() if _type_registry else 0,
		"storages_created": _storages.size(),
		"total_components": total_components,
	}


## IDisposable.dispose() — libera las referencias internas.
func dispose() -> void:
	if _type_registry != null:
		_type_registry.dispose()
	_type_registry = null
	_validator = null
	_storages = {}
	_initialized = false


## Devuelve el ComponentStorage de un tipo, creándolo (con su propio
## ComponentAllocator) si todavía no existía. O(1) amortizado.
func _get_or_create_storage(component_id: int) -> ComponentStorage:
	if not _storages.has(component_id):
		_storages[component_id] = ComponentStorage.new(ComponentAllocator.new())
	return _storages[component_id]


## Devuelve el ComponentStorage de un tipo, o null si todavía no se creó
## ninguno para ese tipo (nunca se le agregó un Component). O(1).
func _get_storage(component_id: int) -> ComponentStorage:
	return _storages.get(component_id)

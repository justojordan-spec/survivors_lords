## Registro de tipos de Component (ComponentTypeRegistry).
##
## Responsabilidad:
##   Registrar cada tipo de Component exactamente una vez, asignarle un
##   ComponentId estable y permitir su búsqueda determinista por nombre o
##   por id (docs/Implementation/05_COMPONENT_REGISTRY.md, "Component Type
##   Registry"; docs/Implementation/13_IMPLEMENTATION_ROADMAP.md, Fase 2,
##   Package 2 — Component Metadata). No almacena instancias de Components
##   ni firmas de entidades: eso corresponde a sprints posteriores.
##
## Dependencias: ComponentType, ComponentMetadata, ComponentId,
##   DuplicateRegistrationException, FrameworkLogger. No depende de
##   EntityStorage, EntityRegistry, Query Engine, Scheduler ni Gameplay.
##
## Invariantes:
##   - Un mismo type_name nunca se registra dos veces (la segunda
##     solicitud se rechaza sin alterar el registro existente).
##   - Los ComponentId asignados son estables y nunca cambian ni se
##     reciclan mientras el Runtime esté activo ("no deben eliminarse
##     tipos existentes").
##   - La metadata devuelta por get_metadata() nunca se modifica después
##     de registrarse (ComponentMetadata es inmutable).
##
## Complejidad: register_type(), is_registered(), get_id() y
##   get_metadata() son O(1) amortizado.
##
## Implementa por duck typing IInitializable/IDisposable/IDebuggable (ver
## core/ecs/interfaces/), siguiendo la misma convención que ECSRuntime y
## EntityRegistry.
class_name ComponentTypeRegistry
extends RefCounted

var _logger: FrameworkLogger
var _by_name: Dictionary = {}  # StringName -> ComponentMetadata
var _by_id: Array[ComponentMetadata] = []
var _initialized: bool = false


func _init(logger: FrameworkLogger) -> void:
	_logger = logger


## IInitializable.initialize() — prepara las estructuras internas vacías.
func initialize() -> void:
	_by_name = {}
	_by_id = []
	_initialized = true


func is_initialized() -> bool:
	return _initialized


## Registra un nuevo tipo de Component y le asigna un ComponentId estable.
## Devuelve ComponentId.INVALID si la declaración es inválida o si el
## tipo ya estaba registrado (rechazo seguro, sin corromper el registro).
## O(1) amortizado.
func register_type(component_type: ComponentType) -> int:
	if not component_type.is_valid():
		_logger.warning("component_type_registry", "Declaración de Component inválida (nombre vacío)")
		return ComponentId.INVALID

	if _by_name.has(component_type.type_name):
		var error := DuplicateRegistrationException.new(
			"component_type_registry", component_type.type_name
		)
		_logger.error(error.subsystem, error.message, error.details)
		return ComponentId.INVALID

	var id := _by_id.size()
	var metadata := ComponentMetadata.new(id, component_type.type_name)
	_by_id.append(metadata)
	_by_name[component_type.type_name] = metadata
	return id


func is_registered(type_name: StringName) -> bool:
	return _by_name.has(type_name)


## Devuelve el ComponentId asociado a un nombre ya registrado, o
## ComponentId.INVALID si no existe. O(1).
func get_id(type_name: StringName) -> int:
	var metadata: ComponentMetadata = _by_name.get(type_name)
	if metadata == null:
		return ComponentId.INVALID
	return metadata.id


## Devuelve los metadatos de un tipo registrado por su id, o null si el
## id no corresponde a ningún tipo registrado. O(1).
func get_metadata(id: int) -> ComponentMetadata:
	if id < 0 or id >= _by_id.size():
		return null
	return _by_id[id]


func get_registered_count() -> int:
	return _by_id.size()


## IDebuggable.get_debug_info() — información de diagnóstico; nunca
## modifica el estado interno.
func get_debug_info() -> Dictionary:
	return {
		"registered_types": _by_id.size(),
	}


## IDisposable.dispose() — libera las estructuras internas.
func dispose() -> void:
	_by_name = {}
	_by_id = []
	_initialized = false

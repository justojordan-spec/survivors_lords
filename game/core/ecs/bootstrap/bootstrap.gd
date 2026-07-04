## Punto de entrada único del Framework ECS.
##
## Orquesta la secuencia obligatoria de arranque definida en
## docs/Implementation/01_PROJECT_BOOTSTRAP.md. No contiene gameplay, no
## ejecuta Systems y no debe ejecutarse más de una vez por ciclo de vida
## del Framework (idempotencia).
##
## Sprint 1 (Runtime Foundation) implementó lógica real hasta CORE_CREATED,
## WORLD_READY y RUNNING. Sprint 2 (ECS Core, Package 1 — Entity System) y
## Sprint 4 (ECS Runtime Integration, Package 2 — Components) completaron
## la etapa REGISTRIES_INITIALIZED: crea EntityRegistry y ComponentRegistry
## y conecta la notificación de destrucción entre ambos (Bootstrap sólo
## ensambla; no decide ni ejecuta esa coordinación). El resto de etapas
## intermedias (Resources, Systems, Event Bus, Query Engine, Save, Network)
## se atraviesan todavía como "stub" hasta que su fase del roadmap las
## implemente.
class_name Bootstrap
extends Node

signal framework_ready(context: ECSContext)
signal framework_failed(error: BootstrapException)

const RuntimeLoopScript := preload("res://core/ecs/core/runtime_loop.gd")

var _logger: FrameworkLogger = null
var _config: RuntimeConfig = null
var _runtime: ECSRuntime = null
var _runtime_loop: RuntimeLoop = null
var _state: BootstrapState.State = BootstrapState.State.UNINITIALIZED
var _has_run: bool = false

## Estados intermedios sin subsistema real todavía en este Sprint.
const _STUB_STATES: Array[BootstrapState.State] = [
	BootstrapState.State.RESOURCES_LOADED,
	BootstrapState.State.SYSTEMS_REGISTERED,
	BootstrapState.State.EVENT_BUS_READY,
	BootstrapState.State.QUERY_ENGINE_READY,
	BootstrapState.State.SAVE_PIPELINE_READY,
	BootstrapState.State.NETWORK_READY,
]


func _ready() -> void:
	_logger = FrameworkLogger.new()
	if not _advance_to(BootstrapState.State.ENGINE_READY):
		return
	_run_bootstrap_sequence()


func _run_bootstrap_sequence() -> void:
	# Idempotencia: el Bootstrap nunca debe reutilizarse.
	if _has_run:
		_fail(BootstrapState.name_of(_state), "El Bootstrap ya fue ejecutado; no es reutilizable")
		return
	_has_run = true

	if not _advance_to(BootstrapState.State.CORE_CREATED):
		return

	_config = RuntimeConfig.load_default()
	if not _config.validate():
		_fail(BootstrapState.name_of(_state), "Configuración de Runtime inválida")
		return

	_runtime = ECSRuntime.new(_logger)
	_runtime.initialize()

	if not _advance_to(BootstrapState.State.REGISTRIES_INITIALIZED):
		return
	var entity_registry := EntityRegistry.new(_logger)
	entity_registry.initialize()

	var component_registry := ComponentRegistry.new(entity_registry, _logger)
	component_registry.initialize()

	# Composición de dependencias entre Packages: EntityRegistry sigue sin
	# conocer a ComponentRegistry (recibe un Callable opaco), pero al
	# destruir una entidad notificará a ComponentRegistry para que elimine
	# sus Components (ver EntityRegistry.set_destruction_listener() y
	# ComponentRegistry.remove_all_components()). Ensamblar esta conexión
	# es responsabilidad del Bootstrap; ejecutarla no lo es.
	entity_registry.set_destruction_listener(component_registry.remove_all_components)

	_runtime.get_context().entity_registry = entity_registry
	_runtime.get_context().component_registry = component_registry
	_logger.info("bootstrap", "Entity Registry inicializado", entity_registry.get_debug_info())
	_logger.info("bootstrap", "Component Registry inicializado", component_registry.get_debug_info())

	for stub_state in _STUB_STATES:
		if not _advance_to(stub_state):
			return
		_logger.info("bootstrap", "Etapa sin subsistema real todavía (stub)", {
			"stage": BootstrapState.name_of(stub_state),
		})

	if not _advance_to(BootstrapState.State.WORLD_READY):
		return
	if _runtime.get_context() == null:
		_fail(BootstrapState.name_of(_state), "El Runtime no posee un Context válido")
		return

	if not _advance_to(BootstrapState.State.RUNNING):
		return

	_runtime.start()
	_runtime_loop = RuntimeLoopScript.new()
	_runtime_loop.configure(_runtime, _logger)
	add_child(_runtime_loop)

	framework_ready.emit(_runtime.get_context())


## Avanza de forma estricta al siguiente estado documentado. Rechaza
## cualquier intento de saltar o repetir etapas.
func _advance_to(target: BootstrapState.State) -> bool:
	var expected := BootstrapState.next(_state)
	if target != expected:
		_fail(BootstrapState.name_of(_state), "Transición de Bootstrap fuera de orden", {
			"expected": BootstrapState.name_of(expected),
			"got": BootstrapState.name_of(target),
		})
		return false
	_state = target
	_logger.info("bootstrap", "Etapa de Bootstrap alcanzada", {"stage": BootstrapState.name_of(_state)})
	return true


## Política de fallos: el Bootstrap nunca continúa después de un error
## crítico. Cancela el arranque, libera lo parcialmente creado e informa
## el motivo (ver 01_PROJECT_BOOTSTRAP.md, "Gestión de Errores").
func _fail(stage: String, message: String, details: Dictionary = {}) -> void:
	var error := BootstrapException.new(stage, message, details)
	_logger.fatal("bootstrap", error.format())

	if _runtime != null and _runtime.is_initialized():
		_runtime.dispose()

	framework_failed.emit(error)

	if not Engine.is_editor_hint():
		get_tree().quit(1)


func get_runtime() -> ECSRuntime:
	return _runtime


func get_current_state() -> BootstrapState.State:
	return _state

## Punto de entrada único del Framework ECS.
##
## Orquesta la secuencia obligatoria de arranque definida en
## docs/Implementation/01_PROJECT_BOOTSTRAP.md. No contiene gameplay, no
## ejecuta Systems y no debe ejecutarse más de una vez por ciclo de vida
## del Framework (idempotencia).
##
## Sprint 1 (Runtime Foundation) sólo implementa lógica real hasta
## CORE_CREATED, WORLD_READY y RUNNING. Las etapas intermedias
## (Registries, Resources, Systems, Event Bus, Query Engine, Save,
## Network) se atraviesan como "stub" hasta que su fase del roadmap las
## implemente — ver BootstrapState.RUNTIME_FOUNDATION_STATES.
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
	BootstrapState.State.REGISTRIES_INITIALIZED,
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

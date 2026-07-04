## Runtime completo del Framework (IECSRuntime).
##
## Coordina el ciclo de vida global del ECS: iniciar, detener, reiniciar,
## consultar su estado y exponer el Context. No ejecuta Systems, no crea
## entidades, no administra Components ni emite eventos — esas
## responsabilidades pertenecen a otros módulos (fases posteriores).
##
## Ver docs/Implementation/03_CORE_INTERFACES.md (IECSRuntime) y
## docs/Implementation/13_IMPLEMENTATION_ROADMAP.md (Fase 1, Module Lifecycle).
##
## Implementa por duck typing los contratos IInitializable/IDisposable
## (ver core/ecs/interfaces/) ya que GDScript no permite heredar de
## varias clases base a la vez.
class_name ECSRuntime
extends RefCounted

var _state: ModuleLifecycleState.State = ModuleLifecycleState.State.CREATED
var _context: ECSContext = null
var _logger: FrameworkLogger


func _init(logger: FrameworkLogger) -> void:
	_logger = logger


## IInitializable.initialize() — crea el Context. No debe invocarse más de una vez.
func initialize() -> void:
	_context = ECSContext.new()
	_transition_to(ModuleLifecycleState.State.INITIALIZED)


func is_initialized() -> bool:
	return _state != ModuleLifecycleState.State.CREATED


func start() -> void:
	_transition_to(ModuleLifecycleState.State.RUNNING)


func stop() -> void:
	_transition_to(ModuleLifecycleState.State.STOPPED)


## Reanuda la ejecución tras un stop(). Requiere haber pasado por STOPPED.
func restart() -> void:
	_transition_to(ModuleLifecycleState.State.RUNNING)


## IDisposable.dispose() — libera el Context. No reinicializa el Runtime.
func dispose() -> void:
	_transition_to(ModuleLifecycleState.State.DESTROYED)
	_context = null


func get_state() -> ModuleLifecycleState.State:
	return _state


func get_context() -> ECSContext:
	return _context


func _transition_to(target: ModuleLifecycleState.State) -> void:
	if not ModuleLifecycleState.can_transition(_state, target):
		_logger.fatal("ecs_runtime", "Transición de ciclo de vida inválida", {
			"from": ModuleLifecycleState.name_of(_state),
			"to": ModuleLifecycleState.name_of(target),
		})
		return
	_logger.info("ecs_runtime", "Transición de ciclo de vida", {
		"from": ModuleLifecycleState.name_of(_state),
		"to": ModuleLifecycleState.name_of(target),
	})
	_state = target

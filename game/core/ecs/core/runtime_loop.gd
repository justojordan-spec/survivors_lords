## Bucle de ejecución mínimo del Runtime (Fase 1, Package 3 — Runtime Loop).
##
## Sólo mantiene el control determinista de arranque/parada mientras el
## Scheduler (Fase 3 del roadmap) no existe todavía. No contiene lógica
## de Systems ni de gameplay.
class_name RuntimeLoop
extends Node

var _runtime: ECSRuntime = null
var _logger: FrameworkLogger = null
var _frame_count: int = 0


func configure(runtime: ECSRuntime, logger: FrameworkLogger) -> void:
	_runtime = runtime
	_logger = logger


func _process(_delta: float) -> void:
	if _runtime == null or _runtime.get_state() != ModuleLifecycleState.State.RUNNING:
		return
	_frame_count += 1
	# TODO(Fase 3 - Scheduler): invocar aquí scheduler.execute_frame(_delta)
	# una vez que el Scheduler exista. Por ahora este nodo sólo garantiza
	# un punto de enganche determinista para la ejecución futura.


func _exit_tree() -> void:
	if _runtime == null:
		return
	if _runtime.get_state() == ModuleLifecycleState.State.RUNNING:
		if _logger != null:
			_logger.info("runtime_loop", "Cierre detectado; deteniendo Runtime", {"frame_count": _frame_count})
		_runtime.stop()
	if _runtime.get_state() == ModuleLifecycleState.State.STOPPED:
		_runtime.dispose()

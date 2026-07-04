## Ciclo de vida genérico de un módulo/servicio del Framework.
##
## Ver docs/Implementation/13_IMPLEMENTATION_ROADMAP.md (Fase 1, Package 2 —
## Module Lifecycle). Cualquier servicio del Runtime (ECSRuntime, y en
## fases futuras Scheduler, EventBus, etc.) reutiliza este mismo conjunto
## de estados y transiciones en lugar de definir uno propio.
class_name ModuleLifecycleState
extends RefCounted

enum State {
	CREATED,
	INITIALIZED,
	RUNNING,
	STOPPED,
	DESTROYED,
}

## Transiciones válidas. Cualquier otra transición debe rechazarse.
const VALID_TRANSITIONS: Dictionary = {
	State.CREATED: [State.INITIALIZED],
	State.INITIALIZED: [State.RUNNING],
	State.RUNNING: [State.STOPPED],
	State.STOPPED: [State.RUNNING, State.DESTROYED],
	State.DESTROYED: [],
}


static func name_of(state: State) -> String:
	return State.keys()[state]


static func can_transition(from: State, to: State) -> bool:
	var allowed: Array = VALID_TRANSITIONS.get(from, [])
	return allowed.has(to)

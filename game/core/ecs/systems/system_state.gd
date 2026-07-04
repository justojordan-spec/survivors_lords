## Ciclo de vida mínimo de un System (SystemState).
##
## docs/Implementation/06_SYSTEM_BASE.md define un ciclo más amplio
## (Created → Initialized → Ready → Running → Paused → Disposed) y
## estados operativos adicionales (Running/Paused/Disabled/Error). Este
## Sprint implementa deliberadamente sólo el subconjunto que tiene
## sentido sin un Scheduler: crear, inicializar y liberar. Ready/Running/
## Paused/Disabled/Error dependen de que algo controle frecuencia,
## pausas y recuperación de errores — eso es responsabilidad exclusiva
## del futuro Scheduler (Fase 3) y queda fuera de alcance (ver
## "Decisiones técnicas del Sprint 5").
class_name SystemState
extends RefCounted

enum State {
	CREATED,
	INITIALIZED,
	DISPOSED,
}

## Transiciones válidas. Cualquier otra debe rechazarse.
const VALID_TRANSITIONS: Dictionary = {
	State.CREATED: [State.INITIALIZED],
	State.INITIALIZED: [State.DISPOSED],
	State.DISPOSED: [],
}


static func name_of(state: State) -> String:
	return State.keys()[state]


static func can_transition(from: State, to: State) -> bool:
	var allowed: Array = VALID_TRANSITIONS.get(from, [])
	return allowed.has(to)

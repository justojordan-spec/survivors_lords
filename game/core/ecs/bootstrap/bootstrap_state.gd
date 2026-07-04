## Máquina de estados del Bootstrap del Framework.
##
## El orden y los nombres de los estados están definidos por
## docs/Implementation/01_PROJECT_BOOTSTRAP.md ("Estados" /
## "Orden Obligatorio de Inicialización") y no deben alterarse sin una
## revisión de arquitectura formal.
##
## Sprint 1 (Runtime Foundation) sólo implementa lógica real para los
## estados listados en RUNTIME_FOUNDATION_STATES. El resto se atraviesa
## como una etapa "stub" (sin subsistema real todavía) hasta que la fase
## correspondiente del roadmap (docs/Implementation/13_IMPLEMENTATION_ROADMAP.md)
## los implemente.
class_name BootstrapState
extends RefCounted

enum State {
	UNINITIALIZED,
	ENGINE_READY,
	CORE_CREATED,
	REGISTRIES_INITIALIZED,
	RESOURCES_LOADED,
	SYSTEMS_REGISTERED,
	EVENT_BUS_READY,
	QUERY_ENGINE_READY,
	SAVE_PIPELINE_READY,
	NETWORK_READY,
	WORLD_READY,
	RUNNING,
}

## Orden obligatorio de inicialización. Nunca debe reordenarse.
const ORDER: Array[State] = [
	State.UNINITIALIZED,
	State.ENGINE_READY,
	State.CORE_CREATED,
	State.REGISTRIES_INITIALIZED,
	State.RESOURCES_LOADED,
	State.SYSTEMS_REGISTERED,
	State.EVENT_BUS_READY,
	State.QUERY_ENGINE_READY,
	State.SAVE_PIPELINE_READY,
	State.NETWORK_READY,
	State.WORLD_READY,
	State.RUNNING,
]

## Estados con implementación real en el Sprint 1 (Runtime Foundation).
## Los estados que no aparecen aquí se atraviesan como "stub" hasta que
## su fase correspondiente del roadmap los implemente.
const RUNTIME_FOUNDATION_STATES: Array[State] = [
	State.UNINITIALIZED,
	State.ENGINE_READY,
	State.CORE_CREATED,
	State.WORLD_READY,
	State.RUNNING,
]


static func name_of(state: State) -> String:
	return State.keys()[state]


static func is_implemented_in_runtime_foundation(state: State) -> bool:
	return RUNTIME_FOUNDATION_STATES.has(state)


## Devuelve el estado siguiente según el orden obligatorio.
## No debe invocarse sobre el último estado (RUNNING).
static func next(state: State) -> State:
	var index := ORDER.find(state)
	assert(index != -1, "Estado desconocido: %s" % state)
	assert(index < ORDER.size() - 1, "No existe estado siguiente para %s" % name_of(state))
	return ORDER[index + 1]

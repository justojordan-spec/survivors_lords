## Implementación base común para todos los Systems del Framework
## (SystemBase).
##
## Responsabilidad:
##   Proporcionar el ciclo de vida mínimo compartido por cualquier System
##   (creación, inicialización, liberación) y el punto de acceso al
##   contexto del Runtime recibido en initialize(), evitando que cada
##   System concreto reimplemente las mismas validaciones de estado
##   (docs/Implementation/06_SYSTEM_BASE.md, "SystemBase"). No implementa
##   lógica de gameplay.
##
## Dependencias: IECSContext, SystemState, SystemPhase. No depende de
##   EntityStorage, ComponentStorage, EntityAllocator, ComponentAllocator,
##   Dense/Sparse Arrays, Query Engine, Scheduler, Event Bus ni Gameplay:
##   un System concreto sólo alcanza los Registries a través de los
##   contratos que expone IECSContext (IEntityRegistry/IComponentRegistry),
##   nunca de forma directa.
##
## Invariantes:
##   - initialize() sólo tiene efecto una vez, desde el estado CREATED.
##   - update() no ejecuta _on_update() si el System no está INITIALIZED
##     (evita trabajo sobre un System no preparado o ya liberado).
##   - shutdown() sólo tiene efecto desde INITIALIZED y deja al System en
##     DISPOSED de forma permanente (sin transición de vuelta).
##
## Complejidad: initialize(), update(), shutdown() y get_state() son O(1)
##   en esta base (sin contar el costo que agregue cada System concreto
##   en sus hooks _on_*).
##
## Extiende ISystem (herencia real: no hereda de Node, sin conflicto de
## herencia múltiple). Los Systems concretos deben heredar de SystemBase
## y sobrescribir _on_initialize()/_on_update(delta)/_on_shutdown() en
## lugar de initialize()/update()/shutdown() directamente, para no perder
## las validaciones de estado centralizadas aquí.
class_name SystemBase
extends ISystem

var _state: SystemState.State = SystemState.State.CREATED
var _context: IECSContext = null


## ISystem.initialize() — válido únicamente desde CREATED.
func initialize(context: IECSContext) -> void:
	if not SystemState.can_transition(_state, SystemState.State.INITIALIZED):
		push_error("SystemBase.initialize() inválido desde el estado %s" % SystemState.name_of(_state))
		return
	_context = context
	_on_initialize()
	_state = SystemState.State.INITIALIZED


## ISystem.update() — no hace nada si el System no está INITIALIZED.
func update(delta: float) -> void:
	if _state != SystemState.State.INITIALIZED:
		return
	_on_update(delta)


## ISystem.shutdown() — válido únicamente desde INITIALIZED.
func shutdown() -> void:
	if not SystemState.can_transition(_state, SystemState.State.DISPOSED):
		push_error("SystemBase.shutdown() inválido desde el estado %s" % SystemState.name_of(_state))
		return
	_on_shutdown()
	_context = null
	_state = SystemState.State.DISPOSED


func get_state() -> SystemState.State:
	return _state


## Contexto recibido en initialize(); null antes de inicializar o
## después de shutdown().
func get_context() -> IECSContext:
	return _context


## Fase de ejecución declarada por este System (metadato puramente
## informativo). El valor por defecto es UPDATE; un System concreto
## puede sobrescribirlo si necesita ejecutarse antes/después del resto.
func get_phase() -> SystemPhase.Phase:
	return SystemPhase.Phase.UPDATE


## Hook de inicialización específico de cada System concreto.
func _on_initialize() -> void:
	pass


## Hook de ejecución específico de cada System concreto. Recibe delta en
## segundos; no debe asumir una frecuencia fija (la decidirá el futuro
## Scheduler).
func _on_update(_delta: float) -> void:
	pass


## Hook de liberación específico de cada System concreto.
func _on_shutdown() -> void:
	pass

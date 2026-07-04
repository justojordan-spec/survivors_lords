## Verificación manual de desarrollo de la infraestructura base de
## Systems (Sprint 5 — ECS System Foundation): ISystem, SystemBase,
## SystemState, SystemPhase, IECSContext.
##
## Script temporal, fuera del Bootstrap. Define un System de prueba
## (CounterTestSystem, sólo dentro de este archivo de testing/, nunca
## gameplay) para ejercitar el ciclo de vida sin depender de ningún
## Scheduler, Query Engine ni Event Bus — ninguno de los cuales existe
## todavía. El Context se ensambla igual que lo hace Bootstrap
## (EntityRegistry + ComponentRegistry + listener de destrucción).
##
## Uso:
##   godot --headless --path game --script res://core/ecs/testing/system_base_dev_check.gd
extends SceneTree


## System de prueba: sólo cuenta invocaciones y registra qué recibió del
## Context, para poder verificar el contrato sin ninguna lógica de
## gameplay real.
class CounterTestSystem extends SystemBase:
	var initialize_calls: int = 0
	var update_calls: int = 0
	var shutdown_calls: int = 0
	var last_delta: float = -1.0
	var saw_entity_registry: bool = false
	var saw_component_registry: bool = false

	func _on_initialize() -> void:
		initialize_calls += 1
		saw_entity_registry = get_context().get_entity_registry() != null
		saw_component_registry = get_context().get_component_registry() != null

	func _on_update(delta: float) -> void:
		update_calls += 1
		last_delta = delta

	func _on_shutdown() -> void:
		shutdown_calls += 1


func _initialize() -> void:
	var logger := FrameworkLogger.new()
	var context := _build_context(logger)

	_check_full_lifecycle(context, logger)
	_check_update_before_initialize_is_noop(logger)
	_check_double_initialize_rejected(context, logger)
	_check_double_shutdown_rejected(context, logger)
	_check_default_phase_is_declarative(logger)

	logger.info("dev_check", "Verificación completa", {})
	quit()


## Ensambla EntityRegistry + ComponentRegistry + listener de destrucción
## exactamente como lo hace Bootstrap, para probar la integración real
## con IECSContext (no un doble de prueba).
func _build_context(logger: FrameworkLogger) -> ECSContext:
	var entity_registry := EntityRegistry.new(logger)
	entity_registry.initialize()
	var component_registry := ComponentRegistry.new(entity_registry, logger)
	component_registry.initialize()
	entity_registry.set_destruction_listener(component_registry.remove_all_components)

	var context := ECSContext.new()
	context.entity_registry = entity_registry
	context.component_registry = component_registry
	return context


func _check_full_lifecycle(context: ECSContext, logger: FrameworkLogger) -> void:
	var system := CounterTestSystem.new()
	var created_ok := system.get_state() == SystemState.State.CREATED

	system.initialize(context)
	var initialized_ok := (
		system.get_state() == SystemState.State.INITIALIZED
		and system.initialize_calls == 1
		and system.saw_entity_registry
		and system.saw_component_registry
	)

	system.update(0.016)
	system.update(0.016)
	system.update(0.033)
	var update_ok := system.update_calls == 3 and system.last_delta == 0.033

	system.shutdown()
	var shutdown_ok := (
		system.get_state() == SystemState.State.DISPOSED
		and system.shutdown_calls == 1
		and system.get_context() == null
	)

	system.update(0.5)
	var update_after_shutdown_is_noop := system.update_calls == 3

	assert(created_ok, "Un System recién construido debe estar en CREATED")
	assert(initialized_ok, "initialize() debe dejar el System en INITIALIZED con el Context recibido")
	assert(update_ok, "update() debe invocar _on_update() con el delta recibido mientras esté INITIALIZED")
	assert(shutdown_ok, "shutdown() debe dejar el System en DISPOSED y liberar el Context")
	assert(update_after_shutdown_is_noop, "update() después de shutdown() nunca debe ejecutar _on_update()")

	logger.info("dev_check", "Ciclo de vida completo", {
		"created_ok": created_ok,
		"initialized_ok": initialized_ok,
		"update_ok": update_ok,
		"shutdown_ok": shutdown_ok,
		"update_after_shutdown_is_noop": update_after_shutdown_is_noop,
	})


func _check_update_before_initialize_is_noop(logger: FrameworkLogger) -> void:
	var system := CounterTestSystem.new()
	system.update(0.1)
	var is_noop := system.update_calls == 0
	assert(is_noop, "update() antes de initialize() nunca debe ejecutar _on_update()")
	logger.info("dev_check", "update() antes de initialize() es no-op", {"is_noop": is_noop})


func _check_double_initialize_rejected(context: ECSContext, logger: FrameworkLogger) -> void:
	var system := CounterTestSystem.new()
	system.initialize(context)
	system.initialize(context)
	var rejected := system.initialize_calls == 1 and system.get_state() == SystemState.State.INITIALIZED
	assert(rejected, "Un segundo initialize() sobre el mismo System debe rechazarse")
	logger.info("dev_check", "Doble initialize() rechazado", {"rejected": rejected})


func _check_double_shutdown_rejected(context: ECSContext, logger: FrameworkLogger) -> void:
	var system := CounterTestSystem.new()
	system.initialize(context)
	system.shutdown()
	system.shutdown()
	var rejected := system.shutdown_calls == 1 and system.get_state() == SystemState.State.DISPOSED
	assert(rejected, "Un segundo shutdown() sobre el mismo System debe rechazarse")
	logger.info("dev_check", "Doble shutdown() rechazado", {"rejected": rejected})


func _check_default_phase_is_declarative(logger: FrameworkLogger) -> void:
	var system := CounterTestSystem.new()
	var phase_ok := system.get_phase() == SystemPhase.Phase.UPDATE
	assert(phase_ok, "La fase por defecto de un System debe ser UPDATE")
	logger.info("dev_check", "Fase declarativa por defecto", {"phase": SystemPhase.name_of(system.get_phase())})

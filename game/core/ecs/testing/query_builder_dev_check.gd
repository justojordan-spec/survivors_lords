## Verificación manual de desarrollo del modelo de Queries (Sprint 6 —
## Query Foundation): IQuery, QueryDescriptor, QueryBuilder.
##
## Script temporal, fuera del Bootstrap. No ejecuta ninguna búsqueda de
## entidades (el QueryEngine no existe todavía): sólo verifica que las
## Queries describan correctamente sus requisitos y permanezcan
## inmutables. Un System de prueba (definido sólo en este archivo,
## reutilizando SystemBase del Sprint 5) demuestra la integración con
## IECSContext sin ejecutar ninguna consulta real.
##
## Uso:
##   godot --headless --path game --script res://core/ecs/testing/query_builder_dev_check.gd
extends SceneTree


## System de prueba: durante su inicialización, registra tipos de
## Component a través del Context (nunca accede a Storage directamente)
## y construye un QueryDescriptor con los ComponentId obtenidos.
class QueryDeclaringTestSystem extends SystemBase:
	var built_query: QueryDescriptor = null

	func _on_initialize() -> void:
		var component_registry := get_context().get_component_registry()
		var transform_id := component_registry.register_component_type(&"TransformComponent")
		var velocity_id := component_registry.register_component_type(&"VelocityComponent")
		var sleep_id := component_registry.register_component_type(&"SleepComponent")

		built_query = QueryBuilder.new() \
			.with_component(transform_id) \
			.with_component(velocity_id) \
			.without_component(sleep_id) \
			.build()


func _initialize() -> void:
	var logger := FrameworkLogger.new()

	_check_basic_build(logger)
	_check_duplicate_components_collapsed(logger)
	_check_invalid_component_id_ignored(logger)
	_check_contradictory_build_rejected(logger)
	_check_immutability(logger)
	_check_reused_between_multiple_systems(logger)
	_check_integration_with_ecs_context(logger)

	logger.info("dev_check", "Verificación completa", {})
	quit()


func _check_basic_build(logger: FrameworkLogger) -> void:
	var query := QueryBuilder.new() \
		.with_component(1) \
		.with_component(2) \
		.without_component(3) \
		.with_optional_component(4) \
		.build()

	var ok := (
		query != null
		and query.requires(1) and query.requires(2)
		and query.excludes(3)
		and query.is_optional(4)
		and query.get_required_components().size() == 2
		and query.get_excluded_components().size() == 1
		and query.get_optional_components().size() == 1
	)
	assert(ok, "Un QueryDescriptor básico debe reflejar exactamente lo declarado en el Builder")
	logger.info("dev_check", "Construcción básica", {"ok": ok})


func _check_duplicate_components_collapsed(logger: FrameworkLogger) -> void:
	var query := QueryBuilder.new() \
		.with_component(10) \
		.with_component(10) \
		.with_component(10) \
		.build()

	var ok := query.get_required_components().size() == 1
	assert(ok, "Declarar el mismo ComponentId varias veces no debe duplicarlo")
	logger.info("dev_check", "Duplicados colapsados", {"ok": ok})


func _check_invalid_component_id_ignored(logger: FrameworkLogger) -> void:
	var query := QueryBuilder.new() \
		.with_component(ComponentId.INVALID) \
		.with_component(5) \
		.build()

	var ok := query.get_required_components().size() == 1 and query.requires(5)
	assert(ok, "Un ComponentId inválido nunca debe agregarse a la descripción")
	logger.info("dev_check", "ComponentId inválido ignorado", {"ok": ok})


func _check_contradictory_build_rejected(logger: FrameworkLogger) -> void:
	var query := QueryBuilder.new() \
		.with_component(7) \
		.without_component(7) \
		.build()

	var rejected := query == null
	assert(rejected, "Un ComponentId requerido y excluido a la vez debe rechazar la construcción")
	logger.info("dev_check", "Configuración contradictoria rechazada", {"rejected": rejected})


func _check_immutability(logger: FrameworkLogger) -> void:
	var query := QueryBuilder.new().with_component(42).build()
	var required := query.get_required_components()
	var size_before := required.size()

	required.append(999)
	var size_after := query.get_required_components().size()

	var immutable := size_after == size_before
	assert(immutable, "Un intento de modificar el array devuelto nunca debe alterar el QueryDescriptor")
	logger.info("dev_check", "Inmutabilidad verificada", {
		"immutable": immutable,
		"is_read_only": required.is_read_only(),
	})


func _check_reused_between_multiple_systems(logger: FrameworkLogger) -> void:
	var shared_query := QueryBuilder.new().with_component(1).with_component(2).build()

	# Dos "Systems" distintos referencian el mismo QueryDescriptor sin
	# copiarlo ni reconstruirlo, y ambos observan exactamente los mismos
	# datos, de forma segura y simultánea.
	var system_a_view := shared_query
	var system_b_view := shared_query

	var consistent := (
		system_a_view.requires(1) and system_a_view.requires(2)
		and system_b_view.requires(1) and system_b_view.requires(2)
		and system_a_view == system_b_view
	)
	assert(consistent, "Un mismo QueryDescriptor debe ser seguro de compartir entre múltiples Systems")
	logger.info("dev_check", "Reutilización entre Systems", {"consistent": consistent})


func _check_integration_with_ecs_context(logger: FrameworkLogger) -> void:
	var entity_registry := EntityRegistry.new(logger)
	entity_registry.initialize()
	var component_registry := ComponentRegistry.new(entity_registry, logger)
	component_registry.initialize()
	entity_registry.set_destruction_listener(component_registry.remove_all_components)

	var context := ECSContext.new()
	context.entity_registry = entity_registry
	context.component_registry = component_registry

	var system := QueryDeclaringTestSystem.new()
	system.initialize(context)

	var transform_id := component_registry.get_id(&"TransformComponent")
	var velocity_id := component_registry.get_id(&"VelocityComponent")
	var sleep_id := component_registry.get_id(&"SleepComponent")

	var ok := (
		system.built_query != null
		and system.built_query.requires(transform_id)
		and system.built_query.requires(velocity_id)
		and system.built_query.excludes(sleep_id)
	)
	assert(ok, "Un System debe poder declarar una Query usando únicamente lo que obtiene de IECSContext, sin tocar Storage")
	logger.info("dev_check", "Integración con IECSContext", {"ok": ok})

	system.shutdown()

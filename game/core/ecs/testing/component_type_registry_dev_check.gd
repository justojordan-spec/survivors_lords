## Verificación manual de desarrollo del ComponentTypeRegistry (Sprint 3A).
##
## Script temporal, fuera del Bootstrap, que ejercita el registro de
## tipos de Component y registra el resultado en el log. No forma parte
## del Framework en ejecución: se invoca manualmente mientras no exista
## el framework de pruebas automatizado (Fase 0B).
##
## Uso:
##   godot --headless --path game --script res://core/ecs/testing/component_type_registry_dev_check.gd
extends SceneTree


func _initialize() -> void:
	var logger := FrameworkLogger.new()
	var registry := ComponentTypeRegistry.new(logger)
	registry.initialize()

	_check_register_single(registry, logger)
	_check_unique_ids(registry, logger)
	_check_lookup_by_name_and_id(registry, logger)
	_check_duplicate_rejected(registry, logger)
	_check_invalid_declaration_rejected(registry, logger)
	_check_unknown_lookup_returns_invalid(registry, logger)

	logger.info("dev_check", "Verificación completa", registry.get_debug_info())
	quit()


func _check_register_single(registry: ComponentTypeRegistry, logger: FrameworkLogger) -> void:
	var id := registry.register_type(ComponentType.new(&"TransformComponent"))
	var ok := ComponentId.is_valid(id) and id == 0
	assert(ok, "El primer tipo registrado debe recibir el id 0")
	logger.info("dev_check", "Registrar un tipo", {"ok": ok, "id": id})


func _check_unique_ids(registry: ComponentTypeRegistry, logger: FrameworkLogger) -> void:
	var health_id := registry.register_type(ComponentType.new(&"HealthComponent"))
	var inventory_id := registry.register_type(ComponentType.new(&"InventoryComponent"))
	var unique := health_id != inventory_id and ComponentId.is_valid(health_id) and ComponentId.is_valid(inventory_id)
	assert(unique, "Cada tipo registrado debe recibir un ComponentId distinto")
	logger.info("dev_check", "IDs únicos", {"health_id": health_id, "inventory_id": inventory_id})


func _check_lookup_by_name_and_id(registry: ComponentTypeRegistry, logger: FrameworkLogger) -> void:
	var id := registry.get_id(&"HealthComponent")
	var metadata := registry.get_metadata(id)
	var consistent := metadata != null and metadata.id == id and metadata.type_name == &"HealthComponent"
	assert(consistent, "La búsqueda por nombre y por id debe ser consistente")
	assert(registry.is_registered(&"HealthComponent"), "HealthComponent debe figurar como registrado")
	logger.info("dev_check", "Búsqueda consistente por nombre e id", {"consistent": consistent})


func _check_duplicate_rejected(registry: ComponentTypeRegistry, logger: FrameworkLogger) -> void:
	var count_before := registry.get_registered_count()
	var second_id := registry.register_type(ComponentType.new(&"HealthComponent"))
	var rejected := not ComponentId.is_valid(second_id)
	var count_unchanged := registry.get_registered_count() == count_before
	assert(rejected, "Registrar un tipo ya existente debe rechazarse")
	assert(count_unchanged, "Un registro duplicado no debe alterar el registro existente")
	logger.info("dev_check", "Registro duplicado rechazado", {
		"rejected": rejected,
		"count_unchanged": count_unchanged,
	})


func _check_invalid_declaration_rejected(registry: ComponentTypeRegistry, logger: FrameworkLogger) -> void:
	var id := registry.register_type(ComponentType.new(&""))
	var rejected := not ComponentId.is_valid(id)
	assert(rejected, "Una declaración con nombre vacío debe rechazarse")
	logger.info("dev_check", "Declaración inválida rechazada", {"rejected": rejected})


func _check_unknown_lookup_returns_invalid(registry: ComponentTypeRegistry, logger: FrameworkLogger) -> void:
	var id := registry.get_id(&"UnknownComponent")
	var metadata := registry.get_metadata(999)
	var ok := not ComponentId.is_valid(id) and metadata == null
	assert(ok, "Buscar un tipo no registrado debe devolver valores inválidos, nunca corromper el estado")
	logger.info("dev_check", "Búsqueda de tipo desconocido", {"ok": ok})

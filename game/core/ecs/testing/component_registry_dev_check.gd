## Verificación manual de desarrollo del ComponentRegistry (Sprint 3C).
##
## Script temporal, fuera del Bootstrap. A diferencia de los scripts de
## desarrollo de sprints anteriores, éste NO toca ComponentStorage,
## ComponentAllocator, ComponentValidator ni ComponentTypeRegistry
## directamente: ejercita únicamente la API pública de ComponentRegistry,
## demostrando que es el único punto de entrada necesario.
##
## Uso:
##   godot --headless --path game --script res://core/ecs/testing/component_registry_dev_check.gd
extends SceneTree

const BULK_COUNT: int = 20000


func _initialize() -> void:
	var logger := FrameworkLogger.new()
	var entity_registry := EntityRegistry.new(logger)
	entity_registry.initialize()

	var registry := ComponentRegistry.new(entity_registry, logger)
	registry.initialize()

	var position_id := registry.register_component_type(&"PositionComponent")
	registry.register_component_type(&"HealthComponent")

	_check_register_and_add(entity_registry, registry, position_id, logger)
	_check_replace(entity_registry, registry, position_id, logger)
	_check_duplicate_rejected(entity_registry, registry, position_id, logger)
	_check_remove(entity_registry, registry, position_id, logger)
	_check_invalid_entity_and_type_rejected(entity_registry, registry, position_id, logger)
	_check_storage_created_lazily(registry, logger)
	_check_bulk(entity_registry, logger)

	logger.info("dev_check", "Verificación completa", registry.get_debug_info())
	quit()


func _check_register_and_add(entity_registry: EntityRegistry, registry: ComponentRegistry, position_id: int, logger: FrameworkLogger) -> void:
	var ok_type := ComponentId.is_valid(position_id)
	var entity := entity_registry.create_entity()
	var added := registry.add_component(entity, position_id, {"x": 1, "y": 2})
	var found := registry.has_component(entity, position_id)
	var data: Dictionary = registry.get_component(entity, position_id)

	assert(ok_type, "El tipo debe registrarse con un ComponentId válido")
	assert(added, "add_component debe aceptar una entidad viva y un tipo registrado")
	assert(found, "has_component debe ser true tras el alta")
	assert(data.x == 1 and data.y == 2, "get_component debe devolver el dato insertado")
	logger.info("dev_check", "Registro y alta vía fachada", {"ok_type": ok_type, "added": added, "found": found, "data": data})


func _check_replace(entity_registry: EntityRegistry, registry: ComponentRegistry, position_id: int, logger: FrameworkLogger) -> void:
	var entity := entity_registry.create_entity()
	registry.add_component(entity, position_id, {"x": 10, "y": 10})

	var replaced := registry.replace_component(entity, position_id, {"x": 55, "y": 55})
	var data: Dictionary = registry.get_component(entity, position_id)
	var replace_without_add := registry.replace_component(entity_registry.create_entity(), position_id, {"x": 1, "y": 1})

	assert(replaced, "replace_component debe aceptar una entidad con Component existente")
	assert(data.x == 55 and data.y == 55, "replace_component debe sobrescribir el dato")
	assert(not replace_without_add, "replace_component nunca debe crear un Component nuevo")
	logger.info("dev_check", "Reemplazo vía fachada", {"replaced": replaced, "data": data, "replace_without_add_rejected": not replace_without_add})


func _check_duplicate_rejected(entity_registry: EntityRegistry, registry: ComponentRegistry, position_id: int, logger: FrameworkLogger) -> void:
	var entity := entity_registry.create_entity()
	registry.add_component(entity, position_id, {"x": 1, "y": 1})

	var second_attempt := registry.add_component(entity, position_id, {"x": 2, "y": 2})
	var data: Dictionary = registry.get_component(entity, position_id)

	assert(not second_attempt, "Un segundo add_component sobre la misma entidad y tipo debe rechazarse")
	assert(data.x == 1, "El dato original no debe alterarse por el intento duplicado")
	logger.info("dev_check", "Duplicado rechazado vía fachada", {"rejected": not second_attempt})


func _check_remove(entity_registry: EntityRegistry, registry: ComponentRegistry, position_id: int, logger: FrameworkLogger) -> void:
	var entity := entity_registry.create_entity()
	registry.add_component(entity, position_id, {"x": 7, "y": 7})

	var removed := registry.remove_component(entity, position_id)
	var found_after := registry.has_component(entity, position_id)
	var second_remove := registry.remove_component(entity, position_id)

	assert(removed, "remove_component debe aceptar un Component existente")
	assert(not found_after, "Tras remove_component, has_component debe ser false")
	assert(not second_remove, "Eliminar dos veces el mismo Component nunca debe aceptarse")
	logger.info("dev_check", "Baja vía fachada", {"removed": removed, "found_after": found_after, "second_remove_rejected": not second_remove})


func _check_invalid_entity_and_type_rejected(entity_registry: EntityRegistry, registry: ComponentRegistry, position_id: int, logger: FrameworkLogger) -> void:
	var destroyed_entity := entity_registry.create_entity()
	entity_registry.destroy_entity(destroyed_entity)
	entity_registry.process_pending_destructions()

	var add_on_destroyed := registry.add_component(destroyed_entity, position_id, {"x": 0, "y": 0})
	var unknown_type_id := 9999
	var add_unknown_type := registry.add_component(entity_registry.create_entity(), unknown_type_id, {"x": 0, "y": 0})

	assert(not add_on_destroyed, "add_component sobre una entidad destruida debe rechazarse")
	assert(not add_unknown_type, "add_component con un ComponentId no registrado debe rechazarse")
	logger.info("dev_check", "Entidad/tipo inválidos rechazados", {
		"add_on_destroyed_rejected": not add_on_destroyed,
		"add_unknown_type_rejected": not add_unknown_type,
	})


func _check_storage_created_lazily(registry: ComponentRegistry, logger: FrameworkLogger) -> void:
	var debug_before: Dictionary = registry.get_debug_info()
	var before: int = debug_before["storages_created"]
	var new_type_id := registry.register_component_type(&"LazyComponent")
	var debug_after: Dictionary = registry.get_debug_info()
	var after_register: int = debug_after["storages_created"]
	logger.info("dev_check", "ComponentStorage se crea de forma perezosa", {
		"storages_before_register": before,
		"storages_after_register_without_add": after_register,
		"no_storage_created_by_register_alone": before == after_register,
	})
	assert(before == after_register, "Registrar un tipo no debe crear su ComponentStorage por sí solo")
	assert(ComponentId.is_valid(new_type_id), "El nuevo tipo debe recibir un ComponentId válido")


func _check_bulk(entity_registry: EntityRegistry, logger: FrameworkLogger) -> void:
	var bulk_logger := FrameworkLogger.new()
	var registry := ComponentRegistry.new(entity_registry, bulk_logger)
	registry.initialize()
	var type_id := registry.register_component_type(&"BulkComponent")

	var entities: Array[int] = []
	var add_start := Time.get_ticks_usec()
	for i in range(BULK_COUNT):
		var entity := entity_registry.create_entity()
		entities.append(entity)
		registry.add_component(entity, type_id, {"value": i})
	var add_elapsed_usec := Time.get_ticks_usec() - add_start

	var all_present := true
	for i in range(BULK_COUNT):
		var data: Dictionary = registry.get_component(entities[i], type_id)
		if data == null or data.value != i:
			all_present = false
			break

	var remove_start := Time.get_ticks_usec()
	var removed_count := 0
	for i in range(0, BULK_COUNT, 2):
		if registry.remove_component(entities[i], type_id):
			removed_count += 1
	var remove_elapsed_usec := Time.get_ticks_usec() - remove_start

	var consistent := true
	for i in range(BULK_COUNT):
		var should_exist := (i % 2) != 0
		var exists := registry.has_component(entities[i], type_id)
		if exists != should_exist:
			consistent = false
			break

	assert(all_present, "Todas las entidades deben recuperar su dato tras el alta masiva vía fachada")
	assert(consistent, "Tras la baja masiva vía fachada, el estado debe permanecer consistente")

	logger.info("dev_check", "Alta/baja masiva vía fachada (20.000 Components)", {
		"bulk_count": BULK_COUNT,
		"all_present_after_bulk_add": all_present,
		"removed_count": removed_count,
		"consistent_after_bulk_remove": consistent,
		"add_elapsed_usec": add_elapsed_usec,
		"remove_elapsed_usec": remove_elapsed_usec,
		"avg_add_usec": float(add_elapsed_usec) / BULK_COUNT,
		"avg_remove_usec": float(remove_elapsed_usec) / removed_count,
	})

## Verificación manual de desarrollo del almacenamiento de Components
## (Sprint 3B): ComponentStorage, ComponentAllocator, ComponentValidator.
##
## Script temporal, fuera del Bootstrap. Instancia EntityRegistry
## (Sprint 2) y ComponentTypeRegistry (Sprint 3A) para probar la
## integración real de validaciones, sin tocar el Bootstrap ni crear
## ningún ComponentRegistry (todavía no existe).
##
## Uso:
##   godot --headless --path game --script res://core/ecs/testing/component_storage_dev_check.gd
extends SceneTree

const BULK_COUNT: int = 20000


func _initialize() -> void:
	var logger := FrameworkLogger.new()

	var entity_registry := EntityRegistry.new(logger)
	entity_registry.initialize()

	var type_registry := ComponentTypeRegistry.new(logger)
	type_registry.initialize()
	var position_id := type_registry.register_type(ComponentType.new(&"PositionComponent"))

	var validator := ComponentValidator.new(entity_registry, type_registry)
	var allocator := ComponentAllocator.new()
	var storage := ComponentStorage.new(allocator)

	_check_add_and_access(entity_registry, validator, storage, position_id, logger)
	_check_replace(entity_registry, validator, storage, position_id, logger)
	_check_duplicate_rejected(entity_registry, validator, storage, position_id, logger)
	_check_remove(entity_registry, validator, storage, position_id, logger)
	_check_invalid_access(storage, logger)
	_check_bulk_storage(entity_registry, logger)

	logger.info("dev_check", "Verificación completa", {"final_count": storage.count()})
	quit()


## Intenta insertar respetando el contrato documentado: sólo llama a
## storage.add() si la entidad es válida, el tipo está registrado y no
## existe ya un componente para esa entidad. Simula cómo lo hará el
## futuro ComponentRegistry.
func _try_add(entity_id: int, data: Variant, storage: ComponentStorage, validator: ComponentValidator, type_id: int) -> bool:
	if not validator.is_entity_valid(entity_id):
		return false
	if not validator.is_type_valid(type_id):
		return false
	if validator.has_component(entity_id, storage):
		return false
	storage.add(EntityId.index_of(entity_id), data)
	return true


func _check_add_and_access(entity_registry: EntityRegistry, validator: ComponentValidator, storage: ComponentStorage, type_id: int, logger: FrameworkLogger) -> void:
	var entity := entity_registry.create_entity()
	var added := _try_add(entity, {"x": 1, "y": 2}, storage, validator, type_id)
	var found := validator.has_component(entity, storage)
	var data: Dictionary = storage.get_data(EntityId.index_of(entity))

	assert(added, "La primera inserción debe aceptarse")
	assert(found, "Tras insertar, has_component debe ser true")
	assert(data.x == 1 and data.y == 2, "El dato leído debe coincidir con el insertado")
	logger.info("dev_check", "Alta y acceso", {"added": added, "found": found, "data": data})


func _check_replace(entity_registry: EntityRegistry, validator: ComponentValidator, storage: ComponentStorage, type_id: int, logger: FrameworkLogger) -> void:
	var entity := entity_registry.create_entity()
	_try_add(entity, {"x": 10, "y": 10}, storage, validator, type_id)
	var count_before := storage.count()

	var replaced := storage.replace(EntityId.index_of(entity), {"x": 99, "y": 99})
	var data: Dictionary = storage.get_data(EntityId.index_of(entity))
	var count_after := storage.count()

	assert(replaced, "replace() sobre una entidad existente debe aceptarse")
	assert(data.x == 99 and data.y == 99, "replace() debe sobrescribir el dato")
	assert(count_before == count_after, "replace() nunca debe alterar la cantidad de componentes")
	logger.info("dev_check", "Reemplazo", {"replaced": replaced, "data": data, "count_stable": count_before == count_after})


func _check_duplicate_rejected(entity_registry: EntityRegistry, validator: ComponentValidator, storage: ComponentStorage, type_id: int, logger: FrameworkLogger) -> void:
	var entity := entity_registry.create_entity()
	_try_add(entity, {"x": 1, "y": 1}, storage, validator, type_id)

	var second_attempt := _try_add(entity, {"x": 2, "y": 2}, storage, validator, type_id)
	var data: Dictionary = storage.get_data(EntityId.index_of(entity))

	assert(not second_attempt, "Un segundo alta sobre la misma entidad debe rechazarse")
	assert(data.x == 1 and data.y == 1, "El dato original no debe alterarse por el intento duplicado")
	logger.info("dev_check", "Duplicado rechazado", {"rejected": not second_attempt, "data_unchanged": data.x == 1})


func _check_remove(entity_registry: EntityRegistry, validator: ComponentValidator, storage: ComponentStorage, type_id: int, logger: FrameworkLogger) -> void:
	var entity := entity_registry.create_entity()
	_try_add(entity, {"x": 7, "y": 7}, storage, validator, type_id)
	var count_before := storage.count()

	storage.remove(EntityId.index_of(entity))
	var found_after := validator.has_component(entity, storage)
	var count_after := storage.count()

	assert(not found_after, "Tras remove(), has_component debe ser false")
	assert(count_after == count_before - 1, "remove() debe reducir el conteo exactamente en uno")
	logger.info("dev_check", "Baja", {"found_after": found_after, "count_before": count_before, "count_after": count_after})


func _check_invalid_access(storage: ComponentStorage, logger: FrameworkLogger) -> void:
	var negative_ok := not storage.has(-1) and storage.get_data(-1) == null
	var far_out_ok := not storage.has(999999) and storage.get_data(999999) == null
	assert(negative_ok and far_out_ok, "Accesos fuera de rango nunca deben corromper el Storage ni lanzar errores")
	logger.info("dev_check", "Acceso inválido seguro", {"negative_ok": negative_ok, "far_out_ok": far_out_ok})


func _check_bulk_storage(entity_registry: EntityRegistry, logger: FrameworkLogger) -> void:
	var logger_bulk := logger
	var type_registry := ComponentTypeRegistry.new(logger_bulk)
	type_registry.initialize()
	var type_id := type_registry.register_type(ComponentType.new(&"BulkComponent"))
	var validator := ComponentValidator.new(entity_registry, type_registry)
	var allocator := ComponentAllocator.new()
	var storage := ComponentStorage.new(allocator)
	storage.reserve(BULK_COUNT)

	var entities: Array[int] = []
	var add_start := Time.get_ticks_usec()
	for i in range(BULK_COUNT):
		var entity := entity_registry.create_entity()
		entities.append(entity)
		_try_add(entity, {"value": i}, storage, validator, type_id)
	var add_elapsed_usec := Time.get_ticks_usec() - add_start

	var all_present := true
	for i in range(BULK_COUNT):
		var data: Dictionary = storage.get_data(EntityId.index_of(entities[i]))
		if data == null or data.value != i:
			all_present = false
			break

	assert(storage.count() == BULK_COUNT, "El conteo debe igualar la cantidad de altas masivas")
	assert(all_present, "Cada entidad debe recuperar exactamente el dato con el que fue insertada")

	var remove_start := Time.get_ticks_usec()
	var removed_count := 0
	for i in range(0, BULK_COUNT, 2):
		storage.remove(EntityId.index_of(entities[i]))
		removed_count += 1
	var remove_elapsed_usec := Time.get_ticks_usec() - remove_start

	var consistent := true
	for i in range(BULK_COUNT):
		var should_exist := (i % 2) != 0
		var exists := storage.has(EntityId.index_of(entities[i]))
		if exists != should_exist:
			consistent = false
			break
		if exists:
			var data: Dictionary = storage.get_data(EntityId.index_of(entities[i]))
			if data.value != i:
				consistent = false
				break

	assert(storage.count() == BULK_COUNT - removed_count, "El conteo tras eliminar debe reflejar exactamente las bajas")
	assert(consistent, "Tras eliminar la mitad, el swap-remove no debe corromper ni desplazar datos de las entidades restantes")

	logger.info("dev_check", "Almacenamiento masivo", {
		"bulk_count": BULK_COUNT,
		"all_present_after_bulk_add": all_present,
		"removed_count": removed_count,
		"consistent_after_bulk_remove": consistent,
		"final_count": storage.count(),
		"final_capacity": allocator.capacity(),
		"add_elapsed_usec": add_elapsed_usec,
		"remove_elapsed_usec": remove_elapsed_usec,
		"avg_add_usec": float(add_elapsed_usec) / BULK_COUNT,
		"avg_remove_usec": float(remove_elapsed_usec) / removed_count,
	})

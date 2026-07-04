## Verificación manual de desarrollo de la integración EntityRegistry +
## ComponentRegistry (Sprint 4 — ECS Runtime Integration).
##
## Script temporal, fuera del Bootstrap. Ensambla EntityRegistry y
## ComponentRegistry exactamente igual que lo hace Bootstrap (mismo
## orden, mismo wiring del listener de destrucción) para verificar la
## coordinación entre Packages sin ejecutar el Bootstrap real. La
## ejecución del Bootstrap real se verifica por separado
## (`godot --headless --quit-after N`).
##
## Uso:
##   godot --headless --path game --script res://core/ecs/testing/runtime_integration_dev_check.gd
extends SceneTree


func _initialize() -> void:
	var logger := FrameworkLogger.new()

	var entity_registry := EntityRegistry.new(logger)
	entity_registry.initialize()

	var component_registry := ComponentRegistry.new(entity_registry, logger)
	component_registry.initialize()
	entity_registry.set_destruction_listener(component_registry.remove_all_components)

	var position_id := component_registry.register_component_type(&"PositionComponent")
	var health_id := component_registry.register_component_type(&"HealthComponent")
	var inventory_id := component_registry.register_component_type(&"InventoryComponent")

	_check_destroy_removes_single_component(entity_registry, component_registry, position_id, logger)
	_check_destroy_removes_multiple_components(entity_registry, component_registry, position_id, health_id, inventory_id, logger)
	_check_destroy_entity_without_components(entity_registry, logger)
	_check_recycled_entity_id_starts_clean(entity_registry, component_registry, position_id, logger)
	_check_unrelated_entity_unaffected(entity_registry, component_registry, position_id, logger)

	logger.info("dev_check", "Verificación completa", component_registry.get_debug_info())
	quit()


func _check_destroy_removes_single_component(entity_registry: EntityRegistry, component_registry: ComponentRegistry, position_id: int, logger: FrameworkLogger) -> void:
	var entity := entity_registry.create_entity()
	component_registry.add_component(entity, position_id, {"x": 1, "y": 1})

	entity_registry.destroy_entity(entity)
	entity_registry.process_pending_destructions()

	var still_has_component := component_registry.has_component(entity, position_id)
	assert(not still_has_component, "Destruir la entidad debe eliminar automáticamente su Component")
	logger.info("dev_check", "Destrucción elimina un Component", {"cleaned_up": not still_has_component})


func _check_destroy_removes_multiple_components(entity_registry: EntityRegistry, component_registry: ComponentRegistry, position_id: int, health_id: int, inventory_id: int, logger: FrameworkLogger) -> void:
	var entity := entity_registry.create_entity()
	component_registry.add_component(entity, position_id, {"x": 2, "y": 2})
	component_registry.add_component(entity, health_id, {"hp": 100})
	component_registry.add_component(entity, inventory_id, {"items": []})

	entity_registry.destroy_entity(entity)
	entity_registry.process_pending_destructions()

	var all_removed := (
		not component_registry.has_component(entity, position_id)
		and not component_registry.has_component(entity, health_id)
		and not component_registry.has_component(entity, inventory_id)
	)
	assert(all_removed, "Destruir una entidad con múltiples tipos de Component debe eliminarlos todos")
	logger.info("dev_check", "Destrucción elimina múltiples Components", {"all_removed": all_removed})


func _check_destroy_entity_without_components(entity_registry: EntityRegistry, logger: FrameworkLogger) -> void:
	var entity := entity_registry.create_entity()
	var active_before := entity_registry.get_active_count()

	entity_registry.destroy_entity(entity)
	var processed := entity_registry.process_pending_destructions()

	var active_after := entity_registry.get_active_count()
	assert(processed >= 1, "La destrucción de una entidad sin Components debe procesarse igualmente")
	assert(active_after == active_before - 1, "El conteo de entidades activas debe reducirse en uno")
	logger.info("dev_check", "Destrucción de entidad sin Components", {
		"processed": processed, "active_before": active_before, "active_after": active_after,
	})


func _check_recycled_entity_id_starts_clean(entity_registry: EntityRegistry, component_registry: ComponentRegistry, position_id: int, logger: FrameworkLogger) -> void:
	var entity_a := entity_registry.create_entity()
	component_registry.add_component(entity_a, position_id, {"x": 9, "y": 9})
	var index_a := EntityId.index_of(entity_a)

	entity_registry.destroy_entity(entity_a)
	entity_registry.process_pending_destructions()

	var entity_b := entity_registry.create_entity()
	var index_b := EntityId.index_of(entity_b)
	var reused_index := index_a == index_b
	var b_has_no_leftover_component := not component_registry.has_component(entity_b, position_id)

	assert(b_has_no_leftover_component, "Una Entity reciclada nunca debe heredar Components de la Entity anterior")
	logger.info("dev_check", "EntityId reciclado sin datos residuales", {
		"reused_index": reused_index,
		"clean": b_has_no_leftover_component,
	})


func _check_unrelated_entity_unaffected(entity_registry: EntityRegistry, component_registry: ComponentRegistry, position_id: int, logger: FrameworkLogger) -> void:
	var survivor := entity_registry.create_entity()
	component_registry.add_component(survivor, position_id, {"x": 42, "y": 42})

	var victim := entity_registry.create_entity()
	component_registry.add_component(victim, position_id, {"x": 0, "y": 0})
	entity_registry.destroy_entity(victim)
	entity_registry.process_pending_destructions()

	var survivor_data: Dictionary = component_registry.get_component(survivor, position_id)
	var survivor_intact: bool = survivor_data != null and survivor_data.x == 42 and survivor_data.y == 42

	assert(survivor_intact, "Destruir una entidad nunca debe afectar los Components de otra entidad viva")
	logger.info("dev_check", "Entidad no relacionada permanece intacta", {"survivor_intact": survivor_intact})

## Verificación manual de desarrollo del EntityRegistry (Sprint 2).
##
## Script temporal, fuera del Bootstrap, que ejercita el ciclo de vida de
## Entities y registra el resultado en el log. No forma parte del
## Framework en ejecución: se invoca manualmente mientras no exista el
## framework de pruebas automatizado (Fase 0B) ni el Scheduler (Fase 3),
## que en el futuro reemplazarán a este script.
##
## Uso:
##   godot --headless --path game --script res://core/ecs/testing/entity_registry_dev_check.gd
extends SceneTree

const BULK_COUNT: int = 1000


func _initialize() -> void:
	var logger := FrameworkLogger.new()
	var registry := EntityRegistry.new(logger)
	registry.initialize()

	_check_create_single(registry, logger)
	_check_recycle(registry, logger)
	_check_stale_handle_rejected(registry, logger)
	_check_bulk_create_and_destroy(registry, logger)
	_check_double_destroy_is_safe(registry, logger)

	logger.info("dev_check", "Verificación completa", registry.get_debug_info())
	quit()


func _check_create_single(registry: EntityRegistry, logger: FrameworkLogger) -> void:
	var id := registry.create_entity()
	var ok := registry.is_alive(id)
	assert(ok, "La Entity recién creada debe estar ALIVE")
	logger.info("dev_check", "Crear una Entity", {"ok": ok, "id": id})


func _check_recycle(registry: EntityRegistry, logger: FrameworkLogger) -> void:
	var id := registry.create_entity()
	var index_before := EntityId.index_of(id)

	registry.destroy_entity(id)
	registry.process_pending_destructions()

	var new_id := registry.create_entity()
	var index_after := EntityId.index_of(new_id)
	var same_index := index_before == index_after
	var different_generation := EntityId.generation_of(new_id) != EntityId.generation_of(id)

	assert(not registry.is_alive(id), "El EntityId destruido no debe seguir vivo")
	assert(registry.is_alive(new_id), "El nuevo EntityId reciclado debe estar ALIVE")
	logger.info("dev_check", "Reciclar índice tras destrucción", {
		"same_index": same_index,
		"different_generation": different_generation,
	})


func _check_stale_handle_rejected(registry: EntityRegistry, logger: FrameworkLogger) -> void:
	var id := registry.create_entity()
	registry.destroy_entity(id)
	registry.process_pending_destructions()

	var rejected := not registry.is_alive(id)
	assert(rejected, "Un handle obsoleto nunca debe volver a ser válido")
	logger.info("dev_check", "Handle obsoleto rechazado", {"rejected": rejected})


func _check_bulk_create_and_destroy(registry: EntityRegistry, logger: FrameworkLogger) -> void:
	var active_before := registry.get_active_count()
	var ids: Array[int] = []
	for _i in range(BULK_COUNT):
		ids.append(registry.create_entity())

	var all_alive := true
	for id in ids:
		if not registry.is_alive(id):
			all_alive = false
			break

	for id in ids:
		registry.destroy_entity(id)
	var processed := registry.process_pending_destructions()

	assert(all_alive, "Todas las entidades del lote deben estar ALIVE antes de destruirlas")
	assert(processed == BULK_COUNT, "Deben procesarse exactamente las destrucciones solicitadas")
	assert(registry.get_active_count() == active_before, "El conteo activo debe volver al valor previo al lote")
	logger.info("dev_check", "Creación y destrucción masiva", {
		"count": BULK_COUNT,
		"all_alive_before_destroy": all_alive,
		"processed": processed,
		"active_after": registry.get_active_count(),
	})


func _check_double_destroy_is_safe(registry: EntityRegistry, logger: FrameworkLogger) -> void:
	var id := registry.create_entity()
	registry.destroy_entity(id)
	registry.process_pending_destructions()

	var second_attempt := registry.destroy_entity(id)
	assert(not second_attempt, "Destruir dos veces la misma Entity nunca debe aceptarse")
	logger.info("dev_check", "Doble destrucción no produce corrupción", {
		"second_attempt_rejected": not second_attempt,
	})

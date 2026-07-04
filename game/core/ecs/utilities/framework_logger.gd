## Logging interno del Framework ECS.
##
## Servicio propio del Runtime, independiente del futuro "Log Manager" de
## gameplay (docs/Managers/*, fuera de alcance del Framework). Se usa
## exclusivamente para diagnosticar el arranque y la ejecución interna
## del Runtime (Bootstrap, Core, Scheduler, etc.).
##
## No es un AutoLoad: cada servicio recibe su instancia explícitamente
## (inyección de dependencias), evitando estado global implícito.
class_name FrameworkLogger
extends RefCounted

enum Level {
	INFO,
	WARNING,
	ERROR,
	FATAL,
}

const LEVEL_NAMES: Dictionary = {
	Level.INFO: "INFO",
	Level.WARNING: "WARNING",
	Level.ERROR: "ERROR",
	Level.FATAL: "FATAL",
}


## Registra un mensaje estructurado y determinista.
##
## subsystem: nombre corto del subsistema emisor (ej: "bootstrap", "core").
## message: qué ocurrió, de forma concreta y accionable.
## details: contexto adicional opcional (valores simples serializables).
func log_message(level: Level, subsystem: String, message: String, details: Dictionary = {}) -> void:
	var line := _format(level, subsystem, message, details)
	match level:
		Level.INFO:
			print(line)
		Level.WARNING:
			push_warning(line)
		Level.ERROR, Level.FATAL:
			push_error(line)


func info(subsystem: String, message: String, details: Dictionary = {}) -> void:
	log_message(Level.INFO, subsystem, message, details)


func warning(subsystem: String, message: String, details: Dictionary = {}) -> void:
	log_message(Level.WARNING, subsystem, message, details)


func error(subsystem: String, message: String, details: Dictionary = {}) -> void:
	log_message(Level.ERROR, subsystem, message, details)


func fatal(subsystem: String, message: String, details: Dictionary = {}) -> void:
	log_message(Level.FATAL, subsystem, message, details)


func _format(level: Level, subsystem: String, message: String, details: Dictionary) -> String:
	if details.is_empty():
		return "[%s][%s] %s" % [LEVEL_NAMES[level], subsystem, message]
	return "[%s][%s] %s | details=%s" % [LEVEL_NAMES[level], subsystem, message, details]

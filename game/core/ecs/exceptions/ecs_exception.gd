## Excepción base del Framework ECS.
##
## GDScript no posee try/catch ni throw nativos, por lo que el Framework
## no "lanza" estos objetos: los construye y los propaga explícitamente
## como valor de retorno (o los entrega al Logger) para mantener un
## formato de error consistente y tipificado en todo el Runtime.
##
## Ver docs/Implementation/02_ECS_DIRECTORY_STRUCTURE.md (directorio exceptions/).
class_name ECSException
extends RefCounted

## Subsistema del Framework que originó el error (ej: "bootstrap", "core").
var subsystem: String = ""

## Mensaje legible describiendo qué ocurrió.
var message: String = ""

## Contexto adicional para depuración (valores simples, sin referencias vivas).
var details: Dictionary = {}


func _init(p_subsystem: String, p_message: String, p_details: Dictionary = {}) -> void:
	subsystem = p_subsystem
	message = p_message
	details = p_details


## Representación uniforme para logging.
func format() -> String:
	if details.is_empty():
		return "[%s] %s" % [subsystem, message]
	return "[%s] %s | details=%s" % [subsystem, message, details]

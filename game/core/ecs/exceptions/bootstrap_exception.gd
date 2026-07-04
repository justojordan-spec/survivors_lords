## Excepción específica del proceso de Bootstrap.
##
## Representa un fallo crítico durante la inicialización del Framework.
## Por política del Bootstrap (docs/Implementation/01_PROJECT_BOOTSTRAP.md,
## "Gestión de Errores"), todo BootstrapException es fatal: detiene el
## arranque, cancela el Bootstrap y nunca permite continuar en un estado
## parcialmente inicializado.
class_name BootstrapException
extends ECSException

## Etapa de la máquina de estados del Bootstrap en la que ocurrió el fallo.
var stage: String = ""


func _init(p_stage: String, p_message: String, p_details: Dictionary = {}) -> void:
	stage = p_stage
	super._init("bootstrap", p_message, p_details)


func format() -> String:
	return "[bootstrap:%s] %s | details=%s" % [stage, message, details]

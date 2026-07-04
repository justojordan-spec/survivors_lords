## Contrato: representa un servicio del Framework que requiere una
## inicialización explícita y controlada antes de poder utilizarse.
##
## Ver docs/Implementation/03_CORE_INTERFACES.md (IInitializable).
##
## Los servicios que hereden de Node (y por lo tanto no puedan heredar de
## esta clase por la falta de herencia múltiple en GDScript) deben
## implementar los mismos métodos por duck typing, dejando constancia en
## un comentario de qué contrato están cumpliendo.
class_name IInitializable
extends RefCounted


## Inicializa el servicio. Debe poder invocarse una única vez.
## No debe crear gameplay, iniciar Systems, ni depender del SceneTree.
func initialize() -> void:
	push_error("IInitializable.initialize() no implementado por %s" % [get_script()])


## Indica si el servicio ya fue inicializado.
func is_initialized() -> bool:
	push_error("IInitializable.is_initialized() no implementado por %s" % [get_script()])
	return false

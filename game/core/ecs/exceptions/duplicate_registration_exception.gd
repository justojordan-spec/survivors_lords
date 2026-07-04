## Excepción para registros duplicados en cualquier Registry del Framework
## (DuplicateRegistrationException).
##
## Ejemplo de uso: ComponentTypeRegistry.register_type() recibe una
## declaración para un tipo ya registrado. Ver docs/Implementation/
## 02_ECS_DIRECTORY_STRUCTURE.md (directorio exceptions/, donde este
## nombre aparece explícitamente listado como ejemplo).
##
## Como el resto de excepciones del Framework, no se "lanza": se
## construye y se entrega al Logger (GDScript no posee try/catch) — ver
## ECSException.
class_name DuplicateRegistrationException
extends ECSException


func _init(p_subsystem: String, p_type_name: String, p_details: Dictionary = {}) -> void:
	super._init(p_subsystem, "Registro duplicado: '%s' ya estaba registrado" % p_type_name, p_details)

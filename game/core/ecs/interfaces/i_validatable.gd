## Contrato: representa un servicio capaz de verificar su propia
## consistencia interna (dependencias satisfechas, estado consistente).
##
## Ver docs/Implementation/03_CORE_INTERFACES.md (IValidatable).
##
## Permite al Bootstrap verificar automáticamente el estado del Framework
## antes de avanzar a la siguiente etapa de inicialización.
class_name IValidatable
extends RefCounted


## Devuelve true si el servicio se encuentra en un estado consistente.
func validate() -> bool:
	push_error("IValidatable.validate() no implementado por %s" % [get_script()])
	return false

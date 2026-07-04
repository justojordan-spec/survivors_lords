## Contrato: representa un servicio capaz de exponer información interna
## útil para herramientas de depuración, sin alterar el estado del Runtime.
##
## Ver docs/Implementation/03_CORE_INTERFACES.md (IDebuggable).
class_name IDebuggable
extends RefCounted


## Devuelve un diccionario con información de diagnóstico del servicio.
## Nunca debe modificar el estado interno del Runtime.
func get_debug_info() -> Dictionary:
	push_error("IDebuggable.get_debug_info() no implementado por %s" % [get_script()])
	return {}

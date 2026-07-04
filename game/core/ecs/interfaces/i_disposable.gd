## Contrato: representa un servicio capaz de liberar correctamente sus
## recursos al finalizar su ciclo de vida.
##
## Ver docs/Implementation/03_CORE_INTERFACES.md (IDisposable).
##
## dispose() nunca debe reinicializar el objeto ni reconstruir recursos;
## su única función es liberar (referencias, buffers, cachés, suscripciones).
class_name IDisposable
extends RefCounted


## Libera los recursos retenidos por el servicio.
func dispose() -> void:
	push_error("IDisposable.dispose() no implementado por %s" % [get_script()])

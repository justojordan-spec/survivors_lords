## Contrato: ISystem.
##
## Contrato mínimo común de cualquier System del Framework. Deliberadamente
## pequeño: sólo declara el ciclo de vida (initialize/shutdown) y el punto
## de entrada de ejecución (update), que en el futuro invocará
## exclusivamente el Scheduler (Fase 3, todavía inexistente). No declara
## identidad, prioridades ni fase de ejecución como parte del contrato
## obligatorio — ver SystemBase/SystemPhase para esos metadatos opcionales
## (docs/Implementation/06_SYSTEM_BASE.md, "ISystem").
class_name ISystem
extends RefCounted


## Recibe el contexto del Runtime (única forma de acceder a los
## Registries) y prepara el System. Debe invocarse una única vez, nunca
## automáticamente al construirse.
func initialize(_context: IECSContext) -> void:
	push_error("ISystem.initialize() no implementado por %s" % [get_script()])


## Punto de entrada de ejecución. No debe ser invocado directamente por
## otro System; en el futuro lo invocará exclusivamente el Scheduler.
func update(_delta: float) -> void:
	push_error("ISystem.update() no implementado por %s" % [get_script()])


## Libera referencias y recursos. Nunca destruye entidades ni Components.
func shutdown() -> void:
	push_error("ISystem.shutdown() no implementado por %s" % [get_script()])

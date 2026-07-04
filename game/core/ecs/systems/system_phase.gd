## Fase de ejecución declarable por un System (SystemPhase).
##
## Metadato puramente declarativo, sin comportamiento: un System expone
## en qué fase preferiría ejecutarse, pero no decide nada por sí mismo.
## "Los Systems únicamente declaran metadatos. La resolución pertenece al
## Scheduler" (docs/Implementation/06_SYSTEM_BASE.md, "Orden de
## Ejecución", "SystemMetadata"). El futuro Scheduler (Fase 3) es quien
## interpretará este valor; hasta entonces sólo se declara y se consulta.
class_name SystemPhase
extends RefCounted

enum Phase {
	PRE_UPDATE,
	UPDATE,
	POST_UPDATE,
}


static func name_of(phase: Phase) -> String:
	return Phase.keys()[phase]

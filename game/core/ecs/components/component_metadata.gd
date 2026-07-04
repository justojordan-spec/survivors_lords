## Metadatos inmutables de un tipo de Component ya registrado
## (ComponentMetadata).
##
## Responsabilidad:
##   Asociar de forma inmutable un ComponentId con el nombre del tipo que
##   lo originó. Representa exactamente la "Type metadata" mencionada en
##   docs/Implementation/13_IMPLEMENTATION_ROADMAP.md (Fase 2, Package 2 —
##   Component Metadata): "Metadata immutable after registration".
##
## Dependencias: ninguna.
##
## Invariantes:
##   - Una vez creada, ni id ni type_name cambian.
##
## Complejidad: acceso a campos O(1).
class_name ComponentMetadata
extends RefCounted

var id: int
var type_name: StringName


func _init(p_id: int, p_type_name: StringName) -> void:
	id = p_id
	type_name = p_type_name

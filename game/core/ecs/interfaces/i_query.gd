## Contrato: IQuery.
##
## Representa una consulta ECS preparada para describir qué Entities le
## interesan a un System. Nunca ejecuta la búsqueda, nunca conoce el
## almacenamiento interno y nunca conoce al Scheduler
## (docs/Implementation/03_CORE_INTERFACES.md, IQuery; docs/ECS/
## 06_QUERY_SYSTEM.md, "¿Qué es una Query?").
##
## Describe Components mediante ComponentId (enteros ya asignados por
## ComponentTypeRegistry), nunca mediante clases o Scripts concretos —
## ver la decisión documentada en el informe del Sprint 6.
class_name IQuery
extends RefCounted


## ComponentId que una Entity debe poseer todos para coincidir.
func get_required_components() -> Array[int]:
	push_error("IQuery.get_required_components() no implementado por %s" % [get_script()])
	return []


## ComponentId cuya presencia descarta a la Entity del resultado.
func get_excluded_components() -> Array[int]:
	push_error("IQuery.get_excluded_components() no implementado por %s" % [get_script()])
	return []


## ComponentId que, si están presentes, aportan información adicional
## pero cuya ausencia nunca descarta a la Entity.
func get_optional_components() -> Array[int]:
	push_error("IQuery.get_optional_components() no implementado por %s" % [get_script()])
	return []

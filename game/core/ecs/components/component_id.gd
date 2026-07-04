## Identificador opaco y estable de un tipo de Component (ComponentId).
##
## Responsabilidad:
##   Representar, como entero simple, el identificador interno asignado a
##   un tipo de Component registrado. A diferencia de EntityId, no incluye
##   generación: un tipo registrado nunca se destruye ni se recicla
##   mientras el Runtime permanece activo (docs/Implementation/
##   05_COMPONENT_REGISTRY.md, "Registro de Tipos": "no deben eliminarse
##   tipos existentes").
##
## Dependencias: ninguna.
##
## Invariantes:
##   - INVALID nunca coincide con un id real asignado por
##     ComponentTypeRegistry.
##   - Un ComponentId nunca debe persistirse en archivos de guardado ni
##     transmitirse por red como identificador permanente (documento,
##     "Component Type ID"): sólo es estable durante la vida del Runtime.
##
## Complejidad: is_valid() es O(1).
class_name ComponentId
extends RefCounted

## Identificador reservado que nunca representa un tipo registrado.
const INVALID: int = -1


static func is_valid(id: int) -> bool:
	return id != INVALID

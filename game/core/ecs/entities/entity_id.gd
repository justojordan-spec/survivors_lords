## Identificador opaco y generacional de una Entity (EntityId).
##
## Responsabilidad:
##   Empaquetar y desempaquetar un EntityId como un único entero de 64 bits
##   (índice en los 32 bits bajos, generación en los 32 bits altos), de
##   forma que comparar, almacenar y transportar identificadores sea una
##   operación primitiva sin asignar memoria adicional.
##
## Dependencias: ninguna.
##
## Invariantes:
##   - INVALID nunca coincide con ningún par (índice, generación) real.
##   - index_of()/generation_of() son funciones puras de extracción de
##     bits; nunca consultan el estado del Registry ni del Storage.
##   - Los consumidores del Framework nunca deben interpretar manualmente
##     el contenido interno de un EntityId (docs/Implementation/
##     04_ENTITY_REGISTRY.md, "Entity Identifier"); deben usar siempre
##     pack()/index_of()/generation_of().
##
## Complejidad: todas las operaciones son O(1) y no asignan memoria.
##
## Ver docs/Implementation/04_ENTITY_REGISTRY.md ("Entity Identifier",
## "IDs Generacionales").
class_name EntityId
extends RefCounted

## Identificador reservado que nunca representa una Entity válida.
const INVALID: int = -1

const _INDEX_MASK: int = 0xFFFFFFFF
const _GENERATION_SHIFT: int = 32

## Generación máxima representable antes de que un índice deba retirarse
## permanentemente. Ver EntityAllocator ("Generation overflow").
const MAX_GENERATION: int = 0x7FFFFFFF


## Empaqueta índice y generación en un identificador opaco. O(1).
static func pack(index: int, generation: int) -> int:
	return (generation << _GENERATION_SHIFT) | (index & _INDEX_MASK)


## Extrae el índice físico de un identificador. O(1).
static func index_of(id: int) -> int:
	return id & _INDEX_MASK


## Extrae la generación de un identificador. O(1).
static func generation_of(id: int) -> int:
	return id >> _GENERATION_SHIFT


## Un identificador es sintácticamente válido si no es INVALID.
## No implica que la Entity siga viva: eso lo determina EntityValidator. O(1).
static func is_valid(id: int) -> bool:
	return id != INVALID

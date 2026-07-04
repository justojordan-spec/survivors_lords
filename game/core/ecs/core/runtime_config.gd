## Configuración propia del Runtime del Framework (IConfigurable).
##
## No es configuración de gameplay ni de usuario: sólo los parámetros que
## el propio Bootstrap necesita para decidir cómo arrancar el Runtime.
## Ver docs/Implementation/03_CORE_INTERFACES.md (IConfigurable) y
## docs/Implementation/01_PROJECT_BOOTSTRAP.md ("NETWORK_READY").
class_name RuntimeConfig
extends RefCounted

enum ExecutionMode {
	SINGLE_PLAYER,
	HOST,
	CLIENT,
	DEDICATED_SERVER,
}

var execution_mode: ExecutionMode = ExecutionMode.SINGLE_PLAYER


func _init(p_execution_mode: ExecutionMode = ExecutionMode.SINGLE_PLAYER) -> void:
	execution_mode = p_execution_mode


## IValidatable.validate() — verifica que la configuración sea consistente.
func validate() -> bool:
	return ExecutionMode.values().has(execution_mode)


## Configuración por defecto y segura: Single Player.
## DEC-006 (ai/DECISIONS.md): la primera versión del juego es para un
## jugador; la arquitectura ya está preparada para host/cliente/servidor
## dedicado cuando el Framework de Multiplayer (Fase 8) exista.
static func load_default() -> RuntimeConfig:
	return RuntimeConfig.new(ExecutionMode.SINGLE_PLAYER)

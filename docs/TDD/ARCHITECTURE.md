# Survivors Lords

# ARCHITECTURE

Versión: 1.0

---

# Objetivo

Definir la arquitectura técnica del proyecto.

Toda implementación deberá respetar esta estructura.

---

# Filosofía

Arquitectura modular.

Cada sistema tendrá una única responsabilidad.

Los sistemas deberán poder evolucionar sin romper otros sistemas.

El proyecto debe poder crecer durante años.

---

# Estructura General

survivors_lords/

├── ai/

├── docs/

├── assets/

├── game/

└── tools/

---

# Dentro de game/

game/

├── autoload/

├── scenes/

├── scripts/

├── resources/

├── ui/

├── audio/

├── shaders/

└── tests/

---

# Escenas

scenes/

player/

enemy/

world/

dungeons/

kingdom/

ui/

---

# Scripts

scripts/

player/

enemy/

combat/

inventory/

quests/

world/

kingdom/

utils/

---

# Recursos

resources/

items/

weapons/

armor/

skills/

enemies/

quests/

---

# Managers (Autoload)

Los siguientes sistemas serán Singleton (Autoload).

GameManager

SceneManager

SaveManager

AudioManager

InputManager

PlayerManager

InventoryManager

CombatManager

QuestManager

WorldManager

KingdomManager

UIManager

EventManager

---

# Responsabilidad de cada Manager

GameManager

Estado general del juego.

---

SceneManager

Cambio de escenas.

---

SaveManager

Guardar y cargar partidas.

---

AudioManager

Música y efectos.

---

InputManager

Entrada del jugador.

---

PlayerManager

Información global del jugador.

---

InventoryManager

Inventario.

---

CombatManager

Daño, combate y estados.

---

QuestManager

Misiones.

---

WorldManager

Estado del mundo.

---

KingdomManager

Estado del Reino.

---

UIManager

Interfaces.

---

EventManager

Eventos globales.

---

# Comunicación

Los Managers no deben depender unos de otros directamente.

Siempre utilizar eventos o llamadas bien definidas.

Evitar referencias cruzadas.

---

# Código

Cada script debe tener una única responsabilidad.

Evitar scripts gigantes.

Máximo recomendado:

300 líneas por script.

Si supera ese tamaño, dividir responsabilidades.

---

# Convenciones

Escenas

snake_case.tscn

Scripts

snake_case.gd

Clases

PascalCase

Variables

snake_case

Constantes

UPPER_CASE

Funciones

snake_case()

---

# Objetivo Final

Que cualquier desarrollador pueda entender el proyecto en pocos minutos.
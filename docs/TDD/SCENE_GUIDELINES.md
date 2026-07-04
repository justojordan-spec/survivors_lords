# Survivors Lords

# SCENE GUIDELINES

Versión: 1.0

---

# Objetivo

Definir las reglas para crear escenas en Godot.

Todas las escenas del proyecto deberán seguir estas normas para mantener consistencia, reutilización y facilidad de mantenimiento.

---

# Principios

- Una escena = un único propósito.
- Las escenas deben ser reutilizables.
- Evitar escenas gigantes.
- Preferir composición antes que herencia.
- Mantener una jerarquía clara.

---

# Estructura de una Escena

Cada escena debe tener un nodo raíz apropiado.

Ejemplos:

Player → CharacterBody3D

Enemy → CharacterBody3D

Objeto interactivo → Node3D

Interfaz → Control

---

# Ejemplo: Player

Player.tscn

CharacterBody3D
├── CollisionShape3D
├── MeshInstance3D
├── AnimationPlayer
├── AnimationTree
├── CameraPivot
│   └── Camera3D
├── InteractionArea
├── HealthComponent
├── InventoryComponent
└── SkillComponent

---

# Ejemplo: Enemigo

Enemy.tscn

CharacterBody3D
├── CollisionShape3D
├── MeshInstance3D
├── AnimationPlayer
├── NavigationAgent3D
├── HealthComponent
├── AIComponent
└── Hitbox

---

# Componentes

Siempre que sea posible utilizar componentes reutilizables.

Ejemplos:

HealthComponent

DamageComponent

InventoryComponent

InteractionComponent

SkillComponent

---

# Escenas UI

Cada ventana será una escena independiente.

Ejemplos:

MainMenu.tscn

HUD.tscn

InventoryUI.tscn

SettingsMenu.tscn

PauseMenu.tscn

---

# Escenas del Mundo

Las regiones estarán separadas.

Ejemplo:

world/

forest/

desert/

mountain/

swamp/

---

# Mazmorras

Cada mazmorra será una escena independiente.

Nunca incluir varias mazmorras en una sola escena.

---

# NPC

Cada tipo de NPC tendrá su propia escena.

Ejemplo:

Merchant.tscn

Blacksmith.tscn

Alchemist.tscn

Guard.tscn

Villager.tscn

---

# Jefes

Cada jefe será una escena individual.

Permitirá reutilizar IA y habilidades.

---

# Organización

Nunca mezclar:

Jugador

Enemigos

UI

Mundo

Objetos

Cada sistema tendrá su propia carpeta.

---

# Convenciones

Escenas:

snake_case.tscn

Ejemplos:

player.tscn

forest_region.tscn

main_menu.tscn

---

# Regla Principal

Si una escena supera una complejidad razonable deberá dividirse en escenas más pequeñas reutilizables.

---

# Objetivo Final

Crear escenas simples, reutilizables y fáciles de mantener durante todo el desarrollo del proyecto.
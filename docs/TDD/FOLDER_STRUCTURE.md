# Survivors Lords

# FOLDER STRUCTURE

Versión: 1.0

---

# Objetivo

Definir la organización oficial del proyecto.

Todos los archivos deberán respetar esta estructura.

No crear carpetas nuevas sin una decisión registrada en DECISIONS.md.

---

# Estructura Principal

survivors_lords/

├── ai/
├── assets/
├── docs/
├── game/
├── tools/

---

# ai/

Documentación del equipo de IA.

Contiene:

- Roles
- Reglas
- Roadmap
- Decisiones
- Tareas

No contiene código.

---

# assets/

Recursos originales del proyecto.

Ejemplos:

- Modelos 3D
- Texturas
- Música
- Sonidos
- Concept Art
- Animaciones

Nunca guardar código aquí.

---

# docs/

Toda la documentación oficial.

Subcarpetas:

GDD/

TDD/

Lore/

Systems/

Art/

UI/

Audio/

---

# game/

Proyecto de Godot.

Contiene exclusivamente archivos utilizados por el juego.

---

# game/autoload/

Singletons.

Ejemplos:

GameManager

SaveManager

SceneManager

CombatManager

---

# game/scenes/

Escenas del juego.

Ejemplo:

player/

enemy/

world/

kingdom/

ui/

---

# game/scripts/

Lógica del juego.

Separada por sistemas.

Ejemplo:

player/

combat/

inventory/

quests/

world/

utils/

---

# game/resources/

Resources de Godot.

Ejemplo:

Items

Skills

Enemies

Quests

Loot Tables

---

# game/ui/

Interfaces.

HUD

Menús

Inventario

Mapa

Configuración

---

# game/audio/

Música y efectos.

Separados por categorías.

music/

sfx/

voices/

ambient/

---

# game/shaders/

Shaders personalizados.

---

# game/tests/

Escenas de prueba.

Nunca mezclar pruebas con escenas finales.

---

# tools/

Herramientas para desarrollo.

Scripts.

Conversores.

Importadores.

Generadores.

No forman parte del juego final.

---

# Reglas

Cada archivo debe tener una única responsabilidad.

No duplicar recursos.

No crear carpetas temporales.

Eliminar archivos obsoletos.

Mantener nombres consistentes.

---

# Convención de nombres

Escenas

snake_case.tscn

Scripts

snake_case.gd

Resources

snake_case.tres

Imágenes

snake_case.png

Audio

snake_case.ogg

Modelos

snake_case.glb

---

# Objetivo

Que cualquier desarrollador pueda encontrar cualquier archivo en menos de un minuto.
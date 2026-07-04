# Survivors Lords

# FOLDER STRUCTURE

Versión: 1.0

---

# Objetivo

Definir la estructura oficial de carpetas del proyecto.

Toda nueva carpeta, escena, script o recurso deberá respetar esta organización.

El objetivo es mantener un proyecto limpio, escalable y fácil de navegar.

---

# Filosofía

La estructura debe:

- Ser clara.
- Ser modular.
- Evitar archivos duplicados.
- Facilitar el trabajo en equipo.
- Facilitar el trabajo de IA como Claude y Gemini.

---

# Estructura Principal

```
SurvivorsLords/
│
├── addons/
├── assets/
├── docs/
├── project/
└── tools/
```

---

# Carpeta Project

Todo el juego vive dentro de:

```
project/
│
├── scenes/
├── scripts/
├── resources/
├── assets/
├── ui/
├── audio/
├── shaders/
├── saves/
├── localization/
└── tests/
```

---

# Scenes

Contiene únicamente escenas (.tscn)

```
scenes/
│
├── Main/
├── Player/
├── Enemies/
├── NPC/
├── World/
├── Kingdom/
├── Buildings/
├── Items/
├── UI/
├── Effects/
├── Props/
├── Dungeons/
└── Multiplayer/
```

Cada carpeta contendrá únicamente escenas.

Nunca scripts.

---

# Scripts

Contiene únicamente código.

```
scripts/
│
├── Core/
├── Managers/
├── Components/
├── Player/
├── Enemy/
├── NPC/
├── World/
├── Kingdom/
├── Items/
├── Inventory/
├── Combat/
├── Skills/
├── Quests/
├── Building/
├── Multiplayer/
├── Save/
├── UI/
├── Audio/
├── Utils/
└── Debug/
```

---

# Resources

Todos los datos configurables.

```
resources/
│
├── Items/
├── Weapons/
├── Armor/
├── Buildings/
├── Recipes/
├── Enemies/
├── NPC/
├── Skills/
├── Quests/
├── Professions/
├── Biomes/
├── Regions/
├── Loot/
├── Audio/
└── Config/
```

Todo deberá almacenarse mediante Resources.

Nunca valores hardcodeados.

---

# Assets

Contenido artístico.

```
assets/
│
├── Models/
├── Textures/
├── Materials/
├── Icons/
├── Fonts/
├── Sprites/
├── Animations/
├── VFX/
└── Cinematics/
```

---

# UI

Recursos específicos de interfaz.

```
ui/
│
├── HUD/
├── Menus/
├── Inventory/
├── Kingdom/
├── Crafting/
├── Multiplayer/
├── Widgets/
└── Themes/
```

---

# Audio

```
audio/
│
├── Music/
├── Ambient/
├── SFX/
├── Voices/
└── UI/
```

---

# Saves

```
saves/
│
├── Autosave/
├── Manual/
└── Backup/
```

---

# Localization

```
localization/
│
├── en/
├── es/
├── pt/
├── fr/
└── de/
```

Preparado para múltiples idiomas.

---

# Tests

```
tests/
│
├── Unit/
├── Integration/
└── Performance/
```

---

# Convención de Nombres

Escenas:

```
Player.tscn

Goblin.tscn

Blacksmith.tscn
```

---

Scripts

```
Player.gd

EnemyAI.gd

InventoryManager.gd
```

---

Resources

```
IronSword.tres

GoblinData.tres

ForestBiome.tres
```

---

# Reglas

Nunca mezclar:

- Assets
- Código
- Escenas
- Datos

Cada tipo de archivo tendrá su carpeta.

---

# Organización

Cada sistema debe poder encontrarse rápidamente.

Ejemplo:

```
Combat

↓

scripts/Combat

resources/Weapons

scenes/Effects
```

---

# Dependencias

Evitar referencias entre carpetas no relacionadas.

Los Managers actuarán como punto central de comunicación.

---

# Escalabilidad

La estructura deberá soportar:

- DLC.
- Mods.
- Nuevos biomas.
- Nuevas profesiones.
- Eventos temporales.
- Contenido descargable.

Sin reorganizar carpetas existentes.

---

# Integración

Toda la arquitectura del proyecto depende de esta estructura.

Claude deberá respetarla siempre.

---

# Consideraciones para Claude

Nunca crear carpetas nuevas sin una razón justificada.

Ubicar cada archivo en la carpeta correspondiente.

Mantener una separación estricta entre código, datos y contenido visual.

---

# Consideraciones para Gemini

Todo contenido generado deberá respetar la estructura oficial.

Los nombres deberán ser consistentes y descriptivos.

---

# Estado

Arquitectura aprobada.

Pendiente de implementación.

---

# Objetivo Final

Mantener un proyecto organizado, escalable y fácil de mantener durante todo el desarrollo de Survivors Lords.
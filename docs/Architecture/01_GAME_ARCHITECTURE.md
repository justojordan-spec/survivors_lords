# Survivors Lords

# GAME ARCHITECTURE

Versión: 1.0

---

# Objetivo

Definir la arquitectura general del proyecto.

Este documento establece cómo se organizan todos los sistemas, cómo se comunican entre sí y cuáles son las responsabilidades de cada componente.

Toda implementación deberá respetar esta arquitectura.

---

# Filosofía

La arquitectura debe ser:

- Modular.
- Escalable.
- Data-Driven.
- Fácil de mantener.
- Preparada para cooperativo.
- Preparada para futuras expansiones.

Ningún sistema debe depender directamente de otro si puede evitarse.

La comunicación deberá realizarse mediante Managers, Eventos o Interfaces.

---

# Principios

## Single Responsibility

Cada clase tendrá una única responsabilidad.

Ejemplo:

InventoryManager

↓

Solo administra inventarios.

Nunca manejará combate ni guardado.

---

## Bajo Acoplamiento

Los sistemas deben depender lo mínimo posible entre sí.

Ejemplo:

Player

↓

No conoce cómo funciona SaveManager.

Solo expone los datos necesarios.

---

## Alta Cohesión

Cada módulo agrupa funcionalidades relacionadas.

Ejemplo:

Todo el código del Reino pertenece al Kingdom System.

---

## Data Driven

Las reglas del juego estarán definidas mediante Resources y archivos de datos.

Nunca mediante valores escritos directamente en el código.

---

## Modularidad

Cada sistema podrá reemplazarse sin afectar al resto.

Ejemplo:

Cambiar el sistema de inventario no debería romper el sistema de combate.

---

# Arquitectura General

```text
Jugador
    │
    ▼
Input System
    │
    ▼
GameManager
    │
─────────────────────────────────────
│        │        │        │
▼        ▼        ▼        ▼
World   Player   Kingdom  UI
Manager Manager  Manager Manager
│        │        │        │
─────────────────────────────────────
│        │        │        │
Combat Inventory Quest Save
Manager Manager   Manager Manager
│
─────────────────────────────────────
│
Audio
Network
AI
EventBus
```

---

# Flujo General

Inicio

↓

Main Scene

↓

GameManager

↓

Carga Configuración

↓

Carga Recursos

↓

Carga Managers

↓

Carga Mundo

↓

Carga Jugador

↓

Carga UI

↓

Comienza la partida

---

# Sistemas Principales

Los sistemas principales son:

- GameManager
- WorldManager
- PlayerManager
- KingdomManager
- CombatManager
- InventoryManager
- ItemManager
- QuestManager
- AudioManager
- SaveManager
- UIManager
- NetworkManager
- EventBus

---

# Comunicación

Los Managers nunca deberán comunicarse mediante referencias directas cuando exista una alternativa más desacoplada.

Se utilizarán:

- Señales (Signals)
- Eventos
- Interfaces
- Managers centrales

---

# Event Bus

El proyecto utilizará un EventBus global.

Ejemplos:

PlayerDied

EnemyKilled

QuestCompleted

BuildingConstructed

RegionLiberated

KingdomLevelUp

InventoryChanged

Este sistema reducirá el acoplamiento entre módulos.

---

# Escenas

Las escenas deberán mantenerse pequeñas.

Cada escena tendrá una responsabilidad concreta.

Las escenas grandes estarán compuestas por subescenas.

---

# Resources

Toda configuración estará en Resources.

Ejemplos:

EnemyData

WeaponData

ArmorData

BuildingData

RecipeData

SkillData

QuestData

NPCData

BiomeData

---

# Persistencia

Cada sistema será responsable de guardar y cargar únicamente sus propios datos.

El SaveManager coordinará el proceso.

---

# Multiplayer

Toda lógica importante se ejecutará en el Host.

Los clientes enviarán únicamente acciones.

---

# IA

La IA de enemigos será completamente independiente.

No dependerá del Player.

Solo reaccionará a información del mundo.

---

# Rendimiento

Evitar:

- Búsquedas constantes.
- GetNode repetitivos.
- Instanciaciones innecesarias.
- Código duplicado.

Utilizar:

- Object Pooling.
- Caché.
- Streaming.
- Lazy Loading.

---

# Escalabilidad

La arquitectura debe permitir añadir:

- Nuevos biomas.
- Nuevos enemigos.
- Nuevas profesiones.
- Nuevas regiones.
- Nuevos edificios.
- Nuevos modos de juego.

Sin modificar la arquitectura principal.

---

# Integración

Este documento afecta a TODOS los sistemas del proyecto.

Es la referencia principal para cualquier implementación.

---

# Consideraciones para Claude

Todo código deberá respetar esta arquitectura.

No crear dependencias innecesarias.

Utilizar composición antes que herencia cuando sea posible.

Toda funcionalidad deberá dividirse en módulos pequeños y reutilizables.

---

# Consideraciones para Gemini

Todo contenido generado deberá adaptarse a la arquitectura Data-Driven.

Nunca asumir valores fijos.

Toda nueva información deberá almacenarse como Resources configurables.

---

# Estado

Arquitectura aprobada.

Pendiente de implementación.

---

# Objetivo Final

Construir una arquitectura profesional, escalable y mantenible que permita desarrollar Survivors Lords durante años sin necesidad de rehacer los sistemas principales.
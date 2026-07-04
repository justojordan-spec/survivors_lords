# Game System

**Estado:** Draft

---

# Objetivo

El Game System es el sistema raíz de Survivors Lords.

Su responsabilidad es coordinar el ciclo de vida completo del juego, inicializando, ejecutando y finalizando todos los Systems que participan en la simulación.

No implementa mecánicas de juego, únicamente coordina su ejecución.

---

# Filosofía

El Game System representa el punto de entrada de la aplicación.

Debe permanecer extremadamente liviano y delegar todas las responsabilidades específicas a los Systems correspondientes.

Su función principal es orquestar la ejecución del juego respetando la arquitectura ECS y Data Driven.

---

# Responsabilidades

El Game System será responsable de:

- Inicializar el motor.
- Cargar la configuración general.
- Inicializar el Resource System.
- Inicializar el Event System.
- Inicializar el Save System.
- Crear la sesión de juego.
- Inicializar todos los Systems.
- Controlar el ciclo principal del juego.
- Administrar el cambio de estados.
- Coordinar el cierre de la aplicación.

---

# No es responsable de

El Game System NO debe:

- Ejecutar IA.
- Resolver combate.
- Administrar inventarios.
- Procesar físicas.
- Gestionar NPCs.
- Ejecutar habilidades.
- Administrar economía.
- Gestionar recursos.
- Controlar audio.
- Dibujar la interfaz.

Cada una de estas tareas pertenece a su propio System.

---

# Ciclo de Vida

El Game System administrará los siguientes estados:

## Boot

Inicialización mínima del juego.

---

## Loading

Carga de Resources.

---

## Initializing

Inicialización de todos los Systems.

---

## Main Menu

Juego en menú principal.

---

## Starting Game

Creación de una nueva partida.

---

## Loading Save

Carga de una partida existente.

---

## Playing

Simulación activa.

---

## Paused

Simulación detenida.

---

## Saving

Proceso de guardado.

---

## Ending Game

Finalización de la sesión.

---

## Shutdown

Liberación de recursos y cierre.

---

# Orden de Inicialización

El orden recomendado será:

1. Resource System
2. Event System
3. Save System
4. World System
5. Entity System
6. Component System
7. Player System
8. Input System
9. Time System
10. Camera System
11. Audio System
12. UI System
13. Gameplay Systems

---

# Orden de Actualización

Durante cada frame:

1. Input
2. Time
3. Gameplay
4. Physics
5. Audio
6. UI

El Game System únicamente coordina este flujo.

---

# Comunicación

Toda comunicación entre Systems deberá realizarse mediante:

- Event Bus
- Interfaces
- Requests
- Commands

El Game System nunca accederá directamente al estado interno de otro System.

---

# Dependencias

El Game System podrá depender de:

- Resource System
- Event System
- Save System
- Configuration

No deberá depender de ningún System de gameplay.

---

# Integración

El Game System coordina todos los Systems del proyecto, incluyendo:

- Resource System
- Save System
- Event System
- World System
- Entity System
- Component System
- Player System
- Input System
- Time System
- Camera System
- Audio System
- UI System
- Combat System
- Inventory System
- Item System
- Building System
- Ability System
- Effect System
- Loot System
- Crafting System
- Profession System
- Kingdom System
- Settlement System
- Economy System
- Diplomacy System
- Technology System
- Research System
- Multiplayer System

---

# Multiplayer

El Game System será responsable de:

- Crear la sesión.
- Iniciar Host o Cliente.
- Coordinar la carga inicial.
- Sincronizar el inicio de la simulación.
- Finalizar correctamente la sesión.

La lógica de red pertenece exclusivamente al Multiplayer System.

---

# Rendimiento

El Game System deberá:

- Tener una única instancia.
- Mantener bajo acoplamiento.
- Delegar todas las tareas.
- Evitar lógica pesada.
- Coordinar únicamente el flujo general.

---

# Eventos

Ejemplos:

- GameStarted
- GamePaused
- GameResumed
- GameSaved
- GameLoaded
- GameEnded
- GameClosed

---

# Convenciones

El Game System deberá:

- Ser el único orquestador global.
- No contener lógica de gameplay.
- No almacenar datos de entidades.
- No duplicar información.
- Mantener la arquitectura desacoplada.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Game System extremadamente liviano.
- Delegar responsabilidades.
- Utilizar eventos para la comunicación.
- Evitar dependencias circulares.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar lógica de gameplay dentro del Game System.
- Verificar el orden de inicialización.
- Detectar dependencias innecesarias.
- Validar el desacoplamiento entre Systems.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema central que coordine el ciclo de vida completo del juego, la inicialización de todos los Systems y la ejecución ordenada de la simulación, manteniendo una arquitectura ECS y Data Driven completamente desacoplada.
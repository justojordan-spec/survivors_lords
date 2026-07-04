# Game Manager

**Estado:** Draft

---

# Objetivo

El Game Manager es el responsable de controlar el ciclo de vida global del juego.

Su función es coordinar los estados principales de la aplicación, gestionar las transiciones entre ellos y actuar como punto central de control para el flujo general del juego.

No implementa lógica de gameplay ni administra entidades individuales.

---

# Filosofía

El Game Manager representa el estado global del juego.

Mientras los Components controlan el comportamiento de las Entities y los demás Managers administran servicios específicos, el Game Manager coordina el funcionamiento general de la aplicación.

Debe permanecer lo más pequeño posible, delegando responsabilidades a otros Managers cuando corresponda.

---

# Arquitectura

El Game Manager es un AutoLoad disponible durante toda la ejecución del juego.

Su responsabilidad consiste en administrar la máquina de estados principal del juego y coordinar las transiciones entre dichos estados.

No debe conocer detalles internos de otros Managers más allá de sus APIs públicas.

---

# Responsabilidades

El Game Manager es responsable de:

- Inicializar el juego.
- Coordinar el proceso de arranque.
- Controlar el estado global de la aplicación.
- Gestionar las transiciones entre estados.
- Iniciar y finalizar partidas.
- Coordinar la pausa y reanudación del juego.
- Gestionar el cierre ordenado de la aplicación.

No es responsable de:

- Guardar partidas.
- Reproducir audio.
- Gestionar escenas.
- Administrar jugadores.
- Sincronizar red.
- Controlar la interfaz de usuario.

Estas responsabilidades pertenecen a sus respectivos Managers.

---

# API Pública

La API pública deberá permitir operaciones relacionadas exclusivamente con el estado global del juego.

Entre ellas:

- Iniciar el juego.
- Comenzar una nueva partida.
- Cargar una partida existente.
- Pausar la partida.
- Reanudar la partida.
- Finalizar la partida.
- Reiniciar la partida.
- Consultar el estado actual del juego.

La implementación concreta de estas operaciones se documentará durante el desarrollo.

---

# Flujo de funcionamiento

El ciclo de vida general será:

1. Inicio de la aplicación.
2. Inicialización de Managers.
3. Menú principal.
4. Inicio de partida.
5. Gameplay.
6. Pausa.
7. Reanudación.
8. Fin de partida.
9. Regreso al menú o cierre.

Cada transición deberá ser controlada exclusivamente por el Game Manager.

---

# Dependencias

El Game Manager podrá interactuar con:

- Scene Manager.
- Save Manager.
- Network Manager.
- UI Manager.
- Audio Manager.
- EventBus.

Siempre mediante sus APIs públicas.

No deberá depender de Components ni de Entities específicas.

---

# Integración con el resto del proyecto

Todos los sistemas que necesiten conocer el estado global del juego deberán consultar al Game Manager.

Las acciones relacionadas con el flujo principal deberán coordinarse desde este Manager.

Los demás Managers continuarán siendo responsables de ejecutar sus propias tareas.

---

# Consideraciones para Claude

Al generar código:

- Mantener al Game Manager como coordinador.
- Delegar responsabilidades específicas en otros Managers.
- Evitar lógica de gameplay.
- Evitar dependencias innecesarias.
- Mantener una máquina de estados clara.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar responsabilidades que pertenezcan a otros Managers.
- Verificar que el flujo del juego permanezca centralizado.
- Validar una correcta separación entre coordinación y ejecución.
- Identificar posibles acoplamientos excesivos.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un único punto de coordinación para el ciclo de vida del juego, capaz de administrar los estados principales de la aplicación sin asumir responsabilidades ajenas, actuando como el orquestador del funcionamiento general del proyecto.
# EventBus API

**Estado:** Draft

---

# Objetivo

Este documento define el contrato de comunicación para el EventBus del proyecto.

El EventBus proporciona un mecanismo de comunicación desacoplado entre sistemas mediante eventos globales, permitiendo que distintos módulos interactúen sin depender directamente unos de otros.

Su objetivo es reducir el acoplamiento entre Managers, Components y demás sistemas, facilitando una arquitectura modular y escalable.

---

# Filosofía

El EventBus implementa un modelo de publicación y suscripción (Publish/Subscribe).

Los sistemas emisores no conocen quién recibirá un evento, y los receptores no necesitan conocer quién lo generó.

Cada evento representa un hecho ocurrido dentro del juego y no una orden para ejecutar una acción.

---

# Arquitectura

Todos los eventos deberán ser emitidos a través del EventBus.

Los sistemas podrán:

- Publicar eventos.
- Suscribirse a eventos.
- Cancelar una suscripción cuando deje de ser necesaria.

El EventBus no debe contener lógica de gameplay.

Su única responsabilidad es distribuir eventos entre los sistemas registrados.

---

# Responsabilidades

La API del EventBus debe permitir:

- Registrar escuchas de eventos.
- Eliminar escuchas.
- Emitir eventos.
- Transportar la información necesaria para los receptores.

El EventBus no debe modificar la información transportada ni decidir cómo debe responder cada sistema.

---

# Convenciones

Los eventos deberán:

- Tener nombres claros y descriptivos.
- Representar hechos ya ocurridos.
- Mantener una estructura consistente.
- Evitar información innecesaria en sus datos.

Ejemplos:

- `player_died`
- `enemy_spawned`
- `item_collected`
- `game_paused`

No deben utilizarse nombres que representen órdenes, por ejemplo:

- `kill_enemy`
- `spawn_item`
- `pause_game`

---

# Integración con el resto del proyecto

El EventBus podrá ser utilizado por:

- Managers
- Components
- Systems
- AI
- Multiplayer
- Save System
- UI

Siempre que sea posible, se priorizará el uso del EventBus frente a dependencias directas entre sistemas.

---

# Consideraciones para Claude

Al generar código:

- Utilizar el EventBus para eventos globales.
- No utilizar el EventBus para llamadas síncronas.
- Evitar lógica de negocio dentro del EventBus.
- Mantener nombres de eventos consistentes con la documentación.

---

# Consideraciones para Gemini

Al revisar código o documentación:

- Verificar que los eventos representen hechos y no comandos.
- Detectar dependencias directas que puedan reemplazarse por eventos.
- Identificar eventos redundantes o ambiguos.
- Validar la consistencia de los nombres y la información transportada.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un mecanismo de comunicación global desacoplado, consistente y escalable que permita la interacción entre sistemas sin generar dependencias innecesarias, favoreciendo el mantenimiento y la evolución del proyecto.
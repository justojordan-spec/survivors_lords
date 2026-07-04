# UI Manager

**Estado:** Draft

---

# Objetivo

El UI Manager es responsable de coordinar toda la interfaz de usuario del proyecto.

Su función es administrar la creación, actualización, visualización y cierre de los distintos elementos de la interfaz, proporcionando una experiencia consistente para el jugador.

No implementa lógica de gameplay ni almacena información propia del juego.

---

# Filosofía

La interfaz de usuario es una representación visual del estado del juego.

El UI Manager coordina la presentación de la información, mientras que los datos continúan siendo responsabilidad de los sistemas que los generan.

La UI nunca debe convertirse en la fuente de verdad del proyecto.

---

# Arquitectura

El UI Manager es un AutoLoad disponible durante toda la ejecución de la aplicación.

Su responsabilidad consiste en administrar las capas de interfaz, coordinar pantallas, ventanas, HUDs, notificaciones y demás elementos visuales.

La lógica de negocio permanece completamente separada de la interfaz.

---

# Responsabilidades

El UI Manager es responsable de:

- Mostrar y ocultar pantallas.
- Gestionar el HUD.
- Administrar ventanas modales.
- Coordinar menús.
- Gestionar notificaciones.
- Controlar capas de interfaz.
- Coordinar transiciones visuales de la UI.

No es responsable de:

- Calcular datos de gameplay.
- Administrar inventarios.
- Gestionar jugadores.
- Controlar IA.
- Administrar estados del juego.

---

# API Pública

La API pública deberá permitir operaciones como:

- Mostrar una pantalla.
- Ocultar una pantalla.
- Abrir una ventana.
- Cerrar una ventana.
- Mostrar una notificación.
- Actualizar elementos de la interfaz.
- Consultar el estado de una pantalla.

La implementación concreta será documentada durante el desarrollo.

---

# Flujo de funcionamiento

El flujo general será:

1. Un sistema solicita una operación de interfaz.
2. El UI Manager valida la solicitud.
3. Localiza la pantalla correspondiente.
4. Ejecuta la operación solicitada.
5. Actualiza el estado visual.
6. Notifica cuando la operación finaliza si corresponde.

El UI Manager nunca genera datos de gameplay.

---

# Dependencias

El UI Manager podrá interactuar con:

- Game Manager.
- Scene Manager.
- Input Manager.
- Audio Manager.
- EventBus.

No deberá depender de Components específicos ni de Entities.

---

# Integración con el resto del proyecto

Todos los sistemas que necesiten modificar la interfaz deberán hacerlo mediante el UI Manager o mediante las APIs públicas de los elementos de UI gestionados por este.

La interfaz deberá reaccionar al estado del juego, nunca definirlo.

---

# Consideraciones para Claude

Al generar código:

- Mantener completamente separadas la lógica de negocio y la interfaz.
- Utilizar el UI Manager para coordinar pantallas globales.
- Evitar almacenar datos de gameplay dentro de la UI.
- Diseñar pantallas reutilizables y desacopladas.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica de gameplay dentro de la interfaz.
- Verificar que la UI actúe únicamente como representación del estado.
- Validar una correcta separación entre datos y presentación.
- Identificar dependencias innecesarias entre UI y Components.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado para la gestión de toda la interfaz del proyecto, garantizando una presentación consistente, desacoplada y escalable, donde la UI represente el estado del juego sin convertirse en la fuente de verdad de la aplicación.
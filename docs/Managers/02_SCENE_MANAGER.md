# Scene Manager

**Estado:** Draft

---

# Objetivo

El Scene Manager es responsable de administrar el ciclo de vida de todas las escenas del proyecto.

Su función es cargar, descargar, reemplazar y gestionar las transiciones entre escenas, proporcionando una interfaz uniforme para el resto de los sistemas.

No controla el flujo del juego ni implementa lógica de gameplay.

---

# Filosofía

Las escenas representan la estructura visual y funcional del proyecto.

El Scene Manager desacopla la navegación de la implementación física de las escenas, evitando que otros sistemas conozcan rutas, recursos o detalles de carga.

Todos los cambios de escena deberán realizarse exclusivamente mediante este Manager.

---

# Arquitectura

El Scene Manager es un AutoLoad disponible durante toda la ejecución del juego.

Administra la escena activa y coordina las transiciones necesarias para mantener el flujo de la aplicación.

La organización interna de las escenas deberá permanecer transparente para los sistemas consumidores.

---

# Responsabilidades

El Scene Manager es responsable de:

- Cargar escenas.
- Descargar escenas.
- Reemplazar la escena activa.
- Gestionar transiciones entre escenas.
- Mantener referencia a la escena principal.
- Coordinar cargas asíncronas cuando corresponda.

No es responsable de:

- Decidir cuándo cambiar de escena.
- Administrar el estado del juego.
- Gestionar la interfaz de usuario.
- Administrar recursos de gameplay.

Estas decisiones pertenecen al Game Manager u otros Managers especializados.

---

# API Pública

La API pública deberá permitir operaciones como:

- Cargar una escena.
- Descargar una escena.
- Cambiar la escena actual.
- Recargar una escena.
- Obtener la escena activa.
- Consultar el estado de una transición.

La implementación concreta será documentada durante el desarrollo.

---

# Flujo de funcionamiento

El flujo general será:

1. Solicitud de cambio de escena.
2. Validación de la operación.
3. Inicio de la transición.
4. Carga de la nueva escena.
5. Liberación de recursos de la escena anterior.
6. Activación de la nueva escena.
7. Notificación de finalización.

Todo el proceso será gestionado por el Scene Manager.

---

# Dependencias

El Scene Manager podrá interactuar con:

- Game Manager.
- Resource Manager.
- UI Manager.
- EventBus.

Siempre mediante sus APIs públicas.

No deberá depender de Components ni de Entities específicas.

---

# Integración con el resto del proyecto

Todos los sistemas que necesiten cambiar de escena deberán hacerlo mediante el Scene Manager.

Ningún sistema deberá cargar escenas directamente utilizando rutas o mecanismos propios de Godot.

Esto garantiza una navegación consistente y facilita futuras modificaciones en la arquitectura.

---

# Consideraciones para Claude

Al generar código:

- Centralizar todas las operaciones relacionadas con escenas.
- Evitar cargas directas desde otros sistemas.
- Mantener desacopladas las rutas físicas de las escenas.
- Soportar futuras cargas asíncronas y pantallas de transición.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar cargas directas de escenas fuera del Scene Manager.
- Verificar que las transiciones permanezcan centralizadas.
- Validar la independencia respecto a la estructura física del proyecto.
- Identificar posibles dependencias innecesarias.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Proporcionar un único punto de acceso para la gestión de escenas del proyecto, permitiendo una navegación consistente, desacoplada y preparada para futuras optimizaciones como carga asíncrona, streaming de escenas y transiciones avanzadas.
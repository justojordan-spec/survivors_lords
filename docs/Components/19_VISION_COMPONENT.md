# Vision Component

**Estado:** Draft

---

# Objetivo

El Vision Component es responsable de detectar y mantener información sobre las Entities visibles para una Entity.

Su función es proporcionar un sistema uniforme de percepción que permita a otros Components y Systems consultar qué objetos se encuentran dentro del rango de detección.

No selecciona objetivos ni toma decisiones de comportamiento.

---

# Filosofía

Ver no significa atacar.

El Vision Component únicamente proporciona información sobre el entorno.

La interpretación de esa información pertenece a otros sistemas como IA, combate, interacción o targeting.

---

# Arquitectura

El Vision Component mantiene una colección dinámica de Entities detectadas.

La detección podrá realizarse mediante diferentes mecanismos (áreas, raycasts, sensores, etc.), sin que el Component dependa de una implementación concreta.

El resultado será una representación consistente de las Entities actualmente visibles.

---

# Responsabilidades

El Vision Component es responsable de:

- Detectar Entities dentro del rango de visión.
- Mantener la lista de Entities visibles.
- Actualizar la información cuando el entorno cambie.
- Consultar si una Entity es visible.
- Notificar cambios de visibilidad.

No es responsable de:

- Elegir objetivos.
- Ejecutar ataques.
- Controlar IA.
- Gestionar navegación.
- Aplicar daño.

---

# API Pública

La API pública deberá permitir operaciones como:

- Obtener Entities visibles.
- Consultar si una Entity es visible.
- Obtener la Entity más cercana.
- Limpiar la lista de detección.
- Consultar el rango de visión.

La implementación concreta será documentada durante el desarrollo.

---

# Estado Interno

El Component administrará:

- Lista de Entities visibles.
- Rango de visión.
- Estado de detección.
- Parámetros de percepción.

Toda esta información permanecerá encapsulada.

---

# Signals

El Component podrá emitir eventos como:

- Entity detectada.
- Entity perdida.
- Lista de visión actualizada.

Los nombres concretos de las Signals se definirán durante la implementación.

---

# Dependencias

El Vision Component podrá interactuar con:

- Physics System.
- EventBus.
- AI Systems.
- Target Component.

No deberá depender del Combat Component ni del Damage Component.

---

# Integración con el resto del proyecto

El Vision Component podrá ser utilizado por:

- IA.
- Jugadores.
- NPCs.
- Torres.
- Trampas.
- Sistemas de interacción.

Otros sistemas consumirán la información mediante la API pública del Component.

---

# Rendimiento

El Component deberá:

- Minimizar consultas al motor de física.
- Actualizar la lista únicamente cuando sea necesario.
- Evitar asignaciones de memoria repetidas.
- Escalar correctamente para cientos de Entities simultáneas.

---

# Multiplayer

La percepción es un estado local derivado del mundo del juego.

El Component no deberá sincronizar listas de Entities visibles, salvo que una mecánica específica del juego lo requiera.

---

# Consideraciones para Claude

Al generar código:

- Mantener el sistema independiente de la IA y el combate.
- Diseñar una API genérica para distintos mecanismos de detección.
- Evitar lógica de selección de objetivos.
- Optimizar las consultas de percepción.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica de combate dentro del Vision Component.
- Verificar el desacoplamiento con la IA.
- Validar la gestión eficiente de la lista de Entities visibles.
- Identificar dependencias innecesarias.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema reutilizable para detectar y consultar Entities visibles, proporcionando información consistente y eficiente a otros Components y Systems sin asumir decisiones de gameplay.
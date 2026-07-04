# Interaction Component

**Estado:** Draft

---

# Objetivo

El Interaction Component es responsable de gestionar las interacciones entre una Entity y otros elementos del mundo.

Su función es detectar, validar y coordinar solicitudes de interacción, proporcionando una interfaz uniforme para cualquier sistema que permita interactuar con objetos, personajes o estructuras.

No implementa el comportamiento específico de cada interacción.

---

# Filosofía

Interactuar significa solicitar una acción sobre otro objeto del mundo.

El Interaction Component únicamente administra el proceso de interacción.

El resultado de la interacción pertenece al objeto o sistema que la recibe.

---

# Arquitectura

El Interaction Component actúa como intermediario entre la Entity y los elementos interactuables.

Podrá trabajar junto con sistemas de detección, colisiones o selección, pero no dependerá de una implementación concreta.

Cada objeto interactuable expondrá una API compatible con el sistema de interacción.

---

# Responsabilidades

El Interaction Component es responsable de:

- Detectar objetos interactuables.
- Validar si una interacción es posible.
- Iniciar una interacción.
- Cancelar una interacción.
- Gestionar el estado de interacción.
- Notificar eventos relacionados.

No es responsable de:

- Abrir puertas.
- Iniciar diálogos.
- Comprar objetos.
- Activar mecanismos.
- Ejecutar lógica específica de un objeto.

---

# API Pública

La API pública deberá permitir operaciones como:

- Iniciar interacción.
- Cancelar interacción.
- Consultar objeto interactuable actual.
- Verificar si existe una interacción disponible.
- Consultar el estado de interacción.

La implementación concreta será documentada durante el desarrollo.

---

# Estado Interno

El Component administrará:

- Objeto interactuable actual.
- Estado de interacción.
- Distancia válida.
- Restricciones temporales.

Toda esta información permanecerá encapsulada.

---

# Signals

El Component podrá emitir eventos como:

- Interacción iniciada.
- Interacción cancelada.
- Interacción finalizada.
- Objeto interactuable detectado.
- Objeto interactuable perdido.

Los nombres concretos de las Signals se definirán durante la implementación.

---

# Dependencias

El Interaction Component podrá interactuar con:

- EventBus.
- Resource Manager.
- UI Manager.
- Input Manager.
- Systems especializados.

No deberá depender directamente de NPCs, puertas, cofres o cualquier otro tipo específico de objeto.

---

# Integración con el resto del proyecto

El Interaction Component podrá utilizarse en cualquier Entity que necesite interactuar con el mundo.

Los objetos interactuables implementarán la lógica correspondiente mediante Components, Resources o Systems especializados.

Esto permite que el sistema permanezca completamente desacoplado del contenido del juego.

---

# Rendimiento

El Component deberá:

- Minimizar comprobaciones de proximidad.
- Evitar búsquedas innecesarias.
- Mantener un número reducido de referencias activas.
- Escalar correctamente en escenas con múltiples objetos interactuables.

---

# Multiplayer

Las solicitudes de interacción deberán respetar el modelo de autoridad Host-Client.

La validación definitiva de una interacción corresponderá al Host o al servidor dedicado cuando corresponda.

---

# Consideraciones para Claude

Al generar código:

- Mantener la interacción desacoplada del comportamiento específico.
- Diseñar el sistema para soportar cualquier tipo de objeto interactuable.
- Evitar dependencias con clases concretas.
- Utilizar interfaces o APIs públicas para ejecutar la interacción.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica específica dentro del Interaction Component.
- Verificar el desacoplamiento entre interacción y comportamiento.
- Validar el uso de APIs públicas para interactuar con otros sistemas.
- Identificar dependencias innecesarias con tipos concretos de Entities.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema reutilizable para gestionar las interacciones entre Entities y el mundo del juego, permitiendo detectar, validar y coordinar acciones de forma uniforme, desacoplada y extensible para cualquier tipo de objeto interactuable.
# Ability Component

**Estado:** Draft

---

# Objetivo

El Ability Component es responsable de administrar todas las habilidades disponibles para una Entity.

Su función es registrar, activar, desactivar y controlar la ejecución de habilidades, gestionando aspectos como tiempos de reutilización, costos, restricciones y estados de activación.

No implementa la lógica específica de cada habilidad.

---

# Filosofía

Las habilidades son datos.

Su comportamiento se define mediante Resources y sistemas especializados.

El Ability Component únicamente coordina su ejecución y controla su estado durante el gameplay.

Esto permite construir un sistema completamente Data Driven y fácilmente extensible.

---

# Arquitectura

El Ability Component administra una colección de Ability Resources.

Cada habilidad define:

- Configuración.
- Costos.
- Cooldowns.
- Requisitos.
- Parámetros.
- Comportamiento asociado.

El Component coordina su utilización sin conocer los detalles internos de cada habilidad.

---

# Responsabilidades

El Ability Component es responsable de:

- Registrar habilidades.
- Activar habilidades.
- Cancelar habilidades.
- Gestionar cooldowns.
- Validar requisitos.
- Controlar estados.
- Notificar cambios.

No es responsable de:

- Aplicar daño.
- Gestionar estadísticas.
- Ejecutar animaciones.
- Reproducir sonidos.
- Implementar la lógica específica de una habilidad.

---

# API Pública

La API pública deberá permitir operaciones como:

- Registrar una habilidad.
- Eliminar una habilidad.
- Activar una habilidad.
- Cancelar una habilidad.
- Consultar habilidades disponibles.
- Consultar cooldowns.
- Consultar estados.

La implementación concreta será documentada durante el desarrollo.

---

# Estado Interno

El Component administrará:

- Lista de habilidades.
- Cooldowns activos.
- Estados de activación.
- Restricciones temporales.

Toda esta información permanecerá encapsulada.

---

# Signals

El Component podrá emitir eventos como:

- Habilidad activada.
- Habilidad cancelada.
- Cooldown iniciado.
- Cooldown finalizado.
- Estado modificado.

Los nombres concretos de las Signals se definirán durante la implementación.

---

# Dependencias

El Ability Component podrá interactuar con:

- Stats Component.
- Combat Component.
- Resource Manager.
- EventBus.
- Animation System.
- Audio Manager.

No deberá depender directamente del Inventory Component.

---

# Integración con el resto del proyecto

El Ability Component podrá ser utilizado por:

- Jugadores.
- Enemigos.
- NPCs.
- Invocaciones.
- Objetos especiales.

La lógica concreta de cada habilidad permanecerá definida mediante Resources y sistemas especializados.

---

# Rendimiento

El Component deberá:

- Actualizar únicamente habilidades activas.
- Minimizar cálculos por frame.
- Compartir Resources entre múltiples Entities.
- Escalar correctamente para cientos de habilidades simultáneas.

---

# Multiplayer

La activación y el estado de las habilidades deberán sincronizarse correctamente dentro del modelo Host-Client.

La lógica de replicación será responsabilidad del sistema de Networking.

---

# Consideraciones para Claude

Al generar código:

- Diseñar un sistema completamente Data Driven.
- Mantener separada la lógica de las habilidades.
- Utilizar Resources para definir habilidades.
- Evitar lógica específica dentro del Ability Component.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica de habilidades dentro del Ability Component.
- Verificar el uso de Ability Resources.
- Validar el sistema de cooldowns.
- Identificar responsabilidades mezcladas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema reutilizable para administrar habilidades de cualquier Entity, permitiendo registrar, activar y controlar su ejecución mediante una arquitectura completamente Data Driven, desacoplada y fácilmente extensible.
# Loot Component

**Estado:** Draft

---

# Objetivo

El Loot Component es responsable de administrar las recompensas que una Entity puede generar al morir, ser destruida o completar un evento determinado.

Su función es coordinar la generación del loot utilizando tablas de drop definidas mediante Resources, manteniendo completamente separadas las reglas de generación de los datos del juego.

No crea objetos manualmente ni implementa probabilidades directamente.

---

# Filosofía

El loot representa una consecuencia del gameplay.

El Loot Component únicamente coordina el proceso de generación.

Las probabilidades, cantidades y reglas pertenecen a Resources especializados.

---

# Arquitectura

Cada Entity podrá poseer un Loot Component asociado a una o más Loot Tables.

Cuando ocurra un evento válido (muerte, destrucción, recompensa, etc.), el Component solicitará la generación del loot correspondiente.

La lógica de generación permanecerá desacoplada mediante Resources y Systems especializados.

---

# Responsabilidades

El Loot Component es responsable de:

- Asociar Loot Tables a una Entity.
- Solicitar la generación del loot.
- Coordinar la entrega de recompensas.
- Notificar eventos relacionados con el loot.

No es responsable de:

- Calcular probabilidades.
- Crear Items manualmente.
- Administrar inventarios.
- Gestionar economía.
- Decidir cuándo una Entity muere.

---

# API Pública

La API pública deberá permitir operaciones como:

- Obtener Loot Tables.
- Agregar Loot Tables.
- Eliminar Loot Tables.
- Generar loot.
- Consultar si la Entity posee recompensas.

La implementación concreta será documentada durante el desarrollo.

---

# Estado Interno

El Component administrará:

- Loot Tables asociadas.
- Estado de generación.
- Restricciones de generación.

Toda esta información permanecerá encapsulada.

---

# Signals

El Component podrá emitir eventos como:

- Loot generado.
- Loot entregado.
- Loot cancelado.

Los nombres concretos de las Signals se definirán durante la implementación.

---

# Dependencias

El Loot Component podrá interactuar con:

- Resource Manager.
- Inventory Component.
- EventBus.
- Loot System.

No deberá depender directamente del Combat Component ni del Health Component.

---

# Integración con el resto del proyecto

El Loot Component podrá utilizarse en:

- Enemigos.
- Jefes.
- Cofres.
- Objetos destruibles.
- Eventos.
- Misiones.

Las recompensas generadas podrán ser utilizadas posteriormente por el Inventory Component u otros sistemas.

---

# Rendimiento

El Component deberá:

- Compartir Loot Tables entre múltiples Entities.
- Evitar duplicación de datos.
- Generar loot únicamente cuando sea necesario.
- Mantener un consumo mínimo de memoria.

---

# Multiplayer

La generación de loot deberá ser autorizada por el Host o servidor dedicado para evitar inconsistencias y duplicaciones.

El resultado será sincronizado mediante el sistema de Networking.

---

# Consideraciones para Claude

Al generar código:

- Mantener el sistema completamente Data Driven.
- Utilizar Loot Tables como única fuente de reglas.
- Evitar lógica de probabilidades dentro del Component.
- Mantener el Loot Component independiente del inventario.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar probabilidades codificadas dentro del Component.
- Verificar el uso de Loot Tables.
- Validar la separación entre generación y almacenamiento del loot.
- Identificar responsabilidades mezcladas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema reutilizable para coordinar la generación de recompensas de cualquier Entity, utilizando una arquitectura completamente Data Driven basada en Loot Tables, manteniendo desacopladas las reglas de generación, el inventario y la economía del juego.
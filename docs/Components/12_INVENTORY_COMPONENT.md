# Inventory Component

**Estado:** Draft

---

# Objetivo

El Inventory Component es responsable de administrar la colección de objetos pertenecientes a una Entity.

Su función es almacenar, organizar y gestionar los ítems disponibles, proporcionando una interfaz uniforme para agregarlos, eliminarlos, consultarlos y transferirlos.

No interpreta el comportamiento de los objetos almacenados.

---

# Filosofía

El inventario representa únicamente la posesión de objetos.

El significado y uso de cada objeto pertenece a otros sistemas especializados.

El Inventory Component nunca debe conocer cómo funciona un arma, una armadura, una poción o un material.

---

# Arquitectura

El Inventory Component administra una colección de Item Resources.

Cada entrada podrá contener:

- Referencia al Item.
- Cantidad.
- Estado cuando corresponda.
- Información adicional necesaria para identificar la instancia.

El almacenamiento interno permanece encapsulado.

---

# Responsabilidades

El Inventory Component es responsable de:

- Agregar objetos.
- Eliminar objetos.
- Transferir objetos.
- Consultar contenido.
- Controlar cantidades.
- Validar capacidad.
- Notificar cambios.

No es responsable de:

- Equipar objetos.
- Consumir objetos.
- Ejecutar habilidades.
- Aplicar efectos.
- Gestionar el equipamiento.
- Calcular estadísticas.

---

# API Pública

La API pública deberá permitir operaciones como:

- Agregar un Item.
- Eliminar un Item.
- Buscar un Item.
- Consultar cantidad.
- Transferir Items.
- Vaciar el inventario.
- Consultar capacidad disponible.

La implementación concreta será documentada durante el desarrollo.

---

# Estado Interno

El Component administrará:

- Lista de Items.
- Cantidades.
- Capacidad máxima.
- Espacios ocupados.
- Restricciones de almacenamiento.

Toda esta información permanecerá encapsulada.

---

# Signals

El Component podrá emitir eventos como:

- Item agregado.
- Item eliminado.
- Inventario modificado.
- Capacidad modificada.

Los nombres concretos de las Signals se definirán durante la implementación.

---

# Dependencias

El Inventory Component podrá interactuar con:

- Resource Manager.
- Equipment Component.
- EventBus.
- Systems especializados (Crafting, Loot, Trading).

No deberá depender del Combat Component ni del Health Component.

---

# Integración con el resto del proyecto

El Inventory Component será utilizado por cualquier Entity capaz de poseer objetos.

Otros sistemas utilizarán su API para consultar o modificar el contenido, pero la interpretación del comportamiento de los Items permanecerá fuera del inventario.

---

# Rendimiento

El Component deberá:

- Optimizar búsquedas frecuentes.
- Minimizar asignaciones de memoria.
- Gestionar eficientemente grandes cantidades de objetos.
- Escalar correctamente para inventarios extensos.

---

# Multiplayer

Las modificaciones del inventario deberán sincronizarse mediante la arquitectura Host-Client.

El Inventory Component no implementará lógica de replicación; esta será responsabilidad del sistema de Networking.

---

# Consideraciones para Claude

Al generar código:

- Mantener el inventario independiente del comportamiento de los objetos.
- Utilizar Resources para representar los Items.
- Evitar lógica de gameplay dentro del Inventory Component.
- Diseñar una API sencilla y consistente.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica de uso de objetos dentro del Inventory Component.
- Verificar que el equipamiento se gestione mediante el Equipment Component.
- Validar una correcta encapsulación del inventario.
- Identificar responsabilidades que pertenezcan a otros sistemas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema reutilizable para administrar la colección de objetos de cualquier Entity, proporcionando una gestión eficiente y desacoplada del inventario, donde los Items sean datos y su comportamiento sea responsabilidad de sistemas especializados.
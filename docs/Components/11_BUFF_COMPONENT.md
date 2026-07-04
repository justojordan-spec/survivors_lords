# Buff Component

**Estado:** Draft

---

# Objetivo

El Buff Component es responsable de administrar todos los modificadores temporales y permanentes que afectan a una Entity.

Su función es agregar, actualizar, eliminar y controlar Buffs, Debuffs y otros efectos de estado, coordinando la aplicación de sus modificadores sobre los distintos sistemas del juego.

No implementa directamente los efectos del gameplay.

---

# Filosofía

Un Buff representa una modificación temporal o permanente del estado de una Entity.

El Buff Component administra el ciclo de vida de dichos efectos.

Los cambios producidos por un Buff deberán aplicarse mediante los Components especializados, principalmente el Stats Component.

---

# Arquitectura

El Buff Component mantiene una colección de efectos activos.

Cada Buff posee su propia configuración mediante Resources.

El Component coordina:

- Inicio del Buff.
- Actualización.
- Expiración.
- Eliminación.
- Acumulación (Stacking).
- Renovación.

Los efectos concretos permanecen desacoplados del propio Component.

---

# Responsabilidades

El Buff Component es responsable de:

- Agregar Buffs.
- Eliminar Buffs.
- Actualizar duración.
- Gestionar acumulaciones.
- Aplicar modificadores.
- Eliminar modificadores.
- Notificar cambios.

No es responsable de:

- Calcular estadísticas.
- Aplicar daño.
- Administrar la salud.
- Ejecutar habilidades.
- Gestionar animaciones.

---

# API Pública

La API pública deberá permitir operaciones como:

- Agregar un Buff.
- Eliminar un Buff.
- Consultar Buffs activos.
- Renovar duración.
- Consultar acumulaciones.
- Limpiar todos los Buffs.

La implementación concreta será documentada durante el desarrollo.

---

# Estado Interno

El Component administrará:

- Lista de Buffs activos.
- Tiempo restante.
- Acumulaciones.
- Estado de cada Buff.

Toda esta información permanecerá encapsulada.

---

# Signals

El Component podrá emitir eventos como:

- Buff agregado.
- Buff eliminado.
- Buff expirado.
- Buff actualizado.

Los nombres concretos de las Signals serán definidos durante la implementación.

---

# Dependencias

El Buff Component podrá interactuar con:

- Stats Component.
- Resource Manager.
- EventBus.
- Ability Component.
- Equipment Component.

No deberá modificar directamente otros Components.

---

# Integración con el resto del proyecto

Los Buffs podrán originarse mediante:

- Habilidades.
- Objetos.
- Equipamiento.
- Enemigos.
- Eventos del mapa.
- Estados especiales.

Los modificadores deberán aplicarse utilizando las APIs públicas de los Components correspondientes.

---

# Rendimiento

El Component deberá:

- Actualizar únicamente Buffs activos.
- Minimizar cálculos por frame.
- Compartir Resources entre múltiples Buffs.
- Escalar correctamente para cientos de Entities.

---

# Multiplayer

Los Buffs deberán sincronizar correctamente:

- Inicio.
- Duración.
- Eliminación.
- Acumulaciones.

La sincronización será responsabilidad del sistema de Networking.

---

# Consideraciones para Claude

Al generar código:

- Mantener separado el Buff de los efectos concretos.
- Aplicar modificadores mediante el Stats Component.
- Diseñar Buffs completamente Data Driven.
- Evitar lógica específica dentro del Component.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar Buffs que modifiquen directamente otros Components.
- Verificar el uso del Stats Component.
- Validar la gestión del ciclo de vida.
- Identificar responsabilidades mezcladas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema reutilizable para administrar Buffs y Debuffs de cualquier Entity, permitiendo controlar su ciclo de vida y aplicar modificadores de manera desacoplada mediante los Components especializados del proyecto.
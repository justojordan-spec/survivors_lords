# Level Component

**Estado:** Draft

---

# Objetivo

El Level Component es responsable de administrar el nivel actual de una Entity.

Su función es registrar el nivel, controlar los cambios de nivel y coordinar los eventos asociados a la progresión, utilizando reglas definidas mediante Resources.

No administra la experiencia acumulada ni calcula la progresión por sí mismo.

---

# Filosofía

El nivel representa una etapa de progresión de una Entity.

Las reglas para alcanzar un nivel determinado pertenecen a datos de configuración externos.

El Level Component únicamente administra el estado del nivel y comunica sus cambios.

---

# Arquitectura

El Level Component encapsula toda la información relacionada con el nivel actual.

Las tablas de progresión, límites máximos y requisitos serán definidos mediante Resources especializados.

El Component permanecerá independiente del modelo concreto de progresión utilizado por el juego.

---

# Responsabilidades

El Level Component es responsable de:

- Mantener el nivel actual.
- Incrementar o reducir el nivel cuando corresponda.
- Consultar el nivel.
- Validar límites mínimos y máximos.
- Notificar cambios de nivel.

No es responsable de:

- Administrar experiencia.
- Calcular requisitos de experiencia.
- Modificar estadísticas.
- Desbloquear habilidades.
- Otorgar recompensas.

---

# API Pública

La API pública deberá permitir operaciones como:

- Obtener nivel actual.
- Establecer nivel.
- Incrementar nivel.
- Reducir nivel.
- Consultar nivel máximo.
- Consultar nivel mínimo.

La implementación concreta será documentada durante el desarrollo.

---

# Estado Interno

El Component administrará:

- Nivel actual.
- Nivel mínimo permitido.
- Nivel máximo permitido.

Toda esta información permanecerá encapsulada.

---

# Signals

El Component podrá emitir eventos como:

- Nivel aumentado.
- Nivel reducido.
- Nivel modificado.
- Nivel máximo alcanzado.

Los nombres concretos de las Signals se definirán durante la implementación.

---

# Dependencias

El Level Component podrá interactuar con:

- Experience Component.
- Stats Component.
- Resource Manager.
- EventBus.
- Systems de progresión.

No deberá depender directamente de habilidades, inventario o combate.

---

# Integración con el resto del proyecto

El cambio de nivel podrá desencadenar acciones como:

- Recalcular estadísticas.
- Desbloquear contenido.
- Mostrar efectos visuales.
- Notificar a la interfaz.

Estas acciones serán responsabilidad de sistemas especializados que reaccionen a los eventos emitidos por el Component.

---

# Rendimiento

El Component deberá:

- Mantener un estado interno mínimo.
- Evitar cálculos innecesarios.
- Emitir eventos únicamente cuando el nivel cambie.
- Escalar correctamente para múltiples Entities.

---

# Multiplayer

Los cambios de nivel deberán ser autorizados por el Host o servidor dedicado.

El Component no implementará lógica de sincronización; esta será responsabilidad del sistema de Networking.

---

# Consideraciones para Claude

Al generar código:

- Mantener separado el nivel de la experiencia.
- Obtener las reglas de progresión desde Resources.
- Evitar lógica de recompensas dentro del Component.
- Diseñar una API reutilizable para distintos modelos de progresión.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar cálculos de experiencia dentro del Level Component.
- Verificar el uso de Resources para la progresión.
- Validar la separación entre nivel, experiencia y recompensas.
- Identificar responsabilidades mezcladas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema reutilizable para administrar el nivel de cualquier Entity, manteniendo separadas las responsabilidades de progresión, experiencia y recompensas, y permitiendo definir completamente las reglas mediante una arquitectura Data Driven.
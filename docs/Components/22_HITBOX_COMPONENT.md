# Hitbox Component

**Estado:** Draft

---

# Objetivo

El Hitbox Component es responsable de administrar las áreas de colisión utilizadas para detectar impactos sobre una Entity.

Su función es coordinar la recepción de colisiones relacionadas con el combate, proporcionando una interfaz uniforme para que otros sistemas procesen el daño, los efectos y las interacciones físicas.

No calcula daño ni decide las consecuencias de un impacto.

---

# Filosofía

Una Hitbox representa una zona susceptible de recibir impactos.

El Hitbox Component únicamente detecta y comunica que una colisión válida ha ocurrido.

La interpretación del impacto pertenece a Components y Systems especializados.

---

# Arquitectura

El Hitbox Component administra una o más áreas de impacto asociadas a una Entity.

Cada Hitbox podrá representar distintas partes del cuerpo u objetos específicos según las necesidades del gameplay.

El Component notificará los impactos detectados mediante una API pública y eventos.

---

# Responsabilidades

El Hitbox Component es responsable de:

- Registrar Hitboxes.
- Detectar impactos válidos.
- Validar colisiones.
- Notificar impactos.
- Habilitar o deshabilitar Hitboxes cuando corresponda.

No es responsable de:

- Calcular daño.
- Aplicar efectos.
- Gestionar salud.
- Ejecutar animaciones.
- Resolver física.
- Determinar objetivos.

---

# API Pública

La API pública deberá permitir operaciones como:

- Habilitar una Hitbox.
- Deshabilitar una Hitbox.
- Consultar Hitboxes activas.
- Obtener el estado de una Hitbox.
- Registrar un impacto.

La implementación concreta será documentada durante el desarrollo.

---

# Estado Interno

El Component administrará:

- Lista de Hitboxes.
- Estado de activación.
- Configuración de colisiones.
- Parámetros de detección.

Toda esta información permanecerá encapsulada.

---

# Signals

El Component podrá emitir eventos como:

- Hit Detected.
- Hitbox Enabled.
- Hitbox Disabled.

Los nombres concretos de las Signals serán definidos durante la implementación.

---

# Dependencias

El Hitbox Component podrá interactuar con:

- Physics System.
- Damage Component.
- Combat Component.
- EventBus.

No deberá depender directamente del Health Component ni del AI System.

---

# Integración con el resto del proyecto

El Hitbox Component podrá utilizarse en:

- Jugadores.
- Enemigos.
- Jefes.
- NPCs.
- Objetos destruibles.
- Invocaciones.

Los impactos detectados serán procesados posteriormente por los sistemas correspondientes.

---

# Rendimiento

El Component deberá:

- Mantener únicamente Hitboxes necesarias.
- Activar y desactivar áreas cuando corresponda.
- Minimizar comprobaciones de colisión.
- Escalar correctamente para cientos de Entities simultáneas.

---

# Multiplayer

La validación definitiva de los impactos corresponderá al Host o servidor dedicado.

La sincronización del resultado será responsabilidad del sistema de Networking.

---

# Consideraciones para Claude

Al generar código:

- Mantener el sistema independiente del cálculo de daño.
- Utilizar las herramientas de colisión proporcionadas por Godot.
- Evitar lógica de combate dentro del Component.
- Diseñar el sistema para múltiples Hitboxes por Entity.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar cálculos de daño dentro del Hitbox Component.
- Verificar el desacoplamiento entre detección e impacto.
- Validar el uso correcto del sistema de colisiones.
- Identificar responsabilidades mezcladas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema reutilizable para detectar impactos sobre cualquier Entity mediante áreas de colisión, manteniendo completamente desacopladas la detección, el cálculo de daño y las consecuencias del impacto dentro de la arquitectura del proyecto.
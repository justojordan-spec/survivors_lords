# Death Component

**Estado:** Draft

---

# Objetivo

El Death Component es responsable de administrar el ciclo de muerte de una Entity.

Su función es coordinar las acciones que deben ejecutarse cuando una Entity deja de estar viva, notificando al resto de los sistemas y garantizando que la secuencia de muerte se realice de forma consistente.

No determina cuándo una Entity muere; esa responsabilidad pertenece al Health Component y a los sistemas que modifican su estado.

---

# Filosofía

La muerte es un cambio de estado dentro del ciclo de vida de una Entity.

El Death Component centraliza toda la lógica relacionada con este evento para evitar que múltiples sistemas implementen comportamientos duplicados.

Su objetivo es actuar como punto único de coordinación del proceso de muerte.

---

# Arquitectura

El Death Component mantiene el estado de vida de la Entity y coordina la secuencia de muerte.

Cuando recibe una notificación de que la Entity ha muerto:

- Marca el estado interno.
- Emite los eventos correspondientes.
- Coordina la ejecución de acciones posteriores.
- Evita múltiples ejecuciones de la misma secuencia.

La destrucción de la Entity será responsabilidad de otros sistemas.

---

# Responsabilidades

El Death Component es responsable de:

- Detectar la transición al estado muerto.
- Coordinar la secuencia de muerte.
- Evitar ejecuciones duplicadas.
- Notificar la muerte al resto del proyecto.
- Mantener el estado de vida de la Entity.

No es responsable de:

- Calcular daño.
- Administrar salud.
- Generar loot.
- Ejecutar animaciones.
- Eliminar la Entity de la escena.
- Gestionar respawn.

---

# API Pública

La API pública deberá permitir operaciones como:

- Consultar si la Entity está viva.
- Consultar si la Entity está muerta.
- Iniciar la secuencia de muerte.
- Reiniciar el estado (cuando corresponda).

La implementación concreta será documentada durante el desarrollo.

---

# Estado Interno

El Component administrará:

- Estado de vida.
- Estado de muerte.
- Estado de procesamiento de la secuencia.

Toda esta información permanecerá encapsulada.

---

# Signals

El Component podrá emitir eventos como:

- Death Started.
- Death Completed.
- Entity Died.
- Entity Revived.

Los nombres concretos de las Signals serán definidos durante la implementación.

---

# Dependencias

El Death Component podrá interactuar con:

- Health Component.
- Loot Component.
- Spawn Component.
- Animation System.
- Audio Manager.
- EventBus.

No deberá depender directamente de sistemas de IA o UI.

---

# Integración con el resto del proyecto

La muerte podrá desencadenar acciones como:

- Generación de loot.
- Actualización de estadísticas.
- Notificación de misiones.
- Reproducción de efectos.
- Inicio del respawn.
- Eliminación de la Entity.

Estas acciones serán responsabilidad de otros Components o Systems que reaccionen a los eventos emitidos.

---

# Rendimiento

El Component deberá:

- Ejecutar la secuencia de muerte una única vez.
- Evitar comprobaciones innecesarias.
- Mantener un estado interno mínimo.
- Escalar correctamente para cientos de Entities.

---

# Multiplayer

La muerte deberá ser validada por el Host o servidor dedicado.

La sincronización del estado será responsabilidad del sistema de Networking.

---

# Consideraciones para Claude

Al generar código:

- Mantener separadas muerte y salud.
- Evitar destruir directamente la Entity.
- Coordinar la secuencia mediante eventos.
- Garantizar que la muerte solo pueda procesarse una vez.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar destrucciones directas desde el Death Component.
- Verificar que la secuencia no pueda ejecutarse múltiples veces.
- Validar el desacoplamiento con Loot, Respawn y Animaciones.
- Identificar responsabilidades mezcladas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema reutilizable para coordinar el ciclo de muerte de cualquier Entity, notificando de forma consistente al resto de los sistemas y manteniendo completamente desacopladas las consecuencias de la muerte mediante una arquitectura basada en eventos.
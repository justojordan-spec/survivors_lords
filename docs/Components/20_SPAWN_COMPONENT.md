# Spawn Component

**Estado:** Draft

---

# Objetivo

El Spawn Component es responsable de administrar el ciclo de aparición y reaparición de una Entity dentro del mundo del juego.

Su función es coordinar el proceso de spawn utilizando datos de configuración y notificando los eventos correspondientes.

No decide cuándo debe aparecer una Entity ni implementa la lógica de generación del mundo.

---

# Filosofía

El Spawn Component administra el estado de aparición de una Entity.

Las reglas que determinan cuándo y dónde aparecer pertenecen a Systems y Resources especializados.

El Component únicamente ejecuta el ciclo de vida relacionado con el spawn.

---

# Arquitectura

El Spawn Component encapsula la información necesaria para controlar el estado de aparición de una Entity.

Podrá trabajar junto con Spawn Points, Spawn Systems y Spawn Resources, manteniéndose independiente de una implementación específica.

---

# Responsabilidades

El Spawn Component es responsable de:

- Gestionar el estado de spawn.
- Coordinar la aparición inicial.
- Coordinar la reaparición cuando corresponda.
- Notificar eventos relacionados con el spawn.
- Mantener información sobre el origen de aparición.

No es responsable de:

- Elegir puntos de spawn.
- Crear Entities.
- Gestionar oleadas.
- Controlar IA.
- Administrar pools de objetos.

---

# API Pública

La API pública deberá permitir operaciones como:

- Iniciar spawn.
- Solicitar respawn.
- Consultar estado de spawn.
- Obtener información del punto de origen.
- Cancelar un respawn pendiente.

La implementación concreta será documentada durante el desarrollo.

---

# Estado Interno

El Component administrará:

- Estado de aparición.
- Información del punto de origen.
- Temporizadores de respawn.
- Restricciones temporales.

Toda esta información permanecerá encapsulada.

---

# Signals

El Component podrá emitir eventos como:

- Spawn iniciado.
- Spawn completado.
- Respawn iniciado.
- Respawn completado.

Los nombres concretos de las Signals se definirán durante la implementación.

---

# Dependencias

El Spawn Component podrá interactuar con:

- Spawn Manager.
- Resource Manager.
- EventBus.
- Spawn Systems.

No deberá depender del Combat Component ni del Health Component.

---

# Integración con el resto del proyecto

El Spawn Component podrá utilizarse en:

- Jugadores.
- Enemigos.
- NPCs.
- Jefes.
- Invocaciones.
- Objetos temporales.

Las reglas de generación permanecerán definidas mediante Resources y Systems especializados.

---

# Rendimiento

El Component deberá:

- Mantener un estado interno mínimo.
- Evitar temporizadores innecesarios.
- Compartir datos mediante Resources.
- Escalar correctamente para miles de Entities.

---

# Multiplayer

Las operaciones de spawn y respawn deberán ser autorizadas por el Host o servidor dedicado.

La creación efectiva de la Entity será sincronizada mediante el sistema de Networking.

---

# Consideraciones para Claude

Al generar código:

- Mantener separado el spawn de la creación de Entities.
- Utilizar Resources para configurar reglas de aparición.
- Evitar lógica de generación del mundo dentro del Component.
- Diseñar un sistema reutilizable para cualquier tipo de Entity.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica de generación dentro del Spawn Component.
- Verificar el desacoplamiento con Spawn Systems.
- Validar la correcta encapsulación del estado de spawn.
- Identificar responsabilidades mezcladas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema reutilizable para administrar el ciclo de aparición y reaparición de cualquier Entity, manteniendo completamente separadas las responsabilidades de generación del mundo, creación de entidades y control del estado de spawn.
# Combat Component

**Estado:** Draft

---

# Objetivo

El Combat Component es responsable de coordinar las acciones ofensivas de una Entity.

Su función es administrar el flujo de combate, validar si una acción ofensiva puede ejecutarse y coordinar la interacción entre los distintos Components involucrados.

No calcula daño ni administra la salud de las Entities.

---

# Filosofía

El combate representa la coordinación de múltiples sistemas.

El Combat Component no contiene toda la lógica del combate.

Su responsabilidad consiste en organizar la ejecución de un ataque utilizando los Components especializados.

---

# Arquitectura

El Combat Component actúa como coordinador entre:

- Stats Component
- Damage Component
- Movement Component
- Ability Component
- Animation System
- Audio System

Cada uno mantiene sus propias responsabilidades.

---

# Responsabilidades

El Combat Component es responsable de:

- Iniciar ataques.
- Cancelar ataques.
- Validar estados de combate.
- Gestionar tiempos de ataque.
- Coordinar ataques cuerpo a cuerpo.
- Coordinar ataques a distancia.
- Coordinar habilidades ofensivas.
- Controlar el estado de combate.

No es responsable de:

- Calcular daño.
- Reducir vida.
- Gestionar estadísticas.
- Mover la Entity.
- Ejecutar animaciones.
- Reproducir sonidos.

---

# API Pública

La API pública deberá permitir operaciones como:

- Iniciar ataque.
- Cancelar ataque.
- Consultar si puede atacar.
- Consultar estado de combate.
- Obtener información del ataque actual.
- Finalizar ataque.

La implementación concreta será documentada durante el desarrollo.

---

# Flujo de combate

Un ataque seguirá el siguiente flujo general:

1. Se solicita un ataque.
2. Combat Component valida el estado.
3. Consulta las estadísticas necesarias.
4. Coordina la animación correspondiente.
5. Solicita al Damage Component la generación del daño.
6. Finaliza el ataque.
7. Notifica el resultado cuando corresponda.

El Combat Component nunca modifica directamente la vida del objetivo.

---

# Estado Interno

El Component administrará, entre otros:

- Estado de combate.
- Ataque activo.
- Tiempo de recuperación.
- Objetivo actual.
- Estado de cancelación.

Toda esta información permanecerá encapsulada.

---

# Signals

El Component podrá emitir eventos como:

- Ataque iniciado.
- Ataque cancelado.
- Ataque finalizado.
- Estado de combate modificado.

Los nombres concretos de las Signals se definirán durante la implementación.

---

# Dependencias

El Combat Component podrá interactuar con:

- Stats Component.
- Damage Component.
- Movement Component.
- Ability Component.
- Animation System.
- Audio Manager.
- EventBus.

No deberá modificar directamente otros Components.

---

# Integración con el resto del proyecto

El Combat Component será utilizado por cualquier Entity capaz de realizar acciones ofensivas.

Podrá ser utilizado por:

- Jugadores.
- Enemigos.
- NPCs.
- Invocaciones.
- Torres.
- Trampas.

La lógica específica de cada tipo de ataque permanecerá desacoplada mediante Resources y Components especializados.

---

# Rendimiento

El Component deberá:

- Evitar cálculos innecesarios durante cada ataque.
- Delegar responsabilidades a Components especializados.
- Minimizar estados temporales.
- Escalar correctamente para cientos de Entities simultáneas.

---

# Multiplayer

La coordinación de ataques deberá respetar la autoridad del Host.

El Combat Component no implementará lógica de replicación; la sincronización será responsabilidad del sistema de Networking.

---

# Consideraciones para Claude

Al generar código:

- Mantener Combat como coordinador.
- Delegar el cálculo del daño al Damage Component.
- Obtener estadísticas mediante Stats Component.
- No modificar directamente la vida de otras Entities.
- Mantener el flujo de combate claramente separado.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica de daño dentro del Combat Component.
- Verificar que la vida sea administrada únicamente por Health Component.
- Validar la correcta coordinación entre Components.
- Identificar responsabilidades mezcladas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un Component especializado en coordinar todas las acciones ofensivas de una Entity, manteniendo completamente separadas las responsabilidades de combate, daño, estadísticas y salud, permitiendo construir un sistema flexible, escalable y fácilmente extensible.
# Event System

**Estado:** Draft

---

# Objetivo

El Event System es responsable de administrar los eventos globales del mundo y del gameplay.

Su función es iniciar, actualizar, finalizar y coordinar eventos que afectan al estado general del juego, permitiendo que múltiples Systems reaccionen de forma consistente.

No reemplaza al EventBus ni administra la comunicación interna del proyecto.

---

# Filosofía

Un evento representa una situación temporal que modifica el comportamiento del mundo.

Los eventos son entidades de gameplay con su propio ciclo de vida.

El Event System coordina dichos eventos utilizando una arquitectura completamente Data Driven.

---

# Arquitectura

Cada evento será definido mediante un Event Resource.

El Event System administrará:

- Inicio.
- Actualización.
- Finalización.
- Cancelación.
- Prioridades.
- Reglas de activación.

Los Systems interesados reaccionarán mediante EventBus o APIs públicas.

---

# Responsabilidades

El Event System es responsable de:

- Registrar eventos.
- Activar eventos.
- Finalizar eventos.
- Cancelar eventos.
- Mantener eventos activos.
- Coordinar múltiples eventos simultáneos.
- Notificar cambios de estado.

No es responsable de:

- Ejecutar IA.
- Aplicar daño.
- Gestionar UI.
- Reproducir efectos.
- Guardar partidas.

---

# Ciclo de Vida

Cada evento seguirá el siguiente flujo:

- Registrado.
- Disponible.
- Activado.
- En ejecución.
- Finalizado.
- Eliminado.

Cada transición será controlada por el Event System.

---

# Comunicación

El Event System podrá comunicarse con:

- World System.
- Kingdom System.
- Enemy System.
- Quest System.
- Loot System.
- Audio System.
- Effect System.
- EventBus.

No accederá directamente al estado interno de otros Systems.

---

# Dependencias

El Event System podrá utilizar:

- Event Resources.
- Resource Manager.
- EventBus.
- World System.
- Save System.

Las reglas del evento permanecerán definidas mediante Resources.

---

# Integración con el resto del proyecto

Ejemplos de eventos:

- Blood Moon.
- Eclipse.
- Tormenta.
- Festival.
- Invasión.
- Boss Mundial.
- Temporada.
- Evento Especial.

Cada evento podrá modificar distintos Systems sin generar acoplamiento entre ellos.

---

# Rendimiento

El System deberá:

- Actualizar únicamente eventos activos.
- Compartir Event Resources.
- Evitar comprobaciones innecesarias.
- Escalar correctamente para múltiples eventos simultáneos.

---

# Multiplayer

Los eventos globales deberán ser iniciados y controlados por el Host o servidor dedicado.

Los clientes recibirán únicamente el estado sincronizado del evento.

---

# Consideraciones para Claude

Al generar código:

- Mantener los eventos completamente Data Driven.
- Separar la lógica del evento de los Systems afectados.
- Utilizar Event Resources.
- Coordinar los cambios mediante EventBus.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica específica dentro del Event System.
- Verificar el uso de Event Resources.
- Validar el desacoplamiento entre eventos y Systems.
- Identificar dependencias innecesarias.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado para administrar todos los eventos globales del juego, permitiendo activar, coordinar y finalizar eventos de forma desacoplada, reutilizable y completamente Data Driven.
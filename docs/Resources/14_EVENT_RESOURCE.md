# Event Resource

**Estado:** Draft

---

# Objetivo

El Event Resource define un evento global o local dentro de Survivors Lords.

Su propósito es describir completamente las condiciones, duración, efectos y comportamiento de un evento mediante una arquitectura completamente Data Driven.

No ejecuta el evento por sí mismo.

---

# Filosofía

Un evento representa una situación temporal que modifica el comportamiento del mundo.

Puede afectar una región específica, una facción, una ciudad o incluso todo el mundo.

El Event Resource únicamente describe el evento.

Su ejecución será responsabilidad del Event System.

---

# Arquitectura

Cada Event Resource representa un evento independiente.

Podrá utilizar otros Resources para construir comportamientos complejos mediante composición.

Ejemplos:

- Effect Resources.
- Loot Table Resources.
- Dialogue Resources.
- Quest Resources.
- Faction Resources.
- World Resources.

---

# Información General

Todo Event podrá definir:

- ID único.
- Nombre.
- Descripción.
- Categoría.
- Prioridad.
- Icono.
- Etiquetas.

---

# Activación

Un evento podrá iniciarse mediante:

- Hora del día.
- Día específico.
- Estación.
- Probabilidad.
- Progreso del jugador.
- Estado del Reino.
- Estado del Mundo.
- Activación manual.
- Script del servidor.

---

# Duración

Un evento podrá definir:

- Instantáneo.
- Temporal.
- Permanente.
- Duración máxima.
- Duración mínima.
- Condiciones de finalización.

---

# Efectos

Un evento podrá producir:

- Cambios climáticos.
- Modificaciones de Spawn.
- Bonificaciones.
- Penalizaciones.
- Desbloqueo de Quests.
- Aparición de NPCs.
- Aparición de Bosses.
- Cambios en Loot.
- Cambios económicos.

Todos los efectos serán definidos mediante Resources.

---

# Responsabilidades

El Event Resource es responsable de:

- Definir un evento.
- Configurar condiciones.
- Configurar duración.
- Configurar efectos.
- Referenciar otros Resources.

No es responsable de:

- Ejecutar lógica.
- Administrar tiempo.
- Modificar Entities.
- Controlar IA.
- Gestionar UI.

---

# Composición

Un Event podrá utilizar:

- Effect Resources.
- Loot Table Resources.
- Quest Resources.
- Dialogue Resources.
- Faction Resources.
- World Resources.

Todos estos Resources serán opcionales.

---

# Integración con el resto del proyecto

Los Event Resources serán utilizados por:

- Event System.
- World System.
- Kingdom System.
- Quest System.
- Enemy System.
- Loot System.
- Effect System.

Su función será describir completamente el comportamiento de un evento.

---

# Rendimiento

Los Event Resources deberán:

- Compartirse entre múltiples partidas.
- Evitar información redundante.
- Mantener únicamente datos estáticos.
- Ser completamente reutilizables.

---

# Multiplayer

Los eventos serán iniciados y controlados por el Host o servidor dedicado.

Los clientes recibirán únicamente el estado del evento y las consecuencias autorizadas por el servidor.

---

# Convenciones

Todo Event deberá:

- Tener un ID único.
- Representar un único evento.
- Mantener una estructura consistente.
- No contener lógica.
- Utilizar composición mediante otros Resources.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Event Resource como una definición de datos.
- Evitar lógica de ejecución.
- Utilizar composición mediante Resources.
- Diseñar eventos completamente reutilizables.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas.
- Validar condiciones de activación.
- Identificar configuraciones duplicadas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para todos los eventos del juego, permitiendo construir fenómenos globales, eventos del mundo, invasiones, festivales y sucesos especiales mediante Resources reutilizables, desacoplados de la lógica del Event System y preparados para integrarse con el resto de la arquitectura de Survivors Lords.
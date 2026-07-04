# Signals API

**Estado:** Draft

---

# Objetivo

Este documento define el contrato de uso de las Signals dentro del proyecto.

Las Signals constituyen el mecanismo principal de comunicación entre nodos, Components y escenas que mantienen una relación directa dentro del árbol de nodos de Godot.

Su objetivo es permitir una comunicación reactiva, desacoplada y coherente con la arquitectura basada en componentes.

---

# Filosofía

Las Signals representan eventos locales producidos por un objeto.

Un objeto emite una Signal para informar que su estado ha cambiado o que ha ocurrido un evento relevante.

Los objetos que necesiten reaccionar podrán conectarse a dicha Signal sin que el emisor conozca a los receptores.

Las Signals no deben utilizarse como sustituto del EventBus para eventos de alcance global.

---

# Arquitectura

Las Signals deberán utilizarse únicamente cuando exista una relación directa entre los objetos involucrados.

Casos típicos:

- Comunicación entre un Component y su Entity.
- Comunicación entre nodos de una misma escena.
- Comunicación entre la UI y el nodo que la controla.
- Comunicación entre sistemas con dependencias locales.

Las Signals deberán declararse explícitamente y documentarse en el componente correspondiente.

---

# Responsabilidades

Las Signals deben:

- Notificar cambios de estado.
- Informar la finalización de una operación.
- Comunicar eventos locales.
- Reducir el acoplamiento entre nodos relacionados.

Las Signals no deben:

- Ejecutar lógica de negocio.
- Coordinar sistemas globales.
- Reemplazar llamadas directas cuando una dependencia es intencional y clara.
- Sustituir el EventBus para eventos del dominio del juego.

---

# Convenciones

Las Signals deberán seguir una nomenclatura consistente.

Se recomienda utilizar nombres que describan el hecho ocurrido.

Ejemplos:

- `health_changed`
- `damage_received`
- `level_completed`
- `inventory_updated`
- `animation_finished`

Evitar nombres imperativos como:

- `update_health`
- `change_inventory`
- `play_animation`

Las Signals representan hechos, no órdenes.

---

# Integración con el resto del proyecto

Las Signals podrán utilizarse en:

- Components
- Entities
- Scenes
- UI
- Managers (cuando la comunicación sea local)

Para eventos que deban ser observados por múltiples sistemas independientes, deberá utilizarse el EventBus.

---

# Consideraciones para Claude

Al generar código:

- Priorizar Signals para comunicación entre nodos relacionados.
- No utilizar Signals como mecanismo de comunicación global.
- Declarar todas las Signals de forma explícita.
- Documentar el propósito de cada Signal pública.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Verificar que las Signals representen eventos locales.
- Detectar Signals utilizadas para coordinar sistemas globales.
- Comprobar que exista una separación clara entre Signals y EventBus.
- Validar una nomenclatura consistente y descriptiva.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Establecer un modelo uniforme para el uso de Signals, favoreciendo una comunicación local reactiva y desacoplada entre nodos, Components y escenas, manteniendo una separación clara respecto al EventBus y preservando la coherencia de la arquitectura del proyecto.
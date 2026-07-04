# Component Base

**Estado:** Draft

---

# Objetivo

Definir la especificación técnica que deben cumplir todos los Components del proyecto.

Este documento establece la arquitectura base, las responsabilidades, las restricciones y las convenciones que garantizan un comportamiento uniforme en toda la arquitectura basada en composición.

Todos los Components deberán ajustarse a estas reglas.

---

# Filosofía

Un Component representa una única capacidad o comportamiento que puede añadirse a una Entity.

Un Component nunca representa un objeto del juego completo.

Las Entities son únicamente contenedores que agrupan Components.

La combinación de múltiples Components define el comportamiento final de una Entity.

---

# Arquitectura

Todos los Components deberán cumplir las siguientes reglas:

- Tener una única responsabilidad.
- Ser reutilizables.
- Ser independientes del tipo de Entity.
- Mantener encapsulado su estado.
- Exponer únicamente una API pública.
- Minimizar las dependencias.
- Poder combinarse libremente con otros Components.

Los Components no deberán depender del orden en que fueron agregados a una Entity.

---

# Responsabilidades

Todo Component deberá ser responsable únicamente de una capacidad concreta.

Ejemplos:

- Vida
- Movimiento
- Inventario
- Combate
- Estadísticas
- Interacción
- Habilidades

No deberán mezclarse varias responsabilidades dentro del mismo Component.

---

# Ciclo de vida

Todo Component seguirá el ciclo de vida definido por la arquitectura del proyecto.

De forma general:

1. Creación.
2. Inicialización.
3. Configuración.
4. Activación.
5. Actualización.
6. Desactivación.
7. Liberación.

Cada fase deberá ser claramente diferenciable.

---

# API Pública

Cada Component deberá definir una API pública mínima y coherente.

La API deberá:

- Ser estable.
- Estar documentada.
- Ocultar la implementación interna.
- Evitar exponer variables directamente.

Los demás sistemas deberán interactuar únicamente mediante dicha API.

---

# Estado Interno

El estado interno pertenece exclusivamente al Component.

Otros sistemas no deberán modificarlo directamente.

Toda modificación deberá realizarse mediante métodos públicos o mecanismos específicamente documentados.

---

# Comunicación

Los Components podrán comunicarse mediante:

- API pública.
- Signals.
- EventBus.
- Eventos documentados.

No deberán acceder directamente al estado interno de otros Components.

---

# Dependencias

Un Component podrá depender de:

- Otros Components de la misma Entity.
- Managers.
- Resources.
- Systems.

Las dependencias deberán mantenerse al mínimo indispensable.

Las dependencias circulares deberán evitarse.

---

# Integración con Entities

Las Entities actúan como contenedores de Components.

Las Entities coordinan la existencia de los Components, pero no implementan la lógica que estos encapsulan.

El comportamiento emerge de la interacción entre Components.

---

# Integración con Managers

Los Managers proporcionan servicios globales.

Los Components podrán consumir dichos servicios mediante las APIs públicas correspondientes.

Los Managers nunca deberán depender de Components específicos.

---

# Rendimiento

Los Components deberán diseñarse considerando:

- Bajo consumo de memoria.
- Baja cantidad de asignaciones.
- Reutilización.
- Bajo acoplamiento.
- Escalabilidad para cientos o miles de Entities.

---

# Multiplayer

Los Components deberán ser compatibles con la arquitectura Host-Client del proyecto.

La lógica específica de sincronización deberá permanecer desacoplada de la lógica funcional siempre que sea posible.

Los Components no deberán asumir que siempre existirán conexiones de red.

---

# Consideraciones para Claude

Al generar código:

- Crear Components pequeños.
- Evitar múltiples responsabilidades.
- Favorecer la composición.
- Mantener APIs claras.
- Evitar lógica duplicada.
- Diseñar Components reutilizables.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar Components demasiado grandes.
- Verificar el cumplimiento del principio de responsabilidad única.
- Identificar dependencias innecesarias.
- Validar el desacoplamiento entre Components.
- Comprobar la reutilización potencial del diseño.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Establecer una especificación única para todos los Components del proyecto, garantizando una arquitectura consistente, modular y reutilizable que sirva como base para el desarrollo de todo el gameplay de Survivors Lords.
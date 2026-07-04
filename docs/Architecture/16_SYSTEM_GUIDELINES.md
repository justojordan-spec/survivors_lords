# System Guidelines

**Proyecto:** Survivors Lords

**Versión:** 1.0

---

# Objetivo

Este documento establece las normas oficiales para el diseño, implementación y mantenimiento de todos los Systems del proyecto.

Su propósito es garantizar que cualquier nuevo System siga la misma arquitectura, filosofía y estándares utilizados en Survivors Lords.

---

# Filosofía

Cada System debe tener una única responsabilidad claramente definida.

Los Systems deberán ser independientes, reutilizables y fácilmente mantenibles.

Toda la arquitectura sigue los principios de ECS, Data Driven y Event Driven.

---

# Responsabilidad Única

Cada System deberá responder claramente a una única pregunta:

> ¿Qué responsabilidad exclusiva administra?

Si un System posee más de una responsabilidad, deberá dividirse.

---

# Organización

Todo nuevo System deberá incluir como mínimo las siguientes secciones:

- Objetivo.
- Filosofía.
- Responsabilidades.
- No es responsable de.
- Comunicación.
- Integración.
- Multiplayer.
- Rendimiento.
- Eventos.
- Convenciones.
- Consideraciones para Claude.
- Consideraciones para Gemini.
- Estado.
- Objetivo Final.
- DEC propuesta.

Todos los Systems deberán seguir exactamente esta estructura.

---

# Comunicación

Los Systems únicamente podrán comunicarse mediante:

- Eventos.
- Interfaces.
- Queries.

Nunca mediante referencias directas innecesarias.

---

# Resources

Toda configuración deberá almacenarse en Resources.

Ejemplos:

- ItemResource
- EnemyResource
- BuildingResource
- TechnologyResource

Los Resources nunca deberán contener lógica.

---

# Components

Los Components almacenan únicamente datos.

No deberán ejecutar lógica.

Toda la lógica pertenece a los Systems.

---

# Eventos

Los eventos deberán:

- Representar un único hecho.
- Ser inmutables.
- Ser serializables.
- No contener lógica.
- Tener nombres descriptivos.

---

# Dependencias

Todo nuevo System deberá:

- Evitar dependencias circulares.
- Mantener bajo acoplamiento.
- Utilizar interfaces públicas.
- Compartir únicamente información necesaria.

---

# Multiplayer

Todo System deberá considerar desde su diseño:

- Autoridad del servidor.
- Sincronización.
- Replicación.
- Determinismo.
- Serialización.

---

# Rendimiento

Todo System deberá:

- Procesar únicamente entidades relevantes.
- Compartir Resources.
- Evitar cálculos repetidos.
- Minimizar consultas innecesarias.
- Favorecer estructuras de datos eficientes.

---

# Convenciones

Todos los Systems deberán:

- Tener nombres descriptivos.
- Utilizar la misma estructura documental.
- Mantener consistencia entre cliente y servidor.
- Ser completamente Data Driven.
- Seguir la arquitectura ECS.

---

# Lista de Verificación

Antes de aprobar un nuevo System verificar:

- Tiene una única responsabilidad.
- No duplica funcionalidades existentes.
- Utiliza Resources.
- Utiliza Components correctamente.
- Se comunica mediante eventos o interfaces.
- No introduce dependencias circulares.
- Es compatible con Multiplayer.
- Es determinista.
- Puede serializarse.
- Sigue la estructura oficial de documentación.

---

# Buenas Prácticas

Se recomienda:

- Escribir Systems pequeños.
- Favorecer composición sobre herencia.
- Utilizar eventos para desacoplar lógica.
- Mantener APIs públicas reducidas.
- Documentar cualquier decisión arquitectónica relevante mediante un DEC.

---

# Consideraciones para Claude

Al generar código:

- Respetar la arquitectura ECS.
- Favorecer Systems desacoplados.
- Utilizar Resources para configuración.
- Utilizar Components únicamente como datos.
- Evitar lógica duplicada.
- Documentar decisiones importantes.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar violaciones del principio de responsabilidad única.
- Detectar dependencias innecesarias.
- Validar el uso correcto de Resources y Components.
- Revisar la arquitectura de eventos.
- Verificar el cumplimiento de estas Guidelines.

---

# Estado

**Fase:** Arquitectura

**Estado:** Aprobado

---

# Objetivo Final

Disponer de una guía oficial que garantice que todos los Systems de Survivors Lords mantengan una arquitectura consistente, modular, escalable y fácil de mantener durante todo el ciclo de vida del proyecto.

---

# DEC propuesta

## DEC – Todos los Systems seguirán una estructura unificada

### Decisión

Todo nuevo System deberá seguir la plantilla oficial definida en este documento tanto para su documentación como para su implementación.

### Justificación

- Mantiene la consistencia del proyecto.
- Reduce la curva de aprendizaje para nuevos desarrolladores.
- Facilita revisiones de código y documentación.
- Simplifica la evolución de la arquitectura.
- Refuerza los principios ECS, Data Driven y Event Driven.
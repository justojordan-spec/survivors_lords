# Managers

**Estado:** Draft

---

# Objetivo

Esta carpeta contiene la documentación técnica de todos los Managers globales del proyecto.

Cada Manager representa un servicio de alto nivel responsable de una única área del juego, proporcionando una interfaz pública estable para el resto de los sistemas.

El propósito de esta documentación es definir claramente las responsabilidades, límites y relaciones de cada Manager antes de su implementación.

---

# Filosofía

Los Managers existen para coordinar sistemas globales, no para implementar lógica específica de gameplay.

Cada Manager debe tener una única responsabilidad claramente definida (Single Responsibility Principle).

Los Managers deben comportarse como servicios reutilizables, desacoplados y fácilmente mantenibles.

Siempre que sea posible, la comunicación entre Managers deberá realizarse mediante Signals o EventBus, evitando dependencias directas.

---

# Arquitectura

Todos los Managers del proyecto comparten las siguientes características:

- Son AutoLoad de Godot.
- Existen durante todo el ciclo de vida de la aplicación.
- Exponen únicamente una API pública bien definida.
- Mantienen encapsulado su estado interno.
- Coordinan sistemas, pero no reemplazan Components.
- No contienen lógica específica de una Entity.

Cada Manager documentará su propia arquitectura interna cuando sea necesario.

---

# Responsabilidades

Cada documento de esta carpeta deberá describir:

- Objetivo del Manager.
- Responsabilidades.
- Funciones principales.
- API pública.
- Signals emitidas.
- Dependencias.
- Integración con otros Managers.
- Recursos utilizados.
- Consideraciones de rendimiento.
- Consideraciones de red.
- Casos de uso.

Cada Manager deberá mantener una única responsabilidad claramente definida.

---

# Integración con el resto del proyecto

Los Managers interactúan con:

- Components
- Entities
- Systems
- Resources
- Scenes
- UI
- AI
- Save System
- Multiplayer

La comunicación deberá respetar las reglas definidas en la carpeta `docs/API`.

---

# Estructura de un documento

Todos los documentos de esta carpeta seguirán la siguiente estructura:

1. Objetivo
2. Filosofía
3. Arquitectura
4. Responsabilidades
5. API Pública
6. Flujo de funcionamiento
7. Dependencias
8. Integración
9. Consideraciones para Claude
10. Consideraciones para Gemini
11. Estado
12. Objetivo Final

Esta estructura garantiza consistencia en toda la documentación del proyecto.

---

# Consideraciones para Claude

Al generar código:

- Respetar la responsabilidad única de cada Manager.
- No acceder al estado interno de otros Managers.
- Utilizar únicamente las APIs públicas documentadas.
- Evitar dependencias circulares.
- Mantener el desacoplamiento mediante Signals y EventBus cuando corresponda.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Verificar que cada Manager tenga una única responsabilidad.
- Detectar responsabilidades duplicadas entre Managers.
- Identificar posibles dependencias innecesarias.
- Validar que las APIs sean coherentes con la arquitectura general.
- Comprobar el cumplimiento de los principios de composición y desacoplamiento.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una colección de Managers claramente definidos, con responsabilidades bien delimitadas, APIs estables y una integración coherente con el resto de la arquitectura del proyecto, sirviendo como base para una implementación modular, mantenible y escalable.
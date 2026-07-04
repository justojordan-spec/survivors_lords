# Entity API

**Estado:** Draft

---

# Objetivo

Este documento define el contrato de interacción con las Entities del proyecto.

La Entity API establece una interfaz pública uniforme para que Managers, Components, Systems y demás módulos puedan interactuar con cualquier Entity sin depender de su implementación interna.

Su propósito es garantizar consistencia, reutilización y desacoplamiento dentro de la arquitectura basada en componentes.

---

# Filosofía

Una Entity representa un objeto del mundo del juego.

Su comportamiento no reside en la propia Entity, sino en los Components que la componen.

La Entity actúa como un contenedor y coordinador de Components, proporcionando una interfaz pública estable para acceder a ellos y consultar su estado.

---

# Arquitectura

Todas las Entities deberán exponer una API pública coherente.

Los sistemas podrán:

- Obtener Components.
- Consultar información general de la Entity.
- Verificar su estado.
- Solicitar operaciones permitidas por la Entity.

Los sistemas no deberán depender de la estructura interna de nodos ni acceder directamente a Components mediante rutas del SceneTree.

---

# Responsabilidades

La Entity API debe permitir:

- Acceder a Components registrados.
- Consultar identificadores.
- Obtener información básica de la Entity.
- Verificar estados generales.
- Coordinar la interacción entre Components cuando sea necesario.

La Entity no debe concentrar lógica de gameplay que corresponda a un Component específico.

---

# Convenciones

Todas las Entities deberán:

- Exponer una interfaz pública consistente.
- Ocultar su organización interna.
- Evitar referencias rígidas entre Components.
- Mantener independencia respecto al tipo concreto de Entity.

Los consumidores deberán interactuar con la Entity mediante su API pública y no mediante la estructura del árbol de nodos.

---

# Integración con el resto del proyecto

La Entity API podrá ser utilizada por:

- Managers
- Components
- Systems
- AI
- Multiplayer
- UI

Las operaciones específicas continuarán siendo responsabilidad de los Components correspondientes.

La Entity únicamente proporciona el punto de acceso común.

---

# Consideraciones para Claude

Al generar código:

- Interactuar con las Entities únicamente mediante su API pública.
- Evitar acceder directamente a nodos internos mediante rutas.
- Mantener la lógica de gameplay dentro de los Components.
- Preservar el desacoplamiento entre Entity y Components.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar accesos directos a la estructura interna de una Entity.
- Verificar que la lógica permanezca distribuida entre Components.
- Validar una API pública consistente para todas las Entities.
- Identificar posibles dependencias innecesarias entre Components.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Definir una interfaz pública uniforme para todas las Entities del proyecto, permitiendo que cualquier sistema interactúe con ellas de forma consistente, desacoplada y compatible con la arquitectura basada en componentes.
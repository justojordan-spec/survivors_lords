# Managers API

**Estado:** Draft

---

# Objetivo

Este documento define el contrato de comunicación que deben seguir todos los Managers del proyecto.

La API de un Manager representa la única interfaz pública mediante la cual otros sistemas pueden interactuar con él.

El objetivo es garantizar una arquitectura consistente, desacoplada y fácil de mantener, independientemente de la implementación interna de cada Manager.

---

# Filosofía

Los Managers actúan como servicios globales del proyecto.

Cada Manager expone una API pública clara y estable, mientras que toda su lógica interna permanece encapsulada.

Los sistemas consumidores deben interactuar únicamente a través de esta API, evitando dependencias con detalles de implementación.

La documentación de la API constituye un contrato arquitectónico entre los distintos módulos del proyecto.

---

# Arquitectura

Todos los Managers deberán cumplir las siguientes reglas:

- Exponer únicamente los métodos necesarios para otros sistemas.
- Mantener encapsulado su estado interno.
- Evitar exponer variables modificables públicamente.
- Mantener una interfaz coherente y consistente con el resto de los Managers.
- Priorizar funciones con una única responsabilidad.
- Documentar cualquier cambio en su API pública.

Cada Manager tendrá su propia documentación específica dentro de `docs/Managers/`, donde se describirá su implementación y funcionamiento interno.

---

# Responsabilidades

La API de un Manager debe:

- Definir los métodos públicos disponibles.
- Especificar los parámetros esperados.
- Deficar los valores de retorno.
- Documentar los posibles errores o casos especiales.
- Indicar las señales emitidas cuando corresponda.
- Servir como contrato estable para el resto del proyecto.

La API no debe describir la lógica interna del Manager.

---

# Integración con el resto del proyecto

Todos los sistemas que necesiten interactuar con un Manager deberán hacerlo exclusivamente mediante su API pública.

La implementación interna podrá modificarse sin afectar a otros sistemas, siempre que la API permanezca estable.

Este documento sirve como base para la documentación individual de cada Manager.

---

# Consideraciones para Claude

Al generar código:

- Utilizar únicamente la API pública documentada.
- No acceder al estado interno de un Manager.
- No agregar nuevos métodos públicos sin actualizar previamente la documentación correspondiente.
- Respetar el encapsulamiento definido por la arquitectura.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Verificar que las APIs sean consistentes entre Managers.
- Detectar métodos públicos innecesarios.
- Identificar posibles violaciones del encapsulamiento.
- Validar que la implementación respete el contrato documentado.

---

# Estado

**Fase:** 2 - Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una interfaz pública uniforme para todos los Managers del proyecto, permitiendo una comunicación consistente, desacoplada y mantenible entre los distintos sistemas del juego.
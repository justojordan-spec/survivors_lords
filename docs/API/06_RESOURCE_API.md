# Resource API

**Estado:** Draft

---

# Objetivo

Este documento define el contrato de acceso a los Resources utilizados por el proyecto.

La Resource API establece una interfaz uniforme para consultar, cargar y utilizar datos definidos mediante Resources (.tres), garantizando una arquitectura Data Driven consistente y desacoplada.

Su propósito es permitir que cualquier sistema obtenga información sin depender de la organización física de los archivos ni de su implementación interna.

---

# Filosofía

Los Resources representan datos, no comportamiento.

Toda la información configurable del proyecto deberá almacenarse mediante Resources cuando sea posible.

Los sistemas consumidores deben solicitar los datos a través de la Resource API, evitando referencias directas a archivos o rutas específicas.

La estructura de almacenamiento podrá evolucionar sin afectar a los sistemas que utilizan los datos.

---

# Arquitectura

Toda consulta de datos deberá realizarse mediante la Resource API o mediante los Managers responsables de administrar dichos Resources.

Los sistemas podrán:

- Solicitar un Resource.
- Consultar información contenida en un Resource.
- Obtener referencias de solo lectura.
- Acceder a catálogos y bases de datos de Resources.

Ningún sistema deberá depender de rutas físicas dentro del proyecto.

---

# Responsabilidades

La Resource API debe permitir:

- Localizar Resources.
- Cargar datos cuando sea necesario.
- Compartir información entre sistemas.
- Garantizar consistencia en el acceso a los datos.
- Ocultar la organización interna de los archivos.

La API no debe contener lógica de gameplay.

---

# Convenciones

Los Resources deberán cumplir las siguientes reglas:

- Representar únicamente datos.
- Ser reutilizables.
- Mantener identificadores estables.
- Evitar referencias innecesarias entre Resources.
- Permanecer independientes del estado de ejecución del juego.

Las modificaciones en tiempo de ejecución no deberán alterar los datos originales del Resource.

---

# Integración con el resto del proyecto

La Resource API podrá ser utilizada por:

- Managers
- Components
- Systems
- AI
- UI
- Gameplay
- Save System

Todos los sistemas deberán obtener información mediante esta API o a través del Manager correspondiente, evitando dependencias directas con la estructura de carpetas del proyecto.

---

# Consideraciones para Claude

Al generar código:

- Acceder a los datos únicamente mediante la Resource API o el Manager correspondiente.
- No utilizar rutas de archivo codificadas directamente en el código.
- Tratar los Resources como fuentes de datos inmutables durante la ejecución.
- Mantener separada la lógica de negocio de la definición de datos.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar accesos directos a archivos de Resources.
- Verificar que los datos permanezcan desacoplados de la lógica de gameplay.
- Comprobar la reutilización de Resources cuando sea posible.
- Validar que la organización física de los archivos no afecte a los sistemas consumidores.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una interfaz uniforme para acceder a todos los datos definidos mediante Resources, preservando la filosofía Data Driven del proyecto y garantizando un acceso consistente, desacoplado y fácilmente mantenible.
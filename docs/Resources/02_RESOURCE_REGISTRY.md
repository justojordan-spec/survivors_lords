# Resource Registry

**Estado:** Draft

---

# Objetivo

El Resource Registry define el mecanismo oficial para registrar, localizar y acceder a los Resources utilizados por Survivors Lords.

Su objetivo es establecer una organización uniforme que facilite la reutilización, el mantenimiento y el acceso eficiente a todos los datos del proyecto.

El Resource Registry representa el catálogo oficial de Resources disponibles para Components, Systems y Managers.

---

# Filosofía

Los Resources no deberán localizarse mediante rutas escritas manualmente dentro del código.

Todo acceso a Resources deberá realizarse utilizando mecanismos centralizados definidos por el proyecto.

Esto garantiza consistencia, facilita la refactorización y reduce el acoplamiento entre sistemas.

---

# Arquitectura

El Resource Registry será administrado por el Resource Manager.

Su responsabilidad será mantener el índice de todos los Resources registrados y proporcionar mecanismos seguros para su recuperación.

El Registry no contiene los datos de los Resources.

Únicamente mantiene la información necesaria para localizarlos.

---

# Organización

Los Resources deberán organizarse por categorías.

Ejemplo:

- Characters
- Enemies
- Items
- Equipment
- Abilities
- Buffs
- Loot
- Buildings
- Crafting
- Quests
- Dialogues
- Events
- World

Cada categoría tendrá su propio espacio dentro del Registry.

---

# Identificadores

Cada Resource deberá poseer un identificador único.

Los identificadores deberán:

- Permanecer estables.
- No depender del nombre del archivo.
- Ser únicos dentro de su categoría.
- Poder utilizarse para serialización y guardado.

Los IDs serán la referencia oficial utilizada por el proyecto.

---

# Registro

El proceso de registro deberá permitir:

- Registrar Resources.
- Actualizar registros.
- Eliminar registros.
- Consultar Resources registrados.
- Validar identificadores duplicados.

El mecanismo concreto será definido durante la implementación.

---

# API Conceptual

El Registry deberá permitir operaciones equivalentes a:

- Obtener Resource por ID.
- Consultar existencia.
- Obtener todos los Resources de una categoría.
- Enumerar categorías.
- Validar integridad del Registry.

La implementación concreta será documentada durante el desarrollo.

---

# Dependencias

El Resource Registry podrá interactuar con:

- Resource Manager.
- Save System.
- Editor Tools.
- Components.
- Systems.

No dependerá de lógica específica de gameplay.

---

# Integración con el resto del proyecto

Todos los Components, Managers y Systems deberán acceder a los Resources mediante el Resource Manager y el Resource Registry.

Ningún sistema deberá depender directamente de rutas físicas del proyecto.

---

# Rendimiento

El Registry deberá:

- Mantener búsquedas rápidas.
- Evitar cargas duplicadas.
- Compartir referencias entre Systems.
- Minimizar operaciones de acceso al disco.

---

# Multiplayer

Todos los participantes deberán utilizar el mismo conjunto de Resources.

Durante la sincronización se transmitirán únicamente identificadores y estados cuando sea necesario.

Los Resources deberán ser equivalentes entre Host y Clientes.

---

# Convenciones

Todos los Resources registrados deberán:

- Poseer un ID único.
- Mantener una categoría definida.
- Cumplir la estructura establecida por el proyecto.
- Permanecer organizados dentro del árbol de directorios oficial.

---

# Consideraciones para Claude

Al generar código:

- Nunca acceder directamente a rutas de archivos.
- Utilizar siempre el Resource Manager como punto de acceso.
- Favorecer búsquedas mediante IDs.
- Mantener el Registry independiente del gameplay.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar rutas codificadas manualmente.
- Verificar el uso del Resource Manager.
- Validar la unicidad de los IDs.
- Identificar dependencias innecesarias con el sistema de archivos.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado para registrar, organizar y localizar todos los Resources del proyecto mediante identificadores únicos, eliminando dependencias con rutas físicas y reforzando la arquitectura Data Driven de Survivors Lords.
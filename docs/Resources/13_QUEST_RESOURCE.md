# Quest Resource

**Estado:** Draft

---

# Objetivo

El Quest Resource define una misión reutilizable dentro de Survivors Lords.

Su propósito es describir los objetivos, condiciones, progreso y recompensas de una misión mediante una arquitectura completamente Data Driven.

No ejecuta la misión por sí mismo.

---

# Filosofía

Una Quest representa un conjunto de objetivos que el jugador puede completar.

El Quest Resource únicamente describe la misión.

El Quest System será responsable de controlar su progreso, validar objetivos y otorgar recompensas.

---

# Arquitectura

Cada Quest Resource representa una misión independiente.

Una misión podrá componerse de:

- Objetivos.
- Requisitos.
- Etapas.
- Recompensas.
- Eventos.
- Diálogos.

Todos estos elementos serán configurables mediante Resources.

---

# Información General

Toda Quest podrá definir:

- ID único.
- Nombre.
- Descripción.
- Categoría.
- Nivel recomendado.
- Dificultad.
- NPC inicial.
- NPC final.
- Etiquetas.

---

# Objetivos

Una Quest podrá contener uno o varios objetivos.

Ejemplos:

- Derrotar enemigos.
- Recolectar objetos.
- Construir estructuras.
- Fabricar objetos.
- Hablar con NPCs.
- Explorar zonas.
- Sobrevivir cierto tiempo.
- Defender un reino.

Los objetivos podrán completarse en orden o en paralelo.

---

# Requisitos

Una Quest podrá requerir:

- Nivel mínimo.
- Profesión.
- Reputación.
- Quest previa.
- Evento activo.
- Facción.
- Bioma.
- Hora del día.

---

# Recompensas

Una Quest podrá otorgar:

- Experiencia.
- Item Resources.
- Loot Tables.
- Oro.
- Reputación.
- Desbloqueo de Abilities.
- Nuevas Quests.
- Eventos.

---

# Estados

Toda Quest podrá pasar por los siguientes estados:

- Disponible.
- Aceptada.
- En progreso.
- Completada.
- Fracasada.
- Cancelada.

El ciclo de vida será administrado por el Quest System.

---

# Responsabilidades

El Quest Resource es responsable de:

- Definir una misión.
- Configurar objetivos.
- Configurar requisitos.
- Configurar recompensas.
- Referenciar otros Resources.

No es responsable de:

- Ejecutar lógica.
- Detectar progreso.
- Entregar recompensas.
- Modificar reputación.
- Gestionar UI.

---

# Composición

Una Quest podrá utilizar:

- Dialogue Resources.
- Item Resources.
- Loot Table Resources.
- Event Resources.
- Faction Resources.
- Building Resources.
- World Resources.

---

# Integración con el resto del proyecto

Los Quest Resources serán utilizados por:

- Quest System.
- Dialogue System.
- World System.
- Kingdom System.
- UI System.
- Save System.

Su función será proporcionar toda la información necesaria para administrar las misiones.

---

# Rendimiento

Las Quests deberán:

- Compartirse entre todos los jugadores.
- Evitar información redundante.
- Mantener únicamente datos estáticos.
- Ser completamente reutilizables.

---

# Multiplayer

El progreso de las misiones compartidas será administrado por el Host o servidor dedicado.

Las recompensas y cambios de estado serán sincronizados con todos los clientes cuando corresponda.

---

# Convenciones

Toda Quest deberá:

- Tener un ID único.
- Representar una única misión.
- Mantener una estructura consistente.
- No contener lógica.
- Utilizar únicamente referencias a Resources.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Quest Resource como una definición de datos.
- Evitar lógica de progreso.
- Reutilizar otros Resources mediante composición.
- Diseñar Quests modulares y escalables.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas a otros Resources.
- Validar la estructura de objetivos y recompensas.
- Identificar configuraciones duplicadas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para todas las misiones del juego, permitiendo definir objetivos, requisitos y recompensas mediante Resources reutilizables, desacoplados de la lógica del Quest System y preparados para integrarse con el resto de la arquitectura de Survivors Lords.
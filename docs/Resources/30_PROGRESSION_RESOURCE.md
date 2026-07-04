# Progression Resource

**Estado:** Draft

---

# Objetivo

El Progression Resource define una estructura genérica de progresión dentro de Survivors Lords.

Su propósito es servir como base para cualquier sistema que desbloquee contenido mediante niveles, experiencia, requisitos o hitos, siguiendo una arquitectura completamente Data Driven.

No administra el progreso de una partida ni almacena el estado del jugador.

---

# Filosofía

Una progresión representa una secuencia de desbloqueos.

El Progression Resource únicamente describe esa secuencia.

La experiencia, niveles, investigación y desbloqueos serán administrados por los Systems correspondientes.

---

# Arquitectura

Todo Progression Resource representa una progresión reutilizable.

Servirá como base conceptual para:

- Skill Tree Resource.
- Technology Resource.
- Research Resource.
- Profession Progression Resource.

---

# Información General

Toda Progression podrá definir:

- ID único.
- Nombre.
- Descripción.
- Categoría.
- Icono.
- Color representativo.
- Etiquetas.

---

# Configuración

## Niveles

Podrá definir:

- Nivel mínimo.
- Nivel máximo.
- Curva de experiencia.
- Requisitos por nivel.

---

## Desbloqueos

Cada nivel podrá desbloquear:

- Ability Resources.
- Recipe Resources.
- Building Resources.
- Profession Resources.
- Technology Resources.
- Effect Resources.

Todos los desbloqueos serán opcionales.

---

## Requisitos

La progresión podrá requerir:

- Nivel previo.
- Profesión.
- Tecnología.
- Investigación.
- Quest.
- Evento.
- Reputación.
- Estadísticas.

---

## Bonificaciones

Cada nivel podrá otorgar:

- Stats Resources.
- Buff Resources.
- Multiplicadores.
- Bonificaciones pasivas.

---

# Responsabilidades

El Progression Resource es responsable de:

- Definir una progresión.
- Configurar niveles.
- Configurar requisitos.
- Configurar desbloqueos.
- Referenciar otros Resources.

No es responsable de:

- Administrar experiencia.
- Subir niveles.
- Desbloquear contenido.
- Guardar progreso.
- Ejecutar lógica.

---

# Composición

Una Progression podrá utilizar:

- Ability Resources.
- Recipe Resources.
- Profession Resources.
- Technology Resources.
- Building Resources.
- Stats Resources.
- Buff Resources.
- Quest Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Progression Resources serán utilizados por:

- Progression System.
- Skill System.
- Profession System.
- Technology System.
- Research System.
- Quest System.

Su función será proporcionar la configuración base para todos los sistemas de progresión.

---

# Rendimiento

Los Progression Resources deberán:

- Compartirse entre todas las partidas.
- Mantener únicamente información estática.
- Evitar configuraciones duplicadas.
- Ser completamente reutilizables.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos Progression Resources.

El progreso será sincronizado únicamente mediante los Systems correspondientes.

---

# Convenciones

Toda Progression deberá:

- Tener un ID único.
- Representar una única progresión.
- No contener lógica.
- Ser completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Progression Resource como una definición de datos.
- Evitar lógica de progresión.
- Favorecer composición mediante otros Resources.
- Diseñar una base reutilizable para todos los sistemas de progreso.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas.
- Detectar configuraciones duplicadas.
- Validar la separación entre datos y comportamiento.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para cualquier sistema de progresión del juego, proporcionando una base común reutilizable para habilidades, tecnologías, investigaciones y profesiones, desacoplada de la lógica de los Systems correspondientes y preparada para escalar durante todo el desarrollo de Survivors Lords.
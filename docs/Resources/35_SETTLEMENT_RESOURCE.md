# Settlement Resource

**Estado:** Draft

---

# Objetivo

El Settlement Resource define un asentamiento dentro de Survivors Lords.

Su propósito es representar cualquier núcleo habitado del mundo mediante una arquitectura completamente Data Driven.

No representa el estado dinámico de un asentamiento durante una partida.

---

# Filosofía

Un asentamiento representa una comunidad organizada.

Puede pertenecer a un reino, una facción o existir de forma independiente.

El Settlement Resource únicamente describe su configuración inicial.

Toda la simulación será responsabilidad del Settlement System.

---

# Arquitectura

Cada Settlement Resource representa un único asentamiento.

Ejemplos:

- Ciudad
- Pueblo
- Aldea
- Campamento
- Fortaleza
- Castillo
- Mina
- Puerto
- Monasterio
- Refugio

---

# Información General

Todo Settlement podrá definir:

- ID único.
- Nombre.
- Descripción.
- Icono.
- Escudo.
- Categoría.
- Etiquetas.

---

# Organización

## Gobierno

Podrá definir:

- Kingdom Resource.
- Faction Resource.
- Gobernante.
- NPC líder.

---

## Población

Podrá definir:

- Población inicial.
- NPC Resources.
- Profesiones disponibles.
- Capacidad máxima.

---

## Infraestructura

Podrá contener:

- Building Resources.
- Roads.
- Walls.
- Gates.
- Farms.
- Markets.
- Workshops.

Todos ellos serán referencias a otros Resources.

---

## Economía

Podrá definir:

- Currency Resource.
- Recursos producidos.
- Recursos consumidos.
- Comercio permitido.
- Impuestos.
- Mercados.

---

## Defensa

Podrá definir:

- Guardias.
- Torres.
- Murallas.
- Alarmas.
- Nivel de seguridad.

---

## Expansión

Podrá definir:

- Radio máximo.
- Prioridad de expansión.
- Restricciones.
- Biomas compatibles.

---

# Relaciones

Un Settlement podrá mantener relaciones con:

- Kingdom Resources.
- Faction Resources.
- Settlement Resources.
- NPC Resources.

Estas relaciones serán administradas por el Diplomacy System.

---

# Responsabilidades

El Settlement Resource es responsable de:

- Definir un asentamiento.
- Configurar edificios iniciales.
- Configurar población.
- Configurar economía.
- Configurar defensa.
- Referenciar otros Resources.

No es responsable de:

- Construir edificios.
- Simular economía.
- Administrar NPCs.
- Gestionar comercio.
- Ejecutar lógica.

---

# Composición

Un Settlement podrá utilizar:

- Building Resources.
- NPC Resources.
- Kingdom Resources.
- Faction Resources.
- Currency Resources.
- Profession Resources.
- Quest Resources.
- Event Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Settlement Resources serán utilizados por:

- Settlement System.
- Building System.
- Economy System.
- NPC System.
- Kingdom System.
- Diplomacy System.
- World System.
- Save System.

Su función será proporcionar la configuración base de todos los asentamientos del juego.

---

# Rendimiento

Los Settlement Resources deberán:

- Compartirse entre todas las partidas.
- Mantener únicamente datos estáticos.
- Evitar configuraciones duplicadas.
- Ser completamente reutilizables.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos Settlement Resources.

El servidor administrará la evolución dinámica de cada asentamiento.

---

# Convenciones

Todo Settlement deberá:

- Tener un ID único.
- Representar un único asentamiento.
- No contener lógica.
- Ser completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Settlement Resource como una definición de datos.
- Evitar lógica de simulación.
- Reutilizar Building Resources y NPC Resources.
- Mantener separación entre configuración inicial y estado dinámico.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas.
- Detectar configuraciones duplicadas.
- Validar separación entre Settlement y Kingdom.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para todos los asentamientos del juego, permitiendo definir infraestructura, población, economía y defensa mediante Resources reutilizables, desacoplados de la lógica del Settlement System y preparados para integrarse con la simulación del mundo de Survivors Lords.
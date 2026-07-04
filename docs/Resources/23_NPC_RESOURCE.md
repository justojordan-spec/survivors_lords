# NPC Resource

**Estado:** Draft

---

# Objetivo

El NPC Resource define la configuración de cualquier personaje no controlado por el jugador dentro de Survivors Lords.

Su propósito es describir la identidad, comportamiento, interacciones y capacidades de un NPC mediante una arquitectura completamente Data Driven.

No representa una instancia activa dentro del mundo.

---

# Filosofía

Un NPC es una especialización de un Entity.

El NPC Resource amplía la información de un Entity Resource con datos relacionados con interacción, comercio, diálogo y servicios.

Su comportamiento será ejecutado por los distintos Systems del juego.

---

# Arquitectura

Todo NPC Resource deriva conceptualmente de Entity Resource.

Además de las propiedades generales de una Entity, incorpora información relacionada con interacción social.

Ejemplos:

- Comerciantes
- Herreros
- Agricultores
- Guardias
- Taberneros
- Sanadores
- Reyes
- Aldeanos
- Entrenadores

---

# Información General

Todo NPC podrá definir:

- ID único.
- Nombre.
- Descripción.
- Retrato.
- Modelo o escena.
- Rol.
- Categoría.
- Etiquetas.

---

# Configuración

## Identidad

- Profession Resource.
- Faction Resource.
- Kingdom asociado.
- Nivel.

## Interacción

- Dialogue Resources.
- Quest Resources.
- Comercio.
- Servicios.
- Entrenamiento.

## Comportamiento

- Horario.
- Rutinas.
- Zona de trabajo.
- Zona de descanso.
- Restricciones.

## Inventario

- Inventario inicial.
- Objetos en venta.
- Moneda utilizada.
- Reposición automática.

---

# Relaciones

Un NPC podrá mantener relaciones con:

- Jugadores.
- Otras Facciones.
- Otros NPCs.
- Reinos.

Estas relaciones serán administradas por los Systems correspondientes.

---

# Responsabilidades

El NPC Resource es responsable de:

- Definir un NPC.
- Configurar servicios.
- Configurar diálogos.
- Configurar comercio.
- Referenciar otros Resources.

No es responsable de:

- Ejecutar IA.
- Administrar inventarios.
- Gestionar comercio.
- Ejecutar diálogos.
- Controlar movimiento.

---

# Composición

Un NPC podrá utilizar:

- Dialogue Resources.
- Quest Resources.
- Profession Resources.
- Faction Resources.
- Item Resources.
- Loot Table Resources.
- Building Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los NPC Resources serán utilizados por:

- NPC System.
- Dialogue System.
- Quest System.
- Trading System.
- AI System.
- World System.
- Save System.

Su función será proporcionar la configuración base de todos los NPCs.

---

# Rendimiento

Los NPC Resources deberán:

- Compartirse entre múltiples instancias.
- Evitar datos duplicados.
- Mantener únicamente información estática.
- Ser completamente reutilizables.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos NPC Resources.

El comportamiento de los NPCs será administrado por el Host o servidor dedicado.

---

# Convenciones

Todo NPC deberá:

- Tener un ID único.
- Derivar conceptualmente de Entity Resource.
- Representar un único tipo de NPC.
- No contener lógica.
- Ser completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener el NPC Resource como una definición de datos.
- Evitar lógica de IA.
- Reutilizar Resources existentes.
- Favorecer composición sobre configuración específica.

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

Disponer de una representación completamente Data Driven para todos los NPCs del juego, permitiendo definir comercio, diálogos, profesiones, rutinas y servicios mediante Resources reutilizables, desacoplados de la lógica del NPC System y preparados para integrarse con la IA y el resto de la arquitectura de Survivors Lords.
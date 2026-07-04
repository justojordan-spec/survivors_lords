# Kingdom Resource

**Estado:** Draft

---

# Objetivo

El Kingdom Resource define un reino, nación o territorio político dentro de Survivors Lords.

Su propósito es representar la organización territorial, administrativa y política del mundo mediante una arquitectura completamente Data Driven.

No representa el estado dinámico de un reino durante una partida.

---

# Filosofía

Un Reino representa una entidad política que gobierna uno o varios territorios.

El Kingdom Resource únicamente describe sus características estáticas.

La diplomacia, expansión territorial y estado del reino serán administrados por los Systems correspondientes.

---

# Arquitectura

Cada Kingdom Resource representa un único reino.

Ejemplos:

- Reino del Norte.
- Imperio Solar.
- Confederación Mercante.
- Reino Enano.
- Tribus del Pantano.
- Reino Élfico.

---

# Información General

Todo Kingdom podrá definir:

- ID único.
- Nombre.
- Descripción.
- Emblema.
- Color representativo.
- Capital.
- Idioma principal.
- Etiquetas.

---

# Organización

El Reino podrá definir:

## Gobierno

- Tipo de gobierno.
- Gobernante.
- Sucesión.
- Leyes principales.

## Administración

- Capital.
- Ciudades principales.
- Regiones.
- Asentamientos iniciales.

---

# Relaciones

El Reino podrá mantener relaciones con:

- Kingdom Resources.
- Faction Resources.
- NPC Resources.
- Character Resources.

Estas relaciones serán administradas dinámicamente por el Diplomacy System.

---

# Economía

Podrá definir:

- Currency Resource.
- Recursos principales.
- Producción característica.
- Comercio permitido.
- Impuestos base.

---

# Cultura

Podrá definir:

- Religión.
- Tradiciones.
- Arquitectura.
- Tecnología inicial.
- Profesiones predominantes.

---

# Expansión

Opcionalmente podrá definir:

- Biomas preferidos.
- Límites territoriales iniciales.
- Prioridades de expansión.
- Restricciones ambientales.

---

# Responsabilidades

El Kingdom Resource es responsable de:

- Definir un reino.
- Configurar organización política.
- Configurar economía base.
- Configurar cultura.
- Referenciar otros Resources.

No es responsable de:

- Administrar diplomacia.
- Gestionar guerras.
- Controlar asentamientos.
- Expandir territorios.
- Ejecutar lógica.

---

# Composición

Un Kingdom podrá utilizar:

- Faction Resources.
- Settlement Resources.
- Currency Resources.
- Technology Resources.
- Building Resources.
- NPC Resources.
- Biome Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Kingdom Resources serán utilizados por:

- Kingdom System.
- Diplomacy System.
- Settlement System.
- Economy System.
- World System.
- Quest System.
- Save System.

Su función será proporcionar la configuración base de todos los reinos del juego.

---

# Rendimiento

Los Kingdom Resources deberán:

- Compartirse entre todas las partidas.
- Mantener únicamente información estática.
- Evitar configuraciones duplicadas.
- Ser completamente reutilizables.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos Kingdom Resources.

Las guerras, alianzas y cambios territoriales serán sincronizados por el Host o servidor dedicado.

---

# Convenciones

Todo Kingdom deberá:

- Tener un ID único.
- Representar un único reino.
- No contener lógica.
- Ser completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Kingdom Resource como una definición de datos.
- Evitar lógica de diplomacia.
- Favorecer referencias reutilizables.
- Separar claramente Reino y Facción.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas.
- Validar la separación entre Kingdom y Faction.
- Detectar configuraciones duplicadas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para todos los reinos del juego, permitiendo definir organización política, economía, cultura y territorio mediante Resources reutilizables, desacoplados de la lógica del Kingdom System y preparados para integrarse con la diplomacia, la economía y la simulación del mundo de Survivors Lords.
# Biome Resource

**Estado:** Draft

---

# Objetivo

El Biome Resource define un bioma dentro del mundo de Survivors Lords.

Su propósito es describir las características ambientales, climáticas, geográficas y ecológicas de una región mediante una arquitectura completamente Data Driven.

No representa una región específica del mapa, sino una plantilla reutilizable utilizada durante la generación del mundo.

---

# Filosofía

Un Bioma representa un conjunto de reglas que describen un ecosistema.

El Biome Resource únicamente contiene datos estáticos.

La generación del terreno, el Spawn de entidades y la simulación del mundo serán responsabilidad del World System.

---

# Arquitectura

Cada Biome Resource representa un único tipo de bioma.

Ejemplos:

- Bosque
- Desierto
- Pantano
- Montaña
- Tundra
- Selva
- Llanura
- Volcán
- Costa

---

# Información General

Todo Biome podrá definir:

- ID único.
- Nombre.
- Descripción.
- Icono.
- Color representativo.
- Etiquetas.

---

# Configuración

## Terreno

- Altura mínima.
- Altura máxima.
- Humedad.
- Temperatura.
- Rugosidad.
- Fertilidad.

## Clima

- Tipos de clima permitidos.
- Probabilidades.
- Frecuencia de tormentas.
- Niebla.
- Viento.

## Recursos

El Bioma podrá definir:

- Minerales.
- Árboles.
- Plantas.
- Recursos especiales.
- Agua.

Todos ellos serán referenciados mediante Resources.

---

# Spawn

Podrá configurar:

- Animal Resources.
- Enemy Resources.
- NPC Resources.
- Spawn Groups.

Cada Spawn será configurable mediante probabilidades.

---

# Eventos

Podrá activar:

- Event Resources.
- Eventos climáticos.
- Eventos estacionales.
- Eventos especiales.

---

# Construcción

El Bioma podrá definir:

- Buildings permitidos.
- Restricciones de construcción.
- Multiplicadores de producción.
- Modificadores ambientales.

---

# Responsabilidades

El Biome Resource es responsable de:

- Definir un ecosistema.
- Configurar recursos.
- Configurar Spawn.
- Configurar clima.
- Referenciar otros Resources.

No es responsable de:

- Generar el mapa.
- Ejecutar Spawn.
- Administrar clima.
- Simular el mundo.
- Controlar IA.

---

# Composición

Un Biome podrá utilizar:

- Animal Resources.
- Enemy Resources.
- NPC Resources.
- Spawn Group Resources.
- Event Resources.
- Building Resources.
- Loot Table Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Biome Resources serán utilizados por:

- World System.
- World Generation System.
- Spawn System.
- Weather System.
- Gathering System.
- AI System.

Su función será proporcionar la configuración ambiental utilizada durante la generación y simulación del mundo.

---

# Rendimiento

Los Biome Resources deberán:

- Compartirse entre todas las partidas.
- Mantener únicamente datos estáticos.
- Evitar configuraciones duplicadas.
- Ser completamente reutilizables.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos Biome Resources.

El servidor utilizará esta configuración para generar el mundo y sincronizar únicamente el estado dinámico.

---

# Convenciones

Todo Biome deberá:

- Tener un ID único.
- Representar un único ecosistema.
- No contener lógica.
- Ser completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Biome Resource como una definición de datos.
- Evitar lógica de generación procedural.
- Favorecer la composición mediante otros Resources.
- Mantener independencia respecto al World System.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas.
- Validar reutilización entre distintos mundos.
- Detectar configuraciones duplicadas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para todos los biomas del juego, permitiendo definir ecosistemas, recursos, clima y entidades mediante Resources reutilizables, desacoplados de la lógica del World System y preparados para soportar distintos tipos de generación procedural.
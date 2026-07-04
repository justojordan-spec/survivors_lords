# Animal Resource

**Estado:** Draft

---

# Objetivo

El Animal Resource define la configuración de cualquier animal dentro de Survivors Lords.

Su propósito es representar fauna salvaje, animales domesticables, monturas y animales de producción mediante una arquitectura completamente Data Driven.

No representa una instancia activa dentro del mundo.

---

# Filosofía

Un Animal es una especialización de Creature Resource.

Describe las características específicas relacionadas con domesticación, reproducción, producción de recursos y comportamiento natural.

Toda la lógica será administrada por los Systems correspondientes.

---

# Arquitectura

Todo Animal Resource deriva conceptualmente de Creature Resource.

Ejemplos:

- Lobos
- Ciervos
- Vacas
- Gallinas
- Caballos
- Osos
- Peces
- Abejas
- Ovejas

---

# Información General

Todo Animal podrá definir:

- ID único.
- Nombre.
- Descripción.
- Modelo o escena.
- Categoría.
- Rareza.
- Etiquetas.

---

# Domesticación

Un Animal podrá definir:

- Domesticable.
- Tiempo de domesticación.
- Método de domesticación.
- Afinidad inicial.
- Afinidad máxima.

---

# Producción

Un Animal podrá producir:

- Carne.
- Leche.
- Huevos.
- Lana.
- Cuero.
- Miel.
- Plumas.
- Otros recursos.

La frecuencia de producción será configurable.

---

# Reproducción

Podrá definir:

- Edad mínima.
- Tiempo de gestación.
- Tiempo entre reproducciones.
- Número de crías.
- Condiciones necesarias.

---

# Monturas

Opcionalmente podrá definir:

- Puede montarse.
- Velocidad adicional.
- Capacidad de carga.
- Resistencia.
- Habilidades especiales.

---

# Comportamiento

Un Animal podrá definir:

- Huye del peligro.
- Defiende sus crías.
- Vive en manadas.
- Patrulla territorio.
- Sigue líderes.
- Puede domesticarse.

---

# Relaciones

Podrá definir:

- Depredadores.
- Presas.
- Facción.
- Compatibilidad con NPCs.
- Compatibilidad con jugadores.

---

# Responsabilidades

El Animal Resource es responsable de:

- Definir un animal.
- Configurar domesticación.
- Configurar reproducción.
- Configurar producción.
- Referenciar otros Resources.

No es responsable de:

- Ejecutar IA.
- Gestionar reproducción.
- Controlar movimiento.
- Administrar inventarios.
- Resolver combate.

---

# Composición

Un Animal podrá utilizar:

- Loot Table Resources.
- Stats Resources.
- Ability Resources.
- Buff Resources.
- Faction Resources.
- Effect Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Animal Resources serán utilizados por:

- AI System.
- Farming System.
- Husbandry System.
- Combat System.
- Loot System.
- Spawn System.
- World System.

Su función será proporcionar la configuración base de todos los animales del juego.

---

# Rendimiento

Los Animal Resources deberán:

- Compartirse entre múltiples instancias.
- Mantener únicamente información estática.
- Evitar datos duplicados.
- Ser completamente reutilizables.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos Animal Resources.

La domesticación, reproducción y comportamiento serán administrados por el Host o servidor dedicado.

---

# Convenciones

Todo Animal deberá:

- Tener un ID único.
- Derivar conceptualmente de Creature Resource.
- Representar una única especie.
- No contener lógica.
- Ser completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Animal Resource como una definición de datos.
- Evitar lógica de IA o reproducción.
- Favorecer composición mediante otros Resources.
- Diseñar animales fácilmente extensibles.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas.
- Validar reutilización desde Creature Resource.
- Detectar configuraciones duplicadas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para toda la fauna del juego, permitiendo definir domesticación, reproducción, producción de recursos y comportamiento natural mediante Resources reutilizables, desacoplados de la lógica de simulación y preparados para integrarse con los sistemas de IA, agricultura y supervivencia de Survivors Lords.
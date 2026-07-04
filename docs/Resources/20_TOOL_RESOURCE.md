# Tool Resource

**Estado:** Draft

---

# Objetivo

El Tool Resource define la configuración de cualquier herramienta utilizable dentro de Survivors Lords.

Su propósito es representar herramientas utilizadas para recolección, construcción, fabricación y profesiones mediante una arquitectura completamente Data Driven.

No representa una instancia equipada ni ejecuta acciones por sí mismo.

---

# Filosofía

Una herramienta es una especialización de un Item.

El Tool Resource describe qué puede hacer una herramienta y bajo qué condiciones puede utilizarse.

Toda la lógica relacionada con recolección, fabricación y construcción será responsabilidad de los Systems correspondientes.

---

# Arquitectura

Todo Tool Resource deriva conceptualmente de Item Resource.

Además de las propiedades generales de un Item, incorpora información específica para herramientas.

Ejemplos:

- Hachas.
- Picos.
- Martillos.
- Azadas.
- Palas.
- Hoces.
- Cañas de pescar.
- Tijeras.
- Herramientas especiales.

---

# Información General

Toda Tool podrá definir:

- ID único.
- Nombre.
- Descripción.
- Icono.
- Modelo o escena.
- Rareza.
- Calidad.
- Nivel requerido.
- Etiquetas.

---

# Configuración

## Profesiones

- Profesión asociada.
- Nivel mínimo requerido.
- Experiencia otorgada.
- Especialización.

## Recolección

- Recursos compatibles.
- Velocidad de recolección.
- Multiplicador de eficiencia.
- Calidad obtenida.

## Construcción

- Compatible con Building System.
- Herramienta requerida para construir.
- Herramienta requerida para reparar.
- Herramienta requerida para mejorar.

## Fabricación

- Compatible con estaciones.
- Bonificaciones de fabricación.
- Reducción de tiempo.
- Reducción de consumo.

## Durabilidad

- Durabilidad máxima.
- Desgaste.
- Reparación.

---

# Bonificaciones

Una herramienta podrá otorgar:

- Stats Resources.
- Buff Resources.
- Ability Resources.
- Effect Resources.

Todas las bonificaciones serán opcionales.

---

# Responsabilidades

El Tool Resource es responsable de:

- Definir una herramienta.
- Configurar sus propiedades.
- Configurar requisitos.
- Referenciar otros Resources.

No es responsable de:

- Ejecutar recolección.
- Construir estructuras.
- Fabricar objetos.
- Administrar durabilidad.
- Ejecutar lógica.

---

# Composición

Una Tool podrá utilizar:

- Profession Resources.
- Stats Resources.
- Buff Resources.
- Ability Resources.
- Effect Resources.
- Recipe Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Tool Resources serán utilizados por:

- Gathering System.
- Profession System.
- Crafting System.
- Building System.
- Inventory System.
- Equipment System.
- Save System.

Su función será proporcionar la configuración base de todas las herramientas del juego.

---

# Rendimiento

Los Tool Resources deberán:

- Compartirse entre múltiples instancias.
- Evitar datos duplicados.
- Mantener únicamente información estática.
- Aprovechar el sistema de caché de Godot.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos Tool Resources.

Las acciones realizadas con herramientas serán validadas por el Host o servidor dedicado.

La sincronización incluirá únicamente los estados dinámicos y las acciones ejecutadas.

---

# Convenciones

Toda Tool deberá:

- Tener un ID único.
- Derivar conceptualmente de Item Resource.
- Representar una única herramienta.
- Mantener una estructura consistente.
- No contener lógica.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Tool Resource como una definición de datos.
- Evitar lógica de recolección o construcción.
- Utilizar composición mediante otros Resources.
- Diseñar herramientas fácilmente extensibles.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas a otros Resources.
- Validar la separación entre datos y comportamiento.
- Identificar configuraciones duplicadas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para todas las herramientas del juego, permitiendo definir requisitos, capacidades y bonificaciones mediante Resources reutilizables, desacoplados de la lógica del Gathering System, Crafting System y Building System, y preparados para escalar durante todo el desarrollo de Survivors Lords.
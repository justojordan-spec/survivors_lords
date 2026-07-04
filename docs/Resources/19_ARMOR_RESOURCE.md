# Armor Resource

**Estado:** Draft

---

# Objetivo

El Armor Resource define la configuración de cualquier pieza de armadura o equipamiento defensivo dentro de Survivors Lords.

Su propósito es describir las propiedades, estadísticas, requisitos y bonificaciones de una armadura mediante una arquitectura completamente Data Driven.

No representa una instancia equipada ni administra el estado del equipamiento.

---

# Filosofía

Una armadura es una especialización de un Item.

El Armor Resource amplía la información de un Item Resource con datos relacionados con la defensa y supervivencia.

La lógica de equipamiento, reducción de daño y aplicación de modificadores será responsabilidad del Equipment System y del Combat System.

---

# Arquitectura

Todo Armor Resource deriva conceptualmente de Item Resource.

Además de las propiedades generales de un Item, incorpora información específica para equipamiento defensivo.

Ejemplos:

- Cascos.
- Pecheras.
- Guantes.
- Botas.
- Escudos.
- Capas.
- Amuletos.
- Anillos.
- Reliquias defensivas.

---

# Información General

Toda Armor podrá definir:

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

## Defensa

- Armadura base.
- Resistencia física.
- Resistencia mágica.
- Resistencia elemental.
- Bloqueo.
- Evasión.

## Equipamiento

- Slot de equipamiento.
- Compatibilidad.
- Restricciones.
- Conjuntos (Sets).

## Requisitos

- Nivel mínimo.
- Profesión requerida.
- Clase permitida (si existiera).
- Estadísticas mínimas.

## Durabilidad

- Durabilidad máxima.
- Desgaste.
- Reparación.

---

# Bonificaciones

Una armadura podrá otorgar:

- Stats Resources.
- Buff Resources.
- Ability Resources.
- Effect Resources.

Todas las bonificaciones serán opcionales.

---

# Conjuntos (Sets)

Una armadura podrá pertenecer a un conjunto.

Los Sets podrán otorgar bonificaciones adicionales cuando se equipen varias piezas.

La lógica será responsabilidad del Equipment System.

---

# Responsabilidades

El Armor Resource es responsable de:

- Definir una armadura.
- Configurar estadísticas defensivas.
- Configurar requisitos.
- Referenciar otros Resources.

No es responsable de:

- Reducir daño.
- Administrar equipamiento.
- Calcular bonificaciones.
- Gestionar durabilidad.
- Ejecutar lógica.

---

# Composición

Una Armor podrá utilizar:

- Stats Resources.
- Buff Resources.
- Ability Resources.
- Effect Resources.
- Loot Table Resources.
- Recipe Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Armor Resources serán utilizados por:

- Equipment System.
- Combat System.
- Inventory System.
- Loot System.
- Crafting System.
- Save System.
- UI System.

Su función será proporcionar la configuración base de todas las armaduras y equipamientos defensivos.

---

# Rendimiento

Los Armor Resources deberán:

- Compartirse entre múltiples instancias.
- Evitar datos duplicados.
- Mantener únicamente información estática.
- Aprovechar el sistema de caché de Godot.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos Armor Resources.

La sincronización incluirá únicamente el estado dinámico del equipamiento y sus efectos activos.

---

# Convenciones

Toda Armor deberá:

- Tener un ID único.
- Derivar conceptualmente de Item Resource.
- Representar una única pieza de equipamiento.
- Mantener una estructura consistente.
- No contener lógica.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Armor Resource como una definición de datos.
- Evitar lógica defensiva.
- Utilizar composición mediante otros Resources.
- Diseñar armaduras fácilmente extensibles.

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

Disponer de una representación completamente Data Driven para todas las armaduras del juego, permitiendo definir estadísticas defensivas, requisitos y bonificaciones mediante Resources reutilizables, desacoplados de la lógica del Combat System y preparados para integrarse con el sistema de equipamiento de Survivors Lords.
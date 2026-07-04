# Weapon Resource

**Estado:** Draft

---

# Objetivo

El Weapon Resource define la configuración de cualquier arma utilizable dentro de Survivors Lords.

Su propósito es describir las propiedades, estadísticas, requisitos y comportamiento general de un arma mediante una arquitectura completamente Data Driven.

No representa una instancia equipada ni ejecuta ataques.

---

# Filosofía

Un arma es una especialización de un Item.

El Weapon Resource amplía la información de un Item Resource con datos específicos para el combate.

La lógica de ataque, cálculo de daño y animaciones será responsabilidad del Combat System, Equipment System y Ability System.

---

# Arquitectura

Todo Weapon Resource deriva conceptualmente de Item Resource.

Además de las propiedades generales de un Item, incorpora información relacionada con el combate.

Ejemplos:

- Espadas
- Hachas
- Lanzas
- Mazas
- Arcos
- Ballestas
- Bastones
- Dagas
- Armas legendarias

---

# Información General

Toda Weapon podrá definir:

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

## Combate

- Daño base.
- Tipo de daño.
- Alcance.
- Velocidad de ataque.
- Tiempo de recuperación.
- Multiplicador crítico.

## Equipamiento

- Mano principal.
- Mano secundaria.
- Dos manos.
- Compatibilidad con escudos.

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

# Modificadores

Un arma podrá otorgar:

- Stats Resources.
- Ability Resources.
- Buff Resources.
- Effect Resources.

Estos modificadores serán opcionales.

---

# Responsabilidades

El Weapon Resource es responsable de:

- Definir un arma.
- Configurar sus estadísticas.
- Configurar requisitos.
- Referenciar otros Resources.

No es responsable de:

- Ejecutar ataques.
- Aplicar daño.
- Detectar impactos.
- Administrar durabilidad.
- Gestionar equipamiento.

---

# Composición

Un Weapon podrá utilizar:

- Stats Resources.
- Ability Resources.
- Buff Resources.
- Effect Resources.
- Loot Table Resources.
- Recipe Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Weapon Resources serán utilizados por:

- Equipment System.
- Combat System.
- Ability System.
- Inventory System.
- Loot System.
- Crafting System.
- Save System.

Su función será proporcionar la configuración base de todas las armas del juego.

---

# Rendimiento

Los Weapon Resources deberán:

- Compartirse entre múltiples instancias.
- Evitar datos duplicados.
- Mantener únicamente información estática.
- Aprovechar el sistema de caché de Godot.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos Weapon Resources.

La sincronización incluirá únicamente los estados dinámicos del arma equipada y las acciones ejecutadas por el jugador o la IA.

---

# Convenciones

Toda Weapon deberá:

- Tener un ID único.
- Derivar conceptualmente de Item Resource.
- Representar una única arma.
- Mantener una estructura consistente.
- No contener lógica.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Weapon Resource como una definición de datos.
- Evitar lógica de combate.
- Utilizar composición mediante otros Resources.
- Diseñar armas fácilmente extensibles.

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

Disponer de una representación completamente Data Driven para todas las armas del juego, permitiendo definir estadísticas, requisitos y modificadores mediante Resources reutilizables, desacoplados de la lógica del Combat System y preparados para escalar durante todo el desarrollo de Survivors Lords.
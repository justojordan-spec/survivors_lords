# Entity Resource

**Estado:** Draft

---

# Objetivo

El Entity Resource define la estructura base utilizada para describir cualquier Entity del juego.

Su propósito es proporcionar una definición uniforme de las características generales que comparten todas las Entities, independientemente de su tipo.

No representa una instancia del juego, sino una definición reutilizable utilizada durante la creación de Entities.

---

# Filosofía

Una Entity representa un objeto existente dentro del mundo del juego.

El Entity Resource únicamente describe sus características generales.

Toda la lógica de comportamiento será responsabilidad de Components, Systems y Managers.

---

# Arquitectura

El Entity Resource actuará como la base para Resources especializados.

Ejemplos:

- Character Resource
- Enemy Resource
- NPC Resource
- Building Resource
- Projectile Resource

Cada uno podrá extender la información base sin modificar su filosofía.

---

# Información General

Todo Entity Resource podrá definir información como:

- ID único.
- Nombre.
- Descripción.
- Categoría.
- Etiquetas.
- Icono.
- Escena asociada.
- Components iniciales.
- Resources asociados.

La estructura exacta será definida durante la implementación.

---

# Responsabilidades

El Entity Resource es responsable de:

- Identificar una Entity.
- Definir información descriptiva.
- Asociar Components iniciales.
- Asociar otros Resources necesarios.
- Proporcionar datos reutilizables para la creación de Entities.

No es responsable de:

- Ejecutar lógica.
- Administrar estados.
- Aplicar daño.
- Controlar IA.
- Gestionar inventarios.

---

# Relaciones

Un Entity Resource podrá referenciar:

- Stats Resource.
- Ability Resources.
- Loot Table Resources.
- Buff Resources.
- Spawn Resources.
- Faction Resources.

Estas relaciones permitirán construir Entities complejas mediante composición.

---

# Integración con el resto del proyecto

Los Entity Resources serán utilizados por:

- Spawn System.
- Entity Manager.
- Enemy System.
- Player System.
- World System.

Su función será proporcionar la configuración inicial de cada Entity.

---

# Rendimiento

Los Entity Resources deberán:

- Compartirse entre múltiples instancias.
- Evitar duplicación de datos.
- Mantener únicamente información estática.
- Aprovechar el sistema de caché de Godot.

---

# Multiplayer

Todos los clientes deberán utilizar la misma definición de Entity Resource.

Durante la sincronización únicamente se transmitirán los estados dinámicos de las instancias.

---

# Convenciones

Todo Entity Resource deberá:

- Poseer un ID único.
- Tener un nombre descriptivo.
- Mantener referencias mediante IDs o Resources.
- Evitar almacenar información dinámica.
- Respetar la estructura común definida por el proyecto.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Entity Resource como una definición de datos.
- Evitar lógica de gameplay.
- Favorecer la composición mediante referencias a otros Resources.
- Diseñar Resources reutilizables.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar el uso de composición.
- Validar referencias entre Resources.
- Identificar datos dinámicos almacenados incorrectamente.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una definición base para todas las Entities del juego, permitiendo construir personajes, enemigos, NPCs, edificios, proyectiles y cualquier otro objeto del mundo mediante una arquitectura completamente Data Driven y basada en composición.
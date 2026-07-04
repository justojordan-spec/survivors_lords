# Resource Architecture

**Proyecto:** Survivors Lords

**Versión:** 1.0

---

# Objetivo

Este documento define la arquitectura oficial utilizada por todos los Resources del proyecto.

Su propósito es garantizar una estructura uniforme, completamente Data Driven y desacoplada de la lógica del juego.

---

# Filosofía

Los Resources representan datos de configuración.

Nunca contienen lógica de negocio.

Los Resources describen "qué es" un elemento del juego.

Los Systems determinan "cómo funciona".

---

# Principios

Todos los Resources deberán ser:

- Data Driven.
- Reutilizables.
- Serializables.
- Independientes.
- Editables desde el Editor.
- Libres de lógica.

---

# Responsabilidad

Un Resource únicamente almacena información.

Nunca deberá:

- Ejecutar lógica.
- Consultar otros Systems.
- Generar eventos.
- Modificar entidades.
- Acceder a Managers.

---

# Organización

Cada Resource deberá contener únicamente datos relacionados con su propia responsabilidad.

Ejemplos:

- ItemResource
- EnemyResource
- BuildingResource
- AbilityResource
- WeatherResource
- TechnologyResource

---

# Herencia

Siempre que sea posible se utilizará una clase base común.

Ejemplo:

BaseResource

↓

ItemResource

EnemyResource

BuildingResource

ProfessionResource

TechnologyResource

---

# Identificadores

Todo Resource deberá poseer:

- ID único.
- Nombre interno.
- Nombre visible.
- Descripción.
- Categoría.

---

# Referencias

Un Resource podrá referenciar otros Resources.

Ejemplo:

BuildingResource

↓

RecipeResource

↓

ItemResource

Nunca deberá referenciar Systems.

---

# Serialización

Todos los Resources deberán poder:

- Guardarse.
- Cargarse.
- Compartirse.
- Versionarse.

---

# Convenciones

Todos los Resources deberán:

- Utilizar nombres descriptivos.
- Mantener consistencia.
- Evitar datos duplicados.
- Favorecer reutilización.

---

# Buenas Prácticas

Se recomienda:

- Mantener Resources pequeños.
- Evitar referencias innecesarias.
- Compartir datos comunes.
- Centralizar configuraciones.

---

# Consideraciones para Claude

Al generar código:

- Crear Resources sin lógica.
- Favorecer composición.
- Utilizar identificadores únicos.
- Mantener independencia entre Resources.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar lógica dentro de Resources.
- Detectar datos duplicados.
- Verificar consistencia.
- Revisar referencias entre Resources.

---

# Estado

**Fase:** Arquitectura

**Estado:** Aprobado

---

# Objetivo Final

Disponer de una arquitectura uniforme para todos los Resources del proyecto, garantizando consistencia, reutilización y una implementación completamente Data Driven.
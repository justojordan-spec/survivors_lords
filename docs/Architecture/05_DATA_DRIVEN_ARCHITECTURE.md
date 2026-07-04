# Survivors Lords

# DATA DRIVEN ARCHITECTURE

Versión: 1.0

---

# Objetivo

Definir la arquitectura Data-Driven de Survivors Lords.

Toda la información configurable del juego deberá almacenarse en Resources de Godot o archivos de datos, evitando valores hardcodeados en el código.

Esta arquitectura permitirá ampliar el juego sin modificar los sistemas principales.

---

# Filosofía

El código define el comportamiento.

Los datos definen el contenido.

Un sistema debe funcionar con cualquier dato compatible.

---

# Principios

- Separar lógica y contenido.
- Evitar valores hardcodeados.
- Facilitar el balanceo.
- Facilitar la creación de contenido.
- Permitir futuras herramientas de edición.
- Favorecer la reutilización.

---

# Regla Principal

Nunca escribir en el código:

- Daño de armas.
- Vida de enemigos.
- Costes de construcción.
- Recetas.
- Recompensas.
- Estadísticas.
- Nombres.
- Descripciones.

Toda esta información deberá obtenerse desde Resources.

---

# Arquitectura

```
Código

↓

Lee Resources

↓

Configura Objetos

↓

Ejecuta la lógica

↓

Actualiza el mundo
```

---

# Recursos Principales

El proyecto utilizará Resources para:

- EnemyData
- NPCData
- WeaponData
- ArmorData
- ToolData
- ItemData
- BuildingData
- RecipeData
- SkillData
- ProfessionData
- QuestData
- BiomeData
- RegionData
- LootTableData
- AudioData
- DialogueData

---

# EnemyData

Contendrá únicamente información.

Ejemplo:

- Nombre.
- Vida.
- Daño.
- Velocidad.
- Experiencia.
- Loot.
- Modelo.
- Animaciones.
- IA asignada.

No contendrá lógica.

---

# WeaponData

Ejemplo:

- Daño.
- Durabilidad.
- Peso.
- Alcance.
- Velocidad.
- Rareza.
- Precio.
- Tipo de arma.

---

# BuildingData

Ejemplo:

- Coste.
- Tiempo de construcción.
- Producción.
- Capacidad.
- Nivel máximo.
- Modelo.

---

# QuestData

Ejemplo:

- Objetivos.
- Recompensas.
- NPC inicial.
- Región.
- Requisitos.
- Texto.

---

# NPCData

Ejemplo:

- Nombre.
- Profesión.
- Rutinas.
- Diálogos.
- Apariencia.
- Relaciones.

---

# LootTableData

Ejemplo:

- Objetos posibles.
- Probabilidades.
- Cantidades.
- Rareza.

---

# BiomeData

Ejemplo:

- Música.
- Clima.
- Recursos.
- Enemigos.
- Colores.
- Vegetación.

---

# Configuración Global

Los valores generales del juego también utilizarán Resources.

Ejemplos:

GameConfig

↓

- Dificultad base
- Multiplicadores
- Tiempo del día
- Configuración del Reino
- Balance económico

---

# Beneficios

Esta arquitectura permitirá:

- Balancear el juego sin modificar código.
- Crear nuevo contenido rápidamente.
- Reutilizar sistemas.
- Facilitar el trabajo en equipo.
- Preparar soporte para mods.

---

# Integración con Claude

Claude implementará sistemas genéricos.

Ejemplo:

CombatComponent

↓

Lee WeaponData

↓

Calcula daño

Nunca conocerá valores específicos.

---

# Integración con Gemini

Gemini generará Resources.

Ejemplos:

- Nuevas armas.
- Nuevos enemigos.
- Nuevos NPC.
- Nuevas recetas.
- Nuevos edificios.
- Nuevas regiones.

Sin necesidad de modificar scripts.

---

# Convenciones

Todos los Resources deberán:

- Tener nombres descriptivos.
- Utilizar categorías.
- Compartir una estructura consistente.
- Validarse antes de usarse.

---

# Validación

Cada Resource deberá comprobar:

- Datos obligatorios.
- Rangos válidos.
- Referencias existentes.
- Compatibilidad de versiones.

Los datos inválidos deberán generar advertencias durante el desarrollo.

---

# Escalabilidad

El sistema permitirá añadir cientos de nuevos elementos sin modificar el código existente.

Los sistemas simplemente consumirán nuevos Resources.

---

# Integración

Este documento afecta directamente a:

- Manager System
- Scene Architecture
- Save Architecture
- AI Architecture
- Todos los Systems

---

# Consideraciones para Claude

Todo sistema deberá diseñarse para consumir Resources.

Evitar constantes y valores escritos directamente en el código.

Las configuraciones deberán poder cambiar sin recompilar el proyecto.

---

# Consideraciones para Gemini

Todo el contenido nuevo deberá entregarse como Resources compatibles con la arquitectura del proyecto.

Nunca modificar la lógica para añadir contenido.

---

# Estado

Arquitectura aprobada.

Pendiente de implementación.

---

# Objetivo Final

Construir un juego completamente Data-Driven donde la lógica permanezca estable y el contenido pueda crecer indefinidamente mediante Resources reutilizables.
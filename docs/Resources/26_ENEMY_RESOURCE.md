# Enemy Resource

**Estado:** Draft

---

# Objetivo

El Enemy Resource define la configuración de cualquier enemigo dentro de Survivors Lords.

Su propósito es representar criaturas hostiles mediante una arquitectura completamente Data Driven, proporcionando toda la información necesaria para el combate, la IA y las recompensas.

No representa una instancia activa dentro del mundo.

---

# Filosofía

Un Enemy es una especialización de Creature Resource.

El Enemy Resource amplía la información de una criatura con datos relacionados con el combate, comportamiento hostil y recompensas.

La IA y el combate serán administrados por los Systems correspondientes.

---

# Arquitectura

Todo Enemy Resource deriva conceptualmente de Creature Resource.

Ejemplos:

- Zombies
- Esqueletos
- Bandidos
- Arañas gigantes
- Demonios
- Gólems
- Dragones menores
- Espíritus
- Criaturas corrompidas

---

# Información General

Todo Enemy podrá definir:

- ID único.
- Nombre.
- Descripción.
- Modelo o escena.
- Categoría.
- Rareza.
- Nivel.
- Etiquetas.

---

# Combate

Un Enemy podrá definir:

## Estadísticas

- Vida base.
- Daño base.
- Defensa.
- Velocidad.
- Alcance.
- Velocidad de ataque.
- Probabilidad de crítico.

## IA

- Distancia de detección.
- Distancia de persecución.
- Distancia de regreso.
- Prioridad de objetivos.
- Tiempo de búsqueda.

## Comportamiento

- Patrulla.
- Guardia.
- Emboscada.
- Cazador.
- Protector.
- Invocador.
- Huida por poca vida (opcional).

---

# Recompensas

Al derrotar un Enemy podrá otorgar:

- Experiencia.
- Loot Table Resource.
- Oro.
- Reputación.
- Quest Progress.
- Eventos.

---

# Aparición

Podrá definir:

- Biomas permitidos.
- Nivel mínimo del mundo.
- Horario.
- Clima requerido.
- Eventos necesarios.
- Spawn Group.

---

# Relaciones

Un Enemy podrá definir:

- Facción.
- Enemigos naturales.
- Aliados.
- Objetivos prioritarios.

---

# Responsabilidades

El Enemy Resource es responsable de:

- Definir un enemigo.
- Configurar estadísticas.
- Configurar comportamiento hostil.
- Configurar recompensas.
- Referenciar otros Resources.

No es responsable de:

- Ejecutar IA.
- Resolver combate.
- Calcular daño.
- Gestionar Spawn.
- Administrar experiencia.

---

# Composición

Un Enemy podrá utilizar:

- Stats Resources.
- Ability Resources.
- Buff Resources.
- Effect Resources.
- Loot Table Resources.
- Faction Resources.
- Quest Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Enemy Resources serán utilizados por:

- AI System.
- Combat System.
- Spawn System.
- Loot System.
- Quest System.
- World System.
- Save System.

Su función será proporcionar la configuración base de todos los enemigos del juego.

---

# Rendimiento

Los Enemy Resources deberán:

- Compartirse entre múltiples instancias.
- Mantener únicamente información estática.
- Evitar configuraciones duplicadas.
- Ser completamente reutilizables.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos Enemy Resources.

El Host o servidor dedicado será responsable de administrar la IA, el combate y el Spawn de los enemigos.

---

# Convenciones

Todo Enemy deberá:

- Tener un ID único.
- Derivar conceptualmente de Creature Resource.
- Representar un único tipo de enemigo.
- No contener lógica.
- Ser completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Enemy Resource como una definición de datos.
- Evitar lógica de IA o combate.
- Reutilizar Ability Resources y Loot Table Resources.
- Diseñar enemigos fácilmente extensibles.

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

Disponer de una representación completamente Data Driven para todos los enemigos del juego, permitiendo definir estadísticas, IA, recompensas y condiciones de aparición mediante Resources reutilizables, desacoplados de la lógica del Combat System, AI System y Spawn System, preparados para escalar durante todo el desarrollo de Survivors Lords.
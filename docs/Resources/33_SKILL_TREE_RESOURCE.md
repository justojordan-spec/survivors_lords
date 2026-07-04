# Skill Tree Resource

**Estado:** Draft

---

# Objetivo

El Skill Tree Resource define un árbol de habilidades dentro de Survivors Lords.

Su propósito es representar la progresión de habilidades, talentos y especializaciones mediante una arquitectura completamente Data Driven.

No administra la experiencia del jugador ni ejecuta habilidades.

---

# Filosofía

Un Skill Tree es una especialización de Progression Resource.

Describe la estructura, conexiones y requisitos entre habilidades.

La lógica de desbloqueo y progresión será responsabilidad del Skill System.

---

# Arquitectura

Todo Skill Tree Resource deriva conceptualmente de Progression Resource.

Cada árbol representa una rama independiente de progresión.

Ejemplos:

- Combate.
- Supervivencia.
- Construcción.
- Agricultura.
- Minería.
- Herrería.
- Magia.
- Exploración.
- Liderazgo.

---

# Información General

Todo Skill Tree podrá definir:

- ID único.
- Nombre.
- Descripción.
- Icono.
- Categoría.
- Color representativo.
- Etiquetas.

---

# Nodos

Cada árbol estará compuesto por nodos.

Cada nodo podrá definir:

- Ability Resource.
- Nivel requerido.
- Coste de puntos.
- Posición dentro del árbol.
- Nodo padre.
- Nodos hijos.

---

# Requisitos

Cada nodo podrá requerir:

- Nivel del personaje.
- Profesión.
- Tecnología.
- Investigación.
- Quest completada.
- Evento.
- Estadísticas mínimas.
- Otro nodo desbloqueado.

---

# Bonificaciones

Cada nodo podrá otorgar:

- Ability Resources.
- Stats Resources.
- Buff Resources.
- Passive Effects.
- Multiplicadores.

---

# Especializaciones

Un árbol podrá contener:

- Ramas independientes.
- Caminos alternativos.
- Especializaciones exclusivas.
- Desbloqueos opcionales.

---

# Responsabilidades

El Skill Tree Resource es responsable de:

- Definir la estructura del árbol.
- Configurar nodos.
- Configurar requisitos.
- Configurar bonificaciones.
- Referenciar otros Resources.

No es responsable de:

- Desbloquear habilidades.
- Administrar puntos.
- Ejecutar habilidades.
- Guardar progreso.
- Ejecutar lógica.

---

# Composición

Un Skill Tree podrá utilizar:

- Ability Resources.
- Buff Resources.
- Stats Resources.
- Quest Resources.
- Technology Resources.
- Profession Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Skill Tree Resources serán utilizados por:

- Skill System.
- Progression System.
- Character System.
- Profession System.
- Save System.
- UI System.

Su función será proporcionar la configuración base de todos los árboles de habilidades.

---

# Rendimiento

Los Skill Tree Resources deberán:

- Compartirse entre todas las partidas.
- Mantener únicamente información estática.
- Evitar configuraciones duplicadas.
- Ser completamente reutilizables.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos Skill Tree Resources.

El progreso individual será sincronizado por el Host o servidor dedicado.

---

# Convenciones

Todo Skill Tree deberá:

- Tener un ID único.
- Derivar conceptualmente de Progression Resource.
- Representar un único árbol de habilidades.
- No contener lógica.
- Ser completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Skill Tree Resource como una definición de datos.
- Evitar lógica de desbloqueo.
- Favorecer referencias mediante Ability Resources.
- Diseñar árboles fácilmente extensibles.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas.
- Validar reutilización desde Progression Resource.
- Detectar configuraciones duplicadas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para todos los árboles de habilidades del juego, permitiendo definir nodos, requisitos, especializaciones y bonificaciones mediante Resources reutilizables, desacoplados de la lógica del Skill System y preparados para evolucionar junto al resto de la arquitectura de Survivors Lords.
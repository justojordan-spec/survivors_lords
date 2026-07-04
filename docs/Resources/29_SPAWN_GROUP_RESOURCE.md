# Spawn Group Resource

**Estado:** Draft

---

# Objetivo

El Spawn Group Resource define un grupo reutilizable de entidades que pueden aparecer conjuntamente dentro de Survivors Lords.

Su propósito es centralizar la configuración de aparición de criaturas, NPCs y eventos mediante una arquitectura completamente Data Driven.

No ejecuta el Spawn ni representa entidades activas.

---

# Filosofía

Un Spawn Group representa una colección de posibles apariciones.

Su función es desacoplar la configuración de Spawn del World System, Biome Resource y Event System.

Toda la lógica de generación será responsabilidad del Spawn System.

---

# Arquitectura

Cada Spawn Group Resource representa un grupo reutilizable.

Ejemplos:

- Bosque inicial.
- Manada de lobos.
- Campamento de bandidos.
- Cementerio.
- Bosque encantado.
- Aldea.
- Minas abandonadas.
- Pantano maldito.

---

# Información General

Todo Spawn Group podrá definir:

- ID único.
- Nombre.
- Descripción.
- Categoría.
- Prioridad.
- Etiquetas.

---

# Configuración

## Entidades

Podrá contener:

- Animal Resources.
- Enemy Resources.
- NPC Resources.
- Boss Resources.

Cada entrada podrá definir:

- Probabilidad.
- Cantidad mínima.
- Cantidad máxima.
- Peso relativo.

---

# Restricciones

El Spawn podrá depender de:

- Hora del día.
- Clima.
- Estación.
- Bioma.
- Nivel del mundo.
- Evento activo.
- Reino.
- Facción.

---

# Reaparición

Podrá definir:

- Tiempo de respawn.
- Distancia mínima.
- Distancia máxima.
- Cantidad máxima simultánea.
- Respawn automático.
- Respawn único.

---

# Variaciones

Opcionalmente podrá utilizar:

- Variantes estacionales.
- Variantes nocturnas.
- Variantes por dificultad.
- Variantes por eventos.

---

# Responsabilidades

El Spawn Group Resource es responsable de:

- Definir grupos de Spawn.
- Configurar probabilidades.
- Configurar restricciones.
- Referenciar otros Resources.

No es responsable de:

- Crear entidades.
- Administrar IA.
- Ejecutar Spawn.
- Gestionar el mundo.
- Resolver combate.

---

# Composición

Un Spawn Group podrá utilizar:

- Animal Resources.
- Enemy Resources.
- Boss Resources.
- NPC Resources.
- Event Resources.
- Biome Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Spawn Group Resources serán utilizados por:

- Spawn System.
- World Generation System.
- AI System.
- Event System.
- Biome Resources.
- World System.

Su función será proporcionar configuraciones reutilizables de aparición para todo el juego.

---

# Rendimiento

Los Spawn Group Resources deberán:

- Compartirse entre todas las partidas.
- Mantener únicamente datos estáticos.
- Evitar configuraciones duplicadas.
- Ser completamente reutilizables.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos Spawn Group Resources.

El Host o servidor dedicado será responsable de ejecutar el Spawn y sincronizar las entidades creadas.

---

# Convenciones

Todo Spawn Group deberá:

- Tener un ID único.
- Representar una configuración reutilizable.
- No contener lógica.
- Mantener una estructura consistente.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Spawn Group Resource como una definición de datos.
- Evitar lógica de generación.
- Favorecer referencias reutilizables.
- Mantener independencia respecto al Spawn System.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas.
- Detectar configuraciones duplicadas.
- Validar reutilización entre biomas y eventos.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para todos los grupos de aparición del juego, permitiendo reutilizar configuraciones de Spawn entre biomas, eventos y regiones del mundo, desacopladas de la lógica del Spawn System y preparadas para soportar generación procedural y eventos dinámicos.
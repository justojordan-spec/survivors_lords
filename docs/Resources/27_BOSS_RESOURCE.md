# Boss Resource

**Estado:** Draft

---

# Objetivo

El Boss Resource define la configuración de cualquier jefe dentro de Survivors Lords.

Su propósito es representar encuentros especiales de alta dificultad mediante una arquitectura completamente Data Driven.

No representa una instancia activa dentro del mundo.

---

# Filosofía

Un Boss es una especialización de Enemy Resource.

Amplía la configuración de un enemigo con mecánicas especiales, múltiples fases, eventos de combate y recompensas únicas.

Toda la lógica será administrada por los Systems correspondientes.

---

# Arquitectura

Todo Boss Resource deriva conceptualmente de Enemy Resource.

Ejemplos:

- Rey Esqueleto.
- Dragón Ancestral.
- Señor Demonio.
- Reina Araña.
- Gólem Colosal.
- Titán del Bosque.
- Kraken.
- Guardián del Reino.

---

# Información General

Todo Boss podrá definir:

- ID único.
- Nombre.
- Descripción.
- Modelo o escena.
- Rareza.
- Nivel recomendado.
- Categoría.
- Etiquetas.

---

# Fases

Un Boss podrá contener múltiples fases.

Cada fase podrá definir:

- Vida requerida.
- Nuevas habilidades.
- Modificadores.
- Invocaciones.
- Cambios visuales.
- Nuevas mecánicas.

La transición entre fases será administrada por el Boss System.

---

# Mecánicas Especiales

Un Boss podrá utilizar:

- Enrage.
- Escudos temporales.
- Vulnerabilidades.
- Objetivos secundarios.
- Invocación de enemigos.
- Eventos del escenario.
- Ataques globales.
- Cinemáticas.

---

# Arena

Opcionalmente podrá definir:

- Arena de combate.
- Límites.
- Obstáculos.
- Elementos interactivos.
- Condiciones de derrota.

---

# Recompensas

Al derrotar un Boss podrá otorgar:

- Loot Table Resource.
- Objetos únicos.
- Logros.
- Experiencia.
- Reputación.
- Desbloqueo de Quests.
- Desbloqueo de Eventos.
- Cinemáticas.

---

# Respawn

Podrá definir:

- Respawn permitido.
- Tiempo de respawn.
- Requisitos.
- Evento necesario.
- Aparición única.

---

# Responsabilidades

El Boss Resource es responsable de:

- Definir un jefe.
- Configurar fases.
- Configurar mecánicas especiales.
- Configurar recompensas.
- Referenciar otros Resources.

No es responsable de:

- Ejecutar IA.
- Administrar fases.
- Resolver combate.
- Gestionar Spawn.
- Ejecutar eventos.

---

# Composición

Un Boss podrá utilizar:

- Ability Resources.
- Buff Resources.
- Effect Resources.
- Loot Table Resources.
- Quest Resources.
- Dialogue Resources.
- Event Resources.
- Faction Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Boss Resources serán utilizados por:

- Boss System.
- Combat System.
- AI System.
- Spawn System.
- Loot System.
- Quest System.
- Event System.
- Save System.

Su función será proporcionar la configuración base de todos los jefes del juego.

---

# Rendimiento

Los Boss Resources deberán:

- Compartirse entre múltiples instancias.
- Mantener únicamente información estática.
- Evitar configuraciones duplicadas.
- Ser completamente reutilizables.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos Boss Resources.

El Host o servidor dedicado administrará la IA, fases, eventos y sincronización del combate.

---

# Convenciones

Todo Boss deberá:

- Tener un ID único.
- Derivar conceptualmente de Enemy Resource.
- Representar un único encuentro.
- No contener lógica.
- Ser completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Boss Resource como una definición de datos.
- Evitar lógica de combate.
- Favorecer la reutilización de Ability Resources y Event Resources.
- Diseñar jefes fácilmente escalables mediante fases.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas.
- Validar reutilización desde Enemy Resource.
- Detectar configuraciones duplicadas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para todos los jefes del juego, permitiendo definir fases, mecánicas especiales, recompensas y eventos mediante Resources reutilizables, desacoplados de la lógica del Boss System y preparados para crear encuentros memorables y altamente configurables dentro de Survivors Lords.
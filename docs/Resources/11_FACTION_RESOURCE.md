# Faction Resource

**Estado:** Draft

---

# Objetivo

El Faction Resource define una facción dentro del mundo de Survivors Lords.

Su propósito es describir la identidad, relaciones, reglas y comportamiento diplomático de una facción mediante una arquitectura completamente Data Driven.

No controla directamente el comportamiento de sus miembros.

---

# Filosofía

Una facción representa un grupo organizado dentro del mundo.

Las facciones permiten definir alianzas, enemistades, neutralidad y reputación entre Entities.

El comportamiento individual será responsabilidad de los Components y Systems correspondientes.

---

# Arquitectura

Cada Faction Resource representa una facción independiente.

Podrá ser utilizada por:

- Jugadores.
- NPCs.
- Enemigos.
- Reinos.
- Edificios.
- Invocaciones.

Las relaciones entre facciones serán configuradas mediante Resources y no mediante código.

---

# Información General

Toda Faction podrá definir:

- ID único.
- Nombre.
- Descripción.
- Icono.
- Color representativo.
- Etiquetas.

---

# Relaciones

Una Faction podrá definir relaciones con otras facciones.

Ejemplos:

- Aliada.
- Neutral.
- Hostil.
- En guerra.
- Protegida.
- Comercial.

Las relaciones podrán modificarse dinámicamente durante la partida.

---

# Configuración

Una Faction podrá definir:

## Diplomacia

- Relaciones iniciales.
- Nivel de confianza.
- Hostilidad.
- Prioridad de ataque.

## Reputación

- Reputación inicial.
- Límites mínimo y máximo.
- Recompensas.
- Penalizaciones.

## Restricciones

- Zonas controladas.
- NPCs asociados.
- Enemigos naturales.
- Comerciantes disponibles.

---

# Responsabilidades

El Faction Resource es responsable de:

- Definir una facción.
- Configurar relaciones iniciales.
- Describir reglas diplomáticas.
- Servir como referencia para el gameplay.

No es responsable de:

- Ejecutar IA.
- Resolver combate.
- Aplicar reputación.
- Administrar miembros.
- Gestionar eventos.

---

# Composición

Una Faction podrá referenciar:

- Quest Resources.
- Event Resources.
- Dialogue Resources.
- Building Resources.
- Loot Table Resources.

Estas referencias permitirán crear contenido específico para cada facción.

---

# Integración con el resto del proyecto

Los Faction Resources serán utilizados por:

- Faction Component.
- Enemy System.
- Kingdom System.
- Quest System.
- World System.
- AI System.
- Dialogue System.

Su función será proporcionar la configuración diplomática y organizativa de las facciones.

---

# Rendimiento

Los Faction Resources deberán:

- Compartirse entre múltiples Entities.
- Evitar información redundante.
- Mantener únicamente datos estáticos.
- Ser completamente reutilizables.

---

# Multiplayer

Todos los participantes deberán utilizar las mismas definiciones de Faction Resources.

Los cambios dinámicos de reputación o relaciones serán sincronizados mediante los Systems correspondientes.

---

# Convenciones

Toda Faction deberá:

- Tener un ID único.
- Representar una única organización.
- Mantener una estructura consistente.
- No contener lógica.
- Ser completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Resource como una definición de datos.
- Evitar lógica diplomática dentro del Resource.
- Diseñar relaciones extensibles.
- Favorecer la reutilización entre distintos Systems.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar relaciones consistentes entre facciones.
- Validar referencias a otros Resources.
- Identificar configuraciones duplicadas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una definición completamente Data Driven para todas las facciones del juego, permitiendo gestionar diplomacia, reputación y relaciones entre organizaciones mediante Resources reutilizables, desacoplados de la lógica de gameplay y preparados para integrarse con la IA, el mundo y los sistemas de progresión.
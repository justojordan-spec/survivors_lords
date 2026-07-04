# Diplomacy Resource

**Estado:** Draft

---

# Objetivo

El Diplomacy Resource define las reglas diplomáticas utilizadas dentro de Survivors Lords.

Su propósito es configurar las relaciones iniciales, acciones permitidas y restricciones diplomáticas mediante una arquitectura completamente Data Driven.

No administra el estado dinámico de las relaciones entre reinos o facciones.

---

# Filosofía

La diplomacia representa las reglas que gobiernan las interacciones políticas.

El Diplomacy Resource únicamente contiene configuraciones estáticas.

Las relaciones, tratados, guerras y alianzas serán administradas por el Diplomacy System.

---

# Arquitectura

Cada Diplomacy Resource representa un conjunto reutilizable de reglas diplomáticas.

Ejemplos:

- Diplomacia Medieval
- Diplomacia Tribal
- Diplomacia Imperial
- Diplomacia Fantástica

---

# Información General

Toda Diplomacy podrá definir:

- ID único.
- Nombre.
- Descripción.
- Categoría.
- Etiquetas.

---

# Relaciones Iniciales

Podrá definir relaciones por defecto entre:

- Kingdom Resources.
- Faction Resources.

Tipos posibles:

- Aliado.
- Neutral.
- Amistoso.
- Desconfiado.
- Hostil.
- En guerra.

---

# Acciones Diplomáticas

Podrá habilitar o deshabilitar:

- Declarar guerra.
- Firmar paz.
- Alianzas.
- Pactos defensivos.
- Pactos comerciales.
- Intercambio de recursos.
- Intercambio tecnológico.
- Tributación.
- Vasallaje.

---

# Reputación

Podrá configurar:

- Reputación mínima.
- Reputación máxima.
- Penalizaciones.
- Bonificaciones.
- Modificadores por acciones.

---

# Restricciones

Podrá limitar:

- Relaciones entre facciones.
- Relaciones entre reinos.
- Comercio internacional.
- Acciones durante eventos.
- Acciones según tecnología.

---

# Eventos

Podrá reaccionar a:

- Guerras.
- Paz.
- Conquista.
- Rebeliones.
- Desastres.
- Eventos mundiales.

---

# Responsabilidades

El Diplomacy Resource es responsable de:

- Definir reglas diplomáticas.
- Configurar relaciones iniciales.
- Configurar acciones permitidas.
- Configurar restricciones.
- Referenciar otros Resources.

No es responsable de:

- Administrar relaciones.
- Ejecutar guerras.
- Gestionar tratados.
- Actualizar reputación.
- Ejecutar lógica.

---

# Composición

Un Diplomacy podrá utilizar:

- Kingdom Resources.
- Faction Resources.
- Event Resources.
- Quest Resources.
- Technology Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Diplomacy Resources serán utilizados por:

- Diplomacy System.
- Kingdom System.
- Faction System.
- Quest System.
- Event System.
- World System.
- Save System.

Su función será proporcionar la configuración base de la diplomacia utilizada durante la simulación del juego.

---

# Rendimiento

Los Diplomacy Resources deberán:

- Compartirse entre todas las partidas.
- Mantener únicamente información estática.
- Evitar configuraciones duplicadas.
- Ser completamente reutilizables.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos Diplomacy Resources.

El servidor administrará el estado dinámico de las relaciones y sincronizará sus cambios.

---

# Convenciones

Todo Diplomacy deberá:

- Tener un ID único.
- Representar un único conjunto de reglas.
- No contener lógica.
- Ser completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Diplomacy Resource como una definición de datos.
- Evitar lógica de relaciones.
- Favorecer referencias reutilizables.
- Mantener independencia respecto al Diplomacy System.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas.
- Detectar configuraciones duplicadas.
- Validar la separación entre reglas y estado dinámico.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para las reglas diplomáticas del juego, permitiendo configurar relaciones iniciales, acciones políticas y restricciones mediante Resources reutilizables, desacoplados de la lógica del Diplomacy System y preparados para soportar distintos modelos políticos en Survivors Lords.
# World Resource

**Estado:** Draft

---

# Objetivo

El World Resource define la configuración global del mundo de Survivors Lords.

Su propósito es centralizar todas las reglas, parámetros y configuraciones estáticas que describen el comportamiento general del mundo mediante una arquitectura completamente Data Driven.

No administra el estado dinámico del mundo.

---

# Filosofía

El World Resource representa la configuración base utilizada para crear una partida.

Contiene únicamente datos estáticos.

La simulación, generación y actualización del mundo serán responsabilidad del World System.

---

# Arquitectura

Cada World Resource representa una configuración completa del mundo.

Podrá utilizar otros Resources para definir distintos aspectos del entorno.

Ejemplos:

- Biomas.
- Eventos.
- Clima.
- Ciclos.
- Facciones.
- Spawn Tables.

---

# Información General

Todo World Resource podrá definir:

- ID único.
- Nombre.
- Descripción.
- Versión.
- Semilla por defecto (opcional).
- Etiquetas.

---

# Configuración

Un World Resource podrá definir información relacionada con:

## Mundo

- Tamaño.
- Tipo de generación.
- Altura máxima.
- Profundidad.
- Dificultad inicial.

## Tiempo

- Duración del día.
- Duración de la noche.
- Estaciones.
- Calendario.

## Clima

- Tipos de clima.
- Probabilidades.
- Duración.
- Eventos climáticos.

## Biomas

- Lista de Biomas.
- Distribución.
- Restricciones.
- Recursos disponibles.

## Spawn

- Spawn inicial.
- Spawn de enemigos.
- Spawn de NPCs.
- Spawn de recursos.

## Economía

- Multiplicadores globales.
- Reglas comerciales.
- Escasez.
- Inflación.

---

# Responsabilidades

El World Resource es responsable de:

- Definir la configuración global.
- Configurar parámetros del mundo.
- Referenciar otros Resources.
- Servir como plantilla para crear una partida.

No es responsable de:

- Simular el mundo.
- Generar chunks.
- Controlar IA.
- Administrar Entities.
- Guardar estados dinámicos.

---

# Composición

Un World Resource podrá utilizar:

- Event Resources.
- Faction Resources.
- Loot Table Resources.
- Dialogue Resources.
- Quest Resources.
- Building Resources.
- Spawn Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los World Resources serán utilizados por:

- World System.
- Event System.
- Kingdom System.
- Spawn System.
- Weather System.
- Save System.

Su función será proporcionar la configuración base utilizada durante la creación y simulación del mundo.

---

# Rendimiento

Los World Resources deberán:

- Compartirse entre todas las partidas.
- Evitar datos redundantes.
- Mantener únicamente información estática.
- Ser completamente reutilizables.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente el mismo World Resource.

El Host o servidor dedicado será responsable de mantener sincronizado el estado dinámico del mundo.

---

# Convenciones

Todo World Resource deberá:

- Tener un ID único.
- Representar una única configuración de mundo.
- Mantener una estructura consistente.
- No contener lógica.
- Referenciar únicamente otros Resources.

---

# Consideraciones para Claude

Al generar código:

- Mantener el World Resource como una definición de datos.
- Evitar lógica de simulación.
- Favorecer la reutilización de configuraciones.
- Separar claramente datos estáticos y estados dinámicos.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas.
- Validar la separación entre configuración y simulación.
- Identificar configuraciones duplicadas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para la configuración global del mundo, permitiendo definir reglas, clima, biomas, ciclos y parámetros generales mediante Resources reutilizables, desacoplados de la lógica del World System y preparados para soportar distintos tipos de mundos y modos de juego.
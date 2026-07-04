# Scenario Resource

**Estado:** Draft

---

# Objetivo

El Scenario Resource define un escenario de juego dentro de Survivors Lords.

Su propósito es configurar las condiciones iniciales, reglas especiales y modificadores de una partida mediante una arquitectura completamente Data Driven.

No representa el estado de una partida en ejecución.

---

# Filosofía

Un escenario representa un conjunto de reglas utilizadas para iniciar una nueva partida.

Permite reutilizar el mismo World Resource bajo diferentes condiciones.

Toda la simulación será responsabilidad de los Systems correspondientes.

---

# Arquitectura

Cada Scenario Resource representa un escenario independiente.

Ejemplos:

- Mundo Normal
- Hardcore
- Invasión Demoníaca
- Invierno Eterno
- Reino en Guerra
- Supervivencia Extrema
- Sandbox

---

# Información General

Todo Scenario podrá definir:

- ID único.
- Nombre.
- Descripción.
- Icono.
- Categoría.
- Etiquetas.

---

# Configuración del Mundo

Podrá definir:

- World Resource.
- Biomas disponibles.
- Clima inicial.
- Estación inicial.
- Hora inicial.

---

# Configuración Inicial

Podrá definir:

- Character Resources permitidos.
- Settlement Resources iniciales.
- Kingdom Resources activos.
- Faction Resources activas.

---

# Reglas Especiales

Podrá configurar:

- Dificultad.
- Muerte permanente.
- Hambre.
- Sed.
- Fatiga.
- Daño recibido.
- Daño infligido.
- Multiplicadores de experiencia.
- Multiplicadores de recursos.

---

# Eventos

Podrá activar:

- Event Resources.
- Eventos periódicos.
- Eventos únicos.
- Eventos aleatorios.

---

# Economía

Podrá definir:

- Economy Resource.
- Currency Resources.
- Restricciones comerciales.

---

# Tecnología

Podrá definir:

- Technology Resources iniciales.
- Research Resources desbloqueadas.
- Tecnologías prohibidas.

---

# Condiciones

Podrá definir:

## Victoria

- Derrotar un Boss.
- Construir un edificio.
- Alcanzar un nivel.
- Completar una Quest.
- Sobrevivir cierto tiempo.

## Derrota

- Muerte del jugador.
- Destrucción del reino.
- Pérdida de un asentamiento.
- Tiempo límite.

---

# Responsabilidades

El Scenario Resource es responsable de:

- Definir un escenario.
- Configurar reglas iniciales.
- Configurar modificadores.
- Configurar condiciones.
- Referenciar otros Resources.

No es responsable de:

- Ejecutar la simulación.
- Guardar partidas.
- Administrar progreso.
- Ejecutar eventos.
- Contener lógica.

---

# Composición

Un Scenario podrá utilizar:

- World Resources.
- Character Resources.
- Kingdom Resources.
- Settlement Resources.
- Economy Resources.
- Diplomacy Resources.
- Technology Resources.
- Event Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Scenario Resources serán utilizados por:

- Game System.
- World System.
- Event System.
- Economy System.
- Diplomacy System.
- Save System.

Su función será proporcionar la configuración inicial utilizada al comenzar una nueva partida.

---

# Rendimiento

Los Scenario Resources deberán:

- Compartirse entre todas las partidas.
- Mantener únicamente información estática.
- Evitar configuraciones duplicadas.
- Ser completamente reutilizables.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente el mismo Scenario Resource.

El Host seleccionará el escenario al crear la partida.

---

# Convenciones

Todo Scenario deberá:

- Tener un ID único.
- Representar un único escenario.
- No contener lógica.
- Ser completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Scenario Resource como una definición de datos.
- Evitar lógica de inicio de partida.
- Favorecer referencias reutilizables.
- Separar claramente escenario y estado de la partida.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas.
- Detectar configuraciones duplicadas.
- Validar la separación entre escenario y simulación.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para todos los escenarios del juego, permitiendo configurar mundos, reglas, condiciones de victoria y modificadores mediante Resources reutilizables, desacoplados de la lógica de los Systems y preparados para soportar campañas, modos de juego y expansiones futuras.
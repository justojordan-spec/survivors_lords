# Game Mode Resource

**Estado:** Draft

---

# Objetivo

El Game Mode Resource define un modo de juego dentro de Survivors Lords.

Su propósito es configurar las reglas generales, restricciones y comportamiento global de un tipo de partida mediante una arquitectura completamente Data Driven.

No representa una partida ni un escenario específico.

---

# Filosofía

Un modo de juego define la experiencia general que tendrá el jugador.

El Game Mode Resource establece las reglas permanentes que afectan a todas las partidas creadas bajo dicho modo.

Toda la lógica será responsabilidad de los Systems correspondientes.

---

# Arquitectura

Cada Game Mode Resource representa un único modo de juego.

Ejemplos:

- Historia
- Sandbox
- Hardcore
- Creativo
- PvP
- Cooperativo
- Supervivencia
- Arena

---

# Información General

Todo Game Mode podrá definir:

- ID único.
- Nombre.
- Descripción.
- Icono.
- Imagen.
- Etiquetas.

---

# Escenarios

Podrá definir:

- Scenario Resources permitidos.
- Escenario por defecto.
- Escenarios bloqueados.

---

# Reglas Generales

Podrá configurar:

- Permadeath.
- PvP habilitado.
- Friendly Fire.
- Construcción libre.
- Comercio.
- Diplomacia.
- Investigación.
- Tecnología.
- Economía.

---

# Restricciones

Podrá limitar:

- Profesiones.
- Tecnologías.
- Buildings.
- NPCs.
- Eventos.
- Biomas.
- Recursos.

---

# Multiplayer

Podrá definir:

- Máximo de jugadores.
- Mínimo de jugadores.
- Servidor dedicado.
- Invitaciones.
- Respawn.
- Reconexión.

---

# Dificultad

Podrá modificar:

- Daño recibido.
- Daño realizado.
- Vida de enemigos.
- Frecuencia de Spawn.
- Recursos obtenidos.
- Experiencia.
- Velocidad de progresión.

---

# Victoria y Derrota

Podrá configurar:

- Condiciones permitidas.
- Condiciones obligatorias.
- Tiempo límite.
- Objetivos principales.

---

# Responsabilidades

El Game Mode Resource es responsable de:

- Definir un modo de juego.
- Configurar reglas generales.
- Configurar restricciones.
- Referenciar otros Resources.

No es responsable de:

- Ejecutar reglas.
- Administrar partidas.
- Gestionar jugadores.
- Guardar progreso.
- Contener lógica.

---

# Composición

Un Game Mode podrá utilizar:

- Scenario Resources.
- Technology Resources.
- Economy Resources.
- Diplomacy Resources.
- Event Resources.
- Character Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Game Mode Resources serán utilizados por:

- Game System.
- Multiplayer System.
- Save System.
- World System.
- Economy System.
- Technology System.
- Diplomacy System.

Su función será proporcionar la configuración global utilizada por una partida.

---

# Rendimiento

Los Game Mode Resources deberán:

- Compartirse entre todas las partidas.
- Mantener únicamente datos estáticos.
- Ser completamente reutilizables.
- Evitar configuraciones duplicadas.

---

# Multiplayer

Todos los jugadores deberán utilizar exactamente el mismo Game Mode Resource.

El Host seleccionará el modo al crear la partida.

---

# Convenciones

Todo Game Mode deberá:

- Tener un ID único.
- Representar un único modo de juego.
- No contener lógica.
- Ser completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Game Mode Resource como una definición de datos.
- Evitar lógica de juego.
- Favorecer referencias reutilizables.
- Mantener independencia respecto al Game System.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas.
- Detectar configuraciones duplicadas.
- Validar la separación entre modo de juego y escenario.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para todos los modos de juego de Survivors Lords, permitiendo reutilizar escenarios y configurar reglas globales mediante Resources reutilizables, desacoplados de la lógica del Game System y preparados para soportar campañas, sandbox, PvP, cooperativo y futuras expansiones.
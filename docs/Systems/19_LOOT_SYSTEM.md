# Loot System

**Estado:** Draft

---

# Objetivo

El Loot System es responsable de administrar toda la generación y distribución de botín en Survivors Lords.

Su propósito es determinar qué objetos aparecen, cuándo aparecen y bajo qué condiciones, utilizando una arquitectura completamente Data Driven.

No administra Items, inventarios ni economía.

---

# Filosofía

El Loot System determina exclusivamente la obtención de objetos.

La creación de las instancias será responsabilidad del Item System y el almacenamiento corresponderá al Inventory System.

Toda la configuración será completamente Data Driven mediante Loot Resources.

---

# Responsabilidades

El Loot System será responsable de:

- Generar botín.
- Resolver tablas de loot.
- Calcular probabilidades.
- Aplicar modificadores de botín.
- Generar recompensas.
- Administrar drops del mundo.
- Gestionar botines de enemigos.
- Gestionar recompensas de cofres.

---

# No es responsable de

El Loot System NO debe:

- Crear Items directamente.
- Administrar inventarios.
- Resolver crafting.
- Gestionar economía.
- Ejecutar combate.
- Administrar interfaz.
- Gestionar equipamiento.

Estas responsabilidades pertenecen a sus respectivos Systems.

---

# Fuentes de Loot

El sistema podrá generar botín desde:

- Enemigos.
- Cofres.
- Recursos naturales.
- Edificios.
- Misiones.
- Eventos.
- Comerciantes.
- Recompensas especiales.

---

# Modificadores

El botín podrá verse afectado por:

- Nivel.
- Dificultad.
- Profesión.
- Tecnología.
- Eventos.
- Clima.
- Bonificaciones.
- Multiplicadores.

---

# Comunicación

El Loot System se comunicará mediante:

- Eventos.
- Interfaces.
- Consultas.

Nunca modificará directamente otros Systems.

---

# Integración

Trabajará junto a:

- Resource System.
- Item System.
- Inventory System.
- Enemy System.
- Quest System.
- Economy System.
- Technology System.
- Time System.
- Multiplayer System.

---

# Multiplayer

El servidor será la autoridad sobre toda generación de botín.

Los clientes únicamente recibirán el resultado sincronizado.

---

# Rendimiento

El Loot System deberá:

- Compartir Loot Resources.
- Resolver tablas eficientemente.
- Evitar cálculos repetidos.
- Generar únicamente el botín necesario.
- Mantener una simulación determinista.

---

# Eventos

Ejemplos:

- LootGenerated
- LootDropped
- LootCollected
- LootTableResolved
- RewardGranted

---

# Convenciones

Todo botín deberá:

- Referenciar un Loot Resource.
- Poder serializarse.
- Mantener probabilidades válidas.
- Ser determinista.
- Mantener consistencia entre cliente y servidor.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Loot System desacoplado del Item System.
- Configurar todas las tablas mediante Loot Resources.
- Utilizar probabilidades Data Driven.
- Evitar lógica específica para enemigos o cofres.
- Favorecer una arquitectura orientada a eventos.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar tablas de loot inválidas.
- Verificar probabilidades.
- Detectar generación duplicada.
- Validar sincronización multijugador.
- Revisar rendimiento del sistema.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado encargado de administrar toda la generación de botín del juego, resolviendo tablas de recompensas mediante una arquitectura ECS, Data Driven y completamente desacoplada.

---

# DEC propuesta

## DEC – El Loot System administrará únicamente la generación de botín

### Decisión

El Loot System será responsable exclusivamente de determinar qué objetos deben generarse y bajo qué condiciones. La creación de las instancias será responsabilidad del Item System y su almacenamiento corresponderá al Inventory System.

### Justificación

- Mantiene el principio de responsabilidad única.
- Separa claramente generación, creación y almacenamiento de objetos.
- Facilita el balance de probabilidades.
- Mejora la reutilización de tablas de loot.
- Refuerza la arquitectura ECS y Data Driven.
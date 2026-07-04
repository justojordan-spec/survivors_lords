# Systems Overview

**Proyecto:** Survivors Lords

**Versión:** 1.0

---

# Objetivo

Este documento describe la arquitectura general de los Systems de Survivors Lords.

Su propósito es establecer una organización clara, modular y escalable basada en los principios de ECS (Entity Component System), Data Driven y Event Driven.

Este documento actúa como referencia principal para comprender cómo se organiza la lógica del juego.

---

# Filosofía

Cada System posee una única responsabilidad.

Los Systems nunca deberán asumir responsabilidades pertenecientes a otro System.

Toda interacción entre Systems deberá realizarse mediante mecanismos desacoplados, evitando dependencias directas siempre que sea posible.

La arquitectura prioriza:

- Modularidad.
- Escalabilidad.
- Reutilización.
- Bajo acoplamiento.
- Alto nivel de mantenibilidad.

---

# Arquitectura General

La lógica del juego está dividida en Systems independientes.

Cada System administra una parte específica del funcionamiento del juego y coopera con los demás mediante eventos, interfaces y consultas.

Los datos pertenecen a Components y Resources.

Los Systems únicamente ejecutan lógica.

---

# Organización

La arquitectura está compuesta por treinta y dos Systems principales.

## Núcleo

- Game System
- Resource System
- Event System

Estos Systems inicializan y coordinan toda la arquitectura.

---

## Mundo

- World System
- Time System
- Weather System

Administran el estado global del mundo.

---

## ECS

- Entity System
- Component System

Administran entidades y componentes.

---

## Jugador

- Player System
- Input System
- Camera System
- Audio System
- UI System

Administran toda la interacción del jugador.

---

## Gameplay

- Quest System
- Combat System
- Ability System
- Effect System

Administran las mecánicas principales del juego.

---

## Objetos

- Inventory System
- Item System
- Loot System
- Crafting System

Administran todos los objetos y su ciclo de vida.

---

## Construcción

- Building System
- Settlement System
- Economy System

Administran la expansión del reino.

---

## Progresión

- Profession System
- Research System
- Technology System

Administran el progreso del jugador y del reino.

---

## Mundo Vivo

- Kingdom System
- Diplomacy System
- Enemy System

Administran las facciones y entidades dinámicas del mundo.

---

## Infraestructura

- Multiplayer System
- Save System

Administran la red y la persistencia del juego.

---

# Comunicación

Los Systems podrán comunicarse únicamente mediante:

- Eventos.
- Interfaces.
- Consultas.

Nunca deberán acceder directamente al estado interno de otro System.

---

# Resources

Toda configuración pertenece exclusivamente a los Resources.

Ejemplos:

- ItemResource
- EnemyResource
- BuildingResource
- AbilityResource
- TechnologyResource

Los Resources no contienen lógica.

---

# Components

Los Components almacenan únicamente datos.

Nunca ejecutan lógica de negocio.

Toda lógica pertenece a los Systems.

---

# Eventos

Los eventos representan la principal forma de comunicación entre Systems.

Los eventos:

- No contienen lógica.
- Son inmutables.
- Representan hechos ocurridos durante la simulación.

---

# Principios de Diseño

Toda la arquitectura sigue los siguientes principios:

- ECS.
- Data Driven.
- Event Driven.
- Server Authoritative.
- Modular.
- Desacoplada.
- Escalable.
- Determinista.

---

# Convenciones

Cada System deberá:

- Tener una única responsabilidad.
- Poder evolucionar de forma independiente.
- Utilizar únicamente Resources para configuración.
- Evitar dependencias circulares.
- Comunicar cambios mediante eventos.

---

# Objetivo Final

Disponer de una arquitectura robusta, consistente y preparada para soportar la evolución de Survivors Lords durante todo su desarrollo sin necesidad de rediseñar la base del proyecto.
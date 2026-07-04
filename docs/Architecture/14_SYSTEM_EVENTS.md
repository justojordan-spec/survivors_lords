# System Events

**Proyecto:** Survivors Lords

**Versión:** 1.0

---

# Objetivo

Este documento define la arquitectura de eventos utilizada por todos los Systems de Survivors Lords.

Su propósito es establecer un mecanismo de comunicación desacoplado entre Systems, evitando dependencias directas y facilitando una arquitectura modular, escalable y mantenible.

---

# Filosofía

Los eventos representan hechos que ya ocurrieron dentro del juego.

Un evento nunca ejecuta lógica por sí mismo.

Su única función es comunicar información entre Systems.

---

# Principios

Todos los eventos deberán ser:

- Inmutables.
- Descriptivos.
- Independientes.
- Deterministas.
- Serializables.

---

# Flujo General

System A

↓

Genera Evento

↓

Event System

↓

Distribuye Evento

↓

Systems Suscriptos

---

# Tipos de Eventos

## Gameplay

Ejemplos:

- PlayerSpawned
- PlayerDied
- EnemyKilled
- QuestCompleted
- AbilityUnlocked

---

## Mundo

Ejemplos:

- DayStarted
- NightStarted
- WeatherChanged
- SeasonChanged

---

## Inventario

Ejemplos:

- ItemAdded
- ItemRemoved
- InventoryFull

---

## Construcción

Ejemplos:

- BuildingPlaced
- ConstructionStarted
- ConstructionCompleted
- BuildingDestroyed

---

## Economía

Ejemplos:

- ResourceProduced
- ResourceConsumed
- TradeCompleted

---

## Investigación

Ejemplos:

- ResearchStarted
- ResearchCompleted
- TechnologyUnlocked

---

## Diplomacia

Ejemplos:

- WarDeclared
- PeaceSigned
- AllianceCreated

---

## Red

Ejemplos:

- ClientConnected
- ClientDisconnected
- SessionStarted

---

## Guardado

Ejemplos:

- SaveStarted
- SaveCompleted
- LoadCompleted

---

# Reglas

Los eventos:

- Nunca contienen lógica.
- Nunca modifican Systems.
- Nunca consultan datos.
- Nunca generan otros eventos directamente.

Los eventos únicamente notifican que algo ocurrió.

---

# Suscripción

Los Systems podrán:

- Suscribirse.
- Cancelar suscripción.
- Ignorar eventos no relevantes.

Nunca deberán depender del orden de suscripción.

---

# Prioridades

Los eventos podrán procesarse con prioridades:

- Crítica.
- Alta.
- Normal.
- Baja.

La prioridad únicamente afecta el orden de procesamiento.

---

# Persistencia

Por defecto los eventos son temporales.

Únicamente algunos eventos podrán almacenarse para:

- Repeticiones.
- Depuración.
- Sincronización.
- Guardado.

---

# Multiplayer

En partidas multijugador:

- El servidor genera los eventos oficiales.
- Los clientes reciben únicamente los eventos sincronizados.
- Los eventos deben ser deterministas.

---

# Convenciones

Todo evento deberá:

- Tener un nombre descriptivo.
- Representar un único hecho.
- Contener únicamente la información necesaria.
- Poder serializarse.

Ejemplo:

PlayerDamaged

No:

CombatEvent01

---

# Consideraciones para Claude

Al generar código:

- Crear eventos pequeños.
- Evitar lógica dentro del evento.
- Favorecer nombres descriptivos.
- Utilizar el Event System como intermediario.
- Evitar referencias directas entre Systems.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar eventos innecesarios.
- Detectar lógica dentro de eventos.
- Revisar consistencia de nombres.
- Verificar serialización.
- Validar desacoplamiento.

---

# Objetivo Final

Disponer de una arquitectura de eventos uniforme, desacoplada y escalable que permita la comunicación entre todos los Systems del proyecto sin introducir dependencias directas.
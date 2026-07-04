# Diplomacy System

**Estado:** Draft

---

# Objetivo

El Diplomacy System es responsable de administrar las relaciones diplomáticas entre reinos, facciones, asentamientos y otras organizaciones de Survivors Lords.

Su propósito es gestionar alianzas, guerras, tratados, reputación y acuerdos mediante una arquitectura ECS, modular y completamente Data Driven.

No administra combate, economía ni IA.

---

# Filosofía

La diplomacia representa las relaciones políticas entre organizaciones del mundo.

El Diplomacy System administra exclusivamente el estado de dichas relaciones y las reglas que permiten modificarlas.

Toda la configuración será completamente Data Driven mediante Diplomacy Resources.

---

# Responsabilidades

El Diplomacy System será responsable de:

- Crear relaciones diplomáticas.
- Modificar relaciones.
- Gestionar alianzas.
- Gestionar guerras.
- Administrar tratados.
- Gestionar pactos comerciales.
- Administrar reputación entre facciones.
- Resolver cambios diplomáticos.
- Notificar eventos diplomáticos.

---

# No es responsable de

El Diplomacy System NO debe:

- Resolver combates.
- Administrar economía.
- Gestionar IA.
- Controlar asentamientos.
- Administrar tecnologías.
- Gestionar interfaz.

Estas responsabilidades pertenecen a sus respectivos Systems.

---

# Relaciones Diplomáticas

El sistema podrá administrar:

- Aliados.
- Neutrales.
- Hostiles.
- En guerra.
- Vasallaje.
- Independientes.
- Pacto comercial.
- Pacto militar.

---

# Factores de Cambio

Las relaciones podrán modificarse por:

- Eventos.
- Misiones.
- Comercio.
- Guerra.
- Traiciones.
- Tratados.
- Decisiones del jugador.
- Acciones de IA.

---

# Comunicación

El Diplomacy System se comunicará mediante:

- Eventos.
- Interfaces.
- Consultas.

Nunca modificará directamente otros Systems.

---

# Integración

Trabajará junto a:

- Kingdom System.
- Settlement System.
- Economy System.
- Quest System.
- AI System.
- Event System.
- World System.
- Resource System.
- Time System.
- Multiplayer System.

---

# Multiplayer

El servidor será la autoridad sobre todas las relaciones diplomáticas.

Los clientes recibirán únicamente los cambios sincronizados.

---

# Rendimiento

El Diplomacy System deberá:

- Procesar únicamente relaciones activas.
- Compartir Diplomacy Resources.
- Evitar cálculos repetidos.
- Minimizar consultas entre Systems.
- Mantener una simulación determinista.

---

# Eventos

Ejemplos:

- AllianceCreated
- AllianceBroken
- WarDeclared
- PeaceSigned
- TreatyAccepted
- DiplomacyUpdated

---

# Convenciones

Toda relación diplomática deberá:

- Tener un identificador único.
- Poder serializarse.
- Mantener consistencia entre cliente y servidor.
- Ser determinista.
- Basarse en Diplomacy Resources.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Diplomacy System desacoplado del Combat System.
- Configurar relaciones mediante Diplomacy Resources.
- Utilizar eventos para comunicar cambios.
- Evitar lógica específica para cada facción.
- Favorecer una arquitectura orientada a eventos.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar dependencias innecesarias.
- Verificar consistencia de relaciones.
- Detectar lógica duplicada.
- Validar sincronización multijugador.
- Revisar rendimiento del sistema.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado encargado de administrar todas las relaciones diplomáticas del juego, coordinando alianzas, guerras, tratados y reputación mediante una arquitectura ECS, Data Driven y completamente desacoplada.

---

# DEC propuesta

## DEC – El Diplomacy System administrará exclusivamente las relaciones diplomáticas

### Decisión

El Diplomacy System será responsable únicamente del estado y evolución de las relaciones entre organizaciones del mundo. Las consecuencias económicas, militares o territoriales serán responsabilidad de los Systems especializados.

### Justificación

- Mantiene el principio de responsabilidad única.
- Evita acoplamiento entre diplomacia, combate y economía.
- Facilita la incorporación de nuevas mecánicas diplomáticas.
- Mejora la mantenibilidad del sistema.
- Refuerza la arquitectura ECS y Data Driven.
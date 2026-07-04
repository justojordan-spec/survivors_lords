# Kingdom System

**Estado:** Draft

---

# Objetivo

El Kingdom System es responsable de administrar los reinos y sus relaciones dentro de Survivors Lords.

Su propósito es gestionar la organización política, territorial y administrativa de cada reino, coordinando su interacción con asentamientos, facciones y diplomacia.

No administra economía, combate ni tecnologías.

---

# Filosofía

Un reino representa una organización política que agrupa uno o más asentamientos.

El Kingdom System administra exclusivamente la estructura y el estado de los reinos.

Toda la configuración será completamente Data Driven mediante Kingdom Resources.

---

# Responsabilidades

El Kingdom System será responsable de:

- Crear reinos.
- Disolver reinos.
- Administrar territorios.
- Gestionar asentamientos.
- Gestionar gobernantes.
- Administrar población del reino.
- Gestionar relaciones internas.
- Notificar cambios administrativos.

---

# No es responsable de

El Kingdom System NO debe:

- Administrar diplomacia.
- Gestionar economía.
- Resolver combates.
- Ejecutar IA.
- Administrar tecnologías.
- Gestionar profesiones.
- Administrar interfaz.

Estas responsabilidades pertenecen a sus respectivos Systems.

---

# Organización

Cada reino podrá definir:

- Capital.
- Gobernante.
- Asentamientos.
- Territorios.
- Población.
- Recursos estratégicos.
- Nivel de desarrollo.

---

# Estados

Un reino podrá encontrarse en:

- En desarrollo.
- Estable.
- En expansión.
- En crisis.
- En guerra.
- Colapsado.

---

# Comunicación

El Kingdom System se comunicará mediante:

- Eventos.
- Interfaces.
- Consultas.

Nunca modificará directamente otros Systems.

---

# Integración

Trabajará junto a:

- Settlement System.
- Diplomacy System.
- Economy System.
- Technology System.
- Research System.
- Profession System.
- World System.
- Resource System.
- Time System.
- Multiplayer System.

---

# Multiplayer

El servidor será la autoridad sobre todos los reinos y su organización.

Los clientes únicamente recibirán el estado sincronizado de cada reino.

---

# Rendimiento

El Kingdom System deberá:

- Procesar únicamente reinos activos.
- Compartir Kingdom Resources.
- Evitar cálculos repetidos.
- Minimizar consultas entre Systems.
- Mantener una simulación determinista.

---

# Eventos

Ejemplos:

- KingdomCreated
- KingdomDestroyed
- SettlementAdded
- SettlementRemoved
- CapitalChanged
- KingdomStateChanged

---

# Convenciones

Todo reino deberá:

- Referenciar un Kingdom Resource.
- Tener un identificador único.
- Poder serializarse.
- Mantener consistencia entre cliente y servidor.
- Ser determinista.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Kingdom System desacoplado del Diplomacy System.
- Configurar todos los reinos mediante Kingdom Resources.
- Gestionar únicamente la estructura administrativa.
- Utilizar eventos para comunicar cambios.
- Evitar lógica específica de cada reino.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar dependencias innecesarias.
- Verificar consistencia territorial.
- Detectar lógica duplicada.
- Validar sincronización multijugador.
- Revisar rendimiento del sistema.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado encargado de administrar la organización de los reinos del juego, coordinando su estructura política y territorial mediante una arquitectura ECS, Data Driven y completamente desacoplada.

---

# DEC propuesta

## DEC – El Kingdom System administrará únicamente la organización de los reinos

### Decisión

El Kingdom System será responsable exclusivamente de la estructura administrativa y territorial de los reinos. La diplomacia, economía, investigación, combate y demás mecánicas serán responsabilidad de los Systems especializados.

### Justificación

- Mantiene el principio de responsabilidad única.
- Evita acoplamiento entre política, economía y combate.
- Facilita la incorporación de nuevos tipos de reinos.
- Mejora la escalabilidad del sistema.
- Refuerza la arquitectura ECS y Data Driven.
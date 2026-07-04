# Ability System

**Estado:** Draft

---

# Objetivo

El Ability System es responsable de administrar todas las habilidades disponibles en Survivors Lords.

Su propósito es gestionar la activación, ejecución, duración, enfriamiento y restricciones de las habilidades utilizadas por jugadores, NPC y otras entidades.

No administra combate, inventarios ni efectos permanentes.

---

# Filosofía

Las habilidades representan acciones especiales que una entidad puede ejecutar.

El Ability System coordina su utilización, mientras que otros Systems aplican las consecuencias correspondientes.

Toda la configuración será completamente Data Driven mediante Ability Resources.

---

# Responsabilidades

El Ability System será responsable de:

- Registrar habilidades.
- Activar habilidades.
- Validar requisitos.
- Gestionar tiempos de reutilización (Cooldown).
- Gestionar duración.
- Gestionar costos.
- Cancelar habilidades.
- Notificar la ejecución de habilidades.

---

# No es responsable de

El Ability System NO debe:

- Calcular daño.
- Aplicar efectos permanentes.
- Administrar inventarios.
- Ejecutar IA.
- Gestionar animaciones.
- Reproducir sonidos.
- Administrar interfaz.

Estas responsabilidades pertenecen a sus respectivos Systems.

---

# Tipos de Habilidades

El sistema podrá administrar:

- Activas.
- Pasivas.
- Canalizadas.
- Instantáneas.
- Permanentes.
- Temporales.
- De combate.
- De construcción.
- De exploración.

---

# Requisitos

Las habilidades podrán depender de:

- Nivel.
- Profesión.
- Tecnología.
- Recursos.
- Equipamiento.
- Energía.
- Mana.
- Estados.
- Cooldown.

---

# Costos

Una habilidad podrá consumir:

- Energía.
- Mana.
- Vida.
- Munición.
- Recursos.
- Objetos.

---

# Estados

Cada habilidad podrá encontrarse en:

- Disponible.
- En ejecución.
- En cooldown.
- Cancelada.
- Bloqueada.

---

# Comunicación

El Ability System se comunicará mediante:

- Eventos.
- Interfaces.
- Consultas.

Nunca modificará directamente otros Systems.

---

# Integración

Trabajará junto a:

- Combat System.
- Effect System.
- Player System.
- Enemy System.
- Inventory System.
- Item System.
- Technology System.
- Research System.
- Time System.
- UI System.
- Audio System.
- Multiplayer System.

---

# Multiplayer

El servidor será la autoridad sobre la activación y resolución de habilidades.

Los clientes únicamente enviarán solicitudes de uso y recibirán el resultado sincronizado.

---

# Rendimiento

El Ability System deberá:

- Procesar únicamente habilidades activas.
- Compartir Ability Resources.
- Evitar cálculos duplicados.
- Gestionar eficientemente los cooldowns.
- Mantener una simulación determinista.

---

# Eventos

Ejemplos:

- AbilityActivated
- AbilityFinished
- AbilityCancelled
- AbilityCooldownStarted
- AbilityCooldownFinished
- AbilityUnlocked

---

# Convenciones

Toda habilidad deberá:

- Referenciar un Ability Resource.
- Tener un identificador único.
- Poder serializarse.
- Ser determinista.
- Mantener consistencia entre cliente y servidor.

---

# Consideraciones para Claude

Al generar código:

- Mantener Ability System desacoplado del Combat System.
- Utilizar Ability Resources para toda configuración.
- Gestionar cooldowns mediante Time System.
- Favorecer una arquitectura basada en eventos.
- Evitar lógica específica de cada habilidad dentro del sistema.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar lógica de combate dentro del Ability System.
- Verificar cooldowns.
- Detectar dependencias innecesarias.
- Validar sincronización multijugador.
- Revisar rendimiento del sistema.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado encargado de administrar todas las habilidades del juego, coordinando su activación, restricciones y ciclo de vida mediante una arquitectura ECS, Data Driven y completamente desacoplada.

---

# DEC propuesta

## DEC – El Ability System administrará únicamente el ciclo de vida de las habilidades

### Decisión

El Ability System será responsable exclusivamente de la activación, validación, duración y finalización de las habilidades. Los efectos producidos por estas serán ejecutados por los Systems correspondientes, como Combat System, Effect System o Building System.

### Justificación

- Mantiene el principio de responsabilidad única.
- Reduce el acoplamiento entre Systems.
- Facilita la incorporación de nuevas habilidades.
- Mejora la reutilización de la lógica.
- Refuerza la arquitectura ECS y Data Driven.
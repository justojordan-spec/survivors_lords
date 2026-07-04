# Combat System

**Estado:** Draft

---

# Objetivo

El Combat System es responsable de administrar toda la lógica de combate de Survivors Lords.

Su propósito es coordinar los ataques, el daño, la defensa, los efectos temporales y la resolución de los enfrentamientos entre entidades.

No administra inventarios, habilidades ni IA.

---

# Filosofía

El combate deberá ser completamente desacoplado del resto de los Systems.

El Combat System resolverá únicamente las reglas del combate, utilizando información proporcionada por otros Systems.

Toda la configuración será Data Driven mediante Resources y Components.

---

# Responsabilidades

El Combat System será responsable de:

- Resolver ataques.
- Resolver defensa.
- Calcular daño.
- Aplicar modificadores.
- Gestionar golpes críticos.
- Gestionar bloqueos.
- Gestionar esquivas.
- Administrar alcance de ataques.
- Gestionar daño continuo.
- Resolver muerte en combate.

---

# No es responsable de

El Combat System NO debe:

- Administrar inventarios.
- Ejecutar IA.
- Gestionar animaciones.
- Reproducir sonidos.
- Administrar habilidades.
- Aplicar efectos permanentes.
- Gestionar la interfaz.

Estas responsabilidades pertenecen a sus respectivos Systems.

---

# Tipos de Combate

El sistema podrá soportar:

- Combate cuerpo a cuerpo.
- Combate a distancia.
- Combate mágico.
- Daño ambiental.
- Daño por trampas.
- Combate contra estructuras.

---

# Daño

El cálculo podrá considerar:

- Daño base.
- Defensa.
- Armadura.
- Resistencia.
- Multiplicadores.
- Bonificaciones.
- Penalizaciones.
- Nivel.
- Distancia.

---

# Estados del Combate

Las entidades podrán encontrarse en:

- Fuera de combate.
- En combate.
- Atacando.
- Defendiendo.
- Aturdido.
- Derribado.
- Muerto.

---

# Comunicación

El Combat System se comunicará mediante:

- Eventos.
- Interfaces.
- Consultas.

Nunca modificará directamente otros Systems.

---

# Integración

Trabajará junto a:

- Entity System.
- Component System.
- Resource System.
- Player System.
- Enemy System.
- Ability System.
- Effect System.
- Inventory System.
- Item System.
- Time System.
- Audio System.
- UI System.
- Multiplayer System.

---

# Multiplayer

El servidor será la autoridad sobre toda resolución de combate.

Los clientes únicamente enviarán solicitudes de acciones y recibirán los resultados sincronizados.

---

# Rendimiento

El Combat System deberá:

- Evitar cálculos duplicados.
- Procesar únicamente entidades activas.
- Reducir consultas innecesarias.
- Compartir datos mediante Components.
- Mantener una simulación determinista.

---

# Eventos

Ejemplos:

- CombatStarted
- CombatEnded
- AttackPerformed
- DamageApplied
- CriticalHit
- BlockSucceeded
- DodgeSucceeded
- EntityKilled

---

# Convenciones

Toda acción de combate deberá:

- Ser determinista.
- Poder serializarse.
- Ser reproducible.
- Mantener consistencia entre cliente y servidor.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Combat System desacoplado.
- Obtener información mediante Components.
- Utilizar Resources para configurar armas, habilidades y efectos.
- Evitar lógica específica de entidades.
- Favorecer una arquitectura orientada a eventos.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar lógica duplicada.
- Verificar cálculos de daño.
- Detectar dependencias innecesarias.
- Validar sincronización multijugador.
- Revisar rendimiento del sistema.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado encargado de resolver todas las interacciones de combate del juego, proporcionando una simulación consistente, determinista y desacoplada del resto de los Systems.

---

# DEC propuesta

## DEC – El Combat System será el único responsable de resolver el combate

### Decisión

Toda resolución de ataques, daño, defensa y muerte será responsabilidad exclusiva del Combat System. Los demás Systems únicamente proporcionarán datos o reaccionarán a los eventos generados.

### Justificación

- Centraliza toda la lógica de combate.
- Evita cálculos inconsistentes.
- Facilita el balance del juego.
- Mejora la sincronización en multijugador.
- Mantiene la arquitectura ECS y Data Driven.
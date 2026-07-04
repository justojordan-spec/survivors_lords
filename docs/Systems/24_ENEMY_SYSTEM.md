# Enemy System

**Estado:** Draft

---

# Objetivo

El Enemy System es responsable de administrar todas las entidades enemigas de Survivors Lords.

Su propósito es coordinar su comportamiento general, ciclo de vida, aparición y relación con los demás Systems del juego, manteniendo una arquitectura ECS, modular y completamente Data Driven.

No administra IA, combate ni botín.

---

# Filosofía

Los enemigos son entidades del mundo que pueden interactuar con jugadores, NPC, estructuras y el entorno.

El Enemy System administra exclusivamente su ciclo de vida y organización, mientras que los comportamientos específicos serán responsabilidad de Systems especializados.

Toda la configuración será completamente Data Driven mediante Enemy Resources.

---

# Responsabilidades

El Enemy System será responsable de:

- Crear enemigos.
- Registrar enemigos.
- Eliminar enemigos.
- Administrar estados generales.
- Gestionar aparición (Spawn).
- Gestionar desaparición (Despawn).
- Administrar facciones enemigas.
- Gestionar niveles de dificultad.
- Notificar cambios de estado.

---

# No es responsable de

El Enemy System NO debe:

- Ejecutar IA.
- Resolver combate.
- Generar botín.
- Administrar inventarios.
- Gestionar animaciones.
- Reproducir sonidos.
- Administrar interfaz.

Estas responsabilidades pertenecen a sus respectivos Systems.

---

# Tipos de Enemigos

El sistema podrá administrar:

- Criaturas salvajes.
- Humanos hostiles.
- Monstruos.
- Jefes (Bosses).
- Criaturas élite.
- Criaturas invocadas.
- Eventos especiales.

---

# Estados

Los enemigos podrán encontrarse en:

- Inactivo.
- Patrullando.
- Alerta.
- Persiguiendo.
- En combate.
- Huyendo.
- Muerto.
- Desaparecido.

---

# Spawn

El sistema podrá gestionar:

- Spawn natural.
- Spawn por eventos.
- Spawn por estructuras.
- Spawn por oleadas.
- Respawn.
- Spawn dinámico según dificultad.

---

# Comunicación

El Enemy System se comunicará mediante:

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
- Combat System.
- AI System.
- Loot System.
- World System.
- Weather System.
- Time System.
- Settlement System.
- Audio System.
- Multiplayer System.

---

# Multiplayer

El servidor será la autoridad sobre todos los enemigos.

Los clientes recibirán únicamente el estado sincronizado de las entidades enemigas.

---

# Rendimiento

El Enemy System deberá:

- Procesar únicamente enemigos activos.
- Compartir Enemy Resources.
- Evitar consultas innecesarias.
- Optimizar el Spawn y Despawn.
- Mantener una simulación determinista.

---

# Eventos

Ejemplos:

- EnemySpawned
- EnemyDespawned
- EnemyActivated
- EnemyDefeated
- EnemyRespawned
- EnemyStateChanged

---

# Convenciones

Todo enemigo deberá:

- Referenciar un Enemy Resource.
- Tener un identificador único.
- Poder serializarse.
- Mantener consistencia entre cliente y servidor.
- Ser determinista.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Enemy System desacoplado del Combat System y del AI System.
- Configurar todos los enemigos mediante Enemy Resources.
- Gestionar únicamente el ciclo de vida de los enemigos.
- Utilizar eventos para comunicar cambios.
- Favorecer una arquitectura basada en ECS y eventos.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar dependencias innecesarias.
- Verificar consistencia del Spawn.
- Detectar lógica de IA dentro del Enemy System.
- Validar sincronización multijugador.
- Revisar rendimiento del sistema.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado encargado de administrar todas las entidades enemigas del juego, coordinando su ciclo de vida, aparición y organización mediante una arquitectura ECS, Data Driven y completamente desacoplada.

---

# DEC propuesta

## DEC – El Enemy System administrará únicamente el ciclo de vida de los enemigos

### Decisión

El Enemy System será responsable exclusivamente de la creación, registro, activación y eliminación de las entidades enemigas. La IA, el combate, el botín y otros comportamientos especializados serán responsabilidad de los Systems correspondientes.

### Justificación

- Mantiene el principio de responsabilidad única.
- Evita el acoplamiento entre IA, combate y gestión de entidades.
- Facilita la incorporación de nuevos tipos de enemigos.
- Mejora la mantenibilidad y escalabilidad del sistema.
- Refuerza la arquitectura ECS y Data Driven.
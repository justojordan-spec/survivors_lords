# Entity System

**Estado:** Draft

---

# Objetivo

El Entity System es responsable de crear, registrar, administrar y destruir todas las entidades existentes dentro de Survivors Lords.

Su propósito es proporcionar una identidad única para cada objeto de la simulación, permitiendo que los Components y Systems trabajen sobre ellas siguiendo la arquitectura ECS (Entity Component System).

No administra Components ni ejecuta lógica de gameplay.

---

# Filosofía

Las entidades representan únicamente una identidad.

No contienen datos ni comportamiento.

Toda la información pertenece a los Components y toda la lógica pertenece a los Systems.

---

# Responsabilidades

El Entity System será responsable de:

- Crear entidades.
- Destruir entidades.
- Asignar IDs únicos.
- Registrar entidades.
- Consultar entidades.
- Mantener el ciclo de vida de las entidades.
- Reciclar IDs cuando corresponda.

---

# No es responsable de

El Entity System NO debe:

- Administrar Components.
- Ejecutar IA.
- Resolver combate.
- Administrar inventarios.
- Procesar físicas.
- Ejecutar habilidades.
- Guardar partidas.

---

# Entidades

El sistema administrará entidades como:

- Jugadores.
- NPCs.
- Enemigos.
- Animales.
- Objetos.
- Construcciones.
- Proyectiles.
- Vehículos.
- Recursos del mundo.

---

# Ciclo de Vida

Toda entidad podrá pasar por los siguientes estados:

- Creada.
- Activa.
- Desactivada.
- Pendiente de eliminación.
- Eliminada.

---

# Operaciones

El sistema permitirá:

- CreateEntity
- DestroyEntity
- IsValidEntity
- Exists
- GetEntity
- EnumerateEntities

---

# Identificación

Cada entidad deberá poseer:

- Entity ID único.
- Estado.
- Tiempo de creación.
- Información mínima de registro.

---

# Comunicación

Los demás Systems utilizarán el Entity System para obtener y validar entidades.

Nunca crearán IDs manualmente.

---

# Integración

Será utilizado por:

- Component System.
- Player System.
- Combat System.
- Inventory System.
- Building System.
- AI System.
- Save System.
- Multiplayer System.

---

# Multiplayer

El servidor será responsable de la creación y destrucción de entidades.

Los clientes recibirán la sincronización correspondiente.

---

# Rendimiento

El Entity System deberá:

- Crear entidades rápidamente.
- Permitir millones de IDs si fuese necesario.
- Evitar fragmentación.
- Reciclar IDs de forma segura.
- Minimizar asignaciones de memoria.

---

# Eventos

Ejemplos:

- EntityCreated
- EntityDestroyed
- EntityActivated
- EntityDeactivated

---

# Convenciones

Toda entidad deberá:

- Tener un ID único.
- No contener datos.
- No contener lógica.
- Ser administrada exclusivamente por el Entity System.

---

# Consideraciones para Claude

Al generar código:

- Mantener las entidades como identificadores simples.
- Evitar almacenar información dentro de las entidades.
- Optimizar la creación y destrucción.
- Mantener compatibilidad con ECS.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar datos almacenados dentro de entidades.
- Verificar unicidad de IDs.
- Detectar creación manual de entidades.
- Validar el ciclo de vida.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado encargado exclusivamente de administrar el ciclo de vida de todas las entidades del juego, proporcionando identificadores únicos y desacoplando completamente la identidad de los datos y la lógica conforme a la arquitectura ECS.
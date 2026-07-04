# Component System

**Estado:** Draft

---

# Objetivo

El Component System es responsable de administrar todos los Components asociados a las entidades dentro de Survivors Lords.

Su propósito es registrar, agregar, eliminar, consultar y mantener los Components durante la simulación, siguiendo la arquitectura ECS (Entity Component System).

No ejecuta lógica de gameplay.

---

# Filosofía

Los Components representan únicamente datos.

El Component System administra su ciclo de vida y proporciona acceso eficiente a ellos.

Toda la lógica que utiliza estos datos pertenece a los distintos Gameplay Systems.

---

# Responsabilidades

El Component System será responsable de:

- Registrar tipos de Components.
- Agregar Components a entidades.
- Eliminar Components.
- Consultar Components.
- Verificar existencia de Components.
- Gestionar almacenamiento.
- Optimizar acceso.
- Mantener consistencia.

---

# No es responsable de

El Component System NO debe:

- Ejecutar IA.
- Resolver combate.
- Modificar estadísticas.
- Ejecutar habilidades.
- Administrar inventarios.
- Procesar físicas.
- Ejecutar lógica de negocio.

---

# Tipos de Components

El sistema administrará todos los Components del proyecto.

Ejemplos:

- Character Component
- Stats Component
- Health Component
- Inventory Component
- Equipment Component
- Ability Component
- Building Component
- Kingdom Component
- Settlement Component
- Technology Component
- Research Component

---

# Operaciones

Permitirá:

- AddComponent
- RemoveComponent
- HasComponent
- GetComponent
- ReplaceComponent
- CopyComponent

---

# Consultas

Permitirá obtener:

- Component por entidad.
- Todas las entidades con un Component.
- Todas las entidades con múltiples Components.
- Conteo de Components.
- Componentes registrados.

---

# Comunicación

Los Gameplay Systems accederán a los Components únicamente mediante el Component System.

Nunca accederán directamente al almacenamiento interno.

---

# Integración

Será utilizado por:

- Entity System
- Combat System
- Inventory System
- Equipment System
- Building System
- Character System
- AI System
- UI System
- Save System

---

# Multiplayer

El servidor será responsable de sincronizar los cambios de Components.

El Component System únicamente administra los datos.

---

# Rendimiento

El Component System deberá:

- Mantener acceso O(1) cuando sea posible.
- Minimizar asignaciones de memoria.
- Evitar duplicaciones.
- Optimizar consultas frecuentes.

---

# Eventos

Ejemplos:

- ComponentAdded
- ComponentRemoved
- ComponentUpdated
- ComponentRegistered

---

# Convenciones

Todo Component deberá:

- Contener únicamente datos.
- No contener lógica.
- Ser reutilizable.
- Ser serializable.

---

# Consideraciones para Claude

Al generar código:

- Mantener separación estricta entre datos y lógica.
- Optimizar el acceso mediante estructuras eficientes.
- Evitar dependencias entre Components.
- Favorecer la reutilización.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar lógica dentro de Components.
- Verificar consultas eficientes.
- Detectar duplicación de datos.
- Validar el cumplimiento de la arquitectura ECS.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado que administre todos los Components del proyecto, proporcionando almacenamiento eficiente, consultas rápidas y una separación estricta entre datos y lógica, conforme a la arquitectura ECS de Survivors Lords.
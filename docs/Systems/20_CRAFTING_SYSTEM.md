# Crafting System

**Estado:** Draft

---

# Objetivo

El Crafting System es responsable de administrar toda la fabricación de objetos en Survivors Lords.

Su propósito es validar recetas, consumir materiales y generar nuevos objetos mediante una arquitectura completamente Data Driven.

No administra inventarios, Items ni tecnologías.

---

# Filosofía

El Crafting System coordina el proceso de fabricación.

Las recetas definirán los requisitos y resultados, mientras que los Items serán creados por el Item System y almacenados mediante el Inventory System.

Toda la configuración será completamente Data Driven mediante Recipe Resources.

---

# Responsabilidades

El Crafting System será responsable de:

- Validar recetas.
- Verificar materiales.
- Consumir recursos.
- Iniciar procesos de fabricación.
- Cancelar fabricación.
- Finalizar fabricación.
- Administrar tiempos de fabricación.
- Desbloquear recetas disponibles.

---

# No es responsable de

El Crafting System NO debe:

- Crear Items directamente.
- Administrar inventarios.
- Gestionar tecnologías.
- Resolver economía.
- Ejecutar combate.
- Administrar interfaz.
- Gestionar profesiones.

Estas responsabilidades pertenecen a sus respectivos Systems.

---

# Tipos de Fabricación

El sistema podrá administrar:

- Fabricación manual.
- Fabricación en estaciones de trabajo.
- Fabricación automática.
- Fabricación en edificios.
- Fabricación en cadena.

---

# Requisitos

Cada receta podrá requerir:

- Materiales.
- Herramientas.
- Estación de trabajo.
- Profesión.
- Tecnología.
- Nivel.
- Energía.
- Tiempo.

---

# Resultados

Una receta podrá generar:

- Objetos.
- Materiales.
- Componentes.
- Recursos procesados.
- Subproductos.

---

# Comunicación

El Crafting System se comunicará mediante:

- Eventos.
- Interfaces.
- Consultas.

Nunca modificará directamente otros Systems.

---

# Integración

Trabajará junto a:

- Resource System.
- Recipe System.
- Item System.
- Inventory System.
- Profession System.
- Building System.
- Technology System.
- Research System.
- Economy System.
- Time System.
- UI System.
- Multiplayer System.

---

# Multiplayer

El servidor será la autoridad sobre todos los procesos de fabricación.

Los clientes únicamente solicitarán iniciar o cancelar procesos y recibirán el resultado sincronizado.

---

# Rendimiento

El Crafting System deberá:

- Compartir Recipe Resources.
- Evitar validaciones repetidas.
- Procesar únicamente recetas activas.
- Reducir consultas a inventarios.
- Mantener una simulación determinista.

---

# Eventos

Ejemplos:

- CraftStarted
- CraftCompleted
- CraftCancelled
- RecipeUnlocked
- RecipeLearned
- MaterialsConsumed

---

# Convenciones

Toda receta deberá:

- Referenciar un Recipe Resource.
- Tener un identificador único.
- Poder serializarse.
- Mantener consistencia de materiales.
- Ser determinista.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Crafting System desacoplado del Item System.
- Configurar todas las recetas mediante Recipe Resources.
- Crear Items únicamente a través del Item System.
- Utilizar eventos para comunicar el progreso.
- Gestionar tiempos mediante el Time System.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar recetas inválidas.
- Verificar consumo correcto de materiales.
- Detectar duplicación de lógica.
- Validar sincronización multijugador.
- Revisar rendimiento del sistema.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado encargado de administrar toda la fabricación del juego, validando recetas, consumiendo materiales y coordinando la creación de objetos mediante una arquitectura ECS, Data Driven y completamente desacoplada.

---

# DEC propuesta

## DEC – El Crafting System administrará únicamente el proceso de fabricación

### Decisión

El Crafting System será responsable exclusivamente de validar recetas y coordinar el proceso de fabricación. La creación de las instancias de objetos será responsabilidad del Item System y su almacenamiento corresponderá al Inventory System.

### Justificación

- Mantiene el principio de responsabilidad única.
- Evita duplicar lógica de creación de objetos.
- Facilita la incorporación de nuevas recetas y estaciones de trabajo.
- Mejora la mantenibilidad del sistema.
- Refuerza la arquitectura ECS y Data Driven.
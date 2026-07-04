# Item System

**Estado:** Draft

---

# Objetivo

El Item System es responsable de administrar todos los Items de Survivors Lords.

Su propósito es gestionar el ciclo de vida de los objetos dentro del mundo, manteniendo su identidad, estado y relación con las entidades que los poseen.

No administra inventarios, equipamiento ni crafting.

---

# Filosofía

Los Items representan instancias de objetos dentro del juego.

El Item System administra exclusivamente las instancias, mientras que toda la información estática será obtenida mediante Item Resources.

Toda la configuración será completamente Data Driven.

---

# Responsabilidades

El Item System será responsable de:

- Crear Items.
- Destruir Items.
- Registrar Items.
- Administrar estado de los Items.
- Gestionar durabilidad.
- Gestionar cantidad.
- Gestionar calidad.
- Gestionar propietarios.
- Gestionar referencias a Item Resources.

---

# No es responsable de

El Item System NO debe:

- Administrar inventarios.
- Equipar objetos.
- Resolver crafting.
- Aplicar efectos.
- Administrar economía.
- Ejecutar combate.
- Gestionar interfaz.

Estas responsabilidades pertenecen a sus respectivos Systems.

---

# Información Administrada

Cada Item podrá contener:

- Item Resource.
- Cantidad.
- Durabilidad.
- Calidad.
- Estado.
- Propietario.
- Inventario asociado.
- Entidad asociada.

---

# Estados

Los Items podrán encontrarse en:

- En el mundo.
- En inventario.
- Equipado.
- Almacenado.
- Consumido.
- Destruido.

---

# Comunicación

El Item System se comunicará mediante:

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
- Inventory System.
- Equipment System.
- Loot System.
- Crafting System.
- Economy System.
- Save System.
- Multiplayer System.

---

# Multiplayer

El servidor será la autoridad sobre todas las instancias de Items.

Los clientes recibirán únicamente las actualizaciones sincronizadas.

---

# Rendimiento

El Item System deberá:

- Compartir Item Resources.
- Evitar duplicación de datos.
- Crear únicamente instancias necesarias.
- Minimizar asignaciones de memoria.
- Mantener consultas rápidas.

---

# Eventos

Ejemplos:

- ItemCreated
- ItemDestroyed
- ItemUpdated
- ItemMoved
- ItemConsumed
- ItemDamaged
- ItemRepaired

---

# Convenciones

Todo Item deberá:

- Referenciar un Item Resource.
- Tener un identificador único.
- Poder serializarse.
- Mantener consistencia con el Inventory System.
- Ser determinista.

---

# Consideraciones para Claude

Al generar código:

- Mantener separación entre Item e Inventory.
- Utilizar Item Resources para la información estática.
- Evitar duplicación de datos.
- Mantener referencias mediante IDs.
- Favorecer una arquitectura orientada a eventos.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar duplicación de información.
- Verificar referencias a Item Resources.
- Detectar inconsistencias entre Item e Inventory.
- Validar sincronización multijugador.
- Revisar rendimiento del sistema.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado encargado de administrar todas las instancias de objetos del juego, manteniendo su identidad, estado y relación con las entidades mediante una arquitectura ECS, Data Driven y completamente desacoplada.

---

# DEC propuesta

## DEC – El Item System administrará únicamente las instancias de Items

### Decisión

El Item System será responsable exclusivamente del ciclo de vida de las instancias de Items. La información estática será obtenida desde Item Resources, mientras que el almacenamiento, equipamiento, crafting y economía serán responsabilidad de los Systems especializados.

### Justificación

- Mantiene el principio de responsabilidad única.
- Evita duplicación de datos.
- Facilita la serialización y sincronización.
- Mejora la escalabilidad del sistema.
- Refuerza la arquitectura ECS y Data Driven.
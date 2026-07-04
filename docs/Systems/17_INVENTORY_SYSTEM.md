# Inventory System

**Estado:** Draft

---

# Objetivo

El Inventory System es responsable de administrar todos los inventarios de Survivors Lords.

Su propósito es gestionar el almacenamiento, organización y transferencia de objetos entre entidades, contenedores y estructuras, manteniendo una arquitectura desacoplada y Data Driven.

No administra los datos de los objetos ni sus efectos.

---

# Filosofía

Los inventarios representan contenedores de Items.

El Inventory System administra exclusivamente dónde se encuentran los objetos y cómo se mueven entre inventarios.

Toda la información de los objetos será obtenida mediante Item Resources.

---

# Responsabilidades

El Inventory System será responsable de:

- Crear inventarios.
- Administrar espacios.
- Agregar objetos.
- Remover objetos.
- Transferir objetos.
- Dividir pilas.
- Unificar pilas.
- Verificar capacidad.
- Ordenar inventarios.
- Gestionar contenedores.

---

# No es responsable de

El Inventory System NO debe:

- Crear Items.
- Administrar Equipamiento.
- Resolver Crafting.
- Aplicar efectos.
- Ejecutar combate.
- Gestionar economía.
- Administrar interfaz.

Estas responsabilidades pertenecen a sus respectivos Systems.

---

# Tipos de Inventario

El sistema podrá administrar:

- Inventario del jugador.
- Inventario de NPC.
- Inventario de enemigos.
- Cofres.
- Almacenes.
- Edificios.
- Vehículos.
- Contenedores temporales.
- Inventarios compartidos.

---

# Operaciones

El sistema permitirá:

- Mover objetos.
- Intercambiar objetos.
- Apilar objetos.
- Separar pilas.
- Buscar objetos.
- Filtrar objetos.
- Ordenar automáticamente.

---

# Capacidad

Cada inventario podrá definir:

- Número de espacios.
- Peso máximo.
- Volumen máximo.
- Restricciones por tipo.
- Restricciones por categoría.

---

# Comunicación

El Inventory System se comunicará mediante:

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
- Item System.
- Equipment System.
- Loot System.
- Crafting System.
- Building System.
- Economy System.
- UI System.
- Save System.
- Multiplayer System.

---

# Multiplayer

El servidor será la autoridad sobre todos los inventarios.

Los clientes únicamente solicitarán operaciones de inventario y recibirán el estado sincronizado.

---

# Rendimiento

El Inventory System deberá:

- Evitar búsquedas innecesarias.
- Compartir referencias a Item Resources.
- Minimizar copias de datos.
- Procesar únicamente inventarios modificados.
- Mantener operaciones deterministas.

---

# Eventos

Ejemplos:

- InventoryCreated
- InventoryOpened
- InventoryClosed
- ItemAdded
- ItemRemoved
- ItemTransferred
- InventorySorted

---

# Convenciones

Todo inventario deberá:

- Tener un identificador único.
- Poder serializarse.
- Mantener consistencia de Items.
- Ser determinista.
- Mantener sincronización entre cliente y servidor.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Inventory System desacoplado del Item System.
- Utilizar únicamente referencias a Item Resources.
- Evitar duplicación de Items.
- Favorecer operaciones mediante eventos.
- Optimizar búsquedas y transferencias.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar duplicación de Items.
- Verificar consistencia de inventarios.
- Detectar referencias inválidas.
- Validar sincronización multijugador.
- Revisar rendimiento de búsquedas.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado encargado de administrar todos los inventarios del juego, proporcionando almacenamiento, organización y transferencia de objetos mediante una arquitectura ECS, Data Driven y completamente desacoplada.

---

# DEC propuesta

## DEC – El Inventory System administrará únicamente el almacenamiento de Items

### Decisión

El Inventory System será responsable exclusivamente del almacenamiento y movimiento de Items entre inventarios. La creación de objetos, su equipamiento, sus efectos y su utilización serán responsabilidad de los Systems especializados.

### Justificación

- Mantiene el principio de responsabilidad única.
- Evita acoplamiento entre inventario, equipamiento y crafting.
- Facilita la incorporación de nuevos tipos de inventarios.
- Mejora el rendimiento mediante referencias a Item Resources.
- Refuerza la arquitectura ECS y Data Driven.
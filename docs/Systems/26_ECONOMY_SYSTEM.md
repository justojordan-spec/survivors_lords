# Multiplayer System

**Estado:** Draft

---

# Objetivo

El Multiplayer System es responsable de administrar toda la comunicación en red de Survivors Lords.

Su propósito es sincronizar el estado del juego entre clientes y servidor, garantizando consistencia, seguridad y rendimiento en partidas multijugador.

No administra la lógica de gameplay.

---

# Filosofía

El Multiplayer System será la única capa responsable de la comunicación en red.

Los demás Systems únicamente enviarán o recibirán información mediante eventos, interfaces o mensajes, sin conocer los detalles de la implementación de red.

Toda la sincronización deberá ser independiente del motor gráfico.

---

# Responsabilidades

El Multiplayer System será responsable de:

- Administrar conexiones.
- Sincronizar entidades.
- Sincronizar Components.
- Replicar eventos.
- Validar mensajes.
- Gestionar clientes.
- Gestionar servidor.
- Resolver autoridad.
- Administrar sesiones.
- Gestionar desconexiones.

---

# No es responsable de

El Multiplayer System NO debe:

- Ejecutar combate.
- Administrar inventarios.
- Resolver IA.
- Gestionar economía.
- Administrar interfaz.
- Gestionar guardado.
- Administrar recursos.

Estas responsabilidades pertenecen a sus respectivos Systems.

---

# Modelo de Red

El sistema soportará:

- Cliente-Servidor.
- Servidor dedicado.
- Servidor alojado por jugador (Host).
- Sesiones privadas.
- Sesiones públicas.

---

# Autoridad

La arquitectura utilizará un modelo **Server Authoritative**.

El servidor será responsable de:

- Validar acciones.
- Resolver simulaciones.
- Sincronizar resultados.
- Mantener el estado oficial del mundo.

Los clientes actuarán únicamente como solicitantes y representarán el estado recibido.

---

# Sincronización

El sistema podrá sincronizar:

- Entidades.
- Components.
- Posiciones.
- Inventarios.
- Construcciones.
- Tiempo.
- Clima.
- Eventos.
- Estados.

---

# Comunicación

El Multiplayer System se comunicará mediante:

- Eventos.
- Interfaces.
- Mensajes de red.

Nunca accederá directamente al estado interno de otros Systems.

---

# Integración

Trabajará junto a:

- Entity System.
- Component System.
- Resource System.
- Player System.
- Combat System.
- Inventory System.
- Building System.
- Quest System.
- Economy System.
- World System.
- Time System.
- Save System.

---

# Seguridad

El sistema deberá:

- Validar todas las acciones del cliente.
- Evitar modificaciones no autorizadas.
- Detectar mensajes inválidos.
- Mantener consistencia del estado.
- Reducir posibilidades de explotación.

---

# Rendimiento

El Multiplayer System deberá:

- Reducir tráfico de red.
- Sincronizar únicamente cambios relevantes.
- Comprimir paquetes cuando corresponda.
- Utilizar replicación selectiva.
- Minimizar latencia percibida.

---

# Eventos

Ejemplos:

- ClientConnected
- ClientDisconnected
- SessionCreated
- SessionClosed
- EntityReplicated
- StateSynchronized

---

# Convenciones

Toda información sincronizada deberá:

- Poder serializarse.
- Ser determinista.
- Mantener consistencia entre cliente y servidor.
- Tener identificadores únicos.
- Validarse antes de aplicarse.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Multiplayer System desacoplado del gameplay.
- Utilizar una arquitectura Server Authoritative.
- Sincronizar únicamente los datos necesarios.
- Favorecer mensajes pequeños y eficientes.
- Evitar lógica específica de otros Systems.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar sincronizaciones innecesarias.
- Verificar autoridad del servidor.
- Detectar posibles vulnerabilidades.
- Validar consistencia de replicación.
- Revisar rendimiento de red.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado encargado de administrar toda la comunicación en red del juego, proporcionando sincronización segura, eficiente y completamente desacoplada mediante una arquitectura ECS, Data Driven y Server Authoritative.

---

# DEC propuesta

## DEC – El Multiplayer System será la única capa responsable de la comunicación en red

### Decisión

El Multiplayer System será responsable exclusivamente de la comunicación entre clientes y servidor. Los demás Systems no implementarán lógica de red; únicamente expondrán los datos necesarios para ser sincronizados.

### Justificación

- Mantiene el principio de responsabilidad única.
- Centraliza toda la comunicación de red.
- Facilita el mantenimiento y la escalabilidad.
- Mejora la seguridad mediante un modelo Server Authoritative.
- Refuerza la arquitectura ECS y Data Driven.
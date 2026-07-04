# Multiplayer System

**Estado:** Draft

---

# Objetivo

El Multiplayer System es responsable de administrar toda la infraestructura de red de Survivors Lords.

Su propósito es sincronizar el estado del juego entre clientes y servidor, garantizando consistencia, seguridad y rendimiento tanto en partidas cooperativas como competitivas.

No implementa lógica de gameplay.

---

# Filosofía

El Multiplayer System será la única capa responsable de la comunicación de red.

Los demás Systems únicamente expondrán los datos necesarios para sincronización mediante eventos e interfaces.

Toda la arquitectura seguirá un modelo **Server Authoritative**.

---

# Responsabilidades

El Multiplayer System será responsable de:

- Administrar conexiones.
- Gestionar sesiones.
- Sincronizar entidades.
- Sincronizar Components.
- Replicar eventos.
- Gestionar RPC.
- Validar acciones remotas.
- Gestionar autoridad.
- Resolver reconexiones.
- Administrar replicación.

---

# No es responsable de

El Multiplayer System NO debe:

- Resolver combate.
- Administrar IA.
- Ejecutar economía.
- Administrar inventarios.
- Gestionar clima.
- Administrar guardado.
- Ejecutar lógica de gameplay.

Estas responsabilidades pertenecen a sus respectivos Systems.

---

# Modelo de Red

El sistema soportará:

- Cliente-Servidor.
- Servidor Dedicado.
- Host + Clientes.
- Partidas privadas.
- Partidas públicas.

La arquitectura utilizará autoridad completa del servidor.

---

# Sincronización

El sistema podrá sincronizar:

- Entidades.
- Components.
- Posiciones.
- Estados.
- Inventarios.
- Construcciones.
- Eventos.
- Tiempo.
- Clima.

---

# Autoridad

El servidor será responsable de:

- Validar acciones.
- Resolver simulaciones.
- Mantener el estado oficial.
- Detectar inconsistencias.
- Replicar resultados.

Los clientes actuarán únicamente como representación del estado recibido.

---

# Comunicación

El Multiplayer System se comunicará mediante:

- Eventos.
- Interfaces.
- Mensajes de red.
- RPC.

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
- World System.
- Time System.
- Weather System.
- Save System.

---

# Seguridad

El sistema deberá:

- Validar todas las acciones remotas.
- Evitar modificaciones del cliente.
- Detectar paquetes inválidos.
- Limitar acciones sospechosas.
- Mantener consistencia del mundo.

---

# Rendimiento

El Multiplayer System deberá:

- Sincronizar únicamente cambios.
- Reducir tráfico de red.
- Priorizar entidades relevantes.
- Utilizar compresión cuando corresponda.
- Minimizar la latencia percibida.

---

# Eventos

Ejemplos:

- ClientConnected
- ClientDisconnected
- SessionCreated
- SessionClosed
- EntityReplicated
- StateSynchronized
- AuthorityTransferred

---

# Convenciones

Toda información sincronizada deberá:

- Poder serializarse.
- Tener identificadores únicos.
- Mantener consistencia entre cliente y servidor.
- Ser determinista.
- Validarse antes de aplicarse.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Multiplayer System desacoplado del gameplay.
- Implementar un modelo Server Authoritative.
- Sincronizar únicamente los datos necesarios.
- Favorecer mensajes pequeños y eficientes.
- Utilizar eventos para comunicar cambios.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar sincronizaciones innecesarias.
- Verificar autoridad del servidor.
- Detectar vulnerabilidades.
- Validar consistencia de replicación.
- Revisar rendimiento de red.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado encargado de administrar toda la comunicación de red del juego, proporcionando sincronización segura, eficiente y completamente desacoplada mediante una arquitectura ECS, Data Driven y Server Authoritative.

---

# DEC propuesta

## DEC – El Multiplayer System será la única capa responsable de la comunicación en red

### Decisión

Toda la comunicación entre clientes y servidor será gestionada exclusivamente por el Multiplayer System. Los demás Systems no implementarán lógica de red y expondrán únicamente los datos necesarios para su sincronización.

### Justificación

- Mantiene el principio de responsabilidad única.
- Centraliza toda la infraestructura de red.
- Facilita la escalabilidad del multijugador.
- Mejora la seguridad mediante un modelo Server Authoritative.
- Refuerza la arquitectura ECS y Data Driven.
# 12 - MULTIPLAYER IMPLEMENTATION

# Parte 1 — Arquitectura General

---

# Objetivo

Este documento define la implementación completa de la infraestructura Multiplayer del Framework ECS de **Survivors Lords**.

No describe gameplay.

No describe combate.

No describe IA.

No describe mecánicas.

Define exclusivamente cómo implementar la infraestructura de red que permitirá sincronizar el Runtime ECS entre múltiples instancias utilizando Godot 4.4 y GDScript.

Toda la arquitectura se encuentra alineada con las fases anteriores del proyecto.

---

# Alcance

Este documento especifica:

- Multiplayer Bootstrap
- Network Manager
- Session Manager
- Connection Pipeline
- Authentication Pipeline
- Replication Pipeline
- Network Tick
- Snapshot Replication
- Entity Replication
- Component Replication
- Authority Model
- Ownership
- Interest Management
- Network Serialization
- RPC Infrastructure
- Event Replication
- Spawn Pipeline
- Despawn Pipeline
- Prediction
- Interpolation
- Reconciliation
- Reliability
- Debug
- Profiling
- Testing

---

# Fuera de Alcance

Este documento no define:

- Gameplay
- Sistemas de combate
- Inventarios
- IA
- Animaciones
- UI
- Save System
- Formato de paquetes

Tampoco define protocolos específicos de transporte.

La infraestructura deberá poder adaptarse a distintos backends de networking.

---

# Filosofía

El Multiplayer constituye otra infraestructura del Framework.

No pertenece al gameplay.

No pertenece a los Systems.

No pertenece a los Components.

No pertenece a los Resources.

Su responsabilidad consiste únicamente en mantener múltiples Runtime sincronizados.

---

# Modelo Arquitectónico

El proyecto utiliza un modelo:

```text
Server Authoritative
```

Toda decisión oficial ocurre en el servidor.

Los clientes representan únicamente copias sincronizadas.

---

# Principio Fundamental

Existe un único Runtime oficial.

```text
Server Runtime
```

Todo el resto son representaciones.

```text
Client Runtime
```

Nunca existen múltiples autoridades simultáneas.

---

# Arquitectura General

Conceptualmente:

```text
                 Multiplayer API
                        │
                        ▼
                 Network Manager
────────────────────────────────────────────
                        │
        ┌───────────────┼───────────────┐
        ▼               ▼               ▼
 Session Manager   Replication     RPC Layer
                        │
                        ▼
                Network Serializer
                        │
                        ▼
                Transport Backend
```

Cada módulo mantiene una única responsabilidad.

---

# Principios Arquitectónicos

La infraestructura Multiplayer debe cumplir:

- Server Authoritative
- Determinismo
- Modularidad
- Escalabilidad
- Desacoplamiento
- Baja Latencia
- Sin referencias directas entre Systems

---

# Server Authoritative

El servidor posee el estado oficial.

Ejemplo:

```text
Player Input

↓

Server

↓

Simulation

↓

Replication

↓

Clients
```

Los clientes nunca modifican directamente el mundo oficial.

---

# Determinismo

Todos los clientes deben converger hacia exactamente el mismo estado producido por el servidor.

---

# Modularidad

El Multiplayer debe poder evolucionar sin modificar:

- Systems
- Components
- Resources
- Gameplay

---

# Desacoplamiento

Ningún System conoce detalles del networking.

Toda comunicación ocurre mediante interfaces.

---

# Escalabilidad

La arquitectura debe soportar:

- servidores dedicados
- listen servers
- partidas cooperativas
- mundos persistentes
- futuras arquitecturas distribuidas

Sin modificar la API pública.

---

# Arquitectura ECS

El Multiplayer sincroniza exclusivamente:

- Entities
- Components
- Events

Nunca sincroniza Nodes.

Nunca sincroniza Scenes.

Nunca sincroniza lógica.

---

# Flujo General

Conceptualmente:

```text
Runtime

↓

Entities

↓

Components

↓

Replication

↓

Network

↓

Remote Runtime
```

---

# Estado Oficial

Únicamente el servidor posee:

- simulación oficial
- IA
- física oficial
- decisiones finales
- validación

---

# Estado del Cliente

El cliente mantiene:

- representación visual
- predicción local
- interpolación
- presentación

Nunca autoridad.

---

# Runtime Compartido

Todos los participantes ejecutan exactamente la misma arquitectura ECS.

Únicamente cambia la autoridad.

---

# Network Manager

## Responsabilidad

El Network Manager constituye la fachada pública del sistema Multiplayer.

Coordina:

- conexiones
- desconexiones
- replicación
- RPC
- sincronización

Nunca procesa gameplay.

---

# Session Manager

## Responsabilidad

Gestionar:

- sesiones
- jugadores
- conexión
- desconexión
- estado de la partida

No replica Components.

---

# Replication Layer

## Responsabilidad

Sincronizar el estado ECS.

Conceptualmente:

```text
Server ECS

↓

Replication

↓

Client ECS
```

---

# RPC Layer

## Responsabilidad

Transmitir mensajes puntuales.

Ejemplos:

- comandos
- solicitudes
- respuestas
- eventos

No sincroniza estado continuo.

---

# Network Serializer

## Responsabilidad

Convertir datos ECS a un formato transmisible.

Nunca conoce gameplay.

Nunca interpreta lógica.

---

# Transport Layer

## Responsabilidad

Enviar y recibir paquetes.

Toda implementación concreta permanece encapsulada.

---

# Integración con ECS

El Multiplayer interactúa únicamente mediante:

- Entity Registry
- Component Registry
- Event Bus
- Query Engine
- Scheduler

Nunca accede directamente a Systems concretos.

---

# Integración con Save

El Multiplayer no implementa persistencia.

Cuando el servidor restaura un Save:

```text
Load Save

↓

Restore Runtime

↓

Replication

↓

Clients Updated
```

---

# Integración con Resources

Los Resources nunca se transmiten completos.

Solo se sincronizan sus identificadores.

---

# Integración con Scheduler

La replicación ocurre únicamente en puntos seguros definidos por el Scheduler.

Nunca durante la ejecución de un System.

---

# Ciclo de Vida

El Multiplayer sigue el siguiente ciclo:

```text
Created

↓

Initialized

↓

Listening

↓

Connected

↓

Synchronizing

↓

Running

↓

Disconnected

↓

Disposed
```

---

# Garantías

La infraestructura Multiplayer garantiza:

- autoridad única
- sincronización determinista
- independencia del gameplay
- integración con ECS
- compatibilidad con Save
- compatibilidad con Resources
- compatibilidad con Scheduler

---

# Dependencias Permitidas

Puede depender únicamente de:

- Runtime Services
- Registries
- Scheduler
- Event Bus
- Transport Layer

Siempre mediante interfaces.

---

# Dependencias Prohibidas

Nunca debe depender de:

- Gameplay
- Combat Systems
- Inventory Systems
- SceneTree
- UI
- Nodes específicos

---

# Objetivos Arquitectónicos

La implementación debe permitir:

- Dedicated Servers
- Listen Servers
- Cooperativo
- PvP
- Persistencia
- Escalabilidad
- Replicación eficiente
- Baja latencia
- Evolución futura

Sin romper la arquitectura existente.

---

# Resultado Esperado

Al finalizar esta primera parte queda definida la arquitectura general del **Multiplayer Framework**.

El sistema se establece como una infraestructura completamente desacoplada del gameplay, responsable de sincronizar múltiples Runtime ECS mediante un modelo **Server Authoritative**, manteniendo una separación estricta entre la simulación oficial del servidor, la representación local de los clientes y la infraestructura de transporte, todo ello integrado con el Scheduler, los Registries y el resto del Framework sin introducir dependencias directas entre Systems.
# 12 - MULTIPLAYER IMPLEMENTATION

# Parte 2 — Multiplayer Bootstrap, Network Manager, Session Manager y Connection Pipeline

---

# Objetivo

Esta sección define el proceso de inicialización de la infraestructura Multiplayer, la implementación del **Network Manager**, el **Session Manager** y el ciclo completo de conexión entre clientes y servidor.

El objetivo es garantizar que toda sesión multijugador siga exactamente el mismo flujo de inicialización, independientemente del backend de red utilizado.

---

# Filosofía

La infraestructura Multiplayer debe inicializarse de forma completamente independiente del gameplay.

Ningún System necesita conocer:

- cómo se crea un servidor;
- cómo se conecta un cliente;
- cómo se establece una sesión.

Toda esa responsabilidad pertenece exclusivamente a la infraestructura Multiplayer.

---

# Bootstrap General

La inicialización sigue el siguiente flujo conceptual.

```text
Project Bootstrap

↓

Runtime Bootstrap

↓

Multiplayer Bootstrap

↓

Network Ready

↓

Game Session Ready
```

La infraestructura Multiplayer se inicializa antes de comenzar la simulación.

---

# Responsabilidades del Bootstrap

El Bootstrap Multiplayer debe:

- crear los servicios de red;
- inicializar el Network Manager;
- inicializar el Session Manager;
- registrar los servicios necesarios;
- preparar el Transport Layer;
- dejar el sistema listo para aceptar conexiones.

No inicia una partida.

No crea entidades.

No carga Saves.

---

# Estados del Bootstrap

```text
Not Initialized

↓

Initializing

↓

Ready

↓

Running
```

Si ocurre un error:

```text
Initializing

↓

Failed

↓

Shutdown
```

---

# Network Manager

## Responsabilidad

El Network Manager constituye la fachada principal de toda la infraestructura Multiplayer.

Toda solicitud relacionada con la red pasa por este módulo.

---

# Responsabilidades

El Network Manager coordina:

- creación de servidores;
- conexión de clientes;
- cierre de conexiones;
- estado de la red;
- ciclo de vida de la sesión;
- comunicación con el Transport Layer.

Nunca procesa lógica de gameplay.

---

# Responsabilidad Única

El Network Manager nunca:

- replica Components;
- serializa entidades;
- procesa RPC;
- administra autoridad.

Cada una de estas tareas pertenece a módulos especializados.

---

# Estados del Network Manager

```text
Created

↓

Initialized

↓

Idle

↓

Hosting
```

o

```text
Idle

↓

Connecting

↓

Connected
```

o

```text
Connected

↓

Disconnected
```

---

# Session Manager

## Responsabilidad

El Session Manager administra la existencia lógica de una sesión multijugador.

No administra paquetes.

No administra sockets.

No administra transporte.

Su responsabilidad consiste únicamente en la sesión.

---

# Información Administrada

Conceptualmente puede mantener:

- Session ID;
- modo de juego;
- estado de la sesión;
- lista de participantes;
- configuración general.

---

# Estados de una Sesión

```text
Created

↓

Waiting Players

↓

Starting

↓

Running

↓

Finishing

↓

Closed
```

---

# Creación de una Sesión

Cuando el servidor inicia:

```text
Host Request

↓

Session Manager

↓

Create Session

↓

Waiting Players
```

Todavía no existe simulación.

---

# Unión a una Sesión

Cuando un cliente solicita ingresar:

```text
Join Request

↓

Connection Pipeline

↓

Session Manager

↓

Pending
```

La sesión decide posteriormente si la conexión será aceptada.

---

# Connection Pipeline

## Objetivo

El Connection Pipeline define el flujo oficial para establecer una conexión.

Todo cliente sigue exactamente el mismo proceso.

---

# Flujo General

```text
Connect

↓

Transport

↓

Handshake

↓

Validation

↓

Authentication

↓

Session Join

↓

Synchronization

↓

Ready
```

---

# Connect

El cliente solicita una conexión al servidor.

Todavía no existe intercambio de información del Runtime.

---

# Transport

El Transport Layer establece la comunicación física.

La implementación concreta permanece desacoplada.

---

# Handshake

El Handshake verifica que ambas partes puedan comunicarse.

Ejemplos:

- versión del protocolo;
- compatibilidad básica;
- capacidades mínimas.

---

# Validation

Durante esta etapa se verifican las condiciones necesarias para aceptar la conexión.

Ejemplos:

- sesión disponible;
- servidor activo;
- capacidad suficiente.

---

# Authentication

La infraestructura permite incorporar un proceso de autenticación.

La implementación concreta queda fuera del alcance del Framework.

El resultado conceptual es:

```text
Authenticated

↓

Continue
```

o

```text
Rejected

↓

Disconnect
```

---

# Session Join

Una vez validado el cliente:

```text
Player

↓

Session Manager

↓

Participant Registered
```

Aún no se sincroniza el mundo.

---

# Synchronization

Después del ingreso:

```text
Server Snapshot

↓

Replication

↓

Client Runtime
```

Solo cuando la sincronización finaliza el cliente puede comenzar la simulación local.

---

# Ready

El cliente pasa oficialmente al estado:

```text
Connected
```

Y comienza la ejecución normal.

---

# Reconexión

La arquitectura admite futuras estrategias de reconexión.

Conceptualmente:

```text
Disconnected

↓

Reconnect

↓

Validation

↓

Synchronization

↓

Running
```

La política concreta permanece desacoplada.

---

# Desconexión

La desconexión puede originarse por:

- decisión del usuario;
- cierre del servidor;
- pérdida de conexión;
- error de autenticación.

El Connection Pipeline debe finalizar correctamente todos los recursos asociados.

---

# Tiempo de Espera

Las conexiones pendientes no deben permanecer indefinidamente.

Conceptualmente:

```text
Connecting

↓

Timeout

↓

Disconnect
```

La duración específica será configurable.

---

# Cancelación

Un proceso de conexión puede cancelarse antes de completar la sincronización inicial.

Después de la sincronización, la sesión debe cerrarse mediante el procedimiento normal de desconexión.

---

# Integración con el Scheduler

Durante el Connection Pipeline el Scheduler aún no ejecuta Systems dependientes del jugador conectado.

La simulación comienza únicamente después de finalizar la sincronización inicial.

---

# Integración con Entity Registry

Durante el proceso de conexión no se crean entidades de gameplay.

Las entidades del jugador se generan únicamente cuando la sesión lo autoriza y la sincronización correspondiente ha finalizado.

---

# Integración con Save

Si el servidor utiliza un mundo persistente:

```text
Restore Save

↓

Runtime Ready

↓

Accept Connections
```

Nunca debe aceptarse un cliente antes de que el Runtime oficial esté completamente restaurado.

---

# Integración con Event Bus

El ciclo de vida de una conexión puede publicar eventos conceptuales como:

```text
Client Connecting
```

```text
Client Connected
```

```text
Client Disconnected
```

```text
Session Started
```

Estos eventos permiten reaccionar sin crear dependencias directas.

---

# Restricciones

El Bootstrap Multiplayer nunca debe:

- crear entidades de gameplay;
- iniciar Systems;
- cargar escenas;
- ejecutar lógica de simulación.

El Connection Pipeline nunca debe:

- modificar Components directamente;
- alterar el Runtime durante el Handshake;
- sincronizar datos antes de completar la validación.

---

# Garantías

La infraestructura garantiza que:

- todas las conexiones siguen el mismo Pipeline;
- la sesión permanece desacoplada del transporte;
- el Bootstrap prepara completamente la infraestructura antes de iniciar la simulación;
- ningún cliente comienza a ejecutar el Runtime sin haber completado la sincronización inicial.

---

# Flujo Completo

Conceptualmente:

```text
Project Bootstrap

↓

Network Bootstrap

↓

Host / Connect

↓

Handshake

↓

Validation

↓

Authentication

↓

Session Join

↓

Initial Synchronization

↓

Runtime Ready

↓

Simulation Running
```

Este flujo representa el comportamiento oficial del proceso de inicialización y conexión dentro de la infraestructura Multiplayer del Framework ECS.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificada la implementación del **Multiplayer Bootstrap**, el **Network Manager**, el **Session Manager** y el **Connection Pipeline**.

La arquitectura establece un proceso uniforme para la creación de sesiones y la incorporación de clientes, manteniendo una separación estricta entre la infraestructura de red, el transporte, la validación de conexiones y la simulación ECS, garantizando que todo participante ingrese al mundo únicamente después de disponer de un Runtime completamente sincronizado y consistente.
# 12 - MULTIPLAYER IMPLEMENTATION

# Parte 3 — Authority Model, Ownership, Network Tick y Replication Pipeline

---

# Objetivo

Esta sección define el modelo de autoridad utilizado por el Framework ECS, la propiedad de las entidades (Ownership), el funcionamiento del Network Tick y el Replication Pipeline responsable de sincronizar el estado del Runtime.

Estos mecanismos constituyen el núcleo de la arquitectura Multiplayer.

---

# Filosofía

La arquitectura Multiplayer está basada en un único principio.

**El servidor siempre posee la autoridad.**

Los clientes nunca modifican directamente el estado oficial del Runtime.

Toda modificación válida ocurre únicamente en el servidor.

---

# Modelo de Autoridad

El Framework utiliza un modelo completamente:

```text
Server Authoritative
```

Esto significa que únicamente el servidor puede:

- crear entidades
- destruir entidades
- modificar Components oficiales
- ejecutar IA
- validar acciones
- resolver conflictos
- actualizar el mundo

---

# Cliente

El cliente únicamente puede:

- enviar inputs
- realizar solicitudes
- mostrar representación visual
- realizar predicción local
- interpolar estados
- reproducir efectos

Nunca produce el estado oficial.

---

# Flujo General

```text
Player Input

↓

Client

↓

Server

↓

Simulation

↓

Replication

↓

Clients
```

Todo cambio pasa obligatoriamente por el servidor.

---

# Beneficios

Este modelo proporciona:

- seguridad
- consistencia
- sincronización determinista
- prevención de trampas
- simulación única

---

# Ownership

## Objetivo

El Ownership define qué cliente controla una determinada entidad.

No define autoridad.

La autoridad siempre pertenece al servidor.

---

# Diferencia

Ownership

```text
Quién controla la entidad
```

Authority

```text
Quién decide el estado oficial
```

Son conceptos diferentes.

---

# Ejemplo

Jugador A controla:

```text
Player Entity
```

Pero el servidor continúa siendo la autoridad.

---

# Cambio de Ownership

La arquitectura permite transferir Ownership.

Ejemplo:

```text
Entity

↓

Player A

↓

Player B
```

El cambio siempre es autorizado por el servidor.

---

# Entidades sin Owner

Muchas entidades no poseen propietario.

Ejemplos:

- árboles
- rocas
- enemigos
- clima
- mundo

Todas continúan siendo controladas por el servidor.

---

# Authority Transfer

Como regla general:

La autoridad nunca cambia.

Siempre pertenece al servidor.

Incluso si cambia el Ownership.

---

# Network Tick

## Objetivo

El Multiplayer no replica continuamente.

Replica en intervalos definidos.

Cada intervalo constituye un:

```text
Network Tick
```

---

# Filosofía

Separar:

Simulation Tick

de

Network Tick

permite optimizar ancho de banda.

---

# Flujo

```text
Simulation

↓

Simulation Tick

↓

Network Tick

↓

Replication
```

No todos los Simulation Tick producen tráfico de red.

---

# Scheduler

El Scheduler determina cuándo ejecutar:

- Systems
- Replication
- Snapshot

Cada fase permanece separada.

---

# Estados

Conceptualmente:

```text
Simulation

↓

Barrier

↓

Replication

↓

Next Frame
```

Nunca debe replicarse durante la modificación de Components.

---

# Replication Pipeline

## Objetivo

Sincronizar el Runtime oficial hacia todos los clientes.

---

# Flujo General

```text
Server Runtime

↓

Detect Changes

↓

Serialize

↓

Build Packet

↓

Transport

↓

Client

↓

Deserialize

↓

Apply Changes
```

---

# Responsabilidad

El Replication Pipeline únicamente sincroniza estado.

Nunca ejecuta gameplay.

Nunca interpreta lógica.

---

# Detección de Cambios

Antes de replicar:

```text
Components

↓

Changed?

↓

Yes

↓

Replicate
```

Los Components sin modificaciones no necesitan enviarse nuevamente.

---

# Snapshot de Replicación

Cada Tick genera conceptualmente un Snapshot.

```text
Server ECS

↓

Network Snapshot
```

Este Snapshot representa únicamente el estado necesario para sincronizar clientes.

No debe confundirse con el Save Snapshot.

---

# Replication Units

La unidad básica de replicación es:

```text
Entity
```

compuesta por:

```text
Components
```

Nunca se sincronizan Nodes.

---

# Component Replication

Cada Component puede pertenecer a una de las siguientes categorías:

```text
Replicated
```

```text
Server Only
```

```text
Client Only
```

La política concreta pertenece al diseño de cada Component.

---

# Orden

El Pipeline debe respetar un orden determinista.

```text
Spawn

↓

Components

↓

Updates

↓

Events

↓

Despawn
```

Esto evita inconsistencias.

---

# Replicación Parcial

El Pipeline debe permitir enviar únicamente:

```text
Changed Components
```

En lugar de toda la entidad.

Esto reduce significativamente el tráfico.

---

# Replicación Completa

En determinados casos será necesario enviar:

```text
Entire Entity
```

Ejemplo:

- conexión inicial
- reconstrucción
- corrección completa

---

# Agrupación

Varias entidades pueden agruparse en un mismo paquete.

Conceptualmente:

```text
Entity

+

Entity

+

Entity

↓

Packet
```

---

# Confirmación

La recepción de información puede requerir confirmación dependiendo del tipo de dato.

La política concreta será definida posteriormente por el sistema de Reliability.

---

# Integración con Entity Registry

El Pipeline obtiene todas las entidades desde:

```text
Entity Registry
```

Nunca desde el SceneTree.

---

# Integración con Component Registry

Toda información replicada proviene de:

```text
Component Registry
```

Los Components nunca conocen la red.

---

# Integración con Scheduler

El Scheduler ejecuta:

```text
Systems

↓

Barrier

↓

Replication
```

Este orden nunca debe invertirse.

---

# Integración con Save

Después de cargar un Save:

```text
Restore Runtime

↓

Replication Snapshot

↓

Clients Updated
```

La sincronización inicial reutiliza el mismo Pipeline.

---

# Restricciones

El Replication Pipeline nunca debe:

- modificar gameplay
- ejecutar IA
- crear decisiones
- alterar autoridad

Su responsabilidad consiste únicamente en transportar estado.

---

# Garantías

La arquitectura garantiza:

- autoridad única
- Ownership desacoplado
- sincronización determinista
- separación entre simulación y red
- replicación eficiente basada en cambios
- independencia del gameplay

---

# Flujo Completo

```text
Simulation

↓

Scheduler Barrier

↓

Detect Changes

↓

Replication Snapshot

↓

Serialize

↓

Transport

↓

Deserialize

↓

Apply Components

↓

Client Runtime Updated
```

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificado el **Authority Model**, el sistema de **Ownership**, el funcionamiento del **Network Tick** y el **Replication Pipeline**.

La arquitectura garantiza que toda modificación del Runtime sea validada por el servidor y posteriormente distribuida a los clientes mediante un proceso determinista de replicación basado en entidades y Components, manteniendo una separación estricta entre la simulación ECS, la sincronización de red y la infraestructura de transporte.
# 12 - MULTIPLAYER IMPLEMENTATION

# Parte 4 — Network Serialization, Snapshot Replication, Entity Replication y Component Replication

---

# Objetivo

Esta sección define cómo el estado del Runtime ECS se transforma en información transmisible por la red y cómo dicho estado es reconstruido en los clientes.

La infraestructura de serialización de red es completamente independiente del Save System.

Aunque ambos sistemas serializan datos, poseen objetivos completamente distintos.

---

# Filosofía

El Save System serializa para persistencia.

El Multiplayer serializa para sincronización.

Ambos reutilizan la arquitectura ECS.

Pero nunca comparten responsabilidades.

---

# Comparación

Save

```text
Runtime

↓

Serialize

↓

Storage
```

Multiplayer

```text
Runtime

↓

Serialize

↓

Network
```

La finalidad es distinta.

---

# Network Serializer

## Responsabilidad

El Network Serializer transforma el estado ECS en un formato transmisible.

Nunca interpreta gameplay.

Nunca modifica Components.

Nunca crea entidades.

---

# Flujo General

```text
Runtime

↓

Replication Snapshot

↓

Network Serializer

↓

Network Packet
```

---

# Principio Fundamental

La serialización de red debe ser:

- determinista
- incremental
- eficiente
- compacta
- desacoplada

---

# Snapshot Replication

## Objetivo

Representar el estado del servidor durante un Network Tick.

No representa el estado completo del mundo.

Únicamente contiene la información necesaria para sincronizar clientes.

---

# Snapshot

Conceptualmente

```text
Server Runtime

↓

Replication Snapshot
```

El Snapshot es inmutable.

Nunca se modifica durante la transmisión.

---

# Diferencia con Save Snapshot

Save Snapshot

```text
Estado completo
```

Network Snapshot

```text
Estado replicable
```

Son infraestructuras distintas.

---

# Construcción

Cada Network Tick produce conceptualmente:

```text
Detect Changes

↓

Replication Snapshot
```

---

# Contenido

Un Snapshot puede contener:

- entidades creadas
- entidades destruidas
- Components modificados
- eventos de red
- cambios de Ownership
- actualizaciones globales

Nunca contiene lógica.

---

# Entity Replication

## Responsabilidad

Sincronizar la existencia de entidades.

No sincroniza comportamiento.

No sincroniza IA.

---

# Flujo

```text
Entity

↓

Serialize

↓

Packet

↓

Client

↓

Deserialize

↓

Entity
```

---

# Información Replicada

Cada entidad puede incluir:

- Entity ID
- tipo
- estado
- Components replicables

---

# Entity Identifier

El Entity ID debe permanecer estable durante toda la sesión.

Nunca debe reutilizarse mientras exista la posibilidad de referencias activas.

---

# Creación

Cuando aparece una entidad:

```text
Server

↓

Spawn

↓

Replication

↓

Client
```

---

# Actualización

Mientras exista:

```text
Entity

↓

Changed Components

↓

Replication
```

---

# Eliminación

Cuando desaparece:

```text
Server

↓

Despawn

↓

Replication

↓

Client Destroy
```

---

# Component Replication

## Responsabilidad

Sincronizar únicamente Components marcados como replicables.

---

# Filosofía

No todos los Components requieren replicación.

Ejemplos:

```text
Server Only
```

Nunca viajan por la red.

---

# Categorías

Conceptualmente:

```text
Replicated
```

```text
Predicted
```

```text
Client Only
```

```text
Server Only
```

Cada Component define su política.

---

# Serialización

Cada Component posee un Serializer especializado.

```text
Component

↓

Network Serializer

↓

Binary Data
```

---

# Deserialización

En el cliente

```text
Binary Data

↓

Deserializer

↓

Component Update
```

---

# Component Delta

Siempre que sea posible únicamente se envían cambios.

```text
Previous

↓

Current

↓

Delta
```

Esto reduce tráfico.

---

# Full Component

En determinadas situaciones será necesario enviar:

```text
Entire Component
```

Ejemplos:

- conexión inicial
- corrección
- recuperación

---

# Orden

La aplicación debe seguir un orden consistente.

```text
Spawn

↓

Components

↓

Updates

↓

Events

↓

Despawn
```

---

# Referencias

Cuando un Component referencia otra entidad:

```text
Entity A

↓

Entity ID

↓

Entity B
```

La resolución ocurre después de crear todas las entidades necesarias.

---

# Global State

Además de entidades puede existir información global.

Ejemplos:

- hora
- clima
- estado del mundo

Su sincronización pertenece al mismo Pipeline.

---

# Network Packet

Un paquete puede contener:

```text
Header

↓

Entities

↓

Components

↓

Events
```

La organización exacta permanece desacoplada.

---

# Packet Builder

El Packet Builder reúne la información producida por el Replication Pipeline.

```text
Snapshot

↓

Packet Builder

↓

Packet
```

---

# Packet Reader

En el cliente

```text
Packet

↓

Packet Reader

↓

Deserializer
```

---

# Orden de Aplicación

Conceptualmente

```text
Read Packet

↓

Spawn

↓

Update Components

↓

Resolve References

↓

Fire Events
```

Nunca debe alterarse este orden.

---

# Integración con Entity Registry

Las entidades se crean únicamente mediante:

```text
Entity Registry
```

Nunca directamente desde la infraestructura Multiplayer.

---

# Integración con Component Registry

Los Components se agregan mediante:

```text
Component Registry
```

No existen modificaciones directas.

---

# Integración con Resource Registry

Cuando un Component referencia un Resource:

```text
Resource ID

↓

Registry

↓

Resource
```

Nunca se transmite el Resource completo.

---

# Integración con Scheduler

La aplicación del Snapshot ocurre únicamente durante una fase segura del Scheduler.

Nunca durante la ejecución de un System.

---

# Restricciones

El Network Serializer nunca debe:

- modificar Components
- crear gameplay
- ejecutar IA
- resolver autoridad

Su única responsabilidad consiste en transformar datos.

---

# Garantías

La arquitectura garantiza:

- serialización determinista
- Snapshots inmutables
- sincronización incremental
- independencia entre Save y Multiplayer
- Components desacoplados
- transmisión eficiente

---

# Flujo Completo

```text
Server Runtime

↓

Replication Snapshot

↓

Serialize

↓

Packet

↓

Transport

↓

Receive

↓

Deserialize

↓

Apply

↓

Client Runtime
```

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificada la implementación del **Network Serializer**, la **Snapshot Replication**, la **Entity Replication** y la **Component Replication**.

La arquitectura establece un mecanismo uniforme para transformar el estado replicable del Runtime ECS en paquetes de red compactos y deterministas, reconstruyendo posteriormente dicho estado en los clientes mediante los Registries del Framework, sin introducir dependencias con el gameplay ni con el sistema de persistencia.
# 12 - MULTIPLAYER IMPLEMENTATION

# Parte 5 — RPC Layer, Event Replication, Commands, Requests y Message Pipeline

---

# Objetivo

Esta sección define la infraestructura de comunicación orientada a mensajes del Framework Multiplayer.

Mientras el **Replication Pipeline** sincroniza estado continuo del Runtime, el **RPC Layer** transmite acciones puntuales entre cliente y servidor.

Ambos sistemas son completamente independientes.

---

# Filosofía

Existen dos tipos completamente diferentes de comunicación.

## Sincronización de Estado

Mantiene los Runtime sincronizados.

Ejemplo:

```text
Server

↓

Replication

↓

Clients
```

---

## Mensajes

Transmiten acciones específicas.

Ejemplo:

```text
Client

↓

Request

↓

Server
```

El RPC Layer únicamente administra mensajes.

Nunca sincroniza Components completos.

---

# Arquitectura

Conceptualmente:

```text
Application

↓

RPC Layer

↓

Message Serializer

↓

Transport Layer
```

---

# Responsabilidad

El RPC Layer coordina:

- envío
- recepción
- validación
- despacho

Nunca ejecuta gameplay.

---

# Principio Fundamental

Los mensajes nunca modifican directamente el Runtime.

Siempre ingresan al Framework mediante interfaces claramente definidas.

---

# Tipos de Mensajes

La infraestructura distingue conceptualmente:

```text
Command
```

```text
Request
```

```text
Response
```

```text
Notification
```

```text
Network Event
```

Cada uno posee un propósito diferente.

---

# Commands

## Objetivo

Solicitar que el servidor ejecute una acción.

Ejemplo:

```text
Move

↓

Command

↓

Server
```

El servidor decide si el comando es válido.

---

# Características

Un Command:

- nunca modifica directamente el Runtime;
- requiere validación;
- puede rechazarse;
- puede producir cambios oficiales.

---

# Requests

## Objetivo

Solicitar información.

Ejemplo:

```text
Client

↓

Request

↓

Server

↓

Response
```

No implica modificación del mundo.

---

# Responses

Representan la respuesta a una solicitud previa.

Siempre corresponden a un Request existente.

---

# Notifications

Comunican información.

Ejemplo:

```text
Server

↓

Notification

↓

Clients
```

No requieren respuesta.

---

# Network Events

Los eventos representan sucesos puntuales.

Ejemplos conceptuales:

```text
Player Joined
```

```text
Player Left
```

```text
Session Started
```

No deben confundirse con:

- ECS Events
- Gameplay Events

Aunque posteriormente puedan generar eventos dentro del Runtime.

---

# Message Pipeline

## Flujo

```text
Create Message

↓

Serialize

↓

Transport

↓

Receive

↓

Deserialize

↓

Dispatch
```

---

# Message Serializer

## Responsabilidad

Transformar mensajes en un formato transmisible.

Nunca interpreta gameplay.

Nunca conoce Systems.

---

# Message Dispatcher

## Responsabilidad

Enviar cada mensaje al módulo correspondiente.

Conceptualmente:

```text
Message

↓

Dispatcher

↓

Handler
```

---

# Handlers

Cada tipo de mensaje posee un Handler especializado.

Ejemplo:

```text
Move Command

↓

Move Handler
```

---

# Responsabilidad Única

Cada Handler procesa únicamente un tipo de mensaje.

Nunca múltiples responsabilidades.

---

# Validación

Antes de ejecutar un mensaje:

```text
Receive

↓

Validate

↓

Execute
```

Si falla:

```text
Reject
```

---

# Autorización

Además de validar el formato debe verificarse:

- origen
- permisos
- Ownership
- estado de sesión

---

# Orden

Los mensajes deben procesarse en el mismo orden lógico en que fueron aceptados.

La política concreta dependerá del sistema de Reliability.

---

# Reenvío

Algunos mensajes podrán reenviarse.

Otros nunca.

La infraestructura permite ambas estrategias.

---

# Broadcast

Un mensaje puede enviarse a:

```text
One Client
```

```text
Several Clients
```

```text
Entire Session
```

La decisión pertenece al RPC Layer.

---

# Integración con Event Bus

Después de procesar un mensaje:

```text
RPC

↓

Framework Event

↓

Systems
```

De esta forma el gameplay permanece desacoplado de la red.

---

# Integración con Scheduler

Los mensajes aceptados no modifican inmediatamente el Runtime.

El Scheduler determina el momento seguro para ejecutar sus efectos.

---

# Integración con Systems

Los Systems nunca reciben paquetes de red.

Únicamente reciben:

```text
Events
```

o

```text
Commands Already Validated
```

La infraestructura Multiplayer desaparece completamente para el gameplay.

---

# Integración con Query Engine

Cuando un mensaje requiere consultar el Runtime:

```text
RPC Handler

↓

Query

↓

Runtime
```

Nunca mediante referencias directas.

---

# Integración con Authority

Todo Command recibido por el servidor debe respetar:

```text
Authority

↓

Validation

↓

Execute
```

Los clientes nunca ejecutan Commands oficiales.

---

# Integración con Ownership

Antes de aceptar determinadas solicitudes:

```text
Ownership

↓

Allowed?

↓

Execute
```

---

# Integración con Replication

Un RPC nunca reemplaza la Replicación.

El flujo correcto es:

```text
Command

↓

Server Simulation

↓

Replication

↓

Clients
```

No:

```text
Command

↓

Clients Updated
```

La actualización oficial siempre ocurre mediante el Replication Pipeline.

---

# Errores

Cuando un mensaje resulta inválido:

```text
Reject

↓

Optional Response

↓

Continue
```

Nunca debe comprometer la estabilidad del Runtime.

---

# Restricciones

El RPC Layer nunca debe:

- modificar Components directamente;
- sincronizar entidades completas;
- ejecutar lógica de IA;
- reemplazar el Replication Pipeline.

Cada infraestructura mantiene una responsabilidad independiente.

---

# Garantías

La arquitectura garantiza:

- separación entre mensajes y sincronización de estado;
- validación previa de toda solicitud;
- procesamiento mediante Handlers especializados;
- integración con Scheduler y Event Bus;
- desacoplamiento total del gameplay.

---

# Flujo Completo

Conceptualmente:

```text
Client

↓

Command

↓

RPC Layer

↓

Validation

↓

Scheduler

↓

Gameplay

↓

Replication

↓

Clients Updated
```

Este flujo representa el comportamiento oficial del sistema de mensajes del Framework Multiplayer.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificada la implementación del **RPC Layer**, el **Message Pipeline**, la infraestructura de **Commands**, **Requests**, **Responses**, **Notifications** y la **Event Replication**.

La arquitectura establece un canal de comunicación desacoplado para acciones puntuales entre cliente y servidor, manteniendo una separación estricta entre la mensajería, la simulación ECS y el Replication Pipeline, garantizando que toda modificación oficial del Runtime continúe siendo validada por el servidor y distribuida posteriormente mediante la sincronización de estado.
# 12 - MULTIPLAYER IMPLEMENTATION

# Parte 6 — Spawn Pipeline, Despawn Pipeline, Entity Lifecycle y Runtime Synchronization

---

# Objetivo

Esta sección define cómo las entidades aparecen, desaparecen y son sincronizadas durante toda la vida de una sesión Multiplayer.

El objetivo es garantizar que todos los Runtime mantengan exactamente la misma estructura ECS sin depender del SceneTree ni de la lógica de gameplay.

---

# Filosofía

Una entidad no existe en un cliente porque éste la haya creado.

Existe porque el servidor decidió que debía existir.

Toda creación y destrucción de entidades pertenece exclusivamente al Runtime oficial.

---

# Principio Fundamental

Únicamente el servidor puede modificar la estructura del mundo.

Esto incluye:

- crear entidades;
- destruir entidades;
- cambiar la composición estructural;
- asignar Ownership;
- iniciar replicación.

---

# Entity Lifecycle

Durante una sesión Multiplayer una entidad atraviesa el siguiente ciclo.

```text
Created

↓

Spawn Pending

↓

Replicated

↓

Active

↓

Updated

↓

Despawn Pending

↓

Destroyed
```

Todos los Runtime deben respetar exactamente este ciclo.

---

# Spawn Pipeline

## Objetivo

Replicar la aparición de una nueva entidad desde el servidor hacia todos los clientes correspondientes.

---

# Flujo General

```text
Server

↓

Create Entity

↓

Assign Entity ID

↓

Attach Components

↓

Replication Snapshot

↓

Serialize

↓

Transport

↓

Client

↓

Create Entity

↓

Attach Components

↓

Activate
```

---

# Creación Oficial

La creación siempre comienza en el servidor.

Nunca en un cliente.

---

# Entity Identifier

Antes de iniciar la replicación la entidad debe poseer un identificador definitivo.

```text
Entity

↓

Entity ID

↓

Replication
```

El identificador nunca cambia durante la vida de la entidad.

---

# Inicialización

Una entidad nunca debe replicarse parcialmente.

Primero debe encontrarse completamente inicializada.

```text
Create

↓

Attach Components

↓

Ready

↓

Replicate
```

---

# Snapshot de Spawn

El primer Snapshot debe contener toda la información necesaria para reconstruir la entidad.

Ejemplo conceptual:

```text
Entity ID

+

Components

+

Initial State
```

---

# Recepción

Al recibir el Snapshot:

```text
Read Packet

↓

Create Entity

↓

Register Entity

↓

Attach Components

↓

Resolve References

↓

Ready
```

La activación ocurre únicamente al finalizar este proceso.

---

# Activación

Una entidad recién creada no participa inmediatamente en la simulación.

Primero debe encontrarse completamente reconstruida.

```text
Create

↓

Initialize

↓

Activate

↓

Simulation
```

---

# Despawn Pipeline

## Objetivo

Eliminar una entidad del Runtime de forma consistente.

---

# Flujo General

```text
Server

↓

Destroy Entity

↓

Replication

↓

Client

↓

Destroy Entity
```

---

# Destrucción Oficial

La eliminación siempre comienza en el servidor.

Los clientes nunca destruyen entidades oficiales por iniciativa propia.

---

# Orden

Antes de eliminar una entidad deben resolverse correctamente todas las referencias dependientes.

Conceptualmente:

```text
Stop Usage

↓

Resolve References

↓

Remove Components

↓

Destroy Entity
```

---

# Confirmación

Una entidad sólo desaparece del cliente después de recibir la confirmación correspondiente desde el servidor.

---

# Entity Updates

Mientras la entidad permanece activa:

```text
Entity

↓

Changed Components

↓

Replication

↓

Client Update
```

No se retransmite la entidad completa salvo que resulte necesario.

---

# Structural Changes

Los cambios estructurales incluyen:

- agregar Components;
- eliminar Components;
- modificar Ownership;
- cambiar estado replicable.

Estos cambios siguen el mismo Pipeline de sincronización.

---

# Runtime Synchronization

## Objetivo

Mantener todos los Runtime compatibles con el Runtime oficial.

---

# Sincronización Continua

Cada Network Tick ejecuta conceptualmente:

```text
Detect Changes

↓

Build Snapshot

↓

Replication

↓

Apply Changes
```

---

# Sincronización Inicial

Cuando un cliente ingresa:

```text
Session Join

↓

Initial Snapshot

↓

Create Runtime

↓

Simulation Ready
```

No se utilizan actualizaciones incrementales.

---

# Sincronización Incremental

Después del ingreso:

```text
Previous State

↓

Detect Changes

↓

Delta

↓

Replication
```

Esto reduce considerablemente el tráfico de red.

---

# Reconciliación Estructural

Si el cliente detecta una inconsistencia estructural:

```text
Request Correction

↓

Server Snapshot

↓

Rebuild Entity
```

La decisión siempre pertenece al servidor.

---

# Referencias entre Entidades

Cuando una entidad depende de otra:

```text
Entity A

↓

Entity ID

↓

Entity B
```

La referencia sólo debe resolverse cuando ambas entidades existan localmente.

---

# Dependencias

Nunca debe activarse una entidad cuyo conjunto de referencias aún no pueda resolverse.

Esto evita estados inconsistentes durante la sincronización.

---

# Jerarquías

Si existen relaciones jerárquicas entre entidades, el orden de reconstrucción debe garantizar que la entidad padre exista antes de resolver dependencias lógicas.

La implementación concreta queda desacoplada del Pipeline.

---

# Integración con Entity Registry

Toda creación y destrucción ocurre exclusivamente mediante el Entity Registry.

Nunca directamente desde el Multiplayer.

---

# Integración con Component Registry

Los Components se agregan y eliminan utilizando el Component Registry.

La infraestructura Multiplayer nunca modifica almacenamiento interno.

---

# Integración con Scheduler

Las operaciones de Spawn y Despawn se aplican únicamente durante fases seguras del Scheduler.

Nunca durante la ejecución de un System.

---

# Integración con Replication Pipeline

El Spawn Pipeline y el Despawn Pipeline forman parte del Replication Pipeline.

Conceptualmente:

```text
Replication

↓

Spawn

↓

Updates

↓

Events

↓

Despawn
```

Este orden nunca debe alterarse.

---

# Integración con Save

Después de restaurar un Save:

```text
Restore Runtime

↓

Generate Initial Snapshot

↓

Spawn Entities

↓

Clients Ready
```

La sincronización inicial reutiliza exactamente la misma infraestructura.

---

# Restricciones

El Spawn Pipeline nunca debe:

- ejecutar gameplay;
- iniciar IA;
- activar entidades parcialmente inicializadas.

El Despawn Pipeline nunca debe:

- eliminar entidades sin autorización del servidor;
- destruir referencias activas;
- dejar Components huérfanos.

---

# Garantías

La arquitectura garantiza:

- creación determinista de entidades;
- destrucción consistente;
- sincronización incremental;
- Runtime idéntico entre servidor y clientes;
- separación entre estructura ECS y SceneTree.

---

# Flujo Completo

Conceptualmente:

```text
Server Runtime

↓

Create Entity

↓

Assign Components

↓

Replication Snapshot

↓

Transport

↓

Client Runtime

↓

Create Entity

↓

Resolve References

↓

Activate

↓

Simulation
```

Durante la eliminación:

```text
Destroy Entity

↓

Replication

↓

Resolve References

↓

Remove Components

↓

Destroy Local Entity
```

Este flujo representa el comportamiento oficial del ciclo de vida de las entidades dentro de la infraestructura Multiplayer.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificada la implementación del **Spawn Pipeline**, el **Despawn Pipeline**, el ciclo de vida de las entidades y la sincronización estructural del Runtime.

La arquitectura garantiza que todas las entidades del mundo sean creadas, actualizadas y destruidas exclusivamente bajo la autoridad del servidor, manteniendo una representación ECS consistente y determinista en todos los clientes mediante un proceso uniforme de replicación y reconstrucción del estado.
# 12 - MULTIPLAYER IMPLEMENTATION

# Parte 7 — Prediction, Interpolation, Reconciliation y Latency Compensation

---

# Objetivo

Esta sección define las estrategias utilizadas para ocultar la latencia de red y mantener una experiencia fluida para el jugador sin comprometer el modelo **Server Authoritative**.

Estas técnicas actúan únicamente sobre la representación local del Runtime.

Nunca alteran el estado oficial del servidor.

---

# Filosofía

La autoridad siempre pertenece al servidor.

Las optimizaciones del cliente existen únicamente para mejorar la percepción del jugador.

Toda discrepancia debe resolverse a favor del estado oficial.

---

# Flujo General

```text
Player Input

↓

Local Prediction

↓

Send Command

↓

Server Simulation

↓

Replication

↓

Reconciliation
```

---

# Separación de Responsabilidades

Cada técnica posee un objetivo diferente.

Prediction

```text
Reducir sensación de latencia.
```

Interpolation

```text
Suavizar movimiento remoto.
```

Reconciliation

```text
Corregir diferencias.
```

Latency Compensation

```text
Mitigar efectos de la red.
```

---

# Client Prediction

## Objetivo

Permitir que el jugador vea una respuesta inmediata a sus acciones.

---

# Funcionamiento

Cuando el usuario genera un input:

```text
Input

↓

Local Simulation

↓

Visual Update

↓

Send Command
```

El cliente no espera la respuesta del servidor para actualizar su representación local.

---

# Alcance

La predicción sólo afecta:

- representación visual;
- movimiento local;
- efectos temporales.

Nunca modifica el estado oficial.

---

# Autoridad

La simulación predicha siempre es provisional.

El servidor mantiene la última palabra.

---

# Predicted Components

Algunos Components pueden admitir predicción.

Conceptualmente:

```text
Predicted Component
```

Otros nunca deben predecirse.

Ejemplos:

- IA;
- economía;
- clima;
- mundo persistente.

---

# Confirmación

Cuando llega la actualización oficial:

```text
Server State

↓

Compare

↓

Reconcile
```

---

# Interpolation

## Objetivo

Suavizar el movimiento de entidades remotas.

---

# Filosofía

Los clientes no muestran inmediatamente cada Snapshot recibido.

En cambio:

```text
Snapshot A

↓

Interpolation

↓

Snapshot B
```

Esto reduce movimientos bruscos.

---

# Flujo

```text
Receive Snapshot

↓

Store

↓

Interpolate

↓

Render
```

---

# Buffer de Interpolación

Conceptualmente:

```text
Network Snapshot Queue
```

Los Snapshots permanecen temporalmente almacenados antes de ser representados.

---

# Entidades Remotas

Las entidades controladas por otros jugadores normalmente utilizan interpolación.

---

# Entidad Local

La entidad controlada por el propio jugador utiliza principalmente predicción.

No interpolación.

---

# Reconciliation

## Objetivo

Corregir diferencias entre:

```text
Predicted State
```

y

```text
Authoritative State
```

---

# Flujo

```text
Prediction

↓

Server Update

↓

Compare

↓

Correct
```

---

# Corrección

Si ambos estados coinciden:

```text
Continue
```

Si difieren:

```text
Rollback

↓

Replay

↓

Correct
```

La implementación concreta podrá variar.

---

# Historial

La arquitectura admite mantener un historial temporal de inputs.

Conceptualmente:

```text
Input History
```

Utilizado para reconstrucciones futuras.

---

# Replay

Después de una corrección:

```text
Official State

↓

Replay Inputs

↓

Updated Prediction
```

---

# Divergencia

Las diferencias pequeñas pueden corregirse gradualmente.

Las diferencias importantes pueden requerir una reconstrucción inmediata.

La política concreta permanece desacoplada.

---

# Latency Compensation

## Objetivo

Reducir el impacto perceptible de la latencia.

No modifica la autoridad.

---

# Estrategias Posibles

La arquitectura admite futuras técnicas como:

- buffers de entrada;
- compensación temporal;
- reconstrucción histórica;
- validación retrospectiva.

La decisión concreta dependerá del gameplay.

---

# Sincronización Temporal

El servidor representa la referencia temporal oficial.

Los clientes ajustan su representación utilizando la información recibida.

---

# Integración con Network Tick

Cada Snapshot corresponde a un Network Tick determinado.

```text
Tick

↓

Snapshot

↓

Prediction

↓

Correction
```

---

# Integración con Replication

La reconciliación siempre utiliza información proveniente del Replication Pipeline.

Nunca de mensajes RPC.

---

# Integración con RPC

Los Commands continúan enviándose normalmente.

```text
Input

↓

Command

↓

Server
```

La predicción no modifica el flujo de mensajería.

---

# Integración con Scheduler

Las correcciones del Runtime deben aplicarse únicamente durante fases seguras definidas por el Scheduler.

Nunca durante la ejecución de un System.

---

# Integración con Components

Cada Component puede definir una política conceptual:

```text
Predicted
```

```text
Interpolated
```

```text
Replicated Only
```

La infraestructura Multiplayer respeta dicha configuración.

---

# Integración con Entity Registry

Las técnicas de predicción nunca crean ni destruyen entidades.

Sólo modifican temporalmente la representación de entidades existentes.

---

# Integración con Save

Prediction, Interpolation y Reconciliation nunca participan en el proceso de persistencia.

El Save únicamente almacena el estado oficial del Runtime.

---

# Restricciones

La infraestructura nunca debe:

- modificar autoridad;
- alterar decisiones del servidor;
- aceptar estados generados por clientes;
- persistir estados predichos;
- ejecutar reconciliación fuera del Scheduler.

---

# Garantías

La arquitectura garantiza:

- autoridad exclusiva del servidor;
- respuesta inmediata para el jugador local;
- movimiento fluido de entidades remotas;
- corrección determinista;
- convergencia progresiva hacia el estado oficial.

---

# Flujo Completo

Conceptualmente:

```text
Player Input

↓

Prediction

↓

Command

↓

Server Simulation

↓

Replication Snapshot

↓

Client

↓

Interpolation

↓

Reconciliation

↓

Updated Runtime
```

Este flujo representa el comportamiento oficial de las técnicas de compensación de latencia dentro del Framework Multiplayer.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificada la implementación de **Client Prediction**, **Interpolation**, **Reconciliation** y las bases de **Latency Compensation**.

La arquitectura proporciona una experiencia de juego fluida y reactiva sin comprometer el modelo **Server Authoritative**, garantizando que todas las representaciones locales converjan de manera determinista hacia el estado oficial producido por el servidor y sincronizado mediante el Replication Pipeline.
# 12 - MULTIPLAYER IMPLEMENTATION

# Parte 8 — Interest Management, Reliability, Bandwidth Optimization y Network Performance

---

# Objetivo

Esta sección define cómo el Framework Multiplayer optimiza el tráfico de red mediante **Interest Management**, mecanismos de **Reliability**, estrategias de optimización del ancho de banda y criterios generales de rendimiento.

El objetivo es reducir la cantidad de información transmitida sin afectar la consistencia del Runtime.

---

# Filosofía

No toda la información debe enviarse a todos los clientes.

Cada participante únicamente necesita recibir el estado del mundo que resulta relevante para su simulación.

La infraestructura debe minimizar el tráfico manteniendo el modelo **Server Authoritative**.

---

# Principios

La optimización nunca debe comprometer:

- consistencia;
- determinismo;
- autoridad;
- integridad de la simulación.

La prioridad siempre es mantener un Runtime correcto.

---

# Interest Management

## Objetivo

Determinar qué información debe recibir cada cliente.

---

# Filosofía

Cada cliente posee un conjunto diferente de entidades relevantes.

Conceptualmente:

```text
World

↓

Interest Filter

↓

Relevant Entities

↓

Replication
```

---

# Beneficios

El Interest Management reduce:

- tráfico de red;
- uso de CPU;
- procesamiento del cliente;
- consumo de ancho de banda.

---

# Interest Set

Cada cliente mantiene conceptualmente un:

```text
Interest Set
```

Compuesto por todas las entidades que deben replicarse hacia ese cliente.

---

# Evaluación

Antes de construir un Snapshot:

```text
Entities

↓

Interest Evaluation

↓

Relevant

↓

Replication
```

Las entidades irrelevantes no se incluyen.

---

# Criterios

La arquitectura permite múltiples políticas de interés.

Ejemplos:

- proximidad;
- visibilidad;
- pertenencia a una sesión;
- zona del mundo;
- equipos;
- dimensiones o instancias.

La implementación concreta permanece desacoplada.

---

# Entrada al Interest Set

Cuando una entidad pasa a ser relevante:

```text
Not Relevant

↓

Relevant

↓

Spawn Pipeline
```

---

# Salida del Interest Set

Cuando deja de ser relevante:

```text
Relevant

↓

Not Relevant

↓

Despawn Pipeline
```

La entidad continúa existiendo en el servidor.

---

# Actualización

Mientras permanezca dentro del Interest Set:

```text
Entity

↓

Changed Components

↓

Replication
```

---

# Reliability

## Objetivo

Garantizar que determinados mensajes lleguen correctamente.

No toda la información posee los mismos requisitos.

---

# Categorías

Conceptualmente existen dos grandes grupos.

```text
Reliable
```

```text
Unreliable
```

---

# Reliable

Se utiliza para información crítica.

Ejemplos conceptuales:

- Spawn;
- Despawn;
- cambios de Ownership;
- inicio de sesión;
- cierre de sesión.

---

# Unreliable

Adecuado para información continua.

Ejemplos:

- movimiento;
- rotación;
- animaciones;
- estados temporales.

La pérdida ocasional puede corregirse mediante el siguiente Snapshot.

---

# Confirmación

Los mensajes Reliable pueden requerir:

```text
Send

↓

Acknowledge

↓

Complete
```

La estrategia concreta depende del Transport Layer.

---

# Reenvío

Cuando un mensaje Reliable no se confirma:

```text
Timeout

↓

Resend
```

La política exacta permanece desacoplada.

---

# Orden

Determinados mensajes requieren mantener un orden estricto.

La infraestructura de Reliability debe garantizar dicho comportamiento cuando resulte necesario.

---

# Bandwidth Optimization

## Objetivo

Reducir la cantidad total de información transmitida.

---

# Estrategias

La arquitectura admite:

- replicación incremental;
- deltas;
- filtrado por interés;
- agrupación de entidades;
- compresión opcional;
- frecuencia variable.

Todas ellas son independientes entre sí.

---

# Delta Replication

Conceptualmente:

```text
Previous State

↓

Current State

↓

Difference

↓

Replication
```

Sólo se transmiten cambios.

---

# Agrupación

Varias actualizaciones pueden combinarse en un único paquete.

```text
Entity A

+

Entity B

+

Entity C

↓

Packet
```

Esto reduce sobrecarga.

---

# Frecuencia

No todos los Components requieren la misma frecuencia de actualización.

La arquitectura permite políticas diferenciadas.

Ejemplo conceptual:

```text
High Frequency
```

```text
Medium Frequency
```

```text
Low Frequency
```

---

# Prioridad

Los datos más importantes pueden enviarse antes que los secundarios.

La estrategia concreta permanece desacoplada.

---

# Compresión

El Replication Pipeline puede incorporar una etapa opcional de compresión.

```text
Snapshot

↓

Serialize

↓

Compress

↓

Transport
```

La compresión nunca modifica la lógica de replicación.

---

# Network Performance

## Objetivo

Mantener un comportamiento estable incluso con grandes cantidades de entidades.

---

# Escalabilidad

La arquitectura debe soportar:

- cientos de jugadores;
- miles de entidades replicables;
- múltiples sesiones;
- mundos persistentes.

Sin modificar la API pública.

---

# Costos

Los principales costos provienen de:

- detección de cambios;
- serialización;
- filtrado de interés;
- construcción de paquetes;
- transporte.

Cada etapa puede optimizarse de forma independiente.

---

# Integración con Scheduler

La evaluación del Interest Set y la construcción de Snapshots se realizan únicamente durante las fases de red definidas por el Scheduler.

Nunca durante la ejecución de Systems.

---

# Integración con Replication Pipeline

El flujo oficial queda representado por:

```text
Detect Changes

↓

Interest Filter

↓

Serialize

↓

Reliability

↓

Transport
```

---

# Integración con Entity Registry

Las entidades candidatas provienen exclusivamente del Entity Registry.

El Interest Management nunca inspecciona el SceneTree.

---

# Integración con Component Registry

Los Components replicables se obtienen mediante el Component Registry.

Las políticas de frecuencia y relevancia se aplican antes de serializar.

---

# Integración con Save

El Interest Management no afecta el sistema de persistencia.

El Save continúa almacenando el estado completo del Runtime oficial.

---

# Restricciones

La infraestructura nunca debe:

- ocultar entidades al servidor;
- modificar autoridad;
- alterar el Runtime para reducir tráfico;
- omitir información crítica;
- romper el determinismo.

Toda optimización debe producir exactamente el mismo estado final.

---

# Garantías

La arquitectura garantiza:

- replicación basada en relevancia;
- soporte para distintos niveles de fiabilidad;
- reducción eficiente del ancho de banda;
- escalabilidad para mundos de gran tamaño;
- independencia entre optimización y gameplay.

---

# Flujo Completo

Conceptualmente:

```text
Server Runtime

↓

Detect Changes

↓

Interest Management

↓

Delta Generation

↓

Serialize

↓

Reliability

↓

Compress (Optional)

↓

Transport

↓

Client
```

Este flujo representa el comportamiento oficial del sistema de optimización de red del Framework Multiplayer.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificada la implementación del **Interest Management**, los mecanismos de **Reliability**, las estrategias de **Bandwidth Optimization** y los principios generales de **Network Performance**.

La arquitectura garantiza que cada cliente reciba únicamente la información relevante para su simulación, optimizando el uso del ancho de banda y permitiendo escalar la infraestructura Multiplayer hacia sesiones con un gran número de entidades y jugadores, sin comprometer el modelo **Server Authoritative** ni la consistencia del Runtime ECS.
# 12 - MULTIPLAYER IMPLEMENTATION

# Parte 9 — Integración con ECS, Save System, Event Bus, Debug, Profiling y Testing

---

# Objetivo

Esta sección define cómo la infraestructura Multiplayer se integra con el resto del Framework ECS, incluyendo el **Scheduler**, los **Registries**, el **Save System**, el **Event Bus**, así como las herramientas oficiales de **Debug**, **Profiling** y **Testing**.

El objetivo es mantener el desacoplamiento arquitectónico mientras todos los subsistemas colaboran de forma coherente.

---

# Filosofía

El Multiplayer no constituye un Runtime independiente.

Es una infraestructura que opera sobre el Runtime ECS existente.

Nunca reemplaza:

- Scheduler
- Systems
- Registries
- Save System
- Event Bus

Simplemente coordina la sincronización del estado oficial.

---

# Integración con Scheduler

## Responsabilidad

El Scheduler continúa siendo el único responsable del orden de ejecución del Runtime.

El Multiplayer nunca decide cuándo ejecutar Systems.

---

# Flujo

Conceptualmente:

```text
Input

↓

Systems

↓

Scheduler Barrier

↓

Replication

↓

Next Tick
```

La replicación ocurre únicamente después de finalizar la simulación.

---

# Barreras

Las fases de red deben ejecutarse exclusivamente en puntos seguros definidos por el Scheduler.

Nunca durante la modificación activa de Components.

---

# Integración con Entity Registry

Toda la infraestructura Multiplayer obtiene las entidades mediante:

```text
Entity Registry
```

Nunca inspecciona directamente el SceneTree.

---

# Integración con Component Registry

Los Components replicables son consultados exclusivamente desde:

```text
Component Registry
```

La infraestructura Multiplayer nunca administra almacenamiento interno.

---

# Integración con Resource Registry

Los Resources nunca viajan completos por la red.

Únicamente se sincronizan:

```text
Resource IDs
```

La resolución ocurre localmente mediante el Resource Registry.

---

# Integración con Query Engine

Cuando la infraestructura necesita consultar el estado del Runtime:

```text
Network Module

↓

Query

↓

Runtime
```

Nunca mediante referencias directas a Systems.

---

# Integración con Event Bus

## Filosofía

La red no debe generar acoplamiento entre el Runtime y el transporte.

Los eventos constituyen el mecanismo oficial de comunicación.

---

# Eventos Conceptuales

Ejemplos:

```text
Client Connected
```

```text
Client Disconnected
```

```text
Session Started
```

```text
Session Closed
```

```text
Ownership Changed
```

```text
Network Error
```

Estos eventos pueden ser consumidos por otros módulos del Framework.

---

# Gameplay

Los Systems nunca reciben paquetes.

Reciben únicamente:

```text
Framework Events
```

o

```text
Validated Commands
```

La infraestructura Multiplayer permanece invisible para el gameplay.

---

# Integración con Save System

## Filosofía

El servidor constituye la única autoridad para persistir el mundo.

Los clientes nunca generan el Save oficial.

---

# Guardado

Conceptualmente:

```text
Server Runtime

↓

Save System

↓

Storage
```

---

# Restauración

Después de restaurar un mundo:

```text
Load Save

↓

Restore Runtime

↓

Replication Snapshot

↓

Clients Updated
```

No existe sincronización antes de finalizar completamente la restauración.

---

# Auto Save

Cuando el servidor ejecuta un Auto Save:

```text
Simulation

↓

Snapshot

↓

Save
```

Los clientes continúan recibiendo replicación normalmente.

---

# Reconexión

Después de una reconexión:

```text
Reconnect

↓

Restore Session

↓

Initial Snapshot

↓

Continue
```

La información persistente continúa perteneciendo al servidor.

---

# Integración con Debug

## Objetivo

Permitir inspeccionar el comportamiento de la infraestructura Multiplayer.

Nunca modificarla.

---

# Network Inspector

Puede mostrar:

- conexiones activas;
- sesiones;
- tráfico;
- latencia;
- estado de replicación.

---

# Session Inspector

Permite consultar:

- jugadores;
- Ownership;
- estado de sesión;
- participantes.

---

# Replication Inspector

Puede visualizar:

- Snapshots;
- entidades replicadas;
- Components enviados;
- frecuencia de actualización.

---

# RPC Inspector

Permite observar:

- Commands;
- Requests;
- Responses;
- Notifications;
- errores.

---

# Interest Inspector

Puede mostrar:

```text
Client

↓

Interest Set

↓

Replicated Entities
```

Facilitando el diagnóstico del filtrado de relevancia.

---

# Profiling

## Objetivo

Medir el rendimiento de toda la infraestructura Multiplayer.

---

# Métricas

Como mínimo pueden recopilarse:

- tiempo de Network Tick;
- tiempo de serialización;
- tiempo de deserialización;
- tiempo de replicación;
- tamaño promedio de paquetes;
- ancho de banda;
- cantidad de entidades replicadas;
- Components enviados;
- tiempo de Interest Management;
- memoria temporal utilizada.

---

# Comparación

El Profiler puede comparar diferentes sesiones.

Ejemplo conceptual:

```text
Session A

↓

Metrics
```

```text
Session B

↓

Metrics
```

---

# Testing

## Filosofía

Toda la infraestructura Multiplayer debe poder probarse de manera completamente aislada del gameplay.

---

# Bootstrap Tests

Verifican:

- inicialización;
- creación del servidor;
- creación del cliente;
- disponibilidad de servicios.

---

# Connection Tests

Comprueban:

- Handshake;
- validación;
- autenticación;
- ingreso;
- desconexión.

---

# Replication Tests

Validan:

- creación de entidades;
- actualización;
- destrucción;
- sincronización incremental.

---

# Authority Tests

Comprueban:

- autoridad del servidor;
- Ownership;
- rechazo de modificaciones ilegales.

---

# RPC Tests

Verifican:

- Commands;
- Requests;
- Responses;
- validación;
- errores.

---

# Prediction Tests

Comprueban:

- predicción;
- reconciliación;
- interpolación;
- convergencia.

---

# Reliability Tests

Simulan:

- pérdida de paquetes;
- duplicación;
- reordenamiento;
- retransmisión.

La infraestructura debe recuperarse correctamente.

---

# Stress Tests

La arquitectura debe probarse con:

- miles de entidades;
- cientos de jugadores;
- múltiples sesiones;
- gran volumen de tráfico.

---

# Save Integration Tests

Verifican:

```text
Restore Save

↓

Replication

↓

Clients Ready
```

Sin inconsistencias.

---

# Memory Tests

Comprueban:

- liberación de Snapshots;
- buffers temporales;
- estructuras de red;
- ausencia de pérdidas de memoria.

---

# Restricciones

La infraestructura Multiplayer nunca debe:

- modificar directamente Systems;
- acceder al SceneTree;
- almacenar estado persistente;
- reemplazar el Scheduler;
- omitir el Event Bus como mecanismo de desacoplamiento.

---

# Garantías

La arquitectura garantiza:

- integración completa con ECS;
- compatibilidad con Save System;
- desacoplamiento mediante Event Bus;
- herramientas de Debug y Profiling;
- capacidad de pruebas automatizadas;
- evolución futura sin romper la API pública.

---

# Flujo Completo

Conceptualmente:

```text
Input

↓

Simulation

↓

Scheduler Barrier

↓

Replication

↓

Transport

↓

Client Runtime

↓

Debug

↓

Profiling

↓

Testing
```

Este flujo representa la integración oficial del sistema Multiplayer con el resto del Framework ECS.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificada la integración del **Multiplayer Framework** con el **Scheduler**, los **Registries**, el **Save System**, el **Event Bus**, así como la infraestructura oficial de **Debug**, **Profiling** y **Testing**.

La arquitectura garantiza que la sincronización de red funcione como un subsistema completamente desacoplado, capaz de colaborar con el resto del Framework ECS sin introducir dependencias directas entre el transporte, la simulación y el gameplay, preservando el modelo **Server Authoritative** y la consistencia del Runtime.
# 12 - MULTIPLAYER IMPLEMENTATION

# Parte 10 — Escalabilidad, Evolución Futura, Restricciones Permanentes y Resumen Arquitectónico

---

# Objetivo

Esta sección establece los principios de escalabilidad del Framework Multiplayer, las posibilidades de evolución futura de la infraestructura y las restricciones permanentes que deberán respetarse durante toda la vida del proyecto.

Asimismo, resume la arquitectura completa definida a lo largo de este documento.

---

# Filosofía

El Multiplayer constituye una infraestructura base del Framework ECS.

Su diseño debe permitir evolucionar durante años sin requerir modificaciones en:

- Systems;
- Components;
- Resources;
- Gameplay;
- Scheduler;
- Runtime.

La API pública debe permanecer estable incluso cuando la implementación interna evolucione.

---

# Escalabilidad

## Objetivo

La arquitectura debe poder soportar proyectos de diferentes escalas utilizando exactamente el mismo modelo conceptual.

---

# Escenarios

La infraestructura debe adaptarse a:

- partidas cooperativas;
- PvP;
- servidores dedicados;
- Listen Servers;
- mundos persistentes;
- sesiones temporales;
- servidores de prueba;
- herramientas de desarrollo.

Sin modificar la arquitectura.

---

# Escalabilidad Horizontal

El diseño admite futuras estrategias como:

```text
Session

↓

Multiple Servers

↓

Distributed Infrastructure
```

La implementación concreta queda fuera del alcance del Framework actual.

---

# Escalabilidad Vertical

La infraestructura debe aprovechar adecuadamente recursos adicionales del hardware disponible.

Ejemplos:

- procesamiento concurrente;
- serialización paralela;
- múltiples hilos para transporte;
- construcción paralela de Snapshots.

Siempre preservando el determinismo del Runtime.

---

# Paralelización

Las siguientes etapas pueden evolucionar hacia modelos concurrentes:

- detección de cambios;
- Interest Management;
- serialización;
- compresión;
- construcción de paquetes;
- lectura de paquetes.

La coordinación continúa perteneciendo al Scheduler.

---

# Persistencia Distribuida

La arquitectura admite futuras integraciones con:

```text
Server Runtime

↓

Persistent Storage

↓

Replication

↓

Backup
```

Manteniendo desacoplado el Save System.

---

# Matchmaking

La infraestructura permite incorporar posteriormente:

```text
Player

↓

Matchmaking

↓

Session Assignment

↓

Connection
```

El Matchmaking permanece completamente externo al Runtime ECS.

---

# Servicios Externos

La arquitectura puede integrarse con:

- autenticación;
- cuentas;
- listas de amigos;
- estadísticas;
- servicios en la nube.

Todos ellos mediante interfaces desacopladas.

---

# Versionado del Protocolo

La infraestructura admite la coexistencia de múltiples versiones del protocolo de red.

Conceptualmente:

```text
Client Version

↓

Compatibility Check

↓

Accept

or

Reject
```

Esto facilita futuras actualizaciones sin comprometer la estabilidad de las sesiones existentes.

---

# Observabilidad

La arquitectura está preparada para incorporar herramientas avanzadas de monitoreo.

Ejemplos:

- métricas en tiempo real;
- dashboards;
- trazas de replicación;
- análisis de tráfico;
- auditoría de sesiones.

Estas capacidades permanecen desacopladas del Runtime.

---

# Evolución del Transporte

El Transport Layer puede reemplazarse completamente sin modificar:

- Replication Pipeline;
- RPC Layer;
- Gameplay;
- Systems;
- Components.

Toda dependencia se mantiene encapsulada mediante interfaces.

---

# Restricciones Permanentes

Durante toda la vida del proyecto deberán mantenerse las siguientes reglas.

---

## El servidor siempre posee la autoridad

Nunca podrá existir autoridad distribuida entre clientes.

---

## Los Systems nunca conocen la red

Toda comunicación ocurre mediante:

- Event Bus;
- Commands validados;
- estado ECS.

---

## Los Components nunca implementan networking

Los Components contienen datos.

Nunca lógica de transporte.

---

## Los Resources nunca se transmiten completos

Únicamente:

```text
Resource IDs
```

---

## El Scheduler mantiene el control

El Multiplayer nunca modifica el orden de ejecución del Runtime.

---

## El Replication Pipeline nunca ejecuta gameplay

Su única responsabilidad consiste en sincronizar estado.

---

## El RPC Layer nunca reemplaza la replicación

Los mensajes representan acciones.

La replicación representa estado.

Ambos mecanismos permanecen separados.

---

## El Save System continúa siendo independiente

La persistencia nunca forma parte del Multiplayer.

El único punto de integración es el Runtime oficial del servidor.

---

## El SceneTree nunca constituye la fuente de verdad

Toda sincronización se realiza exclusivamente mediante:

- Entity Registry;
- Component Registry;
- Runtime ECS.

---

# Buenas Prácticas

Toda nueva funcionalidad Multiplayer debería:

- respetar el modelo Server Authoritative;
- utilizar los Registries oficiales;
- publicar eventos mediante el Event Bus;
- evitar referencias directas entre módulos;
- mantener el determinismo del Runtime.

---

# Antipatrones

Las siguientes prácticas deben evitarse permanentemente.

---

## Modificar el Runtime desde el transporte

Incorrecto:

```text
Packet

↓

Gameplay
```

Correcto:

```text
Packet

↓

RPC

↓

Validation

↓

Scheduler

↓

Runtime
```

---

## Crear entidades desde el cliente

Incorrecto:

```text
Client

↓

Spawn Entity
```

Correcto:

```text
Client Command

↓

Server

↓

Spawn

↓

Replication
```

---

## Utilizar RPC para sincronizar estado continuo

Incorrecto:

```text
Movement

↓

RPC
```

Correcto:

```text
Movement

↓

Replication Pipeline
```

---

## Acceder directamente al SceneTree

Toda sincronización debe utilizar exclusivamente la infraestructura ECS.

---

# Resumen Arquitectónico

La infraestructura Multiplayer queda compuesta por los siguientes módulos especializados:

- Multiplayer Bootstrap;
- Network Manager;
- Session Manager;
- Connection Pipeline;
- Authority System;
- Ownership System;
- Replication Pipeline;
- Snapshot Replication;
- Network Serializer;
- RPC Layer;
- Message Pipeline;
- Spawn Pipeline;
- Despawn Pipeline;
- Prediction;
- Interpolation;
- Reconciliation;
- Interest Management;
- Reliability Layer;
- Transport Layer;
- Debug Tools;
- Profiler;
- Testing Infrastructure.

Cada módulo mantiene una única responsabilidad claramente definida.

---

# Flujo Arquitectónico Completo

El comportamiento general del sistema puede resumirse mediante el siguiente Pipeline.

```text
Project Bootstrap

↓

Runtime Bootstrap

↓

Network Bootstrap

↓

Session Creation

↓

Client Connection

↓

Handshake

↓

Validation

↓

Authentication

↓

Initial Synchronization

↓

Simulation

↓

Scheduler Barrier

↓

Replication Snapshot

↓

Interest Management

↓

Serialize

↓

Reliability

↓

Transport

↓

Deserialize

↓

Client Runtime

↓

Prediction

↓

Interpolation

↓

Reconciliation

↓

Next Network Tick
```

---

# Relación con el Framework ECS

El Multiplayer se integra con:

- Runtime;
- Scheduler;
- Entity Registry;
- Component Registry;
- Resource Registry;
- Query Engine;
- Event Bus;
- Save System;
- Debug Tools;
- Profiler.

Sin introducir dependencias directas con el gameplay.

---

# Relación con el Siguiente Documento

El siguiente documento de la fase corresponde a la definición de las herramientas avanzadas de desarrollo, depuración e infraestructura del Framework (según la planificación general del proyecto), donde se especificarán los mecanismos de soporte para inspección, automatización y mantenimiento del Runtime.

---

# Resultado Esperado

Con este documento queda completamente especificada la implementación del **Framework Multiplayer** de **Survivors Lords**.

La arquitectura define una infraestructura de red modular, escalable y completamente desacoplada del gameplay, basada en un modelo **Server Authoritative**, capaz de sincronizar múltiples Runtime ECS mediante replicación determinista de entidades y Components, integración con el Scheduler, los Registries y el Save System, y preparada para evolucionar hacia arquitecturas distribuidas, servicios externos y optimizaciones futuras sin alterar la API pública ni los principios fundamentales del Framework.

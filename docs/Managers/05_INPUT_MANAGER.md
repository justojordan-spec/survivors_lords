# Network Manager

**Estado:** Draft

---

# Objetivo

El Network Manager es responsable de coordinar toda la infraestructura de comunicación multijugador del proyecto.

Su función es administrar el estado de la sesión de red, las conexiones entre peers y la sincronización de la aplicación, proporcionando una interfaz uniforme para el resto de los sistemas.

No implementa lógica de gameplay ni contiene reglas específicas del juego.

---

# Filosofía

El sistema de red debe permanecer completamente desacoplado de la lógica de gameplay.

Los distintos sistemas expresan su intención de sincronizar información o consultar el estado de la conexión, mientras que el Network Manager se encarga de administrar la comunicación utilizando la arquitectura Host-Client definida para el proyecto.

La infraestructura de red debe ser transparente para los sistemas consumidores.

---

# Arquitectura

El Network Manager es un AutoLoad disponible durante toda la ejecución de la aplicación.

Su responsabilidad consiste en coordinar:

- Creación de sesiones.
- Unión a partidas.
- Gestión de conexiones.
- Desconexiones.
- Estado de la red.
- Sincronización general.

No administra directamente Entities, Components ni lógica de juego.

---

# Responsabilidades

El Network Manager es responsable de:

- Crear sesiones multijugador.
- Conectarse a servidores.
- Finalizar sesiones.
- Gestionar clientes conectados.
- Supervisar el estado de la conexión.
- Coordinar la sincronización de red.
- Notificar eventos relacionados con la conectividad.

No es responsable de:

- IA.
- Gameplay.
- Inventarios.
- Guardado.
- UI.
- Escenas.
- Audio.

---

# API Pública

La API pública deberá permitir operaciones como:

- Crear una sesión.
- Unirse a una sesión existente.
- Finalizar una sesión.
- Desconectarse.
- Consultar el estado de la red.
- Consultar si el peer actual posee autoridad.
- Obtener información de los peers conectados.

La implementación concreta será documentada durante el desarrollo.

---

# Flujo de funcionamiento

El flujo general será:

1. Solicitud de inicio o unión a una sesión.
2. Validación de la operación.
3. Establecimiento de la conexión.
4. Inicialización de la sesión.
5. Comunicación entre peers.
6. Sincronización continua.
7. Finalización o desconexión.
8. Liberación de recursos.

Todo el proceso será coordinado por el Network Manager.

---

# Dependencias

El Network Manager podrá interactuar con:

- Game Manager.
- Scene Manager.
- Save Manager.
- EventBus.
- Resource Manager.

Siempre mediante sus APIs públicas.

No deberá depender de Components específicos.

---

# Integración con el resto del proyecto

Todos los sistemas que requieran operaciones relacionadas con el modo multijugador deberán utilizar el Network Manager.

Las llamadas RPC, la gestión de peers y los detalles del transporte de red permanecerán encapsulados dentro de este Manager o de los sistemas especializados de networking.

---

# Consideraciones para Claude

Al generar código:

- Mantener completamente separadas la infraestructura de red y la lógica de gameplay.
- Respetar el modelo Host-Client.
- Diseñar el sistema pensando en la futura compatibilidad con Dedicated Server.
- Centralizar la gestión de conexiones.
- Evitar dependencias directas con la implementación de transporte.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar RPCs utilizados directamente desde sistemas de gameplay.
- Verificar que la autoridad permanezca correctamente definida.
- Validar la independencia entre networking y gameplay.
- Identificar posibles acoplamientos innecesarios.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado para la gestión de la infraestructura de red, capaz de soportar el modelo Host-Client del proyecto y evolucionar hacia Dedicated Server sin requerir cambios significativos en la lógica de gameplay.
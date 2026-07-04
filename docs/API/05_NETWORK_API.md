# Network API

**Estado:** Draft

---

# Objetivo

Este documento define el contrato de comunicación entre los sistemas del proyecto y la arquitectura de red.

La Network API proporciona una interfaz uniforme para todas las operaciones relacionadas con el modo multijugador, permitiendo que los distintos sistemas interactúen con la red sin depender de detalles de implementación.

Su propósito es mantener una arquitectura desacoplada, escalable y preparada para servidores dedicados.

---

# Filosofía

La red es un servicio del proyecto, no una responsabilidad de los sistemas de gameplay.

Managers, Components y demás módulos deben expresar únicamente su intención de sincronizar información o ejecutar una acción remota.

La Network API es responsable de canalizar dicha comunicación respetando el modelo Host-Client definido por la arquitectura.

---

# Arquitectura

Toda comunicación de red deberá realizarse mediante la API pública del sistema de networking.

Los sistemas podrán:

- Solicitar el envío de información.
- Consultar el estado de la conexión.
- Obtener información sobre clientes conectados.
- Recibir notificaciones de eventos de red.

Ningún sistema deberá depender directamente de RPCs, Peer IDs o detalles internos del transporte de red.

---

# Responsabilidades

La Network API debe permitir:

- Gestionar conexiones.
- Gestionar desconexiones.
- Sincronizar datos entre peers.
- Ejecutar acciones remotas autorizadas.
- Informar el estado de la sesión de red.
- Notificar eventos relevantes relacionados con la conectividad.

La API no debe contener lógica de gameplay.

---

# Convenciones

Toda operación de red deberá respetar las siguientes reglas:

- Validar la autoridad antes de ejecutar acciones.
- Mantener una separación clara entre datos locales y datos sincronizados.
- Evitar sincronizar información innecesaria.
- Minimizar el tráfico de red.
- Mantener independencia respecto al tipo de servidor utilizado.

La lógica de red deberá permanecer transparente para los sistemas consumidores.

---

# Integración con el resto del proyecto

La Network API podrá ser utilizada por:

- Managers
- Components
- Systems
- AI
- Save System
- UI
- Gameplay

Los sistemas deberán interactuar únicamente con la API pública, sin depender de la implementación del transporte de red.

---

# Consideraciones para Claude

Al generar código:

- Utilizar únicamente la Network API para operaciones multijugador.
- No invocar RPCs directamente desde sistemas de gameplay salvo que la arquitectura lo permita explícitamente.
- Mantener separada la lógica de negocio de la lógica de sincronización.
- Respetar el modelo de autoridad definido por el proyecto.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar dependencias directas con la implementación de red.
- Verificar el cumplimiento del modelo Host-Client.
- Validar que las responsabilidades de networking permanezcan centralizadas.
- Identificar posibles problemas de sincronización o autoridad.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Proporcionar una interfaz de red uniforme, desacoplada y estable que permita a todos los sistemas del proyecto interactuar con el modo multijugador sin depender de detalles internos de implementación, facilitando la escalabilidad y la compatibilidad con servidores dedicados.
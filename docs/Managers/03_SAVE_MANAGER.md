# Save Manager

**Estado:** Draft

---

# Objetivo

El Save Manager es el responsable de coordinar todas las operaciones de persistencia del proyecto.

Su función es administrar el proceso de guardado y carga de información, proporcionando una interfaz única para que los distintos sistemas puedan almacenar y restaurar su estado.

No conoce la lógica de gameplay de los sistemas que participan en la persistencia.

---

# Filosofía

El guardado debe ser un servicio centralizado.

Cada sistema es responsable únicamente de proporcionar y restaurar sus propios datos.

El Save Manager coordina el proceso completo, pero no interpreta el significado de la información almacenada.

Esta separación permite mantener una arquitectura modular y facilita la evolución del sistema de persistencia.

---

# Arquitectura

El Save Manager es un AutoLoad disponible durante toda la ejecución del juego.

Coordina las operaciones de guardado y carga solicitando información a los sistemas correspondientes y administrando el proceso de persistencia.

Los detalles del formato de almacenamiento permanecen encapsulados dentro del sistema de guardado.

---

# Responsabilidades

El Save Manager es responsable de:

- Iniciar operaciones de guardado.
- Iniciar operaciones de carga.
- Coordinar la recopilación de datos.
- Coordinar la restauración del estado.
- Gestionar múltiples slots de guardado.
- Validar operaciones de persistencia.
- Informar el resultado de cada operación.

No es responsable de:

- Administrar datos de gameplay.
- Interpretar información específica de Components.
- Gestionar archivos manualmente desde otros sistemas.

---

# API Pública

La API pública deberá permitir operaciones como:

- Crear un nuevo guardado.
- Cargar una partida existente.
- Sobrescribir un guardado.
- Eliminar un guardado.
- Consultar los slots disponibles.
- Verificar la existencia de partidas guardadas.
- Obtener información resumida de un guardado.

La implementación concreta será documentada durante el desarrollo.

---

# Flujo de funcionamiento

El proceso general será:

1. Solicitud de guardado o carga.
2. Validación de la operación.
3. Comunicación con los sistemas participantes.
4. Recopilación o restauración de datos.
5. Confirmación del resultado.
6. Notificación mediante Signals o EventBus cuando corresponda.

Todo el flujo será coordinado exclusivamente por el Save Manager.

---

# Dependencias

El Save Manager podrá interactuar con:

- Game Manager.
- Resource Manager.
- Network Manager.
- EventBus.

Y con cualquier sistema que participe en la persistencia, siempre mediante las APIs definidas.

---

# Integración con el resto del proyecto

Todos los sistemas que necesiten persistir información deberán hacerlo exclusivamente mediante el Save Manager.

Ningún Manager, Component o Scene deberá acceder directamente al sistema de archivos.

Esta centralización garantiza consistencia y facilita futuras mejoras en la arquitectura de persistencia.

---

# Consideraciones para Claude

Al generar código:

- Centralizar todas las operaciones de guardado y carga.
- Evitar accesos directos al sistema de archivos.
- Mantener desacoplada la lógica de persistencia del gameplay.
- Diseñar un sistema preparado para futuras versiones y migraciones de datos.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar accesos directos al sistema de archivos.
- Verificar que el Save Manager actúe únicamente como coordinador.
- Validar la correcta separación entre persistencia y lógica de negocio.
- Identificar posibles dependencias innecesarias con el formato de almacenamiento.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema de persistencia centralizado, modular y escalable que permita guardar y restaurar el estado del juego de forma consistente, desacoplada y preparada para futuras ampliaciones, como versionado de partidas, sincronización en red o almacenamiento alternativo.
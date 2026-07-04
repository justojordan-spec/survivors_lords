# DEBUG TOOLS

**Documento:** 10_DEBUG_TOOLS.md

**Fase:** ECS Framework

**Estado:** Draft

**Versión:** 1.0

---

# Objetivo

Este documento define la arquitectura de las herramientas de depuración (Debug Tools) del Framework ECS de Survivors Lords.

Su objetivo es proporcionar un conjunto de utilidades que permitan inspeccionar el estado interno del Framework durante el desarrollo, facilitando la detección de errores, la validación del comportamiento del ECS y el análisis del rendimiento.

Las Debug Tools nunca forman parte de la lógica de gameplay.

Nunca modifican el comportamiento del Framework.

Su única responsabilidad consiste en observar, registrar y visualizar información.

---

# Alcance

Este documento define:

- Arquitectura de Debug.
- Debug Manager.
- Debug Overlay.
- Inspectores.
- Visualizadores.
- Logging.
- Métricas.
- Profiling.
- Validaciones.
- Herramientas para ECS.
- Herramientas para Multiplayer.
- Herramientas para Performance.
- Integración con el Framework.

---

# Filosofía

El Framework debe ser completamente observable.

Todo estado interno relevante debe poder inspeccionarse durante el desarrollo sin modificar el comportamiento del sistema.

Las herramientas de Debug nunca deben introducir dependencias hacia los Systems de gameplay.

---

# Objetivos

Las Debug Tools deben garantizar:

- Observabilidad.
- Bajo acoplamiento.
- Activación opcional.
- Impacto mínimo en rendimiento.
- Información consistente.
- Integración con todo el Framework.

---

# Arquitectura General

Conceptualmente.

```text
Framework

↓

Debug Manager

↓

Inspectors

↓

Visualizers

↓

Overlay

↓

Developer
```

---

# Principios Fundamentales

Las herramientas de Debug deben cumplir las siguientes reglas:

- Nunca modifican el ECS.
- Nunca modifican Components.
- Nunca alteran Queries.
- Nunca cambian el Scheduler.
- Nunca afectan la simulación.

Su funcionamiento debe ser exclusivamente de lectura.

---

# Debug Manager

El Debug Manager centraliza todas las herramientas de depuración del Framework.

Sus responsabilidades incluyen:

- Registrar herramientas.
- Activar o desactivar módulos.
- Recolectar métricas.
- Coordinar overlays.
- Gestionar perfiles de depuración.

---

# Arquitectura Modular

Cada herramienta de Debug debe implementarse como un módulo independiente.

Conceptualmente.

```text
Debug Manager

↓

Entity Inspector

↓

Component Inspector

↓

Query Inspector

↓

Profiler

↓

Network Inspector
```

Cada módulo puede habilitarse o deshabilitarse de forma individual.

---

# Modos de Ejecución

El Framework contempla distintos niveles de depuración.

Ejemplo conceptual.

```text
Disabled

↓

Basic

↓

Advanced

↓

Full
```

El nivel seleccionado determina la cantidad de información recopilada.

---

# Activación

Las Debug Tools solo deben estar disponibles en:

- Editor.
- Builds de desarrollo.
- Builds de testing.

Nunca deben ejecutarse en una build final de producción.

---

# Debug Overlay

El Debug Overlay representa la interfaz visual del sistema de depuración.

Puede mostrar información como:

- FPS.
- Tick actual.
- Número de Entities.
- Número de Components.
- Memoria utilizada.
- Estado del Scheduler.

Toda la información debe actualizarse en tiempo real.

---

# Organización

El Overlay debe organizar la información por categorías.

Ejemplo.

```text
ECS

Scheduler

Networking

Performance

Memory

Events
```

Esto facilita la navegación durante el desarrollo.

---

# Entity Inspector

El Entity Inspector permite visualizar todas las Entities activas del ECS.

Para cada Entity pueden mostrarse:

- Entity ID.
- Estado.
- Componentes asociados.
- Tags.
- Metadata de depuración.

Nunca modifica la Entity inspeccionada.

---

# Component Inspector

El Component Inspector permite visualizar los Components asociados a una Entity.

Ejemplo conceptual.

```text
Entity 120

↓

Transform

Health

Inventory

Equipment
```

Su función es exclusivamente informativa.

---

# Query Inspector

El Query Inspector muestra:

- Queries registradas.
- Número de resultados.
- Tiempo de actualización.
- Estado del caché.
- Frecuencia de uso.

Permite detectar Queries costosas o incorrectamente diseñadas.

---

# Continúa en la Parte 2

La siguiente parte desarrollará:

- Event Inspector.
- Scheduler Inspector.
- Resource Inspector.
- Multiplayer Inspector.
- Memory Inspector.
- Performance Profiler.
- Logging.
- Validaciones.
- Integración con el Framework.
```
---

# Event Inspector

El Event Inspector permite visualizar toda la actividad del Event Bus durante la ejecución.

Su objetivo es facilitar el análisis del flujo de comunicación entre Systems.

Nunca modifica ni intercepta Events.

Únicamente observa su recorrido.

---

# Información Mostrada

Para cada Event pueden visualizarse:

- Event ID.
- Tipo.
- Tick de creación.
- Emisor.
- Destinatarios.
- Estado.
- Tiempo de procesamiento.

---

# Flujo de Visualización

Conceptualmente.

```text
Event Published

↓

Event Queue

↓

Dispatch

↓

Subscribers

↓

Completed
```

Esto permite verificar que todos los Events recorran correctamente el pipeline.

---

# Scheduler Inspector

El Scheduler Inspector muestra el estado del Scheduler en tiempo real.

Entre otros datos:

- Stage actual.
- Systems ejecutándose.
- Orden de ejecución.
- Tiempo consumido.
- Deferred Commands pendientes.
- Event Queue.

---

# Visualización del Pipeline

Conceptualmente.

```text
Input

↓

Simulation

↓

Combat

↓

Events

↓

Rendering
```

Esta representación facilita identificar bloqueos o problemas de orden de ejecución.

---

# Resource Inspector

El Resource Inspector permite inspeccionar el Resource Registry.

Debe mostrar:

- Resources registrados.
- Tipo.
- ID.
- Estado.
- Dependencias.
- Referencias.

También puede informar Resources inválidos o duplicados.

---

# Entity Relationship Inspector

Esta herramienta permite visualizar relaciones entre Entities.

Ejemplo.

```text
Kingdom

↓

Settlement

↓

NPC

↓

Inventory

↓

Item
```

Resulta especialmente útil para detectar referencias rotas.

---

# Component Dependency Inspector

El Framework puede mostrar qué Components participan en cada Query.

Conceptualmente.

```text
Movement Query

↓

Transform

Velocity

Movement Input
```

Esto facilita validar la composición de Signatures.

---

# Memory Inspector

El Memory Inspector recopila estadísticas sobre el uso de memoria del Framework.

Ejemplos:

- Entities activas.
- Components activos.
- Pools.
- Buffers.
- Cachés.
- Resources.

Su finalidad es detectar consumo anómalo.

---

# Pool Inspector

El Framework puede mostrar el estado de todos los Object Pools.

Información útil:

- Capacidad.
- Objetos utilizados.
- Objetos libres.
- Reutilizaciones.
- Expansiones.

Esto permite optimizar la administración de memoria.

---

# Multiplayer Inspector

El Multiplayer Inspector muestra el estado del Multiplayer Pipeline.

Entre otros datos:

- Clientes conectados.
- Tick actual.
- Latencia.
- Snapshots enviados.
- Snapshots recibidos.
- Delta Replication.
- Interest Management.

---

# Snapshot Inspector

Debe ser posible inspeccionar el contenido de cualquier Snapshot.

Conceptualmente.

```text
Snapshot

↓

Entities

↓

Components

↓

Metadata
```

Nunca modifica la información mostrada.

---

# Prediction Inspector

Durante el desarrollo puede visualizarse:

- Estado predicho.
- Estado oficial.
- Error de predicción.
- Rollbacks.
- Reconciliaciones.
- Inputs pendientes.

Esto facilita ajustar el comportamiento del cliente.

---

# Performance Profiler

El Framework debe incluir un profiler integrado.

Su objetivo es medir tiempos de ejecución sin modificar la lógica del ECS.

Debe poder registrar:

- Tiempo por System.
- Tiempo por Stage.
- Tiempo del Scheduler.
- Tiempo de Queries.
- Tiempo de Events.
- Tiempo de Replicación.

---

# Frame Timeline

El profiler puede representar gráficamente el Frame.

Conceptualmente.

```text
Input

████

Simulation

██████

Combat

███

Events

██

Rendering

████
```

Esto facilita localizar cuellos de botella.

---

# Logging

El Framework debe incorporar un sistema centralizado de Logging.

Todos los módulos utilizan la misma infraestructura.

Nunca escriben directamente en consola.

---

# Niveles de Log

Conceptualmente.

```text
Trace

↓

Debug

↓

Info

↓

Warning

↓

Error

↓

Critical
```

Cada nivel representa una prioridad diferente.

---

# Registro de Errores

Los errores registrados deben contener suficiente información para reproducir el problema.

Ejemplo.

- Tick.
- System.
- Entity.
- Component.
- Descripción.
- Stack de depuración cuando corresponda.

---

# Validaciones

Durante el desarrollo el Framework debe detectar automáticamente:

- Entities inválidas.
- Components duplicados.
- Queries inconsistentes.
- Resources inexistentes.
- Events mal registrados.
- Dependencias circulares.
- Violaciones del Scheduler.

Estas validaciones pueden desactivarse en producción.

---

# Continúa en la Parte 3

La siguiente parte desarrollará:

- Métricas.
- Profiling avanzado.
- Estadísticas.
- Optimización.
- Herramientas de visualización.
- Buenas prácticas.
- Anti-patrones.
- Convenciones.
- Estado final del documento.
---

# Métricas

El Framework debe recopilar métricas de forma continua durante la ejecución.

Estas métricas permiten evaluar el comportamiento general del ECS sin modificar la simulación.

Toda la recolección debe ser opcional y configurable.

---

# Categorías de Métricas

Las métricas pueden agruparse en las siguientes categorías:

- ECS.
- Scheduler.
- Systems.
- Components.
- Entities.
- Queries.
- Events.
- Resources.
- Multiplayer.
- Memoria.
- Rendimiento.

Cada categoría debe poder habilitarse de manera independiente.

---

# Métricas del ECS

El Framework puede registrar información como:

- Entities activas.
- Entities creadas.
- Entities destruidas.
- Components activos.
- Components añadidos.
- Components eliminados.
- Archetypes activos (si la implementación los utiliza).
- Tiempo de actualización del ECS.

---

# Métricas del Scheduler

El Scheduler debe registrar:

- Tick actual.
- Duración de cada Tick.
- Tiempo por Stage.
- Systems ejecutados.
- Tiempo de espera.
- Deferred Commands procesados.
- Events despachados.

---

# Métricas de Queries

El Query System puede recopilar:

- Queries registradas.
- Queries activas.
- Tiempo de Matching.
- Tiempo de iteración.
- Tamaño promedio de Result Sets.
- Invalidaciones de caché.

Estas métricas ayudan a detectar consultas costosas.

---

# Métricas de Resources

El Resource Registry puede registrar:

- Resources cargados.
- Tiempo de carga.
- Referencias resueltas.
- Recursos inválidos.
- Dependencias detectadas.
- Uso de caché.

---

# Métricas de Multiplayer

El Multiplayer Pipeline puede mostrar:

- Ping.
- Jitter.
- Pérdida de paquetes.
- Snapshots enviados.
- Snapshots recibidos.
- Deltas generados.
- Ancho de banda utilizado.
- Tiempo de reconciliación.

---

# Historial

El Framework puede mantener un historial limitado de métricas.

Conceptualmente.

```text
Frame 120

↓

Frame 121

↓

Frame 122

↓

Frame 123
```

Esto permite analizar tendencias y detectar problemas intermitentes.

---

# Exportación

Las herramientas de Debug pueden exportar información para su análisis posterior.

Ejemplos:

- Logs.
- Métricas.
- Estadísticas.
- Reportes de rendimiento.

El formato de exportación dependerá de la implementación final.

---

# Visualización

Las métricas deben poder representarse mediante:

- Tablas.
- Contadores.
- Gráficos.
- Barras temporales.
- Diagramas de ejecución.

La representación elegida no afecta al funcionamiento del Framework.

---

# Alertas

El Debug Manager puede generar alertas cuando determinados valores superan umbrales configurables.

Ejemplos:

- Tiempo de Frame elevado.
- Exceso de Entities.
- Uso excesivo de memoria.
- Latencia alta.
- Queries demasiado costosas.

Las alertas tienen únicamente finalidad informativa.

---

# Profiling Avanzado

El Framework puede realizar sesiones de profiling completas.

Durante una sesión pueden registrarse:

- Tiempo exacto por System.
- Tiempo de serialización.
- Tiempo de carga de Resources.
- Tiempo de construcción de Snapshots.
- Tiempo de procesamiento de Events.
- Tiempo de reconstrucción de Queries.

---

# Captura de Estado

Las herramientas de Debug pueden capturar una instantánea del estado interno del Framework.

Conceptualmente.

```text
Capture

↓

Entities

↓

Components

↓

Scheduler

↓

Queries

↓

Resources
```

Estas capturas facilitan reproducir errores complejos.

---

# Integración con el Framework

Las Debug Tools interactúan con:

- Scheduler.
- ECS.
- Entity Registry.
- Component Registry.
- Query System.
- Event Bus.
- Resource Registry.
- Save Pipeline.
- Multiplayer Pipeline.

Sin embargo, siempre mantienen una política estricta de solo lectura.

---

# Impacto en Rendimiento

Cuando las herramientas de Debug están deshabilitadas:

- No deben generar asignaciones adicionales.
- No deben ejecutar validaciones.
- No deben recopilar métricas.
- No deben modificar el Scheduler.

El impacto sobre una build de producción debe ser prácticamente nulo.

---

# Buenas Prácticas

Se recomienda:

- Activar únicamente los módulos necesarios.
- Utilizar perfiles de depuración específicos para cada tarea.
- Revisar periódicamente las métricas de rendimiento.
- Analizar Queries costosas.
- Supervisar el crecimiento de memoria.
- Validar automáticamente durante el desarrollo.

---

# Anti-Patrones

El Framework prohíbe expresamente:

- Modificar el ECS desde una herramienta de Debug.
- Alterar Components durante una inspección.
- Cambiar el orden del Scheduler.
- Crear lógica de gameplay dentro de herramientas de depuración.
- Mantener Debug Tools activas en producción.
- Introducir dependencias desde los Systems hacia los módulos de Debug.

---

# Convenciones

Todas las Debug Tools deberán cumplir las siguientes reglas:

- Son opcionales.
- Son modulares.
- Son de solo lectura.
- No afectan la simulación.
- No modifican el ECS.
- No alteran el comportamiento de los Systems.
- Pueden deshabilitarse completamente.

---

# Resumen de la Arquitectura

```text
Framework
        │
        ▼
Debug Manager
        │
        ├──────────────► ECS Inspector
        ├──────────────► Scheduler Inspector
        ├──────────────► Query Inspector
        ├──────────────► Event Inspector
        ├──────────────► Resource Inspector
        ├──────────────► Multiplayer Inspector
        ├──────────────► Profiler
        ├──────────────► Logger
        └──────────────► Debug Overlay
```

---

# Garantías del Sistema de Debug

Cuando las Debug Tools están habilitadas, el Framework garantiza que:

- Toda la información mostrada refleja el estado actual del Framework.
- Ninguna herramienta modifica el ECS.
- Todas las métricas son consistentes.
- Los inspectores trabajan exclusivamente sobre datos de lectura.
- El comportamiento del juego permanece inalterado.

---

# Relación con el Framework

Las Debug Tools proporcionan una capa transversal de observabilidad sobre todos los subsistemas del Framework.

Su responsabilidad exclusiva consiste en:

**Permitir inspeccionar, validar, medir y diagnosticar el comportamiento interno del Framework ECS sin alterar su funcionamiento.**

---

# Estado

**Estado actual:** Especificación de las Debug Tools.

Este documento define el contrato técnico para la implementación de las herramientas de depuración del Framework ECS de Survivors Lords.

Toda funcionalidad de inspección, validación, métricas o profiling deberá implementarse siguiendo esta arquitectura. Cualquier modificación a la infraestructura de Debug deberá documentarse mediante una DEC (Design Engineering Change) antes de su implementación.
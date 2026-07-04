# TESTING GUIDE

**Documento:** 11_TESTING_GUIDE.md

**Fase:** ECS Framework

**Estado:** Draft

**Versión:** 1.0

---

# Objetivo

Este documento define la estrategia de pruebas del Framework ECS de Survivors Lords.

Su propósito es establecer los principios, procesos y herramientas necesarios para verificar que la implementación del Framework sea correcta, determinista, estable y mantenible a lo largo del desarrollo del proyecto.

Este documento no define pruebas de gameplay.

No define pruebas de balance.

No define QA de contenido.

Define exclusivamente la estrategia de validación técnica del Framework ECS.

---

# Alcance

Este documento define:

- Filosofía de Testing.
- Estrategia de pruebas.
- Tipos de pruebas.
- Unit Testing.
- Integration Testing.
- System Testing.
- Regression Testing.
- Multiplayer Testing.
- Performance Testing.
- Stress Testing.
- Automatización.
- Cobertura.
- Validaciones.
- Buenas prácticas.

---

# Filosofía

Todo componente del Framework debe poder verificarse de forma aislada.

Las pruebas deben ser:

- Repetibles.
- Deterministas.
- Automatizables.
- Independientes.
- Rápidas.

El objetivo es detectar errores lo antes posible y evitar regresiones.

---

# Objetivos

La estrategia de Testing debe garantizar:

- Correctitud funcional.
- Estabilidad.
- Determinismo.
- Compatibilidad entre versiones.
- Escalabilidad.
- Facilidad de mantenimiento.

---

# Principios Fundamentales

Toda prueba debe cumplir las siguientes reglas:

- Produce siempre el mismo resultado bajo las mismas condiciones.
- No depende del orden de ejecución de otras pruebas.
- No comparte estado con otras pruebas.
- No modifica datos permanentes.
- Puede ejecutarse automáticamente.

---

# Pirámide de Testing

Conceptualmente.

```text
           End-to-End
         ──────────────
        Integration Tests
     ─────────────────────
         Unit Tests
──────────────────────────────
```

La mayor parte de las pruebas debe concentrarse en Unit Tests.

---

# Categorías de Pruebas

El Framework contempla las siguientes categorías:

- Unit Tests.
- Integration Tests.
- System Tests.
- Multiplayer Tests.
- Performance Tests.
- Stress Tests.
- Regression Tests.

Cada categoría posee objetivos específicos.

---

# Unit Testing

Los Unit Tests verifican el comportamiento de una única unidad del Framework.

Ejemplos:

- Entity Registry.
- Component Registry.
- Query Builder.
- Event Queue.
- Resource Loader.

Cada prueba debe ejecutarse de forma completamente aislada.

---

# Objetivos de los Unit Tests

Permiten validar:

- Entradas válidas.
- Entradas inválidas.
- Casos límite.
- Errores esperados.
- Contratos públicos.

Cada Unit Test debe centrarse en una única responsabilidad.

---

# Integration Testing

Las pruebas de integración verifican la interacción entre múltiples módulos.

Ejemplos.

```text
Scheduler

↓

Query System

↓

Event Bus
```

El objetivo es comprobar que la comunicación entre sistemas sea correcta.

---

# System Testing

Los System Tests validan un subsistema completo.

Ejemplos:

- Save Pipeline.
- Multiplayer Pipeline.
- Resource Loading.
- Debug Tools.

Cada prueba debe recorrer el flujo completo del subsistema.

---

# Regression Testing

Toda corrección de un error debe incorporar una prueba de regresión.

El objetivo es impedir que el mismo problema vuelva a aparecer en el futuro.

Las pruebas de regresión nunca deben eliminarse.

---

# Continúa en la Parte 2

La siguiente parte desarrollará:

- Multiplayer Testing.
- Performance Testing.
- Stress Testing.
- Automatización.
- Cobertura.
- Métricas.
- Buenas prácticas.
- Anti-patrones.
- Estado final del documento.
---

# Multiplayer Testing

El Multiplayer Pipeline requiere una estrategia de pruebas específica debido a su naturaleza distribuida.

Las pruebas deben verificar que la sincronización del ECS permanezca consistente entre servidor y clientes.

---

# Objetivos

Las pruebas multijugador deben garantizar:

- Consistencia del estado.
- Sincronización correcta.
- Determinismo.
- Correcta reconciliación.
- Correcta replicación.
- Ausencia de desincronizaciones permanentes.

---

# Escenarios de Prueba

Como mínimo deben contemplarse los siguientes escenarios:

- Un cliente.
- Múltiples clientes.
- Unión de clientes en una partida iniciada.
- Desconexión de clientes.
- Reconexión.
- Latencia elevada.
- Pérdida de paquetes.
- Llegada de paquetes fuera de orden.

---

# Validación de Snapshots

Las pruebas deben verificar:

- Construcción correcta.
- Serialización.
- Deserialización.
- Delta Replication.
- Reconstrucción del estado.
- Integridad de los datos.

Cada Snapshot debe representar exactamente el estado del ECS para el Tick correspondiente.

---

# Pruebas de Reconciliación

Las pruebas deben comprobar:

- Rollback correcto.
- Reaplicación de Inputs.
- Corrección del estado.
- Ausencia de acumulación de errores.
- Estabilidad visual.

---

# Performance Testing

Las pruebas de rendimiento miden el comportamiento del Framework bajo condiciones normales.

El objetivo no es encontrar errores funcionales, sino cuellos de botella.

---

# Métricas de Rendimiento

Entre otras, deben medirse:

- Tiempo por Frame.
- Tiempo por Tick.
- Tiempo del Scheduler.
- Tiempo por System.
- Tiempo de Queries.
- Tiempo del Event Bus.
- Tiempo de Replicación.
- Tiempo del Save Pipeline.

---

# Escalabilidad

Las pruebas deben ejecutarse con diferentes tamaños de mundo.

Ejemplos conceptuales.

```text
100 Entities

↓

1.000 Entities

↓

10.000 Entities

↓

100.000 Entities
```

El comportamiento debe permanecer predecible.

---

# Stress Testing

Las pruebas de estrés buscan llevar el Framework hasta sus límites operativos.

Ejemplos:

- Gran cantidad de Entities.
- Alto número de Components.
- Miles de Events por Tick.
- Elevada carga de red.
- Guardados frecuentes.
- Creación y destrucción masiva de Entities.

El objetivo es observar el comportamiento bajo condiciones extremas.

---

# Recuperación

También deben verificarse escenarios de recuperación.

Ejemplos:

- Error durante la carga.
- Error de red.
- Resource inválido.
- Snapshot corrupto.
- Fallo durante la serialización.

El Framework debe permanecer consistente después de cada error.

---

# Automatización

Todas las pruebas del Framework deben poder ejecutarse automáticamente.

La automatización permite:

- Detectar regresiones.
- Validar cambios.
- Integrarse con procesos de integración continua.
- Reducir errores humanos.

---

# Ejecución Repetible

Toda prueba automatizada debe producir exactamente el mismo resultado cuando:

- Los datos iniciales son idénticos.
- La configuración es idéntica.
- El orden de ejecución es idéntico.

---

# Cobertura

La cobertura debe incluir todos los módulos críticos del Framework.

Entre ellos:

- Entity Registry.
- Component Registry.
- Scheduler.
- Query System.
- Event Bus.
- Resource Loader.
- Save Pipeline.
- Multiplayer Pipeline.

Las áreas críticas deben priorizarse sobre la cobertura porcentual.

---

# Casos Límite

Las pruebas deben contemplar situaciones extremas.

Ejemplos:

- Cero Entities.
- Una sola Entity.
- Componentes vacíos.
- IDs máximos.
- Referencias inexistentes.
- Grandes volúmenes de datos.
- Entradas inválidas.

---

# Validaciones

Durante las pruebas el Framework debe verificar automáticamente:

- Integridad del ECS.
- Consistencia de Queries.
- Referencias válidas.
- Estado del Scheduler.
- Sincronización de Components.
- Correcto funcionamiento del Event Bus.

---

# Continúa en la Parte 3

La siguiente parte desarrollará:

- Reportes.
- Métricas.
- Herramientas de Testing.
- Integración con Debug.
- Buenas prácticas.
- Anti-patrones.
- Convenciones.
- Estado final del documento.
---

# Reportes

Toda ejecución de pruebas debe generar un reporte con información suficiente para analizar los resultados.

Como mínimo, el reporte debe incluir:

- Fecha y hora de ejecución.
- Versión del Framework.
- Conjunto de pruebas ejecutadas.
- Cantidad de pruebas.
- Pruebas exitosas.
- Pruebas fallidas.
- Tiempo total de ejecución.
- Errores detectados.

---

# Registro de Resultados

Los resultados deben conservar suficiente contexto para facilitar la reproducción de errores.

Ejemplo.

```text
Test

↓

Input

↓

Resultado Esperado

↓

Resultado Obtenido

↓

Estado
```

---

# Reporte de Fallos

Cuando una prueba falla, el Framework debe registrar información adicional como:

- Nombre de la prueba.
- Módulo afectado.
- Tick de simulación (si corresponde).
- Entity involucrada.
- Component involucrado.
- Mensaje descriptivo.
- Stack de depuración cuando esté disponible.

El objetivo es reducir el tiempo necesario para localizar el problema.

---

# Métricas

Además del resultado de las pruebas, el Framework puede recopilar métricas como:

- Tiempo promedio por prueba.
- Tiempo máximo.
- Tiempo mínimo.
- Uso máximo de memoria.
- Cobertura alcanzada.
- Cantidad de validaciones ejecutadas.

Estas métricas permiten evaluar la evolución del proyecto.

---

# Herramientas de Testing

La infraestructura de Testing debe integrarse con el resto del Framework.

Conceptualmente.

```text
Testing

↓

Scheduler

↓

ECS

↓

Queries

↓

Events

↓

Resources
```

Cada prueba utiliza los mismos contratos públicos que utilizará la implementación real.

---

# Integración con Debug Tools

Las Debug Tools complementan el proceso de Testing.

Durante la ejecución de pruebas pueden utilizarse para:

- Inspeccionar Entities.
- Visualizar Queries.
- Analizar Snapshots.
- Revisar métricas.
- Detectar pérdidas de rendimiento.

Las herramientas de Debug nunca reemplazan a las pruebas automatizadas.

---

# Integración Continua

La arquitectura de Testing debe ser compatible con procesos de Integración Continua (CI).

Cada cambio relevante en el Framework debería permitir ejecutar automáticamente:

- Unit Tests.
- Integration Tests.
- Regression Tests.
- Performance Tests básicos.

El objetivo es detectar problemas antes de integrar cambios al proyecto principal.

---

# Criterios de Aceptación

Una funcionalidad del Framework se considera lista para integración cuando:

- Implementa el contrato definido por la documentación.
- Supera todas las pruebas unitarias.
- Supera las pruebas de integración correspondientes.
- No introduce regresiones.
- Mantiene un rendimiento aceptable.

---

# Buenas Prácticas

Se recomienda:

- Escribir pruebas junto con la implementación.
- Mantener las pruebas pequeñas y específicas.
- Nombrar claramente cada caso de prueba.
- Evitar dependencias entre pruebas.
- Automatizar todas las validaciones posibles.
- Incorporar una prueba de regresión por cada error corregido.

---

# Anti-Patrones

El Framework prohíbe expresamente:

- Compartir estado entre pruebas.
- Depender del orden de ejecución.
- Ignorar pruebas intermitentes.
- Modificar la lógica del Framework para facilitar una prueba.
- Eliminar pruebas de regresión.
- Ejecutar pruebas utilizando datos inconsistentes o no deterministas.

---

# Convenciones

Todas las pruebas deberán cumplir las siguientes reglas:

- Son deterministas.
- Son reproducibles.
- Son independientes.
- Son automatizables.
- Son rápidas siempre que sea posible.
- Utilizan exclusivamente interfaces públicas del Framework.
- No modifican datos persistentes del proyecto.

---

# Resumen de la Estrategia

```text
Unit Tests
        │
        ▼
Integration Tests
        │
        ▼
System Tests
        │
        ▼
Multiplayer Tests
        │
        ▼
Performance Tests
        │
        ▼
Stress Tests
        │
        ▼
Regression Tests
```

Cada nivel incrementa el alcance de la validación mientras mantiene la base de pruebas unitarias como principal mecanismo de detección temprana de errores.

---

# Garantías del Framework

Siguiendo esta estrategia de Testing, el Framework garantiza que:

- Los módulos pueden verificarse de forma aislada.
- La integración entre subsistemas puede validarse automáticamente.
- Las regresiones pueden detectarse de manera temprana.
- El comportamiento determinista puede comprobarse de forma repetible.
- Las pruebas proporcionan una base sólida para la evolución del Framework.

---

# Relación con el Framework

La infraestructura de Testing interactúa con:

- Scheduler.
- Entity Registry.
- Component Registry.
- Query System.
- Event Bus.
- Resource Registry.
- Save Pipeline.
- Multiplayer Pipeline.
- Debug Tools.

Sin embargo, mantiene una única responsabilidad:

**Verificar de forma sistemática que el Framework ECS cumple los contratos definidos por su arquitectura y continúa haciéndolo a medida que evoluciona el proyecto.**

---

# Estado

**Estado actual:** Especificación de la estrategia de Testing.

Este documento define el contrato técnico para la implementación del proceso de validación del Framework ECS de Survivors Lords.

Toda prueba del Framework deberá ajustarse a las directrices aquí establecidas. Cualquier modificación a la estrategia de Testing, automatización, cobertura o criterios de validación deberá documentarse mediante una DEC (Design Engineering Change) antes de su implementación.
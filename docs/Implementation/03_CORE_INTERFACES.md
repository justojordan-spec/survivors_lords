# 03 - CORE INTERFACES

# Parte 1 — Filosofía y Arquitectura de Contratos

---

# Objetivo

Este documento define la arquitectura de contratos utilizada por el Framework ECS de Survivors Lords.

Mientras que los documentos anteriores describen la estructura física del Framework y el proceso de inicialización, este documento establece cómo se comunican los distintos módulos sin depender de implementaciones concretas.

Las interfaces constituyen uno de los pilares fundamentales de la arquitectura, ya que permiten desacoplar completamente los distintos subsistemas del Framework.

---

# Alcance

Este documento define:

- La filosofía de contratos del Framework.
- Qué se considera una interfaz.
- Cómo representar interfaces en GDScript.
- Reglas de implementación.
- Contratos públicos.
- Contratos internos.
- Ciclo de vida de las interfaces.
- Restricciones arquitectónicas.

No define:

- Implementación de Systems.
- Gameplay.
- Componentes.
- Resources.
- Algoritmos internos.

---

# Filosofía

Todo el Framework debe construirse alrededor de contratos.

Los módulos nunca deben depender de implementaciones concretas.

Siempre deben depender de capacidades definidas mediante interfaces.

La implementación puede cambiar.

El contrato no.

---

# Objetivo de los Contratos

Los contratos existen para:

- Reducir acoplamiento.
- Facilitar pruebas.
- Permitir reemplazos.
- Facilitar mantenimiento.
- Garantizar consistencia.
- Permitir evolución del Framework.

---

# ¿Qué es una Interface?

Dentro del Framework, una Interface representa un contrato de comportamiento.

No contiene lógica de negocio.

No almacena estado.

No toma decisiones.

Únicamente define aquello que una implementación promete ofrecer.

---

# Interfaces en GDScript

GDScript no posee soporte nativo para interfaces como otros lenguajes orientados a objetos.

Por este motivo el Framework adopta una representación propia.

Una interfaz será implementada mediante una clase base abstracta cuya única responsabilidad es definir el contrato público esperado.

Las implementaciones concretas heredarán de dicha clase.

---

# Interfaces como Contratos

El Framework considera que una interfaz es un acuerdo entre dos módulos.

Ese acuerdo define:

- Responsabilidades.
- Operaciones disponibles.
- Restricciones.
- Garantías.
- Estado esperado.

No define cómo se realiza el trabajo internamente.

---

# Inversión de Dependencias

Todos los módulos deben depender de contratos.

Nunca de implementaciones.

Ejemplo conceptual:

```text
Scheduler

↓

ISystem
```

Nunca:

```text
Scheduler

↓

MovementSystem
```

El Scheduler no necesita conocer qué System ejecuta.

Solo necesita conocer el contrato que todos los Systems cumplen.

---

# Contratos Estables

Las interfaces deben evolucionar lentamente.

Las implementaciones pueden cambiar con frecuencia.

Los contratos deben permanecer estables.

Modificar una interfaz implica modificar todo el ecosistema que depende de ella.

Por ello debe considerarse un cambio arquitectónico.

---

# Interfaces Públicas

Una interfaz pública puede ser utilizada por cualquier módulo del Framework.

Representa un contrato estable.

Debe mantenerse compatible durante la evolución del Framework.

Ejemplos:

- IEntityRegistry
- IComponentRegistry
- IEventBus
- IQueryEngine
- IScheduler

---

# Interfaces Internas

No todos los contratos son públicos.

Algunas interfaces existen únicamente para organizar internamente un subsistema.

Estas interfaces:

- no deben exponerse;
- pueden evolucionar con mayor libertad;
- no forman parte de la API pública del Framework.

---

# API Pública del Framework

La API pública del Framework está formada exclusivamente por las interfaces públicas.

Las implementaciones concretas nunca forman parte de la API.

Esto permite sustituir una implementación sin afectar al resto del sistema.

---

# Responsabilidad Única

Cada interfaz debe representar una única responsabilidad.

Incorrecto:

```text
IWorldManager

• Crear entidades
• Guardar partida
• Ejecutar Systems
• Emitir eventos
```

Correcto:

```text
IEntityRegistry

ISavePipeline

IScheduler

IEventBus
```

Cada contrato representa una única capacidad.

---

# Interfaces Pequeñas

Se prefieren interfaces pequeñas.

Un contrato reducido es:

- más fácil de comprender;
- más fácil de implementar;
- más fácil de probar;
- más estable.

---

# Principio de Segregación

Una implementación nunca debe verse obligada a implementar métodos que no necesita.

Si una interfaz comienza a crecer demasiado, debe dividirse.

Ejemplo conceptual:

```text
IRegistry
```

Puede convertirse en:

```text
IReadRegistry

IWriteRegistry

IRegistryValidation
```

Cada contrato representa una responsabilidad específica.

---

# Estado

Las interfaces no deben almacenar estado interno.

El estado pertenece a las implementaciones.

Los contratos únicamente describen capacidades.

---

# Lógica

Las interfaces no contienen lógica de negocio.

No ejecutan algoritmos.

No administran datos.

No realizan validaciones complejas.

Toda la lógica pertenece a las implementaciones concretas.

---

# Herencia entre Interfaces

La herencia debe utilizarse con moderación.

Solo cuando exista una verdadera relación de especialización.

Ejemplo:

```text
IInitializable

↓

IBootstrapService
```

No debe utilizarse únicamente para reutilizar métodos.

---

# Composición

Siempre que sea posible debe preferirse la composición de contratos.

Ejemplo:

```text
Scheduler

implementa

IInitializable

IDisposable

IProfilable
```

En lugar de construir jerarquías profundas.

---

# Descubrimiento de Capacidades

El Framework debe descubrir capacidades mediante interfaces y no mediante comprobaciones de tipos concretos.

Incorrecto:

```text
if object is Scheduler
```

Correcto:

```text
if object implements IScheduler
```

Esto reduce el acoplamiento entre módulos.

---

# Sustitución de Implementaciones

Cualquier implementación debe poder ser reemplazada por otra siempre que respete el mismo contrato.

Por ejemplo:

```text
DefaultEventBus
```

podría sustituirse por:

```text
BufferedEventBus
```

sin modificar el resto del Framework.

---

# Independencia de Implementación

Los consumidores de una interfaz no deben asumir:

- estructuras internas;
- algoritmos;
- colecciones utilizadas;
- optimizaciones;
- almacenamiento;
- estrategias de caché.

Solo deben depender del contrato público.

---

# Versionado

Toda modificación incompatible de una interfaz constituye un cambio de arquitectura.

Antes de modificar un contrato público deben evaluarse:

- impacto;
- compatibilidad;
- migración;
- pruebas;
- documentación.

---

# Documentación Obligatoria

Cada interfaz del Framework deberá documentar al menos:

- Objetivo.
- Responsabilidad.
- Implementadores esperados.
- Dependencias permitidas.
- Dependencias prohibidas.
- Garantías.
- Restricciones.
- Ciclo de vida.

Las implementaciones concretas no deben redefinir el contrato.

---

# Convenciones de Nomenclatura

Todas las interfaces utilizarán el prefijo **I**.

Ejemplos:

```text
IEntityRegistry
IComponentRegistry
IEventBus
IQueryEngine
IScheduler
IResourceRegistry
```

Las implementaciones no utilizarán dicho prefijo.

Ejemplos:

```text
EntityRegistry
EventBus
Scheduler
```

---

# Principios Arquitectónicos

Toda interfaz del Framework debe cumplir los siguientes principios:

- Responsabilidad única.
- Bajo acoplamiento.
- Alta cohesión.
- Independencia de implementación.
- Estabilidad.
- Claridad.
- Reutilización.
- Facilidad de prueba.
- Compatibilidad con la arquitectura ECS.

---

# Resultado Esperado

Al finalizar esta primera parte, el Framework dispone de una filosofía clara para el diseño de contratos.

Los módulos dejan de depender de implementaciones concretas y pasan a comunicarse exclusivamente mediante interfaces estables, pequeñas y bien definidas.

Este modelo constituye la base sobre la que se construirán todos los subsistemas descritos en los documentos posteriores de la fase **Implementation**.
# 03 - CORE INTERFACES

# Parte 2 — Interfaces Base del Framework

---

# Objetivo

Además de las interfaces específicas de cada subsistema (Entity Registry, Event Bus, Scheduler, etc.), el Framework define un conjunto de interfaces transversales que representan capacidades comunes.

Estas interfaces no pertenecen a un módulo concreto.

Representan comportamientos reutilizables que pueden ser implementados por cualquier servicio del Framework.

Su objetivo es evitar duplicación de lógica, unificar el ciclo de vida de los servicios y facilitar la construcción de herramientas de depuración, pruebas y automatización.

---

# Filosofía

Las interfaces base representan **capacidades**, no **tipos**.

Por ejemplo:

Un Scheduler es un Scheduler.

Pero además puede ser:

- Inicializable.
- Reiniciable.
- Validable.
- Depurable.
- Perfilable.

Estas capacidades son independientes entre sí.

Un servicio puede implementar una, varias o ninguna.

---

# Interfaces Base Definidas

El Framework define las siguientes interfaces transversales.

```text
IInitializable

IDisposable

IResettable

IValidatable

IIdentifiable

IConfigurable

IDebuggable

IProfilable

ISerializable

IVersioned
```

Estas interfaces constituyen la base común del Runtime.

---

# IInitializable

## Objetivo

Representa cualquier objeto que requiera un proceso explícito de inicialización antes de poder utilizarse.

---

## Responsabilidad

Permitir al Bootstrap controlar el orden de creación de servicios sin conocer su implementación.

---

## Casos de uso

Ejemplos:

- Scheduler
- Event Bus
- Query Engine
- Resource Registry
- Save Pipeline

---

## Garantías

Una implementación debe garantizar que:

- puede inicializarse una única vez;
- no entra en estado operativo antes de inicializarse;
- informa claramente errores de inicialización.

---

## Restricciones

La inicialización no debe:

- crear gameplay;
- iniciar Systems;
- lanzar eventos de gameplay;
- depender del orden de carga del SceneTree.

---

# IDisposable

## Objetivo

Representa un objeto capaz de liberar correctamente sus recursos.

---

## Responsabilidad

Garantizar un cierre limpio del Framework.

---

## Casos de uso

- Scheduler
- Event Bus
- Query Engine
- Multiplayer
- Save Pipeline

---

## Garantías

Una implementación debe liberar:

- referencias;
- buffers;
- cachés;
- suscripciones;
- recursos temporales.

---

## Restricciones

Dispose nunca debe:

- reinicializar el objeto;
- reiniciar el Runtime;
- reconstruir recursos.

Su única función es liberar.

---

# IResettable

## Objetivo

Permitir devolver un objeto a un estado inicial sin destruir su instancia.

---

## Casos de uso

Muy útil para:

- pruebas automatizadas;
- reinicio de mundos;
- benchmarks;
- pools.

---

## Garantías

Después del Reset:

- el objeto conserva su identidad;
- elimina su estado interno;
- puede reutilizarse.

---

## Ejemplo

Un Query Cache puede vaciarse sin destruir el Query Engine.

---

# IValidatable

## Objetivo

Representa cualquier objeto capaz de verificar su propia consistencia.

---

## Casos de uso

- Bootstrap
- Registries
- Resources
- Scheduler

---

## Validaciones típicas

Ejemplos:

- dependencias satisfechas;
- datos completos;
- estado consistente;
- registros válidos;
- referencias correctas.

---

## Beneficio

Permite al Bootstrap verificar automáticamente el estado del Framework.

---

# IIdentifiable

## Objetivo

Representa un objeto que posee una identidad única dentro del Runtime.

---

## Casos de uso

- Systems
- Resources
- Queries
- Eventos registrados

---

## Garantías

La identidad debe ser:

- estable;
- única;
- inmutable durante el ciclo de vida del objeto.

---

# IConfigurable

## Objetivo

Representa un objeto cuya configuración proviene de fuentes externas.

---

## Casos de uso

- Scheduler
- Save Pipeline
- Multiplayer
- Debug Tools

---

## Restricciones

La configuración nunca debe codificarse dentro de la implementación.

Debe obtenerse mediante Resources o mecanismos definidos por el Framework.

---

# IDebuggable

## Objetivo

Permitir que un objeto exponga información útil para herramientas de depuración.

---

## Casos de uso

- Event Bus
- Scheduler
- Query Engine
- Entity Registry

---

## Información esperada

Ejemplos:

- estado interno;
- estadísticas;
- tamaño de cachés;
- cantidad de entidades;
- uso de memoria;
- colas pendientes.

---

## Restricción

Las funciones de depuración nunca deben modificar el estado del Runtime.

---

# IProfilable

## Objetivo

Permitir recopilar métricas de rendimiento.

---

## Casos de uso

- Scheduler
- Queries
- Event Bus
- Save Pipeline

---

## Información esperada

Ejemplos:

- tiempo de ejecución;
- cantidad de operaciones;
- uso de CPU;
- memoria utilizada;
- tiempos promedio;
- tiempos máximos.

---

## Objetivo arquitectónico

Separar completamente la recopilación de métricas de la lógica principal.

---

# ISerializable

## Objetivo

Representar cualquier objeto capaz de participar en el proceso de persistencia.

---

## Casos de uso

- Resources
- Configuración
- Estados internos
- Metadata

---

## Restricciones

La serialización debe representar únicamente el estado necesario.

Nunca debe serializar:

- referencias temporales;
- caches;
- objetos del SceneTree;
- datos reconstruibles.

---

# IVersioned

## Objetivo

Representar objetos cuya estructura puede evolucionar entre versiones.

---

## Casos de uso

- Save Pipeline
- Resources
- Configuración

---

## Beneficios

Facilita:

- migraciones;
- compatibilidad;
- actualización de datos antiguos.

---

# Interfaces Componibles

Las interfaces base fueron diseñadas para combinarse libremente.

Ejemplo conceptual:

```text
Scheduler

↓

IInitializable

↓

IDisposable

↓

IProfilable

↓

IDebuggable
```

No existe una jerarquía obligatoria.

Cada implementación adopta únicamente las capacidades que necesita.

---

# Interfaces Opcionales

Ninguna interfaz base es obligatoria por sí misma.

Cada módulo implementará únicamente aquellas capacidades que sean coherentes con su responsabilidad.

Ejemplo:

Una excepción (`ECSException`) probablemente no implementará `IProfilable`.

Un `Scheduler` sí.

---

# Compatibilidad

Las interfaces base deben permanecer extremadamente estables.

Constituyen los cimientos del Framework.

Agregar una nueva capacidad es sencillo.

Modificar una existente requiere una revisión arquitectónica completa.

---

# Reutilización

Siempre que una nueva funcionalidad represente una capacidad transversal, deberá evaluarse primero si corresponde:

- ampliar una interfaz existente;
- crear una nueva interfaz base.

No deben añadirse métodos arbitrarios a contratos ya definidos.

---

# Matriz de Capacidades

La siguiente tabla resume las capacidades esperadas de los principales subsistemas del Framework.

| Subsistema | Init | Dispose | Reset | Validate | Debug | Profile | Serialize | Version |
|------------|:----:|:-------:|:-----:|:--------:|:-----:|:-------:|:----------:|:-------:|
| Bootstrap | ✓ | ✓ | ✗ | ✓ | ✓ | ✓ | ✗ | ✗ |
| Scheduler | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✗ |
| Event Bus | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✗ |
| Query Engine | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✗ |
| Entity Registry | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✗ |
| Component Registry | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✗ |
| Resource Registry | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| Save Pipeline | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| Multiplayer | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✗ |

La tabla representa capacidades esperadas y no una obligación de herencia directa.

---

# Resultado Esperado

Con estas interfaces base, el Framework dispone de un conjunto uniforme de capacidades transversales que pueden aplicarse de forma consistente a cualquier subsistema.

Esto simplifica el Bootstrap, favorece la automatización de pruebas, mejora las herramientas de depuración y proporciona una base estable sobre la que construir las interfaces específicas de cada módulo, desarrolladas en la siguiente parte de este documento.
# 03 - CORE INTERFACES

# Parte 3A — Interfaces Públicas del Framework (Core, Entities, Components y Systems)

---

# Objetivo

Esta sección define los contratos públicos principales utilizados por el Runtime ECS.

Estas interfaces representan la API oficial del Framework.

Todos los subsistemas deben comunicarse utilizando estos contratos y nunca mediante implementaciones concretas.

Cada implementación deberá cumplir exactamente las responsabilidades aquí descritas.

---

# IECSContext

## Objetivo

Representa el contexto global del Runtime ECS.

Es el punto de acceso controlado a los servicios principales del Framework.

No contiene lógica de gameplay.

No contiene estado del mundo.

Su única responsabilidad es exponer los contratos públicos del Runtime.

---

## Responsabilidades

Debe proporcionar acceso a:

- Entity Registry
- Component Registry
- Event Bus
- Query Engine
- Scheduler
- Resource Registry
- Save Pipeline
- Multiplayer Runtime

No debe crear servicios.

No debe destruir servicios.

No debe administrar su ciclo de vida.

---

## Garantías

Una implementación debe garantizar:

- acceso consistente durante toda la ejecución;
- referencias válidas;
- contratos estables;
- ausencia de referencias nulas una vez finalizado el Bootstrap.

---

## Dependencias Permitidas

Puede depender únicamente de interfaces públicas.

Nunca de implementaciones concretas.

---

# IECSRuntime

## Objetivo

Representa el Runtime completo del Framework.

Es el responsable de coordinar el ciclo de vida global del ECS.

---

## Responsabilidades

Debe permitir:

- iniciar el Runtime;
- detener el Runtime;
- reiniciar el Runtime;
- consultar su estado;
- acceder al Context.

---

## No es Responsable de

- ejecutar Systems;
- crear entidades;
- administrar Components;
- emitir eventos.

Estas responsabilidades pertenecen a otros módulos.

---

## Garantías

Debe mantener un estado consistente durante toda la ejecución.

---

# IEntityRegistry

## Objetivo

Administrar el ciclo de vida de todas las entidades del Runtime.

Es el único contrato autorizado para crear o destruir entidades.

---

## Responsabilidades

Debe permitir:

- crear entidades;
- destruir entidades;
- validar entidades;
- consultar existencia;
- recuperar identificadores;
- reciclar identificadores cuando corresponda.

---

## Restricciones

No administra Components.

No ejecuta Systems.

No emite eventos de gameplay.

No conoce Resources.

---

## Garantías

Toda entidad registrada debe poseer un identificador único y válido.

Las entidades destruidas no deben permanecer accesibles.

---

# IEntityFactory

## Objetivo

Construir entidades complejas utilizando configuraciones externas.

La Factory encapsula el proceso de creación.

---

## Responsabilidades

Debe permitir:

- crear entidades desde Resources;
- crear entidades mediante plantillas;
- aplicar configuraciones iniciales;
- devolver entidades completamente construidas.

---

## No debe

Administrar el ciclo de vida posterior de las entidades.

Una vez creada una entidad, el control pasa al Entity Registry.

---

## Beneficio

Separa la lógica de construcción del almacenamiento de entidades.

---

# IComponentRegistry

## Objetivo

Administrar todos los Components del Runtime.

Es el único contrato autorizado para registrar, añadir o eliminar Components.

---

## Responsabilidades

Debe permitir:

- registrar tipos de Components;
- añadir Components;
- eliminar Components;
- consultar existencia;
- recuperar Components;
- validar registros.

---

## Restricciones

No conoce Systems.

No ejecuta Queries.

No administra entidades.

---

## Garantías

Cada Component pertenece exactamente a una entidad.

Las operaciones deben mantener la consistencia del almacenamiento.

---

# IComponentStorage

## Objetivo

Representa el almacenamiento físico de un tipo específico de Component.

Permite desacoplar el Registry del mecanismo de almacenamiento.

---

## Responsabilidades

Debe permitir:

- insertar datos;
- eliminar datos;
- recuperar datos;
- comprobar existencia;
- iterar componentes.

---

## Implementaciones

El Framework puede ofrecer diferentes estrategias:

- Dense Arrays
- Sparse Sets
- Pools
- Estructuras optimizadas

Todas ellas deberán respetar este contrato.

---

## Beneficio

Permite optimizar el rendimiento sin modificar el resto del Framework.

---

# ISystem

## Objetivo

Representa el contrato común de todos los Systems.

Todo System del proyecto deberá implementar esta interfaz.

---

## Responsabilidades

Debe definir:

- identidad;
- estado;
- fase de ejecución;
- prioridades;
- ciclo de vida;
- punto de ejecución principal.

---

## Restricciones

Un System no debe conocer otros Systems.

Toda comunicación debe realizarse mediante:

- Events;
- Queries;
- Interfaces.

---

## Garantías

Todo System puede ser ejecutado por el Scheduler sin conocer su implementación concreta.

---

# ISystemRegistry

## Objetivo

Administrar el conjunto de Systems registrados en el Runtime.

---

## Responsabilidades

Debe permitir:

- registrar Systems;
- eliminar Systems;
- localizar Systems;
- consultar prioridades;
- consultar grupos de ejecución;
- validar dependencias.

---

## Restricciones

No ejecuta Systems.

No administra el Scheduler.

No controla el Game Loop.

---

## Beneficio

Separa completamente el almacenamiento de Systems de su ejecución.

---

# Relaciones entre Interfaces

La siguiente relación resume las dependencias permitidas entre los contratos definidos.

```text
IECSRuntime
        │
        ▼
IECSContext
        │
        ├───────────────┬────────────────┬────────────────┐
        ▼               ▼                ▼                ▼
IEntityRegistry   IComponentRegistry   ISystemRegistry   ...
        │               │
        ▼               ▼
IEntityFactory   IComponentStorage
```

Las flechas representan acceso mediante contratos públicos.

No representan dependencias hacia implementaciones concretas.

---

# Principios Comunes

Todas las interfaces descritas en esta sección deben cumplir las siguientes reglas:

- Responsabilidad única.
- Bajo acoplamiento.
- Sin referencias directas entre implementaciones.
- Sin lógica de gameplay.
- Sin conocimiento del SceneTree.
- Independencia del modo Single Player o Multiplayer.
- Compatibilidad con pruebas automatizadas.

---

# Estabilidad

Los contratos definidos en esta sección constituyen el núcleo del Framework.

Su modificación debe considerarse un cambio arquitectónico mayor.

Antes de modificar cualquiera de estas interfaces deberá evaluarse:

- compatibilidad con implementaciones existentes;
- impacto sobre el Scheduler;
- impacto sobre el Bootstrap;
- impacto sobre el Runtime;
- impacto sobre la documentación.

---

# Resultado Esperado

Al implementar estos contratos, el núcleo del Framework dispondrá de una API pública estable para gestionar el Runtime, las entidades, los componentes y los Systems.

Los documentos posteriores (`04_ENTITY_REGISTRY.md`, `05_COMPONENT_REGISTRY.md` y `06_SYSTEM_BASE.md`) utilizarán estas interfaces como base para especificar la implementación concreta de cada subsistema.
# 03 - CORE INTERFACES

# Parte 3B — Interfaces Públicas del Framework (Scheduler, Events, Queries, Resources, Save y Multiplayer)

---

# Objetivo

Esta sección completa la definición de la API pública del Framework estableciendo los contratos correspondientes a los servicios de ejecución, comunicación, consulta, recursos, persistencia y red.

Estos contratos representan los puntos de integración oficiales del Runtime.

Las implementaciones concretas podrán evolucionar con el tiempo, pero deberán respetar las responsabilidades aquí definidas.

---

# IScheduler

## Objetivo

Representa el motor responsable de ejecutar los Systems registrados.

El Scheduler coordina la ejecución del Framework.

No implementa gameplay.

No contiene lógica de negocio.

---

## Responsabilidades

Debe permitir:

- iniciar la ejecución;
- detener la ejecución;
- pausar el Runtime;
- reanudar la ejecución;
- ejecutar un ciclo completo;
- consultar el estado del Scheduler.

---

## No es Responsable de

- registrar Systems;
- crear entidades;
- administrar Components;
- emitir Events;
- ejecutar Queries.

---

## Garantías

Debe ejecutar los Systems respetando:

- orden de ejecución;
- prioridades;
- grupos de ejecución;
- dependencias;
- determinismo.

---

# IEventBus

## Objetivo

Representa el sistema oficial de comunicación desacoplada del Framework.

Todos los eventos internos deben circular a través de este contrato.

---

## Responsabilidades

Debe permitir:

- publicar eventos;
- registrar suscriptores;
- eliminar suscripciones;
- despachar eventos;
- consultar estadísticas del bus.

---

## Restricciones

No conoce los Systems.

No conoce el gameplay.

No interpreta los eventos.

No ejecuta lógica asociada.

---

## Garantías

Todo evento publicado llegará únicamente a los suscriptores compatibles.

El orden de despacho deberá seguir la política definida por el Event Bus.

---

# IEventSubscription

## Objetivo

Representa una suscripción registrada dentro del Event Bus.

Permite encapsular la relación entre un emisor y un receptor sin acoplar ambos módulos.

---

## Responsabilidades

Debe representar:

- tipo de evento;
- receptor;
- prioridad;
- estado;
- política de cancelación.

---

## Beneficio

Permite administrar suscripciones como objetos independientes.

---

# IQuery

## Objetivo

Representa una consulta ECS preparada para localizar entidades.

Una Query describe qué entidades interesan.

No ejecuta la búsqueda.

---

## Responsabilidades

Debe describir:

- Components requeridos;
- Components opcionales;
- Components excluidos;
- filtros;
- restricciones.

---

## Restricciones

No accede directamente a entidades.

No conoce el almacenamiento interno.

No ejecuta iteraciones.

---

# IQueryEngine

## Objetivo

Representa el motor encargado de resolver Queries.

---

## Responsabilidades

Debe permitir:

- registrar Queries;
- ejecutar Queries;
- reutilizar Queries;
- invalidar cachés;
- optimizar búsquedas.

---

## Garantías

Dos Queries equivalentes deben producir el mismo conjunto de entidades para un mismo estado del Runtime.

---

## Restricciones

No modifica entidades.

No añade Components.

No elimina Components.

---

# IResourceRegistry

## Objetivo

Administrar todos los Resources utilizados por el Framework.

Representa el punto único de acceso a la configuración compartida.

---

## Responsabilidades

Debe permitir:

- registrar Resources;
- localizar Resources;
- reemplazar Resources;
- validar Resources;
- consultar disponibilidad.

---

## Restricciones

No carga archivos.

No serializa datos.

No administra Assets del juego.

---

# IResourceLoader

## Objetivo

Representa el servicio encargado de cargar Resources desde su origen.

---

## Responsabilidades

Debe permitir:

- localizar archivos;
- cargar Resources;
- validar versiones;
- notificar errores de carga.

---

## Beneficio

Separa completamente la carga física del registro lógico.

---

# ISavePipeline

## Objetivo

Representa la infraestructura oficial de persistencia del Framework.

---

## Responsabilidades

Debe permitir:

- iniciar un guardado;
- iniciar una carga;
- serializar estado;
- restaurar estado;
- validar versiones.

---

## Restricciones

No conoce gameplay.

No interpreta datos específicos del juego.

No administra archivos directamente.

---

## Garantías

Toda operación de persistencia debe ser:

- consistente;
- determinista;
- recuperable ante errores.

---

# ISerializer

## Objetivo

Representa un contrato genérico para transformar datos entre memoria y formato persistente.

---

## Responsabilidades

Debe permitir:

- serializar;
- deserializar;
- validar formato;
- informar incompatibilidades.

---

## Beneficio

Permite sustituir el formato de persistencia sin modificar el resto del Framework.

---

# INetworkRuntime

## Objetivo

Representa la infraestructura de ejecución Multiplayer.

No implementa reglas del juego.

Únicamente proporciona los servicios necesarios para la sincronización del Runtime.

---

## Responsabilidades

Debe permitir:

- iniciar la sesión de red;
- finalizar la sesión;
- consultar el modo de ejecución;
- sincronizar el estado del Runtime;
- informar el estado de conexión.

---

## Restricciones

No interpreta gameplay.

No ejecuta RPC específicos del juego.

No decide autoridad sobre reglas de negocio.

---

# IReplicationService

## Objetivo

Representa el servicio responsable de replicar el estado del ECS entre instancias del Runtime.

---

## Responsabilidades

Debe permitir:

- registrar elementos replicables;
- generar snapshots;
- aplicar snapshots;
- detectar cambios;
- sincronizar diferencias.

---

## Garantías

La replicación debe respetar:

- determinismo;
- autoridad del servidor;
- consistencia del estado;
- orden de aplicación.

---

# Relaciones entre Interfaces

```text
                IScheduler
                     │
                     ▼
              ISystemRegistry

IEventBus ───────────────► IEventSubscription

IQueryEngine ────────────► IQuery

IResourceLoader ─────────► IResourceRegistry

ISavePipeline ───────────► ISerializer

INetworkRuntime ─────────► IReplicationService
```

Las relaciones representan dependencias funcionales entre contratos.

Las implementaciones concretas continúan desacopladas.

---

# Reglas Generales

Todas las interfaces descritas en esta sección deben cumplir las siguientes reglas:

- No almacenar lógica de gameplay.
- No depender del SceneTree.
- No acceder directamente a implementaciones concretas.
- Ser compatibles con pruebas automatizadas.
- Mantener contratos estables.
- Ser independientes del modo de ejecución (Single Player, Host, Cliente o Dedicated Server), salvo cuando su propia responsabilidad implique comportamiento específico de red.

---

# API Pública del Framework

Con esta sección queda definida la API pública principal del Runtime ECS.

Los documentos posteriores deberán implementar estos contratos sin alterar sus responsabilidades.

La incorporación de nuevas implementaciones deberá realizarse respetando estos contratos para garantizar la compatibilidad del Framework.

---

# Resultado Esperado

Al finalizar este documento, el Framework dispone de un conjunto completo de interfaces públicas que definen la comunicación entre todos los subsistemas principales:

- Runtime
- Context
- Entities
- Components
- Systems
- Scheduler
- Event Bus
- Query Engine
- Resource Registry
- Save Pipeline
- Multiplayer

Estos contratos constituyen la base sobre la que se desarrollará la implementación concreta de cada módulo en los documentos siguientes de la fase **Implementation**.
# 03 - CORE INTERFACES

# Parte 4 — Reglas de Implementación, Inyección de Dependencias y Buenas Prácticas

---

# Objetivo

Esta sección establece las normas obligatorias para implementar cualquier interfaz definida por el Framework ECS.

Mientras las secciones anteriores definieron los contratos públicos, esta sección especifica cómo deben implementarse, utilizarse y mantenerse durante la evolución del proyecto.

Estas reglas buscan preservar el desacoplamiento arquitectónico y garantizar que el Framework permanezca mantenible a largo plazo.

---

# Filosofía

Las interfaces existen para desacoplar módulos.

No existen para añadir una capa innecesaria de abstracción.

Una interfaz debe aparecer únicamente cuando represente un contrato estable entre dos partes del sistema.

Si una implementación nunca será sustituida, nunca será utilizada por otro módulo y no representa una capacidad pública del Framework, no debe crearse una interfaz únicamente por consistencia estética.

---

# Implementación de Interfaces en GDScript

Dado que GDScript no posee interfaces nativas, el Framework adopta el siguiente modelo.

Una interfaz se implementa mediante una clase base abstracta.

Esta clase:

- define el contrato público;
- documenta las responsabilidades;
- declara los métodos esperados;
- no contiene lógica de negocio.

Las implementaciones concretas heredan de dicha clase y proporcionan el comportamiento real.

---

# Clases Abstractas

Las clases utilizadas como interfaces deben considerarse abstractas.

No deben instanciarse directamente.

Toda instancia utilizada por el Runtime debe corresponder a una implementación concreta.

---

# Métodos Abstractos

Los métodos definidos por una interfaz representan obligaciones para la implementación.

Una implementación nunca debe omitir un método definido por el contrato.

Si un método no es aplicable, probablemente la clase está implementando una interfaz incorrecta.

---

# Responsabilidad de la Implementación

Una implementación concreta es responsable de:

- cumplir el contrato;
- mantener la consistencia interna;
- respetar las garantías documentadas;
- informar errores de manera controlada.

No debe modificar el significado del contrato.

---

# Inyección de Dependencias

Todo acceso entre módulos debe realizarse mediante interfaces.

Ejemplo conceptual:

```text
Scheduler

↓

IEventBus
```

Nunca:

```text
Scheduler

↓

EventBus
```

El Scheduler no conoce la implementación concreta.

Únicamente conoce el contrato.

---

# Resolución de Dependencias

Las dependencias deben resolverse durante el Bootstrap.

Una vez iniciado el Runtime, las referencias a servicios deben permanecer estables.

No deben buscarse servicios dinámicamente durante la ejecución normal salvo que el diseño del subsistema lo requiera explícitamente.

---

# Constructor vs Inicialización

Las implementaciones no deben realizar trabajo complejo en el constructor.

El constructor debe limitarse a crear la instancia.

La configuración y preparación del objeto deben realizarse durante la fase de inicialización controlada por el Bootstrap.

Esto garantiza un orden determinista y facilita la detección de errores.

---

# Dependencias Opcionales

Si un servicio puede operar sin otro servicio, la dependencia debe tratarse como opcional.

La ausencia de una dependencia opcional nunca debe impedir el arranque del Framework.

El comportamiento esperado en ausencia de dicha dependencia debe estar claramente documentado.

---

# Sustitución de Implementaciones

El Framework debe permitir sustituir cualquier implementación siempre que respete el mismo contrato.

Ejemplos:

```text
EventBus
```

puede reemplazarse por:

```text
BufferedEventBus
```

o

```text
ThreadedEventBus
```

sin modificar los consumidores del contrato.

---

# Compatibilidad

Las implementaciones deben ser compatibles con cualquier consumidor que utilice exclusivamente la interfaz pública.

Nunca deben requerir conversiones al tipo concreto.

Ejemplo incorrecto:

```text
var bus := event_bus as BufferedEventBus
```

Ejemplo correcto:

```text
var bus : IEventBus
```

---

# Estado Compartido

Las implementaciones no deben compartir estado mutable mediante variables globales.

El estado debe pertenecer exclusivamente a la instancia correspondiente.

Esto facilita:

- pruebas;
- reinicios;
- servidores dedicados;
- ejecución determinista.

---

# Errores

Una implementación nunca debe ocultar errores críticos.

Debe:

- detectarlos;
- registrarlos;
- informar al Bootstrap o al Runtime;
- mantener un estado consistente.

No debe continuar operando si el contrato deja de cumplirse.

---

# Versionado de Contratos

Toda modificación de una interfaz pública debe evaluarse cuidadosamente.

Se consideran cambios incompatibles:

- eliminar métodos;
- cambiar responsabilidades;
- modificar garantías;
- alterar el ciclo de vida esperado.

Siempre que sea posible se debe ampliar un contrato antes que romperlo.

---

# Extensión de Interfaces

Cuando una nueva funcionalidad no encaje en un contrato existente, debe preferirse crear una nueva interfaz antes que añadir métodos no relacionados.

Ejemplo:

Incorrecto:

```text
IEventBus

+
export_statistics()
+
serialize()
+
save()
```

Correcto:

```text
IEventBus

IProfilable

ISerializable
```

Cada interfaz mantiene una única responsabilidad.

---

# Descubrimiento de Capacidades

Los módulos no deben comprobar implementaciones concretas para determinar capacidades.

La comprobación debe realizarse sobre contratos.

Ejemplo conceptual:

```text
if service implements IProfilable
```

No:

```text
if service is Scheduler
```

Esto permite incorporar nuevas implementaciones sin modificar el código existente.

---

# Mocks y Stubs

Toda interfaz pública debe poder implementarse mediante objetos de prueba.

Esto permite:

- pruebas unitarias;
- pruebas de integración;
- simulaciones;
- benchmarks.

Los dobles de prueba deben respetar exactamente el mismo contrato que las implementaciones reales.

---

# Pruebas de Contrato

Además de probar las implementaciones, el proyecto debe validar que todas ellas cumplen los contratos definidos.

Una prueba de contrato verifica que cualquier implementación:

- responde correctamente;
- respeta las garantías;
- mantiene el ciclo de vida esperado;
- produce resultados consistentes.

Esto facilita reemplazar implementaciones sin riesgo de incompatibilidades.

---

# Evolución del Framework

La incorporación de nuevos módulos deberá seguir el mismo proceso:

1. Definir el contrato.
2. Documentar responsabilidades.
3. Implementar el contrato.
4. Crear pruebas de contrato.
5. Integrar mediante interfaces.

Nunca debe implementarse un módulo público sin un contrato previamente definido.

---

# Buenas Prácticas

Toda implementación del Framework debería seguir las siguientes recomendaciones:

- Mantener clases pequeñas.
- Evitar herencias profundas.
- Favorecer composición.
- Limitar dependencias.
- Documentar decisiones arquitectónicas relevantes.
- Evitar efectos secundarios durante la inicialización.
- Mantener métodos con una única responsabilidad.
- Exponer únicamente la API necesaria.

---

# Anti-Patrones

Se consideran prácticas prohibidas dentro del Framework:

- Acceder a implementaciones concretas desde otros módulos.
- Convertir interfaces a tipos específicos sin una justificación arquitectónica.
- Añadir métodos a una interfaz para resolver un caso puntual.
- Crear interfaces que solo tengan una implementación y ningún consumidor externo sin necesidad arquitectónica.
- Utilizar interfaces como contenedores de utilidades o lógica compartida.
- Romper contratos existentes sin un proceso de migración documentado.

---

# Relación con los Documentos Siguientes

Los documentos posteriores de la fase **Implementation** desarrollarán la implementación concreta de cada subsistema utilizando los contratos definidos aquí.

En particular:

- `04_ENTITY_REGISTRY.md` implementará `IEntityRegistry`.
- `05_COMPONENT_REGISTRY.md` implementará `IComponentRegistry`.
- `06_SYSTEM_BASE.md` implementará `ISystem`.
- `07_SCHEDULER_IMPLEMENTATION.md` implementará `IScheduler`.
- `08_EVENT_BUS_IMPLEMENTATION.md` implementará `IEventBus`.
- `09_QUERY_ENGINE_IMPLEMENTATION.md` implementará `IQueryEngine`.
- `10_RESOURCE_REGISTRY_IMPLEMENTATION.md` implementará `IResourceRegistry`.
- `11_SAVE_IMPLEMENTATION.md` implementará `ISavePipeline`.
- `12_MULTIPLAYER_IMPLEMENTATION.md` implementará `INetworkRuntime`.

Todos estos documentos deberán respetar los contratos definidos en este archivo.

---

# Resultado Esperado

Al finalizar este documento queda completamente definida la arquitectura de contratos del Framework ECS.

Las interfaces constituyen la API pública del Runtime y establecen un lenguaje común para todos los subsistemas.

Gracias a este modelo, el Framework podrá evolucionar mediante implementaciones intercambiables, con bajo acoplamiento, alta cohesión y una base sólida para pruebas automatizadas, depuración y mantenimiento a largo plazo.
# 02 - ECS DIRECTORY STRUCTURE

---

# Objetivo

Este documento define la organización física del Framework ECS dentro del proyecto **Survivors Lords**.

Mientras que la documentación de arquitectura (Fase 1) establece la estructura general del proyecto y la documentación ECS (Fase 5) define la arquitectura conceptual del Framework, este documento especifica **cómo debe materializarse dicha arquitectura en el árbol de directorios de Godot**.

Su propósito es garantizar que el Framework permanezca:

- Modular.
- Escalable.
- Fácil de mantener.
- Fácil de depurar.
- Independiente del gameplay.
- Preparado para multiplayer.
- Preparado para pruebas automatizadas.
- Preparado para herramientas de editor.

---

# Alcance

Este documento define:

- Organización física de carpetas.
- Ubicación de scripts.
- Ubicación de recursos internos del Framework.
- Separación entre Runtime y Editor.
- Separación entre implementación y gameplay.
- Organización de utilidades internas.
- Organización de herramientas de depuración.
- Organización de pruebas.

No define:

- Systems.
- Components.
- Gameplay.
- Resources del juego.
- Escenas.
- Assets.
- Contenido.

---

# Filosofía

La estructura de carpetas debe reflejar la arquitectura del Framework.

Cada carpeta debe representar una responsabilidad claramente definida.

Una carpeta nunca debe existir únicamente como agrupador visual.

Si una carpeta existe, posee una función arquitectónica específica.

---

# Principios

La organización física debe respetar los siguientes principios:

- Responsabilidad única.
- Bajo acoplamiento.
- Alta cohesión.
- Separación clara entre Runtime y Editor.
- Separación entre Framework y Gameplay.
- Escalabilidad horizontal.
- Navegación predecible.
- Dependencias unidireccionales.

---

# Separación entre Framework y Juego

Una regla fundamental del proyecto es la separación completa entre el Framework ECS y el contenido del juego.

El Framework constituye una infraestructura reutilizable.

El gameplay constituye una implementación concreta que utiliza dicha infraestructura.

Por este motivo:

- El Framework nunca debe depender del juego.
- El juego puede depender del Framework.
- El Framework nunca debe contener lógica de gameplay.
- El Framework nunca debe contener datos del juego.

---

# Organización General

Se propone la siguiente estructura para el Framework ECS.

```text
res://
│
├── core/
│   └── ecs/
│       ├── bootstrap/
│       ├── core/
│       ├── entities/
│       ├── components/
│       ├── systems/
│       ├── scheduler/
│       ├── events/
│       ├── queries/
│       ├── resources/
│       ├── save/
│       ├── multiplayer/
│       ├── debug/
│       ├── interfaces/
│       ├── utilities/
│       ├── exceptions/
│       └── testing/
│
├── gameplay/
│
├── data/
│
├── scenes/
│
├── assets/
│
├── addons/
│
└── docs/
```

---

# Estructura del Framework

La carpeta principal del Framework es:

```text
core/ecs/
```

Todo el código que implementa la infraestructura ECS debe encontrarse exclusivamente dentro de esta jerarquía.

Esto permite identificar inmediatamente qué código pertenece al motor interno y cuál pertenece al juego.

---

# Nivel Superior

El primer nivel del Framework queda organizado de la siguiente manera:

```text
ecs/
│
├── bootstrap/
├── core/
├── entities/
├── components/
├── systems/
├── scheduler/
├── events/
├── queries/
├── resources/
├── save/
├── multiplayer/
├── debug/
├── interfaces/
├── utilities/
├── exceptions/
└── testing/
```

Cada carpeta representa un subsistema del Framework.

Ninguna carpeta debe mezclar responsabilidades.

---

# Organización por Subsistemas

La estructura se organiza por responsabilidad técnica y no por tipo de archivo.

Por ejemplo:

Incorrecto:

```text
scripts/
resources/
interfaces/
```

Correcto:

```text
events/
queries/
scheduler/
```

Cada subsistema contiene todos los elementos necesarios para cumplir su función.

---

# Independencia entre Carpetas

Cada subsistema debe poder evolucionar de forma relativamente independiente.

Por ejemplo, el Event Bus puede modificarse sin afectar la organización del Query Engine.

Del mismo modo, el Scheduler puede evolucionar sin alterar la estructura del sistema de Save.

---

# Profundidad Máxima

La profundidad de carpetas debe mantenerse controlada.

Como regla general:

- Nivel 1: Subsistema.
- Nivel 2: Especialización.
- Nivel 3: Casos excepcionales.

Evitar jerarquías excesivamente profundas que dificulten la navegación.

---

# Organización Interna

Cada subsistema debe seguir una estructura consistente.

Ejemplo conceptual:

```text
events/
│
├── bus/
├── event_types/
├── subscriptions/
├── dispatch/
└── internal/
```

La organización interna debe responder a necesidades reales de implementación y no a preferencias estéticas.

---

# Convención de Crecimiento

Las carpetas no deben crearse anticipando funcionalidades futuras.

Solo deben incorporarse cuando exista una responsabilidad concreta que justifique su existencia.

Esto evita estructuras vacías y reduce la complejidad innecesaria.

---

# Separación del Gameplay

Todo el contenido específico del juego debe permanecer fuera del Framework.

Ejemplo:

```text
gameplay/
│
├── systems/
├── components/
├── entities/
├── worlds/
└── content/
```

El Framework nunca debe acceder directamente a estas carpetas.

La interacción debe realizarse mediante las interfaces y mecanismos definidos por la arquitectura ECS.

---

# Independencia de Assets

El Framework no debe contener:

- Texturas.
- Modelos.
- Audio.
- Animaciones.
- UI.
- Escenas de gameplay.

Cualquier recurso visual pertenece al proyecto del juego, no al Framework.

---

# Dependencias del Framework

El Framework únicamente puede depender de:

- API oficial de Godot.
- Sus propios módulos internos.
- Interfaces públicas definidas por el propio Framework.

No debe depender de:

- Escenas del juego.
- Prefabs del juego.
- Recursos del juego.
- Managers de gameplay.
- Sistemas específicos del proyecto.

---

# Modularidad

Cada carpeta debe poder comprenderse de forma aislada.

Un desarrollador debe poder localizar rápidamente:

- dónde se implementa un Registry;
- dónde vive el Scheduler;
- dónde se implementa el Event Bus;
- dónde residen las herramientas de depuración.

La organización física debe facilitar la comprensión del Framework sin necesidad de explorar todo el proyecto.

---

# Resultado Esperado de la Estructura

Al finalizar la organización propuesta, el Framework deberá presentar las siguientes características:

- Separación clara entre infraestructura y juego.
- Ubicación predecible de cada subsistema.
- Escalabilidad para futuras ampliaciones.
- Bajo acoplamiento entre módulos.
- Navegación sencilla para nuevos desarrolladores.
- Base sólida para la implementación descrita en los documentos siguientes de esta fase.
# 02 - ECS DIRECTORY STRUCTURE

# Parte 2 — Responsabilidades de cada Directorio

---

# Objetivo

Esta sección define la responsabilidad específica de cada directorio del Framework ECS.

Cada carpeta representa un módulo de la arquitectura.

Una carpeta nunca debe contener código perteneciente a otro módulo.

La ubicación física del código debe comunicar claramente su responsabilidad.

---

# Directorio bootstrap/

## Responsabilidad

Contiene exclusivamente el proceso de inicialización del Framework.

Es el único punto responsable de construir la infraestructura ECS.

---

## Contenido esperado

Ejemplos:

- Bootstrap principal
- Bootstrap State Machine
- Inicialización del Core
- Validaciones de inicio
- Configuración inicial
- Inicialización del Runtime

---

## No debe contener

- Gameplay
- Systems
- Components
- Queries
- Eventos del juego
- Recursos del juego

---

## Dependencias permitidas

Puede depender de:

- core/
- interfaces/

No debe depender de ningún otro subsistema durante su propia creación.

---

# Directorio core/

## Responsabilidad

Contiene los objetos centrales del Framework.

Representa el "corazón" del ECS.

Aquí residen los servicios fundamentales compartidos por todo el Framework.

---

## Contenido esperado

Ejemplos:

- ECS Core
- ECS Context
- ECS Runtime
- Service Locator interno (si se adopta)
- Estado global del Framework
- Configuración del Runtime

---

## Debe permanecer pequeño

Esta carpeta no debe convertirse en un "cajón de sastre".

Todo aquello que posea una responsabilidad propia debe vivir en su propio módulo.

---

# Directorio entities/

## Responsabilidad

Implementa toda la infraestructura relacionada con entidades.

No implementa gameplay.

No implementa componentes.

No implementa Systems.

---

## Contenido esperado

Ejemplos:

- Entity Registry
- Entity Factory
- Entity Handles
- Entity Identifiers
- Entity Validation
- Entity Pools
- Entity Lifecycle Helpers

---

## No debe contener

- Componentes
- Eventos
- Queries
- IA
- Inventario
- Combate

---

# Directorio components/

## Responsabilidad

Implementa la infraestructura de almacenamiento de Components.

No contiene los Components del juego.

Los Components del juego pertenecen a gameplay/.

Esta carpeta implementa únicamente el sistema encargado de administrarlos.

---

## Contenido esperado

Ejemplos:

- Component Registry
- Component Storage
- Sparse Sets
- Dense Arrays
- Pools
- Allocation
- Lookup
- Reflection Helpers

---

# Directorio systems/

## Responsabilidad

Contiene exclusivamente la infraestructura base para Systems.

No contiene los Systems concretos del juego.

---

## Contenido esperado

Ejemplos:

- Base System
- System Registry
- System Metadata
- Execution Context
- Priorities
- Dependency Validation

---

## No debe contener

CombatSystem

InventorySystem

AISystem

Etc.

Todos ellos pertenecen al proyecto del juego.

---

# Directorio scheduler/

## Responsabilidad

Implementa el motor que ejecuta los Systems.

Es responsable únicamente de la coordinación de ejecución.

No contiene lógica de gameplay.

---

## Contenido esperado

Ejemplos:

- Scheduler
- Execution Pipeline
- Update Loop
- Fixed Update
- Execution Groups
- System Ordering
- Dependency Resolution

---

# Directorio events/

## Responsabilidad

Implementa el Event Bus del Framework.

No contiene eventos específicos del juego.

Implementa únicamente la infraestructura de publicación y suscripción.

---

## Contenido esperado

Ejemplos:

- Event Bus
- Subscribers
- Publishers
- Dispatch Queue
- Event Metadata
- Event Registration
- Event Validation

---

# Directorio queries/

## Responsabilidad

Implementa el motor de consultas ECS.

Es responsable de localizar entidades compatibles con una determinada combinación de Components.

---

## Contenido esperado

Ejemplos:

- Query Engine
- Query Builder
- Query Cache
- Filters
- Iterators
- Query Validation

---

## No debe contener

Consultas específicas de gameplay.

---

# Directorio resources/

## Responsabilidad

Implementa la infraestructura para registrar y administrar Resources del Framework.

No contiene los Resources del juego.

---

## Contenido esperado

Ejemplos:

- Resource Registry
- Resource Cache
- Resource Loader
- Resource Validation
- Resource Providers

---

# Directorio save/

## Responsabilidad

Implementa la infraestructura del sistema de persistencia.

No contiene formatos específicos de gameplay.

---

## Contenido esperado

Ejemplos:

- Save Pipeline
- Serialization
- Deserialization
- Versionado
- Migraciones
- Snapshot Builder

---

# Directorio multiplayer/

## Responsabilidad

Implementa toda la infraestructura Multiplayer del Framework.

No implementa lógica de red del gameplay.

---

## Contenido esperado

Ejemplos:

- Replication
- Authority
- RPC Helpers
- Snapshot Sync
- Network Registry
- Network Serializer
- Client Prediction Helpers
- Rollback Helpers

---

# Directorio debug/

## Responsabilidad

Contiene todas las herramientas destinadas a inspeccionar el estado interno del Framework.

Nunca deben alterar el comportamiento normal del Runtime.

---

## Contenido esperado

Ejemplos:

- ECS Inspector
- Entity Viewer
- Component Viewer
- Scheduler Profiler
- Query Visualizer
- Event Monitor
- Runtime Statistics

---

# Directorio interfaces/

## Responsabilidad

Define todas las interfaces públicas del Framework.

Estas interfaces representan los contratos utilizados por el resto de la arquitectura.

---

## Contenido esperado

Ejemplos:

- ISystem
- IEntityRegistry
- IComponentRegistry
- IEventBus
- IQueryEngine
- IResourceRegistry
- IScheduler

---

## Importante

Las interfaces nunca deben contener implementación.

Únicamente definen contratos.

---

# Directorio utilities/

## Responsabilidad

Contiene utilidades reutilizables que no pertenecen a ningún subsistema específico.

Su uso debe mantenerse al mínimo.

---

## Contenido esperado

Ejemplos:

- Helpers matemáticos
- Utilidades de reflexión
- Helpers de colección
- Conversores
- Validadores genéricos

---

## Regla

Si una utilidad pertenece claramente a un módulo, debe vivir dentro de dicho módulo y no en utilities/.

---

# Directorio exceptions/

## Responsabilidad

Centraliza todos los errores propios del Framework.

Permite un manejo consistente de errores internos.

---

## Contenido esperado

Ejemplos:

- ECSException
- InvalidComponentException
- InvalidQueryException
- DuplicateRegistrationException
- BootstrapException
- SchedulerException

---

## Beneficios

- Mensajes consistentes
- Mejor depuración
- Errores tipificados
- Logging uniforme

---

# Directorio testing/

## Responsabilidad

Contiene toda la infraestructura de pruebas del Framework.

No contiene pruebas del juego.

---

## Contenido esperado

Ejemplos:

- Test Fixtures
- Mock Registries
- Mock Event Bus
- Mock Scheduler
- Fake Resources
- Benchmark Tools
- Performance Tests
- Integration Tests

---

## Objetivo

Permitir validar el Framework sin depender del contenido del proyecto.

---

# Resumen Arquitectónico

Cada módulo posee una única responsabilidad claramente definida.

La organización física del código debe reflejar exactamente la arquitectura conceptual documentada en las fases anteriores.

Esta separación facilita:

- Escalabilidad.
- Mantenimiento.
- Depuración.
- Reutilización.
- Desarrollo paralelo.
- Automatización de pruebas.
- Evolución futura del Framework sin introducir acoplamientos innecesarios.
# 02 - ECS DIRECTORY STRUCTURE

# Parte 3 — Convenciones, Dependencias y Reglas Arquitectónicas

---

# Objetivo

Esta sección establece las reglas obligatorias que deben respetarse durante la implementación del Framework ECS.

Mientras las secciones anteriores definieron la organización física de directorios y la responsabilidad de cada módulo, esta sección define las normas que garantizan la consistencia del código a medida que el Framework evolucione.

Estas reglas son de cumplimiento obligatorio para todo el código perteneciente al Framework.

---

# Convención General

La estructura de carpetas debe ser estable en el tiempo.

Las carpetas representan responsabilidades arquitectónicas y no deben reorganizarse por preferencias personales.

Mover un módulo implica modificar la arquitectura del Framework y debe considerarse una decisión de diseño, no una tarea de mantenimiento.

---

# Convenciones de Nombres

## Directorios

Todos los directorios deben utilizar:

- minúsculas
- palabras completas
- separación mediante "_"
- nombres descriptivos

Ejemplos:

```text
component_registry/
event_dispatch/
query_cache/
resource_loader/
```

Evitar:

```text
cmp/
misc/
utils2/
new/
temp/
test1/
```

---

## Scripts

Los nombres de scripts deben representar claramente la responsabilidad de la clase.

Ejemplos:

```text
entity_registry.gd
component_registry.gd
event_bus.gd
query_engine.gd
scheduler.gd
bootstrap.gd
```

Evitar:

```text
manager.gd
system.gd
core2.gd
new_scheduler.gd
helper_final.gd
```

---

## Clases

Todas las clases del Framework deben utilizar PascalCase.

Ejemplos:

```text
EntityRegistry
ComponentRegistry
EventBus
QueryEngine
Scheduler
Bootstrap
```

---

## Interfaces

Todas las interfaces deben comenzar con el prefijo **I**.

Ejemplos:

```text
IEntityRegistry
IComponentRegistry
IEventBus
IQueryEngine
IScheduler
```

---

# Regla de Responsabilidad

Cada archivo debe tener una única responsabilidad.

No deben existir clases "gigantes" que implementen múltiples subsistemas.

Si una clase comienza a asumir varias responsabilidades, debe dividirse.

---

# Organización de Archivos

Como regla general:

- un archivo
- una clase principal
- una responsabilidad

Esto facilita:

- lectura
- depuración
- pruebas
- reutilización

---

# Dependencias Permitidas

Las dependencias entre módulos deben ser unidireccionales.

El siguiente diagrama representa el flujo permitido.

```text
Bootstrap

↓

Core

↓

Registries

↓

Resources

↓

Systems

↓

Scheduler

↓

Runtime
```

Nunca deben existir dependencias en sentido contrario.

---

# Dependencias Prohibidas

Quedan expresamente prohibidas las siguientes situaciones.

## Systems → Bootstrap

Un System nunca puede acceder al Bootstrap.

---

## Components → Systems

Los Components contienen únicamente datos.

Nunca conocen a los Systems.

---

## Resources → Gameplay

Los Resources del Framework no conocen el juego.

---

## Event Bus → Scheduler

El Event Bus no controla el Scheduler.

---

## Query Engine → Event Bus

Las Queries no deben emitir eventos automáticamente.

---

## Save → Multiplayer

Ambos subsistemas son independientes.

La coordinación entre ellos corresponde al nivel superior del Framework.

---

# Comunicación entre Subsistemas

Los módulos del Framework únicamente pueden comunicarse mediante:

- Interfaces
- Eventos
- Consultas (Queries)
- Contratos públicos

Nunca mediante referencias directas a implementaciones concretas.

---

# Regla de Importación

Un módulo únicamente puede importar aquello que realmente necesita.

Las importaciones innecesarias deben eliminarse.

Esto reduce el acoplamiento y mejora la claridad del código.

---

# Referencias Circulares

No deben existir referencias circulares.

Ejemplo incorrecto:

```text
Scheduler

↓

EventBus

↓

Scheduler
```

Ejemplo correcto:

```text
Scheduler

↓

IEventBus
```

---

# Separación Runtime / Editor

Todo código utilizado únicamente por herramientas del editor debe permanecer aislado del Runtime.

Ejemplo:

```text
debug/editor/

debug/runtime/
```

El Runtime nunca debe depender del código exclusivo del editor.

---

# Separación Runtime / Testing

Las herramientas de prueba tampoco forman parte del Runtime.

Ejemplo:

```text
testing/

fixtures/

mocks/

benchmarks/
```

El Framework debe poder compilar y ejecutarse sin incluir la infraestructura de pruebas.

---

# Código Experimental

No deben existir carpetas como:

```text
experimental/
prototype/
old/
backup/
```

El repositorio debe contener únicamente código vigente.

Las pruebas de concepto deben mantenerse fuera de la rama principal.

---

# Recursos Temporales

Archivos temporales no deben almacenarse dentro del Framework.

Ejemplos prohibidos:

```text
temp.gd
copy.gd
backup.gd
old_system.gd
```

El historial de versiones pertenece al sistema de control de versiones, no a la estructura del proyecto.

---

# Escalabilidad

La estructura propuesta debe permitir incorporar nuevos módulos sin reorganizar los existentes.

Ejemplo:

```text
ecs/

events/
queries/
scheduler/
resources/
metrics/
profiling/
analytics/
```

La incorporación de un nuevo subsistema no debe afectar la ubicación de los demás.

---

# Crecimiento Controlado

Antes de crear una nueva carpeta deben responderse las siguientes preguntas:

- ¿Representa una responsabilidad nueva?
- ¿No pertenece ya a otro módulo?
- ¿Será utilizada por más de un archivo?
- ¿Mejora realmente la organización?

Si la respuesta es negativa, la carpeta no debe crearse.

---

# Reglas para Nuevos Módulos

Todo nuevo módulo deberá definir explícitamente:

- Objetivo.
- Responsabilidad.
- Dependencias permitidas.
- Dependencias prohibidas.
- Interfaces públicas.
- Ciclo de vida.
- Estrategia de pruebas.

No deben incorporarse módulos "informales".

---

# Validación Arquitectónica

Durante el desarrollo debe verificarse periódicamente que:

- No existan dependencias circulares.
- Cada carpeta conserve una única responsabilidad.
- No aparezcan referencias al gameplay dentro del Framework.
- No existan implementaciones duplicadas.
- Las interfaces permanezcan estables.
- Los contratos públicos continúen siendo compatibles.

Estas validaciones pueden automatizarse mediante herramientas de análisis estático en el futuro.

---

# Compatibilidad con Godot

La organización del Framework debe respetar las convenciones del motor, pero no depender de características específicas que dificulten futuras actualizaciones.

Siempre que sea posible:

- evitar rutas rígidas;
- evitar dependencias implícitas del árbol de nodos;
- preferir composición sobre herencia;
- desacoplar la lógica del SceneTree.

---

# Preparación para Escalabilidad

La estructura aquí definida debe soportar sin reorganización significativa:

- Nuevos tipos de Systems.
- Nuevos Registries.
- Nuevos mecanismos de persistencia.
- Nuevos modelos de red.
- Herramientas de depuración adicionales.
- Integración con herramientas externas.
- Servidores dedicados.
- Automatización de pruebas.
- Hot Reload del Framework.

---

# Resultado Esperado

Al aplicar las reglas definidas en este documento, el Framework ECS debe presentar una organización física que refleje fielmente su arquitectura conceptual.

Cada módulo tendrá una responsabilidad claramente delimitada, las dependencias permanecerán controladas y el crecimiento futuro del proyecto podrá realizarse sin introducir acoplamientos innecesarios ni reorganizaciones estructurales.

Este documento constituye la base organizativa sobre la que se implementarán los restantes documentos de la fase **Implementation**, garantizando una estructura consistente, mantenible y preparada para la evolución del Framework a largo plazo.
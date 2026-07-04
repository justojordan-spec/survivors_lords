# 04 - ENTITY REGISTRY

# Parte 1 — Arquitectura General

---

# Objetivo

Este documento define la implementación del **Entity Registry** del Framework ECS de Survivors Lords.

El Entity Registry constituye la autoridad única sobre el ciclo de vida de todas las entidades existentes dentro del Runtime.

Su responsabilidad es garantizar que todas las entidades del Framework posean una identidad válida, un ciclo de vida consistente y una administración completamente determinista.

Este documento describe exclusivamente la infraestructura del Registry.

No describe gameplay.

No describe Components.

No describe Systems.

No describe IA.

---

# Alcance

Este documento define:

- Arquitectura del Entity Registry.
- Administración del ciclo de vida.
- Identificadores.
- Validación.
- Reciclado.
- Integración con el Runtime.
- Comunicación con otros subsistemas.
- Restricciones arquitectónicas.

No define:

- Component Storage.
- Queries.
- Event Bus.
- Scheduler.
- Gameplay.

---

# Filosofía

Dentro del Framework, una entidad representa únicamente una identidad.

No posee comportamiento.

No contiene lógica.

No contiene datos.

Toda la información pertenece a los Components.

Toda la lógica pertenece a los Systems.

El Registry únicamente administra identidades.

---

# Responsabilidad Única

El Entity Registry es responsable exclusivamente de:

- crear entidades;
- destruir entidades;
- validar entidades;
- administrar identificadores;
- consultar existencia;
- mantener la consistencia del ciclo de vida.

Nada más.

---

# Autoridad Única

Ningún otro módulo puede crear entidades.

Ningún otro módulo puede destruir entidades.

Toda operación relacionada con el ciclo de vida debe pasar por el Entity Registry.

Esto garantiza:

- consistencia;
- trazabilidad;
- validación;
- sincronización.

---

# Arquitectura Interna

Aunque externamente exista un único contrato (`IEntityRegistry`), internamente la implementación se divide en tres responsabilidades.

```text
                  IEntityRegistry
                         │
                         ▼
                 EntityRegistry
                 ──────────────
                 API Pública
                         │
        ┌────────────────┼────────────────┐
        ▼                ▼                ▼
EntityAllocator   EntityStorage   EntityValidator
```

Cada módulo posee una responsabilidad claramente delimitada.

---

# Entity Registry

## Responsabilidad

Representa la fachada pública del subsistema.

Es el único punto de entrada para operaciones sobre entidades.

Coordina el trabajo del resto de los componentes internos.

No implementa directamente la asignación de IDs ni el almacenamiento interno.

---

# Entity Allocator

## Responsabilidad

Gestiona la creación de identificadores.

Es responsable de:

- generar IDs;
- reciclar IDs;
- controlar generaciones;
- evitar reutilización insegura.

No conoce Components.

No conoce Systems.

---

# Entity Storage

## Responsabilidad

Mantiene el estado interno de todas las entidades registradas.

Su responsabilidad es almacenar información mínima necesaria para determinar el estado de una entidad.

Por ejemplo:

- activa;
- destruida;
- pendiente de eliminación;
- generación actual.

No almacena Components.

---

# Entity Validator

## Responsabilidad

Centraliza todas las validaciones relacionadas con entidades.

Permite verificar:

- existencia;
- generación correcta;
- identificador válido;
- estado operativo.

Su objetivo es evitar duplicación de validaciones en el resto del Framework.

---

# Entidad

Dentro del Runtime una entidad representa únicamente una identidad.

Conceptualmente puede visualizarse como:

```text
Entity

↓

Identifier

↓

Components
```

La entidad no conoce los Components.

Los Components no conocen la entidad.

La relación es administrada por el Framework.

---

# Identidad

Toda entidad posee una identidad única durante su vida útil.

La identidad permanece estable mientras la entidad exista.

Una vez destruida, dicha identidad deja de ser válida.

---

# Entity Identifier

El Framework utilizará identificadores opacos.

Los consumidores del Framework nunca deben interpretar el contenido interno de un identificador.

Ejemplo correcto:

```text
EntityId
```

Ejemplo incorrecto:

```text
PlayerId

EnemyId

NPCId
```

El Registry administra entidades, no tipos de entidades.

---

# IDs Generacionales

El Framework utilizará identificadores generacionales.

Conceptualmente:

```text
EntityID

↓

Index

+

Generation
```

El índice identifica la posición física.

La generación identifica la versión de dicha entidad.

---

# Objetivo de las Generaciones

Las generaciones evitan referencias inválidas.

Ejemplo:

```text
Entity 25

↓

Destroy

↓

Create

↓

Entity 25
```

Aunque el índice sea reutilizado, la generación será diferente.

Por lo tanto:

```text
25:v1
```

es distinto de

```text
25:v2
```

Esto elimina una de las fuentes más comunes de errores en arquitecturas ECS.

---

# Ciclo de Vida

Toda entidad atraviesa el siguiente ciclo.

```text
Allocated

↓

Alive

↓

Pending Destroy

↓

Destroyed

↓

Recycled
```

Cada estado posee reglas específicas.

---

# Estado Allocated

El identificador fue reservado.

La entidad todavía no forma parte del mundo.

No posee Components.

No participa en Queries.

---

# Estado Alive

La entidad existe dentro del Runtime.

Puede recibir Components.

Puede participar en Queries.

Puede ser procesada por Systems.

---

# Estado Pending Destroy

La entidad fue marcada para destrucción.

Todavía no ha sido eliminada físicamente.

Este estado evita inconsistencias durante la ejecución de Systems.

---

# Estado Destroyed

La entidad deja de existir.

Todos sus Components fueron eliminados.

Las Queries dejan de verla.

El Scheduler deja de procesarla.

---

# Estado Recycled

El identificador puede reutilizarse.

Antes de hacerlo deberá incrementarse la generación.

---

# Inmutabilidad del Identificador

Mientras una entidad permanezca viva:

- su identificador no cambia;
- su índice no cambia;
- su generación no cambia.

Esto simplifica el acceso desde todos los subsistemas.

---

# Separación respecto a los Components

El Entity Registry nunca administra Components.

Cuando una entidad cambia de estado, la coordinación con el Component Registry se realiza mediante eventos o interfaces definidas por el Framework.

El Registry no elimina Components directamente.

---

# Separación respecto al Gameplay

El Registry desconoce completamente el significado de una entidad.

Para el Registry todas las entidades son equivalentes.

No existen:

- jugadores;
- enemigos;
- árboles;
- cofres;
- proyectiles.

Solo existen identidades.

---

# Integración con el Runtime

El Entity Registry forma parte del Runtime desde el Bootstrap.

Una vez inicializado permanece disponible durante toda la ejecución.

No debe recrearse mientras el Runtime continúe activo.

---

# Dependencias Permitidas

El Entity Registry puede depender de:

- IECSContext
- IEntityRegistry
- Interfaces internas del subsistema

No debe depender de:

- Gameplay
- SceneTree
- UI
- Systems concretos
- Components concretos

---

# Garantías

La implementación del Entity Registry debe garantizar que:

- nunca existan dos entidades vivas con la misma identidad;
- ninguna entidad destruida pueda utilizarse nuevamente sin reciclar su generación;
- todas las operaciones sean deterministas;
- la validación de entidades sea consistente en cualquier punto del Runtime;
- el estado interno permanezca coherente incluso ante errores.

---

# Resultado Esperado

Al finalizar esta primera parte queda definida la arquitectura general del Entity Registry.

El subsistema se presenta como una fachada pública respaldada por componentes internos especializados, con responsabilidades claramente separadas y un modelo de identificadores generacionales preparado para un Runtime ECS de alto rendimiento y completamente determinista.

Las siguientes partes desarrollarán el flujo de creación, destrucción, almacenamiento, integración con el resto del Framework y consideraciones avanzadas de implementación.
# 04 - ENTITY REGISTRY

# Parte 2 — Ciclo de Vida e Implementación

---

# Objetivo

Esta sección define el comportamiento interno del Entity Registry durante la creación, validación, destrucción y reciclado de entidades.

El objetivo es garantizar un ciclo de vida completamente determinista, consistente y desacoplado del resto del Framework.

---

# Principios

Toda operación sobre entidades debe cumplir los siguientes principios:

- Determinista.
- Atómica.
- Consistente.
- Validable.
- Reversible únicamente mediante nuevas operaciones del Registry.
- Independiente del gameplay.

---

# Flujo General

El ciclo completo de una entidad es el siguiente.

```text
Request Create

↓

Allocate Identifier

↓

Create Entity Record

↓

Register Entity

↓

Alive

↓

Request Destroy

↓

Pending Destroy

↓

Remove Components

↓

Destroy Entity

↓

Recycle Identifier
```

Todas las etapas deben ejecutarse en este orden.

---

# Creación de Entidades

Toda creación comienza mediante una solicitud al `IEntityRegistry`.

Ningún otro módulo puede crear entidades directamente.

---

# Paso 1 — Solicitud

Un consumidor solicita una nueva entidad.

Ejemplo conceptual:

```text
Create Entity
```

En este momento todavía no existe ninguna entidad válida.

---

# Paso 2 — Reserva del Identificador

El `EntityAllocator` obtiene un identificador disponible.

Puede hacerlo mediante:

- creación de un nuevo índice;
- reutilización de un índice reciclado.

La decisión es completamente interna.

---

# Paso 3 — Construcción del Registro

El `EntityStorage` crea un registro interno para la nueva entidad.

El registro inicial contiene únicamente la información mínima necesaria para administrar su ciclo de vida.

Por ejemplo:

- índice;
- generación;
- estado;
- flags internos.

No contiene Components.

---

# Paso 4 — Activación

Una vez registrado correctamente, el estado pasa a:

```text
Alive
```

A partir de este momento:

- la entidad es válida;
- puede recibir Components;
- puede aparecer en Queries.

---

# Garantías de Creación

Al finalizar la creación:

- existe exactamente una entidad con ese identificador;
- el identificador es válido;
- la generación es correcta;
- el estado es consistente.

---

# Destrucción de Entidades

La destrucción nunca elimina inmediatamente la entidad.

Siempre comienza mediante una solicitud.

---

# Paso 1 — Solicitud de Destrucción

El consumidor solicita destruir una entidad.

El Registry valida:

- existencia;
- generación;
- estado.

Si alguna validación falla, la operación se rechaza.

---

# Paso 2 — Pending Destroy

La entidad cambia al estado:

```text
Pending Destroy
```

Mientras permanezca en este estado:

- no deben añadirse Components;
- no deben eliminarse manualmente Components;
- no deben iniciarse nuevas operaciones sobre ella.

Este estado evita inconsistencias durante la ejecución de los Systems.

---

# Paso 3 — Eliminación de Components

Una vez marcada la entidad, el Component Registry elimina todos los Components asociados.

Esta coordinación se realiza mediante los mecanismos definidos por el Framework.

El Entity Registry nunca elimina Components directamente.

---

# Paso 4 — Destrucción

Cuando la entidad ya no posee Components:

- el registro interno se elimina;
- el estado pasa a Destroyed.

A partir de este momento el identificador deja de ser válido.

---

# Paso 5 — Reciclado

Finalmente, el identificador puede volver al `EntityAllocator`.

Antes de reutilizarse deberá incrementarse su generación.

---

# Destrucción Diferida

La destrucción debe ser diferida.

Nunca debe eliminarse físicamente una entidad mientras un System pueda estar iterando sobre ella.

La destrucción efectiva debe realizarse en un punto seguro del ciclo de ejecución definido por el Scheduler.

---

# Validación

Toda operación sobre una entidad debe comenzar con una validación.

Las validaciones mínimas son:

- identificador válido;
- índice existente;
- generación correcta;
- estado Alive.

---

# Entidades Inválidas

Una entidad se considera inválida cuando ocurre cualquiera de las siguientes condiciones:

- nunca existió;
- fue destruida;
- pertenece a una generación anterior;
- posee un identificador corrupto;
- su registro no existe.

Las entidades inválidas nunca deben producir comportamiento indefinido.

---

# Reutilización de Identificadores

El reciclado de índices es una optimización de memoria.

Debe ser completamente transparente para el resto del Framework.

Los consumidores nunca deben asumir que un índice representa siempre a la misma entidad.

---

# Política de Reciclado

El `EntityAllocator` puede implementar distintas estrategias internas.

Ejemplos:

- FIFO.
- LIFO.
- Pool libre.
- Segmentación.

La estrategia concreta no forma parte del contrato público.

---

# Generaciones

Cada reutilización incrementa la generación asociada al índice.

Ejemplo conceptual:

```text
Index 42

↓

Generation 1

↓

Destroy

↓

Generation 2

↓

Reuse
```

Esto garantiza que referencias antiguas nunca vuelvan a ser válidas.

---

# Consistencia

Durante toda la vida del Runtime deben cumplirse las siguientes reglas:

- un índice pertenece a una sola entidad viva;
- una entidad viva posee un único identificador;
- una generación nunca disminuye;
- un identificador destruido nunca vuelve a ser válido.

---

# Borrado Masivo

El Registry debe permitir destruir múltiples entidades de forma eficiente.

Sin embargo, la operación debe seguir respetando el ciclo:

```text
Pending Destroy

↓

Remove Components

↓

Destroy

↓

Recycle
```

No deben existir rutas especiales que omitan etapas.

---

# Reinicio del Mundo

Cuando el Runtime reinicia un mundo:

- todas las entidades deben destruirse correctamente;
- todos los identificadores deben reciclarse;
- el Registry debe regresar a un estado consistente.

No debe quedar ninguna referencia residual.

---

# Integración con el Scheduler

El Scheduler define los puntos seguros donde pueden procesarse:

- creaciones pendientes;
- destrucciones pendientes;
- reciclado de identificadores.

El Entity Registry nunca decide por sí mismo cuándo ejecutar estas operaciones.

---

# Operaciones Atómicas

Cada operación pública del Registry debe ser atómica.

Si ocurre un error:

- la operación se cancela;
- el estado interno permanece consistente;
- no deben existir entidades parcialmente creadas o destruidas.

---

# Reglas de Implementación

Toda implementación del Entity Registry debe garantizar:

- ausencia de duplicados;
- validación previa;
- consistencia tras errores;
- determinismo;
- independencia del orden de ejecución de los Systems.

---

# Resultado Esperado

Al finalizar esta sección queda completamente definido el flujo de creación y destrucción de entidades.

El ciclo de vida se mantiene consistente mediante identificadores generacionales, destrucción diferida y validaciones obligatorias, proporcionando una base segura para la interacción con el Component Registry, el Scheduler y el resto del Framework.
# 04 - ENTITY REGISTRY

# Parte 3 — Integración con el Framework

---

# Objetivo

Esta sección define cómo interactúa el Entity Registry con el resto del Framework ECS.

El Registry nunca trabaja de forma aislada.

Forma parte del Runtime y coopera con otros subsistemas mediante contratos públicos, Events y Queries.

En ningún caso debe existir acoplamiento directo con implementaciones concretas.

---

# Filosofía

El Entity Registry es el propietario del ciclo de vida de las entidades.

Sin embargo, no es propietario de:

- Components.
- Systems.
- Resources.
- Eventos.
- Persistencia.
- Multiplayer.

Cada subsistema mantiene su propia responsabilidad.

La coordinación se realiza exclusivamente mediante la arquitectura ECS.

---

# Integración con el Bootstrap

Durante el Bootstrap:

- se crea el Entity Registry;
- se inicializa el Entity Allocator;
- se inicializa el Entity Storage;
- se inicializa el Entity Validator;
- se registran los contratos públicos.

Una vez finalizada la inicialización, el Registry permanece disponible durante toda la vida del Runtime.

---

# Integración con el ECS Context

El Entity Registry debe registrarse dentro del `IECSContext`.

Nunca debe localizar servicios por sí mismo.

El acceso siempre ocurre mediante el contexto del Runtime.

Ejemplo conceptual:

```text
Runtime

↓

ECS Context

↓

IEntityRegistry
```

Esto mantiene desacopladas las implementaciones.

---

# Integración con el Component Registry

El Entity Registry y el Component Registry son subsistemas independientes.

El Entity Registry:

- no almacena Components;
- no conoce tipos de Components;
- no conoce estructuras internas de almacenamiento.

El Component Registry:

- no crea entidades;
- no destruye entidades;
- no administra identificadores.

---

# Coordinación durante la Creación

Una entidad recién creada no posee Components.

El flujo normal es:

```text
Entity Created

↓

Entity Alive

↓

Add Components
```

La creación de Components siempre ocurre posteriormente.

---

# Coordinación durante la Destrucción

Cuando una entidad entra en estado `Pending Destroy`, comienza un proceso coordinado.

Conceptualmente:

```text
Entity Registry

↓

Pending Destroy

↓

Component Registry

↓

Remove Components

↓

Entity Registry

↓

Destroyed
```

Cada subsistema ejecuta únicamente su responsabilidad.

---

# Orden de Eliminación

El orden obligatorio es:

```text
Mark Pending Destroy

↓

Remove Components

↓

Invalidate Queries

↓

Recycle Identifier
```

Alterar este orden puede producir referencias inválidas.

---

# Integración con el Event Bus

El Entity Registry no llama directamente a otros Systems.

Cuando ocurre un cambio importante en el ciclo de vida, puede publicar eventos mediante el `IEventBus`.

Ejemplos conceptuales:

```text
EntityCreated

EntityDestroyed

EntityRecycled
```

El Registry desconoce quién consume dichos eventos.

---

# Principio de Desacoplamiento

El Registry nunca debe realizar operaciones como:

```text
MovementSystem.on_entity_created()

InventorySystem.remove_entity()

CombatSystem.cleanup()
```

Toda coordinación debe realizarse mediante eventos o contratos públicos.

---

# Integración con el Query Engine

El Query Engine utiliza entidades registradas para construir sus resultados.

Sin embargo:

- el Registry no conoce las Queries;
- el Query Engine no modifica el Registry.

Ambos subsistemas permanecen desacoplados.

---

# Cambios de Estado

Cuando una entidad cambia de estado, el Query Engine deberá reflejar dicho cambio según su propia estrategia de actualización.

El Entity Registry no actualiza cachés de Queries.

---

# Integración con el Scheduler

El Scheduler determina cuándo se procesan determinadas operaciones diferidas.

El Registry únicamente expone las operaciones necesarias.

Ejemplos:

- procesar creaciones pendientes;
- procesar destrucciones pendientes;
- reciclar identificadores.

La política temporal pertenece exclusivamente al Scheduler.

---

# Integración con Save

El Entity Registry participa en la persistencia únicamente proporcionando información sobre las entidades existentes.

No serializa datos.

No escribe archivos.

No interpreta formatos.

Su responsabilidad termina al exponer el estado necesario al Save Pipeline.

---

# Información Persistente

La persistencia del Registry puede incluir:

- identificadores activos;
- generaciones;
- estado de reciclado;
- metadatos internos necesarios para reconstruir el Runtime.

Nunca debe incluir:

- Components.
- Gameplay.
- Datos derivados.

---

# Integración con Multiplayer

El Registry debe ser completamente compatible con un modelo Server Authoritative.

La autoridad sobre la creación y destrucción de entidades pertenece al servidor.

Los clientes nunca deben modificar directamente el estado del Registry.

---

# Sincronización

Cuando una entidad es creada o destruida por el servidor:

```text
Server

↓

Replication

↓

Client Registry

↓

Update State
```

El Registry no implementa la replicación.

Únicamente expone operaciones compatibles con ella.

---

# Determinismo

Todos los clientes deben observar exactamente el mismo resultado para una misma secuencia de operaciones válidas.

El Registry no debe introducir comportamiento dependiente de:

- orden de CPU;
- plataforma;
- velocidad de ejecución.

---

# Integración con Debug

Las herramientas de depuración podrán consultar información del Registry mediante interfaces públicas.

Ejemplos:

- cantidad de entidades;
- entidades activas;
- entidades destruidas;
- IDs reciclados;
- generaciones.

Las herramientas nunca deben modificar el estado interno del Registry.

---

# Integración con Profiling

El Registry debe exponer métricas útiles para análisis de rendimiento.

Ejemplos:

- entidades creadas por segundo;
- entidades destruidas por segundo;
- tiempo medio de creación;
- tiempo medio de destrucción;
- tamaño del pool de IDs;
- reutilización de identificadores.

La recopilación de métricas no debe afectar significativamente al rendimiento del Runtime.

---

# Integración con Testing

El contrato `IEntityRegistry` debe permitir implementaciones simuladas para pruebas.

Las pruebas podrán validar:

- creación;
- destrucción;
- reciclado;
- generaciones;
- validación;
- consistencia del estado.

Todas las implementaciones deberán superar el mismo conjunto de pruebas de contrato.

---

# Dependencias Permitidas

El Entity Registry puede interactuar con:

- IECSContext
- IEventBus
- Interfaces internas del subsistema
- Contratos públicos definidos en `03_CORE_INTERFACES.md`

Nunca debe depender de:

- Systems concretos;
- Components concretos;
- Gameplay;
- SceneTree;
- UI;
- Recursos específicos del juego.

---

# Garantías Arquitectónicas

La integración del Entity Registry debe garantizar que:

- ningún subsistema modifica directamente su estado interno;
- toda creación y destrucción pasa por el Registry;
- las operaciones permanecen desacopladas;
- el orden del ciclo de vida es consistente;
- la sincronización con otros módulos ocurre mediante contratos bien definidos.

---

# Resultado Esperado

Al finalizar esta sección, el Entity Registry queda completamente integrado dentro del Framework ECS sin introducir dependencias circulares ni acoplamientos innecesarios.

Cada subsistema mantiene su responsabilidad específica y la coordinación se realiza exclusivamente mediante interfaces públicas, eventos y mecanismos definidos por la arquitectura general del Runtime.
# 04 - ENTITY REGISTRY

# Parte 4 — Rendimiento, Memoria, Depuración y Consideraciones de Implementación

---

# Objetivo

Esta sección define las consideraciones de implementación del Entity Registry relacionadas con rendimiento, uso de memoria, depuración, validación y pruebas.

No describe una implementación concreta en GDScript.

Define las reglas que toda implementación deberá respetar para garantizar un comportamiento consistente y escalable.

---

# Filosofía

El Entity Registry será uno de los subsistemas más utilizados del Runtime.

Prácticamente todos los Systems interactuarán indirectamente con él.

Por este motivo debe priorizar:

- simplicidad;
- determinismo;
- baja latencia;
- bajo consumo de memoria;
- escalabilidad.

---

# Objetivos de Rendimiento

El Registry debe diseñarse para que las siguientes operaciones sean extremadamente rápidas:

- Crear entidad.
- Destruir entidad.
- Validar entidad.
- Consultar existencia.
- Obtener generación.
- Obtener índice.

Las operaciones frecuentes deben evitar asignaciones innecesarias de memoria.

---

# Complejidad Esperada

Como objetivo arquitectónico:

| Operación | Complejidad Esperada |
|------------|----------------------|
| Crear entidad | O(1) amortizado |
| Destruir entidad | O(1) |
| Validar entidad | O(1) |
| Consultar existencia | O(1) |
| Reciclar ID | O(1) |
| Obtener generación | O(1) |

La implementación concreta podrá variar, pero no deberá degradar significativamente estas operaciones.

---

# Uso de Memoria

El Registry debe almacenar únicamente la información estrictamente necesaria.

Cada entidad debe mantener un registro interno mínimo.

Ejemplos:

- índice;
- generación;
- estado;
- flags internos.

Nunca debe almacenar información perteneciente a otros subsistemas.

---

# Fragmentación

El reciclado de identificadores debe minimizar el crecimiento innecesario de estructuras internas.

Siempre que sea posible:

- reutilizar memoria;
- evitar reallocations frecuentes;
- mantener estructuras compactas.

---

# Reservas de Capacidad

La implementación puede permitir reservar capacidad anticipadamente.

Ejemplo conceptual:

```text
Reserve(100000)
```

Esto reduce reasignaciones durante la creación masiva de entidades.

La reserva nunca debe crear entidades.

Únicamente prepara la infraestructura interna.

---

# Creación Masiva

El Registry debe soportar la creación de grandes cantidades de entidades.

Ejemplos:

- generación de terreno;
- vegetación;
- proyectiles;
- simulaciones.

La creación masiva no debe requerir rutas especiales de código.

Debe reutilizar el mismo flujo de creación estándar.

---

# Destrucción Masiva

La destrucción de múltiples entidades debe realizarse mediante el mismo pipeline utilizado para una entidad individual.

No deben existir atajos que omitan validaciones.

---

# Consistencia de Memoria

Después de destruir una entidad:

- no deben quedar referencias internas;
- el registro debe ser reutilizable;
- la memoria debe permanecer consistente.

---

# Cachés

El Entity Registry no debe implementar cachés de gameplay.

Su única responsabilidad es administrar entidades.

Las optimizaciones relacionadas con Queries pertenecen al Query Engine.

---

# Seguridad

Toda operación debe validar previamente el identificador recibido.

Nunca debe asumirse que un identificador es válido.

Las validaciones deben realizarse incluso durante el desarrollo de herramientas internas.

---

# Detección de Corrupción

El Registry debe detectar estados inconsistentes siempre que sea posible.

Ejemplos:

- generación inválida;
- índice inexistente;
- doble destrucción;
- reutilización incorrecta.

En modo Debug estas validaciones deben ser exhaustivas.

---

# Modo Release

En compilaciones Release podrán omitirse determinadas validaciones costosas, siempre que no comprometan la seguridad del Runtime.

Las comprobaciones esenciales deberán mantenerse.

---

# Instrumentación

El Registry debe proporcionar información útil para herramientas de diagnóstico.

Ejemplos:

- entidades activas;
- entidades recicladas;
- capacidad utilizada;
- tamaño del pool;
- generaciones máximas;
- tiempo medio de creación.

La instrumentación debe poder deshabilitarse cuando no sea necesaria.

---

# Logging

El Registry únicamente debe registrar eventos relevantes.

Ejemplos:

- errores críticos;
- corrupción detectada;
- fallos de inicialización.

No debe registrar cada creación o destrucción de entidad durante la ejecución normal.

---

# Estadísticas

La implementación puede mantener contadores internos.

Ejemplos:

```text
Entities Created

Entities Destroyed

Active Entities

Peak Entities

Recycled IDs

Validation Errors
```

Estas estadísticas son útiles para:

- profiling;
- depuración;
- pruebas de rendimiento.

---

# Herramientas de Depuración

El Framework podrá incorporar herramientas capaces de inspeccionar el Registry.

Ejemplos:

- listado de entidades;
- búsqueda por identificador;
- estado de generaciones;
- visualización del pool de IDs;
- entidades pendientes de destrucción.

Estas herramientas deberán utilizar exclusivamente interfaces públicas.

---

# Validaciones Automáticas

El Registry debe permitir ejecutar comprobaciones de consistencia.

Ejemplos:

- no existen identificadores duplicados;
- todas las generaciones son válidas;
- no existen entidades activas sin registro;
- el pool reciclado es consistente.

Estas validaciones serán especialmente útiles durante el desarrollo.

---

# Compatibilidad con Testing

Toda implementación deberá superar pruebas automáticas que verifiquen:

- creación de entidades;
- destrucción;
- reutilización de IDs;
- incremento de generaciones;
- validación de identificadores;
- consistencia tras operaciones masivas;
- reinicio del Runtime.

---

# Escenarios de Prueba

Como mínimo deberán contemplarse los siguientes casos:

## Creación simple

Crear una entidad.

Verificar:

- ID válido;
- estado Alive;
- registro consistente.

---

## Creación múltiple

Crear miles de entidades.

Verificar:

- ausencia de duplicados;
- crecimiento correcto;
- rendimiento esperado.

---

## Destrucción

Destruir entidades existentes.

Verificar:

- cambio de estado;
- eliminación correcta;
- reciclado posterior.

---

## Reutilización

Crear.

Destruir.

Crear nuevamente.

Verificar:

- mismo índice reutilizado cuando corresponda;
- generación incrementada;
- referencias antiguas inválidas.

---

## Reinicio del Runtime

Destruir todas las entidades.

Reiniciar el Runtime.

Verificar:

- estado limpio;
- ausencia de referencias residuales;
- Registry reutilizable.

---

# Compatibilidad con Futuras Extensiones

La implementación deberá permitir incorporar futuras optimizaciones sin modificar el contrato público.

Ejemplos:

- pools especializados;
- almacenamiento segmentado;
- paralelización de validaciones;
- compactación de memoria;
- allocators alternativos.

Estas mejoras deberán permanecer transparentes para los consumidores del `IEntityRegistry`.

---

# Restricciones de Implementación

La implementación del Entity Registry no debe:

- depender del SceneTree;
- acceder directamente a Nodes del juego;
- conocer tipos de Components;
- conocer Systems concretos;
- acceder a lógica de gameplay;
- modificar directamente otros Registries.

---

# Resumen Arquitectónico

El Entity Registry constituye la autoridad única sobre el ciclo de vida de las entidades del Runtime.

Su diseño se basa en:

- identificadores generacionales;
- responsabilidades claramente separadas;
- validaciones consistentes;
- destrucción diferida;
- integración mediante interfaces;
- determinismo;
- escalabilidad.

Todo el resto del Framework asume que el Registry garantiza la validez de las entidades.

Por este motivo, cualquier implementación deberá respetar estrictamente las reglas definidas en este documento.

---

# Resultado Esperado

Con este documento queda completamente especificada la implementación del Entity Registry del Framework ECS de Survivors Lords.

La arquitectura propuesta proporciona una base sólida para un Runtime determinista, desacoplado, preparado para multiplayer, escalable y compatible con las necesidades de rendimiento del proyecto, manteniendo una separación clara entre la administración de identidades y el resto de los subsistemas del Framework.
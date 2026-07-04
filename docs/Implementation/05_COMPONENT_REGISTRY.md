# 05 - COMPONENT REGISTRY

# Parte 1 — Arquitectura General

---

# Objetivo

Este documento define la implementación del **Component Registry** del Framework ECS de Survivors Lords.

El Component Registry constituye la autoridad única sobre el almacenamiento y administración de todos los Components existentes dentro del Runtime.

Su responsabilidad es garantizar que los datos de las entidades permanezcan consistentes, accesibles y organizados de acuerdo con la arquitectura ECS definida para el proyecto.

Este documento describe exclusivamente la infraestructura del Component Registry.

No describe gameplay.

No describe Systems.

No describe IA.

No describe lógica de negocio.

---

# Alcance

Este documento define:

- Arquitectura del Component Registry.
- Registro de tipos.
- Almacenamiento.
- Administración del ciclo de vida de los Components.
- Validación.
- Integración con el Runtime.
- Restricciones arquitectónicas.

No define:

- Queries.
- Event Bus.
- Scheduler.
- Gameplay.
- Recursos específicos del juego.

---

# Filosofía

Dentro del Framework, un Component representa únicamente datos.

No contiene comportamiento.

No contiene lógica.

No conoce otros Components.

No conoce Systems.

No conoce entidades distintas de su propietario.

Toda la lógica del juego pertenece exclusivamente a los Systems.

El Component Registry únicamente administra dichos datos.

---

# Responsabilidad Única

El Component Registry es responsable exclusivamente de:

- registrar tipos de Component;
- añadir Components a entidades;
- eliminar Components;
- consultar Components;
- administrar el almacenamiento;
- validar la consistencia del almacenamiento.

Nada más.

---

# Autoridad Única

Ningún otro módulo puede crear o eliminar Components directamente.

Toda modificación del conjunto de Components debe realizarse mediante el Component Registry.

Esto garantiza:

- consistencia;
- trazabilidad;
- validación;
- sincronización con Queries;
- compatibilidad con Save y Multiplayer.

---

# Arquitectura Interna

Aunque externamente exista únicamente el contrato `IComponentRegistry`, internamente la implementación se divide en varios subsistemas especializados.

```text
                IComponentRegistry
                        │
                        ▼
               ComponentRegistry
               ─────────────────
                  API Pública
                        │
      ┌───────────┬──────────────┬──────────────┬──────────────┐
      ▼           ▼              ▼              ▼
ComponentTypeRegistry
ComponentStorage
ComponentAllocator
ComponentValidator
```

Cada uno posee una única responsabilidad.

---

# Component Registry

## Responsabilidad

Es la fachada pública del subsistema.

Coordina todas las operaciones relacionadas con Components.

No almacena datos directamente.

No administra memoria.

No implementa estrategias de almacenamiento.

---

# Component Type Registry

## Responsabilidad

Registrar todos los tipos de Component disponibles durante la ejecución.

Cada tipo recibe un identificador interno estable.

Ejemplo conceptual:

```text
TransformComponent

↓

Type ID 1

HealthComponent

↓

Type ID 2

InventoryComponent

↓

Type ID 3
```

Los consumidores nunca dependen de estos valores.

Son completamente internos.

---

# Objetivo del Type Registry

Evitar comparaciones dinámicas de tipos.

Las operaciones internas utilizarán identificadores enteros para:

- almacenamiento;
- búsquedas;
- Queries;
- validaciones.

Esto mejora significativamente el rendimiento del Runtime.

---

# Component Storage

## Responsabilidad

Almacenar físicamente los datos de cada tipo de Component.

Cada tipo dispone de un almacenamiento independiente.

Ejemplo conceptual:

```text
Transform Storage

Health Storage

Inventory Storage

Building Storage
```

No existe un almacenamiento único para todos los Components.

---

# Organización del Almacenamiento

Cada Storage contiene únicamente un tipo de Component.

Ejemplo:

```text
Transform Storage

Entity 15

↓

TransformComponent

Entity 28

↓

TransformComponent

Entity 44

↓

TransformComponent
```

Nunca mezcla tipos distintos.

---

# Component Allocator

## Responsabilidad

Administrar la memoria utilizada por los distintos Storage.

Permite:

- reservar capacidad;
- reutilizar memoria;
- reducir asignaciones;
- optimizar inserciones.

El resto del Framework desconoce completamente su funcionamiento interno.

---

# Component Validator

## Responsabilidad

Centralizar todas las comprobaciones relacionadas con Components.

Ejemplos:

- tipo registrado;
- entidad válida;
- Component existente;
- ausencia de duplicados;
- consistencia del almacenamiento.

Su objetivo es evitar que estas validaciones se repliquen en múltiples módulos.

---

# Component Type ID

Cada tipo registrado recibe un identificador estable durante la ejecución del Runtime.

Conceptualmente:

```text
Transform → 1

Health → 2

Inventory → 3
```

Este identificador nunca cambia mientras el Runtime permanezca activo.

No debe persistirse en archivos de guardado.

No debe transmitirse por red como identificador permanente.

---

# Registro de Tipos

Todos los tipos de Component deben registrarse durante el Bootstrap.

Una vez iniciado el Runtime:

- no deben aparecer nuevos tipos;
- no deben eliminarse tipos existentes.

Esto garantiza un entorno determinista.

---

# Component Owner

Todo Component pertenece exactamente a una entidad.

Nunca puede pertenecer a varias.

Nunca puede existir sin propietario.

Conceptualmente:

```text
Entity

↓

Component
```

La relación es administrada por el Component Registry.

---

# Restricción de Duplicados

Una entidad no puede poseer dos instancias del mismo tipo de Component.

Ejemplo correcto:

```text
Entity

↓

Transform

↓

Health

↓

Inventory
```

Ejemplo incorrecto:

```text
Entity

↓

Transform

↓

Transform
```

El Validator debe impedir esta situación.

---

# Component Lifetime

El ciclo de vida de un Component depende completamente de la entidad propietaria.

Cuando una entidad desaparece:

- todos sus Components deben eliminarse.

No pueden existir Components huérfanos.

---

# Separación respecto a las Entidades

El Component Registry no crea entidades.

No destruye entidades.

No administra identificadores.

Toda interacción con entidades se realiza mediante `IEntityRegistry`.

---

# Separación respecto a los Systems

El Registry desconoce completamente el propósito de los Components.

No existen reglas especiales para:

- PlayerComponent;
- EnemyComponent;
- BuildingComponent;
- AIComponent.

Todos son tratados exactamente igual.

---

# Separación respecto al Gameplay

El Component Registry nunca interpreta los datos almacenados.

Por ejemplo:

Un `HealthComponent` contiene información.

El Registry nunca calcula daño.

Nunca modifica vida.

Nunca aplica efectos.

Toda esa lógica pertenece a los Systems.

---

# Integración con el Runtime

El Component Registry forma parte del Runtime desde el Bootstrap.

Permanece activo durante toda la ejecución.

No debe recrearse mientras el Runtime continúe funcionando.

---

# Dependencias Permitidas

El Component Registry puede depender de:

- IECSContext
- IEntityRegistry
- Interfaces internas del subsistema

No debe depender de:

- SceneTree
- Gameplay
- Systems concretos
- UI
- Recursos específicos

---

# Garantías

Toda implementación debe garantizar que:

- cada Component pertenece exactamente a una entidad;
- no existen duplicados del mismo tipo en una entidad;
- todos los tipos utilizados están registrados;
- el almacenamiento permanece consistente;
- ninguna operación deja datos huérfanos.

---

# Resultado Esperado

Al finalizar esta primera parte queda definida la arquitectura general del Component Registry.

El subsistema se organiza mediante una fachada pública respaldada por módulos especializados para el registro de tipos, almacenamiento, asignación de memoria y validación, proporcionando una base sólida, desacoplada y preparada para las optimizaciones que utilizarán el Query Engine y el Scheduler en las siguientes fases del Framework.
# 05 - COMPONENT REGISTRY

# Parte 2 — Ciclo de Vida, Almacenamiento e Implementación

---

# Objetivo

Esta sección define el comportamiento interno del Component Registry durante el registro, creación, modificación y eliminación de Components.

También describe la organización del almacenamiento interno y las reglas que garantizan la consistencia de los datos dentro del Runtime.

---

# Principios

Toda operación sobre Components debe cumplir los siguientes principios:

- Determinista.
- Atómica.
- Consistente.
- Validable.
- Independiente del gameplay.
- Compatible con Multiplayer.
- Compatible con Save.

---

# Flujo General

Todo Component atraviesa el siguiente ciclo de vida.

```text
Type Registered

↓

Component Created

↓

Component Attached

↓

Component Modified

↓

Component Removed

↓

Storage Recycled
```

Cada etapa posee responsabilidades específicas.

---

# Registro del Tipo

Antes de utilizar un Component, su tipo debe encontrarse registrado.

Ejemplo conceptual:

```text
HealthComponent

↓

ComponentTypeRegistry

↓

Type ID Assigned
```

Ningún Component puede existir sin un tipo registrado.

---

# Creación del Component

La creación de un Component consiste únicamente en construir un contenedor de datos.

Todavía no pertenece a ninguna entidad.

Todavía no participa del Runtime.

---

# Asociación a una Entidad

Cuando un Component se agrega mediante el `IComponentRegistry`:

```text
Entity

+

Component

↓

Attach
```

A partir de ese momento:

- pertenece a una entidad;
- forma parte del almacenamiento;
- puede participar en Queries.

---

# Garantías

Después de una inserción correcta:

- la entidad posee exactamente una instancia de ese tipo;
- el almacenamiento permanece consistente;
- el Query Engine podrá localizarlo.

---

# Modificación

Modificar un Component nunca implica reemplazarlo físicamente.

Los Systems modifican únicamente sus datos.

Ejemplo conceptual:

```text
HealthComponent

HP = 50

↓

HP = 35
```

La identidad del Component permanece inalterada.

---

# Reemplazo

Si una operación requiere reemplazar completamente un Component:

```text
Remove

↓

Create

↓

Attach
```

Debe seguir el mismo flujo utilizado para cualquier inserción.

---

# Eliminación

Cuando un Component deja de pertenecer a una entidad:

```text
Entity

↓

Remove Component

↓

Storage Update
```

El almacenamiento libera el espacio correspondiente.

---

# Eliminación por Destrucción de Entidad

Cuando una entidad es destruida:

```text
Entity Destroy

↓

Remove All Components

↓

Recycle Storage
```

El Component Registry elimina todos los Components asociados.

No pueden permanecer datos huérfanos.

---

# Eliminación Individual

También es posible eliminar un único Component.

Ejemplo:

```text
Entity

↓

Remove InventoryComponent
```

Los demás Components permanecen intactos.

---

# Component Storage

Cada tipo de Component dispone de un almacenamiento independiente.

Ejemplo:

```text
Transform Storage

↓

TransformComponent[]
```

```text
Health Storage

↓

HealthComponent[]
```

```text
Inventory Storage

↓

InventoryComponent[]
```

Cada almacenamiento puede utilizar la estrategia más eficiente para ese tipo.

---

# Organización Interna

Conceptualmente:

```text
Component Type

↓

Storage

↓

Entity Mapping

↓

Component Data
```

El Registry nunca mezcla tipos distintos dentro del mismo almacenamiento.

---

# Acceso

Toda operación de lectura sigue el mismo flujo.

```text
Entity

↓

Type ID

↓

Storage

↓

Component
```

No existen búsquedas globales entre todos los Components.

---

# Inserción

El flujo conceptual de inserción es:

```text
Validate Entity

↓

Validate Type

↓

Validate Duplicate

↓

Allocate Memory

↓

Insert Component

↓

Update Queries
```

Cada paso debe completarse correctamente antes de continuar.

---

# Eliminación

La eliminación sigue el siguiente flujo.

```text
Validate Entity

↓

Locate Storage

↓

Remove Component

↓

Recycle Memory

↓

Update Queries
```

---

# Validaciones

Antes de insertar un Component deben verificarse como mínimo:

- entidad existente;
- entidad viva;
- tipo registrado;
- ausencia de duplicados.

---

# Validación de Lectura

Antes de recuperar un Component:

- entidad válida;
- tipo registrado;
- existencia del Component.

Si alguna condición falla, el comportamiento debe ser consistente y estar definido por el contrato público.

---

# Validación de Eliminación

Antes de eliminar:

- entidad válida;
- Component existente.

Eliminar un Component inexistente nunca debe corromper el almacenamiento.

---

# Component Allocator

El `ComponentAllocator` administra la memoria utilizada por cada Storage.

Puede implementar:

- pools;
- bloques;
- reservas anticipadas;
- reutilización de espacios.

Su estrategia es completamente transparente para el resto del Runtime.

---

# Reutilización

Cuando un Component es eliminado:

```text
Storage Slot

↓

Free

↓

Reusable
```

La memoria puede reutilizarse posteriormente.

No debe producir fragmentación innecesaria.

---

# Duplicados

La siguiente situación está prohibida.

```text
Entity

↓

Transform

↓

Transform
```

El Validator debe impedir cualquier inserción que produzca duplicados del mismo tipo.

---

# Integridad

En todo momento deben cumplirse las siguientes reglas:

- cada Component pertenece a una única entidad;
- una entidad posee como máximo un Component por tipo;
- un Component registrado siempre pertenece a una entidad viva;
- no existen referencias colgantes.

---

# Mutabilidad

Los datos internos de un Component pueden modificarse.

La relación entre entidad y Component no cambia durante esas modificaciones.

Esto evita operaciones innecesarias sobre el almacenamiento.

---

# Actualización de Queries

Siempre que un Component sea:

- añadido;
- eliminado;

el Query Engine deberá actualizar su estado utilizando los mecanismos definidos por su propio subsistema.

El Component Registry no implementa la lógica de las Queries.

Únicamente notifica los cambios necesarios mediante la infraestructura del Framework.

---

# Component Signature

Conceptualmente, cada entidad puede representarse mediante una firma compuesta por los tipos de Component que posee.

Ejemplo:

```text
Entity

↓

Transform

↓

Health

↓

Inventory
```

↓

```text
Signature
```

Esta firma será utilizada posteriormente por el Query Engine para optimizar las búsquedas.

El Component Registry mantiene la información necesaria para construirla, pero no interpreta su significado.

---

# Operaciones Atómicas

Todas las operaciones públicas del Registry deben ser atómicas.

Si una inserción falla:

- no debe quedar memoria reservada;
- no debe modificarse el almacenamiento;
- no deben generarse firmas inconsistentes.

---

# Reglas de Implementación

Toda implementación debe garantizar:

- almacenamiento consistente;
- ausencia de duplicados;
- validaciones previas obligatorias;
- independencia del tipo de Component;
- determinismo;
- compatibilidad con futuras optimizaciones.

---

# Resultado Esperado

Al finalizar esta sección queda completamente definido el ciclo de vida de los Components y la organización de su almacenamiento.

El Component Registry administra exclusivamente datos, mantiene la integridad del almacenamiento y proporciona una base eficiente para el Query Engine, el Save Pipeline y el sistema de replicación Multiplayer, sin introducir dependencias con el gameplay o los Systems.
# 05 - COMPONENT REGISTRY

# Parte 3 — Integración con el Framework

---

# Objetivo

Esta sección define cómo interactúa el Component Registry con el resto del Framework ECS.

El Registry constituye uno de los pilares del Runtime y colabora con otros subsistemas mediante contratos públicos, Events y Queries.

En ningún caso debe existir acoplamiento directo con implementaciones concretas ni dependencias hacia el gameplay.

---

# Filosofía

El Component Registry es el propietario exclusivo del almacenamiento de Components.

No interpreta los datos.

No ejecuta lógica.

No toma decisiones de gameplay.

Los demás subsistemas utilizan los datos almacenados, pero ninguno administra directamente su ciclo de vida.

---

# Integración con el Bootstrap

Durante el Bootstrap deben ejecutarse las siguientes etapas:

```text
Create Component Registry

↓

Initialize ComponentTypeRegistry

↓

Initialize Storages

↓

Initialize Allocator

↓

Initialize Validator

↓

Register Public Interface
```

Una vez completada la inicialización, el Registry permanece activo durante toda la vida del Runtime.

---

# Registro de Tipos

Todos los tipos de Component deben registrarse durante el Bootstrap.

Este registro debe completarse antes de que exista cualquier entidad dentro del mundo.

El orden recomendado es:

```text
Bootstrap

↓

Register Component Types

↓

Create Runtime

↓

Create Entities

↓

Attach Components
```

Esto garantiza que todos los Storage necesarios existan desde el inicio.

---

# Integración con el ECS Context

El Component Registry debe registrarse dentro del `IECSContext`.

Los consumidores nunca deben buscar implementaciones concretas.

El acceso siempre ocurre mediante contratos públicos.

Conceptualmente:

```text
Runtime

↓

ECS Context

↓

IComponentRegistry
```

---

# Integración con el Entity Registry

El Component Registry depende del `IEntityRegistry` únicamente para validar la existencia y el estado de las entidades.

No administra identificadores.

No crea entidades.

No destruye entidades.

El flujo normal es:

```text
Validate Entity

↓

Attach Component
```

---

# Creación de Entidades

Cuando una entidad es creada:

```text
Entity Registry

↓

Entity Alive

↓

Component Registry

↓

Attach Initial Components
```

El Registry no participa en la creación de la entidad.

Solo administra sus datos.

---

# Destrucción de Entidades

Cuando una entidad entra en proceso de destrucción:

```text
Entity Pending Destroy

↓

Component Registry

↓

Remove Components

↓

Entity Destroyed
```

El Registry elimina todos los Components pertenecientes a la entidad antes de que el Entity Registry recicle su identificador.

---

# Integración con los Systems

Los Systems nunca acceden directamente al almacenamiento interno.

Toda interacción ocurre mediante el contrato público.

Ejemplo conceptual:

```text
System

↓

IComponentRegistry

↓

Component
```

Los Systems desconocen completamente cómo se almacenan los datos.

---

# Escritura de Datos

Cuando un System modifica un Component:

```text
Read Component

↓

Modify Data

↓

Registry Maintains Consistency
```

El Registry administra la integridad del almacenamiento.

No interpreta la modificación realizada.

---

# Integración con el Query Engine

El Query Engine depende del estado del Component Registry para localizar entidades compatibles con una Query.

Sin embargo:

- el Registry no ejecuta Queries;
- el Query Engine no modifica Components.

Ambos subsistemas permanecen completamente desacoplados.

---

# Actualización de Firmas

Cuando ocurre cualquiera de las siguientes operaciones:

- Add Component
- Remove Component

la firma lógica de la entidad cambia.

Conceptualmente:

```text
Old Signature

↓

Add Health

↓

New Signature
```

El Query Engine utilizará esta información para mantener actualizados sus índices.

El Component Registry únicamente expone el cambio.

---

# Integración con el Event Bus

El Component Registry puede publicar eventos relacionados con cambios estructurales.

Ejemplos conceptuales:

```text
ComponentAdded

ComponentRemoved

ComponentReplaced
```

No debe publicar eventos por modificaciones internas de los datos, ya que estas pertenecen al gameplay y a los Systems.

---

# Desacoplamiento

El Registry nunca debe ejecutar llamadas como:

```text
CombatSystem.update()

InventorySystem.refresh()

MovementSystem.notify()
```

Toda coordinación ocurre mediante:

- Events;
- Interfaces;
- Queries.

---

# Integración con el Save Pipeline

El Component Registry proporciona acceso a los datos necesarios para la persistencia.

No serializa directamente.

No escribe archivos.

No interpreta formatos.

Su responsabilidad termina al exponer los Components registrados.

---

# Datos Persistentes

La persistencia incluye:

- tipos de Component;
- datos de cada Component;
- relación entre entidad y Component.

No incluye:

- caches;
- estructuras auxiliares;
- memoria temporal;
- índices internos reconstruibles.

---

# Integración con Multiplayer

El Component Registry debe ser completamente compatible con un modelo Server Authoritative.

Los clientes no deben modificar directamente los Components replicados.

Toda modificación autorizada proviene del servidor.

---

# Replicación

Conceptualmente:

```text
Server

↓

Component Changed

↓

Replication

↓

Client Registry

↓

Update Component
```

El Registry no implementa la replicación.

Únicamente proporciona una API compatible con ella.

---

# Determinismo

Una misma secuencia de operaciones debe producir exactamente el mismo estado del almacenamiento en cualquier instancia del Runtime.

No debe existir comportamiento dependiente de:

- plataforma;
- hardware;
- velocidad de ejecución.

---

# Integración con Debug

Las herramientas de depuración podrán consultar información como:

- tipos registrados;
- cantidad de Components por tipo;
- Components de una entidad;
- capacidad de cada Storage;
- uso de memoria.

Las herramientas nunca deben modificar directamente el almacenamiento.

---

# Integración con Profiling

El Registry debe exponer métricas útiles para análisis de rendimiento.

Ejemplos:

- inserciones por segundo;
- eliminaciones por segundo;
- lecturas por segundo;
- tiempo medio de acceso;
- utilización de memoria por Storage;
- crecimiento de cada almacenamiento.

La recopilación de métricas debe poder habilitarse o deshabilitarse sin afectar el comportamiento funcional.

---

# Integración con Testing

El contrato `IComponentRegistry` debe permitir implementaciones simuladas para pruebas.

Las pruebas deberán validar:

- registro de tipos;
- inserción;
- eliminación;
- lectura;
- prevención de duplicados;
- destrucción por eliminación de entidad;
- consistencia del almacenamiento.

---

# Dependencias Permitidas

El Component Registry puede interactuar con:

- IECSContext
- IEntityRegistry
- IQueryEngine
- IEventBus
- Interfaces internas del subsistema

Nunca debe depender de:

- Systems concretos;
- Gameplay;
- SceneTree;
- UI;
- Recursos específicos del juego.

---

# Garantías Arquitectónicas

La integración del Component Registry debe garantizar que:

- ningún módulo modifique directamente el almacenamiento;
- toda operación pase por el contrato público;
- las firmas permanezcan consistentes;
- el almacenamiento pueda evolucionar sin afectar a los consumidores;
- el desacoplamiento entre subsistemas se mantenga durante toda la vida del Runtime.

---

# Resultado Esperado

Al finalizar esta sección, el Component Registry queda completamente integrado dentro del Framework ECS.

Su responsabilidad permanece limitada a la administración del almacenamiento de Components, mientras que la coordinación con el Entity Registry, el Query Engine, el Event Bus, el Save Pipeline y el sistema Multiplayer se realiza exclusivamente mediante contratos públicos y mecanismos definidos por la arquitectura general del Runtime, preservando el bajo acoplamiento y la escalabilidad del Framework.
# 05 - COMPONENT REGISTRY

# Parte 4 — Rendimiento, Memoria, Depuración y Consideraciones de Implementación

---

# Objetivo

Esta sección define las consideraciones de implementación relacionadas con el rendimiento, la administración de memoria, la depuración, las pruebas y la evolución futura del Component Registry.

Las reglas aquí descritas deberán respetarse independientemente de la estrategia concreta de almacenamiento utilizada.

---

# Filosofía

El Component Registry será uno de los subsistemas con mayor volumen de datos del Runtime.

Mientras el Entity Registry administra identidades, el Component Registry administra prácticamente toda la información del mundo.

Por este motivo su diseño debe priorizar:

- acceso rápido;
- baja fragmentación;
- alta localidad de memoria;
- escalabilidad;
- determinismo.

---

# Objetivos de Rendimiento

Las siguientes operaciones deberán ser extremadamente eficientes:

- Registrar tipos.
- Añadir Components.
- Eliminar Components.
- Consultar Components.
- Verificar existencia.
- Obtener Storage.
- Iterar Components.

La implementación debe minimizar asignaciones dinámicas durante la ejecución normal.

---

# Complejidad Esperada

Como objetivo arquitectónico:

| Operación | Complejidad Esperada |
|------------|----------------------|
| Registrar tipo | O(1) amortizado |
| Obtener Type ID | O(1) |
| Añadir Component | O(1) amortizado |
| Eliminar Component | O(1) |
| Consultar Component | O(1) |
| Verificar existencia | O(1) |
| Obtener Storage | O(1) |

Estos valores representan los objetivos del Framework.

La implementación concreta podrá variar siempre que mantenga un rendimiento equivalente.

---

# Localidad de Memoria

Siempre que sea posible, los Components del mismo tipo deberán almacenarse de forma contigua.

Conceptualmente:

```text
Transform Storage

↓

[T][T][T][T][T]
```

Esto mejora:

- uso de caché de CPU;
- iteraciones;
- rendimiento de Queries.

---

# Separación por Tipo

Nunca debe existir un almacenamiento único para todos los Components.

La separación por tipo permite:

- acceso directo;
- optimizaciones específicas;
- menor fragmentación;
- independencia entre Storage.

---

# Administración de Memoria

El `ComponentAllocator` debe minimizar:

- asignaciones dinámicas;
- copias innecesarias;
- fragmentación.

Siempre que sea posible deberá reutilizar memoria previamente liberada.

---

# Reserva de Capacidad

Los Storage pueden reservar capacidad anticipadamente.

Ejemplo conceptual:

```text
Health Storage

↓

Reserve(5000)
```

Esto reduce la cantidad de reasignaciones durante la ejecución.

La reserva nunca crea Components.

---

# Crecimiento

Cuando un Storage alcance su capacidad:

```text
Capacity Full

↓

Grow

↓

Continue
```

El crecimiento debe preservar la consistencia de los datos existentes.

---

# Eliminación

La eliminación de un Component debe liberar su posición para futuras reutilizaciones.

No deben mantenerse espacios muertos de forma indefinida.

La estrategia concreta (compactación, swap-remove, listas libres, etc.) queda a criterio de la implementación, siempre que respete el contrato público y el determinismo del Framework.

---

# Fragmentación

El almacenamiento debe minimizar la fragmentación lógica y física.

Las estructuras internas deberán mantenerse compactas siempre que el coste de hacerlo sea razonable.

---

# Compactación

Si la implementación incorpora procesos de compactación:

- nunca deben modificar la API pública;
- nunca deben invalidar identificadores de entidades;
- nunca deben alterar el significado de los datos.

La compactación debe ser completamente transparente para los consumidores.

---

# Acceso Directo

El Runtime nunca debe permitir acceso directo a las estructuras internas del Storage.

Toda interacción debe realizarse mediante el `IComponentRegistry` o los contratos internos definidos para este subsistema.

Esto permite modificar la implementación sin afectar al resto del Framework.

---

# Validaciones

Antes de cualquier operación deben comprobarse:

- entidad válida;
- tipo registrado;
- Component existente cuando corresponda;
- ausencia de duplicados;
- coherencia del Storage.

Estas comprobaciones forman parte del `ComponentValidator`.

---

# Detección de Corrupción

El Registry debe detectar situaciones inconsistentes.

Ejemplos:

- Component sin entidad;
- entidad inexistente;
- tipo no registrado;
- duplicados;
- referencias internas inválidas.

En modo Debug estas comprobaciones deberán ser exhaustivas.

---

# Modo Release

En compilaciones Release podrán omitirse determinadas comprobaciones costosas.

No obstante, las validaciones necesarias para mantener la integridad del Runtime deberán permanecer activas.

---

# Instrumentación

El Registry debe exponer información útil para herramientas de análisis.

Ejemplos:

- número de tipos registrados;
- Components por Storage;
- utilización de memoria;
- capacidad disponible;
- crecimiento histórico;
- inserciones y eliminaciones.

La instrumentación debe poder habilitarse o deshabilitarse sin modificar el comportamiento funcional.

---

# Logging

El Component Registry únicamente debe registrar información relevante.

Ejemplos:

- errores críticos;
- corrupción detectada;
- fallos de inicialización.

No debe registrar operaciones normales como inserciones o lecturas durante la ejecución habitual.

---

# Estadísticas

La implementación puede mantener contadores internos como:

```text
Registered Types

Active Components

Components Added

Components Removed

Peak Components

Storage Capacity

Storage Utilization
```

Estas estadísticas facilitan el análisis del comportamiento del Runtime.

---

# Herramientas de Depuración

El Framework podrá proporcionar herramientas capaces de inspeccionar el estado del Component Registry.

Ejemplos:

- listar tipos registrados;
- inspeccionar Storage;
- visualizar Components por entidad;
- consultar capacidad utilizada;
- detectar Components huérfanos.

Estas herramientas deberán utilizar únicamente contratos públicos.

---

# Validaciones Automáticas

El Registry debe permitir ejecutar comprobaciones completas de consistencia.

Ejemplos:

- todos los tipos utilizados están registrados;
- no existen Components duplicados;
- no existen Components sin entidad;
- todas las entidades referenciadas existen;
- todos los Storage son consistentes.

Estas validaciones serán especialmente útiles durante el desarrollo y las pruebas de integración.

---

# Compatibilidad con Testing

Toda implementación deberá superar pruebas automáticas que verifiquen:

- registro de tipos;
- creación de Storage;
- inserción;
- eliminación;
- lectura;
- reutilización de memoria;
- destrucción masiva;
- reinicio del Runtime.

---

# Escenarios de Prueba

Como mínimo deberán contemplarse los siguientes casos.

## Registro de Tipos

Registrar múltiples tipos.

Verificar:

- Type IDs únicos;
- consistencia del registro.

---

## Inserción

Añadir Components a distintas entidades.

Verificar:

- almacenamiento correcto;
- ausencia de duplicados;
- acceso consistente.

---

## Eliminación

Eliminar Components.

Verificar:

- liberación de memoria;
- consistencia del Storage;
- actualización de firmas.

---

## Destrucción de Entidades

Eliminar una entidad con múltiples Components.

Verificar:

- eliminación completa;
- ausencia de datos huérfanos;
- consistencia de todos los Storage.

---

## Operaciones Masivas

Crear y eliminar grandes cantidades de Components.

Verificar:

- rendimiento;
- estabilidad;
- ausencia de fragmentación excesiva.

---

## Reinicio del Runtime

Vaciar completamente el Registry.

Verificar:

- estado limpio;
- Storage reutilizable;
- ausencia de referencias residuales.

---

# Compatibilidad con Futuras Extensiones

La arquitectura del Component Registry debe permitir incorporar futuras optimizaciones sin modificar su API pública.

Ejemplos:

- Dense Sets especializados;
- Sparse Sets;
- Chunked Storage;
- Pools personalizados;
- almacenamiento híbrido;
- optimizaciones para SIMD;
- paralelización de determinadas operaciones.

Todas estas mejoras deberán permanecer transparentes para los consumidores del `IComponentRegistry`.

---

# Restricciones de Implementación

La implementación del Component Registry no debe:

- depender del SceneTree;
- acceder a Nodes;
- conocer Systems concretos;
- interpretar gameplay;
- modificar directamente entidades;
- ejecutar Queries;
- serializar datos por cuenta propia.

---

# Resumen Arquitectónico

El Component Registry constituye la autoridad única sobre el almacenamiento de datos del Runtime.

Su diseño se basa en:

- registro de tipos;
- almacenamiento independiente por Component;
- asignación eficiente de memoria;
- validaciones centralizadas;
- integración mediante interfaces;
- determinismo;
- escalabilidad.

El resto del Framework asume que el Registry garantiza la integridad de todos los Components existentes.

---

# Relación con el Query Engine

La estructura definida en este documento prepara directamente la implementación del siguiente subsistema:

`06_QUERY_ENGINE_IMPLEMENTATION`

El Query Engine utilizará:

- Component Type IDs;
- firmas de entidades;
- Storage especializados;
- validaciones del Registry.

Gracias a esta organización podrá ejecutar consultas de forma altamente eficiente sin acoplarse a los detalles internos del almacenamiento.

---

# Resultado Esperado

Con este documento queda completamente especificada la implementación del Component Registry del Framework ECS de Survivors Lords.

La arquitectura propuesta proporciona un subsistema especializado, desacoplado y preparado para manejar grandes volúmenes de datos con alto rendimiento, garantizando consistencia, compatibilidad con Multiplayer, Save, Queries y futuras optimizaciones del Framework sin modificar los contratos públicos definidos previamente.
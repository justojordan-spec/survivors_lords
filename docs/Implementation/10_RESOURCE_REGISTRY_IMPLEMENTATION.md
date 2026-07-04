# 10 - RESOURCE REGISTRY IMPLEMENTATION

# Parte 1 — Arquitectura General

---

# Objetivo

Este documento define la implementación del **Resource Registry** del Framework ECS de Survivors Lords.

El Resource Registry constituye la infraestructura responsable de administrar todos los Resources Data Driven utilizados durante la ejecución del Runtime.

Su función no consiste en contener datos del juego.

Los datos pertenecen exclusivamente a los Resources definidos durante la Fase 4.

El Resource Registry únicamente administra:

- carga;
- registro;
- resolución;
- acceso;
- ciclo de vida;
- cache;
- validación.

---

# Alcance

Este documento define:

- Arquitectura del Resource Registry.
- Bootstrap.
- Registro de Resources.
- Resource Loaders.
- Resource Providers.
- Cache.
- Validaciones.
- Integración con Runtime.
- Debug.
- Testing.

No define:

- Gameplay.
- Resources concretos.
- Configuración de Items.
- Configuración de NPCs.
- Configuración de Buildings.
- Configuración del Mundo.

Toda esa información ya fue documentada en la Fase 4.

---

# Filosofía

Todo dato configurable del juego pertenece a un Resource.

Los Systems nunca contienen configuración.

Los Components nunca contienen configuración global.

Las escenas nunca contienen configuración de gameplay.

Toda configuración proviene del Resource Registry.

---

# Principio Fundamental

Los Resources representan información completamente inmutable durante la ejecución normal del Runtime.

Conceptualmente:

```text
Disk

↓

Load

↓

Registry

↓

Read Only

↓

Systems
```

Los Systems únicamente leen información.

Nunca la modifican.

---

# Arquitectura General

El Resource Registry se divide en módulos especializados.

```text
                  IResourceRegistry
                          │
                          ▼
                 ResourceRegistry
─────────────────────────────────────────────────────────────
                          │
        ┌────────────┬────────────┬────────────┬────────────┬────────────┐
        ▼            ▼            ▼            ▼            ▼
 ResourceLoader
 ResourceCatalog
 ResourceProvider
 ResourceCache
 ResourceValidator
 ResourceProfiler
```

Cada módulo posee una única responsabilidad.

---

# Resource Registry

## Responsabilidad

Actúa como fachada pública.

Expone la API utilizada por:

- Systems;
- Query Handlers;
- Bootstrap;
- Runtime.

Nunca carga directamente archivos.

Nunca interpreta datos.

Nunca realiza búsquedas físicas.

---

# Resource Loader

## Responsabilidad

Cargar Resources desde el almacenamiento.

Ejemplo conceptual:

```text
Disk

↓

Resource Loader

↓

Resource
```

El Loader únicamente conoce cómo obtener el Resource.

No conoce gameplay.

---

# Resource Catalog

## Responsabilidad

Mantener el catálogo completo de todos los Resources registrados.

Relaciona:

- identificador;
- tipo;
- ubicación;
- instancia cargada.

No realiza cargas.

No interpreta información.

---

# Resource Provider

## Responsabilidad

Entregar Resources a los consumidores.

Conceptualmente:

```text
System

↓

Provider

↓

Resource
```

El Provider nunca modifica los datos.

---

# Resource Cache

## Responsabilidad

Mantener en memoria los Resources ya cargados.

Evita cargas repetidas desde disco.

---

# Resource Validator

## Responsabilidad

Verificar:

- integridad;
- tipo;
- dependencias;
- consistencia;
- compatibilidad.

Antes de que un Resource quede disponible.

---

# Resource Profiler

## Responsabilidad

Recopilar estadísticas relacionadas con:

- carga;
- tiempo;
- memoria;
- reutilización;
- cache.

No modifica el comportamiento del Runtime.

---

# Diferencia con ResourceLoader

El Loader obtiene datos.

El Registry administra esos datos.

Conceptualmente:

```text
Loader

↓

Load

↓

Registry

↓

Provide
```

---

# Qué es un Resource

Un Resource representa información Data Driven.

Ejemplos conceptuales:

```text
Item Definition

NPC Definition

Biome Definition

Craft Recipe

Building Definition
```

Todos contienen únicamente configuración.

---

# Qué NO es un Resource

No representan:

- entidades;
- Components;
- estado del juego;
- inventarios;
- IA activa;
- progreso del jugador.

Toda esa información pertenece al Runtime.

---

# Solo Lectura

Después de cargarse:

```text
Resource

↓

Read

↓

Use
```

Nunca:

```text
Resource

↓

Modify
```

---

# Inmutabilidad

Durante la ejecución normal:

Los Resources deben considerarse completamente inmutables.

Si un System necesita modificar información:

Debe hacerlo sobre Components.

Nunca sobre Resources.

---

# Comunicación

El flujo oficial es:

```text
System

↓

Resource Registry

↓

Resource

↓

Read Data
```

Nunca:

```text
System

↓

Load Resource
```

Los Systems no conocen la ubicación física de los archivos.

---

# Integración con Systems

Los Systems únicamente pueden:

- solicitar Resources;
- consultar información;
- reutilizar referencias de solo lectura.

Nunca cargarlos manualmente.

---

# Integración con Components

Los Components nunca almacenan configuración duplicada.

Únicamente conservan referencias o identificadores necesarios para localizar Resources.

Ejemplo conceptual:

```text
WeaponComponent

↓

Weapon ID

↓

Query Registry

↓

Weapon Resource
```

---

# Integración con Queries

Los Query Handlers pueden utilizar el Resource Registry para construir resultados.

Siempre en modo lectura.

---

# Integración con Event Bus

El Event Bus nunca interactúa directamente con los Resources.

Si un cambio de Runtime requiere consultar configuración:

El System correspondiente utilizará el Resource Registry.

---

# Ciclo de Vida

El Resource Registry posee el siguiente ciclo:

```text
Created

↓

Initialized

↓

Loading

↓

Validated

↓

Ready

↓

Running

↓

Disposed
```

---

# Created

El objeto existe.

Todavía no posee información registrada.

---

# Initialized

Se crean todos los módulos internos.

---

# Loading

Comienza la carga desde disco.

---

# Validated

Todos los Resources son verificados.

---

# Ready

Los Resources quedan disponibles para todo el Runtime.

---

# Running

Los Systems utilizan normalmente el Registry.

---

# Disposed

Toda la memoria administrada por el Registry es liberada.

---

# Garantías

El Resource Registry garantiza:

- una única instancia global;
- acceso centralizado;
- Resources inmutables;
- ausencia de duplicación;
- reutilización eficiente;
- independencia del gameplay.

---

# Separación de Responsabilidades

| Módulo | Responsabilidad |
|----------|----------------|
| Resource Registry | API pública |
| Resource Loader | Carga desde almacenamiento |
| Resource Catalog | Registro de Resources |
| Resource Provider | Entrega de Resources |
| Resource Cache | Cache en memoria |
| Resource Validator | Validaciones |
| Resource Profiler | Métricas |

Cada módulo mantiene una única responsabilidad.

---

# Dependencias Permitidas

El Resource Registry puede depender únicamente de:

- IECSContext;
- Runtime Services;
- FileSystem;
- interfaces internas.

Nunca debe depender de:

- gameplay;
- escenas;
- Components;
- Systems específicos.

---

# Objetivos Arquitectónicos

La implementación debe permitir:

- miles de consultas por Frame;
- carga centralizada;
- acceso rápido;
- cache eficiente;
- validaciones automáticas;
- instrumentación para Debug;
- crecimiento continuo del proyecto.

---

# Resultado Esperado

Al finalizar esta primera parte queda definida la arquitectura general del **Resource Registry** del Framework ECS.

El Resource Registry se establece como el único punto oficial de acceso a todos los Resources Data Driven del proyecto, organizado mediante módulos especializados para la carga, registro, provisión, validación, almacenamiento en caché y profiling, garantizando un acceso centralizado, inmutable y completamente desacoplado del gameplay y de la implementación de los Systems.
# 10 - RESOURCE REGISTRY IMPLEMENTATION

# Parte 2 — Resource Lifecycle, Bootstrap, Resource Loader y Resource Catalog

---

# Objetivo

Esta sección define el ciclo de vida completo de un Resource dentro del Runtime, el proceso de carga durante el Bootstrap y el funcionamiento del **Resource Loader** y del **Resource Catalog**.

El propósito es establecer un proceso único, determinista y completamente controlado para incorporar todos los Resources Data Driven al Framework ECS antes del inicio de la simulación.

---

# Filosofía

Los Resources no se cargan bajo demanda durante el gameplay.

El Runtime debe comenzar con un conjunto de Resources consistente y validado.

Toda la información Data Driven debe encontrarse disponible antes de ejecutar el primer System.

---

# Principio Fundamental

Todo Resource sigue exactamente el mismo flujo de incorporación.

```text
Discover

↓

Load

↓

Validate

↓

Register

↓

Cache

↓

Ready
```

Una vez finalizado este proceso, el Resource queda disponible para todo el Runtime.

---

# Resource Lifecycle

Cada Resource atraviesa los siguientes estados.

```text
Discovered

↓

Loading

↓

Loaded

↓

Validated

↓

Registered

↓

Cached

↓

Available

↓

Disposed
```

---

# Discovered

El Bootstrap identifica que el Resource existe.

Todavía no ha sido cargado.

En este estado únicamente se conoce:

- ubicación;
- tipo esperado;
- identificador.

---

# Loading

El Resource Loader comienza la lectura desde el almacenamiento.

Conceptualmente:

```text
Disk

↓

Resource Loader

↓

Memory
```

Todavía no puede ser utilizado por ningún System.

---

# Loaded

El archivo fue leído correctamente.

Existe una instancia del Resource en memoria.

Todavía no fue validada.

---

# Validated

El Resource Validator verifica:

- tipo correcto;
- formato válido;
- estructura consistente;
- dependencias resolubles;
- datos mínimos requeridos.

Solo después de superar estas comprobaciones puede continuar el proceso.

---

# Registered

El Resource Catalog incorpora el Resource al registro oficial.

Desde este momento puede resolverse mediante su identificador.

---

# Cached

El Resource Cache conserva la referencia en memoria.

Las solicitudes posteriores reutilizarán la misma instancia.

---

# Available

El Resource queda oficialmente disponible para:

- Systems;
- Query Handlers;
- Runtime Services;
- herramientas de Debug.

---

# Disposed

Durante el cierre del Runtime, el Registry libera todas las referencias administradas.

---

# Bootstrap

La carga de Resources forma parte del proceso oficial de inicialización del Framework.

Conceptualmente:

```text
Runtime Bootstrap

↓

Create Resource Registry

↓

Discover Resources

↓

Load

↓

Validate

↓

Register

↓

Ready
```

El Scheduler nunca debe comenzar mientras el Resource Registry permanezca incompleto.

---

# Descubrimiento de Resources

Durante el Bootstrap, el Resource Loader localiza todos los Resources que forman parte del proyecto.

Este proceso puede realizarse utilizando:

- rutas conocidas;
- catálogos predefinidos;
- índices generados durante el desarrollo.

El mecanismo concreto queda desacoplado de la arquitectura.

---

# Orden de Carga

El Bootstrap debe garantizar un orden de carga determinista.

Conceptualmente:

```text
Global Resources

↓

Gameplay Resources

↓

World Resources

↓

Optional Resources
```

Este orden evita dependencias inconsistentes.

---

# Carga Completa

Antes del primer Frame deben cumplirse las siguientes condiciones:

- todos los Resources requeridos fueron cargados;
- todas las validaciones finalizaron;
- todos los registros fueron completados.

Solo entonces el Runtime podrá cambiar al estado **Ready**.

---

# Resource Loader

## Responsabilidad

El Resource Loader constituye el único módulo autorizado para obtener Resources desde el almacenamiento.

No mantiene registros.

No proporciona acceso a Systems.

No realiza búsquedas posteriores.

---

# Flujo del Loader

Conceptualmente:

```text
Resource Path

↓

Read

↓

Create Instance

↓

Return Resource
```

El Loader finaliza su responsabilidad al devolver la instancia cargada.

---

# Independencia

El Loader nunca debe conocer:

- gameplay;
- Components;
- Systems;
- Queries;
- Event Bus.

Su única responsabilidad consiste en cargar datos.

---

# Resource Catalog

## Responsabilidad

El Resource Catalog mantiene el registro oficial de todos los Resources disponibles.

Relaciona:

- identificador;
- tipo;
- instancia;
- metadatos internos.

No realiza cargas.

No ejecuta validaciones.

No entrega Resources directamente.

---

# Organización Conceptual

```text
Resource ID

↓

Resource Entry
```

Cada identificador debe ser único.

---

# Identificadores

Todo Resource debe poseer un identificador estable.

Ejemplo conceptual:

```text
weapon_iron_sword
```

```text
building_campfire
```

```text
npc_wolf
```

El identificador constituye la clave principal del Resource Catalog.

---

# Registro Único

Un identificador solo puede asociarse a un Resource.

Configuración válida:

```text
weapon_iron_sword

↓

Weapon Resource
```

Configuración inválida:

```text
weapon_iron_sword

↓

Resource A

↓

Resource B
```

El Validator debe detectar duplicados durante el Bootstrap.

---

# Búsqueda

Cuando un consumidor solicita un Resource:

```text
Resource ID

↓

Catalog

↓

Resource Entry
```

La operación debe ser rápida y determinista.

---

# Organización Interna

El Catalog debe optimizar principalmente:

- resolución por identificador;
- resolución por tipo;
- recorrido durante Debug;
- recorrido durante validaciones.

---

# Integridad

El Catalog garantiza:

- ausencia de duplicados;
- referencias válidas;
- consistencia del registro;
- estabilidad durante todo el Runtime.

---

# Modificaciones

Una vez completado el Bootstrap:

El Resource Catalog permanece esencialmente inmutable.

No deben incorporarse nuevos Resources durante la ejecución normal del juego.

Las únicas excepciones pertenecen a herramientas de desarrollo como el Hot Reload.

---

# Dependencias

El Resource Catalog puede depender de:

- Resource Validator;
- Resource Cache;
- Resource Registry.

Nunca de Systems específicos.

---

# Restricciones

El Resource Loader nunca debe:

- registrar Resources;
- entregar Resources al gameplay;
- interpretar configuración.

El Resource Catalog nunca debe:

- cargar archivos;
- validar datos;
- modificar Resources.

Cada módulo conserva una única responsabilidad.

---

# Garantías

El proceso de Bootstrap garantiza que:

- todos los Resources requeridos se encuentran disponibles antes del primer Frame;
- el orden de carga es determinista;
- ningún Resource inválido llega al Runtime;
- cada identificador posee exactamente una instancia registrada.

---

# Flujo Completo

Conceptualmente:

```text
Bootstrap

↓

Discover Resources

↓

Load

↓

Validate

↓

Register

↓

Cache

↓

Runtime Ready
```

Este flujo representa el comportamiento oficial del proceso de carga del Framework ECS.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificado el **Resource Lifecycle**, el proceso de **Bootstrap**, el funcionamiento del **Resource Loader** y del **Resource Catalog**.

La arquitectura garantiza una carga determinista y centralizada de todos los Resources Data Driven, asegurando que cada uno sea validado, registrado y puesto a disposición del Runtime antes del inicio de la simulación, manteniendo una estricta separación de responsabilidades entre los distintos módulos del Resource Registry.
# 10 - RESOURCE REGISTRY IMPLEMENTATION

# Parte 3 — Resource Provider, Resolución, Cache y Acceso a Resources

---

# Objetivo

Esta sección define cómo el Runtime obtiene acceso a los Resources ya registrados mediante el **Resource Provider**, el proceso de resolución de Resources y el funcionamiento interno del **Resource Cache**.

Una vez finalizado el Bootstrap, ningún System debe conocer dónde se encuentra almacenado un Resource.

Toda resolución debe realizarse exclusivamente a través del Resource Registry.

---

# Filosofía

Después del Bootstrap:

Los Resources ya existen.

No deben volver a cargarse.

No deben volver a validarse.

No deben volver a registrarse.

Únicamente deben resolverse y entregarse a quien los solicite.

---

# Flujo General

Conceptualmente:

```text
System

↓

Resource Registry

↓

Provider

↓

Catalog

↓

Cache

↓

Resource

↓

Return
```

Todo el proceso ocurre de forma transparente para el consumidor.

---

# Resource Provider

## Responsabilidad

El Resource Provider constituye el único módulo encargado de entregar Resources.

No carga archivos.

No realiza validaciones.

No interpreta configuración.

Su única responsabilidad consiste en localizar el Resource correcto y devolverlo.

---

# Responsabilidad Única

El Provider únicamente debe:

- resolver identificadores;
- obtener referencias;
- consultar el Cache;
- devolver Resources.

Nada más.

---

# Flujo del Provider

Conceptualmente:

```text
Receive Request

↓

Resolve ID

↓

Locate Resource

↓

Return Reference
```

---

# Resolución

Toda solicitud comienza con un identificador.

Ejemplo conceptual:

```text
weapon_iron_sword
```

↓

```text
Weapon Resource
```

---

# Tipos de Resolución

La arquitectura admite distintas formas de resolución.

Por ejemplo:

- por ID;
- por tipo;
- por categoría;
- por colección.

La implementación concreta puede evolucionar sin modificar la API pública.

---

# Resolución por ID

Es el mecanismo principal.

Conceptualmente:

```text
Resource ID

↓

Catalog

↓

Resource
```

Debe ser extremadamente rápida.

---

# Resolución por Tipo

También puede resultar útil obtener todos los Resources de un tipo.

Ejemplo:

```text
Weapon Resources
```

↓

```text
Collection
```

Este tipo de consulta resulta especialmente útil para herramientas de Debug y editores.

---

# Resolución por Categoría

Ejemplo conceptual:

```text
Biome Resources
```

↓

```text
All Biomes
```

La categorización pertenece al catálogo de Resources.

---

# Referencias Compartidas

Todos los consumidores reciben exactamente la misma instancia del Resource.

Conceptualmente:

```text
Combat System

↓

Weapon Resource

↑

Craft System

↑

Inventory System
```

Existe una única instancia compartida.

---

# Inmutabilidad

Como los Resources son de solo lectura:

La reutilización de referencias resulta completamente segura.

No es necesario duplicar información.

---

# Resource Cache

## Responsabilidad

Evitar cargas repetidas y búsquedas costosas.

El Cache almacena referencias ya disponibles en memoria.

---

# Filosofía

El Cache no almacena copias.

Almacena referencias.

Conceptualmente:

```text
Resource

↓

Reference

↓

Reuse
```

---

# Cache Hit

Cuando el Resource ya se encuentra disponible:

```text
Request

↓

Cache

↓

Resource
```

No interviene el Loader.

---

# Cache Miss

Durante la ejecución normal del Runtime no deberían existir Cache Miss.

Todos los Resources ya fueron cargados durante el Bootstrap.

Si ocurre un Cache Miss representa una situación excepcional.

---

# Consistencia

El Cache siempre debe devolver exactamente la misma referencia registrada.

Nunca debe construir nuevas instancias.

---

# Ciclo de Vida del Cache

Conceptualmente:

```text
Bootstrap

↓

Store Reference

↓

Runtime

↓

Reuse

↓

Dispose
```

---

# Ownership

El Resource Registry conserva la propiedad de las referencias.

Los consumidores únicamente reciben acceso de solo lectura.

---

# Acceso desde Systems

Los Systems nunca deben:

- abrir archivos;
- buscar rutas;
- crear Resources;
- mantener copias.

Únicamente solicitan:

```text
Get Resource

↓

Read
```

---

# Acceso desde Query Handlers

Los Query Handlers pueden utilizar el Provider para construir respuestas.

Siempre en modo lectura.

Ejemplo conceptual:

```text
Item Query

↓

Resource Provider

↓

Item Definition

↓

Result
```

---

# Acceso desde Runtime Services

Servicios internos como:

- Save;
- AI;
- Debug;
- Generación del mundo;

también utilizan el Provider.

Nunca acceden directamente al Loader.

---

# Acceso Concurrente

Como los Resources son inmutables:

Múltiples consumidores pueden leer simultáneamente el mismo Resource.

Conceptualmente:

```text
System A

↓

Resource

↑

System B

↑

System C
```

Sin necesidad de sincronización adicional.

---

# Recursos Compartidos

Un mismo Resource puede ser utilizado por cientos de entidades diferentes.

Ejemplo conceptual:

```text
Iron Sword Resource

↓

Entity 1

↓

Entity 2

↓

Entity 3

↓

Entity N
```

Siempre existe una única instancia.

---

# Ausencia de Duplicación

Nunca deben existir:

```text
Iron Sword Copy A

Iron Sword Copy B

Iron Sword Copy C
```

Toda la información compartida proviene de una única fuente.

---

# Integración con Components

Los Components únicamente almacenan referencias indirectas.

Ejemplo:

```text
WeaponComponent

↓

Weapon ID
```

↓

```text
Resource Provider

↓

Weapon Resource
```

Esto evita duplicar configuración dentro de cada entidad.

---

# Integración con Queries

Las Queries pueden resolver Resources cuando necesiten construir resultados.

Nunca modificarlos.

---

# Integración con Event Bus

El Event Bus nunca consulta Resources directamente.

Toda resolución pertenece a los Systems o Query Handlers.

---

# Integración con Save

El Save Pipeline nunca serializa Resources.

Únicamente serializa identificadores.

Durante la carga:

```text
Load ID

↓

Provider

↓

Resource
```

Esto reduce significativamente el tamaño de los archivos de guardado.

---

# Integración con Multiplayer

La red nunca replica Resources.

Únicamente transmite identificadores.

Cada cliente resuelve esos identificadores utilizando su propio Resource Registry.

Conceptualmente:

```text
Network Packet

↓

Weapon ID

↓

Provider

↓

Weapon Resource
```

---

# Restricciones

El Resource Provider nunca debe:

- cargar archivos;
- modificar Resources;
- validar datos;
- conocer gameplay;
- crear nuevas instancias.

Su responsabilidad consiste únicamente en resolver referencias.

---

# Garantías

El Resource Provider garantiza:

- resolución centralizada;
- reutilización de referencias;
- ausencia de duplicación;
- acceso de solo lectura;
- independencia del almacenamiento físico.

El Resource Cache garantiza:

- reutilización eficiente;
- una única instancia por Resource;
- acceso inmediato durante el Runtime.

---

# Flujo Completo

Conceptualmente:

```text
System

↓

Request Resource

↓

Provider

↓

Catalog

↓

Cache

↓

Reference

↓

Continue Execution
```

Este flujo representa el comportamiento oficial de resolución y acceso a Resources dentro del Framework ECS.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificada la implementación del **Resource Provider**, el proceso de resolución de Resources y el funcionamiento del **Resource Cache**.

La arquitectura garantiza un acceso centralizado, eficiente e inmutable a todos los Resources Data Driven del proyecto, eliminando cargas repetidas, evitando duplicación de datos y proporcionando una única fuente de verdad para toda la configuración utilizada por el Runtime.
# 10 - RESOURCE REGISTRY IMPLEMENTATION

# Parte 4 — Integración con Systems, Scheduler, Registries, Save y Multiplayer

---

# Objetivo

Esta sección define cómo el Resource Registry se integra con el resto de la arquitectura del Framework ECS.

El Resource Registry constituye uno de los servicios fundamentales del Runtime y debe interactuar de forma consistente con:

- Scheduler
- Systems
- Entity Registry
- Component Registry
- Query Engine
- Event Bus
- Save Pipeline
- Multiplayer Pipeline
- Debug Tools

La integración debe preservar el desacoplamiento entre todos los subsistemas.

---

# Filosofía

El Resource Registry representa la única fuente oficial de configuración Data Driven durante la ejecución del juego.

Todos los consumidores obtienen la información desde un único punto de acceso.

Ningún otro módulo debe administrar Resources de forma independiente.

---

# Integración con Systems

Los Systems constituyen los principales consumidores del Resource Registry.

Toda consulta de configuración debe realizarse mediante la interfaz pública del Registry.

Nunca mediante rutas de archivos ni mediante carga manual de Resources.

---

# Flujo Oficial

Conceptualmente:

```text
System

↓

Request Resource

↓

Resource Registry

↓

Resource

↓

Read Configuration
```

---

# Responsabilidades de los Systems

Los Systems pueden:

- solicitar Resources;
- leer configuración;
- reutilizar referencias;
- almacenar identificadores.

No pueden:

- cargar Resources;
- modificarlos;
- registrarlos;
- eliminarlos.

---

# Integración con el Scheduler

El Scheduler controla el momento en que el Runtime puede comenzar a utilizar Resources.

El orden oficial es:

```text
Bootstrap

↓

Load Resources

↓

Validate

↓

Registry Ready

↓

Execute Scheduler
```

El primer Frame nunca debe comenzar mientras el Resource Registry permanezca incompleto.

---

# Estado Consistente

Durante la ejecución normal:

Todos los Systems observan exactamente el mismo conjunto de Resources.

No existen diferencias entre Frames.

No existen cargas parciales.

---

# Integración con Entity Registry

Las entidades nunca almacenan configuraciones completas.

Únicamente conservan referencias indirectas mediante identificadores.

Ejemplo conceptual:

```text
Entity

↓

WeaponComponent

↓

Weapon ID

↓

Resource Registry

↓

Weapon Resource
```

---

# Integración con Component Registry

Los Components representan estado dinámico.

Los Resources representan configuración estática.

Ambos se complementan.

Ejemplo:

```text
HealthComponent

↓

Current Health
```

```text
Character Resource

↓

Maximum Health
```

El Component almacena el estado actual.

El Resource define la configuración base.

---

# Integración con Query Engine

Los Query Handlers pueden utilizar el Resource Registry para construir resultados.

Ejemplo:

```text
Query

↓

Resource Registry

↓

Configuration

↓

Return Result
```

El Query Engine nunca administra Resources directamente.

---

# Integración con Event Bus

El Event Bus permanece completamente independiente del Resource Registry.

Los eventos nunca contienen Resources completos.

Cuando un Handler necesita configuración:

```text
Receive Event

↓

Resolve Resource

↓

Read Configuration
```

---

# Integración con Save

El Save Pipeline nunca serializa Resources completos.

Únicamente almacena identificadores.

Ejemplo conceptual:

```text
WeaponComponent

↓

Weapon ID

↓

Save File
```

Durante la carga:

```text
Weapon ID

↓

Resource Registry

↓

Weapon Resource
```

Esto mantiene los archivos de guardado pequeños y evita duplicar configuración.

---

# Restauración

Durante un proceso de Load:

```text
Restore Components

↓

Resolve Resource IDs

↓

Continue Runtime
```

Todos los Resources ya deben encontrarse disponibles antes de restaurar entidades.

---

# Integración con Multiplayer

En un modelo Server Authoritative:

Servidor y clientes poseen exactamente el mismo conjunto de Resources.

La red únicamente transmite identificadores.

---

# Replicación

Ejemplo conceptual:

```text
Network Packet

↓

Building ID

↓

Client Registry

↓

Building Resource
```

Nunca:

```text
Network Packet

↓

Entire Resource
```

---

# Sincronización

El Multiplayer Pipeline asume que:

- los Resources son idénticos;
- los identificadores son estables;
- el contenido es compatible entre cliente y servidor.

El Resource Registry no realiza sincronización de contenido.

---

# Integración con AI

Los AI Systems utilizan Resources para obtener:

- perfiles de comportamiento;
- configuración de percepción;
- parámetros de navegación;
- datos de combate.

Toda la información permanece en modo lectura.

---

# Integración con World Generation

Los Systems responsables de generar el mundo utilizan el Resource Registry para obtener:

- biomas;
- estructuras;
- vegetación;
- recursos naturales;
- configuraciones ambientales.

Nunca acceden directamente al almacenamiento.

---

# Integración con UI

La interfaz puede consultar Resources para obtener:

- iconos;
- nombres;
- descripciones;
- información visual.

La UI nunca modifica Resources.

---

# Integración con Debug

Las herramientas de Debug pueden consultar:

- Resources registrados;
- estado del Cache;
- tiempos de carga;
- dependencias;
- estadísticas.

Toda esta información debe exponerse como solo lectura.

---

# Integración con Profiling

El Resource Profiler recopila métricas como:

- tiempo de carga;
- cantidad de Resources;
- memoria utilizada;
- reutilización;
- consultas realizadas.

Estas métricas permiten optimizar el Bootstrap y el consumo de memoria.

---

# Integración con Testing

Las pruebas automatizadas pueden:

- registrar Resources simulados;
- validar resolución;
- comprobar referencias;
- medir tiempos de acceso.

Todo utilizando únicamente interfaces públicas.

---

# Dependencias Permitidas

El Resource Registry puede depender de:

- IECSContext;
- Runtime Services;
- FileSystem;
- Scheduler (durante Bootstrap);
- interfaces internas.

Siempre mediante abstracciones.

---

# Dependencias Prohibidas

El Resource Registry nunca debe depender de:

- gameplay;
- Systems concretos;
- escenas;
- UI;
- Event Bus;
- lógica de negocio.

Toda dependencia debe permanecer desacoplada.

---

# Restricciones

El Resource Registry nunca debe:

- contener estado dinámico;
- modificar Components;
- crear entidades;
- destruir entidades;
- ejecutar Queries;
- emitir Events;
- emitir Commands.

Su única responsabilidad consiste en administrar Resources Data Driven.

---

# Garantías

La integración del Resource Registry garantiza que:

- toda la configuración del proyecto posee una única fuente de verdad;
- los Systems permanecen desacoplados del almacenamiento físico;
- Save almacena únicamente identificadores;
- Multiplayer transmite únicamente referencias;
- todos los consumidores reutilizan las mismas instancias en memoria.

---

# Flujo Completo

Conceptualmente:

```text
Bootstrap

↓

Load Resources

↓

Registry Ready

↓

System Request

↓

Resolve Resource

↓

Read Configuration

↓

Continue Execution
```

Este flujo representa la integración oficial del Resource Registry con el resto del Framework ECS.

---

# Resultado Esperado

Al finalizar esta sección queda completamente especificada la integración del **Resource Registry** con el Scheduler, los Systems, los Registries, el Query Engine, el Event Bus, el Save Pipeline y el Multiplayer Pipeline.

El Resource Registry permanece como la infraestructura central encargada de administrar toda la configuración Data Driven del proyecto, proporcionando acceso inmutable, reutilizable y desacoplado a los Resources, garantizando consistencia, eficiencia y escalabilidad para todo el Runtime.
# 10 - RESOURCE REGISTRY IMPLEMENTATION

# Parte 5 — Performance, Validación, Hot Reload, Debug y Profiling

---

# Objetivo

Esta sección define las consideraciones relacionadas con el rendimiento, las validaciones internas, el soporte para Hot Reload durante el desarrollo, las herramientas de depuración y el sistema de profiling del Resource Registry.

El objetivo es garantizar que el Runtime pueda administrar cientos o miles de Resources Data Driven de forma eficiente, manteniendo tiempos de acceso constantes y proporcionando herramientas para diagnosticar problemas durante el desarrollo.

---

# Filosofía

El Resource Registry debe optimizar dos escenarios claramente diferenciados:

- **Bootstrap**, donde el costo principal es la carga y validación.
- **Runtime**, donde el costo principal es la resolución de Resources.

Cada etapa debe optimizarse de forma independiente.

---

# Objetivos de Rendimiento

La implementación debe minimizar:

- tiempo de carga;
- tiempo de validación;
- búsquedas repetidas;
- consumo de memoria;
- duplicación de Resources.

---

# Bootstrap

Durante el Bootstrap es aceptable realizar operaciones costosas como:

- lectura de archivos;
- validaciones completas;
- resolución de dependencias;
- construcción del catálogo.

Estas operaciones ocurren una única vez por ejecución.

---

# Runtime

Durante el Runtime, la resolución de un Resource debe evitar:

- acceso al disco;
- validaciones repetidas;
- reconstrucción de estructuras;
- creación de nuevas instancias.

Todo debe resolverse utilizando referencias ya registradas.

---

# Acceso al Catálogo

La operación más frecuente del Resource Registry es la resolución de un identificador.

Conceptualmente:

```text
Resource ID

↓

Catalog

↓

Resource Reference
```

Esta operación debe ser extremadamente rápida.

---

# Reutilización de Referencias

El Runtime siempre debe reutilizar la misma instancia de un Resource.

Nunca deben generarse copias innecesarias.

Conceptualmente:

```text
One Resource

↓

Many Readers
```

---

# Consumo de Memoria

Los Resources suelen compartirse entre cientos o miles de entidades.

Por este motivo, la duplicación de datos representa uno de los principales riesgos para el consumo de memoria.

El Registry debe garantizar una única instancia por Resource.

---

# Validación

## Objetivo

Detectar errores antes de que el Runtime comience la simulación.

Toda validación debe realizarse preferentemente durante el Bootstrap.

---

# Resource Validator

El Validator constituye el único módulo autorizado para comprobar la integridad de los Resources.

No modifica información.

No corrige errores automáticamente.

Únicamente informa resultados.

---

# Validaciones Obligatorias

Como mínimo deben comprobarse:

- identificador válido;
- tipo correcto;
- estructura esperada;
- formato compatible;
- referencias existentes;
- dependencias resolubles.

---

# Validación de Identificadores

Cada Resource debe poseer un identificador:

- único;
- estable;
- no vacío.

Los identificadores duplicados deben impedir la inicialización del Runtime.

---

# Validación de Tipos

El Validator debe comprobar que cada archivo corresponde al tipo esperado.

Ejemplo conceptual:

```text
Weapon Resource

↓

Weapon Definition
```

Nunca:

```text
Weapon Resource

↓

Biome Definition
```

---

# Validación de Dependencias

Si un Resource referencia a otro:

```text
Building Resource

↓

Craft Recipe

↓

Item Resource
```

Todas las referencias deben poder resolverse.

---

# Validación de Referencias

Toda referencia debe apuntar a un Resource registrado.

Las referencias inexistentes representan un error de configuración.

---

# Validación de Integridad

También deben comprobarse:

- campos obligatorios;
- valores fuera de rango;
- estructuras incompletas;
- configuraciones inconsistentes.

---

# Errores Críticos

Los siguientes errores deben impedir el inicio del Runtime:

- Resources corruptos;
- identificadores duplicados;
- dependencias irresolubles;
- tipos incompatibles.

---

# Advertencias

Configuraciones potencialmente problemáticas pueden registrarse como advertencias.

Ejemplos:

- Resources no utilizados;
- categorías vacías;
- referencias opcionales ausentes.

Las advertencias no deben impedir el Bootstrap.

---

# Hot Reload

## Objetivo

Facilitar el desarrollo permitiendo recargar Resources sin reiniciar completamente el proyecto.

Esta funcionalidad está destinada exclusivamente a herramientas de desarrollo.

---

# Filosofía

El Hot Reload nunca debe modificar directamente el estado del Runtime.

Su responsabilidad consiste únicamente en sustituir la información de configuración.

---

# Flujo Conceptual

```text
File Changed

↓

Reload Resource

↓

Validate

↓

Replace Reference

↓

Notify Debug Tools
```

La actualización debe realizarse de forma controlada.

---

# Alcance

El Hot Reload puede utilizarse para:

- Items;
- NPCs;
- Buildings;
- Craft Recipes;
- configuraciones del mundo;
- tablas Data Driven.

No debe utilizarse para modificar el estado dinámico de entidades.

---

# Seguridad

Antes de reemplazar un Resource:

- debe cargarse la nueva versión;
- debe validarse completamente;
- únicamente entonces puede sustituir a la anterior.

Si la validación falla, la versión previa permanece activa.

---

# Integridad del Runtime

El Hot Reload nunca debe dejar Resources parcialmente actualizados.

La transición debe ser atómica.

---

# Debug

## Objetivo

Permitir inspeccionar el estado interno del Resource Registry durante el desarrollo.

---

# Información Disponible

Las herramientas de Debug podrán consultar:

- Resources registrados;
- cantidad de Resources;
- tipos registrados;
- memoria utilizada;
- estado del Cache;
- dependencias;
- errores de validación.

Toda esta información será de solo lectura.

---

# Resource Browser

Una herramienta de Debug podrá representar conceptualmente:

```text
Resource Registry

↓

Categories

↓

Resources

↓

Definitions

↓

Metadata
```

Facilitando la inspección del contenido cargado.

---

# Dependency Viewer

Otra herramienta podrá mostrar:

```text
Resource

↓

Referenced Resources

↓

Dependency Graph
```

Permitiendo detectar dependencias incorrectas o circulares.

---

# Profiling

## Objetivo

Recopilar métricas relacionadas con la utilización del Resource Registry.

El Profiler nunca modifica el comportamiento del Runtime.

---

# Métricas de Bootstrap

Durante la carga pueden registrarse:

- tiempo total;
- tiempo por categoría;
- tiempo por archivo;
- cantidad de Resources cargados.

---

# Métricas de Runtime

Durante la ejecución pueden medirse:

- resoluciones realizadas;
- consultas por tipo;
- utilización del Cache;
- accesos por Frame.

---

# Consumo de Memoria

El Profiler también puede registrar:

- memoria ocupada por Resources;
- memoria del catálogo;
- memoria utilizada por el Cache;
- tamaño aproximado por categoría.

Estas métricas facilitan futuras optimizaciones.

---

# Logging

El Resource Registry únicamente debe registrar:

- errores;
- advertencias;
- resultados de validación;
- tiempos relevantes del Bootstrap.

Nunca debe registrar cada resolución realizada durante el Runtime.

---

# Escalabilidad

La arquitectura debe soportar:

- cientos de categorías;
- miles de Resources;
- múltiples módulos Data Driven;
- crecimiento continuo del proyecto.

Sin modificar la API pública del Registry.

---

# Restricciones

Las optimizaciones nunca deben comprometer:

- la consistencia;
- la inmutabilidad;
- el desacoplamiento;
- el determinismo.

El comportamiento funcional siempre tiene prioridad sobre el rendimiento.

---

# Garantías

El Resource Registry garantiza que:

- todos los Resources son validados antes de utilizarse;
- existe una única instancia por Resource;
- el Hot Reload mantiene la consistencia del Runtime;
- las herramientas de Debug disponen de información suficiente para diagnosticar problemas;
- el sistema de profiling permite medir objetivamente el rendimiento del Bootstrap y del Runtime.

---

# Resultado Esperado

Al finalizar esta sección quedan completamente especificadas las consideraciones de **Performance**, **Validación**, **Hot Reload**, **Debug** y **Profiling** del Resource Registry.

La infraestructura queda preparada para administrar un gran volumen de Resources Data Driven de forma eficiente, proporcionando mecanismos robustos de validación, optimización y diagnóstico que permiten mantener la consistencia del Runtime y facilitar el desarrollo y mantenimiento del Framework ECS.
# 10 - RESOURCE REGISTRY IMPLEMENTATION

# Parte 6 — Testing, Evolución Futura, Restricciones y Resumen Arquitectónico

---

# Objetivo

Esta sección define la estrategia oficial de testing del Resource Registry, las posibilidades de evolución futura de la arquitectura y el conjunto de restricciones permanentes que deberán respetarse durante toda la vida del Framework ECS.

El objetivo es asegurar que el Resource Registry pueda evolucionar sin romper la compatibilidad con los Systems existentes y sin comprometer la arquitectura Data Driven definida en las fases anteriores.

---

# Filosofía

El Resource Registry es uno de los pilares fundamentales del Framework.

Toda modificación sobre su implementación debe poder verificarse mediante pruebas automatizadas.

Las optimizaciones futuras nunca deberán alterar el comportamiento observable por los consumidores.

La API pública deberá permanecer estable.

---

# Compatibilidad con Testing

Toda la infraestructura del Resource Registry debe poder probarse de forma completamente aislada.

Las pruebas nunca deberán depender de:

- SceneTree
- Gameplay
- UI
- Multiplayer
- Save Files reales
- Escenas
- Prefabs

Las pruebas únicamente utilizarán las interfaces públicas del Runtime.

---

# Objetivos del Testing

El sistema de pruebas deberá validar:

- funcionamiento correcto
- consistencia
- determinismo
- integridad
- rendimiento
- escalabilidad

---

# Escenarios de Prueba

Como mínimo deberán existir pruebas para:

- Bootstrap
- Resource Loader
- Resource Catalog
- Resource Provider
- Resource Cache
- Resource Validator
- Resource Registry
- Hot Reload

---

# Bootstrap Tests

Las pruebas deberán verificar:

- creación correcta del Registry
- inicialización de módulos
- descubrimiento de Resources
- orden de carga
- estado Ready

---

# Loader Tests

El Resource Loader deberá comprobar:

- carga correcta
- rutas válidas
- rutas inexistentes
- formatos inválidos
- errores de lectura

---

# Validator Tests

El Validator deberá probar:

- identificadores duplicados
- tipos incorrectos
- referencias inválidas
- dependencias inexistentes
- datos incompletos
- configuración corrupta

---

# Catalog Tests

Las pruebas deberán verificar:

- registro correcto
- búsqueda por ID
- búsqueda por tipo
- eliminación controlada
- ausencia de duplicados

---

# Provider Tests

El Provider deberá probar:

- resolución correcta
- referencias compartidas
- Resources inexistentes
- múltiples solicitudes consecutivas

---

# Cache Tests

Si el Cache está habilitado deberán comprobarse:

- creación
- reutilización
- invalidación
- liberación
- estabilidad de referencias

---

# Runtime Tests

Durante el Runtime deberán ejecutarse pruebas como:

```text
Multiple Systems

↓

Resolve Resources

↓

Read Configuration

↓

Continue
```

Todos los consumidores deberán recibir exactamente la misma referencia.

---

# Integración con Systems

Las pruebas deberán verificar que:

- los Systems nunca cargan archivos
- los Systems nunca modifican Resources
- toda resolución pasa por el Registry

---

# Integración con Save

Las pruebas deberán comprobar:

```text
Save

↓

Resource IDs

↓

Load

↓

Resolve

↓

Same Resource
```

Los Resources nunca deberán serializarse dentro del Save.

---

# Integración con Multiplayer

Las pruebas deberán verificar:

Servidor:

```text
Weapon ID
```

Cliente:

```text
Weapon ID

↓

Resolve

↓

Same Definition
```

El Registry nunca deberá intervenir en la sincronización de red.

---

# Stress Tests

Deberán realizarse pruebas con:

- miles de Resources
- cientos de categorías
- miles de resoluciones por Frame
- múltiples consultas simultáneas

El objetivo es validar la estabilidad del Runtime.

---

# Memory Tests

Las pruebas deberán comprobar:

- ausencia de duplicados
- liberación correcta
- referencias compartidas
- consumo estable de memoria

---

# Evolución Futura

La arquitectura deberá permitir incorporar nuevas capacidades sin modificar la API pública.

Ejemplos:

- Asset Bundles
- DLC
- Mods
- Streaming
- Versionado
- Catálogos remotos

---

# Asset Bundles

En futuras versiones podrá incorporarse soporte para:

```text
Bundle

↓

Load

↓

Register

↓

Available
```

Sin alterar el funcionamiento interno de los Systems.

---

# DLC

El Registry podrá admitir:

```text
Base Game

+

Expansion

↓

Merged Catalog
```

Manteniendo una única interfaz de acceso.

---

# Sistema de Mods

Una futura implementación podrá permitir:

```text
Official Resources

↓

Override

↓

Mod Resources
```

Siempre respetando el proceso de validación.

---

# Streaming

En proyectos de gran tamaño podrá incorporarse:

```text
Load On Demand

↓

Cache

↓

Unload
```

Esta funcionalidad deberá implementarse sin modificar la API utilizada por los Systems.

---

# Versionado

El Registry podrá incorporar soporte para:

- versiones de Resources
- migraciones
- compatibilidad entre versiones
- actualización automática

---

# Herramientas de Desarrollo

Podrán desarrollarse herramientas como:

- Resource Explorer
- Dependency Graph
- Resource Usage Viewer
- Validation Report
- Memory Analyzer

Todas utilizando exclusivamente la API pública.

---

# Restricciones Permanentes

El Resource Registry nunca deberá:

- contener lógica de gameplay
- modificar Components
- modificar Entities
- modificar Resources durante Runtime
- emitir Events
- ejecutar Commands
- acceder directamente a Systems
- depender del SceneTree

Su responsabilidad permanecerá exclusivamente relacionada con la administración de Resources.

---

# Buenas Prácticas

Todo consumidor del Registry debería:

- reutilizar referencias
- consultar únicamente cuando sea necesario
- almacenar IDs en lugar de datos duplicados
- mantener los Resources completamente inmutables

---

# Antipatrones

Las siguientes prácticas deberán evitarse.

---

## Cargar Resources Manualmente

Incorrecto:

```text
System

↓

Load Resource
```

Siempre deberá utilizarse el Registry.

---

## Duplicar Configuración

Incorrecto:

```text
Resource

↓

Copy

↓

Component
```

Los Components nunca deberán duplicar configuración Data Driven.

---

## Modificar Resources

Incorrecto:

```text
Resource

↓

Modify Value
```

Toda modificación deberá realizarse sobre Components.

---

## Múltiples Instancias

Nunca deberán existir:

```text
Weapon Resource A

Weapon Resource B

Weapon Resource C
```

Siempre existirá una única instancia compartida.

---

# Resumen Arquitectónico

El Resource Registry queda compuesto por los siguientes módulos especializados:

- Resource Registry
- Resource Loader
- Resource Catalog
- Resource Provider
- Resource Cache
- Resource Validator
- Resource Profiler

Cada uno mantiene una única responsabilidad claramente definida.

---

# Flujo Completo

El comportamiento general puede resumirse como:

```text
Bootstrap

↓

Discover Resources

↓

Load

↓

Validate

↓

Register

↓

Cache

↓

Runtime Ready

↓

System Request

↓

Resolve Resource

↓

Read Configuration

↓

Continue Execution
```

Este flujo representa el comportamiento oficial del Resource Registry dentro del Framework ECS.

---

# Relación con el Siguiente Documento

El siguiente documento de esta fase será:

**11_SAVE_IMPLEMENTATION.md**

Mientras el Resource Registry define cómo administrar toda la configuración Data Driven del proyecto, el Save Implementation especificará la infraestructura responsable de serializar y restaurar el estado dinámico completo del Runtime, incluyendo entidades, Components, mundo persistente y progreso del jugador.

Ambos sistemas permanecen completamente desacoplados y se comunican exclusivamente mediante interfaces bien definidas.

---

# Resultado Esperado

Con este documento queda completamente especificada la implementación del **Resource Registry** del Framework ECS de Survivors Lords.

La arquitectura establece un sistema centralizado para descubrir, cargar, validar, registrar, resolver y administrar todos los Resources Data Driven del proyecto mediante módulos especializados e independientes, garantizando inmutabilidad, reutilización de referencias, acceso eficiente, escalabilidad y total desacoplamiento respecto del gameplay, constituyendo la única fuente oficial de configuración para todo el Runtime.

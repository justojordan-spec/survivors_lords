# RESOURCE LOADING

**Documento:** 07_RESOURCE_LOADING.md

**Fase:** ECS Framework

**Estado:** Draft

**Versión:** 1.0

---

# Objetivo

Este documento define la arquitectura del Resource Loading Pipeline del Framework ECS.

El objetivo es especificar cómo el Framework descubre, carga, valida, registra y distribuye todos los Resources Data Driven utilizados por Survivors Lords.

No define Resources específicos.

No define gameplay.

Únicamente especifica la infraestructura encargada de gestionar los datos del proyecto.

---

# Alcance

Este documento define:

- Resource Loader.
- Resource Registry.
- Descubrimiento de Resources.
- Registro.
- Validación.
- Dependencias.
- Pipeline de carga.
- Cachés.
- Integración con ECS.
- Integración con Save.
- Integración con Multiplayer.
- Hot Reload (editor).
- Debug.
- Profiling.

---

# Filosofía

Todo el contenido del juego es Data Driven.

Los Systems nunca crean datos manualmente.

Toda la información proviene de Resources registrados por el Framework.

Los Systems únicamente solicitan Resources al Resource Registry.

Nunca acceden directamente al sistema de archivos.

---

# Objetivos

El Resource Loading debe garantizar:

- Carga determinista.
- Registro único.
- Validación automática.
- Bajo acoplamiento.
- Alto rendimiento.
- Reutilización.
- Compatibilidad Multiplayer.
- Compatibilidad Save.
- Compatibilidad con herramientas de desarrollo.

---

# Arquitectura General

Conceptualmente.

```text
Filesystem

↓

Resource Loader

↓

Validation

↓

Resource Registry

↓

Systems
```

---

# Principios Fundamentales

Todo Resource debe cumplir las siguientes reglas:

- Posee un identificador único.
- Es inmutable durante la ejecución.
- No contiene lógica.
- No depende de Systems.
- Puede ser compartido por múltiples Entities.

---

# Resource Loader

El Resource Loader es responsable de localizar y cargar todos los Resources definidos por el proyecto.

Nunca interpreta gameplay.

Nunca ejecuta lógica.

Su única responsabilidad consiste en preparar los datos para el Framework.

---

# Responsabilidades

El Resource Loader debe:

- Descubrir archivos.
- Cargar Resources.
- Resolver dependencias.
- Validar estructura.
- Registrar Resources.
- Detectar errores.
- Generar estadísticas.

---

# Resource Registry

El Resource Registry representa el punto central de acceso a todos los Resources cargados.

Conceptualmente.

```text
Resource Registry

↓

Items

↓

Buildings

↓

Abilities

↓

NPCs

↓

Biomes

↓

Weather
```

Los Systems nunca conocen el origen físico de los datos.

---

# Identificador Único

Todo Resource debe poseer un ID único dentro de su categoría.

Ejemplo conceptual.

```text
weapon.iron_sword

building.small_house

creature.wolf
```

El Framework utiliza estos identificadores para resolver referencias entre Resources.

---

# Descubrimiento

Durante la inicialización, el Resource Loader recorre las carpetas configuradas.

Conceptualmente.

```text
Resources/

↓

Items

↓

Buildings

↓

Characters

↓

Creatures

↓

Weather
```

Cada archivo compatible es incorporado al pipeline de carga.

---

# Pipeline de Carga

Todo Resource sigue el mismo flujo.

```text
Discover

↓

Load

↓

Validate

↓

Resolve References

↓

Register

↓

Ready
```

---

# Carga

Durante esta etapa el Framework crea una instancia del Resource correspondiente.

Todavía no puede utilizarse.

Las referencias entre Resources aún no fueron resueltas.

---

# Validación

Cada Resource es validado automáticamente.

El Framework debe comprobar:

- Tipo correcto.
- Campos obligatorios.
- ID válido.
- Formato.
- Versionado.
- Dependencias declaradas.

Los Resources inválidos nunca se registran.

---

# Resolución de Referencias

Muchos Resources hacen referencia a otros.

Ejemplo.

```text
Recipe

↓

Item

↓

Tool

↓

Profession
```

El Loader resuelve todas estas referencias antes de finalizar el proceso de carga.

---

# Registro

Una vez validado, el Resource se incorpora al Resource Registry.

Solo a partir de este momento puede ser utilizado por los Systems.

---

# Estado Ready

Cuando un Resource alcanza el estado **Ready** se garantiza que:

- Es válido.
- Posee un ID único.
- Todas sus referencias fueron resueltas.
- Puede utilizarse con seguridad durante la ejecución.

---

# Continúa en la Parte 2

La siguiente parte desarrollará:

- Dependencias entre Resources.
- Orden de carga.
- Cachés.
- Gestión de memoria.
- Integración con ECS.
- Integración con Systems.
- Integración con Queries.
- Validaciones avanzadas.
---

# Dependencias entre Resources

Los Resources pueden depender de otros Resources para completar su configuración.

El Resource Loader es responsable de resolver todas estas dependencias antes de que un Resource pueda utilizarse.

Los Systems nunca resuelven referencias manualmente.

---

# Objetivos

El sistema de dependencias debe garantizar:

- Integridad de datos.
- Resolución determinista.
- Validación automática.
- Ausencia de referencias inválidas.
- Bajo acoplamiento.

---

# Ejemplo Conceptual

```text
Recipe

↓

Requires

↓

Iron Ore

↓

Coal

↓

Hammer
```

La Recipe únicamente podrá registrarse cuando todas las referencias existan.

---

# Dependencias Directas

Un Resource puede referenciar directamente a otro Resource.

Ejemplo.

```text
Weapon

↓

Projectile
```

La referencia debe resolverse durante el proceso de carga.

---

# Dependencias Transitivas

También pueden existir dependencias indirectas.

Ejemplo.

```text
Building

↓

Recipe

↓

Item

↓

Profession
```

El Framework debe garantizar que toda la cadena de referencias sea válida.

---

# Orden de Carga

El orden físico de los archivos nunca debe afectar el resultado.

El Resource Loader determina internamente el orden correcto de carga.

Conceptualmente.

```text
Discover

↓

Build Dependency Graph

↓

Resolve Order

↓

Load

↓

Register
```

---

# Grafo de Dependencias

Las relaciones entre Resources forman un grafo dirigido.

Ejemplo.

```text
Profession

↓

Tool

↓

Recipe

↓

Building
```

Este grafo se utiliza para calcular un orden de carga válido.

---

# Dependencias Circulares

Las dependencias circulares no están permitidas.

Ejemplo inválido.

```text
A

↓

B

↓

C

↓

A
```

El Loader debe detectar este caso durante la inicialización.

El proyecto no debe continuar hasta resolver el conflicto.

---

# Referencias Opcionales

Algunas referencias pueden declararse como opcionales.

Si el Resource referenciado no existe:

- No se genera error crítico.
- La referencia permanece nula.
- El comportamiento dependerá del System que utilice el Resource.

---

# Referencias Obligatorias

Las referencias obligatorias deben resolverse correctamente.

Si una referencia obligatoria no existe:

- El Resource se considera inválido.
- No se registra.
- Se informa el error durante la carga.

---

# Caché de Resources

Una vez registrados, los Resources permanecen almacenados en memoria.

Conceptualmente.

```text
Resource Registry

↓

Cache

↓

Lookup
```

El acceso posterior nunca vuelve a consultar el sistema de archivos.

---

# Objetivos del Caché

El caché permite:

- Acceso inmediato.
- Evitar cargas repetidas.
- Reducir I/O.
- Compartir instancias.
- Mejorar el rendimiento.

---

# Reutilización

Todos los Systems utilizan la misma instancia registrada de un Resource.

Ejemplo.

```text
Iron Sword

↓

Combat System

↓

Inventory System

↓

Loot System
```

No se crean copias adicionales.

---

# Inmutabilidad

Después de alcanzar el estado **Ready**, un Resource es completamente inmutable.

Ningún System puede modificar:

- Valores.
- Referencias.
- Configuración.

Si un System necesita información temporal deberá almacenarla en Components o Structures propias del Framework.

---

# Gestión de Memoria

El Resource Registry administra el ciclo de vida de todos los Resources.

Durante la partida:

- Los Resources permanecen cargados.
- No se destruyen individualmente.
- Son compartidos por todo el Framework.

La liberación ocurre únicamente durante el Shutdown.

---

# Integración con ECS

Las Entities nunca contienen copias de un Resource.

En su lugar, almacenan únicamente una referencia o identificador.

Conceptualmente.

```text
Entity

↓

Weapon Component

↓

weapon.iron_sword
```

Cuando un System necesita la configuración completa:

```text
Weapon Component

↓

Resource Registry

↓

Weapon Resource
```

---

# Integración con Systems

Los Systems nunca crean Resources.

Siempre solicitan el Resource correspondiente al Registry.

Conceptualmente.

```text
Combat System

↓

Request Resource

↓

Resource Registry

↓

Weapon Resource
```

---

# Integración con Queries

Las Queries nunca devuelven Resources.

Únicamente devuelven Components y Entities.

Si un Component contiene una referencia a un Resource, será responsabilidad del System resolver dicha referencia mediante el Resource Registry.

---

# Lookup

El acceso a un Resource debe realizarse mediante su identificador único.

Objetivo de rendimiento:

```text
O(1)
```

La implementación interna puede utilizar tablas hash u otras estructuras equivalentes.

---

# Validaciones Avanzadas

Además de la validación estructural, el Framework debe comprobar:

- IDs duplicados.
- Referencias rotas.
- Versiones incompatibles.
- Dependencias no resueltas.
- Tipos incorrectos.
- Recursos huérfanos (cuando corresponda).

---

# Consistencia

Al finalizar la carga se garantiza que:

- Todos los Resources registrados son válidos.
- Todas las referencias obligatorias fueron resueltas.
- No existen IDs duplicados.
- El Resource Registry está completamente sincronizado.

---

# Continúa en la Parte 3

La siguiente parte desarrollará:

- Integración con Save Pipeline.
- Integración con Multiplayer.
- Hot Reload.
- Versionado.
- Herramientas de Debug.
- Profiling.
- Métricas.
- Optimización de memoria.
- Buenas prácticas.
- Anti-patrones.
---

# Integración con Save Pipeline

El Save Pipeline nunca almacena Resources completos.

Los Resources representan datos estáticos del proyecto y pueden reconstruirse automáticamente durante la carga.

Únicamente se almacenan sus identificadores.

---

# Filosofía

El archivo de guardado contiene únicamente el estado dinámico del mundo.

Los datos estáticos permanecen en los Resources.

Ejemplo.

```text
Save File

↓

weapon.iron_sword

↓

Resource Registry

↓

Weapon Resource
```

---

# Restauración

Durante la carga de una partida el proceso sigue la siguiente secuencia.

```text
Load Resources

↓

Create Resource Registry

↓

Load Save

↓

Resolve Resource IDs

↓

Restore World
```

Los Resources siempre deben estar completamente cargados antes de comenzar la restauración del mundo.

---

# Referencias Persistentes

Los Components nunca almacenan referencias directas persistentes a un Resource.

Siempre almacenan:

- Resource ID.
- Registry Handle.
- Identificador equivalente definido por el Framework.

Esto evita referencias inválidas entre sesiones.

---

# Integración con Multiplayer

Todos los participantes deben utilizar exactamente el mismo conjunto de Resources.

Los Resources no se sincronizan durante la partida.

Cada cliente los carga localmente.

---

# Compatibilidad

Para garantizar una simulación consistente:

- IDs idénticos.
- Versiones idénticas.
- Configuración idéntica.
- Orden lógico equivalente.

Cualquier diferencia puede producir desincronización.

---

# Verificación de Versiones

Durante el establecimiento de una conexión multijugador el Framework debe validar:

- Versión del proyecto.
- Versión del paquete de datos.
- Hash de Resources (opcional).
- Compatibilidad de formatos.

Si las versiones no coinciden, la conexión debe rechazarse.

---

# Hot Reload

Durante el desarrollo el Framework puede permitir la recarga dinámica de Resources.

Este mecanismo solo está disponible en el Editor o en herramientas de desarrollo.

Nunca debe utilizarse en una sesión multijugador de producción.

---

# Flujo de Hot Reload

Conceptualmente.

```text
Modificar Archivo

↓

Detectar Cambio

↓

Recargar Resource

↓

Validar

↓

Actualizar Registry

↓

Notificar Systems
```

---

# Restricciones

El Hot Reload debe respetar las siguientes reglas:

- No modificar IDs.
- No invalidar referencias existentes.
- No alterar la estructura del Registry.
- Mantener la consistencia del Framework.

Si estas condiciones no pueden garantizarse, el Resource debe requerir una recarga completa del proyecto.

---

# Versionado

Cada Resource debe declarar una versión de formato.

Ejemplo conceptual.

```text
Version

1
```

El objetivo es facilitar futuras migraciones de datos sin romper la compatibilidad.

---

# Compatibilidad Hacia Atrás

Cuando sea posible, el Loader puede aplicar procesos de migración para Resources de versiones anteriores.

Ejemplo conceptual.

```text
Version 1

↓

Migration

↓

Version 2
```

Las migraciones deben ser explícitas y estar documentadas.

---

# Debug Tools

El Framework debe proporcionar herramientas para inspeccionar el estado del Resource Registry.

Estas herramientas son exclusivas del entorno de desarrollo.

---

# Registry Inspector

El Registry Inspector permite visualizar:

- Todos los Resources registrados.
- Tipo.
- ID.
- Estado.
- Dependencias.
- Referencias.

Ejemplo.

```text
Items

↓

iron_sword

health_potion

wood_log
```

---

# Dependency Inspector

Debe ser posible visualizar el grafo de dependencias entre Resources.

Conceptualmente.

```text
Building

↓

Recipe

↓

Item

↓

Profession
```

Esto facilita detectar referencias rotas o ciclos inesperados.

---

# Validation Report

Al finalizar la carga el Framework puede generar un informe con:

- Resources cargados.
- Resources inválidos.
- IDs duplicados.
- Referencias no resueltas.
- Advertencias.
- Tiempo total de carga.

---

# Profiling

El Resource Loader debe recopilar métricas como:

- Tiempo de descubrimiento.
- Tiempo de carga.
- Tiempo de validación.
- Tiempo de resolución de referencias.
- Tiempo de registro.
- Tiempo total del pipeline.

Estas métricas permiten optimizar el proceso de inicialización.

---

# Optimización

El Resource Loading Pipeline debe minimizar:

- Accesos al disco.
- Cargas repetidas.
- Asignaciones dinámicas.
- Conversión innecesaria de datos.

Siempre que sea posible debe reutilizar estructuras internas.

---

# Buenas Prácticas

Se recomienda:

- Mantener IDs estables.
- Utilizar nombres descriptivos.
- Declarar explícitamente todas las dependencias.
- Evitar referencias innecesarias.
- Mantener Resources pequeños y especializados.
- Validar automáticamente durante el Startup.

---

# Anti-Patrones

El Framework prohíbe expresamente:

- Cargar Resources directamente desde un System.
- Modificar un Resource en tiempo de ejecución.
- Acceder al sistema de archivos desde gameplay.
- Duplicar Resources en memoria.
- Almacenar estado dinámico dentro de un Resource.
- Crear referencias circulares entre Resources.

---

# Convenciones

Todos los Resources deberán cumplir las siguientes reglas:

- Son inmutables.
- Poseen un ID único.
- No contienen lógica.
- Son compartidos.
- Son registrados exclusivamente por el Resource Loader.
- Se obtienen únicamente a través del Resource Registry.

---

# Resumen del Pipeline

```text
Discover Files
        │
        ▼
Load Resources
        │
        ▼
Validate
        │
        ▼
Resolve Dependencies
        │
        ▼
Register
        │
        ▼
Populate Cache
        │
        ▼
Ready
        │
        ▼
Systems Request Resources
```

---

# Garantías del Resource Loading

Al finalizar la inicialización el Framework garantiza que:

- Todos los Resources registrados son válidos.
- Todas las referencias obligatorias fueron resueltas.
- El Resource Registry está completamente inicializado.
- Los Systems pueden solicitar cualquier Resource registrado de forma segura.
- El estado de los datos es consistente en toda la aplicación.

---

# Estado

**Estado actual:** Especificación del Resource Loading Pipeline.

Este documento define el contrato técnico para la implementación del sistema de carga y registro de Resources del Framework ECS de Survivors Lords.

Toda gestión de datos estáticos deberá realizarse exclusivamente mediante el Resource Loader y el Resource Registry. Cualquier modificación al pipeline de carga, resolución de dependencias, validación o acceso a Resources deberá documentarse mediante una DEC (Design Engineering Change) antes de su implementación.
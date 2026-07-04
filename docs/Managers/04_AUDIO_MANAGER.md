# Resource Manager

**Estado:** Draft

---

# Objetivo

El Resource Manager es responsable de administrar el acceso a todos los Resources utilizados por el proyecto.

Su función es proporcionar una interfaz centralizada para localizar, cargar, almacenar y compartir datos definidos mediante Resources (.tres), garantizando un acceso uniforme y desacoplado para todos los sistemas.

No administra lógica de gameplay ni modifica el contenido de los Resources.

---

# Filosofía

Los Resources constituyen la base de la arquitectura Data Driven del proyecto.

El Resource Manager desacopla a los sistemas consumidores de la organización física de los archivos y de los mecanismos de carga utilizados por Godot.

Todo acceso a datos persistentes deberá realizarse a través de este Manager o de servicios especializados construidos sobre él.

---

# Arquitectura

El Resource Manager es un AutoLoad disponible durante toda la ejecución de la aplicación.

Su responsabilidad consiste en localizar y proporcionar Resources a los distintos sistemas del proyecto, ocultando la estructura interna del almacenamiento.

El Manager podrá implementar mecanismos de caché y reutilización de Resources cuando sea conveniente para el rendimiento.

---

# Responsabilidades

El Resource Manager es responsable de:

- Localizar Resources.
- Cargar Resources.
- Compartir instancias reutilizables.
- Gestionar caché cuando corresponda.
- Centralizar el acceso a la información Data Driven.
- Validar la existencia de Resources solicitados.

No es responsable de:

- Interpretar la lógica contenida en los datos.
- Administrar gameplay.
- Modificar Resources durante la ejecución.
- Gestionar la persistencia del juego.

---

# API Pública

La API pública deberá permitir operaciones como:

- Obtener un Resource.
- Consultar la existencia de un Resource.
- Precargar Resources.
- Liberar recursos en caché cuando corresponda.
- Obtener catálogos de datos.

La implementación concreta será documentada durante el desarrollo.

---

# Flujo de funcionamiento

El flujo general será:

1. Un sistema solicita un Resource.
2. El Resource Manager verifica su disponibilidad.
3. Si el Resource ya está disponible, reutiliza la instancia correspondiente.
4. Si es necesario, realiza la carga del Resource.
5. Devuelve la referencia al sistema solicitante.

Todo el proceso permanece transparente para el consumidor.

---

# Dependencias

El Resource Manager podrá interactuar con:

- Save Manager.
- Scene Manager.
- Network Manager.
- EventBus.

Los demás sistemas accederán a los datos únicamente mediante su API pública.

---

# Integración con el resto del proyecto

Todos los Managers, Components y Systems que necesiten datos definidos mediante Resources deberán utilizar el Resource Manager.

Ningún sistema deberá acceder directamente a rutas físicas de archivos `.tres`.

Esto garantiza independencia respecto a la organización del proyecto y facilita futuras reorganizaciones.

---

# Consideraciones para Claude

Al generar código:

- Obtener Resources exclusivamente mediante el Resource Manager.
- Evitar rutas hardcodeadas.
- Diseñar Resources reutilizables.
- Mantener separados los datos de la lógica de gameplay.
- Aprovechar mecanismos de caché cuando sea apropiado.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar cargas directas de Resources.
- Verificar la correcta aplicación de la arquitectura Data Driven.
- Validar que el acceso a los datos permanezca centralizado.
- Identificar posibles duplicaciones de carga o referencias innecesarias.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Proporcionar un punto único de acceso a todos los Resources del proyecto, garantizando una arquitectura Data Driven consistente, desacoplada, reutilizable y preparada para crecer sin depender de la estructura física de los archivos.
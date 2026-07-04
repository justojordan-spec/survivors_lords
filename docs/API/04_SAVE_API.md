# Save API

**Estado:** Draft

---

# Objetivo

Este documento define el contrato de comunicación entre los distintos sistemas del proyecto y la arquitectura de guardado.

La Save API establece las reglas que deberán seguir Managers, Components, Resources y demás sistemas para almacenar y recuperar información persistente, independientemente de la implementación interna del sistema de guardado.

Su propósito es garantizar una persistencia consistente, extensible y desacoplada.

---

# Filosofía

El sistema de guardado debe funcionar como un servicio centralizado.

Los distintos sistemas no deben conocer cómo ni dónde se almacenan los datos.

Cada sistema es responsable únicamente de proporcionar la información necesaria para ser persistida y de restaurar su propio estado cuando corresponda.

La serialización y el almacenamiento son responsabilidad exclusiva del Save System.

---

# Arquitectura

La comunicación con el sistema de guardado deberá realizarse únicamente mediante su API pública.

Los sistemas podrán:

- Proporcionar datos para guardar.
- Solicitar la restauración de datos.
- Consultar el estado de una operación de guardado o carga.

Ningún sistema deberá acceder directamente a archivos, directorios o formatos de almacenamiento.

---

# Responsabilidades

La Save API debe permitir:

- Iniciar operaciones de guardado.
- Iniciar operaciones de carga.
- Solicitar datos persistentes.
- Restaurar información previamente almacenada.
- Informar el resultado de cada operación.

La API no debe encargarse de definir el formato interno de los archivos ni la estrategia de serialización.

---

# Convenciones

Toda información persistente deberá cumplir las siguientes reglas:

- Ser serializable.
- Mantener una estructura consistente.
- Evitar referencias directas a nodos en memoria.
- Utilizar identificadores estables cuando sea necesario.

Los datos persistentes deberán representar el estado del juego y no objetos de ejecución.

---

# Integración con el resto del proyecto

La Save API podrá ser utilizada por:

- Managers
- Components
- Systems
- Player Data
- World Data
- Inventory
- Progression
- Multiplayer (cuando corresponda)

Cada sistema será responsable de preparar y restaurar exclusivamente la información bajo su responsabilidad.

---

# Consideraciones para Claude

Al generar código:

- Utilizar únicamente la API pública del sistema de guardado.
- No acceder directamente al sistema de archivos desde Components o Managers.
- Mantener separada la lógica de negocio de la lógica de persistencia.
- Diseñar datos fácilmente serializables.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Verificar que ningún sistema dependa del formato interno de los archivos.
- Detectar accesos directos al sistema de archivos fuera del Save System.
- Comprobar que cada sistema gestione únicamente sus propios datos.
- Validar una correcta separación entre estado en memoria y estado persistente.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una interfaz uniforme para todas las operaciones de persistencia del proyecto, permitiendo que cualquier sistema pueda guardar y restaurar su estado de forma consistente, desacoplada y transparente, sin depender de la implementación interna del sistema de guardado.
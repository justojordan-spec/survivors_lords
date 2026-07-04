# Component Registry

**Estado:** Draft

---

# Objetivo

Definir el mecanismo oficial mediante el cual las Entities registran, organizan y proporcionan acceso a sus Components.

El Component Registry garantiza que todos los Components de una Entity puedan localizarse de forma consistente, eficiente y desacoplada, sin depender de la estructura del árbol de nodos.

---

# Filosofía

Una Entity es un contenedor de Components.

Para que los Components puedan colaborar entre sí, debe existir un mecanismo uniforme de registro y consulta.

El Registry elimina la necesidad de búsquedas repetidas en el árbol de escenas y desacopla el gameplay de la organización física de los nodos.

---

# Arquitectura

Cada Entity posee un único Component Registry.

El Registry mantiene referencias a todos los Components registrados en esa Entity y proporciona acceso mediante una interfaz pública.

Los Components no deberán buscar otros Components recorriendo el árbol de nodos.

---

# Responsabilidades

El Component Registry es responsable de:

- Registrar Components durante la inicialización.
- Mantener un índice de los Components disponibles.
- Permitir consultas eficientes.
- Eliminar referencias cuando un Component deja de existir.
- Garantizar la unicidad de cada Component dentro de la Entity cuando corresponda.

No es responsable de:

- Ejecutar lógica de gameplay.
- Coordinar la comunicación entre Components.
- Gestionar el ciclo de vida de los Components.
- Resolver dependencias automáticamente.

---

# Registro

Durante la creación de una Entity:

1. Se instancian los Components.
2. Cada Component se registra en el Registry.
3. El Registry actualiza sus índices internos.
4. Los Components pueden consultar el Registry una vez finalizada la fase de configuración.

El proceso de registro deberá ser transparente para los sistemas consumidores.

---

# Consultas

Los Components podrán solicitar referencias a otros Components mediante el Registry.

Las consultas deberán realizarse utilizando la API pública del Registry y nunca mediante búsquedas en el árbol de nodos.

Si un Component requerido no existe, el comportamiento deberá estar claramente definido por la implementación.

---

# Integración con Entities

Cada Entity será propietaria de un único Component Registry.

La Entity será responsable de crear, mantener y destruir dicho Registry junto con el resto de sus Components.

---

# Integración con Managers

Los Managers no accederán al Component Registry de forma directa.

Su interacción con los Components deberá realizarse mediante APIs públicas, Systems o mecanismos de comunicación definidos por la arquitectura.

---

# Rendimiento

El Registry deberá optimizar:

- Consultas frecuentes.
- Acceso por tipo de Component.
- Bajo consumo de memoria.
- Baja complejidad de búsqueda.

No deberán realizarse búsquedas repetidas por el árbol de escenas durante el gameplay.

---

# Multiplayer

El Component Registry es una estructura local de cada Entity.

No forma parte del estado sincronizado por la red y no deberá contener información específica del networking.

---

# Consideraciones para Claude

Al generar código:

- Utilizar siempre el Component Registry para localizar Components de una Entity.
- Evitar `get_node()`, `find_child()` y búsquedas similares para obtener Components.
- Mantener el Registry como una estructura ligera y eficiente.
- No introducir lógica de gameplay dentro del Registry.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar búsquedas de Components mediante el árbol de nodos.
- Verificar que todas las consultas pasen por el Registry.
- Identificar referencias innecesarias o duplicadas.
- Validar que el Registry actúe únicamente como mecanismo de acceso.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un mecanismo uniforme, eficiente y desacoplado para registrar y localizar Components dentro de una Entity, eliminando la dependencia del árbol de nodos y garantizando una arquitectura consistente y escalable.
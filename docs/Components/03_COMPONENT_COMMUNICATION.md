# Component Communication

**Estado:** Draft

---

# Objetivo

Definir las reglas oficiales para la comunicación entre Components, Managers, Systems y Entities dentro de Survivors Lords.

El objetivo es garantizar una arquitectura desacoplada, mantenible y fácilmente extensible, evitando dependencias innecesarias entre módulos.

---

# Filosofía

La comunicación entre sistemas debe ser explícita, predecible y con el menor acoplamiento posible.

Cada mecanismo de comunicación existe para resolver un problema diferente.

No existe una única forma correcta de comunicar dos sistemas; la elección dependerá de la relación entre ellos.

---

# Principios

Toda comunicación deberá respetar los siguientes principios:

- Bajo acoplamiento.
- Alta cohesión.
- Responsabilidad única.
- APIs públicas bien definidas.
- Comunicación explícita.
- Evitar dependencias circulares.

---

# Métodos de comunicación

El proyecto define cuatro mecanismos oficiales de comunicación.

## 1. API Pública

Se utilizará cuando un sistema necesite solicitar una acción específica a otro sistema conocido.

Ejemplos:

- Consultar la vida actual.
- Agregar un objeto al inventario.
- Obtener una estadística.

Es el mecanismo preferido cuando existe una relación directa entre ambos módulos.

---

## 2. Signals

Se utilizarán para comunicar eventos locales.

Las Signals deberán emplearse cuando exista una relación natural entre objetos cercanos o pertenecientes a una misma Entity o Scene.

Ejemplos:

- La vida cambió.
- El arma terminó de recargar.
- Finalizó una animación.

---

## 3. EventBus

Se utilizará exclusivamente para eventos globales.

El emisor no conocerá quién recibe el evento.

Ejemplos:

- Comenzó una partida.
- Finalizó una partida.
- Un jugador se conectó.
- Se desbloqueó un logro.

El EventBus nunca deberá utilizarse para enviar comandos.

---

## 4. Recursos compartidos

Los Resources permiten compartir datos entre múltiples sistemas.

Los Components podrán consultar información definida en Resources, pero no deberán utilizarlos como mecanismo de comunicación dinámica.

---

# Comunicación entre Components

Dos Components pertenecientes a una misma Entity podrán comunicarse mediante:

- APIs públicas.
- Signals.

Siempre deberán evitar acceder directamente al estado interno del otro Component.

---

# Comunicación con Managers

Los Components podrán utilizar Managers únicamente mediante sus APIs públicas.

Nunca deberán modificar directamente el estado interno de un Manager.

---

# Comunicación con Systems

Los Systems podrán coordinar múltiples Components.

La comunicación deberá mantenerse desacoplada y basada en interfaces públicas.

---

# Comunicación entre Entities

Las Entities no deberán comunicarse directamente entre sí.

La interacción deberá realizarse mediante:

- Components.
- Systems.
- EventBus.
- Managers.

---

# Dependencias

Las dependencias deberán ser:

- Claras.
- Explícitas.
- Mínimas.
- Unidireccionales.

Las dependencias circulares están prohibidas.

---

# Buenas prácticas

Se recomienda:

- Preferir APIs públicas antes que eventos.
- Utilizar Signals únicamente para eventos locales.
- Reservar EventBus para eventos globales.
- Evitar referencias permanentes innecesarias.
- Mantener los eventos pequeños y específicos.

---

# Antipatrones

No se permite:

- Acceder al estado interno de otro Component.
- Utilizar EventBus para ejecutar acciones.
- Crear cadenas largas de Signals.
- Generar dependencias circulares.
- Utilizar Managers como intermediarios para todo.

---

# Consideraciones para Claude

Al generar código:

- Elegir el mecanismo de comunicación adecuado según el contexto.
- Mantener el desacoplamiento.
- Evitar dependencias innecesarias.
- Favorecer APIs públicas claras y pequeñas.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar dependencias circulares.
- Identificar uso incorrecto del EventBus.
- Verificar el uso adecuado de Signals.
- Validar que la comunicación respete la arquitectura definida.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Definir un modelo uniforme de comunicación que permita a todos los módulos del proyecto interactuar de forma consistente, desacoplada y escalable, preservando la mantenibilidad de la arquitectura a largo plazo.
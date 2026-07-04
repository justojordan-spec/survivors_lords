# Movement Component

**Estado:** Draft

---

# Objetivo

El Movement Component es responsable de administrar el desplazamiento de una Entity dentro del mundo del juego.

Su función es procesar las solicitudes de movimiento, calcular el desplazamiento correspondiente y actualizar la posición de la Entity de acuerdo con las reglas definidas por el proyecto.

No implementa lógica de entrada del jugador, IA ni navegación.

---

# Filosofía

El movimiento es una capacidad propia de una Entity.

El Movement Component únicamente ejecuta el desplazamiento.

La decisión de moverse pertenece a otros sistemas, como el Input Component, la IA o el sistema de navegación.

---

# Arquitectura

El Movement Component encapsula toda la lógica relacionada con el desplazamiento físico de una Entity.

La velocidad, aceleración y demás parámetros deberán obtenerse mediante el Stats Component o Resources cuando corresponda.

El Component deberá ser reutilizable por cualquier tipo de Entity que pueda desplazarse.

---

# Responsabilidades

El Movement Component es responsable de:

- Procesar solicitudes de movimiento.
- Calcular desplazamientos.
- Aplicar velocidad.
- Gestionar dirección de movimiento.
- Actualizar la posición de la Entity.
- Informar cambios relevantes del movimiento.

No es responsable de:

- Leer entradas del jugador.
- Tomar decisiones de IA.
- Calcular rutas.
- Gestionar animaciones.
- Resolver colisiones complejas de gameplay.

---

# API Pública

La API pública deberá permitir operaciones como:

- Iniciar movimiento.
- Detener movimiento.
- Establecer dirección.
- Obtener velocidad actual.
- Consultar si la Entity está en movimiento.
- Obtener el vector de movimiento.

La implementación concreta será documentada durante el desarrollo.

---

# Estado Interno

El Component administrará, entre otros:

- Dirección actual.
- Velocidad actual.
- Estado de movimiento.
- Vector de desplazamiento.

Estos datos permanecerán encapsulados.

---

# Signals

El Component podrá emitir eventos como:

- Movimiento iniciado.
- Movimiento detenido.
- Dirección modificada.
- Velocidad modificada.

Los nombres concretos de las Signals se definirán durante la implementación.

---

# Dependencias

El Movement Component podrá interactuar con:

- Stats Component.
- EventBus.
- Resource Manager.

No deberá depender del Input Manager, de la IA ni del Combat Component.

---

# Integración con el resto del proyecto

El Movement Component será utilizado por cualquier Entity capaz de desplazarse.

Las solicitudes de movimiento podrán originarse desde distintos sistemas (jugador, IA, habilidades o scripts), pero todas deberán canalizarse a través de la API pública del Component.

---

# Rendimiento

El Component deberá:

- Minimizar cálculos por frame.
- Evitar asignaciones innecesarias.
- Reutilizar estructuras de datos cuando sea posible.
- Escalar correctamente para cientos de Entities simultáneas.

---

# Multiplayer

El estado de movimiento deberá poder sincronizarse correctamente dentro de la arquitectura Host-Client.

El Component no contendrá lógica específica de replicación; la sincronización será responsabilidad del sistema de red correspondiente.

---

# Consideraciones para Claude

Al generar código:

- Mantener separado el movimiento de la toma de decisiones.
- Obtener velocidad y otros atributos mediante el Stats Component.
- No acceder directamente al Input Manager.
- Diseñar un Component reutilizable para jugadores, enemigos y NPCs.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica de IA o Input dentro del Movement Component.
- Verificar que las estadísticas provengan del Stats Component.
- Validar la separación entre desplazamiento y navegación.
- Identificar responsabilidades que pertenezcan a otros Components.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un Component reutilizable y desacoplado para gestionar el movimiento de cualquier Entity del proyecto, permitiendo que distintos sistemas soliciten desplazamientos mediante una API uniforme, manteniendo separadas las decisiones de movimiento de su ejecución física.
# Health Component

**Estado:** Draft

---

# Objetivo

El Health Component es responsable de administrar la vida de una Entity.

Su función es almacenar, modificar y consultar el estado de salud de la Entity, proporcionando una interfaz uniforme para recibir daño, aplicar curación y determinar si la Entity continúa con vida.

No implementa lógica de combate ni decide cuándo debe producirse el daño.

---

# Filosofía

La vida es un atributo propio de la Entity.

El Health Component únicamente administra dicho atributo.

Las reglas que producen daño o curación pertenecen a otros Components o Systems.

---

# Arquitectura

El Health Component encapsula todo el estado relacionado con la salud.

Su estado deberá mantenerse completamente privado y sólo podrá modificarse mediante su API pública.

El Component deberá ser completamente reutilizable por cualquier tipo de Entity.

---

# Responsabilidades

El Health Component es responsable de:

- Mantener la vida actual.
- Mantener la vida máxima.
- Aplicar daño.
- Aplicar curación.
- Limitar los valores permitidos.
- Determinar si la Entity está viva.
- Determinar si la Entity ha muerto.
- Emitir eventos relacionados con cambios de salud.

No es responsable de:

- Calcular el daño.
- Aplicar resistencias.
- Gestionar armaduras.
- Ejecutar animaciones.
- Eliminar la Entity.
- Otorgar experiencia.

---

# API Pública

La API pública deberá permitir operaciones como:

- Obtener la vida actual.
- Obtener la vida máxima.
- Establecer la vida.
- Aplicar daño.
- Aplicar curación.
- Restaurar completamente la salud.
- Consultar si la Entity está viva.
- Consultar el porcentaje de vida.

La implementación concreta será documentada durante el desarrollo.

---

# Estado Interno

El Component administrará, entre otros, los siguientes conceptos:

- Vida actual.
- Vida máxima.
- Estado de vida.
- Estado de muerte.

Estos datos permanecerán encapsulados.

---

# Signals

El Component podrá emitir eventos como:

- Vida modificada.
- Daño recibido.
- Curación aplicada.
- Vida restaurada.
- Entity muerta.

Los nombres concretos de las Signals se definirán durante la implementación.

---

# Dependencias

El Health Component podrá interactuar con:

- Stats Component.
- Damage Component.
- Combat Component.
- EventBus.
- Managers cuando sea necesario.

No deberá depender directamente de otros Components específicos.

---

# Integración con el resto del proyecto

El Health Component será utilizado por cualquier Entity que pueda recibir daño o curación.

La lógica que origine el daño deberá permanecer completamente separada de este Component.

---

# Rendimiento

El Component deberá:

- Evitar cálculos innecesarios.
- Emitir únicamente los eventos indispensables.
- Mantener un estado interno pequeño.
- Ser eficiente para soportar cientos de Entities simultáneamente.

---

# Multiplayer

El estado de salud deberá poder sincronizarse correctamente dentro de la arquitectura Host-Client.

El Health Component no deberá contener lógica específica de sincronización; dicha responsabilidad pertenecerá al sistema de red correspondiente.

---

# Consideraciones para Claude

Al generar código:

- Mantener encapsulado el estado de salud.
- No permitir modificaciones directas de la vida.
- Utilizar la API pública para todas las operaciones.
- Mantener el Component independiente del sistema de combate.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar accesos directos a la vida.
- Verificar que el Component no implemente lógica de combate.
- Validar el correcto encapsulamiento del estado.
- Identificar responsabilidades que pertenezcan a otros Components.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un Component reutilizable y desacoplado para la gestión de la salud de cualquier Entity del proyecto, garantizando una administración consistente de la vida y una clara separación entre el estado de salud y las mecánicas que lo modifican.
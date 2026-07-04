# Damage Component

**Estado:** Draft

---

# Objetivo

El Damage Component es responsable de procesar la aplicación de daño sobre otras Entities.

Su función es construir, modificar y enviar eventos de daño al sistema correspondiente, sin administrar la vida de la Entity objetivo ni decidir cuándo debe producirse un ataque.

No implementa lógica de combate completa.

---

# Filosofía

El daño representa una transferencia de información entre una Entity atacante y una Entity objetivo.

El Damage Component define **cómo** se aplica el daño.

Las decisiones de **cuándo atacar** pertenecen al Combat Component.

La administración de la vida pertenece al Health Component.

---

# Arquitectura

El Damage Component encapsula toda la lógica relacionada con la generación y aplicación de daño.

El Component podrá construir una instancia de daño utilizando:

- Valor base.
- Tipo de daño.
- Modificadores.
- Multiplicadores.
- Información del atacante.

El objetivo únicamente recibirá el resultado mediante la API correspondiente.

---

# Responsabilidades

El Damage Component es responsable de:

- Construir eventos de daño.
- Aplicar modificadores.
- Calcular el daño final.
- Identificar el origen del daño.
- Enviar el daño al objetivo.
- Emitir eventos relacionados con el daño.

No es responsable de:

- Reducir la vida.
- Administrar estadísticas.
- Decidir cuándo atacar.
- Gestionar animaciones.
- Aplicar efectos visuales.

---

# API Pública

La API pública deberá permitir operaciones como:

- Crear un evento de daño.
- Aplicar daño a una Entity.
- Consultar el tipo de daño.
- Obtener el valor final del daño.
- Configurar modificadores.

La implementación concreta será documentada durante el desarrollo.

---

# Estado Interno

El Component administrará, entre otros:

- Daño base.
- Daño final.
- Tipo de daño.
- Multiplicadores.
- Fuente del daño.

Toda esta información permanecerá encapsulada.

---

# Signals

El Component podrá emitir eventos como:

- Daño generado.
- Daño aplicado.
- Daño cancelado.
- Daño modificado.

Los nombres concretos de las Signals se definirán durante la implementación.

---

# Dependencias

El Damage Component podrá interactuar con:

- Stats Component.
- Health Component (mediante su API pública).
- EventBus.
- Resource Manager.

No deberá depender del Combat Component.

---

# Integración con el resto del proyecto

El Damage Component será utilizado por cualquier Entity capaz de infligir daño.

El destino del daño podrá ser cualquier Entity que disponga de un Health Component compatible.

---

# Rendimiento

El Component deberá:

- Minimizar cálculos repetitivos.
- Reutilizar estructuras de datos cuando sea posible.
- Evitar asignaciones innecesarias durante el combate.
- Ser eficiente para soportar un gran número de impactos simultáneos.

---

# Multiplayer

La aplicación de daño deberá respetar el modelo de autoridad definido por la arquitectura de red.

El Component no implementará lógica de sincronización; dicha responsabilidad corresponderá al sistema de networking.

---

# Consideraciones para Claude

Al generar código:

- Mantener separado el cálculo del daño de la gestión de la vida.
- Utilizar la API pública del Health Component para aplicar el resultado.
- Evitar mezclar lógica de combate con la aplicación del daño.
- Diseñar el sistema para soportar múltiples tipos de daño.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar modificaciones directas de la vida.
- Verificar que el daño pase por el Damage Component.
- Validar la separación entre combate, daño y salud.
- Identificar responsabilidades que pertenezcan a otros Components.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Proporcionar un Component reutilizable para la generación y aplicación de daño entre Entities, manteniendo completamente desacopladas las responsabilidades de combate, daño y salud, y permitiendo extender fácilmente el sistema con nuevos tipos de daño y modificadores.
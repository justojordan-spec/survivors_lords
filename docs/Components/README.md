# Components

**Estado:** Draft

---

# Objetivo

Esta carpeta contiene la documentación técnica de todos los Components utilizados por el proyecto.

Los Components constituyen la unidad fundamental de comportamiento dentro de la arquitectura basada en composición de **Survivors Lords**.

Su propósito es encapsular funcionalidades específicas, reutilizables e independientes que puedan combinarse para construir cualquier tipo de Entity del juego.

---

# Filosofía

El proyecto adopta el principio de **Composición sobre Herencia**.

Las Entities no implementan comportamiento propio; su funcionalidad surge de la combinación de Components especializados.

Cada Component debe resolver un único problema, ser fácilmente reutilizable y mantener el menor acoplamiento posible con el resto del sistema.

La reutilización y la modularidad tienen prioridad sobre la creación de jerarquías complejas.

---

# Arquitectura

Todos los Components deberán cumplir las siguientes características:

- Representar una única responsabilidad.
- Ser reutilizables entre distintas Entities.
- Mantener encapsulado su estado interno.
- Exponer únicamente una API pública clara.
- Comunicarse mediante APIs públicas, Signals o EventBus según corresponda.
- Ser independientes del tipo específico de Entity donde se utilicen.

Los Components forman el núcleo del gameplay del proyecto.

---

# Responsabilidades

Cada documento de esta carpeta deberá definir:

- Objetivo del Component.
- Responsabilidades.
- Arquitectura interna.
- API pública.
- Signals emitidas.
- Dependencias.
- Integración con otros Components.
- Integración con Managers.
- Consideraciones de rendimiento.
- Consideraciones de red.
- Casos de uso.

Cada Component deberá tener una única responsabilidad claramente identificable.

---

# Integración con el resto del proyecto

Los Components interactúan con:

- Entities.
- Otros Components.
- Managers.
- Resources.
- Systems.
- EventBus.
- Signals.

Los Components nunca deberán asumir responsabilidades que pertenezcan a Managers o a otros Components especializados.

---

# Organización

La documentación de esta carpeta se divide en dos grupos:

## Componentes Base

Definen las reglas comunes para todos los Components del proyecto.

Incluyen aspectos como:

- Ciclo de vida.
- Comunicación.
- Registro.
- Integración con Entities.
- Convenciones de implementación.

## Components de Gameplay

Documentan cada Component concreto utilizado por el proyecto.

Por ejemplo:

- Health Component.
- Movement Component.
- Combat Component.
- Stats Component.
- Inventory Component.
- Ability Component.

Cada uno tendrá su propia documentación independiente.

---

# Consideraciones para Claude

Al generar código:

- Mantener una única responsabilidad por Component.
- Evitar dependencias rígidas entre Components.
- Utilizar composición antes que herencia.
- Mantener APIs pequeñas y bien definidas.
- Priorizar la reutilización.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar Components con múltiples responsabilidades.
- Verificar el cumplimiento del principio de composición.
- Identificar acoplamientos innecesarios.
- Validar la reutilización y modularidad de los Components.
- Comprobar que las responsabilidades estén correctamente distribuidas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un conjunto de Components modulares, reutilizables y desacoplados que constituyan la base del gameplay de Survivors Lords, permitiendo construir cualquier Entity mediante composición y garantizando una arquitectura escalable, mantenible y preparada para la evolución futura del proyecto.
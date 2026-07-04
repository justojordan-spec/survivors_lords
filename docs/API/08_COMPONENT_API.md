# Component API

**Estado:** Draft

---

# Objetivo

Este documento define el contrato público que deben respetar todos los Components del proyecto.

La Component API proporciona una interfaz uniforme para la creación, integración y comunicación de Components dentro de la arquitectura ECS-like basada en composición.

Su propósito es garantizar que todos los Components sean reutilizables, desacoplados y consistentes, independientemente de su función específica.

---

# Filosofía

Los Components representan unidades independientes de comportamiento.

Cada Component debe encapsular una única responsabilidad y poder reutilizarse en distintas Entities sin modificaciones.

Los Components no deben asumir el tipo de Entity a la que pertenecen ni depender de otros Components específicos, salvo que dicha dependencia esté documentada explícitamente.

La comunicación entre Components deberá realizarse mediante APIs públicas, Signals o EventBus, según corresponda.

---

# Arquitectura

Todos los Components deberán compartir una interfaz pública coherente.

Cada Component deberá:

- Tener una única responsabilidad.
- Ser independiente de la implementación de la Entity.
- Mantener encapsulado su estado interno.
- Exponer únicamente la funcionalidad necesaria.
- Poder añadirse o retirarse de una Entity sin afectar al resto de la arquitectura.

Los Components deberán poder coexistir sin generar dependencias rígidas entre ellos.

---

# Responsabilidades

La Component API debe permitir:

- Inicializar el Component.
- Acceder a la Entity propietaria cuando sea necesario.
- Exponer su funcionalidad pública.
- Emitir Signals relacionadas con su responsabilidad.
- Integrarse correctamente con los Managers y Systems del proyecto.

Cada Component será responsable únicamente del comportamiento asociado a su dominio.

---

# Convenciones

Todos los Components deberán cumplir las siguientes reglas:

- Una única responsabilidad.
- Interfaces públicas pequeñas y claras.
- Métodos con nombres descriptivos.
- Estado interno encapsulado.
- Sin acceso directo a datos privados de otros Components.
- Sin referencias rígidas a nodos externos.

Las dependencias deberán resolverse mediante la API pública correspondiente.

---

# Integración con el resto del proyecto

Los Components podrán interactuar con:

- Su Entity.
- Otros Components mediante APIs públicas.
- Managers.
- EventBus.
- Signals.
- Resources.

No deberán depender directamente de la estructura de escenas ni de implementaciones concretas.

---

# Consideraciones para Claude

Al generar código:

- Crear Components pequeños y especializados.
- Evitar Components con múltiples responsabilidades.
- No acceder directamente al estado interno de otros Components.
- Utilizar la API pública, Signals o EventBus para comunicarse.
- Mantener la reutilización como prioridad.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar violaciones al principio de responsabilidad única.
- Identificar acoplamientos innecesarios entre Components.
- Verificar el cumplimiento de la arquitectura basada en composición.
- Validar que la comunicación entre Components siga las APIs definidas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Establecer un contrato uniforme para todos los Components del proyecto, asegurando una arquitectura modular, reutilizable y desacoplada que facilite el mantenimiento, la escalabilidad y la evolución del juego durante todo su ciclo de desarrollo.
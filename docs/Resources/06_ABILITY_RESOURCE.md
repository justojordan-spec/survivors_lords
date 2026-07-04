# Ability Resource

**Estado:** Draft

---

# Objetivo

El Ability Resource define una habilidad reutilizable dentro de Survivors Lords.

Su propósito es describir completamente el comportamiento de una habilidad mediante datos, permitiendo que el Ability System ejecute su lógica sin necesidad de configuraciones codificadas.

No ejecuta la habilidad por sí mismo.

---

# Filosofía

Una Ability representa una acción que puede ser ejecutada por una Entity.

El Ability Resource únicamente describe dicha acción.

La ejecución será responsabilidad del Ability System y de los Components correspondientes.

Toda la información necesaria para utilizar una habilidad deberá encontrarse dentro del Resource o en los Resources referenciados por él.

---

# Arquitectura

Cada Ability Resource representará una habilidad independiente.

Podrá referenciar otros Resources especializados para construir comportamientos complejos mediante composición.

Ejemplos:

- Effect Resources.
- Buff Resources.
- Animation Resources.
- Audio Resources.
- VFX Resources.

---

# Información General

Toda Ability podrá definir información como:

- ID único.
- Nombre.
- Descripción.
- Icono.
- Categoría.
- Rareza.
- Nivel mínimo.
- Etiquetas.

---

# Configuración

Una Ability podrá configurar aspectos como:

## Costos

- Maná.
- Energía.
- Vida.
- Recursos especiales.

## Cooldown

- Tiempo base.
- Reducciones permitidas.
- Reutilización.

## Lanzamiento

- Tiempo de casteo.
- Tiempo de preparación.
- Tiempo de recuperación.
- Canalización.

## Alcance

- Distancia.
- Radio.
- Área de efecto.
- Objetivos válidos.

## Ejecución

- Lista de Effect Resources.
- Buffs aplicados.
- Debuffs aplicados.
- Condiciones de uso.

---

# Responsabilidades

El Ability Resource es responsable de:

- Definir una habilidad.
- Configurar sus parámetros.
- Referenciar los Effects necesarios.
- Describir condiciones de utilización.

No es responsable de:

- Ejecutar la habilidad.
- Aplicar daño.
- Modificar estadísticas.
- Detectar objetivos.
- Reproducir efectos.

---

# Composición

Una Ability podrá utilizar:

- Effect Resources.
- Buff Resources.
- Stats Resources.
- Animation Resources.
- Audio Resources.

La composición será la principal herramienta para construir habilidades complejas.

---

# Integración con el resto del proyecto

Los Ability Resources serán utilizados por:

- Ability Component.
- Ability System.
- Combat System.
- Effect System.
- UI System.

Los Components consumirán el Resource sin modificar su contenido.

---

# Rendimiento

Los Ability Resources deberán:

- Compartirse entre múltiples Entities.
- Evitar datos duplicados.
- Mantener únicamente información estática.
- Ser completamente reutilizables.

---

# Multiplayer

Las definiciones de Ability Resources deberán ser idénticas entre Host y Clientes.

La sincronización se realizará únicamente sobre la ejecución de la habilidad y sus resultados.

---

# Convenciones

Toda Ability deberá:

- Tener un ID único.
- Representar una única habilidad.
- Mantener una estructura consistente.
- No contener lógica de ejecución.
- Referenciar otros Resources cuando sea necesario.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Ability Resource como una definición de datos.
- Utilizar composición mediante Effect Resources.
- Evitar lógica de ejecución.
- Favorecer habilidades reutilizables y modulares.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar el uso de Effect Resources.
- Validar la composición de habilidades.
- Identificar duplicación de configuraciones.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una definición completamente Data Driven para todas las habilidades del juego, permitiendo construir acciones complejas mediante composición de Resources reutilizables, desacopladas de la lógica de ejecución y preparadas para escalar durante todo el desarrollo de Survivors Lords.
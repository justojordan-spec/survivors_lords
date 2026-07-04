# Effect Resource

**Estado:** Draft

---

# Objetivo

El Effect Resource define una acción reutilizable que puede producir consecuencias sobre una o más Entities o sobre el mundo del juego.

Su propósito es representar efectos de gameplay de forma completamente Data Driven, permitiendo que múltiples Systems reutilicen la misma definición sin duplicar lógica.

No ejecuta el efecto por sí mismo.

---

# Filosofía

Un Effect Resource representa una descripción de un efecto.

La ejecución corresponde al Effect System.

Un mismo Effect Resource podrá utilizarse desde Abilities, Buffs, Items, Buildings, Quests o Eventos del mundo.

---

# Arquitectura

Cada Effect Resource contendrá únicamente la información necesaria para describir un efecto.

Su interpretación dependerá del System que lo ejecute.

Ejemplos de efectos:

- Daño.
- Curación.
- Aplicación de Buff.
- Eliminación de Buff.
- Generación de partículas.
- Reproducción de sonido.
- Knockback.
- Camera Shake.
- Modificación de estadísticas.
- Invocación de Entities.

---

# Responsabilidades

El Effect Resource es responsable de:

- Definir un efecto.
- Configurar sus parámetros.
- Especificar condiciones de ejecución.
- Poder combinarse con otros Effects.

No es responsable de:

- Ejecutar lógica.
- Modificar Entities.
- Calcular daño.
- Instanciar objetos.
- Reproducir sonidos.

---

# Composición

Un Effect Resource podrá formar parte de:

- Ability Resources.
- Buff Resources.
- Item Resources.
- Quest Resources.
- Event Resources.
- Building Resources.

También podrá combinarse con otros Effect Resources para construir efectos complejos.

---

# Configuración

Un Effect Resource podrá definir información como:

- Tipo de efecto.
- Intensidad.
- Duración.
- Objetivos válidos.
- Alcance.
- Condiciones.
- Prioridad.
- Recursos asociados.

La estructura concreta será definida durante la implementación.

---

# Integración con el resto del proyecto

Los Effect Resources serán ejecutados principalmente por:

- Effect System.
- Ability System.
- Combat System.
- Loot System.
- Quest System.

Su función será describir el efecto, nunca ejecutarlo.

---

# Rendimiento

Los Effect Resources deberán:

- Compartirse entre múltiples Entities.
- Evitar información redundante.
- Ser completamente reutilizables.
- Mantener únicamente datos estáticos.

---

# Multiplayer

Todos los clientes deberán compartir exactamente los mismos Effect Resources.

Durante la partida únicamente se sincronizarán los eventos que indiquen cuándo ejecutar cada efecto.

---

# Convenciones

Todo Effect Resource deberá:

- Tener un ID único.
- Representar una única responsabilidad.
- Ser reutilizable.
- No contener lógica de ejecución.
- Poder combinarse con otros Effects.

---

# Consideraciones para Claude

Al generar código:

- Mantener separados datos y ejecución.
- Evitar lógica dentro del Resource.
- Diseñar Effects reutilizables.
- Favorecer la composición de múltiples Effects.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar reutilización de Effects.
- Validar el desacoplamiento con Effect System.
- Identificar duplicación de configuraciones.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación reutilizable para cualquier efecto del gameplay, permitiendo construir habilidades, buffs, objetos y eventos mediante composición de Effects completamente Data Driven y desacoplados de la lógica de ejecución.
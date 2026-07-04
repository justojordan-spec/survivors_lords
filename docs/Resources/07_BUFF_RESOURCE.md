# Buff Resource

**Estado:** Draft

---

# Objetivo

El Buff Resource define un efecto persistente o temporal que modifica el estado de una Entity.

Su propósito es describir completamente el comportamiento de un Buff mediante datos, permitiendo que el Buff System y el Buff Component administren su ciclo de vida sin lógica codificada.

No ejecuta el Buff por sí mismo.

---

# Filosofía

Un Buff representa una modificación temporal o permanente sobre una Entity.

Puede aumentar, reducir o alterar atributos, aplicar efectos periódicos o modificar el comportamiento de una Entity.

Toda su definición deberá realizarse mediante Resources reutilizables.

---

# Arquitectura

Cada Buff Resource representa una definición independiente.

Su comportamiento se construye mediante la composición de uno o más Effect Resources.

El Buff Component administrará su ciclo de vida mientras que el Buff System coordinará su ejecución.

---

# Información General

Todo Buff podrá definir información como:

- ID único.
- Nombre.
- Descripción.
- Icono.
- Categoría.
- Rareza.
- Etiquetas.

---

# Configuración

Un Buff podrá configurar aspectos como:

## Duración

- Permanente.
- Temporal.
- Instantáneo.
- Infinito.

## Acumulación

- Cantidad máxima de stacks.
- Renovación de duración.
- Reemplazo.
- Acumulación.

## Frecuencia

- Tick periódico.
- Intervalo.
- Tiempo inicial.
- Tiempo final.

## Aplicación

- Lista de Effect Resources.
- Condiciones de aplicación.
- Condiciones de eliminación.

---

# Responsabilidades

El Buff Resource es responsable de:

- Definir un Buff.
- Configurar su duración.
- Configurar su comportamiento.
- Referenciar los Effects necesarios.

No es responsable de:

- Aplicar estadísticas.
- Ejecutar lógica.
- Calcular daño.
- Detectar objetivos.
- Administrar Entities.

---

# Composición

Un Buff podrá utilizar:

- Effect Resources.
- Stats Resources.
- Audio Resources.
- Visual Effect Resources.
- Animation Resources.

Todos estos Resources serán opcionales.

---

# Integración con el resto del proyecto

Los Buff Resources serán utilizados por:

- Buff Component.
- Buff System.
- Ability System.
- Combat System.
- Effect System.

Los Systems serán responsables de interpretar el Resource.

---

# Rendimiento

Los Buff Resources deberán:

- Compartirse entre múltiples Entities.
- Ser completamente reutilizables.
- Evitar configuraciones duplicadas.
- Mantener únicamente información estática.

---

# Multiplayer

Los Buff Resources deberán ser idénticos entre Host y Clientes.

Durante la partida únicamente se sincronizará:

- Aplicación.
- Eliminación.
- Renovación.
- Duración restante.

---

# Convenciones

Todo Buff deberá:

- Tener un ID único.
- Representar una única responsabilidad.
- No contener lógica.
- Utilizar composición mediante Effect Resources.
- Mantener compatibilidad con el Buff Component.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Buff como una definición de datos.
- Reutilizar Effect Resources.
- Evitar lógica de ejecución.
- Diseñar Buffs completamente modulares.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar la reutilización de Effects.
- Validar la composición del Buff.
- Identificar configuraciones duplicadas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una definición completamente Data Driven para cualquier Buff del juego, permitiendo construir efectos temporales y permanentes mediante composición de Effect Resources, desacoplados de la lógica de ejecución y reutilizables por cualquier sistema del proyecto.
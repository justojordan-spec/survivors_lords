# Loot Table Resource

**Estado:** Draft

---

# Objetivo

El Loot Table Resource define la configuración utilizada para determinar las posibles recompensas obtenidas al derrotar enemigos, abrir contenedores, completar eventos o finalizar misiones.

Su propósito es centralizar todas las tablas de botín mediante una arquitectura completamente Data Driven.

No genera objetos por sí mismo.

---

# Filosofía

Una Loot Table representa una colección de posibles recompensas.

La lógica para seleccionar qué objetos entregar será responsabilidad del Loot System.

El Resource únicamente describe las probabilidades y condiciones del botín.

---

# Arquitectura

Cada Loot Table contiene una colección de entradas independientes.

Cada entrada podrá definir:

- Item Resource.
- Cantidad.
- Probabilidad.
- Condiciones.
- Prioridad.

Una misma Loot Table podrá ser reutilizada por múltiples Entities.

---

# Información General

Toda Loot Table podrá definir:

- ID único.
- Nombre.
- Descripción.
- Categoría.
- Etiquetas.

---

# Configuración

Una Loot Table podrá incluir:

## Objetos

- Item Resource.
- Cantidad mínima.
- Cantidad máxima.
- Peso.
- Probabilidad.

## Condiciones

- Nivel mínimo.
- Nivel máximo.
- Profesión requerida.
- Evento activo.
- Bioma.
- Hora del día.
- Clima.

## Reglas

- Botín garantizado.
- Botín opcional.
- Botín único.
- Botín repetible.
- Cantidad máxima de recompensas.

---

# Responsabilidades

El Loot Table Resource es responsable de:

- Definir posibles recompensas.
- Configurar probabilidades.
- Establecer condiciones.
- Ser reutilizable por múltiples Systems.

No es responsable de:

- Generar objetos.
- Calcular probabilidades.
- Modificar inventarios.
- Instanciar Items.
- Gestionar economía.

---

# Composición

Una Loot Table podrá referenciar:

- Item Resources.
- Event Resources.
- World Resources.
- Faction Resources.

Las referencias deberán mantenerse desacopladas.

---

# Integración con el resto del proyecto

Los Loot Table Resources serán utilizados por:

- Loot System.
- Enemy System.
- Quest System.
- Building System.
- World System.

Su función será proporcionar la configuración del botín disponible.

---

# Rendimiento

Las Loot Tables deberán:

- Compartirse entre múltiples Entities.
- Evitar duplicación de datos.
- Mantener únicamente información estática.
- Ser reutilizables.

---

# Multiplayer

La generación del botín deberá ser autoritativa.

El Host o servidor dedicado decidirá el resultado de la Loot Table y sincronizará únicamente las recompensas obtenidas.

---

# Convenciones

Toda Loot Table deberá:

- Tener un ID único.
- Ser reutilizable.
- Mantener una única responsabilidad.
- No contener lógica de selección.
- Utilizar únicamente referencias a Resources.

---

# Consideraciones para Claude

Al generar código:

- Mantener la lógica de generación fuera del Resource.
- Utilizar Loot Tables reutilizables.
- Evitar referencias circulares.
- Favorecer composiciones simples.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar probabilidades inconsistentes.
- Validar referencias correctas a Item Resources.
- Identificar configuraciones duplicadas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una definición reutilizable para todas las tablas de botín del juego, permitiendo configurar recompensas mediante datos, separando completamente la definición del botín de la lógica encargada de generarlo.
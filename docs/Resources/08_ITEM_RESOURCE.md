# Item Resource

**Estado:** Draft

---

# Objetivo

El Item Resource define la estructura base utilizada para describir cualquier objeto del juego.

Su propósito es proporcionar una representación completamente Data Driven para todos los ítems de Survivors Lords, permitiendo que el contenido pueda ampliarse sin modificar código.

No representa una instancia dentro del inventario, sino una definición reutilizable.

---

# Filosofía

Un Item Resource describe qué es un objeto.

No almacena información dinámica.

Los estados particulares de una instancia (durabilidad actual, cantidad, mejoras, propietario, etc.) serán administrados por Components y Systems.

---

# Arquitectura

El Item Resource actúa como la base para todos los objetos del juego.

Ejemplos:

- Armas.
- Armaduras.
- Herramientas.
- Consumibles.
- Materiales.
- Recursos.
- Objetos de misión.
- Objetos especiales.

Cada categoría podrá extender la definición base mediante Resources especializados.

---

# Información General

Todo Item Resource podrá definir:

- ID único.
- Nombre.
- Descripción.
- Icono.
- Modelo o escena asociada.
- Categoría.
- Rareza.
- Peso.
- Valor económico.
- Stack máximo.
- Etiquetas.

---

# Configuración

Un Item podrá incluir información como:

## Inventario

- Tamaño de stack.
- Apilable.
- Peso.
- Tamaño físico.

## Economía

- Precio de compra.
- Precio de venta.
- Valor base.

## Uso

- Consumible.
- Equipable.
- Colocable.
- Intercambiable.
- Descartable.

## Gameplay

- Ability Resources.
- Buff Resources.
- Effect Resources.
- Stats Resources.

---

# Responsabilidades

El Item Resource es responsable de:

- Definir un objeto.
- Configurar sus propiedades.
- Referenciar otros Resources.
- Servir como plantilla para instancias.

No es responsable de:

- Gestionar inventarios.
- Aplicar efectos.
- Ejecutar habilidades.
- Modificar estadísticas.
- Almacenar estados dinámicos.

---

# Composición

Un Item podrá utilizar:

- Ability Resources.
- Buff Resources.
- Effect Resources.
- Stats Resources.
- Loot Table Resources.
- Crafting Resources.

La composición permitirá crear objetos complejos sin duplicar información.

---

# Integración con el resto del proyecto

Los Item Resources serán utilizados por:

- Inventory Component.
- Equipment Component.
- Item System.
- Loot System.
- Crafting System.
- Economy System.
- UI System.

---

# Rendimiento

Los Item Resources deberán:

- Compartirse entre múltiples instancias.
- Evitar duplicación de datos.
- Mantener únicamente información estática.
- Aprovechar el sistema de caché de Godot.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos Item Resources.

Durante la sincronización únicamente se transmitirán los estados dinámicos de las instancias.

---

# Convenciones

Todo Item deberá:

- Tener un ID único.
- Representar un único objeto.
- Mantener una estructura consistente.
- No contener lógica.
- Ser completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Item Resource como una definición de datos.
- Evitar lógica de gameplay.
- Favorecer la composición mediante otros Resources.
- Diseñar Items reutilizables y extensibles.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas a otros Resources.
- Validar la separación entre datos estáticos y estados dinámicos.
- Identificar duplicación de configuraciones.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una definición base para todos los objetos del juego, permitiendo construir armas, armaduras, herramientas, consumibles y materiales mediante una arquitectura completamente Data Driven, reutilizable y desacoplada de la lógica del gameplay.
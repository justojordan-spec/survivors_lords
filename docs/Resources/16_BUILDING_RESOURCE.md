# Building Resource

**Estado:** Draft

---

# Objetivo

El Building Resource define la configuración de cualquier estructura construible dentro de Survivors Lords.

Su propósito es representar edificios, estaciones de trabajo, defensas, decoraciones y cualquier otra construcción mediante una arquitectura completamente Data Driven.

No representa una instancia colocada en el mundo.

---

# Filosofía

Un Building Resource describe cómo es una construcción.

No administra su estado durante la partida.

Toda la lógica relacionada con colocación, construcción, destrucción, producción y mantenimiento será responsabilidad del Building System y de los Components asociados.

---

# Arquitectura

Cada Building Resource representa un tipo de construcción.

Podrá ser utilizado para crear:

- Viviendas.
- Murallas.
- Torres.
- Puertas.
- Bancos de trabajo.
- Hornos.
- Forjas.
- Almacenes.
- Decoraciones.
- Estructuras especiales.

---

# Información General

Todo Building podrá definir:

- ID único.
- Nombre.
- Descripción.
- Icono.
- Escena asociada.
- Categoría.
- Tamaño.
- Peso.
- Etiquetas.

---

# Configuración

Una construcción podrá definir:

## Construcción

- Recipe Resource requerido.
- Tiempo de construcción.
- Herramienta necesaria.
- Profesión requerida.

## Colocación

- Tamaño en la grilla.
- Rotación permitida.
- Terrenos válidos.
- Restricciones de ubicación.

## Integridad

- Vida máxima.
- Resistencia.
- Reparación.
- Durabilidad.

## Producción

- Recursos generados.
- Consumo de recursos.
- Tiempo de producción.
- Inventario interno.

## Interacción

- Puede abrirse.
- Puede mejorarse.
- Puede repararse.
- Puede demolerse.

---

# Responsabilidades

El Building Resource es responsable de:

- Definir una construcción.
- Configurar sus propiedades.
- Referenciar otros Resources.
- Servir como plantilla para instancias.

No es responsable de:

- Construir edificios.
- Administrar producción.
- Gestionar inventarios.
- Ejecutar lógica.
- Controlar trabajadores.

---

# Composición

Un Building podrá utilizar:

- Recipe Resources.
- Loot Table Resources.
- Item Resources.
- Effect Resources.
- Faction Resources.
- World Resources.

Todos estos Resources serán opcionales.

---

# Integración con el resto del proyecto

Los Building Resources serán utilizados por:

- Building System.
- Crafting System.
- Kingdom System.
- World System.
- Inventory System.
- Save System.

Su función será proporcionar la configuración base de todas las construcciones del juego.

---

# Rendimiento

Los Building Resources deberán:

- Compartirse entre múltiples instancias.
- Evitar datos duplicados.
- Mantener únicamente información estática.
- Aprovechar el sistema de caché de Godot.

---

# Multiplayer

Las definiciones de Building Resources deberán ser idénticas entre Host y Clientes.

La colocación, mejora, reparación y destrucción de edificios será validada por el Host o servidor dedicado.

---

# Convenciones

Todo Building deberá:

- Tener un ID único.
- Representar una única construcción.
- Mantener una estructura consistente.
- No contener lógica.
- Ser completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Building Resource como una definición de datos.
- Evitar lógica de construcción.
- Utilizar composición mediante otros Resources.
- Diseñar Buildings completamente modulares.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas a otros Resources.
- Validar la separación entre configuración y estado dinámico.
- Identificar configuraciones duplicadas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para todas las construcciones del juego, permitiendo definir edificios, estaciones de trabajo, defensas y estructuras especiales mediante Resources reutilizables, desacoplados de la lógica del Building System y preparados para integrarse con el resto de la arquitectura de Survivors Lords.
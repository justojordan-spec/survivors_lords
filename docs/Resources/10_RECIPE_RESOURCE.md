# Recipe Resource

**Estado:** Draft

---

# Objetivo

El Recipe Resource define una receta de fabricación utilizada por el Crafting System.

Su propósito es describir completamente los requisitos, materiales, condiciones y resultados de una receta mediante una arquitectura completamente Data Driven.

No fabrica objetos por sí mismo.

---

# Filosofía

Una receta representa una transformación de recursos.

El Recipe Resource únicamente describe dicha transformación.

La ejecución corresponde al Crafting System.

Esto permite modificar el contenido del juego sin alterar la implementación.

---

# Arquitectura

Cada Recipe Resource representa una receta independiente.

Podrá utilizar múltiples Resources para describir:

- Ingredientes.
- Resultados.
- Herramientas.
- Profesiones.
- Estaciones de trabajo.
- Condiciones especiales.

---

# Información General

Toda Recipe podrá definir:

- ID único.
- Nombre.
- Descripción.
- Icono.
- Categoría.
- Profesión asociada.
- Nivel requerido.
- Etiquetas.

---

# Ingredientes

Una receta podrá requerir:

- Item Resources.
- Cantidad de cada ingrediente.
- Calidad mínima.
- Materiales opcionales.
- Materiales alternativos.

Los ingredientes nunca serán instancias específicas.

Siempre harán referencia a Item Resources.

---

# Resultado

Una receta podrá producir:

- Uno o varios Item Resources.
- Cantidad producida.
- Calidad base.
- Resultados aleatorios.
- Subproductos.

---

# Requisitos

Una receta podrá definir:

## Profesión

- Profesión requerida.
- Nivel mínimo.

## Estación

- Banco de trabajo.
- Horno.
- Forja.
- Mesa de alquimia.
- Cocina.

## Mundo

- Bioma.
- Evento activo.
- Hora del día.
- Clima.

---

# Configuración

Cada receta podrá incluir:

- Tiempo de fabricación.
- Consumo de energía.
- Probabilidad de éxito.
- Probabilidad de fallo.
- Coste económico.
- Experiencia obtenida.

---

# Responsabilidades

El Recipe Resource es responsable de:

- Definir una receta.
- Configurar ingredientes.
- Configurar resultados.
- Establecer requisitos.
- Describir condiciones.

No es responsable de:

- Fabricar objetos.
- Consumir materiales.
- Modificar inventarios.
- Calcular probabilidades.
- Otorgar experiencia.

---

# Composición

Una Recipe podrá utilizar:

- Item Resources.
- Profession Resources.
- Building Resources.
- World Resources.
- Event Resources.

Todos estos Resources serán opcionales.

---

# Integración con el resto del proyecto

Los Recipe Resources serán utilizados por:

- Crafting System.
- Inventory System.
- Profession System.
- Building System.
- UI System.

Su función será proporcionar la configuración necesaria para fabricar objetos.

---

# Rendimiento

Las Recipes deberán:

- Compartirse entre múltiples jugadores.
- Evitar configuraciones duplicadas.
- Mantener únicamente información estática.
- Ser completamente reutilizables.

---

# Multiplayer

La validación de una fabricación deberá realizarse en el Host o servidor dedicado.

Los clientes únicamente solicitarán la ejecución de una Recipe.

El resultado será sincronizado por el sistema de red.

---

# Convenciones

Toda Recipe deberá:

- Tener un ID único.
- Representar una única fabricación.
- Mantener una estructura consistente.
- No contener lógica.
- Referenciar únicamente Resources.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Recipe Resource como una definición de datos.
- Evitar lógica de fabricación.
- Reutilizar Item Resources.
- Diseñar Recipes modulares y escalables.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas a Item Resources.
- Validar la separación entre datos y lógica.
- Identificar configuraciones duplicadas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para todas las recetas del juego, permitiendo fabricar objetos mediante configuraciones reutilizables, desacopladas de la lógica del Crafting System y preparadas para escalar durante todo el desarrollo de Survivors Lords.
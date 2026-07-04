# Consumable Resource

**Estado:** Draft

---

# Objetivo

El Consumable Resource define la configuración de cualquier objeto consumible dentro de Survivors Lords.

Su propósito es representar alimentos, pociones, pergaminos, bombas y cualquier otro objeto de un solo uso mediante una arquitectura completamente Data Driven.

No ejecuta efectos por sí mismo.

---

# Filosofía

Un consumible es una especialización de un Item.

El Consumable Resource únicamente describe qué ocurre al utilizar el objeto.

La ejecución de sus efectos será responsabilidad del Item System, Ability System y Effect System.

---

# Arquitectura

Todo Consumable Resource deriva conceptualmente de Item Resource.

Además de las propiedades generales de un Item, incorpora información específica relacionada con su utilización.

Ejemplos:

- Pociones.
- Comida.
- Bebidas.
- Pergaminos.
- Bombas.
- Trampas consumibles.
- Llaves especiales.
- Cristales mágicos.

---

# Información General

Todo Consumable podrá definir:

- ID único.
- Nombre.
- Descripción.
- Icono.
- Modelo o escena.
- Rareza.
- Calidad.
- Nivel requerido.
- Etiquetas.

---

# Configuración

## Consumo

- Tiempo de uso.
- Tiempo de canalización.
- Cooldown.
- Cantidad consumida.

## Restricciones

- Nivel mínimo.
- Profesión requerida.
- Estado requerido.
- Zona permitida.
- Condiciones especiales.

## Efectos

Al consumirse podrá ejecutar:

- Effect Resources.
- Buff Resources.
- Ability Resources.
- Stats Resources.

Todos estos Resources serán opcionales.

---

# Tipos

Ejemplos de categorías:

- Curación.
- Energía.
- Maná.
- Buff temporal.
- Debuff.
- Invocación.
- Teletransporte.
- Material especial.
- Objeto de misión.

---

# Responsabilidades

El Consumable Resource es responsable de:

- Definir un consumible.
- Configurar requisitos.
- Configurar efectos.
- Referenciar otros Resources.

No es responsable de:

- Ejecutar efectos.
- Modificar estadísticas.
- Administrar inventarios.
- Consumir Items.
- Ejecutar lógica.

---

# Composición

Un Consumable podrá utilizar:

- Effect Resources.
- Buff Resources.
- Ability Resources.
- Stats Resources.
- Recipe Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Consumable Resources serán utilizados por:

- Inventory System.
- Item System.
- Effect System.
- Ability System.
- Buff System.
- Save System.
- UI System.

Su función será proporcionar la configuración base de todos los objetos consumibles.

---

# Rendimiento

Los Consumable Resources deberán:

- Compartirse entre múltiples instancias.
- Evitar datos duplicados.
- Mantener únicamente información estática.
- Aprovechar el sistema de caché de Godot.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos Consumable Resources.

El consumo de un objeto será validado por el Host o servidor dedicado.

Los efectos resultantes serán sincronizados mediante los Systems correspondientes.

---

# Convenciones

Todo Consumable deberá:

- Tener un ID único.
- Derivar conceptualmente de Item Resource.
- Representar un único objeto consumible.
- Mantener una estructura consistente.
- No contener lógica.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Consumable Resource como una definición de datos.
- Evitar lógica de ejecución.
- Reutilizar Effect Resources siempre que sea posible.
- Favorecer la composición antes que configuraciones específicas.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas.
- Validar reutilización de Effects y Buffs.
- Identificar configuraciones duplicadas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para todos los consumibles del juego, permitiendo definir efectos, requisitos y restricciones mediante Resources reutilizables, desacoplados de la lógica del Item System y preparados para integrarse con el resto de la arquitectura de Survivors Lords.
# Currency Resource

**Estado:** Draft

---

# Objetivo

El Currency Resource define una moneda utilizada dentro de Survivors Lords.

Su propósito es representar cualquier medio de intercambio económico mediante una arquitectura completamente Data Driven.

No administra balances, transacciones ni economía dinámica.

---

# Filosofía

Una moneda representa un recurso económico utilizado para el comercio.

El Currency Resource únicamente describe sus características estáticas.

Toda la lógica económica será responsabilidad del Economy System.

---

# Arquitectura

Cada Currency Resource representa una única moneda.

Ejemplos:

- Oro
- Plata
- Cobre
- Gemas
- Cristales Arcanos
- Fichas del Reino
- Moneda Imperial

---

# Información General

Toda Currency podrá definir:

- ID único.
- Nombre.
- Descripción.
- Símbolo.
- Icono.
- Color representativo.
- Etiquetas.

---

# Configuración

## Valor

Podrá definir:

- Valor base.
- Unidad mínima.
- Unidad máxima.
- Precisión decimal.

---

## Conversión

Opcionalmente podrá definir:

- Monedas compatibles.
- Tasas de conversión.
- Conversión automática.
- Restricciones.

---

## Uso

La moneda podrá utilizarse para:

- Comercio.
- Crafting.
- Reparaciones.
- Investigación.
- Construcción.
- Misiones.
- Impuestos.
- Mercados.

---

## Restricciones

Podrá definir:

- Reino permitido.
- Facción permitida.
- Biomas permitidos.
- Eventos requeridos.

---

# Responsabilidades

El Currency Resource es responsable de:

- Definir una moneda.
- Configurar conversiones.
- Configurar restricciones.
- Referenciar otros Resources.

No es responsable de:

- Administrar economía.
- Procesar pagos.
- Mantener balances.
- Ejecutar comercio.
- Contener lógica.

---

# Composición

Una Currency podrá utilizar:

- Kingdom Resources.
- Faction Resources.
- Settlement Resources.
- Quest Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Currency Resources serán utilizados por:

- Economy System.
- Trading System.
- Merchant System.
- Settlement System.
- Kingdom System.
- Quest System.
- Save System.

Su función será proporcionar la configuración base de todas las monedas del juego.

---

# Rendimiento

Los Currency Resources deberán:

- Compartirse entre todas las partidas.
- Mantener únicamente información estática.
- Evitar configuraciones duplicadas.
- Ser completamente reutilizables.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos Currency Resources.

El servidor administrará las transacciones y sincronizará los balances correspondientes.

---

# Convenciones

Toda Currency deberá:

- Tener un ID único.
- Representar una única moneda.
- No contener lógica.
- Ser completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Currency Resource como una definición de datos.
- Evitar lógica económica.
- Diseñar monedas reutilizables.
- Mantener independencia respecto al Economy System.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas.
- Detectar configuraciones duplicadas.
- Validar la separación entre moneda y economía.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para todas las monedas del juego, permitiendo definir sus características, conversiones y restricciones mediante Resources reutilizables, desacoplados de la lógica del Economy System y preparados para integrarse con el comercio, los asentamientos y los reinos de Survivors Lords.
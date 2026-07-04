# Economy Resource

**Estado:** Draft

---

# Objetivo

El Economy Resource define las reglas económicas utilizadas dentro de Survivors Lords.

Su propósito es configurar el comportamiento general de la economía mediante una arquitectura completamente Data Driven.

No administra transacciones, balances ni mercados en tiempo de ejecución.

---

# Filosofía

La economía representa el conjunto de reglas que gobiernan el intercambio de recursos.

El Economy Resource únicamente describe dichas reglas.

Toda la simulación económica será responsabilidad del Economy System.

---

# Arquitectura

Cada Economy Resource representa un modelo económico reutilizable.

Ejemplos:

- Economía Medieval
- Economía de Supervivencia
- Economía Imperial
- Economía Tribal
- Economía Comercial

---

# Información General

Toda Economy podrá definir:

- ID único.
- Nombre.
- Descripción.
- Categoría.
- Etiquetas.

---

# Monedas

Podrá utilizar:

- Currency Resources permitidas.
- Moneda principal.
- Conversión entre monedas.
- Restricciones monetarias.

---

# Comercio

Podrá configurar:

- Compra.
- Venta.
- Intercambio.
- Mercados.
- Comerciantes.
- Impuestos.
- Tarifas.

---

# Producción

Podrá definir:

- Multiplicadores de producción.
- Multiplicadores de consumo.
- Recursos estratégicos.
- Escasez.
- Abundancia.

---

# Precios

Podrá configurar:

- Precio mínimo.
- Precio máximo.
- Variación automática.
- Inflación.
- Deflación.

---

# Restricciones

Podrá limitar:

- Comercio internacional.
- Comercio entre facciones.
- Comercio entre reinos.
- Recursos prohibidos.

---

# Eventos

Podrá reaccionar a:

- Guerras.
- Desastres.
- Eventos mundiales.
- Crisis económicas.
- Estaciones.

---

# Responsabilidades

El Economy Resource es responsable de:

- Definir reglas económicas.
- Configurar producción.
- Configurar comercio.
- Configurar precios.
- Referenciar otros Resources.

No es responsable de:

- Ejecutar comercio.
- Calcular precios.
- Procesar pagos.
- Mantener balances.
- Ejecutar lógica.

---

# Composición

Una Economy podrá utilizar:

- Currency Resources.
- Kingdom Resources.
- Settlement Resources.
- Event Resources.
- Quest Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Economy Resources serán utilizados por:

- Economy System.
- Trading System.
- Merchant System.
- Settlement System.
- Kingdom System.
- Quest System.
- World System.

Su función será proporcionar las reglas económicas utilizadas durante la simulación del juego.

---

# Rendimiento

Los Economy Resources deberán:

- Compartirse entre todas las partidas.
- Mantener únicamente datos estáticos.
- Evitar configuraciones duplicadas.
- Ser completamente reutilizables.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos Economy Resources.

El servidor será responsable de ejecutar la simulación económica y sincronizar únicamente los resultados.

---

# Convenciones

Toda Economy deberá:

- Tener un ID único.
- Representar un único modelo económico.
- No contener lógica.
- Ser completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Economy Resource como una definición de datos.
- Evitar lógica de simulación.
- Favorecer referencias reutilizables.
- Mantener independencia respecto al Economy System.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas.
- Detectar configuraciones duplicadas.
- Validar la separación entre reglas económicas y simulación.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para las reglas económicas del juego, permitiendo configurar producción, comercio, precios y restricciones mediante Resources reutilizables, desacoplados de la lógica del Economy System y preparados para soportar distintos modelos económicos en Survivors Lords.
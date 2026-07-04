# Weather Resource

**Estado:** Draft

---

# Objetivo

El Weather Resource define la configuración de una condición climática dentro de Survivors Lords.

Su propósito es describir todas las propiedades necesarias para simular un tipo de clima mediante una arquitectura completamente Data Driven.

No contiene lógica de simulación.

---

# Filosofía

Cada tipo de clima será representado por un Weather Resource.

El Weather System utilizará estos Resources para generar y controlar el estado climático del mundo.

Los Resources únicamente describen datos.

Toda la lógica pertenece al Weather System.

---

# Responsabilidades

El Weather Resource será responsable de definir:

- Identificador único.
- Nombre.
- Descripción.
- Tipo de clima.
- Intensidad.
- Duración.
- Probabilidad de aparición.
- Temperatura.
- Humedad.
- Velocidad del viento.
- Visibilidad.
- Efectos visuales.
- Efectos sonoros.
- Modificadores ambientales.

---

# No es responsable de

El Weather Resource NO debe:

- Ejecutar simulaciones.
- Modificar entidades.
- Generar eventos.
- Administrar transiciones.
- Controlar el paso del tiempo.

Estas responsabilidades pertenecen al Weather System.

---

# Tipos de Clima

Ejemplos:

- Soleado.
- Parcialmente nublado.
- Nublado.
- Lluvia.
- Tormenta.
- Tormenta eléctrica.
- Niebla.
- Nieve.
- Granizo.
- Sequía.
- Clima especial.

---

# Propiedades

Cada Weather Resource podrá definir:

- Temperatura mínima.
- Temperatura máxima.
- Intensidad.
- Duración mínima.
- Duración máxima.
- Probabilidad.
- Color ambiental.
- Iluminación.
- Densidad de niebla.
- Intensidad del viento.
- Nivel de precipitación.

---

# Modificadores

Podrá afectar:

- Movimiento.
- Visibilidad.
- Agricultura.
- Construcción.
- Producción.
- Spawn de criaturas.
- Aparición de eventos.
- Consumo de energía.
- Moral de NPC.

---

# Integración

Será utilizado por:

- Weather System.
- World System.
- Time System.
- Settlement System.
- Economy System.
- Building System.
- Enemy System.
- Player System.
- Audio System.
- UI System.

---

# Serialización

Todo Weather Resource deberá:

- Poder serializarse.
- Poder versionarse.
- Ser reutilizable.
- Mantener compatibilidad con el Save System.

---

# Convenciones

Todo Weather Resource deberá:

- Tener un ID único.
- Mantener nombres descriptivos.
- Evitar lógica.
- Ser completamente Data Driven.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Resource libre de lógica.
- Configurar todos los parámetros desde datos.
- Evitar referencias a Systems.
- Favorecer reutilización.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar lógica dentro del Resource.
- Verificar consistencia de propiedades.
- Detectar datos duplicados.
- Validar referencias.

---

# Estado

**Fase:** 4 – Resources

**Estado:** Draft

---

# Objetivo Final

Disponer de un Resource reutilizable que describa completamente cualquier condición climática del juego, permitiendo que el Weather System gestione la simulación de forma totalmente Data Driven.

---

# DEC propuesta

## DEC – Todas las condiciones climáticas serán Data Driven

### Decisión

Cada condición climática del juego será definida mediante un Weather Resource independiente. El Weather System utilizará estos Resources para controlar la simulación del clima sin contener configuraciones específicas en código.

### Justificación

- Mantiene la arquitectura Data Driven.
- Facilita la creación de nuevos climas.
- Evita configuraciones hardcodeadas.
- Mejora la reutilización y escalabilidad.
- Mantiene desacoplados los datos y la lógica.
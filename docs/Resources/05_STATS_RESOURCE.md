# Stats Resource

**Estado:** Draft

---

# Objetivo

El Stats Resource define el conjunto de estadísticas base utilizadas por una Entity o por cualquier sistema que requiera modificar atributos del gameplay.

Su propósito es centralizar la configuración de estadísticas mediante una arquitectura completamente Data Driven, permitiendo que múltiples Resources compartan la misma definición.

No administra estados dinámicos ni realiza cálculos.

---

# Filosofía

Las estadísticas representan valores base del juego.

El Stats Resource únicamente describe dichos valores.

Los Components y Systems serán responsables de interpretar, modificar y utilizar estas estadísticas durante la ejecución del juego.

---

# Arquitectura

El Stats Resource contiene una colección de estadísticas organizadas de forma estructurada.

Podrá ser referenciado por distintos Resources del proyecto para definir atributos iniciales o modificadores.

Las estadísticas deberán mantenerse independientes de cualquier lógica de gameplay.

---

# Estadísticas

El Resource podrá definir categorías como:

## Vitales

- Vida Máxima
- Energía
- Maná
- Resistencia

## Combate

- Daño Base
- Daño Crítico
- Probabilidad Crítica
- Velocidad de Ataque
- Alcance

## Defensa

- Armadura
- Resistencia Física
- Resistencia Mágica
- Bloqueo
- Evasión

## Movimiento

- Velocidad
- Aceleración
- Rotación

## Recolección

- Minería
- Tala
- Pesca
- Agricultura

## Profesiones

- Herrería
- Alquimia
- Cocina
- Construcción

La lista definitiva será definida durante la implementación.

---

# Responsabilidades

El Stats Resource es responsable de:

- Definir estadísticas base.
- Agrupar atributos relacionados.
- Servir como configuración inicial.
- Ser reutilizable por múltiples Resources.

No es responsable de:

- Calcular modificadores.
- Aplicar Buffs.
- Gestionar niveles.
- Ejecutar lógica.
- Mantener estados dinámicos.

---

# Composición

El Stats Resource podrá ser utilizado por:

- Character Resource.
- Enemy Resource.
- NPC Resource.
- Building Resource.
- Equipment Resource.
- Buff Resource.
- Ability Resource.

Cada uno decidirá cómo interpretar las estadísticas.

---

# Integración con el resto del proyecto

Los datos definidos en este Resource serán consumidos por:

- Stats Component.
- Combat System.
- Ability System.
- Buff System.
- Equipment System.

El Resource nunca modificará directamente el estado de una Entity.

---

# Rendimiento

El Stats Resource deberá:

- Compartirse entre múltiples instancias.
- Evitar datos duplicados.
- Mantener únicamente información estática.
- Aprovechar el sistema de caché de Godot.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente la misma definición de Stats Resource.

Los valores dinámicos serán sincronizados mediante los Systems correspondientes.

---

# Convenciones

Todo Stats Resource deberá:

- Tener un ID único.
- Mantener una estructura consistente.
- Organizar las estadísticas por categorías.
- No almacenar estados temporales.
- Permanecer completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener los Stats Resources como estructuras de datos.
- Evitar lógica de cálculo.
- Diseñar categorías extensibles.
- Favorecer la reutilización entre distintos tipos de Resources.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar la separación entre datos y comportamiento.
- Validar la organización por categorías.
- Identificar duplicación de estadísticas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una definición única y reutilizable para las estadísticas base del juego, permitiendo que cualquier Entity o sistema configure sus atributos mediante una arquitectura completamente Data Driven, consistente y desacoplada.
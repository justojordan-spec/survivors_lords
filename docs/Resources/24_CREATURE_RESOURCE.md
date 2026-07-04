# Creature Resource

**Estado:** Draft

---

# Objetivo

El Creature Resource define la configuración base de cualquier criatura viva no civil dentro de Survivors Lords.

Su propósito es representar criaturas salvajes, animales y enemigos mediante una arquitectura completamente Data Driven.

No representa una instancia activa dentro del mundo.

---

# Filosofía

Una criatura es una especialización de Entity Resource.

Describe sus características biológicas, comportamiento natural y configuración general.

La IA, combate y comportamiento dinámico serán responsabilidad de los Systems correspondientes.

---

# Arquitectura

Todo Creature Resource deriva conceptualmente de Entity Resource.

Servirá como base para:

- Enemy Resource
- Animal Resource
- Boss Resource

---

# Información General

Toda Creature podrá definir:

- ID único.
- Nombre.
- Descripción.
- Modelo o escena.
- Categoría.
- Rareza.
- Nivel.
- Etiquetas.

---

# Configuración

## Biología

- Tamaño.
- Peso.
- Velocidad base.
- Tipo de locomoción.
- Alimentación.

## Hábitat

- Biomas válidos.
- Horario de actividad.
- Clima preferido.
- Altitud.

## Comportamiento

- Temperamento.
- Territorialidad.
- Agresividad.
- Instinto de huida.
- Comportamiento social.

## Reproducción

- Puede reproducirse.
- Tiempo de reproducción.
- Cantidad de crías.
- Condiciones.

---

# Loot

Una criatura podrá utilizar:

- Loot Table Resource.
- Experience Reward.
- Recursos especiales.

---

# Relaciones

Una criatura podrá definir:

- Facción.
- Depredadores.
- Presas.
- Aliados naturales.
- Domesticable.

---

# Responsabilidades

El Creature Resource es responsable de:

- Definir una criatura.
- Configurar su comportamiento base.
- Configurar hábitats.
- Configurar recompensas.
- Referenciar otros Resources.

No es responsable de:

- Ejecutar IA.
- Controlar movimiento.
- Resolver combate.
- Administrar reproducción.
- Gestionar Spawn.

---

# Composición

Una Creature podrá utilizar:

- Stats Resources.
- Loot Table Resources.
- Ability Resources.
- Buff Resources.
- Faction Resources.
- Spawn Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Creature Resources serán utilizados por:

- AI System.
- Spawn System.
- Combat System.
- Loot System.
- World System.
- Save System.

Su función será proporcionar la configuración base de todas las criaturas del mundo.

---

# Rendimiento

Los Creature Resources deberán:

- Compartirse entre múltiples instancias.
- Mantener únicamente datos estáticos.
- Evitar configuraciones duplicadas.
- Ser completamente reutilizables.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos Creature Resources.

El comportamiento será administrado por el Host o servidor dedicado.

---

# Convenciones

Toda Creature deberá:

- Tener un ID único.
- Derivar conceptualmente de Entity Resource.
- Representar un único tipo de criatura.
- No contener lógica.
- Ser completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Creature Resource como una definición de datos.
- Evitar lógica de IA.
- Favorecer composición mediante otros Resources.
- Diseñar una base reutilizable para Enemy y Animal.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas.
- Detectar configuraciones duplicadas.
- Validar reutilización por Enemy y Animal.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para todas las criaturas del mundo, proporcionando una base común reutilizable para enemigos, animales y jefes, desacoplada de la lógica de IA y preparada para integrarse con el resto de la arquitectura de Survivors Lords.
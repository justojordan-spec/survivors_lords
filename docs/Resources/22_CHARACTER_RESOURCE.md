# Character Resource

**Estado:** Draft

---

# Objetivo

El Character Resource define la configuración base de un personaje jugable dentro de Survivors Lords.

Su propósito es describir las propiedades iniciales, restricciones, progresión y capacidades de un personaje mediante una arquitectura completamente Data Driven.

No representa una partida guardada ni el estado actual de un jugador.

---

# Filosofía

Un Character es una especialización de Entity Resource.

El Character Resource define únicamente la plantilla inicial de un personaje.

Toda la información dinámica como experiencia, inventario, estadísticas actuales, posición, equipo y progreso será administrada por los Components y Systems correspondientes.

---

# Arquitectura

Todo Character Resource deriva conceptualmente de Entity Resource.

Representa el punto de partida para cualquier personaje controlable.

Ejemplos:

- Aventurero
- Colono
- Guerrero inicial
- Constructor
- Explorador
- Personajes predefinidos para campañas

---

# Información General

Todo Character podrá definir:

- ID único.
- Nombre.
- Descripción.
- Retrato.
- Modelo o escena.
- Icono.
- Etiquetas.

---

# Configuración Inicial

Un Character podrá definir:

## Estadísticas

- Stats Resource inicial.
- Vida inicial.
- Energía inicial.
- Hambre inicial.
- Sed inicial.

## Inventario

- Objetos iniciales.
- Equipamiento inicial.
- Moneda inicial.

## Profesiones

- Profession Resources disponibles.
- Profesión inicial.
- Profesiones bloqueadas.

## Habilidades

- Ability Resources iniciales.
- Árboles de habilidades disponibles.
- Talentos iniciales.

## Aparición

- Spawn inicial.
- Reino inicial.
- Facción inicial.

---

# Restricciones

El Character podrá definir:

- Profesiones permitidas.
- Equipamiento permitido.
- Habilidades restringidas.
- Buildings desbloqueados.
- Recipes iniciales.

---

# Personalización

Opcionalmente podrá definir:

- Apariencias disponibles.
- Colores.
- Peinados.
- Ropa inicial.
- Voz.
- Animaciones especiales.

La personalización visual será administrada por los Systems correspondientes.

---

# Responsabilidades

El Character Resource es responsable de:

- Definir un personaje inicial.
- Configurar equipamiento inicial.
- Configurar profesiones iniciales.
- Configurar habilidades iniciales.
- Referenciar otros Resources.

No es responsable de:

- Guardar progreso.
- Administrar inventarios.
- Gestionar experiencia.
- Ejecutar habilidades.
- Controlar movimiento.
- Resolver combate.

---

# Composición

Un Character podrá utilizar:

- Stats Resources.
- Profession Resources.
- Ability Resources.
- Item Resources.
- Equipment Resources.
- Faction Resources.
- Kingdom Resources.
- Recipe Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Character Resources serán utilizados por:

- Character System.
- Spawn System.
- Profession System.
- Inventory System.
- Equipment System.
- Save System.
- UI System.

Su función será proporcionar la configuración inicial de todos los personajes jugables.

---

# Rendimiento

Los Character Resources deberán:

- Compartirse entre múltiples partidas.
- Mantener únicamente información estática.
- Evitar configuraciones duplicadas.
- Ser completamente reutilizables.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos Character Resources.

Cada jugador mantendrá una instancia independiente cuyo estado será sincronizado por el Host o servidor dedicado.

---

# Convenciones

Todo Character deberá:

- Tener un ID único.
- Derivar conceptualmente de Entity Resource.
- Representar una única plantilla de personaje.
- No contener lógica.
- Ser completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Character Resource como una definición de datos.
- Evitar almacenar progreso del jugador.
- Favorecer la composición mediante otros Resources.
- Mantener la separación entre configuración inicial y estado dinámico.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas.
- Validar la separación entre plantilla y partida guardada.
- Detectar configuraciones duplicadas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para todos los personajes jugables, permitiendo definir configuraciones iniciales, profesiones, habilidades, equipamiento y restricciones mediante Resources reutilizables, desacoplados de la lógica del Character System y preparados para integrarse con el resto de la arquitectura de Survivors Lords.
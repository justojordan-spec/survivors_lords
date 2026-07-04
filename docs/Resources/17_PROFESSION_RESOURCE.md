# Profession Resource

**Estado:** Draft

---

# Objetivo

El Profession Resource define una profesión disponible dentro de Survivors Lords.

Su propósito es representar las habilidades, progresión, beneficios y restricciones de una profesión mediante una arquitectura completamente Data Driven.

No administra la experiencia ni el progreso del jugador.

---

# Filosofía

Una profesión representa un conjunto de conocimientos y habilidades especializadas.

El Profession Resource únicamente describe sus características.

La experiencia, niveles y progreso serán administrados por el Profession System y los Components correspondientes.

---

# Arquitectura

Cada Profession Resource representa una profesión independiente.

Ejemplos:

- Herrería.
- Carpintería.
- Agricultura.
- Cocina.
- Alquimia.
- Minería.
- Pesca.
- Caza.
- Construcción.

Cada profesión podrá desbloquear nuevas recetas, habilidades y ventajas.

---

# Información General

Toda Profession podrá definir:

- ID único.
- Nombre.
- Descripción.
- Icono.
- Categoría.
- Color representativo.
- Etiquetas.

---

# Configuración

Una profesión podrá definir:

## Progresión

- Nivel máximo.
- Experiencia requerida.
- Curva de progresión.
- Multiplicadores.

## Desbloqueos

- Recipe Resources.
- Ability Resources.
- Building Resources.
- Item Resources.

## Bonificaciones

- Velocidad de fabricación.
- Calidad de objetos.
- Consumo reducido de recursos.
- Probabilidad de éxito.
- Producción adicional.

## Restricciones

- Herramientas requeridas.
- Estaciones de trabajo.
- Profesiones compatibles.
- Profesiones incompatibles.

---

# Responsabilidades

El Profession Resource es responsable de:

- Definir una profesión.
- Configurar desbloqueos.
- Configurar bonificaciones.
- Describir restricciones.
- Servir como referencia para otros Systems.

No es responsable de:

- Gestionar experiencia.
- Subir niveles.
- Fabricar objetos.
- Ejecutar habilidades.
- Administrar inventarios.

---

# Composición

Una Profession podrá utilizar:

- Recipe Resources.
- Ability Resources.
- Building Resources.
- Item Resources.
- Stats Resources.
- Effect Resources.

Todos estos Resources serán opcionales.

---

# Integración con el resto del proyecto

Los Profession Resources serán utilizados por:

- Profession System.
- Crafting System.
- Building System.
- Ability System.
- Inventory System.
- UI System.

Su función será proporcionar la configuración base de cada profesión.

---

# Rendimiento

Los Profession Resources deberán:

- Compartirse entre todos los jugadores.
- Evitar datos redundantes.
- Mantener únicamente información estática.
- Ser completamente reutilizables.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos Profession Resources.

El progreso de cada profesión será sincronizado por el Host o servidor dedicado.

---

# Convenciones

Toda Profession deberá:

- Tener un ID único.
- Representar una única profesión.
- Mantener una estructura consistente.
- No contener lógica.
- Referenciar únicamente otros Resources.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Profession Resource como una definición de datos.
- Evitar lógica de progresión.
- Utilizar composición mediante otros Resources.
- Diseñar profesiones fácilmente extensibles.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas.
- Validar la separación entre datos y comportamiento.
- Identificar configuraciones duplicadas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para todas las profesiones del juego, permitiendo definir progresión, recetas, habilidades y bonificaciones mediante Resources reutilizables, desacoplados de la lógica del Profession System y preparados para integrarse con el resto de la arquitectura de Survivors Lords.
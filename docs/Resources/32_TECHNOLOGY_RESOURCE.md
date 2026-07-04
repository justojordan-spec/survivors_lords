# Technology Resource

**Estado:** Draft

---

# Objetivo

El Technology Resource define una tecnología investigable dentro de Survivors Lords.

Su propósito es representar avances tecnológicos que desbloquean nuevas capacidades, construcciones, recetas y mejoras mediante una arquitectura completamente Data Driven.

No administra el progreso de investigación ni ejecuta desbloqueos.

---

# Filosofía

Una tecnología representa un avance permanente del conocimiento.

El Technology Resource únicamente describe sus requisitos, costos y recompensas.

La investigación y el desbloqueo serán responsabilidad del Technology System y del Research System.

---

# Arquitectura

Todo Technology Resource deriva conceptualmente de Progression Resource.

Cada Resource representa una única tecnología.

Ejemplos:

- Herramientas de piedra.
- Agricultura.
- Metalurgia.
- Ingeniería.
- Navegación.
- Electricidad.
- Alquimia.
- Magia avanzada.
- Automatización.

---

# Información General

Toda Technology podrá definir:

- ID único.
- Nombre.
- Descripción.
- Icono.
- Categoría.
- Era tecnológica.
- Color representativo.
- Etiquetas.

---

# Requisitos

Una tecnología podrá requerir:

- Otras Technology Resources.
- Research Resources.
- Profession Resources.
- Nivel mínimo.
- Quest completadas.
- Eventos.
- Recursos especiales.

---

# Costos

La investigación podrá requerir:

- Puntos de investigación.
- Tiempo.
- Recursos.
- Moneda.
- Objetos específicos.

Todos los costos serán configurables.

---

# Desbloqueos

Una tecnología podrá desbloquear:

- Building Resources.
- Recipe Resources.
- Item Resources.
- Ability Resources.
- Profession Resources.
- Otras Technology Resources.

---

# Bonificaciones

Opcionalmente podrá otorgar:

- Buff Resources.
- Stats Resources.
- Multiplicadores de producción.
- Reducción de costos.
- Nuevas mecánicas.

---

# Responsabilidades

El Technology Resource es responsable de:

- Definir una tecnología.
- Configurar requisitos.
- Configurar costos.
- Configurar desbloqueos.
- Referenciar otros Resources.

No es responsable de:

- Investigar tecnologías.
- Administrar progreso.
- Consumir recursos.
- Ejecutar desbloqueos.
- Contener lógica.

---

# Composición

Una Technology podrá utilizar:

- Building Resources.
- Recipe Resources.
- Item Resources.
- Ability Resources.
- Buff Resources.
- Stats Resources.
- Research Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Technology Resources serán utilizados por:

- Technology System.
- Research System.
- Building System.
- Crafting System.
- Profession System.
- Save System.
- UI System.

Su función será proporcionar la configuración base de todas las tecnologías del juego.

---

# Rendimiento

Los Technology Resources deberán:

- Compartirse entre todas las partidas.
- Mantener únicamente información estática.
- Evitar configuraciones duplicadas.
- Ser completamente reutilizables.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos Technology Resources.

El progreso tecnológico será sincronizado por el Host o servidor dedicado.

---

# Convenciones

Toda Technology deberá:

- Tener un ID único.
- Derivar conceptualmente de Progression Resource.
- Representar una única tecnología.
- No contener lógica.
- Ser completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Technology Resource como una definición de datos.
- Evitar lógica de investigación.
- Favorecer composición mediante otros Resources.
- Diseñar tecnologías fácilmente extensibles.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas.
- Validar reutilización desde Progression Resource.
- Detectar configuraciones duplicadas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para todas las tecnologías del juego, permitiendo definir requisitos, costos, desbloqueos y bonificaciones mediante Resources reutilizables, desacoplados de la lógica del Technology System y preparados para soportar una progresión tecnológica escalable dentro de Survivors Lords.
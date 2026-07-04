# Research Resource

**Estado:** Draft

---

# Objetivo

El Research Resource define un proceso de investigación dentro de Survivors Lords.

Su propósito es describir los requisitos, costos, condiciones y métodos necesarios para completar una investigación mediante una arquitectura completamente Data Driven.

No administra el progreso de la investigación ni ejecuta desbloqueos.

---

# Filosofía

Una investigación representa el proceso necesario para adquirir conocimiento.

El Research Resource únicamente describe dicho proceso.

El progreso será administrado por el Research System.

Una vez completada, la investigación podrá desbloquear una o varias Technology Resources.

---

# Arquitectura

Cada Research Resource representa una investigación independiente.

Ejemplos:

- Estudiar Metalurgia
- Analizar Cristales
- Investigación Agrícola
- Experimentación Alquímica
- Ingeniería Avanzada
- Runas Antiguas
- Navegación Oceánica

---

# Información General

Toda Research podrá definir:

- ID único.
- Nombre.
- Descripción.
- Icono.
- Categoría.
- Complejidad.
- Etiquetas.

---

# Configuración

## Tiempo

La investigación podrá definir:

- Tiempo base.
- Tiempo mínimo.
- Tiempo máximo.
- Modificadores.

---

## Costos

Podrá requerir:

- Recursos.
- Objetos.
- Moneda.
- Energía.
- Puntos de investigación.

Todos los costos serán configurables.

---

## Requisitos

Una investigación podrá requerir:

- Profession Resources.
- Technology Resources.
- Building Resources.
- Quest Resources.
- Eventos.
- Reputación.
- Nivel mínimo.

---

## Lugar

Podrá requerir:

- Laboratorio.
- Biblioteca.
- Taller.
- Estación especial.
- Edificio específico.

---

# Resultados

Al completarse podrá:

- Desbloquear Technology Resources.
- Otorgar Ability Resources.
- Desbloquear Recipe Resources.
- Activar Event Resources.
- Otorgar experiencia.

---

# Responsabilidades

El Research Resource es responsable de:

- Definir una investigación.
- Configurar costos.
- Configurar requisitos.
- Configurar resultados.
- Referenciar otros Resources.

No es responsable de:

- Administrar progreso.
- Consumir recursos.
- Ejecutar desbloqueos.
- Ejecutar lógica.

---

# Composición

Una Research podrá utilizar:

- Technology Resources.
- Building Resources.
- Profession Resources.
- Recipe Resources.
- Ability Resources.
- Event Resources.
- Quest Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Research Resources serán utilizados por:

- Research System.
- Technology System.
- Building System.
- Profession System.
- Quest System.
- Save System.

Su función será proporcionar la configuración de todos los procesos de investigación del juego.

---

# Rendimiento

Los Research Resources deberán:

- Compartirse entre todas las partidas.
- Mantener únicamente datos estáticos.
- Evitar configuraciones duplicadas.
- Ser completamente reutilizables.

---

# Multiplayer

Todos los participantes deberán utilizar exactamente los mismos Research Resources.

El progreso de las investigaciones será sincronizado por el Host o servidor dedicado.

---

# Convenciones

Toda Research deberá:

- Tener un ID único.
- Representar una única investigación.
- No contener lógica.
- Ser completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Research Resource como una definición de datos.
- Evitar lógica de investigación.
- Separar claramente investigación y tecnología.
- Favorecer composición mediante otros Resources.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar referencias correctas.
- Detectar configuraciones duplicadas.
- Validar la separación entre Research y Technology.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para todos los procesos de investigación del juego, permitiendo definir requisitos, costos, tiempos y resultados mediante Resources reutilizables, desacoplados de la lógica del Research System y preparados para integrarse con el sistema tecnológico de Survivors Lords.
# Profession System

**Estado:** Draft

---

# Objetivo

El Profession System es responsable de administrar todas las profesiones de Survivors Lords.

Su propósito es gestionar la asignación, progresión, especialización y desempeño de las profesiones disponibles para las entidades del juego.

No administra economía, tecnologías ni habilidades.

---

# Filosofía

Las profesiones representan el rol laboral de una entidad dentro del mundo.

El Profession System administra exclusivamente la relación entre las entidades y sus profesiones.

Toda la configuración será completamente Data Driven mediante Profession Resources.

---

# Responsabilidades

El Profession System será responsable de:

- Asignar profesiones.
- Cambiar profesiones.
- Validar requisitos.
- Gestionar experiencia profesional.
- Gestionar niveles de profesión.
- Administrar especializaciones.
- Calcular bonificaciones profesionales.
- Notificar cambios de profesión.

---

# No es responsable de

El Profession System NO debe:

- Ejecutar trabajos.
- Administrar economía.
- Resolver crafting.
- Gestionar tecnologías.
- Ejecutar IA.
- Administrar inventarios.
- Gestionar interfaz.

Estas responsabilidades pertenecen a sus respectivos Systems.

---

# Profesiones

El sistema podrá administrar profesiones como:

- Constructor.
- Agricultor.
- Minero.
- Herrero.
- Carpintero.
- Cazador.
- Comerciante.
- Investigador.
- Soldado.
- Médico.

---

# Progresión

Cada profesión podrá definir:

- Nivel.
- Experiencia.
- Especializaciones.
- Bonificaciones.
- Requisitos.
- Tecnologías asociadas.

---

# Especialización

Las profesiones podrán evolucionar mediante:

- Experiencia.
- Investigación.
- Tecnologías.
- Entrenamiento.
- Eventos.

---

# Comunicación

El Profession System se comunicará mediante:

- Eventos.
- Interfaces.
- Consultas.

Nunca modificará directamente otros Systems.

---

# Integración

Trabajará junto a:

- Player System.
- Settlement System.
- Building System.
- Crafting System.
- Economy System.
- Research System.
- Technology System.
- Resource System.
- Time System.
- UI System.
- Multiplayer System.

---

# Multiplayer

El servidor será la autoridad sobre las profesiones y su progresión.

Los clientes únicamente recibirán el estado sincronizado de cada entidad.

---

# Rendimiento

El Profession System deberá:

- Procesar únicamente entidades con profesión.
- Compartir Profession Resources.
- Evitar cálculos repetidos.
- Minimizar consultas innecesarias.
- Mantener una simulación determinista.

---

# Eventos

Ejemplos:

- ProfessionAssigned
- ProfessionChanged
- ProfessionLevelUp
- ProfessionUnlocked
- ProfessionRemoved
- ProfessionExperienceGained

---

# Convenciones

Toda profesión deberá:

- Referenciar un Profession Resource.
- Tener un identificador único.
- Poder serializarse.
- Mantener consistencia entre cliente y servidor.
- Ser determinista.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Profession System desacoplado del Crafting System.
- Configurar todas las profesiones mediante Profession Resources.
- Gestionar experiencia profesional de forma independiente.
- Utilizar eventos para comunicar cambios.
- Evitar lógica específica de cada profesión dentro del sistema.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar dependencias innecesarias.
- Verificar progresión profesional.
- Detectar duplicación de lógica.
- Validar sincronización multijugador.
- Revisar rendimiento del sistema.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado encargado de administrar todas las profesiones del juego, gestionando su asignación, progresión y especialización mediante una arquitectura ECS, Data Driven y completamente desacoplada.

---

# DEC propuesta

## DEC – El Profession System administrará únicamente las profesiones

### Decisión

El Profession System será responsable exclusivamente de la asignación y progresión de las profesiones. La ejecución de trabajos y actividades específicas será responsabilidad de los Systems correspondientes, como Building System, Crafting System o Economy System.

### Justificación

- Mantiene el principio de responsabilidad única.
- Evita acoplamiento entre profesiones y gameplay.
- Facilita la incorporación de nuevas profesiones.
- Mejora la reutilización y mantenimiento del sistema.
- Refuerza la arquitectura ECS y Data Driven.
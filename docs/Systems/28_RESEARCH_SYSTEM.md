# Research System

**Estado:** Draft

---

# Objetivo

El Research System es responsable de administrar toda la investigación y el progreso científico de Survivors Lords.

Su propósito es gestionar proyectos de investigación, descubrimientos y desbloqueos de conocimiento mediante una arquitectura ECS, modular y completamente Data Driven.

No administra tecnologías, economía ni profesiones.

---

# Filosofía

La investigación representa el progreso intelectual de un reino, asentamiento o facción.

El Research System administra exclusivamente el avance de las investigaciones y sus requisitos.

Toda la configuración será completamente Data Driven mediante Research Resources.

---

# Responsabilidades

El Research System será responsable de:

- Iniciar investigaciones.
- Cancelar investigaciones.
- Completar investigaciones.
- Administrar progreso.
- Validar requisitos.
- Gestionar tiempos de investigación.
- Desbloquear nuevos conocimientos.
- Notificar cambios de estado.

---

# No es responsable de

El Research System NO debe:

- Administrar tecnologías.
- Ejecutar crafting.
- Gestionar economía.
- Administrar profesiones.
- Resolver combate.
- Administrar interfaz.

Estas responsabilidades pertenecen a sus respectivos Systems.

---

# Tipos de Investigación

El sistema podrá administrar:

- Investigación militar.
- Investigación agrícola.
- Investigación industrial.
- Investigación científica.
- Investigación mágica.
- Investigación social.
- Investigación económica.

---

# Requisitos

Cada investigación podrá requerir:

- Recursos.
- Tiempo.
- Edificios.
- Profesiones.
- Tecnologías previas.
- Nivel del asentamiento.
- Eventos específicos.

---

# Resultados

Una investigación podrá desbloquear:

- Tecnologías.
- Edificios.
- Recetas.
- Profesiones.
- Bonificaciones.
- Eventos.
- Mejoras globales.

---

# Comunicación

El Research System se comunicará mediante:

- Eventos.
- Interfaces.
- Consultas.

Nunca modificará directamente otros Systems.

---

# Integración

Trabajará junto a:

- Technology System.
- Settlement System.
- Building System.
- Profession System.
- Economy System.
- Resource System.
- Time System.
- Event System.
- UI System.
- Multiplayer System.

---

# Multiplayer

El servidor será la autoridad sobre todas las investigaciones.

Los clientes recibirán únicamente el progreso sincronizado.

---

# Rendimiento

El Research System deberá:

- Procesar únicamente investigaciones activas.
- Compartir Research Resources.
- Evitar cálculos repetidos.
- Minimizar consultas innecesarias.
- Mantener una simulación determinista.

---

# Eventos

Ejemplos:

- ResearchStarted
- ResearchCompleted
- ResearchCancelled
- ResearchUnlocked
- ResearchProgressUpdated

---

# Convenciones

Toda investigación deberá:

- Referenciar un Research Resource.
- Tener un identificador único.
- Poder serializarse.
- Mantener consistencia entre cliente y servidor.
- Ser determinista.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Research System desacoplado del Technology System.
- Configurar todas las investigaciones mediante Research Resources.
- Utilizar eventos para comunicar el progreso.
- Evitar lógica específica para cada investigación.
- Favorecer una arquitectura orientada a eventos.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar dependencias innecesarias.
- Verificar progresión de investigaciones.
- Detectar lógica duplicada.
- Validar sincronización multijugador.
- Revisar rendimiento del sistema.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado encargado de administrar toda la investigación del juego, coordinando el progreso científico y el desbloqueo de conocimientos mediante una arquitectura ECS, Data Driven y completamente desacoplada.

---

# DEC propuesta

## DEC – El Research System administrará únicamente la investigación

### Decisión

El Research System será responsable exclusivamente del progreso y finalización de investigaciones. Los desbloqueos tecnológicos serán gestionados por el Technology System y el resto de las consecuencias serán aplicadas por los Systems correspondientes.

### Justificación

- Mantiene el principio de responsabilidad única.
- Evita acoplamiento entre investigación y tecnologías.
- Facilita la incorporación de nuevas ramas de investigación.
- Mejora la escalabilidad del sistema.
- Refuerza la arquitectura ECS y Data Driven.
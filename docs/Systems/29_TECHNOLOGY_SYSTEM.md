# Technology System

**Estado:** Draft

---

# Objetivo

El Technology System es responsable de administrar todas las tecnologías disponibles en Survivors Lords.

Su propósito es gestionar el desbloqueo, disponibilidad y efectos permanentes de las tecnologías que impulsan el progreso del juego.

No administra el proceso de investigación ni la ejecución de otras mecánicas de gameplay.

---

# Filosofía

Las tecnologías representan conocimientos permanentes adquiridos por el jugador, un asentamiento o un reino.

El Technology System administra exclusivamente las tecnologías desbloqueadas y sus efectos.

Toda la configuración será completamente Data Driven mediante Technology Resources.

---

# Responsabilidades

El Technology System será responsable de:

- Registrar tecnologías.
- Desbloquear tecnologías.
- Bloquear tecnologías cuando corresponda.
- Validar requisitos tecnológicos.
- Gestionar dependencias entre tecnologías.
- Administrar efectos permanentes.
- Notificar cambios tecnológicos.

---

# No es responsable de

El Technology System NO debe:

- Administrar investigaciones.
- Ejecutar crafting.
- Construir edificios.
- Gestionar profesiones.
- Resolver combate.
- Administrar economía.
- Gestionar interfaz.

Estas responsabilidades pertenecen a sus respectivos Systems.

---

# Tipos de Tecnologías

El sistema podrá administrar:

- Tecnologías militares.
- Tecnologías agrícolas.
- Tecnologías industriales.
- Tecnologías científicas.
- Tecnologías sociales.
- Tecnologías económicas.
- Tecnologías especiales.

---

# Requisitos

Cada tecnología podrá requerir:

- Investigaciones previas.
- Tecnologías anteriores.
- Nivel del asentamiento.
- Nivel del reino.
- Eventos específicos.
- Recursos especiales.

---

# Efectos

Una tecnología podrá desbloquear:

- Nuevos edificios.
- Nuevas recetas.
- Nuevas profesiones.
- Nuevas habilidades.
- Mejoras permanentes.
- Bonificaciones globales.
- Contenido adicional.

---

# Comunicación

El Technology System se comunicará mediante:

- Eventos.
- Interfaces.
- Consultas.

Nunca modificará directamente otros Systems.

---

# Integración

Trabajará junto a:

- Research System.
- Building System.
- Crafting System.
- Profession System.
- Economy System.
- Kingdom System.
- Settlement System.
- Resource System.
- Event System.
- UI System.
- Multiplayer System.

---

# Multiplayer

El servidor será la autoridad sobre todas las tecnologías desbloqueadas.

Los clientes recibirán únicamente el estado sincronizado correspondiente.

---

# Rendimiento

El Technology System deberá:

- Procesar únicamente tecnologías relevantes.
- Compartir Technology Resources.
- Evitar validaciones repetidas.
- Minimizar consultas innecesarias.
- Mantener una simulación determinista.

---

# Eventos

Ejemplos:

- TechnologyUnlocked
- TechnologyLocked
- TechnologyUpdated
- TechnologyRequirementMet
- TechnologyTreeUpdated

---

# Convenciones

Toda tecnología deberá:

- Referenciar un Technology Resource.
- Tener un identificador único.
- Poder serializarse.
- Mantener consistencia entre cliente y servidor.
- Ser determinista.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Technology System desacoplado del Research System.
- Configurar todas las tecnologías mediante Technology Resources.
- Gestionar dependencias mediante un árbol tecnológico.
- Utilizar eventos para comunicar cambios.
- Evitar lógica específica para cada tecnología.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar dependencias circulares.
- Verificar requisitos tecnológicos.
- Detectar desbloqueos incorrectos.
- Validar sincronización multijugador.
- Revisar rendimiento del sistema.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado encargado de administrar todas las tecnologías del juego, coordinando su desbloqueo, disponibilidad y efectos permanentes mediante una arquitectura ECS, Data Driven y completamente desacoplada.

---

# DEC propuesta

## DEC – El Technology System administrará únicamente las tecnologías

### Decisión

El Technology System será responsable exclusivamente del estado y los efectos permanentes de las tecnologías. El progreso de investigación será responsabilidad del Research System y las consecuencias específicas serán aplicadas por los Systems correspondientes.

### Justificación

- Mantiene el principio de responsabilidad única.
- Separa claramente investigación y tecnología.
- Facilita la ampliación del árbol tecnológico.
- Mejora la mantenibilidad del sistema.
- Refuerza la arquitectura ECS y Data Driven.
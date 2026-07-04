# Dialogue Resource

**Estado:** Draft

---

# Objetivo

El Dialogue Resource define una conversación reutilizable dentro de Survivors Lords.

Su propósito es describir la estructura, flujo y condiciones de un diálogo mediante una arquitectura completamente Data Driven, permitiendo que el Dialogue System interprete su contenido sin lógica codificada.

No controla directamente la interfaz de usuario ni ejecuta acciones del juego.

---

# Filosofía

Un diálogo representa una conversación entre el jugador y una o más Entities.

El Dialogue Resource únicamente describe la conversación.

La navegación, presentación y ejecución de consecuencias serán responsabilidad del Dialogue System.

---

# Arquitectura

Cada Dialogue Resource representa una conversación independiente.

Podrá estar compuesto por múltiples nodos conectados entre sí.

Cada nodo podrá contener:

- Texto.
- Opciones.
- Condiciones.
- Acciones.
- Referencias a otros diálogos.

---

# Información General

Todo Dialogue podrá definir:

- ID único.
- Nombre.
- Descripción.
- NPC asociado.
- Categoría.
- Idioma.
- Etiquetas.

---

# Estructura

Cada diálogo podrá contener:

## Nodos

- Texto principal.
- Retrato.
- Emoción.
- Animación.
- Audio.

## Opciones

- Respuesta del jugador.
- Condiciones.
- Nodo siguiente.
- Finalización del diálogo.

## Acciones

- Iniciar Quest.
- Completar Quest.
- Entregar Item.
- Recibir Item.
- Modificar reputación.
- Ejecutar Event.
- Activar Cinemática.

---

# Condiciones

Un nodo podrá depender de:

- Quest activa.
- Quest completada.
- Facción.
- Reputación.
- Nivel.
- Profesión.
- Inventario.
- Hora del día.
- Evento activo.
- Variables del mundo.

---

# Responsabilidades

El Dialogue Resource es responsable de:

- Definir conversaciones.
- Organizar nodos.
- Configurar opciones.
- Describir condiciones.
- Referenciar acciones.

No es responsable de:

- Mostrar UI.
- Ejecutar lógica.
- Modificar inventarios.
- Gestionar cámaras.
- Controlar animaciones.

---

# Composición

Un Dialogue podrá utilizar:

- Quest Resources.
- Item Resources.
- Event Resources.
- Faction Resources.
- World Resources.

Todos ellos serán opcionales.

---

# Integración con el resto del proyecto

Los Dialogue Resources serán utilizados por:

- Dialogue System.
- Quest System.
- UI System.
- World System.
- NPCs.

Su función será proporcionar el contenido y la estructura de las conversaciones.

---

# Rendimiento

Los Dialogue Resources deberán:

- Compartirse entre múltiples NPCs.
- Evitar duplicación de textos.
- Mantener únicamente información estática.
- Ser completamente reutilizables.

---

# Multiplayer

Los diálogos deberán sincronizar únicamente las decisiones relevantes cuando afecten al estado compartido del mundo.

La presentación del diálogo será local para cada cliente.

---

# Convenciones

Todo Dialogue deberá:

- Tener un ID único.
- Mantener una estructura basada en nodos.
- No contener lógica de ejecución.
- Utilizar referencias a otros Resources.
- Ser completamente reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Resource como una definición de datos.
- Evitar lógica dentro del diálogo.
- Favorecer estructuras modulares basadas en nodos.
- Utilizar referencias a otros Resources para las consecuencias.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del Resource.
- Verificar la estructura de nodos.
- Validar referencias a Quests, Items y Facciones.
- Identificar diálogos duplicados o inconsistentes.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de una representación completamente Data Driven para todas las conversaciones del juego, permitiendo crear diálogos complejos, ramificados y reutilizables mediante nodos y referencias a otros Resources, desacoplados de la lógica del sistema de diálogo.
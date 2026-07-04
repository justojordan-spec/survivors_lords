# UI System

**Estado:** Draft

---

# Objetivo

El UI System es responsable de administrar toda la interfaz de usuario de Survivors Lords.

Su propósito es presentar información al jugador, gestionar la interacción con la interfaz y coordinar los distintos elementos visuales sin implementar lógica de gameplay.

No administra datos del juego.

---

# Filosofía

El UI System será la única capa responsable de mostrar información al jugador.

Los demás Systems enviarán datos, eventos o solicitudes, pero nunca modificarán directamente los elementos de la interfaz.

Toda la interfaz deberá ser modular, escalable y desacoplada del gameplay.

---

# Responsabilidades

El UI System será responsable de:

- Administrar ventanas.
- Administrar HUD.
- Gestionar menús.
- Mostrar notificaciones.
- Mostrar información contextual.
- Administrar diálogos.
- Gestionar cursores.
- Administrar overlays.
- Coordinar animaciones de UI.

---

# No es responsable de

El UI System NO debe:

- Administrar inventarios.
- Ejecutar combate.
- Procesar entradas directamente.
- Gestionar economía.
- Administrar entidades.
- Resolver lógica de quests.
- Modificar datos del juego.

Estas responsabilidades pertenecen a sus respectivos Systems.

---

# Elementos de UI

El sistema podrá administrar:

- HUD.
- Inventario.
- Barra de salud.
- Barra de energía.
- Barra de experiencia.
- Minimapa.
- Mapa mundial.
- Menú principal.
- Menú de pausa.
- Configuración.
- Diálogos.
- Comercio.
- Construcción.
- Árbol tecnológico.

---

# HUD

El HUD podrá mostrar:

- Vida.
- Energía.
- Hambre.
- Sed.
- Recursos.
- Objetivos.
- Hora.
- Clima.
- Estado del jugador.

---

# Ventanas

El sistema permitirá:

- Abrir ventanas.
- Cerrar ventanas.
- Apilar ventanas.
- Priorizar ventanas.
- Bloquear interacción cuando corresponda.

---

# Comunicación

El UI System se comunicará mediante:

- Eventos.
- Interfaces.
- Consultas.

Nunca accederá directamente al estado interno de otros Systems.

---

# Integración

Trabajará junto a:

- Input System.
- Player System.
- Inventory System.
- Building System.
- Combat System.
- Quest System.
- Time System.
- Weather System.
- Economy System.
- Technology System.
- Research System.
- Multiplayer System.

---

# Multiplayer

La interfaz será completamente local para cada jugador.

El UI System únicamente mostrará información sincronizada proveniente del servidor.

---

# Rendimiento

El UI System deberá:

- Actualizar únicamente elementos modificados.
- Evitar reconstrucciones innecesarias.
- Reutilizar ventanas.
- Minimizar operaciones de dibujo.
- Mantener una interfaz fluida.

---

# Eventos

Ejemplos:

- WindowOpened
- WindowClosed
- HUDUpdated
- NotificationDisplayed
- TooltipShown
- DialogueStarted
- DialogueFinished

---

# Convenciones

Toda interfaz deberá:

- Ser modular.
- Ser reutilizable.
- Adaptarse a distintas resoluciones.
- Soportar localización.
- Mantener consistencia visual.

---

# Consideraciones para Claude

Al generar código:

- Mantener separación entre UI y Gameplay.
- Utilizar eventos para actualizar la interfaz.
- Evitar referencias directas entre Widgets.
- Favorecer componentes reutilizables.
- Mantener soporte para escalado de resolución.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar lógica de gameplay dentro de la UI.
- Verificar actualizaciones innecesarias.
- Detectar dependencias entre ventanas.
- Validar rendimiento.
- Revisar consistencia de navegación.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado encargado de administrar toda la interfaz de usuario del juego, proporcionando una experiencia consistente, modular y desacoplada de la lógica de gameplay.

---

# DEC propuesta

## DEC – La UI será una capa de presentación desacoplada del gameplay

### Decisión

El UI System actuará exclusivamente como una capa de presentación. Ningún elemento de la interfaz contendrá lógica de negocio; toda la información será obtenida mediante eventos, interfaces o consultas a los Systems correspondientes.

### Justificación

- Mantiene separadas la presentación y la lógica del juego.
- Facilita el mantenimiento y la reutilización de la interfaz.
- Permite reemplazar o ampliar la UI sin modificar los Systems.
- Reduce el acoplamiento entre gameplay e interfaz.
- Refuerza la arquitectura ECS y Data Driven.
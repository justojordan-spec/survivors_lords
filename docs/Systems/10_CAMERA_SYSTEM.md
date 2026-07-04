# Camera System

**Estado:** Draft

---

# Objetivo

El Camera System es responsable de administrar el comportamiento de la cámara del jugador dentro de Survivors Lords.

Su propósito es proporcionar una experiencia visual cómoda, fluida y adaptable a las distintas situaciones del juego, manteniendo siempre una visión clara del entorno y del personaje.

No implementa lógica de gameplay.

---

# Filosofía

La cámara debe ayudar al jugador, nunca convertirse en un obstáculo.

Debe adaptarse automáticamente a las distintas situaciones del juego, ofreciendo una visión óptima durante la exploración, el combate, la construcción y otras actividades.

El Camera System será completamente independiente del movimiento del jugador.

---

# Responsabilidades

El Camera System será responsable de:

- Administrar la posición de la cámara.
- Administrar la rotación.
- Gestionar el zoom.
- Gestionar la distancia al jugador.
- Detectar colisiones.
- Aplicar suavizado de movimientos.
- Gestionar distintos modos de cámara.
- Administrar el campo de visión (FOV).
- Adaptar la cámara según el contexto de juego.

---

# No es responsable de

El Camera System NO debe:

- Mover al jugador.
- Procesar entradas del usuario.
- Ejecutar combate.
- Administrar UI.
- Gestionar clima.
- Administrar tiempo.
- Ejecutar IA.

Estas responsabilidades pertenecen a sus respectivos Systems.

---

# Modos de Cámara

El sistema podrá soportar:

- Tercera persona.
- Cámara libre.
- Cámara de construcción.
- Cámara cinemática.
- Modo fotografía.
- Cámara de espectador.

---

# Movimiento

La cámara podrá:

- Rotar horizontalmente.
- Rotar verticalmente.
- Hacer zoom.
- Seguir automáticamente al jugador.
- Ajustar distancia dinámicamente.

Todos los movimientos deberán ser suaves.

---

# Colisiones

La cámara nunca deberá atravesar objetos sólidos.

Cuando exista un obstáculo:

- Ajustará automáticamente su posición.
- Mantendrá visible al jugador.
- Recuperará su posición original cuando sea posible.

---

# Adaptación Contextual

El Camera System podrá modificar automáticamente su comportamiento durante:

- Exploración.
- Combate.
- Construcción.
- Diálogos.
- Cinemáticas.
- Vehículos.
- Monturas.

---

# Configuración

El jugador podrá configurar:

- Sensibilidad horizontal.
- Sensibilidad vertical.
- Invertir eje Y.
- Distancia.
- Zoom.
- Campo de visión (FOV).
- Suavizado.

---

# Comunicación

El Camera System se comunicará mediante:

- Eventos.
- Interfaces.
- Consultas.

Nunca accederá directamente al estado interno de otros Systems.

---

# Integración

Trabajará junto a:

- Input System.
- Player System.
- Combat System.
- Building System.
- World System.
- UI System.
- Time System.
- Weather System.
- Multiplayer System.

---

# Multiplayer

La cámara será completamente local para cada jugador.

No será sincronizada entre clientes, salvo modos especiales como espectador o cámaras compartidas.

---

# Rendimiento

El Camera System deberá:

- Mantener actualización fluida.
- Reducir comprobaciones de colisión.
- Minimizar cálculos innecesarios.
- Mantener interpolaciones suaves.
- Evitar asignaciones de memoria por frame.

---

# Eventos

Ejemplos:

- CameraModeChanged
- CameraZoomChanged
- CameraCollisionDetected
- CameraTargetChanged
- CameraReset

---

# Convenciones

Toda cámara deberá:

- Mantener al jugador visible.
- Evitar atravesar geometría.
- Adaptarse al contexto.
- Mantener una experiencia cómoda.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Camera System independiente del Player System.
- Obtener entradas únicamente mediante el Input System.
- Implementar interpolaciones suaves.
- Optimizar detección de colisiones.
- Permitir añadir nuevos modos de cámara sin modificar la arquitectura.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar acoplamiento con Player System.
- Verificar integración con Input System.
- Detectar movimientos bruscos.
- Validar la gestión de colisiones.
- Revisar rendimiento del sistema.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema independiente encargado de administrar el comportamiento completo de la cámara, proporcionando una experiencia visual cómoda, adaptable y desacoplada del resto de la lógica del juego.

---

# DEC propuesta

## DEC – El Camera System será independiente del movimiento del jugador

### Decisión

El Camera System administrará exclusivamente el comportamiento de la cámara. El movimiento del jugador será responsabilidad del Player System y las entradas serán procesadas únicamente por el Input System.

### Justificación

- Reduce el acoplamiento.
- Facilita nuevos modos de cámara.
- Simplifica el mantenimiento.
- Mejora la reutilización del sistema.
- Mantiene la arquitectura ECS y Data Driven.
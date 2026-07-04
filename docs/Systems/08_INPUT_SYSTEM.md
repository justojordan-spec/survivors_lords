# Input System

**Estado:** Draft

---

# Objetivo

El Input System es responsable de capturar, procesar y distribuir todas las entradas del usuario dentro de Survivors Lords.

Su propósito es abstraer los dispositivos físicos de entrada y proporcionar acciones de alto nivel al resto de los Systems.

No implementa lógica de gameplay.

---

# Filosofía

El Input System representa la única fuente de entrada del jugador.

Los Gameplay Systems nunca deberán consultar directamente el teclado, mouse, gamepad u otros dispositivos.

Toda interacción del usuario será traducida a acciones abstractas.

---

# Responsabilidades

El Input System será responsable de:

- Capturar entradas.
- Procesar eventos de entrada.
- Administrar Action Maps.
- Gestionar Input Contexts.
- Gestionar múltiples dispositivos.
- Administrar remapeo de controles.
- Detectar cambios de dispositivo.
- Distribuir acciones al resto del juego.

---

# No es responsable de

El Input System NO debe:

- Mover personajes.
- Disparar armas.
- Abrir inventarios.
- Ejecutar habilidades.
- Administrar cámaras.
- Controlar UI.
- Resolver combate.

Estas acciones pertenecen a otros Systems.

---

# Dispositivos soportados

El sistema podrá trabajar con:

- Teclado.
- Mouse.
- Gamepad.
- Joystick.
- Pantallas táctiles.
- Dispositivos futuros.

---

# Action Maps

Ejemplos:

## Gameplay

- Move
- Jump
- Sprint
- Attack
- Block
- Interact
- Use Item
- Equip

---

## UI

- Confirm
- Cancel
- Navigate
- Pause
- Inventory
- Map

---

## Construcción

- Place Building
- Rotate Building
- Cancel Placement

---

## Debug

- Free Camera
- Spawn
- Reload
- Console

---

# Input Contexts

El sistema permitirá activar distintos contextos.

Ejemplos:

- Gameplay
- UI
- Inventory
- Dialogue
- Building
- Photo Mode
- Debug

Solo los contextos activos recibirán entradas.

---

# Comunicación

Los demás Systems recibirán acciones del Input System mediante:

- Eventos.
- Interfaces.
- Comandos.

Nunca leerán directamente los dispositivos.

---

# Integración

Será utilizado por:

- Player System.
- Camera System.
- Combat System.
- Inventory System.
- Building System.
- UI System.
- Dialogue System.
- Multiplayer System.

---

# Multiplayer

El Input System únicamente procesa entradas locales.

Las acciones serán enviadas al Multiplayer System para su validación y sincronización.

---

# Rendimiento

El Input System deberá:

- Tener baja latencia.
- Procesar entradas cada frame.
- Evitar duplicación de eventos.
- Minimizar asignaciones de memoria.

---

# Eventos

Ejemplos:

- InputPressed
- InputReleased
- InputHeld
- DeviceChanged
- ContextChanged

---

# Convenciones

Toda acción deberá:

- Tener un identificador único.
- Ser independiente del dispositivo.
- Poder remapearse.
- Ser reutilizable.

---

# Consideraciones para Claude

Al generar código:

- Mantener separación entre dispositivos y acciones.
- Favorecer Action Maps.
- Implementar Input Contexts.
- Evitar dependencias con Gameplay Systems.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar acceso directo al teclado o mouse.
- Verificar separación entre acciones y dispositivos.
- Detectar duplicación de entradas.
- Validar soporte para remapeo.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema único encargado de capturar y distribuir todas las entradas del usuario mediante acciones abstractas, desacoplando completamente los dispositivos físicos de la lógica del juego y facilitando el soporte para múltiples plataformas y métodos de control.
# Audio System

**Estado:** Draft

---

# Objetivo

El Audio System es responsable de administrar todo el audio de Survivors Lords.

Su propósito es reproducir, controlar y sincronizar efectos de sonido, música y audio ambiental, proporcionando una experiencia inmersiva sin interferir con la lógica de gameplay.

No implementa reglas del juego.

---

# Filosofía

El Audio System será la única fuente responsable de la reproducción de audio.

Los demás Systems únicamente solicitarán la reproducción, modificación o detención de sonidos mediante eventos o interfaces.

Toda la configuración del audio será Data Driven mediante Resources.

---

# Responsabilidades

El Audio System será responsable de:

- Reproducir efectos de sonido.
- Reproducir música.
- Reproducir audio ambiental.
- Administrar audio espacial (3D).
- Gestionar mezcladores (Mixers).
- Controlar volumen.
- Administrar canales de audio.
- Gestionar transiciones musicales.
- Administrar prioridades de reproducción.

---

# No es responsable de

El Audio System NO debe:

- Ejecutar combate.
- Administrar animaciones.
- Controlar la cámara.
- Procesar entradas del jugador.
- Administrar UI.
- Gestionar tiempo.
- Ejecutar IA.

Estas responsabilidades pertenecen a sus respectivos Systems.

---

# Tipos de Audio

El sistema podrá administrar:

- Música.
- Efectos de sonido (SFX).
- Audio ambiental.
- Voces.
- Audio de interfaz.
- Audio de cinemáticas.

---

# Audio Espacial

El sistema soportará:

- Sonido 2D.
- Sonido 3D.
- Atenuación por distancia.
- Oclusión.
- Dirección del sonido.
- Prioridad por proximidad.

---

# Mezcladores

El sistema permitirá controlar grupos independientes como:

- Master.
- Música.
- Efectos.
- Ambiente.
- Voces.
- UI.

---

# Configuración

El jugador podrá configurar:

- Volumen general.
- Volumen de música.
- Volumen de efectos.
- Volumen ambiental.
- Volumen de voces.
- Dispositivo de salida.

---

# Comunicación

El Audio System se comunicará mediante:

- Eventos.
- Interfaces.
- Consultas.

Nunca accederá directamente al estado interno de otros Systems.

---

# Integración

Trabajará junto a:

- Event System.
- UI System.
- Combat System.
- Building System.
- Player System.
- Weather System.
- Time System.
- World System.
- Multiplayer System.

---

# Multiplayer

La reproducción del audio será local para cada cliente.

Únicamente se sincronizarán los eventos que requieran generar sonido, nunca el estado interno del sistema de audio.

---

# Rendimiento

El Audio System deberá:

- Reutilizar fuentes de audio.
- Limitar sonidos simultáneos.
- Priorizar sonidos cercanos.
- Evitar reproducciones duplicadas.
- Minimizar consumo de memoria.

---

# Eventos

Ejemplos:

- MusicStarted
- MusicStopped
- SoundPlayed
- SoundStopped
- AmbientChanged
- VolumeChanged

---

# Convenciones

Todo audio deberá:

- Referenciar un Audio Resource.
- Poder reproducirse mediante eventos.
- Respetar la configuración del usuario.
- Mantener consistencia entre escenas.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Audio System desacoplado del gameplay.
- Utilizar eventos para reproducir sonidos.
- Implementar Audio Pooling cuando sea posible.
- Separar claramente música, efectos y ambiente.
- Optimizar la reproducción de audio 3D.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar reproducción duplicada de sonidos.
- Verificar uso correcto de eventos.
- Detectar fugas de Audio Sources.
- Validar la gestión de mezcladores.
- Revisar rendimiento del sistema.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado encargado de administrar toda la reproducción de audio del juego, proporcionando una experiencia inmersiva, escalable y completamente desacoplada de la lógica de gameplay.

---

# DEC propuesta

## DEC – El Audio System será la única capa responsable de la reproducción de sonido

### Decisión

Toda reproducción de música, efectos de sonido y audio ambiental será gestionada exclusivamente por el Audio System. Los demás Systems emitirán eventos o solicitudes, sin acceder directamente a las APIs de audio.

### Justificación

- Centraliza toda la gestión del audio.
- Reduce el acoplamiento entre Systems.
- Facilita la optimización y reutilización de recursos.
- Simplifica la incorporación de nuevas categorías de audio.
- Mantiene la arquitectura ECS y Data Driven.
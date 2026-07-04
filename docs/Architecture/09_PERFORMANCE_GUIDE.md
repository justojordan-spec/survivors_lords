# Survivors Lords

# PERFORMANCE GUIDE

Versión: 1.0

---

# Objetivo

Definir las reglas de rendimiento del proyecto.

Todo sistema deberá diseñarse teniendo en cuenta el uso eficiente de CPU, GPU, memoria y red.

La optimización será una parte del diseño, no una tarea del final del desarrollo.

---

# Filosofía

Primero arquitectura correcta.

Luego código limpio.

Finalmente optimización.

Nunca optimizar prematuramente.

Nunca sacrificar claridad sin una mejora medible.

---

# Objetivos de Rendimiento

Objetivos para PC:

- 60 FPS estables.
- Tiempo de frame inferior a 16 ms.
- Carga rápida de escenas.
- Guardado sin congelar el juego.
- Sin microcortes durante la exploración.

---

# Principios

Todo sistema deberá:

- Evitar trabajo innecesario.
- Reutilizar objetos.
- Reducir llamadas por frame.
- Mantener bajo el consumo de memoria.
- Escalar correctamente.

---

# Streaming del Mundo

El mundo nunca estará completamente cargado.

Las regiones se cargarán dinámicamente según la posición del jugador.

Regiones lejanas:

- Descargadas.
- Suspendidas.
- Simplificadas.

---

# Object Pooling

Nunca crear y destruir objetos constantemente.

Utilizar pools para:

- Proyectiles.
- Efectos.
- Enemigos temporales.
- Partículas.
- Objetos recolectables.

---

# Actualización Inteligente

No todos los objetos deberán actualizarse cada frame.

Ejemplos:

NPC lejanos

↓

Actualización lenta.

NPC cercanos

↓

Actualización completa.

---

# Distancia de Simulación

Cada sistema tendrá un radio de actividad.

Ejemplo:

Jugador

↓

100 metros

↓

IA completa

200 metros

↓

IA simplificada

500 metros

↓

Solo persistencia

Más lejos

↓

Sin simulación

---

# IA

La IA deberá utilizar niveles de detalle.

LOD 0

IA completa.

LOD 1

Decisiones simplificadas.

LOD 2

Rutinas básicas.

LOD 3

Estado congelado.

---

# Física

Solo los objetos relevantes utilizarán física activa.

Los objetos lejanos utilizarán estados simplificados.

---

# Renderizado

Reducir:

- Draw Calls.
- Materiales duplicados.
- Luces dinámicas innecesarias.
- Sombras excesivas.

Reutilizar recursos siempre que sea posible.

---

# Modelos 3D

Utilizar múltiples niveles de detalle (LOD).

Ejemplo:

LOD0

Alta calidad.

LOD1

Media.

LOD2

Baja.

LOD3

Billboard (si aplica).

---

# Texturas

Utilizar:

- Compresión.
- Mipmaps.
- Resoluciones adecuadas.
- Materiales compartidos.

Evitar texturas excesivamente grandes.

---

# Audio

Limitar sonidos simultáneos.

Priorizar:

- Enemigos cercanos.
- Eventos importantes.
- Música.

Reducir sonidos lejanos.

---

# UI

Actualizar únicamente elementos que cambien.

Nunca reconstruir toda la interfaz cada frame.

---

# Red

Enviar únicamente:

- Cambios.
- Eventos.
- Posiciones relevantes.

Evitar sincronización constante de datos innecesarios.

---

# Guardado

Guardar únicamente sistemas modificados.

Utilizar guardado incremental.

Evitar bloquear el hilo principal.

---

# Resources

Cargar bajo demanda.

Liberar recursos que ya no se utilicen.

Evitar duplicados.

---

# Caché

Guardar referencias frecuentes.

Evitar búsquedas repetidas mediante:

- get_node()
- find_child()
- búsquedas por nombre

---

# Señales

Desconectar señales que ya no sean necesarias.

Evitar emisiones excesivas.

---

# Perfilado

Todo sistema importante deberá analizarse mediante el profiler de Godot.

No optimizar sin datos medibles.

---

# Escalabilidad

La arquitectura deberá soportar:

- Miles de objetos.
- Grandes regiones.
- Reinos complejos.
- Cooperativo.
- Expansiones futuras.

---

# Integración

Interactúa con:

- Scene Architecture
- Manager System
- Save Architecture
- Network Architecture

---

# Consideraciones para Claude

Siempre priorizar algoritmos eficientes.

Evitar trabajo repetitivo.

Reutilizar estructuras de datos.

Reducir asignaciones de memoria innecesarias.

---

# Consideraciones para Gemini

El contenido generado deberá respetar los límites de rendimiento.

Evitar crear recursos excesivamente complejos sin justificación.

---

# Estado

Arquitectura aprobada.

Pendiente de implementación.

---

# Objetivo Final

Construir un juego estable, fluido y escalable que mantenga un rendimiento constante incluso en partidas largas y mundos de gran tamaño.
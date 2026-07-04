# Survivors Lords

# NETWORKING

Versión: 1.0

---

# Objetivo

Definir la arquitectura de red del proyecto para garantizar que todos los sistemas sean compatibles con el futuro modo cooperativo.

El multijugador no será implementado durante el Vertical Slice, pero todas las decisiones de arquitectura deberán contemplarlo.

---

# Filosofía

Single Player primero.

Multijugador después.

Nunca sacrificar calidad del modo individual por implementar red demasiado pronto.

---

# Tipo de Multijugador

Cooperativo.

Hasta 4 jugadores.

PvE.

No competitivo.

---

# Arquitectura

Servidor Autoritativo.

El Host actuará como servidor.

Los demás jugadores serán clientes.

---

# Responsabilidades del Host

- Estado del mundo.
- IA de enemigos.
- Eventos.
- Botín.
- Misiones.
- Guardado de la partida.

---

# Responsabilidades de los Clientes

- Movimiento local.
- Entrada del jugador.
- Cámara.
- Interfaz.
- Predicción visual cuando sea necesaria.

---

# Sincronización

Deberán sincronizarse:

- Posición de jugadores.
- Animaciones.
- Vida.
- Inventario.
- Estados alterados.
- Enemigos.
- NPC.
- Objetos interactivos.
- Eventos.
- Clima.
- Hora del día.

---

# Reino

Existirá un único Reino por partida.

Todos los jugadores colaborarán en el mismo asentamiento.

---

# Guardado

El Host será el propietario de la partida.

Los clientes no almacenarán el progreso del mundo.

---

# Diseño de Sistemas

Todos los sistemas deberán evitar depender de un único jugador.

Siempre pensar en:

"¿Este sistema funcionaría con cuatro jugadores?"

---

# Comunicación

La comunicación entre clientes y servidor deberá minimizar el tráfico.

Solo sincronizar información necesaria.

Evitar enviar datos redundantes.

---

# Seguridad

Nunca confiar en datos enviados por los clientes.

El Host siempre tendrá la autoridad sobre:

- Daño.
- Botín.
- Misiones.
- Construcción.
- Progreso.

---

# Escalabilidad

La arquitectura deberá permitir futuras ampliaciones:

- Servidores dedicados.
- Más jugadores.
- Eventos compartidos.
- Contenido cooperativo.

---

# Estado

No implementar networking durante el Vertical Slice.

Diseñar todos los sistemas para facilitar su futura integración.

---

# Objetivo Final

Crear una arquitectura que permita añadir el modo cooperativo sin reescribir los sistemas principales.
# Survivors Lords

# SAVE SYSTEM

Versión: 1.0

---

# Objetivo

Definir el sistema de guardado del juego.

El Save System será responsable de almacenar todo el progreso del jugador, el Reino y el mundo de forma segura, eficiente y compatible con futuras actualizaciones.

---

# Filosofía

El jugador nunca debe perder progreso por un fallo del juego.

El sistema debe ser robusto, rápido y preparado para un mundo persistente.

---

# Información Guardada

El sistema almacenará:

- Personaje.
- Inventario.
- Equipamiento.
- Habilidades.
- Profesiones.
- Reino.
- Habitantes.
- Edificios.
- Recursos.
- Mundo.
- Misiones.
- NPC.
- Eventos.
- Descubrimientos.
- Configuración de la partida.

---

# Personaje

Guardar:

- Nivel.
- Experiencia.
- Vida.
- Energía.
- Stamina.
- Posición.
- Rotación.
- Estado actual.
- Buffs activos.
- Debuffs activos.

---

# Inventario

Guardar:

- Objetos.
- Cantidades.
- Calidad.
- Durabilidad.
- Favoritos.
- Equipamiento.

---

# Reino

Guardar:

- Nivel.
- Prosperidad.
- Moral.
- Recursos.
- Habitantes.
- Profesiones asignadas.
- Producción.
- Edificios.
- Mejoras.
- Distritos.

---

# Mundo

Guardar:

- Regiones descubiertas.
- Regiones liberadas.
- POI descubiertos.
- Mazmorras completadas.
- Estado de cada región.
- Eventos permanentes.

---

# NPC

Guardar:

- Estado.
- Ubicación.
- Profesión.
- Relaciones.
- Misiones asociadas.
- Rutinas.

---

# Misiones

Guardar:

- Estado.
- Objetivos completados.
- Decisiones tomadas.
- Recompensas obtenidas.

---

# Objetos Persistentes

Guardar el estado de:

- Cofres abiertos.
- Puertas desbloqueadas.
- Recursos especiales agotados.
- Reliquias obtenidas.
- Objetos únicos.

---

# Guardado Manual

El jugador podrá guardar la partida manualmente en cualquier momento fuera del combate.

---

# Guardado Automático

Se realizará automáticamente al:

- Completar una misión.
- Entrar en una nueva región.
- Construir un edificio.
- Mejorar el Reino.
- Dormir.
- Derrotar un jefe.
- Salir del juego.

---

# Ranuras de Guardado

Cada partida dispondrá de múltiples ranuras.

Ejemplo:

- Slot 1
- Slot 2
- Slot 3
- Guardado Automático

---

# Versionado

Cada archivo incluirá:

- Versión del juego.
- Versión del Save.
- Fecha.
- Tiempo jugado.

Esto facilitará la compatibilidad con futuras actualizaciones.

---

# Integridad

El sistema verificará que el archivo no esté corrupto.

En caso de error:

- Intentará restaurar una copia de seguridad.
- Avisará al jugador.

---

# Copias de Seguridad

El juego mantendrá automáticamente varias copias recientes del guardado.

Ejemplo:

- Último guardado.
- Guardado anterior.
- Copia de emergencia.

---

# Cooperativo

El anfitrión será el responsable del mundo compartido.

Se guardará:

- Estado del Reino.
- Mundo.
- Construcciones.
- Eventos.

Cada jugador conservará además:

- Inventario.
- Equipamiento.
- Habilidades.
- Profesiones.

---

# Rendimiento

El sistema deberá minimizar el tiempo de guardado.

Siempre que sea posible utilizará guardado incremental para evitar escribir datos innecesarios.

---

# Seguridad

Evitar pérdidas de información durante:

- Cierres inesperados.
- Cortes de energía.
- Errores del sistema.

El proceso de guardado nunca sobrescribirá un archivo válido hasta confirmar que el nuevo se creó correctamente.

---

# Integración

Interactúa con todos los sistemas del juego.

Especialmente:

- Kingdom System
- World System
- Inventory System
- Quest System
- Multiplayer System

---

# Consideraciones para Claude

Implementar el sistema mediante serialización modular.

Cada sistema deberá guardar únicamente su propia información.

Utilizar un SaveManager central que coordine el proceso.

Preparar el sistema para DLC y futuras expansiones.

---

# Consideraciones para Gemini

El jugador debe confiar completamente en el sistema.

Guardar la partida debe ser rápido, transparente y seguro.

Nunca debe interrumpir la experiencia de juego.

---

# Estado

Diseño aprobado.

Pendiente de implementación.

---

# Objetivo Final

Crear un sistema de guardado robusto, modular y preparado para cientos de horas de juego, garantizando la persistencia del mundo y del Reino incluso tras futuras actualizaciones.
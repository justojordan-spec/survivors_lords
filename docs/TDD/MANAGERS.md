# Survivors Lords

# MANAGERS

Versión: 1.0

---

# Objetivo

Definir la responsabilidad de cada Manager del proyecto.

Cada Manager tendrá una única responsabilidad.

Los Managers se cargarán mediante Autoload en Godot.

---

# Reglas Generales

- Un Manager = Una responsabilidad.
- No duplicar lógica entre Managers.
- Los Managers no deben conocerse entre sí de forma directa.
- La comunicación debe realizarse mediante señales, eventos o interfaces bien definidas.
- Evitar dependencias circulares.

---

# GameManager

Responsabilidad:

Controlar el estado general del juego.

Funciones:

- Iniciar partida.
- Pausar.
- Reanudar.
- Game Over.
- Victoria.
- Estado global.

No debe:

- Controlar combate.
- Guardar partidas.
- Manejar inventario.

---

# SceneManager

Responsabilidad:

Administrar el cambio de escenas.

Funciones:

- Cambiar escenas.
- Pantallas de carga.
- Reiniciar escena.
- Volver al menú.

---

# SaveManager

Responsabilidad:

Guardar y cargar partidas.

Funciones:

- Crear partidas.
- Guardar progreso.
- Cargar progreso.
- Gestionar múltiples partidas.

---

# AudioManager

Responsabilidad:

Administrar música y efectos.

Funciones:

- Música.
- Sonidos.
- Volumen.
- Ambientes.

---

# InputManager

Responsabilidad:

Gestionar la entrada del jugador.

Funciones:

- Acciones.
- Reasignación de teclas.
- Compatibilidad con teclado y mando.

---

# PlayerManager

Responsabilidad:

Administrar los datos globales del jugador.

Funciones:

- Estadísticas.
- Nivel.
- Experiencia.
- Profesiones.
- Estado general.

---

# InventoryManager

Responsabilidad:

Administrar el inventario.

Funciones:

- Agregar objetos.
- Eliminar objetos.
- Equipar.
- Desequipar.
- Ordenar.

---

# CombatManager

Responsabilidad:

Gestionar el combate.

Funciones:

- Daño.
- Curación.
- Estados alterados.
- Críticos.
- Cálculos de combate.

---

# SkillManager

Responsabilidad:

Gestionar habilidades activas y pasivas.

Funciones:

- Desbloqueo.
- Enfriamientos.
- Mejoras.

---

# QuestManager

Responsabilidad:

Administrar misiones.

Funciones:

- Misiones activas.
- Objetivos.
- Recompensas.
- Estado.

---

# WorldManager

Responsabilidad:

Administrar el estado del mundo.

Funciones:

- Regiones.
- Eventos.
- Clima.
- Ciclo día/noche.

---

# KingdomManager

Responsabilidad:

Administrar el Reino.

Funciones:

- Nivel del Reino.
- Edificios.
- Habitantes.
- Prosperidad.

---

# LootManager

Responsabilidad:

Generar botín.

Funciones:

- Tablas de loot.
- Rarezas.
- Recompensas.

---

# EventManager

Responsabilidad:

Gestionar eventos globales.

Funciones:

- Eventos dinámicos.
- Eventos temporales.
- Eventos especiales.

---

# UIManager

Responsabilidad:

Administrar la interfaz.

Funciones:

- HUD.
- Menús.
- Ventanas.
- Notificaciones.

---

# Futuros Managers

Podrán agregarse nuevos Managers únicamente si cumplen una responsabilidad claramente definida.

Toda incorporación deberá registrarse en DECISIONS.md.

---

# Objetivo Final

Cada sistema debe ser independiente, reutilizable y fácil de mantener.
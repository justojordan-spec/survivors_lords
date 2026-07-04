# Survivors Lords

# MANAGER SYSTEM

Versión: 1.0

---

# Objetivo

Definir la arquitectura de Managers de Survivors Lords.

Los Managers serán responsables de coordinar los distintos sistemas del juego sin generar dependencias innecesarias entre ellos.

Todo sistema global deberá estar administrado por un Manager específico.

---

# Filosofía

Los Managers no contienen la lógica completa del juego.

Su responsabilidad consiste en:

- Coordinar sistemas.
- Administrar datos globales.
- Enviar eventos.
- Inicializar módulos.
- Facilitar la comunicación.

Nunca deberán reemplazar la lógica propia de cada componente.

---

# Principios

Cada Manager debe:

- Tener una única responsabilidad.
- Ser independiente.
- Poder inicializarse automáticamente.
- Poder reemplazarse sin afectar a otros sistemas.
- Comunicarse mediante EventBus cuando sea posible.

---

# Jerarquía

```
GameManager
│
├── WorldManager
├── PlayerManager
├── KingdomManager
├── CombatManager
├── InventoryManager
├── ItemManager
├── QuestManager
├── SaveManager
├── AudioManager
├── UIManager
├── NetworkManager
├── TimeManager
├── WeatherManager
└── EventBus
```

---

# GameManager

Responsabilidad:

Controlar el ciclo completo del juego.

Funciones:

- Inicializar Managers.
- Cambiar escenas.
- Cargar partida.
- Crear nueva partida.
- Reiniciar partida.
- Cerrar el juego.

Nunca administrará inventarios ni combate.

---

# WorldManager

Responsabilidad:

Administrar el mundo.

Funciones:

- Cargar regiones.
- Descargar regiones.
- Spawn de recursos.
- Spawn de enemigos.
- Eventos del mundo.
- Estado de regiones.

---

# PlayerManager

Responsabilidad:

Administrar todos los jugadores.

Funciones:

- Referencia al jugador local.
- Referencias a jugadores cooperativos.
- Respawn.
- Estadísticas generales.

---

# KingdomManager

Responsabilidad:

Administrar el Reino.

Funciones:

- Habitantes.
- Producción.
- Prosperidad.
- Moral.
- Distritos.
- Construcciones.
- Economía.

---

# CombatManager

Responsabilidad:

Coordinar el combate.

Funciones:

- Daño.
- Estados.
- Buffs.
- Debuffs.
- Combate grupal.
- Balance.

No controla la IA.

---

# InventoryManager

Responsabilidad:

Administrar inventarios.

Funciones:

- Inventario del jugador.
- Inventarios compartidos.
- Cofres.
- Transferencias.
- Peso.
- Espacios.

---

# ItemManager

Responsabilidad:

Administrar todos los objetos.

Funciones:

- Crear Items.
- Buscar Items.
- Registrar Items.
- Objetos únicos.
- Pool de objetos.

---

# QuestManager

Responsabilidad:

Administrar las misiones.

Funciones:

- Activar.
- Completar.
- Cancelar.
- Consultar progreso.
- Generar eventos.

---

# SaveManager

Responsabilidad:

Guardar y cargar el juego.

Funciones:

- Guardado manual.
- Guardado automático.
- Backups.
- Versionado.
- Restauración.

---

# AudioManager

Responsabilidad:

Administrar el audio.

Funciones:

- Música.
- Ambiente.
- SFX.
- Volumen.
- Transiciones.

---

# UIManager

Responsabilidad:

Administrar toda la interfaz.

Funciones:

- HUD.
- Menús.
- Notificaciones.
- Ventanas.
- Cursores.

---

# NetworkManager

Responsabilidad:

Administrar el cooperativo.

Funciones:

- Conexiones.
- RPC.
- Sincronización.
- Autoridad.
- Desconexiones.

---

# TimeManager

Responsabilidad:

Administrar el tiempo.

Funciones:

- Hora.
- Día.
- Estaciones (futuro).
- Eventos temporales.

---

# WeatherManager

Responsabilidad:

Administrar el clima.

Funciones:

- Lluvia.
- Tormenta.
- Niebla.
- Nieve.
- Cambios dinámicos.

---

# EventBus

Responsabilidad:

Comunicar sistemas.

Ejemplos:

PlayerDied

EnemyKilled

QuestCompleted

ItemCrafted

BuildingFinished

KingdomLevelUp

RegionLiberated

WeatherChanged

InventoryChanged

---

# Inicialización

Orden de carga:

```
Main

↓

GameManager

↓

EventBus

↓

SaveManager

↓

WorldManager

↓

PlayerManager

↓

KingdomManager

↓

QuestManager

↓

InventoryManager

↓

CombatManager

↓

AudioManager

↓

UIManager

↓

NetworkManager

↓

Comienza la partida
```

---

# Comunicación

Los Managers nunca deberán acceder directamente a datos internos de otros Managers.

Toda comunicación utilizará:

- Signals
- EventBus
- Interfaces públicas

---

# Persistencia

Cada Manager será responsable de guardar únicamente su propia información.

Ejemplo:

KingdomManager

↓

kingdom.save

InventoryManager

↓

inventory.save

---

# Dependencias

Reducir dependencias al mínimo.

Ejemplo:

CombatManager

NO depende de

QuestManager

Solo envía:

EnemyKilled

El QuestManager decide si esa muerte afecta alguna misión.

---

# Singleton

Los Managers principales se registrarán como AutoLoad.

Ejemplos:

GameManager

SaveManager

AudioManager

UIManager

EventBus

Otros Managers podrán instanciarse dinámicamente cuando sea necesario.

---

# Escalabilidad

Se podrán añadir nuevos Managers sin modificar los existentes.

Ejemplos futuros:

AchievementManager

ModManager

AnalyticsManager

SeasonManager

GuildManager

PetManager

---

# Integración

Interactúa con toda la arquitectura del proyecto.

Es uno de los documentos principales para el desarrollo.

---

# Consideraciones para Claude

Cada Manager deberá implementarse como una clase independiente.

Evitar Managers gigantes.

Siempre utilizar composición.

Toda lógica específica deberá delegarse en componentes especializados.

---

# Consideraciones para Gemini

Todo contenido nuevo deberá comunicarse mediante los Managers existentes.

Nunca asumir acceso directo entre sistemas.

---

# Estado

Arquitectura aprobada.

Pendiente de implementación.

---

# Objetivo Final

Construir una arquitectura de Managers robusta, modular y escalable que permita coordinar todos los sistemas del juego sin generar dependencias innecesarias.
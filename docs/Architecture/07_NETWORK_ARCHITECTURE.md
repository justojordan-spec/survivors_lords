# Survivors Lords

# NETWORK ARCHITECTURE

Versión: 1.0

---

# Objetivo

Definir la arquitectura de red de Survivors Lords.

El sistema de red será modular, seguro y escalable, permitiendo jugar en cooperativo desde la primera versión y evolucionar posteriormente hacia servidores dedicados.

---

# Filosofía

La red debe ser:

- Transparente.
- Estable.
- Escalable.
- Segura.
- Modular.

El jugador no debe notar la complejidad del sistema.

---

# Arquitectura Inicial

Modelo:

Host-Client

Cantidad inicial:

- 1 Host
- Hasta 4 jugadores

Preparado para ampliar el límite en futuras versiones.

---

# Arquitectura Futura

La misma lógica deberá funcionar con:

- Servidores dedicados.
- Crossplay.
- Cross Save.
- Clanes.
- Eventos Mundiales.

Sin modificar los sistemas principales.

---

# Jerarquía

```
Host
│
├── World
├── Kingdom
├── NPC
├── Enemy AI
├── Loot
├── Save
└── Physics

│

Clientes

↓

Player Actions

↓

Host Validation

↓

World Update

↓

Synchronization

↓

Clients
```

---

# Autoridad

El Host tendrá autoridad absoluta sobre:

- Mundo.
- Física.
- IA.
- NPC.
- Construcciones.
- Loot.
- Recursos.
- Eventos.
- Guardado.

Los clientes nunca modificarán directamente el estado del mundo.

---

# Autoridad del Jugador

Cada jugador tendrá autoridad únicamente sobre:

- Movimiento local.
- Cámara.
- Inventario temporal.
- Entrada del usuario.
- Interfaz.

Toda acción importante será validada por el Host.

---

# Sincronización

Se sincronizarán:

- Posiciones.
- Animaciones.
- Estados.
- Vida.
- Daño.
- Objetos.
- Construcciones.
- Eventos.
- Clima.
- Hora.
- Reino.

Solo cuando sea necesario.

---

# RPC

Utilizar RPC para:

- Ataques.
- Construcción.
- Interacciones.
- Revivir.
- Misiones.
- Comercio.

Evitar RPC innecesarias.

---

# NetworkManager

Responsabilidades:

- Crear sesión.
- Unirse a sesión.
- Desconexiones.
- Reconexiones.
- Sincronización.
- Autoridad.
- RPC.
- Ping.

---

# Network Components

Cada entidad sincronizable tendrá un componente específico.

Ejemplo:

```
NetworkComponent

↓

Player

Enemy

NPC

Building

Projectile
```

---

# Predicción

El cliente podrá predecir:

- Movimiento.
- Cámara.
- Animaciones.

El Host corregirá diferencias si es necesario.

---

# Interpolación

Los clientes interpolarán:

- Posiciones.
- Rotaciones.
- Animaciones.

Para reducir movimientos bruscos.

---

# Compensación de Latencia

El sistema deberá:

- Minimizar teletransportes.
- Corregir suavemente.
- Priorizar estabilidad.

---

# Spawn

Solo el Host podrá crear:

- Enemigos.
- NPC.
- Objetos.
- Recursos.
- Construcciones.

Los clientes recibirán la sincronización.

---

# Destrucción

Solo el Host podrá eliminar entidades del mundo.

---

# Inventario

El inventario personal será validado por el Host.

El cliente mostrará la actualización únicamente después de la confirmación.

---

# Loot

Objetos importantes:

Loot individual.

Recursos comunes:

Compartidos.

Jefes:

Recompensa individual para cada jugador.

---

# Construcción

Toda construcción seguirá este flujo:

```
Jugador

↓

Solicitud

↓

Host valida

↓

Construcción creada

↓

Sincronización

↓

Clientes actualizan
```

---

# Reconexión

Si un jugador pierde conexión:

- Su progreso permanecerá guardado.
- Podrá volver a entrar.
- Recuperará su personaje.

---

# Seguridad

El Host verificará:

- Daño.
- Recursos.
- Inventarios.
- Construcciones.
- Fabricación.
- Movimiento extremo.

Reduciendo la posibilidad de trampas.

---

# Optimización

Reducir tráfico mediante:

- Actualizaciones por relevancia.
- Compresión de datos.
- Sincronización parcial.
- Agrupación de eventos.

---

# Escalabilidad

Preparado para:

- Servidores dedicados.
- Crossplay.
- Mods.
- Clanes.
- Comercio.
- Eventos online.

---

# Integración

Interactúa con:

- Multiplayer System
- Save Architecture
- Manager System
- World System
- Kingdom System

---

# Consideraciones para Claude

Implementar utilizando la API Multiplayer de Godot 4.7.

Separar claramente:

- Lógica local.
- Lógica del Host.
- Lógica compartida.

Toda autoridad importante deberá residir en el Host.

---

# Consideraciones para Gemini

Todo contenido multijugador deberá respetar la autoridad del Host.

Nunca asumir que un cliente puede modificar directamente el estado del mundo.

---

# Estado

Arquitectura aprobada.

Pendiente de implementación.

---

# Objetivo Final

Construir una arquitectura de red estable, segura y preparada para evolucionar desde un cooperativo Host-Client hasta servidores dedicados sin rehacer la base del proyecto.
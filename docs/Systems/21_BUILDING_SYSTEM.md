# Building System

**Estado:** Draft

---

# Objetivo

El Building System es responsable de administrar todas las construcciones de Survivors Lords.

Su propósito es gestionar la colocación, construcción, reparación, mejora y demolición de edificios, manteniendo una arquitectura modular, ECS y completamente Data Driven.

No administra recursos, economía ni tecnologías.

---

# Filosofía

Las construcciones representan estructuras permanentes o temporales dentro del mundo.

El Building System administra exclusivamente su ciclo de vida, mientras que su configuración será obtenida mediante Building Resources.

Toda la información será completamente Data Driven.

---

# Responsabilidades

El Building System será responsable de:

- Validar ubicaciones.
- Colocar construcciones.
- Iniciar construcción.
- Finalizar construcción.
- Mejorar edificios.
- Reparar edificios.
- Demoler edificios.
- Gestionar estados de construcción.
- Administrar integridad estructural.

---

# No es responsable de

El Building System NO debe:

- Administrar recursos.
- Consumir materiales.
- Gestionar economía.
- Administrar asentamientos.
- Investigar tecnologías.
- Ejecutar IA.
- Administrar interfaz.

Estas responsabilidades pertenecen a sus respectivos Systems.

---

# Tipos de Construcciones

El sistema podrá administrar:

- Viviendas.
- Talleres.
- Almacenes.
- Murallas.
- Torres.
- Granjas.
- Minas.
- Caminos.
- Decoraciones.
- Edificios especiales.

---

# Estados

Las construcciones podrán encontrarse en:

- Proyectada.
- En construcción.
- Operativa.
- Dañada.
- En reparación.
- Mejorándose.
- Destruida.

---

# Validaciones

Antes de construir deberán verificarse:

- Terreno válido.
- Espacio disponible.
- Recursos necesarios.
- Tecnología requerida.
- Restricciones del asentamiento.
- Colisiones.

---

# Comunicación

El Building System se comunicará mediante:

- Eventos.
- Interfaces.
- Consultas.

Nunca modificará directamente otros Systems.

---

# Integración

Trabajará junto a:

- Entity System.
- Component System.
- Resource System.
- Inventory System.
- Settlement System.
- Economy System.
- Profession System.
- Technology System.
- Research System.
- Weather System.
- Time System.
- World System.
- UI System.
- Multiplayer System.

---

# Multiplayer

El servidor será la autoridad sobre todas las construcciones.

Los clientes únicamente enviarán solicitudes de construcción, mejora o demolición y recibirán el estado sincronizado.

---

# Rendimiento

El Building System deberá:

- Procesar únicamente construcciones activas.
- Compartir Building Resources.
- Evitar validaciones repetidas.
- Reducir consultas al mundo.
- Mantener una simulación determinista.

---

# Eventos

Ejemplos:

- BuildingPlaced
- ConstructionStarted
- ConstructionCompleted
- BuildingUpgraded
- BuildingDamaged
- BuildingRepaired
- BuildingDestroyed

---

# Convenciones

Toda construcción deberá:

- Referenciar un Building Resource.
- Tener un identificador único.
- Poder serializarse.
- Mantener consistencia con el Settlement System.
- Ser determinista.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Building System desacoplado del Settlement System.
- Configurar todos los edificios mediante Building Resources.
- Obtener recursos mediante el Inventory System.
- Validar tecnologías mediante el Technology System.
- Utilizar eventos para comunicar cambios.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar validaciones duplicadas.
- Verificar integración con Settlement System.
- Detectar dependencias innecesarias.
- Validar sincronización multijugador.
- Revisar rendimiento del sistema.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado encargado de administrar todas las construcciones del juego, controlando su ciclo de vida mediante una arquitectura ECS, Data Driven y completamente desacoplada.

---

# DEC propuesta

## DEC – El Building System administrará únicamente el ciclo de vida de las construcciones

### Decisión

El Building System será responsable exclusivamente de la colocación, construcción, mejora, reparación y demolición de edificios. El consumo de recursos, la gestión del asentamiento, la economía y el desbloqueo de tecnologías serán responsabilidad de los Systems especializados.

### Justificación

- Mantiene el principio de responsabilidad única.
- Evita acoplamiento entre construcción, economía y asentamientos.
- Facilita la incorporación de nuevos tipos de edificios.
- Mejora la reutilización del sistema.
- Refuerza la arquitectura ECS y Data Driven.
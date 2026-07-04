# Effect System

**Estado:** Draft

---

# Objetivo

El Effect System es responsable de administrar todos los efectos temporales y permanentes de Survivors Lords.

Su propósito es aplicar, actualizar, modificar y eliminar los efectos que afectan a entidades, objetos o al mundo, manteniendo una simulación consistente y desacoplada.

No administra habilidades ni combate.

---

# Filosofía

Los efectos representan modificaciones temporales o permanentes sobre entidades o el mundo.

El Effect System administra exclusivamente el ciclo de vida de dichos efectos.

Toda la configuración será completamente Data Driven mediante Effect Resources.

---

# Responsabilidades

El Effect System será responsable de:

- Aplicar efectos.
- Actualizar efectos activos.
- Eliminar efectos.
- Gestionar duración.
- Gestionar acumulación (Stacking).
- Gestionar modificadores.
- Validar condiciones de expiración.
- Notificar cambios de estado.

---

# No es responsable de

El Effect System NO debe:

- Resolver combate.
- Activar habilidades.
- Administrar inventarios.
- Ejecutar IA.
- Gestionar animaciones.
- Reproducir sonidos.
- Administrar interfaz.

Estas responsabilidades pertenecen a sus respectivos Systems.

---

# Tipos de Efectos

El sistema podrá administrar:

- Buffs.
- Debuffs.
- Efectos de estado.
- Modificadores temporales.
- Modificadores permanentes.
- Daño continuo.
- Curación continua.
- Alteraciones ambientales.

---

# Propiedades

Cada efecto podrá definir:

- Duración.
- Intensidad.
- Acumulación.
- Prioridad.
- Intervalo de actualización.
- Fuente.
- Objetivo.
- Condiciones de eliminación.

---

# Estados

Los efectos podrán encontrarse en:

- Activo.
- Suspendido.
- Expirado.
- Eliminado.

---

# Comunicación

El Effect System se comunicará mediante:

- Eventos.
- Interfaces.
- Consultas.

Nunca modificará directamente otros Systems.

---

# Integración

Trabajará junto a:

- Ability System.
- Combat System.
- Player System.
- Enemy System.
- Item System.
- Inventory System.
- Time System.
- Technology System.
- Weather System.
- UI System.
- Multiplayer System.

---

# Multiplayer

El servidor será la autoridad sobre todos los efectos activos.

Los clientes recibirán únicamente la información sincronizada necesaria para representar dichos efectos.

---

# Rendimiento

El Effect System deberá:

- Procesar únicamente efectos activos.
- Compartir Effect Resources.
- Evitar cálculos repetidos.
- Agrupar actualizaciones cuando sea posible.
- Mantener una simulación determinista.

---

# Eventos

Ejemplos:

- EffectApplied
- EffectUpdated
- EffectExpired
- EffectRemoved
- EffectStackChanged

---

# Convenciones

Todo efecto deberá:

- Referenciar un Effect Resource.
- Tener un identificador único.
- Poder serializarse.
- Ser determinista.
- Mantener consistencia entre cliente y servidor.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Effect System desacoplado del Combat System.
- Configurar todos los efectos mediante Effect Resources.
- Gestionar la duración utilizando el Time System.
- Implementar correctamente el sistema de acumulación.
- Favorecer una arquitectura orientada a eventos.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar lógica de combate dentro del Effect System.
- Verificar expiración de efectos.
- Detectar acumulaciones incorrectas.
- Validar sincronización multijugador.
- Revisar rendimiento del sistema.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado encargado de administrar todos los efectos del juego, controlando su aplicación, duración, acumulación y eliminación mediante una arquitectura ECS, Data Driven y completamente desacoplada.

---

# DEC propuesta

## DEC – El Effect System administrará exclusivamente el ciclo de vida de los efectos

### Decisión

El Effect System será responsable únicamente de aplicar, actualizar y eliminar efectos. Los Systems que originen dichos efectos, como Ability System, Combat System o Item System, solicitarán su aplicación mediante eventos o interfaces.

### Justificación

- Mantiene el principio de responsabilidad única.
- Evita duplicar lógica entre habilidades, combate e inventario.
- Facilita la incorporación de nuevos efectos sin modificar otros Systems.
- Mejora la reutilización y el mantenimiento del código.
- Refuerza la arquitectura ECS y Data Driven.
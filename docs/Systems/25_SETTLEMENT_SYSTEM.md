# Save System

**Estado:** Draft

---

# Objetivo

El Save System es responsable de administrar el almacenamiento y recuperación del estado del juego en Survivors Lords.

Su propósito es garantizar que el progreso del mundo, las entidades y los datos persistentes puedan guardarse y restaurarse de forma consistente, segura y eficiente.

No administra la lógica de gameplay.

---

# Filosofía

El Save System será el único responsable de la persistencia de datos.

Los demás Systems expondrán la información necesaria mediante interfaces o eventos, pero nunca escribirán directamente archivos de guardado.

Toda la serialización deberá ser independiente del motor gráfico.

---

# Responsabilidades

El Save System será responsable de:

- Crear partidas.
- Guardar partidas.
- Cargar partidas.
- Eliminar partidas.
- Administrar múltiples perfiles.
- Gestionar versiones de guardado.
- Validar integridad de datos.
- Coordinar la serialización.
- Coordinar la deserialización.

---

# No es responsable de

El Save System NO debe:

- Administrar entidades.
- Ejecutar lógica de gameplay.
- Resolver combate.
- Administrar inventarios.
- Gestionar economía.
- Ejecutar IA.
- Administrar interfaz.

Estas responsabilidades pertenecen a sus respectivos Systems.

---

# Datos Persistentes

El sistema podrá almacenar:

- Mundo.
- Jugadores.
- NPC.
- Enemigos.
- Inventarios.
- Construcciones.
- Economía.
- Tecnologías.
- Misiones.
- Tiempo.
- Clima.
- Configuración.

---

# Versionado

El sistema deberá soportar:

- Versiones de guardado.
- Migración de datos.
- Compatibilidad hacia atrás cuando sea posible.
- Validación de versiones incompatibles.

---

# Comunicación

El Save System se comunicará mediante:

- Eventos.
- Interfaces.
- Consultas.

Nunca accederá directamente al estado interno de otros Systems.

---

# Integración

Trabajará junto a:

- Entity System.
- Component System.
- Resource System.
- Inventory System.
- Building System.
- Settlement System.
- Economy System.
- Technology System.
- Quest System.
- World System.
- Time System.
- Weather System.
- Multiplayer System.

---

# Multiplayer

En partidas multijugador el servidor será el único responsable del guardado del mundo.

Los clientes únicamente almacenarán datos locales de configuración cuando corresponda.

---

# Rendimiento

El Save System deberá:

- Minimizar tiempos de guardado.
- Permitir guardado incremental cuando sea posible.
- Evitar bloquear el hilo principal.
- Comprimir datos cuando corresponda.
- Validar integridad antes de finalizar el proceso.

---

# Eventos

Ejemplos:

- SaveStarted
- SaveCompleted
- LoadStarted
- LoadCompleted
- SaveFailed
- SaveVersionMigrated

---

# Convenciones

Toda información persistente deberá:

- Poder serializarse.
- Tener una versión definida.
- Mantener consistencia entre Systems.
- Ser determinista.
- Validarse antes de cargarse.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Save System desacoplado del resto de los Systems.
- Utilizar interfaces para obtener datos persistentes.
- Evitar referencias directas entre Systems.
- Soportar migración de versiones.
- Favorecer operaciones asíncronas.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar dependencias innecesarias.
- Verificar serialización.
- Detectar pérdida de datos.
- Validar compatibilidad entre versiones.
- Revisar rendimiento del sistema.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado encargado de administrar el almacenamiento y recuperación del estado del juego, proporcionando persistencia segura, escalable y completamente desacoplada mediante una arquitectura ECS y Data Driven.

---

# DEC propuesta

## DEC – El Save System será la única capa responsable de la persistencia

### Decisión

El Save System será responsable exclusivamente del guardado y carga del estado del juego. Cada System expondrá únicamente los datos necesarios para su serialización sin conocer el formato ni el mecanismo de almacenamiento.

### Justificación

- Mantiene el principio de responsabilidad única.
- Evita duplicación de lógica de persistencia.
- Facilita cambios en el formato de guardado.
- Mejora la mantenibilidad del proyecto.
- Refuerza la arquitectura ECS y Data Driven.
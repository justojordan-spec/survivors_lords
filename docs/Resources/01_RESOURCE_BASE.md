# Resource Base

**Estado:** Draft

---

# Objetivo

El Resource Base define la filosofía, arquitectura y reglas generales que deberán seguir todos los Resources utilizados en Survivors Lords.

Su propósito es establecer un estándar único para el diseño de datos reutilizables, promoviendo una arquitectura completamente Data Driven y desacoplada de la lógica de implementación.

Todos los Resources del proyecto deberán respetar las reglas definidas en este documento.

---

# Filosofía

En Survivors Lords, un Resource representa únicamente datos.

Los Resources describen el contenido del juego, pero nunca ejecutan lógica de gameplay.

Su función es actuar como la fuente oficial de configuración para Components, Systems y Managers.

Los Resources permiten modificar el comportamiento del juego sin necesidad de alterar el código.

---

# Arquitectura

Todos los Resources estarán implementados utilizando Resources nativos de Godot (.tres).

Cada tipo de Resource representará una definición específica del juego.

Ejemplos:

- Items.
- Habilidades.
- Enemigos.
- Construcciones.
- Profesiones.
- Loot Tables.
- Buffs.
- Eventos.
- Diálogos.

Los Resources podrán referenciar otros Resources para construir estructuras complejas y reutilizables.

---

# Principios

Todos los Resources deberán cumplir los siguientes principios:

- Ser completamente Data Driven.
- Ser reutilizables.
- Ser independientes del contexto.
- No contener lógica de gameplay.
- No modificar el estado del juego.
- Ser serializables.
- Poder compartirse entre múltiples Entities.

---

# Responsabilidades

Un Resource podrá:

- Definir configuraciones.
- Describir comportamientos.
- Almacenar estadísticas.
- Configurar probabilidades.
- Referenciar otros Resources.
- Exponer datos mediante propiedades.

Un Resource no podrá:

- Ejecutar lógica del juego.
- Instanciar Entities.
- Acceder a Managers.
- Emitir Signals.
- Modificar Components.
- Ejecutar cálculos persistentes.

---

# Organización

Los Resources deberán agruparse por responsabilidad.

Ejemplo:

- Character Resources.
- Item Resources.
- Ability Resources.
- Buff Resources.
- Loot Resources.
- Quest Resources.
- Dialogue Resources.

Cada Resource representará una única responsabilidad.

---

# Comunicación

Los Resources no se comunicarán entre sí.

La coordinación será responsabilidad de:

- Components.
- Systems.
- Managers.

Los Resources únicamente serán consumidos por dichos sistemas.

---

# Dependencias

Un Resource podrá referenciar otros Resources cuando exista una relación lógica entre ellos.

Ejemplos:

- Un Ability podrá utilizar múltiples Buff Resources.
- Un Enemy podrá utilizar múltiples Loot Tables.
- Una Quest podrá utilizar múltiples Dialogue Resources.

Las referencias deberán evitar dependencias circulares.

---

# Integración con el resto del proyecto

Los Resources constituyen la base de datos del juego.

Serán utilizados por:

- Components.
- Systems.
- Managers.
- Escenas.
- Herramientas del Editor.

Toda la configuración del gameplay deberá provenir de Resources.

---

# Rendimiento

Los Resources deberán:

- Compartirse entre múltiples instancias.
- Evitar duplicación de datos.
- Mantener un tamaño reducido.
- Aprovechar el sistema de caché de Godot.

---

# Multiplayer

Los Resources deberán ser idénticos entre Host y Clientes.

Durante la partida únicamente se sincronizarán estados y eventos.

Los datos definidos en los Resources no deberán transmitirse constantemente por red.

---

# Convenciones

Todos los Resources deberán:

- Tener nombres descriptivos.
- Mantener una estructura consistente.
- Evitar información redundante.
- Utilizar tipos de datos apropiados.
- Mantener compatibilidad con serialización.

---

# Consideraciones para Claude

Al generar código:

- Mantener los Resources como contenedores de datos.
- Evitar lógica de negocio.
- Favorecer la composición mediante referencias entre Resources.
- Diseñar estructuras reutilizables y escalables.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro de Resources.
- Verificar el cumplimiento del enfoque Data Driven.
- Validar referencias entre Resources.
- Identificar duplicación de información.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Establecer un estándar único para todos los Resources del proyecto, garantizando una arquitectura completamente Data Driven, reutilizable, desacoplada y preparada para escalar durante todo el desarrollo de Survivors Lords.
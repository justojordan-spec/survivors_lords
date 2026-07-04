# Resource System

**Estado:** Draft

---

# Objetivo

El Resource System es responsable de descubrir, cargar, validar, registrar y proporcionar acceso a todos los Resources utilizados por Survivors Lords.

Su propósito es actuar como el punto central de acceso a la información estática del juego dentro de una arquitectura completamente Data Driven.

No administra el estado dinámico de la simulación.

---

# Filosofía

Los Resources representan datos estáticos compartidos por todas las partidas.

El Resource System es el único encargado de administrarlos durante la ejecución del juego.

Todos los demás Systems deberán obtener los Resources exclusivamente a través de este sistema.

---

# Responsabilidades

El Resource System será responsable de:

- Descubrir Resources disponibles.
- Cargar Resources desde disco.
- Registrar Resources.
- Validar dependencias entre Resources.
- Resolver referencias.
- Detectar Resources duplicados.
- Proporcionar búsquedas rápidas.
- Liberar Resources cuando corresponda.

---

# No es responsable de

El Resource System NO debe:

- Modificar Resources.
- Guardar partidas.
- Ejecutar lógica de gameplay.
- Instanciar entidades.
- Administrar Components.
- Ejecutar simulaciones.

---

# Tipos de Resources

El sistema administrará todos los Resources del proyecto.

Ejemplos:

- Character Resource
- Item Resource
- Building Resource
- Recipe Resource
- Technology Resource
- Research Resource
- Kingdom Resource
- Settlement Resource
- Currency Resource
- Economy Resource
- Scenario Resource
- Game Mode Resource

---

# Registro

Cada Resource deberá poseer:

- ID único.
- Tipo.
- Ruta.
- Versión.
- Estado de validación.

---

# Búsquedas

El sistema permitirá búsquedas mediante:

- ID.
- Tipo.
- Categoría.
- Etiquetas.
- Ruta.
- Nombre.

Las búsquedas deberán ser de alta eficiencia.

---

# Validación

Durante la carga se verificará:

- IDs duplicados.
- Referencias inexistentes.
- Dependencias circulares.
- Datos obligatorios.
- Versiones incompatibles.

Los errores deberán reportarse antes del inicio de la partida.

---

# Comunicación

Los demás Systems accederán al Resource System mediante:

- Interfaces.
- Consultas.
- Eventos.

Nunca accederán directamente a los archivos de Resources.

---

# Integración

El Resource System será utilizado por:

- Game System
- Save System
- World System
- Entity System
- Component System
- Combat System
- Inventory System
- Building System
- Quest System
- Economy System
- Technology System
- Research System
- Multiplayer System

---

# Multiplayer

Todos los participantes deberán utilizar exactamente la misma versión de los Resources.

El sistema podrá validar:

- Hash de Resources.
- Versiones.
- Compatibilidad entre cliente y servidor.

---

# Rendimiento

El Resource System deberá:

- Cargar una sola vez los Resources.
- Compartir instancias.
- Evitar duplicación de memoria.
- Resolver referencias mediante caché.
- Minimizar accesos al disco.

---

# Eventos

Ejemplos:

- ResourceLoaded
- ResourceValidated
- ResourceRegistered
- ResourceReloaded
- ResourceLoadFailed

---

# Convenciones

Todo Resource deberá:

- Tener un ID único.
- Ser inmutable durante la partida.
- Ser compartido entre Systems.
- No contener lógica de ejecución.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Resource System independiente del gameplay.
- Implementar acceso eficiente mediante índices.
- Evitar referencias fuertes innecesarias.
- Favorecer la reutilización de Resources.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar cargas duplicadas.
- Detectar referencias inválidas.
- Verificar la inmutabilidad de los Resources.
- Validar la resolución de dependencias.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado encargado de administrar todos los Resources del proyecto, proporcionando acceso eficiente, validación de dependencias y reutilización de datos estáticos para todos los Systems de Survivors Lords.
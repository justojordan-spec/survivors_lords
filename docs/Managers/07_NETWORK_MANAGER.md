# Input Manager

**Estado:** Draft

---

# Objetivo

El Input Manager es responsable de centralizar la gestión de todas las entradas del usuario dentro del proyecto.

Su función es abstraer el sistema de entrada de Godot y proporcionar una interfaz uniforme para que los distintos sistemas puedan consultar acciones, estados y eventos de entrada sin depender directamente de la implementación del motor.

No implementa lógica de gameplay.

---

# Filosofía

El Input Manager actúa como la única puerta de acceso a la entrada del jugador.

Los Components y Systems nunca deberán consultar directamente la API de Input de Godot.

Esta abstracción permite modificar dispositivos, remapeos, perfiles de control y futuras plataformas sin afectar al resto del proyecto.

---

# Arquitectura

El Input Manager es un AutoLoad disponible durante toda la ejecución de la aplicación.

Su responsabilidad consiste en interpretar las entradas físicas y convertirlas en acciones lógicas definidas por el proyecto.

La lógica de respuesta a dichas acciones pertenece exclusivamente a los sistemas consumidores.

---

# Responsabilidades

El Input Manager es responsable de:

- Gestionar acciones de entrada.
- Consultar estados de entrada.
- Gestionar dispositivos conectados.
- Administrar perfiles de control.
- Gestionar remapeos de teclas cuando corresponda.
- Notificar cambios relevantes relacionados con la entrada.

No es responsable de:

- Mover personajes.
- Controlar cámaras.
- Ejecutar habilidades.
- Gestionar interfaces.
- Implementar reglas de gameplay.

---

# API Pública

La API pública deberá permitir operaciones como:

- Consultar si una acción está activa.
- Consultar si una acción acaba de comenzar.
- Consultar si una acción acaba de finalizar.
- Obtener información del dispositivo activo.
- Cambiar el perfil de entrada.
- Consultar el esquema de controles actual.

La implementación concreta será documentada durante el desarrollo.

---

# Flujo de funcionamiento

El flujo general será:

1. El dispositivo genera una entrada.
2. El Input Manager interpreta la entrada física.
3. La traduce a una acción lógica.
4. Los sistemas consultan dicha acción mediante la API pública.
5. Cada sistema decide cómo responder.

El Input Manager nunca ejecuta acciones de gameplay.

---

# Dependencias

El Input Manager podrá interactuar con:

- Game Manager.
- UI Manager.
- Settings Manager.
- EventBus.

No deberá depender de Components específicos ni de Entities.

---

# Integración con el resto del proyecto

Todos los sistemas que necesiten información sobre la entrada del usuario deberán utilizar exclusivamente el Input Manager.

Ningún Component o Manager deberá acceder directamente a la API `Input` de Godot, salvo casos excepcionales documentados.

Esta centralización garantiza consistencia, facilita el remapeo de controles y mejora la portabilidad entre plataformas.

---

# Consideraciones para Claude

Al generar código:

- Utilizar únicamente el Input Manager para consultar acciones de entrada.
- No acceder directamente a `Input` desde Components o Systems.
- Mantener separada la interpretación de entradas de la lógica de gameplay.
- Diseñar el sistema para soportar múltiples dispositivos y remapeos.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar accesos directos a la API `Input` de Godot fuera del Input Manager.
- Verificar la separación entre entrada y gameplay.
- Validar que las acciones representen intenciones del jugador y no teclas físicas.
- Identificar posibles dependencias innecesarias con dispositivos específicos.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Proporcionar una interfaz única, consistente y desacoplada para la gestión de todas las entradas del usuario, permitiendo soportar múltiples dispositivos, remapeos de controles y futuras plataformas sin modificar la lógica de gameplay.
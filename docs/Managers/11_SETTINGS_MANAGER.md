# Log Manager

**Estado:** Draft

---

# Objetivo

El Log Manager es responsable de centralizar el registro de mensajes generados por la aplicación.

Su función es proporcionar un sistema uniforme para registrar información, advertencias, errores y eventos relevantes durante el desarrollo, las pruebas y la ejecución del juego.

No implementa lógica de gameplay.

---

# Filosofía

Toda la información de diagnóstico del proyecto debe pasar por un único sistema de logging.

Los distintos módulos no deben escribir mensajes directamente mediante funciones del motor o mecanismos propios.

Centralizar el registro facilita la depuración, el mantenimiento y la incorporación futura de sistemas de monitoreo o reporte de errores.

---

# Arquitectura

El Log Manager es un AutoLoad disponible durante toda la ejecución de la aplicación.

Su responsabilidad consiste en recibir mensajes de los distintos sistemas, clasificarlos y dirigirlos al destino correspondiente.

La forma en que los mensajes son almacenados o mostrados permanece encapsulada dentro del Manager.

---

# Responsabilidades

El Log Manager es responsable de:

- Registrar mensajes informativos.
- Registrar advertencias.
- Registrar errores.
- Registrar mensajes de depuración.
- Clasificar mensajes por categoría o nivel.
- Controlar la salida de información según el entorno de ejecución.

No es responsable de:

- Corregir errores.
- Gestionar excepciones.
- Tomar decisiones de gameplay.
- Administrar archivos de guardado.

---

# API Pública

La API pública deberá permitir operaciones como:

- Registrar un mensaje informativo.
- Registrar una advertencia.
- Registrar un error.
- Registrar información de depuración.
- Configurar el nivel de detalle del registro.
- Consultar el estado del sistema de logging.

La implementación concreta será documentada durante el desarrollo.

---

# Flujo de funcionamiento

El flujo general será:

1. Un sistema genera un mensaje.
2. El Log Manager recibe la solicitud.
3. Clasifica el mensaje según su nivel.
4. Aplica los filtros correspondientes.
5. Envía el mensaje al destino configurado.

El proceso será completamente transparente para el sistema emisor.

---

# Dependencias

El Log Manager no deberá depender de otros Managers.

Podrá ser utilizado por:

- Managers.
- Components.
- Systems.
- AI.
- Multiplayer.
- Save System.
- UI.
- Herramientas de desarrollo.

---

# Integración con el resto del proyecto

Todos los sistemas que necesiten registrar información deberán utilizar exclusivamente el Log Manager.

El uso de `print()` o mecanismos equivalentes deberá limitarse al propio Log Manager o a casos excepcionales debidamente documentados.

Esta centralización garantiza un formato uniforme y facilita el análisis de errores durante el desarrollo y la producción.

---

# Consideraciones para Claude

Al generar código:

- Utilizar el Log Manager para registrar información relevante.
- Evitar llamadas directas a `print()` en el código de producción.
- Clasificar correctamente los mensajes según su nivel.
- Mantener los mensajes claros, consistentes y útiles para la depuración.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar llamadas directas a `print()` fuera del Log Manager.
- Verificar que los mensajes estén correctamente clasificados.
- Identificar información de diagnóstico redundante o innecesaria.
- Validar una estrategia de logging consistente en todo el proyecto.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado de registro que proporcione información consistente para el desarrollo, las pruebas y el mantenimiento del proyecto, facilitando la depuración y permitiendo futuras integraciones con herramientas de monitoreo o reporte de errores.
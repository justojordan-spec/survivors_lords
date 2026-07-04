# Settings Manager

**Estado:** Draft

---

# Objetivo

El Settings Manager es responsable de administrar todas las configuraciones y preferencias del usuario.

Su función es proporcionar un punto central para consultar, modificar y persistir opciones de configuración relacionadas con la aplicación, sin interferir con el sistema de guardado del progreso del juego.

No administra datos de gameplay.

---

# Filosofía

Las preferencias del usuario son independientes del progreso de una partida.

El Settings Manager centraliza la configuración de la aplicación para garantizar consistencia entre sesiones y evitar que otros sistemas gestionen preferencias por su cuenta.

La configuración debe estar disponible desde el inicio de la aplicación y permanecer accesible durante toda la ejecución.

---

# Arquitectura

El Settings Manager es un AutoLoad disponible durante todo el ciclo de vida de la aplicación.

Su responsabilidad consiste en administrar las preferencias del usuario y notificar a los sistemas cuando dichas configuraciones cambien.

El almacenamiento físico de las preferencias permanece encapsulado dentro del propio Manager.

---

# Responsabilidades

El Settings Manager es responsable de:

- Gestionar configuraciones de audio.
- Gestionar configuraciones de video.
- Gestionar configuraciones de controles.
- Gestionar configuraciones de accesibilidad.
- Gestionar configuraciones de idioma.
- Cargar las preferencias al iniciar la aplicación.
- Guardar las preferencias cuando corresponda.
- Notificar cambios de configuración.

No es responsable de:

- Guardar partidas.
- Administrar progreso del jugador.
- Gestionar datos de gameplay.
- Controlar la interfaz.

---

# API Pública

La API pública deberá permitir operaciones como:

- Obtener una configuración.
- Modificar una configuración.
- Restablecer configuraciones por defecto.
- Guardar preferencias.
- Cargar preferencias.
- Consultar el estado de las configuraciones.

La implementación concreta será documentada durante el desarrollo.

---

# Flujo de funcionamiento

El flujo general será:

1. Inicio de la aplicación.
2. Carga de las preferencias del usuario.
3. Los sistemas consultan las configuraciones necesarias.
4. El usuario modifica una opción.
5. El Settings Manager valida el cambio.
6. Actualiza el valor.
7. Notifica a los sistemas afectados.
8. Persiste la nueva configuración.

Todo el proceso será coordinado por el Settings Manager.

---

# Dependencias

El Settings Manager podrá interactuar con:

- Audio Manager.
- Input Manager.
- UI Manager.
- EventBus.

No deberá depender de Components ni de Entities.

---

# Integración con el resto del proyecto

Todos los sistemas que necesiten consultar o modificar preferencias del usuario deberán hacerlo exclusivamente mediante el Settings Manager.

Ningún sistema deberá almacenar configuraciones de usuario de manera independiente.

Esto garantiza una experiencia consistente y una única fuente de verdad para las preferencias de la aplicación.

---

# Consideraciones para Claude

Al generar código:

- Centralizar toda la configuración del usuario.
- Separar claramente preferencias de usuario y datos de guardado.
- Notificar los cambios mediante Signals o EventBus cuando corresponda.
- Evitar configuraciones duplicadas en distintos sistemas.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar configuraciones almacenadas fuera del Settings Manager.
- Verificar la separación entre preferencias y progreso del juego.
- Validar una gestión consistente de las configuraciones.
- Identificar posibles duplicaciones de datos.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado para administrar todas las preferencias del usuario, garantizando una configuración consistente, persistente y desacoplada del gameplay, permitiendo que cualquier sistema consulte y actualice opciones mediante una única interfaz pública.
# Localization Manager

**Estado:** Draft

---

# Objetivo

El Localization Manager es responsable de administrar el sistema de localización del proyecto.

Su función es proporcionar una interfaz centralizada para obtener textos, cambiar el idioma activo y gestionar los recursos de traducción utilizados por la aplicación.

No implementa lógica de gameplay ni controla la interfaz de usuario.

---

# Filosofía

Todo el texto mostrado al jugador debe provenir del sistema de localización.

Los sistemas del proyecto nunca deberán utilizar cadenas de texto fijas para contenido visible al usuario.

La localización debe permanecer completamente desacoplada de la lógica del juego y de la implementación de la interfaz.

---

# Arquitectura

El Localization Manager es un AutoLoad disponible durante toda la ejecución de la aplicación.

Su responsabilidad consiste en administrar el idioma activo, proporcionar acceso a los recursos de traducción y notificar los cambios de idioma cuando corresponda.

La organización física de los archivos de traducción permanece encapsulada dentro del Manager.

---

# Responsabilidades

El Localization Manager es responsable de:

- Gestionar el idioma activo.
- Obtener textos traducidos.
- Cambiar el idioma de la aplicación.
- Cargar recursos de localización.
- Notificar cambios de idioma.
- Proporcionar acceso uniforme a las traducciones.

No es responsable de:

- Dibujar la interfaz.
- Gestionar fuentes.
- Administrar preferencias del usuario.
- Implementar lógica de gameplay.

---

# API Pública

La API pública deberá permitir operaciones como:

- Obtener un texto localizado.
- Cambiar el idioma activo.
- Consultar el idioma actual.
- Obtener la lista de idiomas disponibles.
- Recargar los recursos de localización cuando sea necesario.

La implementación concreta será documentada durante el desarrollo.

---

# Flujo de funcionamiento

El flujo general será:

1. Inicio de la aplicación.
2. Carga del idioma configurado.
3. Los sistemas solicitan textos mediante la API.
4. El usuario cambia el idioma.
5. El Localization Manager actualiza el idioma activo.
6. Se notifica a la interfaz para refrescar los textos visibles.

Todo el proceso permanece transparente para los sistemas consumidores.

---

# Dependencias

El Localization Manager podrá interactuar con:

- Settings Manager.
- Resource Manager.
- UI Manager.
- EventBus.

No deberá depender de Components ni de Entities.

---

# Integración con el resto del proyecto

Todos los textos visibles para el jugador deberán obtenerse mediante el Localization Manager.

Los sistemas del proyecto no deberán almacenar cadenas localizadas ni depender del idioma activo.

Esta centralización garantiza consistencia y facilita la incorporación de nuevos idiomas.

---

# Consideraciones para Claude

Al generar código:

- Obtener todos los textos visibles mediante el Localization Manager.
- Evitar cadenas de texto hardcodeadas en la lógica del juego.
- Mantener separada la localización de la interfaz y del gameplay.
- Diseñar el sistema para soportar la incorporación de nuevos idiomas sin modificar el código existente.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar cadenas visibles hardcodeadas.
- Verificar que todas las traducciones pasen por el Localization Manager.
- Validar la separación entre localización, interfaz y configuración.
- Identificar posibles dependencias innecesarias con recursos específicos.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Proporcionar un sistema centralizado para la gestión de la localización del proyecto, permitiendo que todos los textos visibles al jugador sean obtenidos de forma consistente, desacoplada y preparada para soportar múltiples idiomas durante toda la vida del juego.
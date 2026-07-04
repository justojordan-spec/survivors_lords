# Audio Manager

**Estado:** Draft

---

# Objetivo

El Audio Manager es responsable de administrar la reproducción de audio del proyecto.

Su función es coordinar la reproducción de música, efectos de sonido y audio ambiental, proporcionando una interfaz uniforme para todos los sistemas del juego.

No implementa lógica de gameplay ni decide cuándo debe reproducirse un sonido.

---

# Filosofía

El Audio Manager actúa como un servicio de reproducción.

Los distintos sistemas solicitan la reproducción de audio mediante su API pública, mientras que el Audio Manager se encarga de gestionar canales, volumen, prioridades y configuración.

Los recursos de audio permanecen desacoplados de la lógica del juego.

---

# Arquitectura

El Audio Manager es un AutoLoad disponible durante toda la ejecución de la aplicación.

Su responsabilidad consiste en administrar la infraestructura de audio del proyecto, coordinando la reproducción y el control de los distintos tipos de sonido.

La lógica que determina cuándo reproducir un audio pertenece exclusivamente a los sistemas consumidores.

---

# Responsabilidades

El Audio Manager es responsable de:

- Reproducir efectos de sonido.
- Reproducir música.
- Gestionar audio ambiental.
- Controlar volumen global.
- Administrar buses de audio.
- Gestionar pausas y reanudaciones de reproducción.
- Coordinar transiciones musicales cuando corresponda.

No es responsable de:

- Decidir cuándo reproducir sonidos.
- Administrar recursos de gameplay.
- Gestionar configuraciones del jugador.
- Controlar la interfaz de usuario.

---

# API Pública

La API pública deberá permitir operaciones como:

- Reproducir un efecto de sonido.
- Reproducir música.
- Detener reproducción.
- Pausar audio.
- Reanudar reproducción.
- Cambiar volumen.
- Consultar el estado de reproducción.

La implementación concreta será documentada durante el desarrollo.

---

# Flujo de funcionamiento

El flujo general será:

1. Un sistema solicita la reproducción de un audio.
2. El Audio Manager valida la solicitud.
3. Selecciona el canal correspondiente.
4. Reproduce el recurso solicitado.
5. Gestiona el ciclo de vida de la reproducción.
6. Libera los recursos cuando finaliza.

Todo el proceso permanece transparente para el sistema solicitante.

---

# Dependencias

El Audio Manager podrá interactuar con:

- Resource Manager.
- Settings Manager.
- EventBus.
- Game Manager.

No deberá depender de Components específicos ni de Entities.

---

# Integración con el resto del proyecto

Todos los sistemas que necesiten reproducir audio deberán utilizar exclusivamente el Audio Manager.

Ningún Component o Manager deberá instanciar reproductores de audio globales por su cuenta.

Esto garantiza una gestión consistente de canales, volumen y prioridades.

---

# Consideraciones para Claude

Al generar código:

- Centralizar toda la reproducción de audio.
- Evitar lógica de gameplay dentro del Audio Manager.
- Reutilizar recursos cuando sea posible.
- Gestionar correctamente buses y canales de audio.
- Preparar la arquitectura para futuras optimizaciones.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar reproducción directa de audio fuera del Audio Manager.
- Verificar que la lógica de reproducción permanezca desacoplada del gameplay.
- Validar una correcta gestión de canales y recursos.
- Identificar posibles duplicaciones innecesarias.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Proporcionar un sistema centralizado para la reproducción de audio del proyecto, garantizando una gestión consistente de música, efectos y sonido ambiental, manteniendo la lógica de reproducción desacoplada del resto de los sistemas y preparada para futuras ampliaciones.
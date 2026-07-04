# Experience Component

**Estado:** Draft

---

# Objetivo

El Experience Component es responsable de administrar la experiencia acumulada por una Entity.

Su función es registrar la obtención, pérdida y consulta de puntos de experiencia, proporcionando una interfaz uniforme para los sistemas de progresión del juego.

No administra el nivel de la Entity.

---

# Filosofía

La experiencia representa el progreso acumulado de una Entity.

El nivel es una consecuencia de ese progreso, pero constituye una responsabilidad independiente.

El Experience Component únicamente administra la experiencia.

---

# Arquitectura

El Experience Component encapsula todo el estado relacionado con la experiencia.

La conversión entre experiencia y nivel será determinada por reglas externas definidas mediante Resources o Systems especializados.

El Component no conocerá cómo se calcula el nivel.

---

# Responsabilidades

El Experience Component es responsable de:

- Almacenar experiencia acumulada.
- Agregar experiencia.
- Restar experiencia cuando corresponda.
- Consultar la experiencia actual.
- Notificar cambios de experiencia.

No es responsable de:

- Administrar niveles.
- Desbloquear habilidades.
- Modificar estadísticas.
- Otorgar recompensas.
- Ejecutar lógica de progresión.

---

# API Pública

La API pública deberá permitir operaciones como:

- Obtener experiencia actual.
- Agregar experiencia.
- Restar experiencia.
- Establecer experiencia.
- Consultar progreso acumulado.

La implementación concreta será documentada durante el desarrollo.

---

# Estado Interno

El Component administrará:

- Experiencia actual.
- Experiencia acumulada.
- Límites definidos por el diseño.

Toda esta información permanecerá encapsulada.

---

# Signals

El Component podrá emitir eventos como:

- Experiencia agregada.
- Experiencia eliminada.
- Experiencia modificada.

Los nombres concretos de las Signals se definirán durante la implementación.

---

# Dependencias

El Experience Component podrá interactuar con:

- EventBus.
- Resource Manager.
- Systems de progresión.

No deberá depender directamente del Level Component.

---

# Integración con el resto del proyecto

La experiencia podrá obtenerse mediante:

- Eliminación de enemigos.
- Misiones.
- Eventos.
- Logros.
- Objetos.
- Actividades especiales.

Los sistemas correspondientes utilizarán la API pública del Experience Component para modificar la experiencia.

---

# Rendimiento

El Component deberá:

- Mantener un estado interno mínimo.
- Evitar cálculos innecesarios.
- Emitir únicamente eventos relevantes.
- Escalar correctamente para múltiples Entities.

---

# Multiplayer

Las modificaciones de experiencia deberán sincronizarse según el modelo Host-Client.

La autoridad sobre los cambios de experiencia corresponderá al Host o al servidor dedicado.

---

# Consideraciones para Claude

Al generar código:

- Mantener completamente separado el sistema de experiencia del sistema de niveles.
- Evitar cálculos de progresión dentro del Component.
- Utilizar Resources para definir las reglas de progresión.
- Diseñar una API sencilla y consistente.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica de niveles dentro del Experience Component.
- Verificar la separación entre experiencia y progresión.
- Validar una correcta encapsulación del estado.
- Identificar responsabilidades mezcladas.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema reutilizable para administrar la experiencia acumulada por cualquier Entity, proporcionando una base flexible para distintos modelos de progresión sin acoplar la experiencia al sistema de niveles.
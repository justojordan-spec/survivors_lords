# Stats Component

**Estado:** Draft

---

# Objetivo

El Stats Component es responsable de administrar todos los atributos numéricos de una Entity.

Su función es proporcionar un sistema centralizado para consultar y modificar estadísticas como vida máxima, velocidad, daño, defensa, probabilidad crítica y cualquier otro atributo definido por el diseño del juego.

No implementa lógica de gameplay.

---

# Filosofía

Los atributos representan el estado numérico de una Entity.

El Stats Component únicamente almacena y calcula dichos valores.

Las mecánicas que utilizan estos atributos pertenecen a otros Components o Systems.

El Component no interpreta el significado del atributo; únicamente administra su valor.

---

# Arquitectura

El Stats Component encapsula todas las estadísticas de una Entity.

Cada estadística podrá estar compuesta por:

- Valor base.
- Modificadores.
- Bonificaciones temporales.
- Valor final calculado.

El cálculo permanecerá completamente encapsulado.

---

# Responsabilidades

El Stats Component es responsable de:

- Mantener estadísticas.
- Calcular valores finales.
- Aplicar modificadores.
- Eliminar modificadores.
- Consultar atributos.
- Notificar cambios relevantes.

No es responsable de:

- Aplicar daño.
- Mover la Entity.
- Gestionar inventarios.
- Ejecutar habilidades.
- Controlar IA.

---

# API Pública

La API pública deberá permitir operaciones como:

- Obtener una estadística.
- Modificar una estadística.
- Agregar modificadores.
- Eliminar modificadores.
- Recalcular atributos.
- Consultar el valor final.

La implementación concreta será documentada durante el desarrollo.

---

# Estado Interno

El Component administrará:

- Estadísticas base.
- Modificadores permanentes.
- Modificadores temporales.
- Valor final de cada atributo.

Toda esta información permanecerá encapsulada.

---

# Signals

El Component podrá emitir eventos como:

- Estadística modificada.
- Recalculo completado.
- Modificador agregado.
- Modificador eliminado.

---

# Dependencias

El Stats Component podrá interactuar con:

- Resource Manager.
- EventBus.
- Buff Component.
- Equipment Component.

No deberá depender del sistema de combate ni del movimiento.

---

# Integración con el resto del proyecto

Todos los Components que necesiten atributos deberán consultarlos mediante el Stats Component.

Ningún Component deberá mantener copias locales de estadísticas globales.

---

# Rendimiento

El Component deberá minimizar:

- Recalculos innecesarios.
- Asignaciones repetidas.
- Duplicación de datos.

Siempre que sea posible, los valores calculados deberán almacenarse en caché.

---

# Multiplayer

Las estadísticas deberán poder sincronizarse correctamente.

El Component no implementará lógica de red.

La sincronización será responsabilidad del sistema correspondiente.

---

# Consideraciones para Claude

Al generar código:

- Mantener completamente encapsulado el cálculo de estadísticas.
- Evitar duplicación de atributos.
- Recalcular únicamente cuando sea necesario.
- Separar datos y lógica de gameplay.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar estadísticas duplicadas.
- Verificar el encapsulamiento.
- Validar el sistema de modificadores.
- Identificar cálculos redundantes.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Proporcionar un sistema centralizado para la gestión de todos los atributos numéricos de una Entity, permitiendo que el resto del gameplay consulte estadísticas de forma consistente, desacoplada y eficiente.
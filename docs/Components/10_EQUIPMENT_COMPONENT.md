# Equipment Component

**Estado:** Draft

---

# Objetivo

El Equipment Component representa el conjunto de objetos actualmente equipados por una entidad dentro de Survivors Lords.

Su propósito es almacenar las referencias a los ítems equipados y proporcionar la información necesaria para que otros Systems calculen sus efectos.

No administra inventarios, durabilidad, estadísticas ni lógica de equipamiento.

---

# Filosofía

El Equipment Component únicamente almacena el estado del equipamiento actual de una entidad.

Toda la lógica relacionada con equipar, desequipar, validar requisitos y aplicar bonificaciones será responsabilidad del Equipment System.

---

# Arquitectura

El Equipment Component pertenece exclusivamente a entidades que pueden equipar objetos.

Ejemplos:

- Player
- NPC
- Mercenarios
- Jefes
- Criaturas humanoides

---

# Información almacenada

El componente podrá contener referencias a:

- Casco
- Pechera
- Guantes
- Pantalones
- Botas
- Capa
- Collar
- Amuleto
- Anillo izquierdo
- Anillo derecho
- Arma principal
- Arma secundaria
- Escudo
- Herramienta
- Munición
- Objetos especiales

Todas las referencias apuntarán a Item Resources o a las entidades que los representen en tiempo de ejecución, según la arquitectura adoptada.

---

# Slots

Cada slot podrá definir:

- Tipo de slot.
- Objeto equipado.
- Estado ocupado/libre.
- Restricciones.

Los tipos de slot serán configurables mediante EquipmentSlot Resources.

---

# Restricciones

El Equipment Component no valida:

- Nivel requerido.
- Profesión requerida.
- Clase requerida.
- Peso.
- Compatibilidad.
- Durabilidad.
- Maldiciones.
- Requisitos especiales.

Estas validaciones pertenecen al Equipment System.

---

# Relaciones

Puede interactuar con:

- Inventory Component.
- Stats Component.
- Character Component.
- Ability Component.
- Durability Component.

Siempre mediante Systems.

---

# Responsabilidades

El Equipment Component es responsable de:

- Almacenar los objetos equipados.
- Mantener el estado de los slots.
- Exponer referencias al Equipment System.

No es responsable de:

- Equipar objetos.
- Desequipar objetos.
- Validar requisitos.
- Aplicar bonificaciones.
- Modificar estadísticas.
- Gestionar inventarios.
- Ejecutar lógica.

---

# Integración con el resto del proyecto

Será utilizado por:

- Equipment System.
- Inventory System.
- Combat System.
- Character System.
- Stats System.
- Durability System.
- Ability System.
- UI System.
- Save System.

---

# Rendimiento

El Equipment Component deberá:

- Mantener únicamente referencias.
- Evitar duplicar información contenida en los Item Resources.
- Ser ligero.
- Permitir acceso rápido por slot.

---

# Multiplayer

El estado del equipamiento será sincronizado por el servidor.

El Equipment Component no contiene lógica de sincronización.

---

# Convenciones

Todo Equipment Component deberá:

- Contener únicamente datos.
- No contener lógica.
- Mantener referencias válidas.
- Evitar duplicar estadísticas.

---

# Consideraciones para Claude

Al generar código:

- Mantener el componente como un contenedor de datos.
- Evitar cualquier lógica de equipamiento.
- Representar los slots mediante estructuras reutilizables.
- Permitir distintos tipos de entidades equipables.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica implementada dentro del componente.
- Verificar que solo almacene referencias.
- Detectar duplicación de datos.
- Validar la separación entre Component y Equipment System.

---

# Estado

**Fase:** 2 – Componentes

**Estado:** Draft

---

# Objetivo Final

Disponer de un componente ligero y completamente Data Driven que represente el equipamiento actual de una entidad, desacoplado de la lógica del Equipment System y preparado para integrarse con los sistemas de inventario, combate, estadísticas, durabilidad y guardado.
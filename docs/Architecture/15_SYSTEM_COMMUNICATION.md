# System Communication

**Proyecto:** Survivors Lords

**Versión:** 1.0

---

# Objetivo

Este documento define las reglas oficiales de comunicación entre todos los Systems de Survivors Lords.

Su propósito es garantizar una arquitectura desacoplada, modular y escalable, evitando dependencias innecesarias entre Systems.

---

# Filosofía

Los Systems colaboran entre sí.

Los Systems nunca controlan a otros Systems.

Cada System mantiene su propia responsabilidad y expone únicamente la información necesaria mediante mecanismos de comunicación definidos.

---

# Principios

Toda comunicación deberá cumplir:

- Bajo acoplamiento.
- Alta cohesión.
- Comunicación explícita.
- Arquitectura modular.
- Independencia entre Systems.

---

# Métodos de Comunicación

Los Systems podrán comunicarse únicamente mediante los siguientes mecanismos.

## 1. Eventos

Los eventos notifican que algo ocurrió.

Características:

- Comunicación unidireccional.
- Desacoplada.
- Asíncrona.
- No devuelve resultados.

Ejemplos:

- EnemyKilled
- QuestCompleted
- BuildingConstructed
- WeatherChanged

---

## 2. Interfaces

Las interfaces permiten acceder a funcionalidades públicas de otro System.

Características:

- Comunicación directa.
- Bajo acoplamiento.
- Contratos claramente definidos.

Ejemplos:

- Obtener inventario.
- Consultar clima actual.
- Obtener datos del jugador.

---

## 3. Consultas (Queries)

Las consultas permiten obtener información sin modificar el estado del juego.

Características:

- Solo lectura.
- Sin efectos secundarios.
- Deterministas.

Ejemplos:

- Obtener recursos disponibles.
- Consultar tecnología desbloqueada.
- Consultar reputación.

---

# Métodos Prohibidos

No está permitido:

- Modificar variables internas de otro System.
- Acceder directamente a Components ajenos.
- Compartir referencias mutables.
- Crear dependencias circulares.
- Ejecutar lógica perteneciente a otro System.

---

# Flujo Recomendado

Gameplay

↓

Genera Evento

↓

Event System

↓

Systems interesados

↓

Actualización independiente

---

# Ejemplo

Incorrecto

Combat System

↓

Inventory System.ModificarObjeto()

---

Correcto

Combat System

↓

ItemDropped Event

↓

Inventory System

↓

Actualizar Inventario

---

# Comunicación entre Categorías

## Gameplay

Puede:

- Generar eventos.
- Consultar información.
- Utilizar interfaces.

---

## Mundo

Puede:

- Publicar cambios ambientales.
- Responder consultas.

---

## Infraestructura

Puede:

- Sincronizar.
- Guardar.
- Registrar eventos.

Nunca deberá ejecutar gameplay.

---

# Reglas

Todo System deberá:

- Escuchar únicamente eventos necesarios.
- Exponer únicamente interfaces públicas.
- Evitar dependencias innecesarias.
- Mantener independencia funcional.

---

# Buenas Prácticas

Preferir:

- Eventos para notificaciones.
- Interfaces para servicios.
- Queries para consultas.

Evitar:

- Llamadas cruzadas innecesarias.
- Dependencias bidireccionales.
- Lógica compartida.

---

# Consideraciones para Claude

Al generar código:

- Favorecer Event Driven.
- Utilizar interfaces bien definidas.
- Evitar referencias directas.
- Mantener los Systems independientes.
- Aplicar el principio de responsabilidad única.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar acoplamiento excesivo.
- Detectar dependencias innecesarias.
- Revisar uso correcto de eventos.
- Validar interfaces públicas.
- Verificar separación de responsabilidades.

---

# Objetivo Final

Disponer de una arquitectura de comunicación uniforme donde todos los Systems interactúen mediante eventos, interfaces y consultas, garantizando una base sólida, escalable y fácil de mantener durante toda la vida del proyecto.
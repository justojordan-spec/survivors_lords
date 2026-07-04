# System Dependencies

**Proyecto:** Survivors Lords

**Versión:** 1.0

---

# Objetivo

Este documento define las dependencias permitidas entre los Systems del proyecto.

Su propósito es mantener una arquitectura desacoplada, modular y fácil de mantener, evitando dependencias circulares y responsabilidades compartidas.

---

# Filosofía

Los Systems deben colaborar entre sí, pero nunca depender fuertemente unos de otros.

Siempre que sea posible, la comunicación deberá realizarse mediante:

- Eventos.
- Interfaces.
- Consultas.

Las referencias directas deberán reducirse al mínimo.

---

# Reglas Generales

## Dependencias permitidas

Un System puede depender de otro únicamente cuando:

- Necesita consultar información.
- Utiliza una interfaz pública.
- Consume eventos generados por otro System.

---

## Dependencias prohibidas

No está permitido:

- Dependencias circulares.
- Modificar directamente el estado interno de otro System.
- Compartir datos mutables.
- Ejecutar lógica perteneciente a otro System.

---

# Dependencias Base

Todos los Systems podrán depender de:

- Game System
- Resource System
- Event System

Estos constituyen el núcleo de la arquitectura.

---

# Dependencias por Categoría

## Gameplay

Puede depender de:

- Entity System
- Component System
- Time System
- Resource System

---

## Inventario

Puede depender de:

- Item System
- Resource System

No debe depender del Combat System.

---

## Construcción

Puede depender de:

- Resource System
- Inventory System
- Technology System

No debe depender directamente del Economy System.

---

## Economía

Puede consultar:

- Building System
- Settlement System
- Profession System

No debe modificar ninguno de ellos.

---

## IA y Enemigos

Puede consultar:

- World System
- Time System
- Weather System

Nunca deberá modificar directamente otros Systems.

---

# Dependencias Recomendadas

Siempre utilizar:

- Interfaces.
- Eventos.
- Recursos compartidos.

Evitar:

- Referencias directas.
- Singletons innecesarios.
- Objetos globales.

---

# Flujo de Dependencias

La dirección recomendada es:

Core

↓

World

↓

Gameplay

↓

Features

↓

Infrastructure

Nunca al revés.

---

# Dependencias Circulares

Quedan prohibidas.

Ejemplo incorrecto:

Combat System

↓

Inventory System

↓

Combat System

---

Ejemplo correcto

Combat System

↓

Event

↓

Inventory System

---

# Validación

Toda nueva dependencia deberá responder afirmativamente a las siguientes preguntas:

- ¿Es realmente necesaria?
- ¿Puede resolverse mediante eventos?
- ¿Puede resolverse mediante una interfaz?
- ¿Introduce acoplamiento innecesario?

Si alguna respuesta es negativa, la dependencia deberá replantearse.

---

# Consideraciones para Claude

Al generar código:

- Evitar dependencias circulares.
- Favorecer interfaces.
- Favorecer eventos.
- Reducir referencias directas.
- Mantener el principio de responsabilidad única.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar acoplamiento excesivo.
- Detectar dependencias innecesarias.
- Detectar ciclos de dependencia.
- Verificar uso correcto de interfaces.
- Validar cumplimiento de la arquitectura.

---

# Objetivo Final

Garantizar que todos los Systems permanezcan desacoplados, reutilizables y escalables, permitiendo que la arquitectura pueda evolucionar sin introducir dependencias innecesarias o difíciles de mantener.
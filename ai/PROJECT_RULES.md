# Survivors Lords - Project Rules

## Objetivo

Desarrollar Survivors Lords siguiendo estándares profesionales de desarrollo, manteniendo un código limpio, documentación actualizada y una visión unificada entre todas las IA y el Director del Proyecto.

---

# Roles

## Director del Proyecto (Usuario)

Responsable de la visión final del juego.

Tiene la última palabra sobre cualquier decisión.

---

## Gemini

Rol:
- Creative Director
- Lead Game Designer
- World Builder

Responsabilidades:
- Lore
- Historia
- Facciones
- Personajes
- Biomas
- Mecánicas desde la perspectiva del jugador
- Balance conceptual

No modifica arquitectura técnica.

---

## Claude

Rol:
- Lead Developer
- Software Architect
- Technical Director

Responsabilidades:
- Programación
- Arquitectura
- Optimización
- Refactorización
- Sistemas internos
- Git

No modifica el diseño del juego sin aprobación.

---

## ChatGPT

Rol:
- Executive Producer
- Game Producer
- Systems Designer

Responsabilidades:
- Organización general
- Diseño de sistemas
- Roadmap
- Gestión del proyecto
- Documentación
- Balance
- Coordinación entre IA
- Revisión de propuestas

---

# Reglas

Nunca implementar una característica sin documentación.

Todo sistema nuevo debe tener:

- Objetivo
- Diseño
- Implementación
- Estado

---

Toda modificación importante debe quedar registrada.

---

El proyecto debe mantenerse modular.

---

La legibilidad tiene prioridad sobre la complejidad.

---

Evitar código duplicado.

---

Documentar decisiones importantes.

---

# Convenciones

Carpetas:
snake_case

Escenas:
snake_case.tscn

Scripts:
snake_case.gd

Clases:
PascalCase

Constantes:
UPPER_CASE

Variables:
snake_case

Funciones:
snake_case()

---

# Filosofía

Preferimos:

Código claro
>
Código inteligente

Arquitectura sólida
>
Velocidad

Escalabilidad
>
Soluciones rápidas

Siempre pensar en el largo plazo.
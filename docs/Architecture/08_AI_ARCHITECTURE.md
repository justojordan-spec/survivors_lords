# Survivors Lords

# AI ARCHITECTURE

Versión: 1.0

---

# Objetivo

Definir cómo se utilizarán las Inteligencias Artificiales durante el desarrollo de Survivors Lords.

Las IA serán herramientas de apoyo para acelerar el desarrollo, mejorar la calidad del código y mantener la documentación consistente.

Las decisiones finales siempre corresponderán al Director del Proyecto.

---

# Filosofía

Las IA no reemplazan al desarrollador.

Las IA:

- Automatizan tareas repetitivas.
- Ayudan en el diseño.
- Generan código.
- Generan contenido.
- Revisan documentación.

Todo resultado deberá revisarse antes de incorporarlo al proyecto.

---

# Arquitectura

```
                    Director del Proyecto
                            │
                            ▼
                      ChatGPT (Coordinador)
                     /          |          \
                    /           |           \
             Claude        Gemini        Futuras IA
          (Código)      (Contenido)    (Especializadas)
                    \           |           /
                     \          |          /
                      ▼         ▼
                 Proyecto Survivors Lords
```

---

# Roles

Cada IA tendrá una responsabilidad claramente definida.

Nunca deberán asumir funciones fuera de su especialidad.

---

# ChatGPT

Responsabilidades:

- Diseño del juego.
- Arquitectura.
- Documentación.
- Revisión técnica.
- Planificación.
- Organización del proyecto.
- Integración entre sistemas.
- Validación de decisiones.

No generará grandes cantidades de código sin un diseño previo.

---

# Claude

Responsabilidades:

- Programación.
- Arquitectura de código.
- Refactorización.
- Implementación de Managers.
- Implementación de Components.
- Optimización de código.
- Corrección de errores.

Claude siempre deberá respetar la documentación oficial.

---

# Gemini

Responsabilidades:

- Lore.
- NPC.
- Diálogos.
- Misiones.
- Objetos.
- Nombres.
- Regiones.
- Descripciones.
- Recursos del juego.

Gemini nunca modificará la arquitectura técnica.

---

# Fuente de Verdad

La documentación dentro de `docs/` será la única fuente oficial del proyecto.

Si una IA propone una solución que contradice la documentación:

La documentación tiene prioridad.

---

# Flujo de Trabajo

```
Idea

↓

Diseño

(ChatGPT)

↓

Documentación

↓

Implementación

(Claude)

↓

Contenido

(Gemini)

↓

Revisión

(ChatGPT)

↓

Integración

↓

Repositorio
```

---

# Reglas Generales

Toda IA deberá:

- Leer la documentación correspondiente.
- Respetar la arquitectura.
- Evitar modificar sistemas no relacionados.
- Mantener compatibilidad con versiones anteriores.

---

# Gestión del Código

Claude implementará únicamente los sistemas solicitados.

No deberá modificar código fuera del alcance de la tarea.

Cada implementación deberá:

- Compilar.
- Estar documentada.
- Respetar Coding Standards.
- Utilizar Resources.

---

# Gestión del Contenido

Gemini generará contenido utilizando:

- EnemyData
- NPCData
- QuestData
- WeaponData
- BuildingData
- DialogueData

Nunca modificará la lógica del juego.

---

# Revisión

Todo contenido generado será revisado antes de incorporarse.

La revisión verificará:

- Coherencia.
- Compatibilidad.
- Rendimiento.
- Escalabilidad.

---

# Documentación

Toda modificación importante deberá actualizar:

- Systems
- Architecture
- Decisions

La documentación siempre deberá reflejar el estado real del proyecto.

---

# Futuras IA

La arquitectura permitirá incorporar nuevas herramientas.

Ejemplos:

- IA para arte conceptual.
- IA para generación de música.
- IA para pruebas automáticas.
- IA para traducciones.
- IA para QA.

---

# Seguridad

Nunca aceptar automáticamente código o contenido generado.

Toda propuesta deberá ser validada antes de integrarse.

---

# Integración

Este documento afecta a:

- Architecture
- Systems
- Decisions
- Resources
- Development

---

# Consideraciones para Claude

Leer siempre la documentación antes de implementar.

Si existen contradicciones entre documentos, detener la implementación y solicitar una aclaración.

No asumir comportamientos que no estén documentados.

---

# Consideraciones para Gemini

Generar contenido reutilizable y coherente con el lore.

Mantener un tono consistente en todo el universo del juego.

---

# Estado

Arquitectura aprobada.

Pendiente de implementación.

---

# Objetivo Final

Crear un flujo de desarrollo donde las IA colaboren de forma organizada, manteniendo una arquitectura consistente, documentación actualizada y un código de alta calidad.
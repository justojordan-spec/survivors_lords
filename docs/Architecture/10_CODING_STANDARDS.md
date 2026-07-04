# Survivors Lords

# CODING STANDARDS

Versión: 1.0

---

# Objetivo

Definir los estándares de programación oficiales de Survivors Lords.

Todo el código deberá ser consistente, legible, modular y fácil de mantener.

Estos estándares aplican a cualquier contribución realizada por personas o Inteligencias Artificiales.

---

# Filosofía

El código debe ser:

- Claro.
- Simple.
- Modular.
- Escalable.
- Reutilizable.
- Fácil de depurar.

El código se escribe para que otras personas puedan entenderlo.

---

# Principios

- Una clase = una responsabilidad.
- Una función = una tarea.
- Evitar duplicación.
- Priorizar claridad antes que complejidad.
- Preferir composición sobre herencia.

---

# Idioma

Todo el código deberá escribirse en inglés.

Ejemplos:

Correcto:

PlayerManager

HealthComponent

QuestSystem

Incorrecto:

AdministradorJugador

Vida

Mision

---

# Nombres

Las clases utilizarán PascalCase.

Ejemplos:

PlayerManager

CombatComponent

SaveManager

---

Variables

camelCase

Ejemplo:

playerHealth

currentQuest

attackSpeed

---

Constantes

UPPER_CASE

Ejemplo:

MAX_LEVEL

DEFAULT_SPEED

MAX_STACK_SIZE

---

Funciones

camelCase

Ejemplo:

calculateDamage()

spawnEnemy()

loadSave()

---

Archivos

PascalCase

Ejemplo:

Player.gd

InventoryManager.gd

EnemyData.gd

---

Escenas

PascalCase

Ejemplo:

Player.tscn

Goblin.tscn

Kingdom.tscn

---

Resources

PascalCase

Ejemplo:

IronSword.tres

GoblinData.tres

ForestBiome.tres

---

# Organización

Orden recomendado:

1. class_name

2. extends

3. Constantes

4. Enums

5. Export Variables

6. Variables Privadas

7. _ready()

8. _process()

9. Funciones Públicas

10. Funciones Privadas

---

# Funciones

Las funciones deben ser pequeñas.

Ideal:

10 a 30 líneas.

Si una función supera las 50 líneas deberá evaluarse dividirla.

---

# Comentarios

Comentar:

- Algoritmos complejos.
- Decisiones importantes.
- Código temporal.

No comentar código obvio.

Incorrecto:

```
player.health -= damage
# Restar vida
```

Correcto:

```
# El daño verdadero depende de la armadura y de los buffs activos.
```

---

# Valores Hardcodeados

Prohibido.

Incorrecto:

```
damage = 25
```

Correcto:

```
damage = weaponData.damage
```

---

# Dependencias

Evitar referencias directas.

Preferir:

- Signals.
- EventBus.
- Managers.
- Interfaces.

---

# Componentes

Toda funcionalidad reutilizable deberá implementarse como Component.

Ejemplos:

HealthComponent

CombatComponent

InventoryComponent

SkillComponent

InteractionComponent

---

# Managers

Los Managers coordinan.

No implementan toda la lógica.

Toda lógica específica deberá vivir en Components o Systems.

---

# Resources

Toda configuración utilizará Resources.

Nunca almacenar datos permanentes dentro del código.

---

# Errores

Nunca ignorar errores.

Registrar información útil para depuración.

Los mensajes deberán indicar:

- Sistema.
- Función.
- Motivo.

---

# Logs

Formato recomendado:

```
[Inventory] Item added.

[Save] Save completed.

[Combat] Critical hit.
```

---

# Optimización

No optimizar sin medir.

Utilizar siempre el profiler antes de modificar algoritmos.

---

# Seguridad

Validar siempre:

- Parámetros.
- Referencias.
- Resources.
- Datos de red.
- Archivos de guardado.

---

# Testing

Todo sistema importante deberá poder probarse de forma independiente.

Evitar dependencias innecesarias.

---

# Documentación

Toda clase importante deberá incluir una descripción al inicio.

Ejemplo:

```
# Manages the player's inventory and item transfers.
```

Las funciones públicas deberán indicar:

- Propósito.
- Parámetros.
- Valor de retorno (si corresponde).

---

# Revisión de Código

Antes de aceptar cambios verificar:

- Compila sin errores.
- Respeta la arquitectura.
- Sigue los Coding Standards.
- No rompe otros sistemas.
- Está documentado.

---

# Integración

Este documento afecta a todo el código del proyecto.

Es obligatorio para cualquier implementación.

---

# Consideraciones para Claude

Todo código generado deberá seguir estas normas.

Si una petición contradice este documento, solicitar aclaración antes de continuar.

---

# Consideraciones para Gemini

No generar ejemplos de código que incumplan estos estándares.

Toda referencia técnica deberá respetar la nomenclatura oficial.

---

# Estado

Arquitectura aprobada.

Pendiente de implementación.

---

# Objetivo Final

Mantener una base de código limpia, consistente y preparada para crecer durante todo el desarrollo de Survivors Lords.
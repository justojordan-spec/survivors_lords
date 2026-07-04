# Survivors Lords

# CODING STANDARDS

Versión: 1.0

---

# Objetivo

Definir los estándares de programación del proyecto.

Todo el código deberá seguir estas reglas para garantizar calidad, consistencia y facilidad de mantenimiento.

---

# Filosofía

El código debe ser:

- Claro.
- Modular.
- Reutilizable.
- Escalable.
- Fácil de leer.

Siempre escribir código pensando que otra persona deberá mantenerlo.

---

# Principios

- KISS (Keep It Simple, Stupid)
- DRY (Don't Repeat Yourself)
- SOLID (adaptado a Godot)
- Composición antes que Herencia

---

# Tipado

Utilizar tipado estático siempre que sea posible.

Ejemplo:

```gdscript
var health: int = 100
var speed: float = 5.0
var inventory: Array[ItemData]
```

Evitar variables sin tipo salvo que sea estrictamente necesario.

---

# Variables

Utilizar snake_case.

Correcto:

player_health

enemy_speed

inventory_size

Incorrecto:

PlayerHealth

EnemySpeed

myVariable

---

# Constantes

Siempre en MAYÚSCULAS.

Ejemplo:

MAX_HEALTH

DEFAULT_SPEED

PLAYER_LAYER

---

# Clases

Utilizar PascalCase.

Ejemplo:

PlayerController

EnemyAI

InventoryManager

---

# Funciones

Utilizar snake_case.

Ejemplo:

take_damage()

load_game()

spawn_enemy()

---

# Longitud de funciones

Recomendado:

Menos de 30 líneas.

Máximo:

50 líneas.

Si una función supera ese tamaño debe dividirse.

---

# Longitud de Scripts

Recomendado:

Menos de 300 líneas.

Máximo:

500 líneas.

Si supera ese tamaño debe separarse en componentes.

---

# Comentarios

Comentar únicamente cuando sea necesario.

Evitar comentarios obvios.

Correcto:

# Calcula daño crítico según la probabilidad del arma.

Incorrecto:

# Suma uno.

level += 1

---

# Números Mágicos

Nunca escribir valores directamente.

Incorrecto:

health -= 37

Correcto:

const FALL_DAMAGE := 37

health -= FALL_DAMAGE

---

# Responsabilidad Única

Cada script debe tener una única responsabilidad.

Ejemplos:

PlayerMovement

PlayerCombat

PlayerInteraction

No crear un único Player.gd con toda la lógica.

---

# Señales

Utilizar señales para comunicar sistemas.

Evitar dependencias directas.

Ejemplo:

player_died

level_up

item_collected

quest_completed

---

# Managers

Los Managers nunca deben contener lógica específica de gameplay.

Solo coordinan sistemas.

---

# Recursos

Los datos deben almacenarse en Resources cuando sea posible.

No escribir datos fijos dentro del código.

---

# Errores

Validar siempre entradas y referencias.

Evitar errores por referencias nulas.

---

# Rendimiento

Evitar:

- Buscar nodos constantemente.
- Crear objetos innecesarios.
- Llamadas repetitivas en _process().

Cachear referencias cuando sea posible.

---

# Organización

Orden recomendado de un script:

1. extends

2. class_name

3. signals

4. enums

5. constants

6. exported variables

7. variables privadas

8. _ready()

9. _process()

10. funciones públicas

11. funciones privadas

---

# Calidad

Antes de dar una tarea por terminada comprobar:

- ¿Es fácil de leer?
- ¿Es reutilizable?
- ¿Tiene una única responsabilidad?
- ¿Respeta la arquitectura?
- ¿Puede ampliarse sin romper otros sistemas?

---

# Objetivo Final

Escribir código que pueda mantenerse durante años y que cualquier desarrollador del proyecto pueda comprender rápidamente.
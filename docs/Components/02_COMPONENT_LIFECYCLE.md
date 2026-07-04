# Component Lifecycle

**Estado:** Draft

---

# Objetivo

Definir el ciclo de vida estándar que deberán seguir todos los Components del proyecto.

El objetivo es garantizar un comportamiento uniforme, predecible y consistente durante la creación, inicialización, ejecución y destrucción de cualquier Component.

---

# Filosofía

Todos los Components deberán seguir el mismo ciclo de vida.

Esto facilita:

- La reutilización.
- La depuración.
- El mantenimiento.
- La integración entre sistemas.
- La implementación de herramientas.

Un Component nunca deberá ejecutar lógica fuera de las etapas definidas en este documento.

---

# Arquitectura

El ciclo de vida de un Component está compuesto por siete fases claramente diferenciadas.

Cada fase tiene una responsabilidad específica y no debe mezclarse con las demás.

---

# Fases del ciclo de vida

## 1. Creación

El Component es instanciado.

En esta etapa únicamente existen sus datos internos.

No debe acceder a otros Components ni a Managers.

---

## 2. Inicialización

El Component prepara sus estructuras internas.

Puede inicializar variables, colecciones y referencias básicas.

No debe comenzar todavía su lógica de gameplay.

---

## 3. Configuración

El Component recibe la información necesaria para funcionar.

En esta etapa podrá:

- Leer Resources.
- Configurar parámetros.
- Resolver dependencias.
- Validar su configuración.

---

## 4. Activación

El Component comienza a participar activamente en el juego.

Puede:

- Conectarse a Signals.
- Suscribirse al EventBus.
- Iniciar procesos internos.
- Comenzar a responder a eventos.

---

## 5. Actualización

Corresponde a la ejecución normal del Component.

Toda la lógica continua del gameplay ocurre durante esta etapa.

El Component deberá minimizar el trabajo realizado en cada actualización para favorecer el rendimiento.

---

## 6. Desactivación

El Component deja de participar temporalmente.

En esta etapa deberá:

- Cancelar suscripciones.
- Desconectar Signals.
- Detener procesos internos.
- Liberar recursos temporales.

No deberá destruir información permanente.

---

## 7. Liberación

El Component finaliza completamente su ciclo de vida.

En esta etapa deberá:

- Liberar referencias.
- Eliminar recursos internos.
- Prepararse para ser destruido por el motor.

Después de esta fase el Component no volverá a utilizarse.

---

# Responsabilidades

Cada fase deberá contener únicamente las operaciones correspondientes a dicha etapa.

No deberán mezclarse responsabilidades entre fases.

---

# Integración con Entities

Las Entities serán responsables de coordinar el ciclo de vida de sus Components.

Todos los Components de una Entity deberán respetar el mismo orden de ejecución.

---

# Integración con Managers

Los Managers podrán interactuar con Components únicamente durante las fases apropiadas.

No deberán asumir que un Component ya se encuentra completamente inicializado antes de la fase de Activación.

---

# Rendimiento

El ciclo de vida deberá minimizar:

- Inicializaciones innecesarias.
- Reconstrucción de datos.
- Asignaciones repetidas.
- Procesos costosos durante la actualización.

La mayor parte del trabajo deberá realizarse durante la configuración y no durante la ejecución continua.

---

# Multiplayer

El ciclo de vida deberá comportarse de forma consistente tanto en modo local como en modo multijugador.

Las operaciones de sincronización deberán respetar las fases definidas en este documento.

---

# Consideraciones para Claude

Al generar código:

- Respetar estrictamente las fases del ciclo de vida.
- No ejecutar lógica de gameplay durante la inicialización.
- Separar claramente configuración, activación y actualización.
- Liberar correctamente los recursos utilizados.

---

# Consideraciones para Gemini

Al revisar documentación o código:

- Detectar lógica ejecutada en fases incorrectas.
- Verificar el cumplimiento del ciclo de vida estándar.
- Identificar inicializaciones innecesarias.
- Validar una correcta liberación de recursos.

---

# Estado

**Fase:** 2 – Diseño Técnico

**Estado:** Draft

---

# Objetivo Final

Establecer un ciclo de vida único para todos los Components del proyecto, garantizando consistencia, previsibilidad y una correcta gestión de recursos durante toda la ejecución del juego.
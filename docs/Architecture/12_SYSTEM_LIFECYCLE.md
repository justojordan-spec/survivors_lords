# System Lifecycle

**Proyecto:** Survivors Lords

**Versión:** 1.0

---

# Objetivo

Este documento define el ciclo de vida de todos los Systems del proyecto.

Su propósito es establecer un orden único de inicialización, actualización y finalización para garantizar una arquitectura consistente, determinista y desacoplada.

---

# Filosofía

Todos los Systems siguen el mismo ciclo de vida.

Cada fase deberá completarse antes de iniciar la siguiente.

Ningún System podrá utilizar otro System que aún no haya sido inicializado.

---

# Ciclo de Vida

Cada System atraviesa las siguientes fases:

1. Registro.
2. Inicialización.
3. Configuración.
4. Ejecución.
5. Actualización.
6. Sincronización.
7. Finalización.
8. Liberación.

---

# Orden de Inicialización

Los Systems deberán inicializarse en el siguiente orden:

## Núcleo

1. Game System
2. Resource System
3. Event System

---

## Mundo

4. World System
5. Entity System
6. Component System

---

## Sistemas Base

7. Time System
8. Weather System

---

## Jugador

9. Player System
10. Input System
11. Camera System
12. Audio System
13. UI System

---

## Gameplay

14. Combat System
15. Ability System
16. Effect System
17. Quest System

---

## Objetos

18. Item System
19. Inventory System
20. Loot System
21. Crafting System

---

## Construcción

22. Building System
23. Settlement System
24. Economy System

---

## Progresión

25. Profession System
26. Research System
27. Technology System

---

## Mundo Vivo

28. Kingdom System
29. Diplomacy System
30. Enemy System

---

## Infraestructura

31. Multiplayer System
32. Save System

---

# Actualización

Durante cada frame los Systems deberán ejecutarse respetando el mismo orden de dependencias.

Los Systems nunca deberán modificar directamente el estado interno de otro System durante su actualización.

La comunicación deberá realizarse mediante eventos o interfaces.

---

# Sincronización

Una vez finalizada la actualización:

- Se procesarán eventos pendientes.
- Se sincronizará el estado multijugador.
- Se actualizará la interfaz.
- Se limpiarán eventos temporales.

---

# Finalización

Al cerrar el juego los Systems deberán finalizar en el orden inverso a la inicialización.

Esto garantiza que ningún System dependa de otro que ya haya sido destruido.

---

# Estados

Cada System podrá encontrarse en uno de los siguientes estados:

- No Registrado.
- Registrado.
- Inicializado.
- Configurado.
- Activo.
- Pausado.
- Finalizando.
- Finalizado.

---

# Reglas

Todo System deberá:

- Inicializarse una única vez.
- Finalizar correctamente.
- Liberar recursos utilizados.
- Cancelar tareas pendientes.
- Mantener consistencia durante todo su ciclo de vida.

---

# Consideraciones para Claude

Al generar código:

- Respetar el orden de inicialización.
- Evitar dependencias circulares.
- No acceder a Systems no inicializados.
- Liberar correctamente todos los recursos.
- Mantener el ciclo de vida desacoplado.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar inicializaciones fuera de orden.
- Verificar liberación de recursos.
- Detectar dependencias circulares.
- Revisar el ciclo de vida completo de cada System.
- Validar consistencia de estados.

---

# Objetivo Final

Garantizar un ciclo de vida uniforme para todos los Systems del proyecto, permitiendo una arquitectura estable, predecible y fácilmente mantenible.
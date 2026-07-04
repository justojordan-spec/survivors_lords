# Survivors Lords

# PLAYER SYSTEM

Versión: 1.0

---

# Objetivo

Definir el funcionamiento completo del jugador.

El jugador es el núcleo de Survivors Lords.

Todos los demás sistemas interactúan directa o indirectamente con él.

---

# Filosofía

El jugador comienza siendo un simple superviviente.

No es un héroe elegido.

Su progreso dependerá de:

- Exploración.
- Combate.
- Construcción.
- Gestión del Reino.
- Decisiones.

El crecimiento será consecuencia del esfuerzo del jugador.

---

# Responsabilidades

El Player System controla:

- Movimiento.
- Cámara.
- Combate.
- Interacción.
- Inventario.
- Equipo.
- Habilidades.
- Profesiones.
- Estadísticas.
- Progresión.

---

# Estadísticas Base

Todo jugador posee:

Vida (Health)

Resistencia (Stamina)

Energía (Mana o equivalente si se implementa)

Ataque

Defensa

Velocidad

Probabilidad Crítica

Daño Crítico

Suerte

Capacidad de carga

---

# Movimiento

El jugador podrá:

- Caminar.
- Correr.
- Saltar.
- Esquivar.
- Agacharse (opcional).
- Interactuar.
- Trepar (si el diseño final lo permite).

El movimiento debe sentirse preciso y responsivo.

---

# Combate

El jugador podrá utilizar:

- Armas cuerpo a cuerpo.
- Arcos.
- Ballestas.
- Escudos.
- Reliquias.
- Habilidades especiales.

El combate estará documentado en Combat System.

---

# Exploración

El jugador podrá:

- Descubrir regiones.
- Abrir cofres.
- Explorar ruinas.
- Resolver puzles.
- Encontrar supervivientes.
- Recolectar recursos.

---

# Interacción

El jugador podrá interactuar con:

NPC

Puertas

Palancas

Edificios

Mesas de trabajo

Objetos

Recursos

Cadáveres

---

# Inventario

El jugador posee un inventario limitado.

Podrá:

- Recoger objetos.
- Equiparlos.
- Usarlos.
- Descartarlos.
- Almacenarlos.

---

# Equipo

Ranuras previstas:

Casco

Pechera

Guantes

Botas

Arma Principal

Arma Secundaria

Escudo

Amuleto

Anillos

Reliquia

---

# Progresión

El jugador mejorará mediante:

Experiencia

Nivel

Habilidades

Equipo

Profesiones

Mejoras del Reino

Reliquias

No existirá una única forma de progresar.

---

# Profesiones

El jugador podrá aprender profesiones.

Ejemplos:

- Minería
- Tala
- Herrería
- Alquimia
- Cocina
- Pesca
- Agricultura

Las profesiones mejorarán con el uso.

---

# Relación con el Reino

El jugador es el líder del Reino.

Todas las mejoras importantes del asentamiento dependerán de sus decisiones.

El Reino también mejorará las capacidades del jugador.

Existe una relación de progreso mutuo.

---

# Muerte

Cuando el jugador muera:

- Perderá parte del progreso reciente (a definir).
- Regresará al último punto seguro.
- El mundo continuará existiendo.

No habrá Game Over tradicional.

---

# Integración

El Player System interactúa con:

- Combat System
- Inventory System
- Skill System
- Kingdom System
- Save System
- Quest System
- World System
- Loot System

---

# Consideraciones para Claude

El sistema deberá ser modular.

Cada responsabilidad deberá implementarse en componentes independientes.

Evitar un único script gigante para el jugador.

---

# Consideraciones para Gemini

El crecimiento del jugador deberá sentirse constante.

Cada mejora debe ofrecer una decisión interesante y no solo aumentar números.

---

# Estado

Diseño aprobado.

Pendiente de implementación.

---

# Objetivo Final

Crear un personaje flexible, divertido de controlar y con múltiples formas de progresar, que refleje el espíritu de reconstrucción y supervivencia de Survivors Lords.
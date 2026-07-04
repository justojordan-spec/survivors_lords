# Weather System

**Estado:** Draft

---

# Objetivo

El Weather System es responsable de administrar todas las condiciones climáticas de Survivors Lords.

Su propósito es simular el clima, controlar sus transiciones y aplicar sus efectos sobre el mundo y los demás Systems mediante una arquitectura ECS, modular y completamente Data Driven.

No administra el paso del tiempo ni la lógica específica de otros Systems.

---

# Filosofía

El clima representa un estado global del mundo que puede afectar a entidades, construcciones, cultivos, visibilidad y otros elementos.

El Weather System administra exclusivamente la simulación y evolución del clima.

Toda la configuración será completamente Data Driven mediante Weather Resources.

---

# Responsabilidades

El Weather System será responsable de:

- Generar condiciones climáticas.
- Administrar transiciones.
- Gestionar duración del clima.
- Administrar intensidad.
- Gestionar probabilidades.
- Aplicar modificadores ambientales.
- Notificar cambios climáticos.
- Coordinar eventos meteorológicos.

---

# No es responsable de

El Weather System NO debe:

- Administrar el tiempo del juego.
- Ejecutar IA.
- Resolver combate.
- Administrar economía.
- Gestionar cultivos directamente.
- Administrar interfaz.

Estas responsabilidades pertenecen a sus respectivos Systems.

---

# Tipos de Clima

El sistema podrá administrar:

- Soleado.
- Nublado.
- Lluvia.
- Tormenta.
- Niebla.
- Nieve.
- Granizo.
- Sequía.
- Tormenta eléctrica.
- Climas especiales.

---

# Propiedades

Cada condición climática podrá definir:

- Intensidad.
- Duración.
- Probabilidad.
- Temperatura.
- Humedad.
- Visibilidad.
- Velocidad del viento.
- Efectos asociados.

---

# Efectos

El clima podrá afectar:

- Visibilidad.
- Movimiento.
- Agricultura.
- Producción.
- Construcciones.
- Exploración.
- Spawn de entidades.
- Eventos del mundo.

---

# Comunicación

El Weather System se comunicará mediante:

- Eventos.
- Interfaces.
- Consultas.

Nunca modificará directamente otros Systems.

---

# Integración

Trabajará junto a:

- World System.
- Time System.
- Building System.
- Settlement System.
- Economy System.
- Enemy System.
- Player System.
- Resource System.
- Audio System.
- UI System.
- Multiplayer System.

---

# Multiplayer

El servidor será la autoridad sobre el estado climático.

Los clientes recibirán únicamente las actualizaciones sincronizadas del clima.

---

# Rendimiento

El Weather System deberá:

- Procesar únicamente cambios climáticos.
- Compartir Weather Resources.
- Evitar cálculos repetidos.
- Reducir actualizaciones innecesarias.
- Mantener una simulación determinista.

---

# Eventos

Ejemplos:

- WeatherStarted
- WeatherChanged
- WeatherEnded
- StormStarted
- RainStarted
- FogStarted

---

# Convenciones

Toda condición climática deberá:

- Referenciar un Weather Resource.
- Tener un identificador único.
- Poder serializarse.
- Mantener consistencia entre cliente y servidor.
- Ser determinista.

---

# Consideraciones para Claude

Al generar código:

- Mantener el Weather System desacoplado del Time System.
- Configurar todos los climas mediante Weather Resources.
- Utilizar eventos para comunicar cambios.
- Evitar lógica específica de gameplay.
- Favorecer una arquitectura orientada a eventos.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar dependencias innecesarias.
- Verificar transiciones climáticas.
- Detectar cálculos duplicados.
- Validar sincronización multijugador.
- Revisar rendimiento del sistema.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado encargado de administrar todas las condiciones climáticas del juego, coordinando su simulación y efectos mediante una arquitectura ECS, Data Driven y completamente desacoplada.

---

# DEC propuesta

## DEC – El Weather System administrará exclusivamente el clima

### Decisión

El Weather System será responsable únicamente de la simulación y evolución de las condiciones climáticas. Los efectos específicos sobre construcciones, cultivos, economía, combate o exploración serán aplicados por los Systems correspondientes utilizando la información proporcionada por el Weather System.

### Justificación

- Mantiene el principio de responsabilidad única.
- Evita acoplamiento entre clima y gameplay.
- Facilita la incorporación de nuevos fenómenos meteorológicos.
- Mejora la mantenibilidad y escalabilidad del sistema.
- Refuerza la arquitectura ECS y Data Driven.
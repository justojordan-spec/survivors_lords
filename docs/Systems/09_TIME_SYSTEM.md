# Time System

**Estado:** Draft

---

# Objetivo

El Time System es responsable de administrar el tiempo global de Survivors Lords.

Su propósito es controlar el avance temporal de la simulación, proporcionando una referencia común para todos los Systems que dependen del tiempo.

No implementa reglas específicas de gameplay.

---

# Filosofía

El tiempo es un recurso global compartido por toda la simulación.

El Time System será la única fuente oficial de tiempo del juego.

Ningún otro System deberá mantener su propio reloj independiente.

---

# Responsabilidades

El Time System será responsable de:

- Administrar el tiempo global.
- Controlar la velocidad del tiempo.
- Gestionar pausas.
- Administrar el ciclo día/noche.
- Administrar estaciones.
- Administrar calendario.
- Gestionar fechas.
- Gestionar horas.
- Notificar cambios temporales.

---

# No es responsable de

El Time System NO debe:

- Cambiar el clima.
- Generar cultivos.
- Ejecutar IA.
- Administrar economía.
- Resolver combate.
- Controlar iluminación.
- Gestionar eventos.

Estas tareas pertenecen a sus respectivos Systems.

---

# Escalas de Tiempo

El sistema administrará:

- Tick.
- Segundo.
- Minuto.
- Hora.
- Día.
- Semana.
- Mes.
- Año.

Todas las escalas deberán derivarse del mismo reloj global.

---

# Ciclos

El sistema podrá administrar:

- Amanecer.
- Mañana.
- Mediodía.
- Tarde.
- Atardecer.
- Noche.
- Medianoche.

---

# Velocidad

Permitirá distintos multiplicadores:

- Pausa.
- x1.
- x2.
- x5.
- x10.
- Personalizado.

---

# Calendario

El calendario podrá definir:

- Días por semana.
- Semanas por mes.
- Meses por año.
- Estaciones.
- Festividades.
- Eventos periódicos.

Toda la configuración será Data Driven mediante Resources.

---

# Comunicación

Los demás Systems consultarán el tiempo exclusivamente mediante el Time System.

La comunicación podrá realizarse mediante:

- Eventos.
- Interfaces.
- Consultas.

---

# Integración

Será utilizado por:

- Weather System.
- Economy System.
- Settlement System.
- Research System.
- Technology System.
- Farming System.
- Building System.
- AI System.
- Quest System.
- Event System.
- UI System.
- Save System.

---

# Multiplayer

El servidor será la autoridad sobre el tiempo global.

Todos los clientes sincronizarán su reloj utilizando el tiempo del servidor.

---

# Rendimiento

El Time System deberá:

- Mantener una única fuente de tiempo.
- Minimizar cálculos por frame.
- Permitir consultas rápidas.
- Evitar relojes duplicados.

---

# Eventos

Ejemplos:

- TickStarted
- TickFinished
- MinuteChanged
- HourChanged
- DayChanged
- MonthChanged
- YearChanged
- SeasonChanged
- TimeScaleChanged

---

# Convenciones

Todo cambio temporal deberá:

- Derivarse del reloj global.
- Ser determinista.
- Poder sincronizarse.
- Ser serializable.

---

# Consideraciones para Claude

Al generar código:

- Mantener un único reloj global.
- Evitar múltiples temporizadores independientes.
- Favorecer eventos temporales.
- Mantener el sistema desacoplado.

---

# Consideraciones para Gemini

Al revisar código:

- Detectar relojes duplicados.
- Verificar sincronización.
- Detectar dependencias circulares.
- Validar el uso del reloj global.

---

# Estado

**Fase:** 3 – Systems

**Estado:** Draft

---

# Objetivo Final

Disponer de un sistema centralizado que administre el tiempo global de la simulación, proporcionando una referencia única y determinista para todos los Systems del proyecto, manteniendo una arquitectura desacoplada, Data Driven y preparada para soporte multijugador.
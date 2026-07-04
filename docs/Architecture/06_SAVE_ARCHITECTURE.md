# Survivors Lords

# SAVE ARCHITECTURE

Versión: 1.0

---

# Objetivo

Definir la arquitectura interna del sistema de guardado.

El SaveManager será el encargado de coordinar el guardado y la carga de todos los sistemas del juego.

Cada sistema será responsable únicamente de sus propios datos.

---

# Filosofía

Guardar información nunca debe afectar la experiencia del jugador.

El sistema debe ser:

- Modular.
- Seguro.
- Escalable.
- Versionable.
- Preparado para futuras expansiones.

---

# Principios

- Un sistema guarda únicamente sus datos.
- El SaveManager coordina el proceso.
- Ningún Manager guarda datos de otro.
- Todo guardado debe poder recuperarse.

---

# Arquitectura General

```
GameManager
      │
      ▼
SaveManager
      │
────────────────────────────────────────────
│        │        │        │
▼        ▼        ▼        ▼
Player  World  Kingdom Inventory
Save     Save    Save     Save

│        │        │        │
───────────────
        │
        ▼
Quest Save

        │
        ▼
Network Save

        │
        ▼
Metadata Save
```

---

# Responsabilidades del SaveManager

El SaveManager será responsable de:

- Crear partidas.
- Guardar.
- Cargar.
- Crear copias de seguridad.
- Verificar versiones.
- Detectar corrupción.
- Restaurar backups.
- Coordinar todos los módulos.

---

# Guardado Modular

Cada sistema utilizará un archivo independiente.

Ejemplo:

```
save/

player.save

inventory.save

world.save

kingdom.save

quests.save

settings.save

network.save

metadata.save
```

Nunca utilizar un único archivo gigante.

---

# Flujo de Guardado

```
Jugador guarda

↓

SaveManager

↓

Solicita datos

↓

PlayerManager

↓

InventoryManager

↓

WorldManager

↓

KingdomManager

↓

QuestManager

↓

Guardar archivos

↓

Verificación

↓

Finalizado
```

---

# Flujo de Carga

```
Seleccionar partida

↓

Leer Metadata

↓

Comprobar versión

↓

Cargar Managers

↓

Cargar Player

↓

Cargar Reino

↓

Cargar Mundo

↓

Cargar Inventario

↓

Cargar Misiones

↓

Inicializar juego
```

---

# SaveData

Cada Manager implementará una interfaz similar a:

```
get_save_data()

load_save_data(data)

reset_data()
```

Esto mantiene un comportamiento uniforme.

---

# Metadata

Cada partida almacenará:

- Nombre.
- Fecha.
- Tiempo jugado.
- Nivel.
- Nivel del Reino.
- Región.
- Versión del juego.
- Versión del Save.
- Miniatura (futuro).

---

# Versionado

Cada archivo incluirá:

```
Save Version

Game Version

Build Number
```

Esto permitirá migraciones automáticas cuando sea necesario.

---

# Backups

El sistema mantendrá automáticamente:

```
Autosave

↓

Backup 1

↓

Backup 2

↓

Backup 3
```

Nunca sobrescribir un archivo válido sin confirmar el nuevo guardado.

---

# Integridad

Antes de finalizar un guardado:

- Verificar datos.
- Confirmar escritura.
- Comprobar integridad.
- Actualizar Metadata.

Solo entonces reemplazar el archivo anterior.

---

# Recuperación

Si un archivo está corrupto:

1. Intentar restaurar Backup.
2. Avisar al jugador.
3. Registrar el error.

---

# Guardado Automático

Eventos que activan AutoSave:

- Dormir.
- Completar misión.
- Derrotar jefe.
- Construcción importante.
- Cambio de región.
- Salir del juego.

---

# Rendimiento

El guardado deberá:

- Ejecutarse en segundo plano cuando sea posible.
- Escribir solo los archivos modificados.
- Evitar bloqueos de la interfaz.

---

# Multiplayer

El Host guardará:

- Mundo.
- Reino.
- Construcciones.
- Eventos.

Cada jugador conservará:

- Inventario.
- Nivel.
- Equipamiento.
- Habilidades.
- Configuración personal.

---

# Compatibilidad Futura

La arquitectura permitirá añadir:

- Guardado en la nube.
- Cross Save.
- Múltiples personajes.
- Mods.
- DLC.

Sin modificar la estructura principal.

---

# Integración

Interactúa con:

- Save System
- Manager System
- Data Driven Architecture
- Multiplayer Architecture

---

# Consideraciones para Claude

Implementar SaveManager como un AutoLoad.

Cada Manager deberá implementar una interfaz común de guardado.

Evitar dependencias entre archivos.

Preparar el sistema para migraciones de versiones.

---

# Consideraciones para Gemini

Todo contenido nuevo deberá ser compatible con el sistema modular de guardado.

Nunca asumir un único archivo de partida.

---

# Estado

Arquitectura aprobada.

Pendiente de implementación.

---

# Objetivo Final

Construir una arquitectura de guardado robusta, modular y preparada para cientos de horas de juego, garantizando seguridad, compatibilidad y escalabilidad.
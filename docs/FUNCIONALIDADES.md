# Manual de Funcionalidades - SoundFua Desktop

## Índice
1. [Introducción](#introducción)
2. [Características Principales](#características-principales)
3. [Interfaz de Usuario](#interfaz-de-usuario)
4. [Gestión de Biblioteca de Sonidos](#gestión-de-biblioteca-de-sonidos)
5. [Reproducción de Audio](#reproducción-de-audio)
6. [Sistema de Quick Sounds](#sistema-de-quick-sounds)
7. [Configuración](#configuración)
8. [Integración con el Sistema](#integración-con-el-sistema)
9. [Casos de Uso](#casos-de-uso)
10. [Preguntas Frecuentes](#preguntas-frecuentes)

---

## Introducción

**SoundFua Desktop** es una aplicación de escritorio para gestionar y reproducir una biblioteca de sonidos de manera eficiente. Diseñada para usuarios que necesitan acceso rápido a efectos de sonido, música o clips de audio, ideal para:

- **Streamers**: Reproducir efectos de sonido durante transmisiones
- **Podcasters**: Gestionar intro/outro y efectos
- **Productores de contenido**: Organizar biblioteca de audio
- **Gamers**: Soundboards personalizados
- **Presentadores**: Efectos de sonido para eventos

---

## Características Principales

### 🎵 Gestión de Biblioteca
- ✅ Importar archivos de audio desde el sistema
- ✅ Organizar sonidos con alias personalizados
- ✅ Búsqueda y filtrado de sonidos
- ✅ Eliminar y editar sonidos
- ✅ Metadatos automáticos (fecha de agregado)

### 🔊 Reproducción Avanzada
- ✅ Reproducción simultánea de múltiples sonidos
- ✅ Selección de dispositivo de salida de audio
- ✅ Soporte para cables de audio virtuales
- ✅ Control de volumen por sonido
- ✅ Barra de progreso de reproducción

### ⚡ Quick Sounds (Sonidos Rápidos)
- ✅ Overlay con atajos de teclado globales
- ✅ Navegación rápida por teclado
- ✅ Reproducción instantánea sin cambiar de ventana
- ✅ Configuración de hotkeys personalizables

### 🎨 Personalización
- ✅ Tema claro/oscuro/sistema
- ✅ Configuración de atajos de teclado
- ✅ Selección de dispositivo de audio por defecto
- ✅ Configuración de volumen global

### 💻 Integración del Sistema
- ✅ Icono en bandeja del sistema
- ✅ Minimizar a bandeja
- ✅ Atajos de teclado globales
- ✅ Multiplataforma (Windows, macOS, Linux)

---

## Interfaz de Usuario

### Pantalla Principal

La pantalla principal se divide en varias secciones:

```
┌─────────────────────────────────────────────────────┐
│  🎵 Gestor de Biblioteca de Sonidos          ⚙️ 🌙  │
├─────────────────────────────────────────────────────┤
│                                                     │
│  📂 Agregar Sonido        🔍 Buscar...              │
│                                                     │
│  ┌─────────────────────────────────────────────┐   │
│  │ Mis Sonidos (12)                            │   │
│  ├─────────────────────────────────────────────┤   │
│  │ 🎵 Intro Podcast        ▶️  🗑️   01:23      │   │
│  │ 🔔 Notificación         ▶️  🗑️   00:03      │   │
│  │ 👏 Aplausos             ▶️  🗑️   00:05      │   │
│  │ 🎶 Outro                ▶️  🗑️   00:45      │   │
│  │ ...                                         │   │
│  └─────────────────────────────────────────────┘   │
│                                                     │
└─────────────────────────────────────────────────────┘
```

#### Elementos de la Interfaz

1. **Barra Superior**
   - Título de la aplicación
   - Botón de configuración (⚙️)
   - Selector de tema (🌙/☀️)

2. **Barra de Acciones**
   - Botón "Agregar Sonido": Importar nuevos archivos
   - Campo de búsqueda: Filtrar sonidos por alias

3. **Lista de Sonidos**
   - Cada sonido muestra:
     - Icono/emoji representativo
     - Alias del sonido
     - Botón de reproducción (▶️)
     - Botón de eliminar (🗑️)
     - Duración del audio
     - Barra de progreso (durante reproducción)

### Panel de Configuración

Accesible desde el botón ⚙️ en la barra superior.

```
┌─────────────────────────────────────────────────────┐
│  ⚙️ Configuración                                    │
├─────────────────────────────────────────────────────┤
│                                                     │
│  🎨 Apariencia                                      │
│  ├─ Tema: [ Sistema ▼ ]                            │
│  │  (Claro / Oscuro / Sistema)                     │
│                                                     │
│  🔊 Audio                                           │
│  ├─ Dispositivo de salida:                         │
│  │  [ VB-Audio Virtual Cable ▼ ]                   │
│  │  🔍 Auto-detectar Cable Virtual                 │
│  │                                                  │
│  ├─ Volumen global: [████████░░] 80%               │
│                                                     │
│  ⌨️ Atajos de Teclado                               │
│  ├─ Quick Sounds: [ CMD+0 ]                        │
│  │  (Personalizable)                               │
│                                                     │
│  💾 Datos                                           │
│  ├─ Ubicación de archivos: ~/Music/SoundFua       │
│  ├─ Espacio usado: 245 MB                          │
│  └─ [Limpiar caché]                                │
│                                                     │
└─────────────────────────────────────────────────────┘
```

### Quick Sound Overlay

Overlay semi-transparente que aparece al presionar el hotkey configurado (por defecto: CMD+0 / CTRL+0).

```
┌─────────────────────────────────────────────────────┐
│         ⚡ Quick Sounds (CMD+0)              ✕      │
├─────────────────────────────────────────────────────┤
│                                                     │
│  ┌─────────────────────────────────────────────┐   │
│  │ 🎵 Intro Podcast                            │   │
│  ├─────────────────────────────────────────────┤   │
│  │ 🔔 Notificación                   [Selec.]  │◀  │
│  ├─────────────────────────────────────────────┤   │
│  │ 👏 Aplausos                                 │   │
│  ├─────────────────────────────────────────────┤   │
│  │ 🎶 Outro                                    │   │
│  └─────────────────────────────────────────────┘   │
│                                                     │
│  ↑↓ Navegar  │  Enter: Reproducir  │  ESC: Cerrar  │
│                                                     │
└─────────────────────────────────────────────────────┘
```

---

## Gestión de Biblioteca de Sonidos

### Agregar Sonidos

**Pasos:**

1. Hacer clic en el botón **"📂 Agregar Sonido"**
2. Se abrirá un selector de archivos del sistema
3. Navegar a la ubicación del archivo de audio
4. Seleccionar uno o varios archivos (formatos soportados: MP3, WAV, OGG, FLAC, etc.)
5. Ingresar un alias (nombre personalizado) para el sonido
6. Hacer clic en **"Agregar"**

**Resultado:**
- El archivo se copia a la biblioteca local de la aplicación
- Se crea una entrada en la base de datos con metadatos
- El sonido aparece en la lista principal

**Nota:** Los archivos originales no se modifican, se realiza una copia.

### Buscar Sonidos

**Uso del campo de búsqueda:**

1. Hacer clic en el campo **"🔍 Buscar..."**
2. Escribir parte del nombre/alias del sonido
3. La lista se filtra en tiempo real mostrando coincidencias

**Ejemplos:**
- Buscar "intro" → Muestra todos los sonidos con "intro" en el alias
- Buscar "podcast" → Filtra sonidos relacionados con podcast

### Editar Sonidos

**Cambiar alias:**

1. Hacer clic derecho en un sonido (o botón de opciones)
2. Seleccionar **"Editar"**
3. Modificar el alias
4. Guardar cambios

### Eliminar Sonidos

**Pasos:**

1. Hacer clic en el botón **🗑️** junto al sonido
2. Confirmar la eliminación en el diálogo
3. El sonido se elimina de la biblioteca y de la base de datos

**Advertencia:** Esta acción no se puede deshacer.

### Información de Sonidos

**Metadatos mostrados:**
- **Alias**: Nombre personalizado
- **Duración**: Tiempo total del audio
- **Fecha agregada**: Cuándo se importó a la biblioteca
- **Ruta del archivo**: Ubicación en el sistema
- **Formato**: Tipo de archivo (MP3, WAV, etc.)

---

## Reproducción de Audio

### Reproducción Simple

**Pasos:**

1. Hacer clic en el botón **▶️** junto al sonido deseado
2. El audio comienza a reproducirse inmediatamente
3. La barra de progreso muestra el avance de la reproducción

**Controles durante reproducción:**
- **⏸️ Pausar**: Pausar temporalmente
- **⏹️ Detener**: Detener completamente
- **Barra de progreso**: Hacer clic para saltar a una posición

### Reproducción Simultánea

**Característica clave**: Puedes reproducir múltiples sonidos al mismo tiempo.

**Ejemplo de uso:**
1. Reproducir música de fondo (▶️ "Intro Podcast")
2. Mientras se reproduce, hacer clic en ▶️ "Aplausos"
3. Ambos sonidos se reproducen simultáneamente

**Límite:** Hasta 10 instancias de audio simultáneas (configurable)

### Control de Volumen

**Volumen individual:**
- Deslizador de volumen por cada sonido
- Rango: 0% - 100%
- Se mantiene la configuración entre sesiones

**Volumen global:**
- Control maestro en Configuración
- Afecta a todos los sonidos
- Integrado con el volumen del sistema

### Barra de Progreso

Durante la reproducción, se muestra una barra visual que indica:
- Tiempo transcurrido
- Tiempo total
- Posición actual (MM:SS / MM:SS)

**Interacción:**
- Hacer clic en la barra para saltar a una posición específica
- Útil para reproducir solo una parte del sonido

---

## Sistema de Quick Sounds

### ¿Qué es Quick Sounds?

Quick Sounds es un **overlay rápido** que permite reproducir sonidos sin necesidad de cambiar de ventana o interrumpir tu trabajo actual.

**Ventajas:**
- ⚡ Acceso instantáneo con hotkey global
- 🎮 Navegación por teclado
- 🚀 Reproducción sin clicks
- 👻 No interrumpe el flujo de trabajo

### Activar Quick Sounds

**Por defecto:** Presionar `CMD+0` (macOS) o `CTRL+0` (Windows/Linux)

**Resultado:**
- Aparece un overlay semi-transparente en el centro de la pantalla
- Muestra todos los sonidos de la biblioteca
- El último sonido seleccionado está pre-seleccionado

### Navegación

**Controles de teclado:**

| Tecla | Acción |
|-------|--------|
| `↑` (Flecha Arriba) | Seleccionar sonido anterior |
| `↓` (Flecha Abajo) | Seleccionar sonido siguiente |
| `Enter` | Reproducir sonido seleccionado |
| `ESC` | Cerrar overlay sin reproducir |
| `CMD/CTRL+0` | Alternar overlay (abrir/cerrar) |

### Flujo de Uso Típico

1. **Activar overlay**: Presionar `CMD+0`
2. **Navegar**: Usar `↑↓` para seleccionar sonido
3. **Reproducir**: Presionar `Enter`
4. **Resultado**: 
   - El sonido se reproduce
   - El overlay se cierra automáticamente
   - Vuelves a tu aplicación anterior

**Tiempo total:** ~2 segundos desde activación hasta reproducción

### Configurar Hotkey

**Cambiar atajo de teclado:**

1. Ir a **Configuración** (⚙️)
2. Sección **"⌨️ Atajos de Teclado"**
3. Hacer clic en el campo "Quick Sounds"
4. Presionar la combinación de teclas deseada
   - Ejemplos: `F1`, `CMD+Q`, `CTRL+ALT+S`
5. Guardar configuración

**Recomendaciones:**
- Usar combinaciones que no interfieran con otras apps
- Preferir teclas de función (F1-F12) o combinaciones con modificadores
- Evitar atajos del sistema operativo

### Casos de Uso de Quick Sounds

**Para Streamers:**
- Reproducir efectos de sonido durante stream
- No necesita cambiar de escena en OBS
- Hotkey accesible mientras juegas

**Para Podcasters:**
- Reproducir intro/outro durante grabación
- Efectos de transición entre segmentos
- Sin interrumpir el flujo de conversación

**Para Presentadores:**
- Efectos de sonido durante presentaciones
- No necesita salir de la presentación
- Acceso discreto

---

## Configuración

### Apariencia

#### Tema de Interfaz

**Opciones:**
- **Claro**: Fondo blanco, texto oscuro
- **Oscuro**: Fondo oscuro, texto claro
- **Sistema**: Sigue la configuración del sistema operativo

**Cómo cambiar:**
1. Click en el icono 🌙/☀️ en la barra superior (cambio rápido)
2. O ir a Configuración → Apariencia → Tema

**Persistencia:** La configuración se guarda automáticamente

### Audio

#### Dispositivo de Salida

**Funcionalidad:** Seleccionar por cuál dispositivo de audio se reproducen los sonidos.

**Casos de uso:**
- Reproducir en auriculares mientras trabajas
- Enviar audio a cable virtual para captura en OBS/streaming
- Separar audio de la app del resto del sistema

**Configuración:**

1. Ir a **Configuración** → **Audio**
2. Sección "Dispositivo de salida"
3. Hacer clic en el menú desplegable
4. Seleccionar dispositivo deseado

**Dispositivos disponibles:**
- 🔊 Speakers (Built-in)
- 🎧 Headphones
- 🔌 VB-Audio Virtual Cable
- 🔌 BlackHole 2ch
- 🖥️ Display Audio
- etc.

**Indicadores visuales:**
- **VIRTUAL**: Se marca si es un cable virtual
- **[Seleccionado]**: Dispositivo actualmente en uso

#### Auto-detección de Cable Virtual

**¿Qué hace?** Detecta automáticamente cables de audio virtuales instalados.

**Cables soportados:**
- VB-Audio Virtual Cable
- BlackHole
- Soundflower
- Loopback

**Uso:**
1. Hacer clic en **"🔍 Auto-detectar Cable Virtual"**
2. La app busca automáticamente
3. Si encuentra uno, lo selecciona automáticamente
4. Aparece notificación de confirmación

**Ventaja:** Configuración rápida para streamers

#### Volumen Global

**Control maestro de volumen:**
- Deslizador de 0% a 100%
- Afecta a todos los sonidos proporcionalmente
- Se aplica además del volumen individual

**Escenarios:**
- Bajar volumen general sin ajustar cada sonido
- Modo "silencioso" para pruebas
- Normalización rápida

### Atajos de Teclado

#### Quick Sounds Hotkey

**Por defecto:** `CMD+0` (macOS) / `CTRL+0` (Windows/Linux)

**Personalización:**
1. Ir a Configuración → Atajos de Teclado
2. Hacer clic en el campo "Quick Sounds"
3. Presionar la nueva combinación
4. Guardar

**Validación:**
- La app verifica que el atajo no esté en uso
- Si está en conflicto, muestra advertencia

**Permisos:**
- **macOS**: Requiere permisos de accesibilidad
- **Windows**: Sin requisitos adicionales
- **Linux**: Puede requerir configuración según DE

#### Futuros Atajos (Roadmap)

- Play/Pause global: `Space`
- Stop all: `Shift+S`
- Volumen up/down: `Ctrl+↑/↓`
- Sonidos favoritos: `1-9`

### Datos y Almacenamiento

#### Ubicación de Archivos

**Por defecto:**
- **macOS**: `~/Music/SoundFua/`
- **Windows**: `%USERPROFILE%\Music\SoundFua\`
- **Linux**: `~/Music/SoundFua/`

**Estructura:**
```
SoundFua/
├── sounds/           # Archivos de audio
│   ├── intro.mp3
│   ├── applause.wav
│   └── ...
├── database/         # Base de datos SQLite
│   └── soundfua.db
└── cache/            # Caché temporal
    └── thumbnails/
```

**Cambiar ubicación:**
- En desarrollo, no configurable por UI aún
- Planificado para futuras versiones

#### Gestión de Espacio

**Información mostrada:**
- Espacio total usado
- Número de sonidos
- Tamaño promedio por sonido

**Limpieza:**
- Botón "Limpiar caché": Elimina archivos temporales
- No afecta sonidos principales

---

## Integración con el Sistema

### Bandeja del Sistema (System Tray)

**Icono en bandeja:** La app añade un icono en la bandeja del sistema (junto al reloj).

**Menú contextual:**

Al hacer clic derecho en el icono:
```
┌──────────────────────────┐
│ 📂 Mostrar Ventana       │
│ ⚡ Quick Sounds          │
│ ──────────────────────── │
│ ⚙️ Configuración         │
│ ──────────────────────── │
│ ❌ Salir                 │
└──────────────────────────┘
```

**Acciones:**
- **Mostrar Ventana**: Restaura la ventana si está minimizada
- **Quick Sounds**: Abre el overlay de quick sounds
- **Configuración**: Abre el panel de configuración
- **Salir**: Cierra completamente la aplicación

### Comportamiento de Ventana

**Minimizar vs Cerrar:**

- **Minimizar (−)**: Minimiza a la barra de tareas
- **Cerrar (✕)**: Minimiza a la bandeja del sistema (no cierra la app)

**Para cerrar completamente:**
- Usar "Salir" en el menú de la bandeja
- O Configuración → Salir

**Ventaja:** La app sigue funcionando en segundo plano, hotkeys siguen activos

### Inicio Automático (Futuro)

Planificado:
- Opción para iniciar con el sistema
- Iniciar minimizado en bandeja
- Configurable en Preferencias

---

## Casos de Uso

### Caso 1: Streamer en Twitch/YouTube

**Objetivo:** Reproducir efectos de sonido durante stream sin interrumpir el juego.

**Setup:**
1. Configurar cable virtual (VB-Audio)
2. Importar efectos de sonido (risas, aplausos, etc.)
3. Seleccionar cable virtual en Configuración → Audio
4. Configurar OBS para capturar el cable virtual
5. Configurar hotkey cómodo (ej: `F5`)

**Flujo durante stream:**
1. Está jugando/charlando
2. Presiona `F5` → Quick Sounds overlay aparece
3. `↓↓` para seleccionar "Risas"
4. `Enter` → Sonido se reproduce en stream
5. Sigue jugando sin interrupciones

**Tiempo:** < 2 segundos

### Caso 2: Podcaster Grabando Episodio

**Objetivo:** Insertar intro/outro y transiciones durante grabación.

**Setup:**
1. Importar intro, outro, y efectos de transición
2. Configurar dispositivo de audio para enviar a DAW
3. Asignar aliases claros ("Intro", "Outro", "Transición")

**Flujo durante grabación:**
1. Inicia grabación en DAW
2. Presiona hotkey → Selecciona "Intro" → Enter
3. Intro se reproduce y se graba en la pista
4. Continúa con contenido
5. Al final, reproduce "Outro" de la misma forma

**Ventaja:** No necesita editar después, todo en vivo

### Caso 3: Productor de Contenido Creando Videos

**Objetivo:** Gestionar biblioteca de música y efectos para edición.

**Setup:**
1. Importar música de fondo, efectos, voiceovers
2. Organizar con aliases descriptivos
3. Usar búsqueda para filtrar por categoría

**Flujo durante edición:**
1. Busca "fondo" → Encuentra música de fondo
2. Reproduce para verificar que es la correcta
3. Arrastra directamente al editor de video
4. Repite para efectos y transiciones

**Ventaja:** Biblioteca centralizada, fácil búsqueda

### Caso 4: Presentador en Eventos/Clases

**Objetivo:** Efectos de sonido discretos durante presentación.

**Setup:**
1. Importar sonidos de transición, atención, aplausos
2. Configurar hotkey discreto
3. Probar antes del evento

**Flujo durante presentación:**
1. Presenta contenido en modo presentación
2. Necesita llamar atención: Presiona hotkey
3. Selecciona "Campana" → Enter
4. Efecto se reproduce, vuelve a la presentación

**Ventaja:** No necesita salir del modo presentación

---

## Preguntas Frecuentes

### ¿Qué formatos de audio soporta?

**Soportados:**
- MP3
- WAV
- OGG
- FLAC
- M4A
- AAC

**Dependencia:** Basado en dart_vlc, que usa libVLC internamente.

### ¿Puedo reproducir múltiples sonidos a la vez?

**Sí**, hasta 10 sonidos simultáneamente (límite configurable en código).

**Ejemplo:**
- Música de fondo + Efectos de sonido
- Intro + Voz en off

### ¿Cómo envío el audio a OBS/Streaming software?

**Pasos:**

1. **Instalar cable virtual:**
   - Windows: VB-Audio Virtual Cable
   - macOS: BlackHole
   - Linux: PulseAudio Loopback

2. **Configurar SoundFua:**
   - Configuración → Audio → Dispositivo de salida
   - Seleccionar el cable virtual
   - O usar "Auto-detectar"

3. **Configurar OBS:**
   - Añadir fuente de audio
   - Seleccionar el mismo cable virtual
   - Ahora OBS captura el audio de SoundFua

### ¿Cómo funciona el overlay en macOS?

**Requisito:** Permisos de accesibilidad

**Configuración:**
1. Abrir Preferencias del Sistema
2. Seguridad y Privacidad → Accesibilidad
3. Permitir SoundFua Desktop
4. Reiniciar la app

**Sin permisos:** Los hotkeys globales no funcionarán.

### ¿Los sonidos se copian o se referencian?

**Comportamiento:** Se **copian** a la biblioteca local.

**Razones:**
- Evita que la app se rompa si mueves/eliminas el original
- Organización centralizada
- Backup automático

**Ubicación:** `~/Music/SoundFua/sounds/`

### ¿Puedo usar la app sin conexión a internet?

**Sí**, completamente offline.

**Funciones sin internet:**
- Gestión de biblioteca
- Reproducción de audio
- Quick Sounds
- Configuración

**Funciones que requieren internet (futuro):**
- Descarga de efectos de sonido desde bibliotecas online
- Sincronización en la nube
- Actualizaciones automáticas

### ¿Cómo hago backup de mi biblioteca?

**Manual:**
1. Localizar carpeta: `~/Music/SoundFua/`
2. Copiar toda la carpeta a ubicación segura
3. Incluye sonidos + base de datos

**Restaurar:**
1. Copiar carpeta backup a la ubicación original
2. Reiniciar la app

**Futuro:** Exportar/importar biblioteca desde UI

### ¿Puedo editar los archivos de audio en la app?

**Actualmente:** No, la app es un gestor/reproductor, no un editor.

**Recomendación:** Editar en software externo (Audacity, Adobe Audition) y luego importar.

**Futuro (roadmap):**
- Trim básico
- Fade in/out
- Normalización

### ¿La app afecta el rendimiento del sistema?

**Impacto:**
- **En reposo**: Mínimo (~30-50 MB RAM)
- **Reproduciendo**: Bajo (~100-150 MB RAM)
- **CPU**: < 1% en uso normal

**Optimizaciones:**
- Lazy loading de sonidos
- Streams eficientes
- Gestión de memoria automática

### ¿Hay límite de sonidos en la biblioteca?

**No hay límite técnico**, depende de:
- Espacio en disco
- Recursos del sistema
- Rendimiento de la base de datos SQLite

**Probado con:**
- 1000 sonidos: Sin problemas
- 5000 sonidos: Performance óptimo aún

**Recomendación:** Organizar en categorías cuando superes 100 sonidos

### ¿Puedo usar SoundFua en múltiples computadoras?

**Actualmente:** Cada instalación es independiente.

**Para sincronizar (manual):**
1. Hacer backup de `~/Music/SoundFua/`
2. Copiar a otra computadora
3. Colocar en la misma ubicación

**Futuro:** Sincronización en la nube planificada

### ¿La app es gratuita?

**Estado actual:** Proyecto en desarrollo

**Licencia:** Por definir

**Modelo potencial:**
- Versión gratuita con funciones básicas
- Versión Pro con features avanzadas
- O completamente open source

---

## Soporte y Ayuda

### Reportar Problemas

**GitHub Issues:** [Enlace al repositorio]

**Incluir:**
- Descripción del problema
- Pasos para reproducir
- Sistema operativo y versión
- Logs de la aplicación

### Solicitar Funcionalidades

**Feature Requests:** GitHub Discussions

**Formato sugerido:**
- Descripción de la funcionalidad
- Caso de uso
- Beneficio esperado

### Comunidad

**Discord:** [Enlace]
**Twitter:** [Enlace]
**Reddit:** [Enlace]

---

## Roadmap de Funcionalidades

### En Desarrollo
- ⏳ Edición básica de audio (trim, fade)
- ⏳ Categorías/Tags para organización
- ⏳ Atajos personalizables por sonido
- ⏳ Playlist/Queue de reproducción

### Planeado
- 📋 Importar/Exportar biblioteca
- 📋 Sincronización en la nube
- 📋 Integración con Spotify/Apple Music
- 📋 Efectos de audio (reverb, eq)
- 📋 Grabación de audio
- 📋 Modo "Soundboard" con grid visual

### Bajo Consideración
- 💭 Soporte para video
- 💭 Streaming directo a Discord/Zoom
- 💭 API para integración externa
- 💭 Extensiones/Plugins

---

**Última actualización:** Octubre 2025  
**Versión:** 1.0.0

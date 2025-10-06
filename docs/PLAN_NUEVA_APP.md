# 🎯 Plan de Desarrollo - SoundFua Overlay Desktop

## 📋 Información del Proyecto

**Nombre:** SoundFua Overlay Desktop
**Versión Objetivo:** 1.0.0
**Fecha de Inicio:** 2025-10-05
**Tipo:** Aplicación Desktop Multiplataforma

---

## 🎨 Visión del Producto

### Descripción
Aplicación desktop minimalista que funciona como un overlay de sonidos controlado por teclado, diseñada para streamers, gamers y usuarios de videoconferencias que necesitan reproducir sonidos rápidamente a través de su micrófono virtual.

### Propósito
Permitir a los usuarios reproducir sonidos desde una carpeta sincronizada mediante un overlay ligero activado por hotkey, sin interrumpir su flujo de trabajo.

### Usuarios Objetivo
- Streamers (Twitch, YouTube)
- Gamers que usan Discord
- Usuarios de videoconferencias (Zoom, Teams, Google Meet)
- Podcasters
- Presentadores

---

## ✨ Features Principales

### 1. **Overlay de Sonidos** 🎯
- Activación mediante hotkey personalizable (comportamiento tipo Game Bar)
- Lista vertical de sonidos con navegación por teclado
- Aparece mientras se mantiene presionado el hotkey
- Desaparece al soltar el hotkey y reproduce el sonido seleccionado
- Diseño minimalista y semi-transparente
- No causa sobrecarga de rendimiento

### 2. **Control por Teclado** ⌨️
- **Hotkey configurable**: Abrir/cerrar overlay (ej: ALT+S)
- **↑/↓**: Navegar entre sonidos
- **Soltar hotkey**: Cerrar overlay y reproducir sonido seleccionado
- **ESC**: Cerrar sin reproducir (opcional)
- Índice de selección persistente entre sesiones

### 3. **Integración del Sistema** 💻
- Icono en bandeja del sistema (System Tray)
- Minimizar a bandeja en lugar de cerrar
- Inicio con el sistema (opcional)
- Menú contextual:
  - Configuración
  - Salir/Cerrar

### 4. **Gestión de Sonidos** 📁
- Sincronización desde carpeta personalizada
- Botón "Sincronizar" para importar/actualizar (manual)
- Sincronización reemplaza completamente la BD
- Base de datos local (SQLite) para metadatos
- Formatos soportados: MP3 y WAV únicamente
- Ordenamiento inteligente por frecuencia de uso

### 5. **Configuración** ⚙️
- **Tema**: Claro / Oscuro / Sistema
- **Carpeta de Audios**: Ruta personalizable
- **Hotkey**: Combinación de teclas personalizable
- **Dispositivo de Audio**: Selección de cable virtual
- **Volumen Global**: Control maestro de la app (0% - 100%)
- **Sincronización**: Manual mediante botón
- Panel de configuración accesible desde tray

### 6. **Reproducción de Audio** 🔊
- Reproducción a través de cable virtual (micrófono)
- Compatible con Discord, Zoom, Teams, etc.
- Formatos soportados: MP3 y WAV
- Detección/configuración de dispositivo virtual
- Control de volumen global (no modifica volumen del sistema)

---

## 🏗️ Arquitectura Técnica

### Stack Tecnológico

#### Framework
- **Flutter**: 3.35.1+
- **Dart**: 3.9.0+
- **Plataformas**: Windows, macOS, Linux

#### Dependencias Core
```yaml
dependencies:
  flutter:
    sdk: flutter

  # State Management & DI
  flutter_riverpod: ^2.4.0

  # Base de Datos
  drift: ^2.12.0
  sqlite3_flutter_libs: ^0.5.0
  path_provider: ^2.1.0
  path: ^1.8.3

  # Audio
  media_kit: ^1.1.10
  media_kit_libs_audio: ^1.0.4

  # Functional Programming
  dartz: ^0.10.1

  # Sistema
  file_picker: ^5.5.0
  shared_preferences: ^2.2.2
  hotkey_manager: ^0.2.3
  window_manager: ^0.3.7
  system_tray: ^2.0.3

  # Code Generation
  freezed_annotation: ^2.4.0
  json_annotation: ^4.8.1

dev_dependencies:
  build_runner: ^2.4.6
  freezed: ^2.4.0
  json_serializable: ^6.7.1
  drift_dev: ^2.12.0
```

### Arquitectura Clean Architecture

```
┌─────────────────────────────────────────────────────────┐
│                   PRESENTATION LAYER                     │
│  • Overlay UI (Widget)                                  │
│  • Settings Page                                        │
│  • Riverpod Providers                                   │
│  • State Notifiers                                      │
└─────────────────────────────────────────────────────────┘
                          ↓ ↑
┌─────────────────────────────────────────────────────────┐
│                     DOMAIN LAYER                         │
│  • Entities: Sound, AudioDevice, Settings               │
│  • Use Cases: GetSounds, SyncFolder, PlaySound          │
│  • Repository Interfaces                                │
│  • Services Interfaces                                  │
└─────────────────────────────────────────────────────────┘
                          ↓ ↑
┌─────────────────────────────────────────────────────────┐
│                      DATA LAYER                          │
│  • Repository Implementations                           │
│  • Data Sources: Local DB, File System                  │
│  • Models & Mappers                                     │
└─────────────────────────────────────────────────────────┘
```

---

## 📂 Estructura del Proyecto

```
lib/
├── core/
│   ├── di/
│   │   └── injection.dart              # Dependency Injection
│   ├── error/
│   │   └── failures.dart                # Error handling
│   ├── usecases/
│   │   └── usecase.dart                 # Base UseCase
│   └── widgets/
│       └── window_lifecycle_manager.dart
│
├── features/
│   ├── overlay/                         # Feature: Overlay
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── sound.dart
│   │   │   ├── repositories/
│   │   │   │   └── sound_repository.dart
│   │   │   ├── services/
│   │   │   │   ├── overlay_service.dart
│   │   │   │   └── audio_service.dart
│   │   │   └── usecases/
│   │   │       ├── get_sounds.dart
│   │   │       ├── play_sound.dart
│   │   │       └── sync_folder.dart
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── sound_local_datasource.dart
│   │   │   │   └── sound_file_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── sound_model.dart
│   │   │   └── repositories/
│   │   │       └── sound_repository_impl.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   ├── overlay_providers.dart
│   │       │   └── sound_providers.dart
│   │       ├── state/
│   │       │   └── overlay_state.dart
│   │       └── widgets/
│   │           └── sound_overlay.dart
│   │
│   └── settings/                        # Feature: Settings
│       ├── domain/
│       │   ├── entities/
│       │   │   ├── app_settings.dart
│       │   │   └── audio_device.dart
│       │   ├── repositories/
│       │   │   └── settings_repository.dart
│       │   ├── services/
│       │   │   └── audio_device_service.dart
│       │   └── usecases/
│       │       ├── get_settings.dart
│       │       ├── save_settings.dart
│       │       └── get_audio_devices.dart
│       ├── data/
│       │   ├── datasources/
│       │   │   └── settings_local_datasource.dart
│       │   ├── models/
│       │   │   └── app_settings_model.dart
│       │   └── repositories/
│       │       └── settings_repository_impl.dart
│       └── presentation/
│           ├── pages/
│           │   └── settings_page.dart
│           ├── providers/
│           │   └── settings_providers.dart
│           └── widgets/
│               ├── theme_selector.dart
│               ├── folder_picker.dart
│               ├── hotkey_selector.dart
│               └── audio_device_selector.dart
│
└── main.dart                            # Entry point
```

---

## 🗂️ Base de Datos

### Esquema Drift

```dart
// Tabla: Sounds
class Sounds extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fileName => text()();
  TextColumn get filePath => text()();
  IntColumn get fileSize => integer()();
  DateTimeColumn get addedOn => dateTime()();
  DateTimeColumn get lastModified => dateTime()();
  IntColumn get playCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastPlayedAt => dateTime().nullable()();
}

// Tabla: Settings
class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}
```

### Claves de Settings
- `theme_mode`: "light" | "dark" | "system"
- `audio_folder_path`: Ruta de la carpeta de audios
- `hotkey`: Combinación de teclas (ej: "alt+s")
- `selected_audio_device`: ID del dispositivo de audio
- `last_selected_index`: Índice del último sonido seleccionado
- `global_volume`: Volumen global de la app (0.0 - 1.0)

---

## 🎯 Plan de Desarrollo por Hitos

### **Hito 1: Setup Inicial y Estructura Base** 🏗️
**Duración estimada:** 2-3 días
**Objetivo:** Configurar proyecto con Clean Architecture y dependencias

#### Tareas
- [ ] Crear nuevo proyecto Flutter desktop
- [ ] Configurar dependencias en `pubspec.yaml`
- [ ] Crear estructura de carpetas (Clean Architecture)
- [ ] Configurar Drift para base de datos
- [ ] Configurar Freezed y code generation
- [ ] Setup de inyección de dependencias con Riverpod
- [ ] Configurar `main.dart` inicial
- [ ] Documentar estructura en README

#### Entregables
- ✅ Proyecto compilable en las 3 plataformas
- ✅ Base de datos funcional (vacía)
- ✅ Estructura de carpetas completa
- ✅ Code generation funcionando

---

### **Hito 2: Sistema de Configuración Base** ⚙️
**Duración estimada:** 3-4 días
**Objetivo:** Implementar sistema de settings y persistencia

#### Tareas
- [ ] **Domain Layer:**
  - [ ] Crear entidad `AppSettings`
  - [ ] Crear repository interface `SettingsRepository`
  - [ ] Crear use cases: `GetSettings`, `SaveSettings`

- [ ] **Data Layer:**
  - [ ] Implementar `SettingsLocalDataSource` (Drift)
  - [ ] Implementar `SettingsRepositoryImpl`
  - [ ] Crear modelos y mappers

- [ ] **Presentation Layer:**
  - [ ] Crear providers de settings
  - [ ] Crear `SettingsPage` básica
  - [ ] Implementar selector de tema (claro/oscuro/sistema)
  - [ ] Implementar selector de carpeta de audios

- [ ] **Testing:**
  - [ ] Probar persistencia de configuraciones
  - [ ] Verificar cambio de tema en tiempo real

#### Entregables
- ✅ Página de configuración funcional
- ✅ Cambio de tema funcionando
- ✅ Selección de carpeta funcionando
- ✅ Configuraciones persistentes

---

### **Hito 3: Sincronización de Carpeta y Gestión de Sonidos** 📁
**Duración estimada:** 4-5 días
**Objetivo:** Leer carpeta de audios y sincronizar con BD

#### Tareas
- [ ] **Domain Layer:**
  - [ ] Crear entidad `Sound`
  - [ ] Crear repository interface `SoundRepository`
  - [ ] Crear use cases:
    - [ ] `SyncFolderUseCase`: Sincronizar carpeta
    - [ ] `GetAllSoundsUseCase`: Obtener todos los sonidos
    - [ ] `GetSoundByIdUseCase`: Obtener sonido específico

- [ ] **Data Layer:**
  - [ ] Implementar `SoundLocalDataSource` (Drift)
  - [ ] Implementar `SoundFileDataSource` (lectura de carpeta)
  - [ ] Implementar `SoundRepositoryImpl`
  - [ ] Lógica de sincronización:
    - [ ] Eliminar TODOS los registros de la tabla Sounds
    - [ ] Leer carpeta completa (solo archivos .mp3 y .wav)
    - [ ] Insertar cada archivo encontrado en la BD
    - [ ] Mantener playCount y lastPlayedAt si existía previamente (opcional)

- [ ] **Presentation Layer:**
  - [ ] Crear providers de sonidos
  - [ ] Botón "Sincronizar" en settings
  - [ ] Indicador de progreso de sincronización
  - [ ] Mostrar contador de sonidos sincronizados

#### Entregables
- ✅ Sincronización de carpeta funcionando
- ✅ Base de datos poblada con sonidos (solo MP3 y WAV)
- ✅ Reemplazo completo de BD en cada sincronización
- ✅ Feedback visual de sincronización
- ✅ Contador de archivos sincronizados

---

### **Hito 4: Sistema de Reproducción de Audio** 🔊
**Duración estimada:** 3-4 días
**Objetivo:** Implementar reproducción de audio a través de dispositivo virtual

#### Tareas
- [ ] **Domain Layer:**
  - [ ] Crear entidad `AudioDevice`
  - [ ] Crear service interface `AudioService`
  - [ ] Crear service interface `AudioDeviceService`
  - [ ] Crear use case `PlaySoundUseCase`

- [ ] **Data/Service Layer:**
  - [ ] Implementar `AudioServiceImpl`
  - [ ] Implementar `AudioDeviceServiceImpl`
  - [ ] Lógica de detección de dispositivos
  - [ ] Auto-detección de cables virtuales

- [ ] **Presentation Layer:**
  - [ ] Selector de dispositivo de audio en settings
  - [ ] Botón de "Auto-detectar cable virtual"
  - [ ] Indicador de dispositivo actual
  - [ ] Control deslizante de volumen global (0% - 100%)
  - [ ] Persistencia de volumen en settings

- [ ] **Testing:**
  - [ ] Probar reproducción en cable virtual
  - [ ] Probar en Discord/Zoom

#### Entregables
- ✅ Reproducción de audio funcionando (media_kit)
- ✅ Selección de dispositivo funcionando
- ✅ Auto-detección de cables virtuales
- ✅ Control de volumen global operativo
- ✅ Volumen NO modifica sistema, solo la app
- ✅ Integración con Discord/Zoom verificada

---

### **Hito 5: Overlay UI y Navegación** 🎯
**Duración estimada:** 4-5 días
**Objetivo:** Crear overlay semi-transparente con lista de sonidos

#### Tareas
- [ ] **Domain Layer:**
  - [ ] Crear service `OverlayService`
  - [ ] Definir estados del overlay
  - [ ] Lógica de navegación y selección
  - [ ] Implementar ordenamiento por playCount
  - [ ] Crear use case `IncrementPlayCountUseCase`

- [ ] **Presentation Layer:**
  - [ ] Crear widget `SoundOverlay`
  - [ ] Diseño UI:
    - [ ] Lista vertical de sonidos
    - [ ] Indicador de selección actual
    - [ ] Diseño minimalista y semi-transparente
    - [ ] Responsive a diferentes tamaños
  - [ ] Crear provider de estado del overlay
  - [ ] Implementar navegación con flechas:
    - [ ] Flecha arriba: sonido anterior
    - [ ] Flecha abajo: sonido siguiente
    - [ ] Wrap-around (circular)
  - [ ] Persistencia de índice seleccionado

- [ ] **Testing:**
  - [ ] Probar navegación por teclado
  - [ ] Verificar persistencia de selección
  - [ ] Probar con diferentes cantidades de sonidos

#### Entregables
- ✅ Overlay UI funcional
- ✅ Navegación por teclado (↑↓)
- ✅ Selección persistente entre sesiones
- ✅ Ordenamiento por frecuencia de uso (más usados primero)
- ✅ Contador de reproducción funcionando
- ✅ Diseño visual completo y minimalista

---

### **Hito 6: Sistema de Hotkeys Globales** ⌨️
**Duración estimada:** 3-4 días
**Objetivo:** Implementar hotkey global con comportamiento "hold to show"

#### Tareas
- [ ] **Domain Layer:**
  - [ ] Crear service `HotkeyService`
  - [ ] Lógica de registro/desregistro de hotkeys

- [ ] **Service Layer:**
  - [ ] Implementar `HotkeyServiceImpl` usando `hotkey_manager`
  - [ ] Comportamiento "hold to show":
    - [ ] Mostrar overlay al presionar hotkey
    - [ ] Mantener abierto mientras esté presionado
    - [ ] Cerrar y reproducir al soltar
  - [ ] Manejo de eventos de teclado

- [ ] **Presentation Layer:**
  - [ ] Configurador de hotkey en settings
  - [ ] Validación de combinaciones
  - [ ] Indicador visual de hotkey activo

- [ ] **Integración:**
  - [ ] Conectar hotkey con overlay service
  - [ ] Conectar liberación de hotkey con reproducción

- [ ] **Testing:**
  - [ ] Probar en Windows, macOS, Linux
  - [ ] Verificar permisos de accesibilidad (macOS)
  - [ ] Probar conflictos con otros atajos

#### Entregables
- ✅ Hotkey global funcionando
- ✅ Comportamiento "hold to show" implementado
- ✅ Configuración de hotkey personalizable
- ✅ Funcionando en las 3 plataformas

---

### **Hito 7: Integración con System Tray** 💻
**Duración estimada:** 2-3 días
**Objetivo:** Icono en bandeja del sistema con menú contextual

#### Tareas
- [ ] **Service Layer:**
  - [ ] Implementar `SystemTrayService`
  - [ ] Configurar icono del tray
  - [ ] Crear menú contextual:
    - [ ] "Configuración"
    - [ ] "Salir"

- [ ] **Window Lifecycle:**
  - [ ] Implementar `WindowLifecycleManager`
  - [ ] Interceptar cierre de ventana
  - [ ] Minimizar a tray en lugar de cerrar
  - [ ] Mostrar ventana desde tray

- [ ] **Testing:**
  - [ ] Probar minimizar/restaurar
  - [ ] Probar cierre desde tray
  - [ ] Verificar en las 3 plataformas

#### Entregables
- ✅ Icono en system tray funcionando
- ✅ Menú contextual operativo
- ✅ Lifecycle de ventana correcto
- ✅ No cierra al hacer clic en X

---

### **Hito 8: Pulido y Optimización** ✨
**Duración estimada:** 3-4 días
**Objetivo:** Mejorar UX, rendimiento y estabilidad

#### Tareas
- [ ] **Performance:**
  - [ ] Optimizar carga de overlay
  - [ ] Lazy loading de sonidos
  - [ ] Reducir latencia de reproducción
  - [ ] Optimizar queries de BD

- [ ] **UX Improvements:**
  - [ ] Animaciones del overlay
  - [ ] Transiciones suaves
  - [ ] Feedback visual de acciones
  - [ ] Mensajes de error amigables

- [ ] **Error Handling:**
  - [ ] Manejo robusto de errores
  - [ ] Notificaciones de estado
  - [ ] Logging de eventos importantes

- [ ] **Testing Integral:**
  - [ ] Casos de uso completos
  - [ ] Testing en las 3 plataformas
  - [ ] Testing con usuarios reales

#### Entregables
- ✅ App optimizada
- ✅ UX pulida
- ✅ Errores manejados correctamente
- ✅ Testing completo

---

### **Hito 9: Documentación y Deployment** 📚
**Duración estimada:** 2-3 días
**Objetivo:** Documentar y preparar para distribución

#### Tareas
- [ ] **Documentación:**
  - [ ] Actualizar README.md
  - [ ] Crear guía de instalación
  - [ ] Crear guía de configuración de cable virtual
  - [ ] Documentar arquitectura técnica

- [ ] **Build & Packaging:**
  - [ ] Configurar builds para Windows
  - [ ] Configurar builds para macOS
  - [ ] Configurar builds para Linux
  - [ ] Crear instaladores

- [ ] **Assets:**
  - [ ] Diseñar/crear icono de la app
  - [ ] Crear icono para tray
  - [ ] Screenshots para documentación

#### Entregables
- ✅ Documentación completa
- ✅ Builds para las 3 plataformas
- ✅ Instaladores funcionales
- ✅ Guías de usuario

---

## 📊 Cronograma Estimado

| Hito | Duración | Acumulado |
|------|----------|-----------|
| 1. Setup Inicial | 2-3 días | 3 días |
| 2. Sistema de Configuración | 3-4 días | 7 días |
| 3. Sincronización de Carpeta | 4-5 días | 12 días |
| 4. Sistema de Audio | 3-4 días | 16 días |
| 5. Overlay UI | 4-5 días | 21 días |
| 6. Hotkeys Globales | 3-4 días | 25 días |
| 7. System Tray | 2-3 días | 28 días |
| 8. Pulido | 3-4 días | 32 días |
| 9. Documentación | 2-3 días | 35 días |

**Total estimado:** ~5 semanas (35 días laborables)

---

## 🎯 Criterios de Éxito

### Por Hito
Cada hito debe cumplir:
- ✅ Código compila sin errores
- ✅ Funcionalidad core implementada
- ✅ Testing básico realizado
- ✅ Documentación de código actualizada

### Del Proyecto
- ✅ App funciona en Windows, macOS y Linux
- ✅ Overlay se abre/cierra con hotkey
- ✅ Navegación por teclado funciona correctamente
- ✅ Audio se reproduce a través de cable virtual
- ✅ Configuraciones persisten entre sesiones
- ✅ Sincronización de carpeta funciona
- ✅ System tray operativo
- ✅ Tema cambia correctamente
- ✅ No hay memory leaks ni sobrecarga de CPU
- ✅ UX es fluida y responsiva

---

## 🚧 Riesgos y Mitigaciones

### Riesgo 1: Compatibilidad de Hotkeys entre Plataformas
**Impacto:** Alto
**Mitigación:** Testing temprano en las 3 plataformas durante Hito 6

### Riesgo 2: Performance del Overlay
**Impacto:** Medio
**Mitigación:** Optimización en Hito 8, uso de widgets eficientes

### Riesgo 3: Detección de Cable Virtual
**Impacto:** Medio
**Mitigación:** Implementar detección manual como fallback

### Riesgo 4: Comportamiento "Hold to Show" del Hotkey
**Impacto:** Alto
**Mitigación:** Investigar API de `hotkey_manager`, considerar alternativas nativas

---

## ✅ Decisiones Técnicas Confirmadas

### 1. Stack de Audio
**Decisión:** `media_kit` + `media_kit_libs_audio`
**Razón:** Moderno, activamente mantenido, mejor performance y soporte multiplataforma

### 2. Formatos de Audio Soportados
**Decisión:** Solo MP3 y WAV
**Razón:** Formatos más comunes para soundboards, reduce complejidad

### 3. Comportamiento de Sincronización
**Decisión:**
- Sincronización manual ÚNICAMENTE desde configuración
- Cada sincronización ELIMINA COMPLETAMENTE la BD actual
- Se realiza lectura completa de la carpeta y se repuebla la BD
- Sin manejo de duplicados (se reemplaza todo)
**Razón:** Simplicidad, carpeta es fuente única de verdad

### 4. Ordenamiento de Lista
**Decisión:** Ordenamiento híbrido
- Inicialmente por fecha de agregado (más recientes primero)
- Dinámicamente por frecuencia de uso (más reproducidos primero)
- Campo `playCount` incrementa en cada reproducción
- Campo `lastPlayedAt` registra última reproducción
**Razón:** UX optimizada, sonidos más usados siempre accesibles

### 5. Control de Volumen
**Decisión:** Volumen global para la aplicación
- Control maestro que afecta toda la reproducción de la app
- No modifica volumen del sistema
- Rango: 0% - 100% (0.0 - 1.0)
**Razón:** Control simple y efectivo sin interferir con el sistema

### 6. Búsqueda/Filtrado en Overlay
**Decisión:** NO implementar búsqueda/filtrado
**Razón:** Overlay se mantiene visible solo mientras se mantiene hotkey presionado, no hay tiempo para escribir búsquedas

### 7. Comportamiento del Hotkey
**Decisión:** "Hold to show, release to play"
- Presionar y MANTENER hotkey → Overlay aparece
- Navegar con flechas mientras mantiene presionado
- SOLTAR hotkey → Overlay desaparece y reproduce sonido seleccionado
**Razón:** Flujo rápido, similar a Game Bar de Windows

### 8. Índice de Selección
**Decisión:** Persistente entre sesiones
- Se guarda en `last_selected_index` en settings
- Al abrir overlay, última selección está pre-seleccionada
**Razón:** UX mejorada, frecuentemente se usa el mismo sonido

---

## 📌 Notas Adicionales

### Aprendizajes del Proyecto Anterior
- Clean Architecture funciona muy bien para este tipo de apps
- Riverpod es excelente para DI y state management
- Drift es robusto para BD local
- dart_vlc tiene limitaciones, considerar migración
- Testing temprano evita problemas tarde

### Recomendaciones
- Hacer commits frecuentes por feature
- Testing manual en las 3 plataformas cada 2-3 hitos
- Documentar decisiones técnicas importantes
- Mantener código generado actualizado
- Usar Git branches por hito/feature

---

## 🔗 Referencias

- [Flutter Desktop Documentation](https://docs.flutter.dev/desktop)
- [Riverpod Documentation](https://riverpod.dev/)
- [Drift Documentation](https://drift.simonbinder.eu/)
- [hotkey_manager Package](https://pub.dev/packages/hotkey_manager)
- [window_manager Package](https://pub.dev/packages/window_manager)
- [system_tray Package](https://pub.dev/packages/system_tray)

---

**Última actualización:** 2025-10-05
**Versión del Plan:** 1.0

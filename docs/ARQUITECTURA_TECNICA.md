# Documentación Técnica - SoundFua Desktop

## Índice
1. [Descripción General](#descripción-general)
2. [Arquitectura del Sistema](#arquitectura-del-sistema)
3. [Stack Tecnológico](#stack-tecnológico)
4. [Estructura del Proyecto](#estructura-del-proyecto)
5. [Patrones de Diseño](#patrones-de-diseño)
6. [Módulos y Componentes](#módulos-y-componentes)
7. [Gestión de Estado](#gestión-de-estado)
8. [Persistencia de Datos](#persistencia-de-datos)
9. [Servicios del Sistema](#servicios-del-sistema)
10. [Flujo de Datos](#flujo-de-datos)

---

## Descripción General

**SoundFua Desktop** es una aplicación de escritorio multiplataforma (Windows, macOS, Linux) construida con Flutter/Dart, diseñada para gestionar y reproducir una biblioteca de sonidos con funcionalidades avanzadas como:

- Gestión de biblioteca de sonidos
- Reproducción de audio con selección de dispositivo de salida
- Sistema de overlay rápido con atajos de teclado
- Integración con bandeja del sistema
- Soporte para cables de audio virtuales

---

## Arquitectura del Sistema

### Arquitectura Limpia (Clean Architecture)

El proyecto sigue los principios de **Clean Architecture** con una separación clara de responsabilidades en tres capas principales:

```
┌─────────────────────────────────────────────────────┐
│              Presentation Layer                      │
│  (UI, Widgets, Pages, State Management)             │
└─────────────────────────────────────────────────────┘
                        ↓↑
┌─────────────────────────────────────────────────────┐
│               Domain Layer                           │
│  (Entities, Use Cases, Repository Interfaces)       │
└─────────────────────────────────────────────────────┘
                        ↓↑
┌─────────────────────────────────────────────────────┐
│                Data Layer                            │
│  (Repository Implementations, Data Sources, Models) │
└─────────────────────────────────────────────────────┘
```

#### Capas de la Arquitectura

1. **Presentation Layer (Capa de Presentación)**
   - Widgets de Flutter
   - Páginas y componentes UI
   - Gestión de estado con Riverpod
   - Providers y notificadores

2. **Domain Layer (Capa de Dominio)**
   - Entidades de negocio inmutables (con Freezed)
   - Casos de uso (Use Cases)
   - Interfaces de repositorios
   - Servicios de dominio
   - Lógica de negocio pura

3. **Data Layer (Capa de Datos)**
   - Implementaciones de repositorios
   - Data sources (local/remote)
   - Modelos de datos (DTOs)
   - Mappers de entidades

---

## Stack Tecnológico

### Framework y Lenguaje
- **Flutter**: 3.35.1
- **Dart**: 3.9.0
- **Plataformas soportadas**: Windows, macOS, Linux

### Dependencias Principales

#### State Management & DI
- `flutter_riverpod: ^2.4.0` - Gestión de estado reactivo e inyección de dependencias

#### Base de Datos
- `drift: ^2.12.0` - ORM para SQLite (Dart SQL builder type-safe)
- `sqlite3_flutter_libs: ^0.5.0` - SQLite nativo para Flutter
- `path_provider: ^2.1.0` - Acceso a directorios del sistema
- `path: ^1.8.3` - Manipulación de rutas

#### Audio
- `dart_vlc: ^0.4.0` - Reproductor de audio con soporte para selección de dispositivo
  - **Nota**: Paquete discontinuado, considerar migrar a `media_kit`

#### Functional Programming
- `dartz: ^0.10.1` - Tipos funcionales (Either, Option) para manejo de errores

#### Sistema & Archivos
- `file_picker: ^5.5.0` - Selector de archivos multiplataforma
- `shared_preferences: ^2.2.2` - Almacenamiento local clave-valor

#### Integración del Sistema
- `hotkey_manager: ^0.2.3` - Gestión de atajos de teclado globales
- `window_manager: ^0.3.7` - Control de ventanas desktop
- `system_tray: ^2.0.3` - Integración con bandeja del sistema
- `flutter_volume_controller: ^1.3.3` - Control de volumen del sistema

#### FFI
- `ffi: ^2.1.0` - Foreign Function Interface para interop nativo

#### Code Generation
- `freezed: ^2.4.0` - Generación de código para clases inmutables
- `json_serializable: ^6.7.1` - Serialización/deserialización JSON
- `build_runner: ^2.4.6` - Ejecutor de generadores de código
- `drift_dev: ^2.12.0` - Generador de código para Drift

---

## Estructura del Proyecto

```
lib/
├── core/                          # Código compartido
│   ├── di/                        # Dependency Injection
│   │   └── injection.dart         # Configuración de providers
│   ├── error/                     # Manejo de errores
│   │   └── failures.dart          # Clases de fallos
│   ├── services/                  # Servicios core
│   │   └── system_tray_service.dart
│   ├── usecases/                  # Caso de uso base
│   │   └── usecase.dart
│   ├── util/                      # Utilidades
│   │   ├── logger.dart
│   │   └── file_helper.dart
│   └── widgets/                   # Widgets reutilizables
│       └── window_lifecycle_manager.dart
│
├── features/                      # Características de la app
│   ├── sound_library/            # Gestión de biblioteca de sonidos
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── file/         # Operaciones con archivos
│   │   │   │   └── local/        # Base de datos local
│   │   │   ├── models/           # DTOs
│   │   │   └── repositories/     # Implementaciones
│   │   ├── domain/
│   │   │   ├── entities/         # Entidades de negocio
│   │   │   ├── repositories/     # Interfaces
│   │   │   ├── services/         # Servicios de audio
│   │   │   └── usecases/         # Casos de uso
│   │   └── presentation/
│   │       ├── pages/            # Páginas UI
│   │       ├── providers/        # Riverpod providers
│   │       ├── state/            # Estados UI
│   │       └── widgets/          # Widgets específicos
│   │
│   ├── settings/                 # Configuración de la app
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/         # Theme, Audio Device, etc.
│   │   │   ├── repositories/
│   │   │   ├── services/         # AudioDeviceService
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── pages/
│   │       ├── providers/
│   │       ├── state/
│   │       └── widgets/
│   │
│   └── quick_sounds/             # Overlay de sonidos rápidos
│       ├── domain/
│       │   └── services/         # QuickSoundService
│       └── presentation/
│           ├── providers/
│           └── widgets/          # Overlay UI
│
└── main.dart                     # Entry point
```

---

## Patrones de Diseño

### 1. **Repository Pattern**
- Abstracción de fuentes de datos
- Interfaces en domain layer
- Implementaciones en data layer
- Ejemplo: `SoundRepository` → `SoundRepositoryImpl`

### 2. **Use Case Pattern**
- Un caso de uso = una acción de negocio
- Encapsula lógica de negocio
- Ejemplos:
  - `GetAllSounds`
  - `AddSound`
  - `DeleteSound`
  - `GetThemeModeSetting`

### 3. **Dependency Injection (DI)**
- Usando Riverpod Providers
- Configuración centralizada en `injection.dart`
- Inversión de dependencias (SOLID)

### 4. **Singleton Pattern**
- Servicios del sistema como singletons
- `SystemTrayService`, `MultiAudioService`, `AudioDeviceService`
- Implementados con patrón factory

### 5. **Observer Pattern**
- Streams para comunicación asíncrona
- StateNotifiers para gestión de estado
- Riverpod para reactividad

### 6. **Factory Pattern**
- Constructores factory en entidades
- `fromJson()` para deserialización
- Freezed genera factories automáticamente

---

## Módulos y Componentes

### Feature: Sound Library

**Responsabilidad**: Gestión completa de la biblioteca de sonidos

#### Entidades
- `Sound`: Entidad inmutable de sonido
  ```dart
  Sound({
    int? id,
    String filePath,
    String alias,
    DateTime addedOn,
  })
  ```

#### Use Cases
- `GetAllSounds`: Obtener todos los sonidos
- `AddSound`: Agregar sonido nuevo
- `DeleteSound`: Eliminar sonido
- `UpdateSound`: Actualizar sonido
- `PlaySound`: Reproducir sonido

#### Data Sources
- `SoundLocalDataSource`: Operaciones CRUD en SQLite (Drift)
- `SoundFileDataSource`: Operaciones con archivos del sistema

#### Servicios
- `MultiAudioService`: Gestión de múltiples instancias de audio
- `AudioInstance`: Instancia individual de reproducción

### Feature: Settings

**Responsabilidad**: Configuración de la aplicación

#### Entidades
- `ThemeModeSetting`: Configuración de tema (light/dark/system)
- `AudioDevice`: Dispositivo de audio (id, name, isVirtual, etc.)
- `KeyboardShortcutSetting`: Configuración de atajos
- `VolumeSetting`: Configuración de volumen

#### Use Cases
- `GetThemeModeSetting`
- `SaveThemeModeSetting`
- `GetAudioDevices`
- `SetAudioDevice`

#### Servicios
- `AudioDeviceService`: Gestión de dispositivos de audio
  - Detección de dispositivos
  - Selección de dispositivo
  - Auto-detección de cables virtuales

#### Data Sources
- `SettingsDatabaseDataSource`: Persistencia en Drift
- `SettingsLocalDataSource`: SharedPreferences

### Feature: Quick Sounds

**Responsabilidad**: Overlay de sonidos rápidos con atajos de teclado

#### Servicios
- `QuickSoundService`: Servicio principal del overlay
  - Gestión de visibilidad
  - Navegación por teclado
  - Reproducción rápida
  - Registro de hotkeys

#### Componentes UI
- `QuickSoundOverlayManager`: Gestión del overlay
- `QuickSoundOverlay`: UI del overlay
- `PermissionsChecker`: Verificación de permisos

---

## Gestión de Estado

### Riverpod como Solución Central

**Tipos de Providers utilizados:**

1. **Provider**: Dependencias inmutables
   ```dart
   final soundRepositoryProvider = Provider<SoundRepository>((ref) {
     return SoundRepositoryImpl(...);
   });
   ```

2. **StateNotifierProvider**: Estado mutable con notificaciones
   ```dart
   final soundsNotifierProvider = StateNotifierProvider<SoundsNotifier, SoundsState>((ref) {
     return SoundsNotifier(ref.read(getAllSoundsProvider));
   });
   ```

3. **FutureProvider**: Operaciones asíncronas
   ```dart
   final settingsInitializerProvider = FutureProvider<void>((ref) async {
     await ref.read(settingsRepositoryProvider).initializeSettings();
   });
   ```

4. **StreamProvider**: Streams de datos
   ```dart
   final audioDevicesProvider = StreamProvider<List<AudioDevice>>((ref) {
     return ref.watch(audioDeviceServiceProvider).devicesStream;
   });
   ```

### Estados UI

**Pattern de Estados con Freezed:**

```dart
@freezed
class SoundsState with _$SoundsState {
  const factory SoundsState.initial() = _Initial;
  const factory SoundsState.loading() = _Loading;
  const factory SoundsState.loaded(List<Sound> sounds) = _Loaded;
  const factory SoundsState.error(String message) = _Error;
}
```

---

## Persistencia de Datos

### Drift (SQLite)

**Base de Datos**: `AppDatabase`

#### Tablas

**1. Sounds Table**
```dart
class Sounds extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get filePath => text()();
  TextColumn get alias => text()();
  DateTimeColumn get addedOn => dateTime()();
}
```

**2. Settings Table**
```dart
class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  
  @override
  Set<Column> get primaryKey => {key};
}
```

#### Operaciones
- **Type-safe queries** con Drift DSL
- **Streams** para cambios en tiempo real
- **Transactions** para operaciones atómicas
- **Migrations** para versionado de esquema

### SharedPreferences

**Uso**: Configuraciones ligeras y estado de sesión

Almacena:
- Último índice seleccionado en quick sounds
- Preferencias de usuario
- Device ID seleccionado

---

## Servicios del Sistema

### 1. SystemTrayService

**Funcionalidad**: Integración con bandeja del sistema

```dart
class SystemTrayService {
  // Singleton
  static final SystemTrayService _instance = SystemTrayService._internal();
  
  Future<void> initialize() async { ... }
  Future<void> _setupMenu() async { ... }
  Future<void> _handleMenuClick(MenuItemBase item) async { ... }
}
```

**Features**:
- Icono en bandeja del sistema
- Menú contextual
- Mostrar/ocultar ventana
- Cerrar aplicación

### 2. MultiAudioService

**Funcionalidad**: Gestión de múltiples instancias de audio simultáneas

```dart
class MultiAudioService {
  // Singleton
  static final MultiAudioService _instance = MultiAudioService._internal();
  
  Future<String> play(String filePath) async { ... }
  Future<void> stop(String instanceId) async { ... }
  Future<void> setDevice(AudioDevice device) async { ... }
}
```

**Features**:
- Reproducción simultánea de múltiples sonidos
- Gestión de instancias de audio
- Selección de dispositivo de salida
- Control de volumen

### 3. AudioDeviceService

**Funcionalidad**: Gestión de dispositivos de audio

```dart
class AudioDeviceService {
  Future<List<AudioDevice>> getDevices() async { ... }
  Future<void> setDevice(AudioDevice device) async { ... }
  bool hasVirtualCables() { ... }
  AudioDevice? autoDetectVirtualCable() { ... }
}
```

**Features**:
- Listado de dispositivos disponibles
- Detección de cables virtuales (VB-Cable, BlackHole, etc.)
- Persistencia de selección
- Integración con dart_vlc

### 4. QuickSoundService

**Funcionalidad**: Overlay de sonidos rápidos

```dart
class QuickSoundService {
  Future<void> initialize(KeyboardShortcutSetting shortcut, List<Sound> sounds) async { ... }
  void toggleOverlay() { ... }
  void selectNext() { ... }
  void selectPrevious() { ... }
  Future<void> playSelected() async { ... }
}
```

**Features**:
- Registro de hotkeys globales
- Navegación por teclado
- Reproducción rápida
- Gestión de visibilidad del overlay

### 5. WindowLifecycleManager

**Funcionalidad**: Gestión del ciclo de vida de la ventana

```dart
class WindowLifecycleManager extends StatefulWidget with WindowListener {
  @override
  void onWindowClose() async { ... }
  @override
  void onWindowFocus() { ... }
  @override
  void onWindowBlur() { ... }
}
```

**Features**:
- Interceptar cierre de ventana
- Minimizar a bandeja en lugar de cerrar
- Eventos de foco/desenfoque

---

## Flujo de Datos

### Flujo Típico: Agregar Sonido

```
1. Usuario selecciona archivo
   ↓
2. Presentation: AddSoundButton (Widget)
   ↓
3. Presentation: SoundsNotifier.addSound()
   ↓
4. Domain: AddSound UseCase.call()
   ↓
5. Domain: SoundRepository.addSound()
   ↓
6. Data: SoundRepositoryImpl.addSound()
   ↓
7. Data: SoundLocalDataSource.insertSound()
   ↓
8. Data: Drift Database INSERT
   ↓
9. Data: SoundFileDataSource.copyFile()
   ↓
10. Domain: Return Either<Failure, Sound>
    ↓
11. Presentation: Update UI State
```

### Flujo de Reproducción de Audio

```
1. Usuario hace clic en sonido
   ↓
2. Presentation: PlayButton onPressed
   ↓
3. Presentation: AudioNotifier.play()
   ↓
4. Domain: AudioService.play(filePath)
   ↓
5. Service: MultiAudioService.play()
   ↓
6. Service: Crear AudioInstance
   ↓
7. Service: dart_vlc Player.open()
   ↓
8. Service: Apply device configuration
   ↓
9. System: Audio playback starts
```

### Flujo de Quick Sounds

```
1. Usuario presiona hotkey (CMD+0)
   ↓
2. System: HotkeyManager detecta hotkey
   ↓
3. Service: QuickSoundService.toggleOverlay()
   ↓
4. Service: Emite evento en visibilityStream
   ↓
5. Presentation: QuickSoundOverlayManager actualiza
   ↓
6. UI: Muestra overlay con sonidos
   ↓
7. Usuario navega con flechas ↑↓
   ↓
8. Service: selectNext()/selectPrevious()
   ↓
9. Usuario presiona Enter
   ↓
10. Service: playSelected()
    ↓
11. Service: MultiAudioService.play()
    ↓
12. UI: Oculta overlay
```

---

## Consideraciones Técnicas

### Manejo de Errores

**Pattern: Either<Failure, Success>** (dartz)

```dart
Future<Either<Failure, List<Sound>>> getAllSounds() async {
  try {
    final sounds = await _localDataSource.getAllSounds();
    return Right(sounds);
  } catch (e) {
    return Left(CacheFailure(message: e.toString()));
  }
}
```

**Tipos de Failures**:
- `CacheFailure`: Errores de base de datos
- `ServerFailure`: Errores de red (futuro)
- `ValidationFailure`: Errores de validación

### Code Generation

**Comandos importantes**:
```bash
# Generar código (Freezed, JSON, Drift)
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode para desarrollo
flutter pub run build_runner watch
```

**Archivos generados**:
- `*.freezed.dart`: Clases inmutables con Freezed
- `*.g.dart`: Serialización JSON
- `*.drift.dart`: Queries de Drift

### Plataformas y Compatibilidad

**Windows**: ✅ Completo
- dart_vlc soportado
- System tray funcional
- Hotkeys globales

**macOS**: ✅ Completo (con limitaciones)
- dart_vlc requiere framework nativo
- System tray funcional
- Hotkeys con permisos de accesibilidad

**Linux**: ⚠️ Parcial
- dart_vlc soportado
- System tray depende de DE
- Hotkeys requieren configuración

### Limitaciones Conocidas

1. **dart_vlc**: Paquete discontinuado
   - Considerar migración a `media_kit`
   - Framework nativo requerido en macOS

2. **Audio Device Selection**: Limitado por dart_vlc
   - No todos los backends soportan selección de dispositivo

3. **Hotkeys en macOS**: Requiere permisos de accesibilidad

---

## Próximos Pasos Técnicos

1. **Migrar de dart_vlc a media_kit**
   - Mejor soporte multiplataforma
   - Activamente mantenido
   - Mayor rendimiento

2. **Implementar Tests**
   - Unit tests para use cases
   - Widget tests para UI
   - Integration tests para flujos completos

3. **Mejorar Error Handling**
   - Mensajes de error más descriptivos
   - Retry logic para operaciones críticas
   - Logging estructurado

4. **Optimizar Performance**
   - Lazy loading de sonidos
   - Cache de metadatos
   - Optimización de queries Drift

5. **CI/CD**
   - Builds automatizados
   - Tests en CI
   - Releases automatizadas

---

## Referencias

- [Flutter Clean Architecture](https://resocoder.com/flutter-clean-architecture-tdd/)
- [Riverpod Documentation](https://riverpod.dev/)
- [Drift Documentation](https://drift.simonbinder.eu/)
- [Freezed Documentation](https://pub.dev/packages/freezed)

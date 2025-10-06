# Decisiones Técnicas - SoundFua Overlay Desktop

**Fecha:** 2025-10-05
**Versión:** 1.0

---

## Resumen Ejecutivo

Este documento consolida todas las decisiones técnicas tomadas para el desarrollo de **SoundFua Overlay Desktop**, una aplicación multiplataforma de soundboard con overlay controlado por teclado.

---

## 🎯 Objetivo del Producto

Aplicación desktop minimalista que permite reproducir sonidos rápidamente a través de un cable de audio virtual mediante un overlay activado por hotkey, diseñada para streamers, gamers y usuarios de videoconferencias.

---

## ✅ Decisiones Confirmadas

### 1. Stack Tecnológico

| Componente | Tecnología | Versión | Justificación |
|------------|-----------|---------|---------------|
| Framework | Flutter | 3.35.1+ | Multiplataforma, nativo |
| Lenguaje | Dart | 3.9.0+ | Ecosistema Flutter |
| State Management | Riverpod | 2.4.0+ | DI y reactividad |
| Base de Datos | Drift (SQLite) | 2.12.0+ | Type-safe, robusto |
| Audio Player | media_kit | 1.1.10+ | Moderno, mantenido |
| Functional Programming | dartz | 0.10.1+ | Either/Failure pattern |
| Code Generation | Freezed | 2.4.0+ | Entidades inmutables |
| System Integration | hotkey_manager, window_manager, system_tray | Latest | Integración del SO |

---

### 2. Arquitectura

**Patrón:** Clean Architecture

**Capas:**
- **Presentation:** UI, Widgets, Riverpod Providers, State Notifiers
- **Domain:** Entidades, Use Cases, Repository Interfaces, Service Interfaces
- **Data:** Repository Implementations, Data Sources, Models

**Principios:**
- Separación de responsabilidades
- Inversión de dependencias (SOLID)
- Testabilidad
- Código limpio y legible
- Sin comentarios excesivos
- Nombres descriptivos

---

### 3. Formatos de Audio

**Decisión:** Solo MP3 y WAV

**Razones:**
- Formatos más comunes para soundboards
- Reduce complejidad de implementación
- Suficiente para el 95% de casos de uso
- Excelente soporte en media_kit

---

### 4. Sincronización de Carpeta

**Comportamiento:**
- ✅ Sincronización MANUAL únicamente (desde configuración)
- ✅ Cada sincronización ELIMINA COMPLETAMENTE la BD actual
- ✅ Se lee la carpeta completa (solo .mp3 y .wav)
- ✅ Se repuebla la BD con todos los archivos encontrados
- ❌ NO hay sincronización automática al inicio
- ❌ NO hay detección incremental de cambios
- ❌ NO hay manejo de duplicados (se reemplaza todo)

**Justificación:**
- Simplicidad en implementación
- Carpeta es la fuente única de verdad
- Evita complejidad de sincronización incremental
- Fácil de entender para el usuario

**Opcional (a considerar):**
- Preservar `playCount` y `lastPlayedAt` si el archivo ya existía
- Requiere match por nombre de archivo

---

### 5. Ordenamiento de Sonidos

**Estrategia:** Ordenamiento híbrido por frecuencia de uso

**Lógica:**
1. Al sincronizar: Todos los sonidos tienen `playCount = 0`
2. Al reproducir un sonido:
   - Incrementar `playCount` en +1
   - Actualizar `lastPlayedAt` con timestamp actual
3. Al mostrar lista en overlay:
   - Ordenar por `playCount` DESC (más usados primero)
   - Empates: ordenar por `lastPlayedAt` DESC (más reciente primero)
   - Si ambos son iguales: ordenar por `addedOn` DESC

**Campos en BD:**
- `playCount`: INTEGER DEFAULT 0
- `lastPlayedAt`: DATETIME NULL
- `addedOn`: DATETIME NOT NULL

**Ventaja:**
- UX optimizada: sonidos frecuentes siempre al alcance
- Adaptativo al comportamiento del usuario
- Sin configuración manual

---

### 6. Control de Volumen

**Decisión:** Volumen global para la aplicación

**Características:**
- ✅ Control maestro que afecta toda la reproducción
- ✅ Rango: 0% - 100% (0.0 - 1.0 internamente)
- ✅ NO modifica volumen del sistema operativo
- ✅ Persistente en settings (clave: `global_volume`)
- ✅ Slider en panel de configuración
- ❌ NO hay volumen individual por sonido

**Implementación:**
- Aplicar multiplicador al volumen del player antes de reproducir
- Ejemplo: Si volumen global = 0.5 (50%), player.setVolume(0.5)

**Justificación:**
- Simplicidad
- Control efectivo sin interferir con el sistema
- Evita confusión con múltiples controles

---

### 7. Comportamiento del Hotkey

**Patrón:** "Hold to show, release to play"

**Flujo:**
1. Usuario PRESIONA y MANTIENE hotkey (ej: ALT+S)
2. Overlay aparece inmediatamente
3. Usuario navega con flechas ↑↓ mientras mantiene hotkey presionado
4. Usuario SUELTA hotkey
5. Overlay desaparece y reproduce el sonido seleccionado

**Alternativa (ESC):**
- Presionar ESC cierra overlay SIN reproducir

**Características:**
- ⚡ Rápido: < 2 segundos desde activación hasta reproducción
- 🎮 Similar a Game Bar de Windows
- 👌 No requiere clicks del mouse

**Desafío técnico:**
- `hotkey_manager` puede no soportar detección de "release"
- Solución: Investigar API nativa o alternativa en Hito 6

---

### 8. Persistencia de Selección

**Decisión:** Índice persistente entre sesiones

**Implementación:**
- Al cambiar selección en overlay: Guardar `last_selected_index` en settings
- Al abrir overlay: Pre-seleccionar índice guardado
- Si índice > cantidad de sonidos: Seleccionar 0 (primero)

**Justificación:**
- UX mejorada
- Frecuentemente se usa el mismo sonido repetidamente
- Menos navegación necesaria

---

### 9. Búsqueda/Filtrado en Overlay

**Decisión:** NO implementar búsqueda/filtrado

**Razón:**
- Overlay solo está visible mientras se mantiene hotkey presionado
- No hay tiempo físico para escribir una búsqueda
- El ordenamiento por frecuencia de uso ya optimiza la UX
- Simplicidad

---

### 10. Integración del Sistema

**System Tray:**
- ✅ Icono en bandeja del sistema
- ✅ Menú contextual:
  - "Configuración"
  - "Salir"
- ✅ Click en icono: Mostrar/Ocultar ventana de configuración

**Window Lifecycle:**
- ✅ Botón X de la ventana: Minimiza a tray (NO cierra)
- ✅ Solo se cierra desde menú tray "Salir"
- ✅ Prevenir cierre accidental

**Inicio Automático:**
- ⏳ Planificado para futuras versiones
- No implementar en v1.0

---

## 🗂️ Esquema de Base de Datos

### Tabla: Sounds

```sql
CREATE TABLE sounds (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  file_name TEXT NOT NULL,
  file_path TEXT NOT NULL,
  file_size INTEGER NOT NULL,
  added_on DATETIME NOT NULL,
  last_modified DATETIME NOT NULL,
  play_count INTEGER NOT NULL DEFAULT 0,
  last_played_at DATETIME NULL
);
```

**Índices recomendados:**
```sql
CREATE INDEX idx_sounds_play_count ON sounds(play_count DESC);
CREATE INDEX idx_sounds_last_played_at ON sounds(last_played_at DESC);
```

### Tabla: Settings

```sql
CREATE TABLE settings (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL
);
```

**Claves utilizadas:**
- `theme_mode`: "light" | "dark" | "system"
- `audio_folder_path`: Ruta absoluta de la carpeta
- `hotkey`: Combinación de teclas (ej: "alt+s")
- `selected_audio_device`: ID del dispositivo de audio
- `last_selected_index`: INTEGER (índice del último sonido seleccionado)
- `global_volume`: REAL (0.0 - 1.0)

---

## 📏 Estándares de Código

### Nomenclatura

**Clases:**
- PascalCase
- Descriptivo y específico
- Ejemplos: `SoundRepository`, `PlaySoundUseCase`, `OverlayService`

**Variables y métodos:**
- camelCase
- Verbos para métodos, sustantivos para variables
- Ejemplos: `getSounds()`, `playCount`, `incrementPlayCount()`

**Constantes:**
- UPPER_SNAKE_CASE
- Ejemplos: `MAX_SOUNDS`, `DEFAULT_VOLUME`

### Comentarios

**Política:** Mínimos comentarios

**Cuándo comentar:**
- ✅ Lógica de negocio compleja no obvia
- ✅ Workarounds o hacks temporales (con TODO)
- ✅ Advertencias importantes

**Cuándo NO comentar:**
- ❌ Código auto-explicativo
- ❌ Métodos con nombres descriptivos
- ❌ Comentarios que repiten el código

### Organización

**Orden en archivos:**
1. Imports (ordenados alfabéticamente)
2. Constantes
3. Clase principal
4. Métodos públicos
5. Métodos privados

**Longitud de métodos:**
- Máximo 50 líneas (idealmente < 20)
- Un método = una responsabilidad

---

## 🚧 Limitaciones Conocidas

### 1. Hotkey "Hold to Show"
**Limitación:** `hotkey_manager` puede no soportar detección de "release"
**Plan:** Investigar en Hito 6, considerar alternativas nativas

### 2. Compatibilidad Multiplataforma
**macOS:**
- Requiere permisos de accesibilidad para hotkeys globales
- Usuario debe configurarlo manualmente

**Linux:**
- System tray depende del Desktop Environment
- Puede requerir configuración adicional

### 3. Sincronización
**Pérdida de playCount:**
- Si no se implementa la preservación, cada sincronización resetea contadores
- Considerar implementar en fase de pulido

---

## 📅 Cronograma de Decisiones

| Decisión | Hito Aplicable | Estado |
|----------|---------------|--------|
| Stack de Audio (media_kit) | Hito 4 | ✅ Confirmada |
| Formatos (MP3/WAV) | Hito 3 | ✅ Confirmada |
| Sincronización (reemplazo completo) | Hito 3 | ✅ Confirmada |
| Ordenamiento (frecuencia de uso) | Hito 5 | ✅ Confirmada |
| Volumen global | Hito 4 | ✅ Confirmada |
| Comportamiento hotkey | Hito 6 | ✅ Confirmada |
| Sin búsqueda en overlay | Hito 5 | ✅ Confirmada |

---

## 🔄 Decisiones Abiertas a Revisión

### 1. Preservación de playCount en Sincronización
**Pregunta:** ¿Mantener contadores al resincronizar archivos que ya existían?

**Opción A (Simple):** Resetear todo
- Pros: Implementación simple
- Contras: Se pierde historial de uso

**Opción B (Preservar):** Mantener contadores
- Pros: Mejor UX, no se pierde historial
- Contras: Requiere lógica de match por nombre

**Recomendación:** Implementar Opción A inicialmente, Opción B en fase de pulido

### 2. Inicio Automático con Sistema
**Pregunta:** ¿Implementar en v1.0 o posponer?

**Recomendación:** Posponer a v1.1, no es crítico para MVP

---

## 📊 Métricas de Éxito

### Performance
- ⚡ Latencia de overlay: < 100ms desde hotkey hasta visualización
- ⚡ Latencia de reproducción: < 200ms desde soltar hotkey
- 💾 Uso de RAM: < 150 MB en reposo
- 🔋 Uso de CPU: < 1% en reposo

### UX
- 👍 Tiempo total de flujo: < 2 segundos (hotkey → selección → reproducción)
- 🎯 Tasa de error: < 5% (reproducción del sonido incorrecto)
- 📱 Responsividad: 60 FPS en overlay

### Estabilidad
- ✅ Sin crashes en 1 hora de uso continuo
- ✅ Sin memory leaks
- ✅ Sincronización exitosa con carpetas de 1000+ archivos

---

## 🔗 Referencias

- [Plan de Desarrollo Completo](./PLAN_NUEVA_APP.md)
- [Arquitectura del Proyecto Base](./ARQUITECTURA_TECNICA.md)
- [Funcionalidades del Proyecto Base](./FUNCIONALIDADES.md)

---

**Última actualización:** 2025-10-05
**Responsable:** Equipo de Desarrollo
**Próxima revisión:** Al completar Hito 3

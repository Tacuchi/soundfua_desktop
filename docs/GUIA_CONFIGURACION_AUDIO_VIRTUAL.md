# 🎵 Guía de Configuración de Audio Virtual

## 📋 Tabla de Contenidos
- [¿Qué es un Cable de Audio Virtual?](#qué-es-un-cable-de-audio-virtual)
- [¿Por qué lo necesitas?](#por-qué-lo-necesitas)
- [Instalación de VB-CABLE](#instalación-de-vb-cable)
- [Configuración en SoundFua Desktop](#configuración-en-soundfua-desktop)
- [Configuración en Discord/Zoom/Teams](#configuración-en-discordzoomteams)
- [Resolución de Problemas](#resolución-de-problemas)

---

## 🎯 ¿Qué es un Cable de Audio Virtual?

Un **cable de audio virtual** es un dispositivo de audio software que actúa como un puente entre aplicaciones. Permite que el audio de una aplicación (SoundFua Desktop) sea "escuchado" por otra aplicación (Discord, Zoom, etc.) como si fuera un micrófono real.

### Analogía Simple
Imagina que tienes dos habitaciones:
- **Habitación A**: SoundFua Desktop reproduciendo sonidos
- **Habitación B**: Discord/Zoom esperando entrada de micrófono

El cable virtual es como un tubo que conecta ambas habitaciones, permitiendo que el sonido viaje de A a B.

---

## 🤔 ¿Por qué lo necesitas?

**SoundFua Desktop** reproduce sonidos a través de tus altavoces/auriculares (salida de audio). Sin embargo, aplicaciones como Discord, Zoom o Teams solo capturan audio desde tu micrófono (entrada de audio).

**El cable virtual resuelve esto** haciendo que la salida de SoundFua aparezca como una entrada de micrófono para otras aplicaciones.

### Casos de Uso
- ✅ Reproducir efectos de sonido en llamadas de Discord
- ✅ Usar soundboard en reuniones de Zoom
- ✅ Compartir audio en Microsoft Teams
- ✅ Transmitir sonidos en streams de Twitch/OBS

---

## 📥 Instalación de VB-CABLE

**VB-CABLE** es un cable de audio virtual gratuito, ligero y confiable.

### Paso 1: Descargar VB-CABLE

1. Visita el sitio oficial: [https://vb-audio.com/Cable/](https://vb-audio.com/Cable/)
2. Haz clic en **"Download"** en la sección **VB-CABLE Virtual Audio Device**
3. Descarga el archivo ZIP (aproximadamente 1 MB)

### Paso 2: Instalar VB-CABLE

1. **Extrae el archivo ZIP** descargado
2. **Haz clic derecho** en `VBCABLE_Setup_x64.exe` (o `VBCABLE_Setup.exe` para 32-bit)
3. Selecciona **"Ejecutar como administrador"**
4. Haz clic en **"Install Driver"**
5. Acepta la instalación del driver cuando Windows te lo pida
6. **Reinicia tu computadora** (importante)

### Paso 3: Verificar la Instalación

Después de reiniciar:

1. Abre **Configuración de Windows** → **Sistema** → **Sonido**
2. En **Dispositivos de salida**, deberías ver:
   - `CABLE Input (VB-Audio Virtual Cable)`
3. En **Dispositivos de entrada**, deberías ver:
   - `CABLE Output (VB-Audio Virtual Cable)`

✅ Si ves ambos dispositivos, ¡la instalación fue exitosa!

---

## ⚙️ Configuración en SoundFua Desktop

### Opción 1: Auto-Detección (Recomendada)

1. Abre **SoundFua Desktop**
2. Ve a **Ajustes** (⚙️ en la esquina superior derecha)
3. Busca la sección **"Dispositivo de Audio Virtual"**
4. Haz clic en el botón **"Auto-detectar Virtual Cable"** 📢

¡Listo! SoundFua detectará automáticamente VB-CABLE y lo configurará.

### Opción 2: Selección Manual

Si la auto-detección no funciona:

1. Abre **SoundFua Desktop** → **Ajustes**
2. En **"Dispositivos disponibles"**, busca:
   - `CABLE Input (VB-Audio Virtual Cable)` 📢
3. Haz clic en ese dispositivo para seleccionarlo
4. Verás una marca verde ✅ indicando que está seleccionado

### Verificar Configuración

En **Ajustes**, deberías ver algo como:

```
┌─────────────────────────────────────┐
│ 📢 CABLE Input (VB-Audio Virtual)  │
│ ✓ Seleccionado                      │
│ Virtual Audio Cable • Selected      │
└─────────────────────────────────────┘
```

---

## 🎤 Configuración en Discord/Zoom/Teams

Una vez que SoundFua esté configurado con VB-CABLE, configura tu aplicación de comunicación:

### Discord

1. Abre Discord
2. Ve a **Configuración de Usuario** (⚙️) → **Voz y Video**
3. En **Dispositivo de Entrada**, selecciona:
   - `CABLE Output (VB-Audio Virtual Cable)`
4. Ajusta la **Sensibilidad de Entrada** si es necesario
5. ¡Listo! Ahora Discord "escuchará" los sonidos de SoundFua

### Zoom

1. Abre Zoom
2. Ve a **Configuración** → **Audio**
3. En **Micrófono**, selecciona:
   - `CABLE Output (VB-Audio Virtual Cable)`
4. Prueba el micrófono con el botón **"Probar"**

### Microsoft Teams

1. Abre Teams
2. Ve a **Configuración** → **Dispositivos**
3. En **Micrófono**, selecciona:
   - `CABLE Output (VB-Audio Virtual Cable)`
4. Haz una prueba de audio

### Google Meet / Otras Apps

El proceso es similar: busca la configuración de audio/micrófono y selecciona **CABLE Output**.

---

## 🎮 Cómo Usar SoundFua en una Llamada

1. **Únete a una llamada** en Discord/Zoom/etc.
2. **Abre SoundFua Desktop**
3. **Reproduce un sonido** haciendo clic en cualquier tarjeta de sonido
4. Los participantes de la llamada **escucharán el sonido** 🎉

### Usando Quick Sounds (Atajos de Teclado)

1. Presiona **ALT+S** (o tu atajo personalizado)
2. Aparecerá un overlay con tus sonidos
3. Usa las **flechas** para navegar
4. **Suelta ALT+S** para reproducir el sonido seleccionado

---

## 🔊 Configuración de Volumen

### Volumen de SoundFua

- Ajusta el volumen en **Ajustes** → **Control de Volumen**
- Este controla qué tan fuerte se escuchan los sonidos en Discord/Zoom

### Volumen en Discord/Zoom

- Los participantes pueden ajustar tu volumen individualmente
- En Discord, haz clic derecho en tu nombre → **Ajustar volumen de usuario**

### Escucharte a Ti Mismo (Opcional)

Si quieres escuchar los sonidos mientras se reproducen:

**Opción 1: Listen to This Device (Windows)**
1. Abre **Panel de Control** → **Sonido**
2. Pestaña **Grabación** → Haz clic derecho en **CABLE Output**
3. Selecciona **Propiedades** → Pestaña **Escuchar**
4. Marca **"Escuchar este dispositivo"**
5. Selecciona tus auriculares/altavoces en el menú desplegable

⚠️ **Advertencia**: Esto puede causar eco si no usas auriculares.

---

## 🚨 Resolución de Problemas

### Problema: "No se encontraron dispositivos de audio"

**Solución:**
1. Verifica que VB-CABLE esté instalado (ve a Configuración de Windows → Sonido)
2. Reinicia SoundFua Desktop
3. Haz clic en **"Auto-detectar Virtual Cable"** en Ajustes

### Problema: "Los participantes no me escuchan"

**Solución:**
1. Verifica que Discord/Zoom use **CABLE Output** como micrófono
2. Verifica que SoundFua use **CABLE Input** como salida
3. Reproduce un sonido de prueba
4. Verifica que no estés muteado en Discord/Zoom

### Problema: "Escucho eco o doble audio"

**Solución:**
1. Desactiva **"Escuchar este dispositivo"** en CABLE Output
2. Cierra otras aplicaciones que puedan estar usando VB-CABLE
3. Verifica que solo Discord/Zoom esté capturando desde CABLE Output

### Problema: "No puedo hablar por mi micrófono normal"

**Solución:**

**Opción A**: Usa VoiceMeeter (mixer avanzado)
- Descarga VoiceMeeter Banana: [https://vb-audio.com/Voicemeeter/](https://vb-audio.com/Voicemeeter/)
- Permite mezclar tu micrófono + SoundFua en un solo canal

**Opción B**: Cambia rápidamente de micrófono
1. Cuando necesites hablar, cambia Discord a tu micrófono real
2. Cuando quieras reproducir sonidos, cambia a CABLE Output

**Opción C**: Usa dos instancias de Discord (avanzado)
- Requiere dos cuentas o usar Discord web + app

### Problema: "VB-CABLE se desinstala después de reiniciar"

**Solución:**
1. Desinstala VB-CABLE completamente
2. Desactiva temporalmente el antivirus
3. Reinstala como administrador
4. Reactiva el antivirus
5. Agrega VB-CABLE a la lista de excepciones del antivirus

### Problema: "Calidad de audio baja o distorsionada"

**Solución:**
1. Abre **Panel de Control** → **Sonido**
2. Pestaña **Reproducción** → **CABLE Input** → **Propiedades**
3. Pestaña **Avanzado** → Cambia a **"24 bit, 48000 Hz"**
4. Aplica los cambios y reinicia SoundFua

---

## 💡 Consejos y Trucos

### 🎯 Consejo 1: Usa Hotkeys en Llamadas
- Configura **Quick Sounds** con un atajo cómodo (ALT+S por defecto)
- Practica navegar el overlay antes de usar en llamadas reales

### 🎯 Consejo 2: Organiza tus Sonidos
- Usa alias descriptivos para identificar rápidamente
- Borra sonidos que ya no uses

### 🎯 Consejo 3: Ajusta el Volumen
- Prueba diferentes niveles antes de usarlo en llamadas
- Un volumen muy alto puede molestar a los participantes

### 🎯 Consejo 4: Ten un Sonido de Prueba
- Guarda un sonido corto (como "test") para probar rápidamente

### 🎯 Consejo 5: Comunica con tu Equipo
- Avisa cuando uses el soundboard por primera vez
- Úsalo con moderación para no interrumpir

---

## 🔗 Enlaces Útiles

- **VB-CABLE Oficial**: https://vb-audio.com/Cable/
- **VoiceMeeter (Mixer Avanzado)**: https://vb-audio.com/Voicemeeter/
- **Soporte SoundFua**: [GitHub Issues](https://github.com/tu-repo/soundfua_desktop/issues)

---

## ❓ Preguntas Frecuentes

**P: ¿VB-CABLE es seguro?**  
R: Sí, VB-CABLE es un software legítimo y ampliamente usado. Desarrollado por VB-Audio Software.

**P: ¿Es gratis?**  
R: Sí, VB-CABLE es completamente gratuito. Puedes hacer una donación al desarrollador si lo deseas.

**P: ¿Funciona en Windows 11?**  
R: Sí, VB-CABLE es compatible con Windows 10, 11 y versiones anteriores.

**P: ¿Puedo usar otros cables virtuales?**  
R: Sí, SoundFua detecta automáticamente cables virtuales como:
- VB-CABLE
- Virtual Audio Cable (VAC)
- VoiceMeeter (Input/Output)
- Y otros cables virtuales

**P: ¿Afecta el rendimiento de mi PC?**  
R: No, VB-CABLE tiene un impacto mínimo en el rendimiento.

**P: ¿Puedo usar múltiples aplicaciones con VB-CABLE?**  
R: Sí, pero solo una aplicación puede capturar desde CABLE Output al mismo tiempo. Para múltiples aplicaciones, considera usar VoiceMeeter.

---

**¿Necesitas más ayuda?** Abre un issue en nuestro repositorio de GitHub con tu pregunta.

---

**Última actualización:** 2025-10-04  
**Versión:** 1.0.0

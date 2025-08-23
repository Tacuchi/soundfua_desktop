import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import '../../../../core/util/logger.dart';

/// Widget que verifica y solicita permisos necesarios para atajos de teclado
class PermissionsChecker extends ConsumerStatefulWidget {
  final Widget child;

  const PermissionsChecker({super.key, required this.child});

  @override
  ConsumerState<PermissionsChecker> createState() => _PermissionsCheckerState();
}

class _PermissionsCheckerState extends ConsumerState<PermissionsChecker> {
  bool _permissionsChecked = false;
  bool _hasPermissions = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    try {
      Logger().info('Checking hotkey permissions', tag: 'QUICK_SOUNDS');

      // En macOS, necesitamos verificar permisos de accesibilidad
      // Para hotkey_manager, vamos a intentar registrar un hotkey temporal
      final testHotKey = HotKey(
        key: LogicalKeyboardKey.f1,
        modifiers: [HotKeyModifier.meta],
      );

      try {
        await hotKeyManager.register(testHotKey, keyDownHandler: (_) {});
        await hotKeyManager.unregister(testHotKey);

        Logger().info('Hotkey permissions available', tag: 'QUICK_SOUNDS');
        setState(() {
          _hasPermissions = true;
          _permissionsChecked = true;
        });
      } catch (e) {
        Logger().warning(
          'Hotkey permissions not available: $e',
          tag: 'QUICK_SOUNDS',
        );
        setState(() {
          _hasPermissions = false;
          _permissionsChecked = true;
        });
      }
    } catch (e) {
      Logger().error('Error checking permissions: $e', tag: 'QUICK_SOUNDS');
      setState(() {
        _hasPermissions = false;
        _permissionsChecked = true;
      });
    }
  }

  void _showPermissionsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permisos Requeridos'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Para usar atajos de teclado globales, la aplicación necesita permisos de accesibilidad.',
            ),
            SizedBox(height: 16),
            Text('Pasos para habilitar:'),
            SizedBox(height: 8),
            Text('1. Abre Preferencias del Sistema'),
            Text('2. Ve a Seguridad y Privacidad'),
            Text('3. Selecciona la pestaña Privacidad'),
            Text('4. Busca "Accesibilidad" en la lista'),
            Text('5. Agrega esta aplicación a la lista'),
            SizedBox(height: 16),
            Text(
              'Después reinicia la aplicación.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Entendido'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _checkPermissions();
            },
            child: const Text('Verificar de nuevo'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_permissionsChecked) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!_hasPermissions) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showPermissionsDialog();
      });
    }

    return widget.child;
  }
}

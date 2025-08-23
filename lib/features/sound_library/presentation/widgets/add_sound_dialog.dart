import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../core/util/file_helper.dart';
import '../../../../core/util/logger.dart';

class AddSoundDialog extends StatefulWidget {
  final Function(String filePath, String alias) onSoundAdded;

  const AddSoundDialog({super.key, required this.onSoundAdded});

  @override
  State<AddSoundDialog> createState() => _AddSoundDialogState();
}

class _AddSoundDialogState extends State<AddSoundDialog> {
  final _formKey = GlobalKey<FormState>();
  final _aliasController = TextEditingController();
  String? _selectedFilePath;
  bool _isLoading = false;

  @override
  void dispose() {
    _aliasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar Nuevo Sonido'),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // File selection
              const Text(
                'Seleccionar archivo de audio:',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedFilePath != null
                            ? _selectedFilePath!.split('/').last
                            : 'Ningún archivo seleccionado',
                        style: TextStyle(
                          color: _selectedFilePath != null
                              ? Colors.black87
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _selectFile,
                      child: const Text('Seleccionar'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Alias input
              TextFormField(
                controller: _aliasController,
                decoration: const InputDecoration(
                  labelText: 'Alias/Nombre del sonido',
                  hintText: 'Ingresa un nombre para identificar el sonido',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa un alias para el sonido';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 8),

              // Supported formats info
              Text(
                'Formatos soportados: ${FileHelper.supportedAudioFormats.join(', ')}',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading
              ? null
              : () {
                  Navigator.of(context).pop();
                },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _addSound,
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Agregar'),
        ),
      ],
    );
  }

  Future<void> _selectFile() async {
    try {
      Logger().info('User initiated file selection', tag: 'ADD_SOUND');
      setState(() {
        _isLoading = true;
      });

      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: FileHelper.supportedAudioFormats,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        if (file.path != null) {
          Logger().info(
            'File selected: ${file.name} (${file.size} bytes)',
            tag: 'ADD_SOUND',
          );
          setState(() {
            _selectedFilePath = file.path;
            // Auto-fill alias with filename (without extension) if empty
            if (_aliasController.text.isEmpty) {
              final fileName = file.name;
              final nameWithoutExtension = fileName.contains('.')
                  ? fileName.substring(0, fileName.lastIndexOf('.'))
                  : fileName;
              _aliasController.text = nameWithoutExtension;
              Logger().debug(
                'Auto-filled alias: $nameWithoutExtension',
                tag: 'ADD_SOUND',
              );
            }
          });
        }
      } else {
        Logger().info('File selection cancelled by user', tag: 'ADD_SOUND');
      }
    } catch (e, stackTrace) {
      Logger().error(
        'Error selecting file',
        tag: 'ADD_SOUND',
        error: e,
        stackTrace: stackTrace,
      );
      _showErrorSnackBar('Error al seleccionar archivo: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addSound() {
    Logger().info('Adding sound - validation started', tag: 'ADD_SOUND');

    if (!_formKey.currentState!.validate() || _selectedFilePath == null) {
      if (_selectedFilePath == null) {
        Logger().warning(
          'Sound addition failed - no file selected',
          tag: 'ADD_SOUND',
        );
        _showErrorSnackBar('Por favor selecciona un archivo de audio');
      }
      return;
    }

    final filePath = _selectedFilePath!;
    final alias = _aliasController.text.trim();

    Logger().info(
      'Validating selected file: $filePath with alias: $alias',
      tag: 'ADD_SOUND',
    );

    // Additional validation
    if (!FileHelper.fileExists(filePath)) {
      Logger().error(
        'Sound addition failed - file does not exist: $filePath',
        tag: 'ADD_SOUND',
      );
      _showErrorSnackBar('El archivo seleccionado no existe');
      return;
    }

    if (!FileHelper.isSupportedAudioFormat(filePath)) {
      Logger().error(
        'Sound addition failed - unsupported format: $filePath',
        tag: 'ADD_SOUND',
      );
      _showErrorSnackBar('El formato de archivo no es compatible');
      return;
    }

    Logger().info(
      'Sound validation passed - adding to library',
      tag: 'ADD_SOUND',
    );

    // Call the callback
    widget.onSoundAdded(filePath, alias);
    Logger().info('Sound added successfully: $alias', tag: 'ADD_SOUND');
    Navigator.of(context).pop();
  }

  void _showErrorSnackBar(String message) {
    Logger().warning('Showing error to user: $message', tag: 'ADD_SOUND');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}

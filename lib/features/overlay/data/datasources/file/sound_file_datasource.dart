import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:soundfua_desktop/features/overlay/data/models/sound_model.dart';

class SoundFileDataSource {
  Future<List<SoundModel>> readFolder(String folderPath) async {
    final dir = Directory(folderPath);

    if (!await dir.exists()) {
      throw FileSystemException(
        'La carpeta no existe',
        folderPath,
      );
    }

    final now = DateTime.now();
    final sounds = <SoundModel>[];

    await for (final entity in dir.list()) {
      if (entity is File) {
        final fileName = p.basename(entity.path);

        if (fileName.startsWith('.')) {
          continue;
        }

        final extension = p.extension(fileName).toLowerCase();
        if (extension != '.mp3' && extension != '.wav') {
          continue;
        }

        final stat = await entity.stat();

        sounds.add(
          SoundModel(
            fileName: fileName,
            filePath: entity.absolute.path,
            fileSize: stat.size,
            addedOn: now,
            lastModified: stat.modified,
          ),
        );
      }
    }

    return sounds;
  }
}

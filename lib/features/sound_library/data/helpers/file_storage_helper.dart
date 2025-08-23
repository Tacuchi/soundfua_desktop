import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../../../core/util/logger.dart';

/// Helper class for managing file storage within the app's directory
class FileStorageHelper {
  static const String _soundsDirectoryName = 'sounds';

  /// Get the sounds directory within the app's documents directory
  static Future<Directory> getSoundsDirectory() async {
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final soundsDir = Directory(p.join(appDocDir.path, _soundsDirectoryName));

      if (!await soundsDir.exists()) {
        await soundsDir.create(recursive: true);
        Logger().info(
          'Created sounds directory: ${soundsDir.path}',
          tag: 'FILE_STORAGE',
        );
      }

      return soundsDir;
    } catch (e) {
      Logger().error(
        'Error getting sounds directory',
        tag: 'FILE_STORAGE',
        error: e,
      );
      rethrow;
    }
  }

  /// Copy a file from external path to internal sounds directory
  static Future<String> copyFileToSoundsDirectory(
    String externalFilePath,
  ) async {
    try {
      Logger().info(
        'Copying file to internal storage: $externalFilePath',
        tag: 'FILE_STORAGE',
      );

      final sourceFile = File(externalFilePath);
      if (!await sourceFile.exists()) {
        throw Exception('Source file does not exist: $externalFilePath');
      }

      final soundsDir = await getSoundsDirectory();
      final fileName = p.basename(externalFilePath);

      // Generate unique filename if file already exists
      String finalFileName = fileName;
      String nameWithoutExtension = p.basenameWithoutExtension(fileName);
      String extension = p.extension(fileName);
      int counter = 1;

      while (await File(p.join(soundsDir.path, finalFileName)).exists()) {
        finalFileName = '${nameWithoutExtension}_$counter$extension';
        counter++;
      }

      final destinationPath = p.join(soundsDir.path, finalFileName);

      await sourceFile.copy(destinationPath);

      Logger().info(
        'File copied successfully to: $destinationPath',
        tag: 'FILE_STORAGE',
      );
      return destinationPath;
    } catch (e) {
      Logger().error(
        'Error copying file to internal storage',
        tag: 'FILE_STORAGE',
        error: e,
      );
      rethrow;
    }
  }

  /// Check if a file exists in the internal sounds directory
  static Future<bool> fileExists(String filePath) async {
    try {
      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      Logger().error(
        'Error checking file existence: $filePath',
        tag: 'FILE_STORAGE',
        error: e,
      );
      return false;
    }
  }

  /// Delete a file from the internal sounds directory
  static Future<bool> deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        Logger().info('File deleted: $filePath', tag: 'FILE_STORAGE');
        return true;
      }
      return false;
    } catch (e) {
      Logger().error(
        'Error deleting file: $filePath',
        tag: 'FILE_STORAGE',
        error: e,
      );
      return false;
    }
  }

  /// Get file size in bytes
  static Future<int> getFileSize(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        return await file.length();
      }
      return 0;
    } catch (e) {
      Logger().error(
        'Error getting file size: $filePath',
        tag: 'FILE_STORAGE',
        error: e,
      );
      return 0;
    }
  }

  /// Get all files in the sounds directory
  static Future<List<String>> getAllSoundFiles() async {
    try {
      final soundsDir = await getSoundsDirectory();
      final files = <String>[];

      if (await soundsDir.exists()) {
        await for (final entity in soundsDir.list()) {
          if (entity is File) {
            files.add(entity.path);
          }
        }
      }

      Logger().info(
        'Found ${files.length} files in sounds directory',
        tag: 'FILE_STORAGE',
      );
      return files;
    } catch (e) {
      Logger().error(
        'Error listing sound files',
        tag: 'FILE_STORAGE',
        error: e,
      );
      return [];
    }
  }

  /// Clean up orphaned files (files in directory but not in database)
  static Future<void> cleanupOrphanedFiles(List<String> validFilePaths) async {
    try {
      Logger().info('Starting cleanup of orphaned files', tag: 'FILE_STORAGE');

      final allFiles = await getAllSoundFiles();
      int deletedCount = 0;

      for (final filePath in allFiles) {
        if (!validFilePaths.contains(filePath)) {
          if (await deleteFile(filePath)) {
            deletedCount++;
          }
        }
      }

      Logger().info(
        'Cleanup completed. Deleted $deletedCount orphaned files',
        tag: 'FILE_STORAGE',
      );
    } catch (e) {
      Logger().error('Error during cleanup', tag: 'FILE_STORAGE', error: e);
    }
  }
}

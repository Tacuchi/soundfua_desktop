import 'dart:io';

/// Helper class for file system operations
class FileHelper {
  /// Check if a file exists at the given path
  static bool fileExists(String path) {
    final file = File(path);
    return file.existsSync();
  }

  /// Get file size in bytes
  static int getFileSize(String path) {
    final file = File(path);
    return file.lengthSync();
  }

  /// Get file extension
  static String getFileExtension(String path) {
    return path.split('.').last.toLowerCase();
  }

  /// Check if the file is a supported audio format
  static bool isSupportedAudioFormat(String path) {
    final extension = getFileExtension(path);
    return _supportedAudioFormats.contains(extension);
  }

  /// List of supported audio formats
  static const List<String> _supportedAudioFormats = [
    'mp3',
    'wav',
    'aac',
    'ogg',
    'flac',
    'm4a',
    'wma',
  ];

  /// Get supported audio formats
  static List<String> get supportedAudioFormats => _supportedAudioFormats;
}

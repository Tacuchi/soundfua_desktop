import '../../../../../core/util/file_helper.dart';

/// Abstract interface for file system operations
abstract class SoundFileDataSource {
  bool fileExists(String path);
  bool isValidAudioFile(String path);
  int getFileSize(String path);
  String getFileExtension(String path);
}

/// Implementation of SoundFileDataSource
class SoundFileDataSourceImpl implements SoundFileDataSource {
  @override
  bool fileExists(String path) {
    return FileHelper.fileExists(path);
  }

  @override
  bool isValidAudioFile(String path) {
    return FileHelper.isSupportedAudioFormat(path);
  }

  @override
  int getFileSize(String path) {
    return FileHelper.getFileSize(path);
  }

  @override
  String getFileExtension(String path) {
    return FileHelper.getFileExtension(path);
  }
}

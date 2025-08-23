import 'dart:developer' as developer;

/// Log levels
enum LogLevel { debug, info, warning, error }

/// Centralized logging service for the application
class Logger {
  static final Logger _instance = Logger._internal();
  factory Logger() => _instance;
  Logger._internal();

  /// Log a message with specified level
  void log(
    String message, {
    LogLevel level = LogLevel.info,
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final timestamp = DateTime.now().toIso8601String();
    final tagStr = tag != null ? '[$tag] ' : '';
    final levelStr = level.name.toUpperCase().padLeft(7);
    final logMessage = '$timestamp [$levelStr] $tagStr$message';

    // Log to console/developer console
    switch (level) {
      case LogLevel.debug:
        developer.log(logMessage, name: 'DEBUG');
        break;
      case LogLevel.info:
        developer.log(logMessage, name: 'INFO');
        break;
      case LogLevel.warning:
        developer.log(logMessage, name: 'WARNING');
        break;
      case LogLevel.error:
        developer.log(
          logMessage,
          name: 'ERROR',
          error: error,
          stackTrace: stackTrace,
        );
        break;
    }

    // Also print to debug console for easier debugging
    print(logMessage);
    if (error != null) {
      print('Error: $error');
    }
    if (stackTrace != null) {
      print('StackTrace: $stackTrace');
    }
  }

  /// Debug log
  void debug(String message, {String? tag}) {
    log(message, level: LogLevel.debug, tag: tag);
  }

  /// Info log
  void info(String message, {String? tag}) {
    log(message, level: LogLevel.info, tag: tag);
  }

  /// Warning log
  void warning(String message, {String? tag}) {
    log(message, level: LogLevel.warning, tag: tag);
  }

  /// Error log
  void error(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    log(
      message,
      level: LogLevel.error,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Audio-specific logs
  void audioDebug(String message, {String? filePath}) {
    final fileInfo = filePath != null ? ' [${filePath.split('/').last}]' : '';
    debug('$message$fileInfo', tag: 'AUDIO');
  }

  void audioInfo(String message, {String? filePath}) {
    final fileInfo = filePath != null ? ' [${filePath.split('/').last}]' : '';
    info('$message$fileInfo', tag: 'AUDIO');
  }

  void audioError(
    String message, {
    String? filePath,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final fileInfo = filePath != null ? ' [${filePath.split('/').last}]' : '';
    this.error(
      '$message$fileInfo',
      tag: 'AUDIO',
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Waveform-specific logs
  void waveformDebug(String message, {String? filePath}) {
    final fileInfo = filePath != null ? ' [${filePath.split('/').last}]' : '';
    debug('$message$fileInfo', tag: 'WAVEFORM');
  }

  void waveformInfo(String message, {String? filePath}) {
    final fileInfo = filePath != null ? ' [${filePath.split('/').last}]' : '';
    info('$message$fileInfo', tag: 'WAVEFORM');
  }

  void waveformError(
    String message, {
    String? filePath,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final fileInfo = filePath != null ? ' [${filePath.split('/').last}]' : '';
    this.error(
      '$message$fileInfo',
      tag: 'WAVEFORM',
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// UI-specific logs
  void uiDebug(String message, {String? widget}) {
    final widgetInfo = widget != null ? ' [$widget]' : '';
    debug('$message$widgetInfo', tag: 'UI');
  }

  void uiError(
    String message, {
    String? widget,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final widgetInfo = widget != null ? ' [$widget]' : '';
    this.error(
      '$message$widgetInfo',
      tag: 'UI',
      error: error,
      stackTrace: stackTrace,
    );
  }
}

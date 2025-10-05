import 'package:dart_vlc/dart_vlc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/util/logger.dart';
import '../entities/audio_device.dart';

/// Service for managing audio output devices
class AudioDeviceService {
  static final AudioDeviceService _instance = AudioDeviceService._internal();
  factory AudioDeviceService() => _instance;
  AudioDeviceService._internal() {
    Logger().info('AudioDeviceService initialized', tag: 'AUDIO_DEVICE');
  }

  static const String _selectedDeviceIdKey = 'selected_audio_device_id';
  static const String _selectedDeviceNameKey = 'selected_audio_device_name';

  SharedPreferences? _prefs;
  AudioDevice? _currentDevice;

  /// Initialize the service with SharedPreferences
  Future<void> initialize(SharedPreferences prefs) async {
    _prefs = prefs;
    await _loadSavedDevice();
  }

  /// Get all available audio output devices
  List<AudioDevice> getAllDevices() {
    try {
      Logger().info('Fetching all audio devices', tag: 'AUDIO_DEVICE');

      // Get devices from dart_vlc
      final vlcDevices = Devices.all;

      Logger().info(
        'Found ${vlcDevices.length} audio devices',
        tag: 'AUDIO_DEVICE',
      );

      // Convert to AudioDevice entities
      final devices = vlcDevices.map((device) {
        final isVirtual = _isVirtualCableDevice(device.name);

        return AudioDevice(
          id: device.id,
          name: device.name,
          isVirtualCable: isVirtual,
          isDefault: false, // dart_vlc doesn't provide default device info
          isSelected: _currentDevice?.id == device.id,
        );
      }).toList();

      Logger().info(
        'Converted to ${devices.length} AudioDevice entities',
        tag: 'AUDIO_DEVICE',
      );

      return devices;
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to get audio devices',
        tag: 'AUDIO_DEVICE',
        error: e,
        stackTrace: stackTrace,
      );
      return [];
    }
  }

  /// Get only virtual audio cable devices
  List<AudioDevice> getVirtualAudioCables() {
    final allDevices = getAllDevices();
    final virtualCables = allDevices
        .where((device) => device.isVirtualCable || device.looksLikeVirtualCable)
        .toList();

    Logger().info(
      'Found ${virtualCables.length} virtual audio cables',
      tag: 'AUDIO_DEVICE',
    );

    return virtualCables;
  }

  /// Detect the best virtual device automatically
  /// Prioritizes known virtual audio cable names
  AudioDevice? detectBestVirtualDevice() {
    Logger().info(
      'Attempting to detect best virtual audio device',
      tag: 'AUDIO_DEVICE',
    );

    final virtualCables = getVirtualAudioCables();

    if (virtualCables.isEmpty) {
      Logger().warning(
        'No virtual audio cables detected',
        tag: 'AUDIO_DEVICE',
      );
      return null;
    }

    // Priority keywords for virtual cables (in order of preference)
    final priorityKeywords = [
      'cable input', // VB-CABLE Input (most common for soundboards)
      'vb-audio cable',
      'vb audio cable',
      'voicemeeter input',
      'voicemeeter aux input',
      'virtual cable',
      'vac', // Virtual Audio Cable
    ];

    // Try to find device matching priority keywords
    for (final keyword in priorityKeywords) {
      final match = virtualCables.firstWhere(
        (device) => device.name.toLowerCase().contains(keyword),
        orElse: () => virtualCables.first,
      );

      if (match.name.toLowerCase().contains(keyword)) {
        Logger().info(
          'Best virtual device detected: ${match.name}',
          tag: 'AUDIO_DEVICE',
        );
        return match;
      }
    }

    // Fallback to first virtual cable found
    final fallback = virtualCables.first;
    Logger().info(
      'Using fallback virtual device: ${fallback.name}',
      tag: 'AUDIO_DEVICE',
    );

    return fallback;
  }

  /// Save selected device to persistent storage
  Future<void> saveSelectedDevice(AudioDevice device) async {
    if (_prefs == null) {
      Logger().warning(
        'SharedPreferences not initialized',
        tag: 'AUDIO_DEVICE',
      );
      return;
    }

    try {
      await _prefs!.setString(_selectedDeviceIdKey, device.id);
      await _prefs!.setString(_selectedDeviceNameKey, device.name);

      _currentDevice = device;

      Logger().info(
        'Saved selected device: ${device.name} (${device.id})',
        tag: 'AUDIO_DEVICE',
      );
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to save selected device',
        tag: 'AUDIO_DEVICE',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Load saved device from persistent storage
  Future<AudioDevice?> loadSavedDevice() async {
    return await _loadSavedDevice();
  }

  /// Internal method to load saved device
  Future<AudioDevice?> _loadSavedDevice() async {
    if (_prefs == null) {
      Logger().debug(
        'SharedPreferences not initialized yet',
        tag: 'AUDIO_DEVICE',
      );
      return null;
    }

    try {
      final savedId = _prefs!.getString(_selectedDeviceIdKey);
      final savedName = _prefs!.getString(_selectedDeviceNameKey);

      if (savedId == null || savedName == null) {
        Logger().debug('No saved device found', tag: 'AUDIO_DEVICE');
        return null;
      }

      // Try to find the saved device in current available devices
      final allDevices = getAllDevices();
      final savedDevice = allDevices.firstWhere(
        (device) => device.id == savedId,
        orElse: () => AudioDevice(
          id: savedId,
          name: savedName,
          isVirtualCable: _isVirtualCableDevice(savedName),
          isSelected: true,
        ),
      );

      _currentDevice = savedDevice.copyWith(isSelected: true);

      Logger().info(
        'Loaded saved device: ${savedDevice.name}',
        tag: 'AUDIO_DEVICE',
      );

      return _currentDevice;
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to load saved device',
        tag: 'AUDIO_DEVICE',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// Get currently selected device
  AudioDevice? get currentDevice => _currentDevice;

  /// Clear saved device
  Future<void> clearSavedDevice() async {
    if (_prefs == null) return;

    try {
      await _prefs!.remove(_selectedDeviceIdKey);
      await _prefs!.remove(_selectedDeviceNameKey);
      _currentDevice = null;

      Logger().info('Cleared saved device', tag: 'AUDIO_DEVICE');
    } catch (e) {
      Logger().warning('Failed to clear saved device', tag: 'AUDIO_DEVICE');
    }
  }

  /// Check if device name suggests it's a virtual cable
  bool _isVirtualCableDevice(String deviceName) {
    final nameLower = deviceName.toLowerCase();
    final virtualKeywords = [
      'cable',
      'virtual',
      'vb-audio',
      'vb audio',
      'voicemeeter',
      'vac',
      'vban',
      'stereo mix',
    ];

    return virtualKeywords.any((keyword) => nameLower.contains(keyword));
  }

  /// Get recommended device message
  String getRecommendedDeviceMessage() {
    final virtualCables = getVirtualAudioCables();

    if (virtualCables.isEmpty) {
      return 'No virtual audio cables detected. Install VB-CABLE to use this app with Discord, Zoom, etc.';
    }

    final best = detectBestVirtualDevice();
    if (best != null) {
      return 'Recommended: ${best.name}';
    }

    return 'Virtual cables detected. Select one to use with Discord, Zoom, etc.';
  }

  /// Check if VB-CABLE or similar is installed
  bool hasVirtualCableInstalled() {
    return getVirtualAudioCables().isNotEmpty;
  }
}

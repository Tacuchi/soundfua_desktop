import 'dart:async';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:window_manager/window_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/util/logger.dart';
import '../../../sound_library/domain/entities/sound.dart';
import '../../../sound_library/domain/services/multi_audio_service.dart';
import '../../../settings/domain/entities/keyboard_shortcut_setting.dart';
import '../../../settings/domain/entities/audio_device.dart';
import '../../../settings/domain/services/audio_device_service.dart';

/// Service for managing quick sound overlay functionality
class QuickSoundService {
  static final QuickSoundService _instance = QuickSoundService._internal();
  factory QuickSoundService() => _instance;
  QuickSoundService._internal() {
    Logger().info('QuickSoundService initialized', tag: 'QUICK_SOUNDS');
  }

  static const String _lastSelectedIndexKey =
      'quick_sounds_last_selected_index';

  final MultiAudioService _audioService = MultiAudioService();
  final AudioDeviceService _audioDeviceService = AudioDeviceService();
  SharedPreferences? _prefs;
  bool _isOverlayVisible = false;
  HotKey? _currentHotKey;
  List<Sound> _currentSounds = [];
  int _selectedIndex = 0;
  AudioDevice? _currentDevice;

  // Stream controllers for state management
  final StreamController<bool> _visibilityController =
      StreamController<bool>.broadcast();
  final StreamController<int> _selectedIndexController =
      StreamController<int>.broadcast();
  final StreamController<List<Sound>> _soundsController =
      StreamController<List<Sound>>.broadcast();

  /// Stream for overlay visibility changes
  Stream<bool> get visibilityStream => _visibilityController.stream;

  /// Stream for selected index changes
  Stream<int> get selectedIndexStream => _selectedIndexController.stream;

  /// Stream for sounds list changes
  Stream<List<Sound>> get soundsStream => _soundsController.stream;

  /// Current overlay visibility state
  bool get isOverlayVisible => _isOverlayVisible;

  /// Current selected index
  int get selectedIndex => _selectedIndex;

  /// Current sounds list
  List<Sound> get currentSounds => List.unmodifiable(_currentSounds);

  /// Initialize the service with keyboard shortcut settings
  Future<void> initialize(KeyboardShortcutSetting shortcutSetting) async {
    try {
      Logger().info(
        'Initializing QuickSoundService with shortcut: ${shortcutSetting.quickSoundsShortcut}',
        tag: 'QUICK_SOUNDS',
      );

      // Initialize SharedPreferences if not already done
      await _initializePreferences();

      // Initialize AudioDeviceService
      if (_prefs != null) {
        await _audioDeviceService.initialize(_prefs!);
        _currentDevice = await _audioDeviceService.loadSavedDevice();

        // Apply saved device to audio service
        if (_currentDevice != null) {
          await _audioService.setDevice(_currentDevice);
          Logger().info(
            'Applied saved audio device: ${_currentDevice!.name}',
            tag: 'QUICK_SOUNDS',
          );
        }
      }

      // Load last selected index
      await _loadLastSelectedIndex();

      // Unregister previous hotkey if exists
      await _unregisterHotKey();

      // Register new hotkey
      await _registerHotKey(shortcutSetting.quickSoundsHotKey);

      Logger().info(
        'QuickSoundService initialized successfully',
        tag: 'QUICK_SOUNDS',
      );
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to initialize QuickSoundService',
        tag: 'QUICK_SOUNDS',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Initialize SharedPreferences
  Future<void> _initializePreferences() async {
    try {
      _prefs ??= await SharedPreferences.getInstance();
      Logger().debug(
        'SharedPreferences initialized for QuickSoundService',
        tag: 'QUICK_SOUNDS',
      );
    } catch (e) {
      Logger().warning(
        'Failed to initialize SharedPreferences: $e',
        tag: 'QUICK_SOUNDS',
      );
    }
  }

  /// Load the last selected index from storage
  Future<void> _loadLastSelectedIndex() async {
    try {
      if (_prefs == null) return;

      final savedIndex = _prefs!.getInt(_lastSelectedIndexKey) ?? 0;
      _selectedIndex = savedIndex;

      Logger().info(
        'Loaded last selected index: $_selectedIndex',
        tag: 'QUICK_SOUNDS',
      );
    } catch (e) {
      Logger().warning(
        'Failed to load last selected index: $e',
        tag: 'QUICK_SOUNDS',
      );
      _selectedIndex = 0; // Fallback to first item
    }
  }

  /// Save the current selected index to storage
  Future<void> _saveSelectedIndex() async {
    try {
      if (_prefs == null) return;

      await _prefs!.setInt(_lastSelectedIndexKey, _selectedIndex);

      Logger().debug(
        'Saved selected index: $_selectedIndex',
        tag: 'QUICK_SOUNDS',
      );
    } catch (e) {
      Logger().warning(
        'Failed to save selected index: $e',
        tag: 'QUICK_SOUNDS',
      );
    }
  }

  /// Register hotkey for quick sounds overlay
  Future<void> _registerHotKey(HotKey hotKey) async {
    try {
      Logger().info(
        'Attempting to register hotkey: ${hotKey.key} with modifiers: ${hotKey.modifiers}',
        tag: 'QUICK_SOUNDS',
      );

      _currentHotKey = hotKey;

      await hotKeyManager.register(
        hotKey,
        keyDownHandler: (hotKey) {
          Logger().info(
            '🔥 HOTKEY PRESSED! Key: ${hotKey.key}, Modifiers: ${hotKey.modifiers}',
            tag: 'QUICK_SOUNDS',
          );
          showOverlay();
        },
        keyUpHandler: (hotKey) {
          Logger().info(
            '🔥 HOTKEY RELEASED! Key: ${hotKey.key}, Modifiers: ${hotKey.modifiers}',
            tag: 'QUICK_SOUNDS',
          );
          hideOverlayAndPlaySelected();
        },
      );

      Logger().info('Hotkey registered successfully', tag: 'QUICK_SOUNDS');
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to register hotkey',
        tag: 'QUICK_SOUNDS',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Unregister current hotkey
  Future<void> _unregisterHotKey() async {
    if (_currentHotKey != null) {
      try {
        await hotKeyManager.unregister(_currentHotKey!);
        Logger().info('Previous hotkey unregistered', tag: 'QUICK_SOUNDS');
      } catch (e) {
        Logger().warning(
          'Failed to unregister previous hotkey: $e',
          tag: 'QUICK_SOUNDS',
        );
      }
      _currentHotKey = null;
    }
  }

  /// Show the quick sounds overlay
  Future<void> showOverlay() async {
    if (_isOverlayVisible) return;

    try {
      Logger().info('Showing quick sounds overlay', tag: 'QUICK_SOUNDS');

      // Ensure window is visible and focused for overlay to work
      await _ensureWindowVisible();

      _isOverlayVisible = true;

      // Validate that the saved index is still valid for current sounds
      if (_currentSounds.isNotEmpty &&
          (_selectedIndex < 0 || _selectedIndex >= _currentSounds.length)) {
        _selectedIndex = 0; // Reset to first item if invalid
        await _saveSelectedIndex(); // Save the corrected index
      }

      // Notify listeners
      _visibilityController.add(true);
      _selectedIndexController.add(_selectedIndex);

      Logger().info(
        'Quick sounds overlay shown successfully with index: $_selectedIndex',
        tag: 'QUICK_SOUNDS',
      );
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to show overlay',
        tag: 'QUICK_SOUNDS',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Ensure window is visible for overlay functionality
  Future<void> _ensureWindowVisible() async {
    try {
      // Check if window is minimized or hidden
      if (!await windowManager.isVisible()) {
        await windowManager.show();
      }

      // Focus the window to ensure hotkeys work
      await windowManager.focus();

      Logger().debug('Window ensured visible for overlay', tag: 'QUICK_SOUNDS');
    } catch (e) {
      Logger().warning(
        'Failed to ensure window visibility: $e',
        tag: 'QUICK_SOUNDS',
      );
    }
  }

  /// Hide the overlay without playing
  void hideOverlay() {
    _hideOverlay();
  }

  /// Hide overlay and play selected sound
  void hideOverlayAndPlaySelected() {
    if (!_isOverlayVisible) return;

    try {
      Logger().info(
        'Hiding overlay and playing selected sound at index $_selectedIndex',
        tag: 'QUICK_SOUNDS',
      );

      // Play selected sound if available
      if (_currentSounds.isNotEmpty &&
          _selectedIndex >= 0 &&
          _selectedIndex < _currentSounds.length) {
        final selectedSound = _currentSounds[_selectedIndex];
        Logger().info(
          'Playing selected sound: ${selectedSound.alias}',
          tag: 'QUICK_SOUNDS',
        );
        _audioService.playAudio(selectedSound.filePath);

        // Save the selected index for next time
        _saveSelectedIndex();
      }

      _hideOverlay();
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to hide overlay and play sound',
        tag: 'QUICK_SOUNDS',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Hide the overlay without playing
  void _hideOverlay() {
    if (!_isOverlayVisible) return;

    _isOverlayVisible = false;
    _visibilityController.add(false);

    Logger().info('Quick sounds overlay hidden', tag: 'QUICK_SOUNDS');
  }

  /// Update the sounds list
  void updateSounds(List<Sound> sounds) {
    _currentSounds = List.from(sounds);

    // Validate current index against new sounds list
    if (_currentSounds.isNotEmpty &&
        (_selectedIndex < 0 || _selectedIndex >= _currentSounds.length)) {
      _selectedIndex = 0; // Reset to first item if invalid
      _saveSelectedIndex(); // Save the corrected index
    } else if (_currentSounds.isEmpty) {
      _selectedIndex = 0; // Reset if no sounds available
    }

    _soundsController.add(_currentSounds);
    _selectedIndexController.add(_selectedIndex);

    Logger().info(
      'Updated sounds list with ${_currentSounds.length} sounds, selected index: $_selectedIndex',
      tag: 'QUICK_SOUNDS',
    );
  }

  /// Navigate to previous sound
  void navigatePrevious() {
    if (_currentSounds.isEmpty) return;

    _selectedIndex =
        (_selectedIndex - 1 + _currentSounds.length) % _currentSounds.length;
    _selectedIndexController.add(_selectedIndex);

    // Save the new index for persistence
    _saveSelectedIndex();

    Logger().debug(
      'Navigated to previous sound, index: $_selectedIndex',
      tag: 'QUICK_SOUNDS',
    );
  }

  /// Navigate to next sound
  void navigateNext() {
    if (_currentSounds.isEmpty) return;

    _selectedIndex = (_selectedIndex + 1) % _currentSounds.length;
    _selectedIndexController.add(_selectedIndex);

    // Save the new index for persistence
    _saveSelectedIndex();

    Logger().debug(
      'Navigated to next sound, index: $_selectedIndex',
      tag: 'QUICK_SOUNDS',
    );
  }

  /// Set selected index directly
  void setSelectedIndex(int index) {
    if (_currentSounds.isEmpty || index < 0 || index >= _currentSounds.length) {
      return;
    }

    _selectedIndex = index;
    _selectedIndexController.add(_selectedIndex);

    // Save the new index for persistence
    _saveSelectedIndex();

    Logger().debug(
      'Set selected index to: $_selectedIndex',
      tag: 'QUICK_SOUNDS',
    );
  }

  /// Dispose resources
  void dispose() {
    Logger().info('Disposing QuickSoundService', tag: 'QUICK_SOUNDS');

    _unregisterHotKey();
    _hideOverlay();

    _visibilityController.close();
    _selectedIndexController.close();
    _soundsController.close();

    Logger().info('QuickSoundService disposed', tag: 'QUICK_SOUNDS');
  }
}

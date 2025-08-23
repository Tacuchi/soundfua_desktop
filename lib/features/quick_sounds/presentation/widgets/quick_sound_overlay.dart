import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import '../../../../core/util/logger.dart';
import '../../../sound_library/domain/entities/sound.dart';
import '../../domain/services/quick_sound_service.dart';

/// Overlay widget for quick sound selection
class QuickSoundOverlay extends StatefulWidget {
  final List<Sound> sounds;
  final int selectedIndex;
  final QuickSoundService quickSoundService;

  const QuickSoundOverlay({
    super.key,
    required this.sounds,
    required this.selectedIndex,
    required this.quickSoundService,
  });

  @override
  State<QuickSoundOverlay> createState() => _QuickSoundOverlayState();
}

class _QuickSoundOverlayState extends State<QuickSoundOverlay> {
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      _scrollToSelected();
    });

    Logger().debug(
      'QuickSoundOverlay initialized with ${widget.sounds.length} sounds',
      tag: 'QUICK_SOUNDS_UI',
    );
  }

  @override
  void didUpdateWidget(QuickSoundOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _scrollToSelected();
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSelected() {
    if (widget.sounds.isEmpty) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        const itemHeight = 56.0;
        final targetOffset = widget.selectedIndex * itemHeight;
        final viewportHeight = _scrollController.position.viewportDimension;
        final currentOffset = _scrollController.offset;

        // Only scroll if the selected item is not visible
        if (targetOffset < currentOffset ||
            targetOffset > currentOffset + viewportHeight - itemHeight) {
          _scrollController.animateTo(
            targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  void _handlePointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent && widget.sounds.isNotEmpty) {
      Logger().debug(
        'Mouse wheel event: scrollDelta=${event.scrollDelta.dy}',
        tag: 'QUICK_SOUNDS_UI',
      );

      // Negative scroll delta means scroll up (navigate to previous)
      // Positive scroll delta means scroll down (navigate to next)
      if (event.scrollDelta.dy < 0) {
        widget.quickSoundService.navigatePrevious();
      } else if (event.scrollDelta.dy > 0) {
        widget.quickSoundService.navigateNext();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.1), // Subtle overlay background
        child: Center(
          child: Listener(
            onPointerSignal: _handlePointerSignal,
            child: Focus(
              focusNode: _focusNode,
              onKeyEvent: _handleKeyEvent,
              child: Container(
                width: 400,
                height: 500,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.surface.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withOpacity(0.2),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Column(
                      children: [
                        _buildHeader(context),
                        Expanded(
                          child: widget.sounds.isEmpty
                              ? _buildEmptyState(context)
                              : _buildSoundsList(context),
                        ),
                        _buildFooter(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.music_note,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'Seleccionar Sonido',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${widget.sounds.length}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.music_off,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'No hay sonidos disponibles',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Agrega algunos sonidos a tu biblioteca',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSoundsList(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.sounds.length,
        itemBuilder: (context, index) {
          final sound = widget.sounds[index];
          final isSelected = index == widget.selectedIndex;

          return Container(
            height: 56,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: isSelected
                  ? Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1,
                    )
                  : null,
            ),
            child: ListTile(
              dense: true,
              leading: CircleAvatar(
                radius: 16,
                backgroundColor: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surfaceVariant,
                child: Icon(
                  Icons.audio_file,
                  size: 16,
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              title: Text(
                sound.alias,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                _formatDate(sound.addedOn),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.7)
                      : Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              trailing: isSelected
                  ? Icon(
                      Icons.keyboard_arrow_right,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
              onTap: () {
                widget.quickSoundService.setSelectedIndex(index);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildKeyHint(context, '↑↓', 'Navegar'),
          const SizedBox(width: 16),
          _buildKeyHint(context, '🖱️', 'Scroll'),
          const SizedBox(width: 16),
          _buildKeyHint(context, 'Esc', 'Cancelar'),
        ],
      ),
    );
  }

  Widget _buildKeyHint(BuildContext context, String key, String action) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
            ),
          ),
          child: Text(
            key,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: key == '🖱️' ? null : 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(action, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Hoy ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Ayer ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} días atrás';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    Logger().debug('Key event: ${event.logicalKey}', tag: 'QUICK_SOUNDS_UI');

    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowUp:
        widget.quickSoundService.navigatePrevious();
        return KeyEventResult.handled;

      case LogicalKeyboardKey.arrowDown:
        widget.quickSoundService.navigateNext();
        return KeyEventResult.handled;

      case LogicalKeyboardKey.enter:
        widget.quickSoundService.hideOverlayAndPlaySelected();
        return KeyEventResult.handled;

      case LogicalKeyboardKey.escape:
        widget.quickSoundService.hideOverlay();
        return KeyEventResult.handled;

      default:
        return KeyEventResult.ignored;
    }
  }
}

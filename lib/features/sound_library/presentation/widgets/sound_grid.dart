import 'package:flutter/material.dart';
import '../../domain/entities/sound.dart';
import 'sound_tile.dart';

class SoundGrid extends StatelessWidget {
  final List<Sound> sounds;

  const SoundGrid({super.key, required this.sounds});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: sounds.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: SizedBox(
              height: 120, // Altura fija para cada elemento
              child: SoundTile(sound: sounds[index]),
            ),
          );
        },
      ),
    );
  }
}

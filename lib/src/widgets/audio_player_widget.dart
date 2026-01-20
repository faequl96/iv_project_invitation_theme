import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/core/core_static.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';

class AudioPlayerWidget extends StatelessWidget {
  const AudioPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: CoreStatic.player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;

        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering ||
            processingState == null) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: W.x2s,
              height: W.x2s,
              child: const CircularProgressIndicator(color: Colors.white),
            ),
          );
        } else if (playing != true) {
          return GestureDetector(
            onTap: CoreStatic.player.play,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color.fromARGB(255, 255, 250, 230),
                border: Border.all(width: 3, color: Colors.grey),
              ),
              child: Icon(Icons.play_arrow, size: W.x2s),
            ),
          );
        } else if (processingState != ProcessingState.completed) {
          return GestureDetector(
            onTap: CoreStatic.player.pause,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color.fromARGB(255, 255, 250, 230),
                border: Border.all(width: 3, color: Colors.grey),
              ),
              child: Icon(Icons.pause, size: W.x2s),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () async {
              CoreStatic.player.seek(Duration.zero);
              CoreStatic.player.pause();
              CoreStatic.player.play();
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color.fromARGB(255, 255, 250, 230),
                border: Border.all(width: 3, color: Colors.grey),
              ),
              child: Icon(Icons.replay, size: W.x2s),
            ),
          );
        }
      },
    );
  }
}

import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/core/core_static.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({super.key});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: CoreStatic.player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;

        final isLoading =
            processingState == ProcessingState.loading || processingState == ProcessingState.buffering || processingState == null;

        if (isLoading) {
          return Padding(
            padding: EdgeInsets.all(W.x4s),
            child: SizedBox(
              width: W.xs,
              height: W.xs,
              child: const CircularProgressIndicator(color: Colors.white),
            ),
          );
        }

        void Function()? onTap;
        IconData? icon;

        if (playing != true) {
          onTap = CoreStatic.player.play;
          icon = Icons.play_arrow;
          _controller.stop();
        } else if (processingState != ProcessingState.completed) {
          onTap = CoreStatic.player.pause;
          icon = Icons.pause;
          _controller.repeat();
        } else {
          onTap = () async {
            CoreStatic.player.seek(Duration.zero);
            CoreStatic.player.pause();
            CoreStatic.player.play();
          };
          icon = Icons.replay;
          _controller.reset();
        }

        return GestureDetector(
          onTap: onTap,
          child: Stack(
            alignment: Alignment.center,
            children: [
              RotationTransition(
                turns: _controller,
                child: Container(
                  width: W.xs + W.x4s,
                  height: W.xs + W.x4s,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(
                      colors: [Colors.transparent, Colors.grey.shade700, Colors.transparent],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(W.x14s),
                decoration: BoxDecoration(shape: BoxShape.circle, color: ColorConverter.lighten(Colors.grey.shade700, 90)),
                child: Icon(icon, size: W.xs, color: ColorConverter.darken(Colors.grey.shade700)),
              ),
            ],
          ),
        );
      },
    );
  }
}

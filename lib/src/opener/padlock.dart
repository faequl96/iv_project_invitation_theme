import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';
// import 'package:iv_project_invitation_theme/src/core/utils/audio.dart';
// import 'package:just_audio/just_audio.dart';

class Padlock extends StatelessWidget {
  const Padlock({super.key, required this.onOpened});

  final Function() onOpened;

  @override
  Widget build(BuildContext context) {
    return GeneralEffectsButton(
      onTap: () async {
        onOpened();
        await Future.delayed(const Duration(seconds: 2));
        // Audio.player.play();
      },
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      borderRadius: BorderRadius.circular(30),
      color: Colors.grey.shade900.withValues(alpha: .2),
      border: Border.all(width: .5, color: Colors.grey.shade500),
      child: Center(
        child: Text(
          'Buka Undangan',
          style: TextStyle(color: Colors.grey.shade300, fontSize: FontScale.sm, fontWeight: FontWeight.bold),
        ),
      ),
    );
    // return StreamBuilder<PlayerState>(
    //   stream: Audio.player.playerStateStream,
    //   builder: (context, snapshot) {
    //     final playerState = snapshot.data;
    //     final processingState = playerState?.processingState;
    //     final playing = playerState?.playing;

    //     if (processingState == ProcessingState.loading ||
    //         processingState == ProcessingState.buffering ||
    //         processingState == null) {
    //       return const SizedBox.shrink();
    //     } else if (playing != true) {
    //       return GestureDetector(
    //         onTap: () async {
    //           onOpened();
    //           await Future.delayed(const Duration(seconds: 2));
    //           Audio.player.play();
    //         },
    //         child: ClipRRect(
    //           child: BackdropFilter(
    //             filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
    //             child: SizedBox(
    //               width: 160,
    //               height: 50,
    //               child: DecoratedBox(
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(10),
    //                   gradient: const LinearGradient(
    //                     colors: [Color.fromARGB(200, 255, 212, 102), Color.fromARGB(240, 255, 198, 192)],
    //                   ),
    //                 ),
    //                 child: const Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Text(
    //                       'Buka Undangan',
    //                       style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       );
    //     } else if (processingState != ProcessingState.completed) {
    //       return const SizedBox.shrink();
    //     } else {
    //       return const SizedBox.shrink();
    //     }
    //   },
    // );
  }
}

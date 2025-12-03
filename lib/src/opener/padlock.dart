import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';
// import 'package:iv_project_invitation_theme/src/core/utils/audio.dart';
// import 'package:just_audio/just_audio.dart';

class Padlock extends StatelessWidget {
  const Padlock({super.key, required this.onOpened});

  final Function() onOpened;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return GeneralEffectsButton(
      onTap: () async {
        onOpened();
        await Future.delayed(const Duration(seconds: 2));
        // Audio.player.play();
      },
      height: W.lg + H.x10s,
      width: W.x12l,
      borderRadius: .circular(30),
      color: Colors.grey.shade900.withValues(alpha: .2),
      border: .all(width: .5, color: Colors.grey.shade500),
      child: Stack(
        alignment: .center,
        children: [
          GlassEffectBox(
            height: W.lg + H.x10s,
            width: W.x12l,
            borderRadius: 40,
            color: Colors.grey.shade200.withValues(alpha: .5),
          ),
          Text(
            langCode == 'en' ? 'Open Invitation' : 'Buka Undangan',
            style: AppFonts.inter(color: Colors.grey.shade300, fontSize: FontSize.sm, fontWeight: .w600),
          ),
        ],
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
    //                   borderRadius: .circular(10),
    //                   gradient: const LinearGradient(
    //                     colors: [Color.fromARGB(200, 255, 212, 102), Color.fromARGB(240, 255, 198, 192)],
    //                   ),
    //                 ),
    //                 child: const Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Text(
    //                       'Buka Undangan',
    //                       style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: .bold),
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

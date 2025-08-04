import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';
import 'package:iv_project_invitation_theme/src/widgets/animated_inviter.dart';
import 'package:iv_project_invitation_theme/src/widgets/animated_photo_sequence.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';

class ElegantBlackAndWhiteGlassSecondPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CoreCubit, CoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          // Positioned(
          //   bottom: 0,
          //   child: SizedBox(
          //     height: ScreenUtil.size.height / 1.8,
          //     width: ScreenUtil.size.width,
          //     child: DecoratedBox(
          //       decoration: BoxDecoration(
          //         gradient: LinearGradient(
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //           colors: [Colors.transparent, Colors.grey.shade900],
          //           stops: const [.2, .8],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Align(
            alignment: const Alignment(0, -.94),
            child: FadeAndSlideTransition(
              slideFromOffset: 1,
              slideFrom: SlideFrom.top,
              delayBeforeStart: Duration.zero,
              animationSpeed: const Duration(milliseconds: 300),
              child: Text(
                'Kami yang Mengundang',
                style: TextStyle(color: Colors.grey.shade900, fontSize: FontScale.x3l, fontWeight: FontWeight.w900),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: ScreenUtil.size.height,
              width: ScreenUtil.size.width,
              child: Padding(
                padding: EdgeInsets.only(top: SizeScale.heightX7l, left: 16, right: 16, bottom: 76),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: ScreenUtil.size.height,
              width: ScreenUtil.size.width,
              child: Padding(
                padding: EdgeInsets.only(top: SizeScale.heightX7l, left: 16, right: 16, bottom: 76),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: .5, color: Colors.grey.shade500),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Align(alignment: Alignment(0, 0), child: AnimatedPhotoSequence.left()),
                        Align(alignment: Alignment(0, 0), child: AnimatedPhotoSequence.right()),
                        Align(
                          alignment: Alignment(0, 0),
                          child: AnimatedInviter.left(children: [Text('Milea Pratiwi')]),
                        ),
                        Align(
                          alignment: Alignment(0, 0),
                          child: AnimatedInviter.right(children: [Text('Dilan Pratama')]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: ScreenUtil.size.height,
              width: ScreenUtil.size.width,
              child: Padding(
                padding: EdgeInsets.only(top: SizeScale.heightX7l, left: 16, right: 16, bottom: 76),
                child: BlocSelector<CoreCubit, CoreState, int>(
                  selector: (state) => state.animationTrigger,
                  builder: (_, animationTrigger) {
                    if (animationTrigger == 0) return const SizedBox.shrink();
                    return GlassEffectBox(
                      width: ScreenUtil.size.width - 32,
                      height: ScreenUtil.size.height - (76 + SizeScale.heightX7l),
                      borderRadius: 20,
                      sliderWidth: 90,
                      color: Colors.grey.shade100.withValues(alpha: .5),
                      animationEnd: 1.12,
                      animationSpeed: const Duration(milliseconds: 600),
                      animationInterval: const Duration(seconds: 3),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

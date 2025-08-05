import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/app_fonts.dart';
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
          //     height: ScreenUtil.size.height / 1.4,
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
            alignment: const Alignment(0, -.93),
            child: FadeAndSlideTransition(
              slideFromOffset: 1,
              slideFrom: SlideFrom.top,
              delayBeforeStart: Duration.zero,
              animationSpeed: const Duration(milliseconds: 300),
              child: Text(
                'Kami Yang Mengundang',
                style: AppFonts.inter(color: Colors.grey.shade900, fontSize: FontScale.x2l, fontWeight: FontWeight.w800),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: ScreenUtil.size.height,
              width: ScreenUtil.size.width,
              child: Padding(
                padding: EdgeInsets.only(
                  top: SizeScale.heightX7l,
                  left: SizeScale.widthX6s,
                  right: SizeScale.widthX6s,
                  bottom: 76,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .7),
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
                padding: EdgeInsets.only(
                  top: SizeScale.heightX7l,
                  left: SizeScale.widthX6s,
                  right: SizeScale.widthX6s,
                  bottom: 76,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: .5, color: Colors.grey.shade500),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Align(alignment: Alignment(0, 0), child: AnimatedPhotoSequence.left()),
                        const Align(alignment: Alignment(0, 0), child: AnimatedPhotoSequence.right()),
                        Align(
                          alignment: const Alignment(0, 0),
                          child: AnimatedInviter.left(
                            children: [
                              Text(
                                'Rahma Nur Istiqomah, M.Biomed.',
                                style: AppFonts.pacifico(fontSize: FontScale.x2l, height: 1.25),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Putri dari',
                                style: AppFonts.inter(fontSize: FontScale.xs + .5, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 2),
                              Text.rich(
                                const TextSpan(
                                  children: [
                                    TextSpan(text: 'Bapak '),
                                    TextSpan(
                                      text: 'Bagyo Trisno Ngulandoro, S.T.',
                                      style: TextStyle(fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                style: AppFonts.inter(fontSize: FontScale.xs + .5, fontStyle: FontStyle.italic, height: 1.2),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'dan',
                                style: AppFonts.inter(fontSize: FontScale.xs + .5, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 2),
                              Text.rich(
                                const TextSpan(
                                  children: [
                                    TextSpan(text: 'Ibu '),
                                    TextSpan(
                                      text: 'Peni Lestari, S.E.',
                                      style: TextStyle(fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                style: AppFonts.inter(fontSize: FontScale.xs + .5, fontStyle: FontStyle.italic, height: 1.2),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0, 0),
                          child: AnimatedInviter.right(
                            children: [
                              Text(
                                'Faiq Ulul Fahmi, S.Pd.',
                                style: AppFonts.pacifico(fontSize: FontScale.x2l, height: 1.25),
                                textAlign: TextAlign.end,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Putra dari',
                                style: AppFonts.inter(fontSize: FontScale.xs + .5, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 2),
                              Text.rich(
                                const TextSpan(
                                  children: [
                                    TextSpan(text: 'Bapak '),
                                    TextSpan(
                                      text: 'Syamsuddin, S.Pd.',
                                      style: TextStyle(fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                style: AppFonts.inter(fontSize: FontScale.xs + .5, fontStyle: FontStyle.italic, height: 1.2),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'dan',
                                style: AppFonts.inter(fontSize: FontScale.xs + .5, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 2),
                              Text.rich(
                                const TextSpan(
                                  children: [
                                    TextSpan(text: 'Ibu '),
                                    TextSpan(
                                      text: 'Sa\'idah',
                                      style: TextStyle(fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                style: AppFonts.inter(fontSize: FontScale.xs + .5, fontStyle: FontStyle.italic, height: 1.2),
                              ),
                            ],
                          ),
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
                padding: EdgeInsets.only(
                  top: SizeScale.heightX7l,
                  left: SizeScale.widthX6s,
                  right: SizeScale.widthX6s,
                  bottom: 76,
                ),
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
                      animationEnd: 1.14,
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

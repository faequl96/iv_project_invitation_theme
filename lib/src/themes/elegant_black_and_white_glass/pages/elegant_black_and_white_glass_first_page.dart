import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/app_fonts.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';

class ElegantBlackAndWhiteGlassFirstPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CoreCubit, CoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          Positioned(
            top: 0,
            child: SizedBox(
              height: ScreenUtil.size.height / 1.4,
              width: ScreenUtil.size.width,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                    stops: [.1, .8],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, -.93),
            child: FadeAndSlideTransition(
              slideFromOffset: 1,
              slideFrom: SlideFrom.top,
              delayBeforeStart: Duration.zero,
              animationSpeed: const Duration(milliseconds: 300),
              child: Text(
                'Maksud Dan Tujuan',
                style: AppFonts.inter(color: Colors.grey.shade200, fontSize: FontScale.x3l, fontWeight: FontWeight.w800),
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
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black.withValues(alpha: .4), Colors.black.withValues(alpha: .5)],
                          stops: const [0, 1],
                        ),
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
                  child: ClipRect(
                    child: Stack(
                      children: [
                        Align(
                          alignment: const Alignment(0, -.75),
                          child: FadeAndSlideTransition(
                            slideFromOffset: .4,
                            slideFrom: SlideFrom.left,
                            delayBeforeStart: const Duration(milliseconds: 600),
                            child: Text(
                              'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ',
                              style: GoogleFonts.arefRuqaa(color: Colors.grey.shade100, fontSize: FontScale.x7l),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0, -.3),
                          child: FadeAndSlideTransition(
                            slideFromOffset: .4,
                            slideFrom: SlideFrom.right,
                            delayBeforeStart: const Duration(milliseconds: 600),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '"Dan di antara tanda-tanda (kebesaran)-Nya adalah Dia menciptakan pasangan-pasangan untukmu dari jenismu sendiri, agar kamu cenderung dan merasa tenteram kepadanya".',
                                    style: AppFonts.inter(
                                      color: Colors.grey.shade100,
                                      fontSize: FontScale.md,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '(Ar-Ruum Ayat 21)',
                                    style: AppFonts.inter(
                                      color: Colors.grey.shade100,
                                      fontSize: FontScale.lg,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0, .6),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FadeAndSlideTransition(
                                  slideFromOffset: .4,
                                  slideFrom: SlideFrom.left,
                                  delayBeforeStart: const Duration(milliseconds: 600),
                                  child: Text(
                                    'Assalamu\'alaikum Wr. Wb.',
                                    style: AppFonts.inter(
                                      color: Colors.grey.shade100,
                                      fontSize: FontScale.x2l,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                SizedBox(height: SizeScale.heightX3s),
                                FadeAndSlideTransition(
                                  slideFromOffset: .4,
                                  slideFrom: SlideFrom.right,
                                  delayBeforeStart: const Duration(milliseconds: 600),
                                  child: Text(
                                    'Dengan memohon rahmat dan ridho Allah Subhanahu Wa Ta\'ala. Kami mengundang Bapak/Ibu/Saudara/I, untuk menghadiri resepsi pernikahan kami.',
                                    style: AppFonts.inter(
                                      color: Colors.grey.shade100,
                                      fontSize: FontScale.md,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
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
                      color: Colors.grey.shade300.withValues(alpha: .3),
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

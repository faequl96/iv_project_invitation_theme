import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            height: ScreenUtil.size.height / 1.4,
            width: ScreenUtil.size.width,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.grey.shade900, Colors.transparent],
                  stops: const [.2, .8],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: FadeAndSlideTransition(
              slideFromOffset: .5,
              slideFrom: SlideFrom.top,
              child: SizedBox(
                height: SizeScale.heightX6l,
                width: ScreenUtil.size.width,
                child: Center(
                  child: Text(
                    'Maksud Dan Tujuan',
                    style: AppFonts.inter(color: Colors.grey.shade200, fontSize: FontScale.x3l, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: ScreenUtil.size.height,
            width: ScreenUtil.size.width,
            child: Padding(
              padding: EdgeInsets.only(top: SizeScale.heightX6l, left: SizeScale.widthX6s, right: SizeScale.widthX6s, bottom: 76),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      // color: Colors.white.withValues(alpha: .1),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black.withValues(alpha: .6), Colors.black.withValues(alpha: .6)],
                        stops: const [0, 1],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: ScreenUtil.size.height,
            width: ScreenUtil.size.width,
            child: Padding(
              padding: EdgeInsets.only(top: SizeScale.heightX6l, left: SizeScale.widthX6s, right: SizeScale.widthX6s, bottom: 76),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: .5, color: Colors.grey.shade500),
                ),
                child: ClipRect(
                  child: Column(
                    children: [
                      // SizedBox(height: SizeScale.heightX2l),
                      const Spacer(),
                      FadeAndSlideTransition(
                        slideFromOffset: .5,
                        slideFrom: SlideFrom.top,
                        delayBeforeStart: const Duration(milliseconds: 500),
                        child: Text(
                          'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ',
                          style: AppFonts.arefRuqaa(color: Colors.grey.shade100, fontSize: FontScale.x7l),
                        ),
                      ),
                      // SizedBox(height: SizeScale.heightXs),
                      const Spacer(),
                      FadeAndSlideTransition(
                        slideFromOffset: .4,
                        slideFrom: SlideFrom.left,
                        delayBeforeStart: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: SizeScale.widthX6s),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(width: .5, color: Colors.grey.shade500),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withValues(alpha: .05),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: SizeScale.heightMd, left: 20, right: 20, bottom: SizeScale.heightSm),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FadeAndSlideTransition(
                                    slideFromOffset: .3,
                                    slideFrom: SlideFrom.top,
                                    delayBeforeStart: const Duration(milliseconds: 1000),
                                    child: Text(
                                      '"Dan di antara tanda-tanda (kebesaran)-Nya adalah Dia menciptakan pasangan-pasangan untukmu dari jenismu sendiri, agar kamu cenderung dan merasa tenteram kepadanya".',
                                      style: AppFonts.inter(
                                        color: Colors.grey.shade100,
                                        fontSize: FontScale.md,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(height: SizeScale.heightX6s),
                                  FadeAndSlideTransition(
                                    slideFromOffset: 1,
                                    slideFrom: SlideFrom.bottom,
                                    delayBeforeStart: const Duration(milliseconds: 1000),
                                    child: Text(
                                      '(Ar-Ruum Ayat 21)',
                                      style: AppFonts.inter(
                                        color: Colors.grey.shade100,
                                        fontSize: FontScale.lg,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: SizeScale.heightX4s),
                      FadeAndSlideTransition(
                        slideFromOffset: .4,
                        slideFrom: SlideFrom.right,
                        delayBeforeStart: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: SizeScale.widthX6s),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(width: .5, color: Colors.grey.shade500),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withValues(alpha: .05),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: SizeScale.heightXs, left: 20, right: 20, bottom: SizeScale.heightSm),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FadeAndSlideTransition(
                                    slideFromOffset: 1,
                                    slideFrom: SlideFrom.top,
                                    delayBeforeStart: const Duration(milliseconds: 1000),
                                    child: Text(
                                      'Assalamu\'alaikum Wr. Wb.',
                                      style: AppFonts.inter(
                                        color: Colors.grey.shade100,
                                        fontSize: FontScale.x2l,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: SizeScale.heightX6s),
                                  FadeAndSlideTransition(
                                    slideFromOffset: .4,
                                    slideFrom: SlideFrom.bottom,
                                    delayBeforeStart: const Duration(milliseconds: 1000),
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
                        ),
                      ),
                      // SizedBox(height: SizeScale.heightXs),
                      const Spacer(),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: ScreenUtil.size.height,
            width: ScreenUtil.size.width,
            child: Padding(
              padding: EdgeInsets.only(top: SizeScale.heightX6l, left: SizeScale.widthX6s, right: SizeScale.widthX6s, bottom: 76),
              child: GlassEffectBox(
                width: ScreenUtil.size.width - 32,
                height: ScreenUtil.size.height - (76 + SizeScale.heightX6l),
                borderRadius: 20,
                sliderWidth: 90,
                color: Colors.grey.shade300.withValues(alpha: .3),
                animationSpeed: const Duration(milliseconds: 600),
                animationInterval: const Duration(seconds: 3),
                delayBeforeStart: const Duration(milliseconds: 1500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

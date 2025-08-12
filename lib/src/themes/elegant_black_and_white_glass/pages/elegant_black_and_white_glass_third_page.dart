import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/app_fonts.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';
import 'package:iv_project_invitation_theme/src/widgets/countdown_timers.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';

class ElegantBlackAndWhiteGlassThirdPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CoreCubit, CoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: ScreenUtil.size.height / 1.4,
              width: ScreenUtil.size.width,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.grey.shade900],
                    stops: const [.1, .8],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: FadeAndSlideTransition(
              slideFromOffset: .5,
              slideFrom: SlideFrom.top,
              animationSpeed: const Duration(milliseconds: 300),
              child: SizedBox(
                height: SizeScale.heightX6l,
                width: ScreenUtil.size.width,
                child: Center(
                  child: Text(
                    'Acara Pernikahan',
                    style: AppFonts.inter(color: Colors.grey.shade900, fontSize: FontScale.x3l, fontWeight: FontWeight.w700),
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
                  top: SizeScale.heightX6l,
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
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: ScreenUtil.size.height,
              width: ScreenUtil.size.width,
              child: Padding(
                padding: EdgeInsets.only(
                  top: SizeScale.heightX6l,
                  left: SizeScale.widthX6s,
                  right: SizeScale.widthX6s,
                  bottom: 76,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: .5, color: Colors.grey.shade500),
                  ),
                  child: ClipRect(
                    child: Column(
                      children: [
                        const Spacer(),
                        SizedBox(height: SizeScale.heightX3l),
                        FadeAndSlideTransition(
                          slideFromOffset: .0,
                          slideFrom: SlideFrom.left,
                          delayBeforeStart: const Duration(milliseconds: 800),
                          child: Text(
                            'Dilaksanakan pada :',
                            style: AppFonts.inter(
                              color: Colors.grey.shade100,
                              fontSize: FontScale.xl,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        SizedBox(height: SizeScale.heightSm),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FadeAndSlideTransition(
                              slideFromOffset: .0,
                              slideFrom: SlideFrom.top,
                              delayBeforeStart: const Duration(milliseconds: 1000),
                              child: Icon(Icons.date_range_rounded, size: 32, color: Colors.grey.shade100),
                            ),
                            const SizedBox(height: 4),
                            FadeAndSlideTransition(
                              slideFromOffset: .8,
                              slideFrom: SlideFrom.bottom,
                              animationSpeed: const Duration(milliseconds: 300),
                              delayBeforeStart: const Duration(milliseconds: 1200),
                              child: Text(
                                'Minggu, 17 Agustus 2025',
                                style: AppFonts.inter(
                                  color: Colors.grey.shade100,
                                  fontSize: FontScale.xl,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          height: .5,
                          width: SizeScale.widthX18l,
                          child: ColoredBox(color: Colors.grey.shade100),
                        ),
                        const Spacer(),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FadeAndSlideTransition(
                              slideFromOffset: .0,
                              slideFrom: SlideFrom.top,
                              delayBeforeStart: const Duration(milliseconds: 1000),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.volunteer_activism, color: Colors.grey.shade100),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Akad Nikah',
                                    style: AppFonts.inter(
                                      color: Colors.grey.shade100,
                                      fontSize: FontScale.x2l,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(Icons.menu_book, color: Colors.grey.shade100),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            FadeAndSlideTransition(
                              slideFromOffset: .8,
                              slideFrom: SlideFrom.bottom,
                              animationSpeed: const Duration(milliseconds: 300),
                              delayBeforeStart: const Duration(milliseconds: 1200),
                              child: Text(
                                'Pukul 08.00 WIB - Pukul 10.00 WIB',
                                style: AppFonts.inter(
                                  color: Colors.grey.shade100,
                                  fontSize: FontScale.md,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          height: .5,
                          width: SizeScale.widthX18l,
                          child: ColoredBox(color: Colors.grey.shade100),
                        ),
                        const Spacer(),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FadeAndSlideTransition(
                              slideFromOffset: .0,
                              slideFrom: SlideFrom.top,
                              delayBeforeStart: const Duration(milliseconds: 1000),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.celebration, color: Colors.grey.shade100),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Resepsi',
                                    style: AppFonts.inter(
                                      color: Colors.grey.shade100,
                                      fontSize: FontScale.x2l,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(Icons.restaurant, color: Colors.grey.shade100),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            FadeAndSlideTransition(
                              slideFromOffset: .8,
                              slideFrom: SlideFrom.bottom,
                              animationSpeed: const Duration(milliseconds: 300),
                              delayBeforeStart: const Duration(milliseconds: 1200),
                              child: Text(
                                'Pukul 11.00 WIB - Pukul 13.00 WIB',
                                style: AppFonts.inter(
                                  color: Colors.grey.shade100,
                                  fontSize: FontScale.md,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          height: .5,
                          width: SizeScale.widthX18l,
                          child: ColoredBox(color: Colors.grey.shade100),
                        ),
                        const Spacer(),
                        SizedBox(height: SizeScale.heightX4s),
                        SizedBox(
                          height: SizeScale.widthX3l,
                          child: CountdownTimers(time: DateTime(2025, 9, 15, 9, 30)),
                        ),
                        SizedBox(height: SizeScale.heightX3s),
                        const Spacer(),
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
                  top: SizeScale.heightX6l,
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
                      height: ScreenUtil.size.height - (76 + SizeScale.heightX6l),
                      borderRadius: 20,
                      sliderWidth: 90,
                      color: Colors.grey.shade300.withValues(alpha: .3),
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

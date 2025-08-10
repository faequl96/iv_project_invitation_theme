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
import 'package:iv_project_invitation_theme/src/widgets/maps.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class ElegantBlackAndWhiteGlassFourthPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassFourthPage({super.key});

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
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.grey.shade900, Colors.transparent],
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
                    'Lokasi Acara',
                    style: AppFonts.inter(color: Colors.grey.shade200, fontSize: FontScale.x3l, fontWeight: FontWeight.w700),
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
                        color: Colors.white.withValues(alpha: .8),
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
                    child: Stack(
                      children: [
                        Align(
                          alignment: const Alignment(0, -.9),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FadeAndSlideTransition(
                                slideFromOffset: .0,
                                slideFrom: SlideFrom.top,
                                delayBeforeStart: const Duration(milliseconds: 1000),
                                child: Icon(Icons.location_pin, size: 32, color: Colors.grey.shade900),
                              ),
                              const SizedBox(height: 4),
                              FadeAndSlideTransition(
                                slideFromOffset: .8,
                                slideFrom: SlideFrom.bottom,
                                animationSpeed: const Duration(milliseconds: 300),
                                delayBeforeStart: const Duration(milliseconds: 1200),
                                child: Text(
                                  'Masjid Raya Bani Umar',
                                  style: AppFonts.inter(
                                    color: Colors.grey.shade900,
                                    fontSize: FontScale.xl,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              FadeAndSlideTransition(
                                slideFromOffset: .8,
                                slideFrom: SlideFrom.bottom,
                                animationSpeed: const Duration(milliseconds: 300),
                                delayBeforeStart: const Duration(milliseconds: 1200),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    'Jl. Graha Raya Bintaro Kv. GK 4 No. 2-4, Pondok Aren, Tangerang Selatan',
                                    style: AppFonts.inter(
                                      color: Colors.grey.shade900,
                                      fontSize: FontScale.xs,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment(0, 1.4 - SizeScale.heightX16s),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Maps(),
                              SizedBox(height: SizeScale.heightX3s),
                              GeneralEffectsButton(
                                onTap: () {},
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                height: SizeScale.widthLg + SizeScale.heightX10s,
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.black.withValues(alpha: .6),
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Text(
                                      'Dapatkan Petunjuk Arah',
                                      style: AppFonts.inter(
                                        color: Colors.grey.shade100,
                                        fontSize: FontScale.md,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
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
                      color: Colors.grey.shade50.withValues(alpha: .5),
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

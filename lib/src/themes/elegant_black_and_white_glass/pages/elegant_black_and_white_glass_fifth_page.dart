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
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class ElegantBlackAndWhiteGlassFifthPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassFifthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CoreCubit, CoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          Positioned(
            top: 0,
            child: FadeAndSlideTransition(
              slideFromOffset: .5,
              slideFrom: SlideFrom.top,
              child: SizedBox(
                height: SizeScale.heightX6l,
                width: ScreenUtil.size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo_library_rounded, size: SizeScale.widthXs, color: Colors.grey.shade900),
                    const SizedBox(width: 10),
                    Text(
                      'Galeri Kami',
                      style: AppFonts.inter(color: Colors.grey.shade900, fontSize: FontScale.x3l, fontWeight: FontWeight.w700),
                    ),
                  ],
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
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black.withValues(alpha: .6), Colors.black.withValues(alpha: .5)],
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: SizeScale.heightX2s),
                      Row(
                        children: [
                          SizedBox(width: SizeScale.widthX4s),
                          Expanded(
                            flex: 5,
                            child: FadeAndSlideTransition(
                              slideFrom: SlideFrom.left,
                              slideFromOffset: .3,
                              delayBeforeStart: const Duration(milliseconds: 500),
                              child: SizedBox(
                                height: SizeScale.widthX11l + 4,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: SizeScale.widthX7s),
                          SizedBox(
                            height: SizeScale.widthX11l + 4,
                            width: .5,
                            child: ColoredBox(color: Colors.grey.shade500),
                          ),
                          SizedBox(width: SizeScale.widthX7s),
                          Expanded(
                            flex: 3,
                            child: FadeAndSlideTransition(
                              slideFrom: SlideFrom.right,
                              slideFromOffset: .3,
                              delayBeforeStart: const Duration(milliseconds: 1000),
                              child: SizedBox(
                                height: SizeScale.widthX11l + 4,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: SizeScale.widthX4s),
                        ],
                      ),
                      SizedBox(height: SizeScale.widthX7s),
                      Row(
                        children: [
                          SizedBox(width: SizeScale.widthX4s),
                          Expanded(
                            child: SizedBox(height: .5, child: ColoredBox(color: Colors.grey.shade500)),
                          ),
                          SizedBox(width: SizeScale.widthX4s),
                        ],
                      ),
                      SizedBox(height: SizeScale.widthX7s),
                      Row(
                        children: [
                          SizedBox(width: SizeScale.widthX4s),
                          Expanded(
                            flex: 3,
                            child: FadeAndSlideTransition(
                              slideFrom: SlideFrom.right,
                              slideFromOffset: .3,
                              delayBeforeStart: const Duration(milliseconds: 1000),
                              child: SizedBox(
                                height: SizeScale.widthX11l + 4,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: SizeScale.widthX7s),
                          SizedBox(
                            height: SizeScale.widthX11l + 4,
                            width: .5,
                            child: ColoredBox(color: Colors.grey.shade500),
                          ),
                          SizedBox(width: SizeScale.widthX7s),
                          Expanded(
                            flex: 5,
                            child: FadeAndSlideTransition(
                              slideFrom: SlideFrom.left,
                              slideFromOffset: .3,
                              delayBeforeStart: const Duration(milliseconds: 500),
                              child: SizedBox(
                                height: SizeScale.widthX11l + 4,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: SizeScale.widthX4s),
                        ],
                      ),
                      SizedBox(height: SizeScale.widthX7s),
                      Row(
                        children: [
                          SizedBox(width: SizeScale.widthX4s),
                          Expanded(
                            child: SizedBox(height: .5, child: ColoredBox(color: Colors.grey.shade500)),
                          ),
                          SizedBox(width: SizeScale.widthX4s),
                        ],
                      ),
                      SizedBox(height: SizeScale.widthX7s),
                      Row(
                        children: [
                          SizedBox(width: SizeScale.widthX4s),
                          Expanded(
                            child: FadeAndSlideTransition(
                              slideFrom: SlideFrom.bottom,
                              slideFromOffset: .3,
                              delayBeforeStart: const Duration(milliseconds: 1500),
                              child: SizedBox(
                                height: SizeScale.widthX9l + 8,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: SizeScale.widthX7s),
                          SizedBox(
                            height: SizeScale.widthX9l + 8,
                            width: .5,
                            child: ColoredBox(color: Colors.grey.shade500),
                          ),
                          SizedBox(width: SizeScale.widthX7s),
                          Expanded(
                            child: FadeAndSlideTransition(
                              slideFrom: SlideFrom.bottom,
                              slideFromOffset: .3,
                              delayBeforeStart: const Duration(milliseconds: 1500),
                              child: SizedBox(
                                height: SizeScale.widthX9l + 8,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: SizeScale.widthX7s),
                          SizedBox(
                            height: SizeScale.widthX9l + 8,
                            width: .5,
                            child: ColoredBox(color: Colors.grey.shade500),
                          ),
                          SizedBox(width: SizeScale.widthX7s),
                          Expanded(
                            child: FadeAndSlideTransition(
                              slideFrom: SlideFrom.bottom,
                              slideFromOffset: .3,
                              delayBeforeStart: const Duration(milliseconds: 1500),
                              child: SizedBox(
                                height: SizeScale.widthX9l + 8,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: SizeScale.widthX4s),
                        ],
                      ),
                      SizedBox(height: SizeScale.heightXs),
                      FadeAndSlideTransition(
                        slideFromOffset: .8,
                        slideFrom: SlideFrom.bottom,
                        animationSpeed: const Duration(milliseconds: 300),
                        delayBeforeStart: const Duration(milliseconds: 2000),
                        child: GeneralEffectsButton(
                          onTap: () {},
                          padding: const EdgeInsets.symmetric(horizontal: 48),
                          height: SizeScale.widthLg + SizeScale.heightX10s,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: .5, color: Colors.grey.shade500),
                          color: Colors.black.withValues(alpha: .5),
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Text(
                                'Selengkapnya',
                                style: AppFonts.inter(
                                  color: Colors.grey.shade50,
                                  fontSize: FontScale.md,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: SizeScale.heightXs),
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
                color: Colors.white.withValues(alpha: .5),
                animationSpeed: const Duration(milliseconds: 600),
                delayBeforeStart: const Duration(milliseconds: 3500),
                animationInterval: const Duration(seconds: 4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
              delayBeforeStart: Duration.zero,
              animationSpeed: const Duration(milliseconds: 300),
              child: SizedBox(
                height: SizeScale.heightX6l,
                width: ScreenUtil.size.width,
                child: Center(
                  child: Text(
                    'Galeri Kami',
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: SizeScale.heightXs),
                          Row(
                            children: [
                              SizedBox(width: SizeScale.widthX6s),
                              Expanded(
                                child: FadeAndSlideTransition(
                                  slideFrom: SlideFrom.left,
                                  slideFromOffset: .3,
                                  child: SizedBox(
                                    height: SizeScale.widthX9l + 8,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                              SizedBox(
                                height: SizeScale.widthX9l + 8,
                                width: .5,
                                child: ColoredBox(color: Colors.grey.shade500),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                              Expanded(
                                child: FadeAndSlideTransition(
                                  slideFrom: SlideFrom.right,
                                  slideFromOffset: .3,
                                  delayBeforeStart: const Duration(milliseconds: 1400),
                                  child: SizedBox(
                                    height: SizeScale.widthX9l + 8,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                            ],
                          ),
                          SizedBox(height: SizeScale.heightX4s),
                          Row(
                            children: [
                              SizedBox(width: SizeScale.widthX6s),
                              Expanded(
                                child: SizedBox(height: .5, child: ColoredBox(color: Colors.grey.shade500)),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                              SizedBox(width: SizeScale.widthX6s),
                              Expanded(
                                child: SizedBox(height: .5, child: ColoredBox(color: Colors.grey.shade500)),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                            ],
                          ),
                          SizedBox(height: SizeScale.heightX4s),
                          Row(
                            children: [
                              SizedBox(width: SizeScale.widthX6s),
                              Expanded(
                                child: FadeAndSlideTransition(
                                  slideFrom: SlideFrom.left,
                                  slideFromOffset: .3,
                                  delayBeforeStart: const Duration(milliseconds: 1400),
                                  child: SizedBox(
                                    height: SizeScale.widthX9l + 8,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                              SizedBox(
                                height: SizeScale.widthX9l + 8,
                                width: .5,
                                child: ColoredBox(color: Colors.grey.shade500),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                              Expanded(
                                child: FadeAndSlideTransition(
                                  slideFrom: SlideFrom.right,
                                  slideFromOffset: .3,
                                  child: SizedBox(
                                    height: SizeScale.widthX9l + 8,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                            ],
                          ),
                          SizedBox(height: SizeScale.heightX4s),
                          Row(
                            children: [
                              SizedBox(width: SizeScale.widthX6s),
                              Expanded(
                                child: SizedBox(height: .5, child: ColoredBox(color: Colors.grey.shade500)),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                              SizedBox(width: SizeScale.widthX6s),
                              Expanded(
                                child: SizedBox(height: .5, child: ColoredBox(color: Colors.grey.shade500)),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                            ],
                          ),
                          SizedBox(height: SizeScale.heightX4s),
                          Row(
                            children: [
                              SizedBox(width: SizeScale.widthX6s),
                              Expanded(
                                child: FadeAndSlideTransition(
                                  slideFrom: SlideFrom.left,
                                  slideFromOffset: .3,
                                  child: SizedBox(
                                    height: SizeScale.widthX9l + 8,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                              SizedBox(
                                height: SizeScale.widthX9l + 8,
                                width: .5,
                                child: ColoredBox(color: Colors.grey.shade500),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                              Expanded(
                                child: FadeAndSlideTransition(
                                  slideFrom: SlideFrom.right,
                                  slideFromOffset: .3,
                                  delayBeforeStart: const Duration(milliseconds: 1400),
                                  child: SizedBox(
                                    height: SizeScale.widthX9l + 8,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                            ],
                          ),
                          SizedBox(height: SizeScale.heightX4s),
                          Row(
                            children: [
                              SizedBox(width: SizeScale.widthX6s),
                              Expanded(
                                child: SizedBox(height: .5, child: ColoredBox(color: Colors.grey.shade500)),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                              SizedBox(width: SizeScale.widthX6s),
                              Expanded(
                                child: SizedBox(height: .5, child: ColoredBox(color: Colors.grey.shade500)),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                            ],
                          ),
                          SizedBox(height: SizeScale.heightX4s),
                          Row(
                            children: [
                              SizedBox(width: SizeScale.widthX6s),
                              Expanded(
                                child: FadeAndSlideTransition(
                                  slideFrom: SlideFrom.left,
                                  slideFromOffset: .3,
                                  delayBeforeStart: const Duration(milliseconds: 1400),
                                  child: SizedBox(
                                    height: SizeScale.widthX9l + 8,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                              SizedBox(
                                height: SizeScale.widthX9l + 8,
                                width: .5,
                                child: ColoredBox(color: Colors.grey.shade500),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                              Expanded(
                                child: FadeAndSlideTransition(
                                  slideFrom: SlideFrom.right,
                                  slideFromOffset: .3,
                                  child: SizedBox(
                                    height: SizeScale.widthX9l + 8,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                            ],
                          ),
                          SizedBox(height: SizeScale.heightX4s),
                          Row(
                            children: [
                              SizedBox(width: SizeScale.widthX6s),
                              Expanded(
                                child: SizedBox(height: .5, child: ColoredBox(color: Colors.grey.shade500)),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                              SizedBox(width: SizeScale.widthX6s),
                              Expanded(
                                child: SizedBox(height: .5, child: ColoredBox(color: Colors.grey.shade500)),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                            ],
                          ),
                          SizedBox(height: SizeScale.heightX4s),
                          Row(
                            children: [
                              SizedBox(width: SizeScale.widthX6s),
                              Expanded(
                                child: FadeAndSlideTransition(
                                  slideFrom: SlideFrom.left,
                                  slideFromOffset: .3,
                                  child: SizedBox(
                                    height: SizeScale.widthX9l + 8,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                              SizedBox(
                                height: SizeScale.widthX9l + 8,
                                width: .5,
                                child: ColoredBox(color: Colors.grey.shade500),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                              Expanded(
                                child: FadeAndSlideTransition(
                                  slideFrom: SlideFrom.right,
                                  slideFromOffset: .3,
                                  delayBeforeStart: const Duration(milliseconds: 1400),
                                  child: SizedBox(
                                    height: SizeScale.widthX9l + 8,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: SizeScale.widthX6s),
                            ],
                          ),
                          SizedBox(height: SizeScale.heightXs),
                        ],
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
                child: BlocSelector<CoreCubit, CoreState, int>(
                  selector: (state) => state.animationTrigger,
                  builder: (_, animationTrigger) {
                    if (animationTrigger == 0) return const SizedBox.shrink();
                    return GlassEffectBox(
                      width: ScreenUtil.size.width - 32,
                      height: ScreenUtil.size.height - (76 + SizeScale.heightX6l),
                      borderRadius: 20,
                      sliderWidth: 90,
                      color: Colors.white.withValues(alpha: .5),
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

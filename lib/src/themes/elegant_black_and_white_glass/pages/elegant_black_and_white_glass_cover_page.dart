import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/src/core/app_fonts.dart';
import 'package:iv_project_invitation_theme/src/core/cubit/core_cubit.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';
import 'package:iv_project_invitation_theme/src/widgets/countdown_timers.dart';
import 'package:iv_project_invitation_theme/src/widgets/double_arrow_slider.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';

class ElegantBlackAndWhiteGlassCoverPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassCoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CoreCubit, CoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          Image.asset(
            'assets/dummys/try_theme_cover_image.png',
            package: 'iv_project_invitation_theme',
            height: ScreenUtil.size.height / 1.2,
            width: ScreenUtil.size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: ScreenUtil.size.height / 1.2,
              width: ScreenUtil.size.width,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.grey.shade900],
                    stops: const [.3, .8],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, .32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FadeAndSlideTransition(
                  slideFromOffset: 0,
                  child: Text(
                    'Pernikahan Dari',
                    style: TextStyle(fontSize: FontScale.lg, fontWeight: FontWeight.w500, color: Colors.grey.shade300),
                  ),
                ),
                SizedBox(height: SizeScale.heightX9s),
                const _BrideName(),
              ],
            ),
          ),
          Align(
            alignment: const Alignment(0, .68),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FadeAndSlideTransition(
                  slideFromOffset: 0,
                  child: Text(
                    'Menuju dalam waktu',
                    style: AppFonts.inter(fontSize: FontScale.xs, color: Colors.grey.shade300),
                  ),
                ),
                const SizedBox(height: 10),
                CountdownTimers(time: DateTime(2025, 9, 15, 9, 30)),
              ],
            ),
          ),
          Align(
            alignment: const Alignment(0, .92),
            child: FadeAndSlideTransition(
              slideFromOffset: 0,
              delayBeforeStart: const Duration(milliseconds: 500),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DoubleArrowSlider(arrowSize: SizeScale.widthLg, sliderPathLength: SizeScale.heightX2l),
                  Text(
                    'Geser ke atas',
                    style: AppFonts.inter(fontSize: FontScale.xs, color: Colors.grey.shade300),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BrideName extends StatelessWidget {
  const _BrideName();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: const Alignment(0, 0),
          child: FadeAndSlideTransition(
            slideFromOffset: .3,
            slideFrom: SlideFrom.left,
            animationSpeed: const Duration(milliseconds: 500),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Milea',
                    style: TextStyle(fontSize: FontScale.x8l, color: Colors.grey.shade300),
                  ),
                  TextSpan(
                    text: ' & ',
                    style: TextStyle(fontSize: FontScale.x4l, color: Colors.transparent),
                  ),
                  TextSpan(
                    text: 'Dilan',
                    style: TextStyle(fontSize: FontScale.x8l, color: Colors.transparent),
                  ),
                ],
              ),
              style: AppFonts.pacifico(fontSize: FontScale.x8l, height: 1.1),
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0, 0),
          child: FadeAndSlideTransition(
            slideFromOffset: 0,
            delayBeforeStart: const Duration(milliseconds: 200),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Milea',
                    style: TextStyle(fontSize: FontScale.x8l, color: Colors.transparent),
                  ),
                  TextSpan(
                    text: ' & ',
                    style: TextStyle(fontSize: FontScale.x4l, color: Colors.grey.shade300),
                  ),
                  TextSpan(
                    text: 'Dilan',
                    style: TextStyle(fontSize: FontScale.x8l, color: Colors.transparent),
                  ),
                ],
              ),
              style: AppFonts.pacifico(fontSize: FontScale.x8l, height: 1.1),
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0, 0),
          child: FadeAndSlideTransition(
            slideFromOffset: .3,
            slideFrom: SlideFrom.right,
            animationSpeed: const Duration(milliseconds: 500),
            delayBeforeStart: const Duration(milliseconds: 400),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Milea',
                    style: TextStyle(fontSize: FontScale.x8l, color: Colors.transparent),
                  ),
                  TextSpan(
                    text: ' & ',
                    style: TextStyle(fontSize: FontScale.x4l, color: Colors.transparent),
                  ),
                  TextSpan(
                    text: 'Dilan',
                    style: TextStyle(fontSize: FontScale.x8l, color: Colors.grey.shade300),
                  ),
                ],
              ),
              style: AppFonts.pacifico(fontSize: FontScale.x8l, height: 1.1),
            ),
          ),
        ),
      ],
    );
  }
}

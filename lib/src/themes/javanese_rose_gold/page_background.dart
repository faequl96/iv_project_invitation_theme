import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/widgets/background_slide_transition.dart';

class JavaneseRoseGoldPageBackground extends StatelessWidget {
  const JavaneseRoseGoldPageBackground({super.key, required this.noAnimate});

  final bool noAnimate;

  final Duration animationSpeed = const Duration(milliseconds: 1200);
  final Duration delayedBeforeStart = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    if (noAnimate) {
      return Stack(
        children: [
          SizedBox(width: Screen.width, height: Screen.height),
          Positioned(
            left: 0,
            width: Screen.width / 2,
            height: Screen.height,
            child: Image.asset(
              'assets/backgrounds/batik_1_left.jpg',
              fit: .fitHeight,
              alignment: .centerRight,
              package: 'iv_project_invitation_theme',
            ),
          ),
          Positioned(
            right: 0,
            width: Screen.width / 2,
            height: Screen.height,
            child: Image.asset(
              'assets/backgrounds/batik_1_right.jpg',
              fit: .fitHeight,
              alignment: .centerLeft,
              package: 'iv_project_invitation_theme',
            ),
          ),
          Positioned(
            left: 0,
            width: Screen.width / 2,
            child: Stack(
              clipBehavior: .none,
              alignment: .center,
              children: [
                SizedBox(width: Screen.width / 2, height: Screen.height),
                Positioned(
                  right: -W.x2s,
                  width: W.x11l,
                  child: Image.asset(
                    'assets/backgrounds/kelir_jawa_rose_gold.png',
                    width: W.x11l,
                    fit: .fitWidth,
                    package: 'iv_project_invitation_theme',
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            width: Screen.width / 2,
            child: Stack(
              clipBehavior: .none,
              alignment: .center,
              children: [
                SizedBox(width: Screen.width / 2, height: Screen.height),
                Positioned(
                  left: -W.x2s,
                  width: W.x11l,
                  child: Image.asset(
                    'assets/backgrounds/kelir_jawa_gold.png',
                    width: W.x11l,
                    fit: .fitWidth,
                    package: 'iv_project_invitation_theme',
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Stack(
      children: [
        SizedBox(width: Screen.width, height: Screen.height),
        Positioned(
          left: 0,
          width: Screen.width / 2,
          height: Screen.height,
          child: BackgroundSlideTransition(
            animationSpeed: animationSpeed,
            delayedBeforeStart: delayedBeforeStart,
            slideFrom: .left,
            child: Image.asset(
              'assets/backgrounds/batik_1_left.jpg',
              fit: .fitHeight,
              alignment: .centerRight,
              package: 'iv_project_invitation_theme',
            ),
          ),
        ),
        Positioned(
          right: 0,
          width: Screen.width / 2,
          height: Screen.height,
          child: BackgroundSlideTransition(
            animationSpeed: animationSpeed,
            delayedBeforeStart: delayedBeforeStart,
            slideFrom: .right,
            child: Image.asset(
              'assets/backgrounds/batik_1_right.jpg',
              fit: .fitHeight,
              alignment: .centerLeft,
              package: 'iv_project_invitation_theme',
            ),
          ),
        ),
        Positioned(
          left: 0,
          width: Screen.width / 2,
          child: BackgroundSlideTransition(
            animationSpeed: animationSpeed,
            delayedBeforeStart: delayedBeforeStart,
            slideFrom: .left,
            child: Stack(
              clipBehavior: .none,
              alignment: .center,
              children: [
                SizedBox(width: Screen.width / 2, height: Screen.height),
                Positioned(
                  right: -W.x2s,
                  width: W.x11l,
                  child: Image.asset(
                    'assets/backgrounds/kelir_jawa_rose_gold.png',
                    width: W.x11l,
                    fit: .fitWidth,
                    package: 'iv_project_invitation_theme',
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          width: Screen.width / 2,
          child: BackgroundSlideTransition(
            animationSpeed: animationSpeed,
            delayedBeforeStart: delayedBeforeStart,
            slideFrom: .right,
            child: Stack(
              clipBehavior: .none,
              alignment: .center,
              children: [
                SizedBox(width: Screen.width / 2, height: Screen.height),
                Positioned(
                  left: -W.x2s,
                  width: W.x11l,
                  child: Image.asset(
                    'assets/backgrounds/kelir_jawa_gold.png',
                    width: W.x11l,
                    fit: .fitWidth,
                    package: 'iv_project_invitation_theme',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

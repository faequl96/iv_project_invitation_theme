import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/widgets/frontground_slide_transition.dart';

class GroupFrontground extends StatelessWidget {
  const GroupFrontground({super.key});

  final Duration animationSpeed = const Duration(milliseconds: 1200);
  final Duration delayedBeforeStart = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(width: Screen.width, height: Screen.height),
        Positioned(
          left: -Screen.width / 2,
          width: Screen.width / 2,
          height: Screen.height,
          child: FrontgroundSlideTransition(
            animationSpeed: animationSpeed,
            delayedBeforeStart: delayedBeforeStart,
            slideFrom: .right,
            child: Image.asset(
              'assets/backgrounds/batik_1_left.jpg',
              fit: .fitHeight,
              alignment: .centerRight,
              package: 'iv_project_invitation_theme',
            ),
          ),
        ),
        Positioned(
          right: -Screen.width / 2,
          width: Screen.width / 2,
          height: Screen.height,
          child: FrontgroundSlideTransition(
            animationSpeed: animationSpeed,
            delayedBeforeStart: delayedBeforeStart,
            slideFrom: .left,
            child: Image.asset(
              'assets/backgrounds/batik_1_right.jpg',
              fit: .fitHeight,
              alignment: .centerLeft,
              package: 'iv_project_invitation_theme',
            ),
          ),
        ),
        Positioned(
          left: -Screen.width / 2,
          width: Screen.width / 2,
          child: FrontgroundSlideTransition(
            animationSpeed: animationSpeed,
            delayedBeforeStart: delayedBeforeStart,
            slideFrom: .right,
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
          right: -Screen.width / 2,
          width: Screen.width / 2,
          child: FrontgroundSlideTransition(
            animationSpeed: animationSpeed,
            delayedBeforeStart: delayedBeforeStart,
            slideFrom: .left,
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

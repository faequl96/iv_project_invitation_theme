import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';

class CoverBackground extends StatelessWidget {
  const CoverBackground({super.key});

  @override
  Widget build(BuildContext context) {
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
                bottom: H.x20l,
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
                bottom: H.x20l,
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
}

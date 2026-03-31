import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class CanvasThemeBackground extends StatelessWidget {
  const CanvasThemeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: Screen.width,
          height: Screen.height,
          child: Image.asset('assets/backgrounds/base_canvas.jpg', fit: .cover, package: 'iv_project_invitation_theme'),
        ),
        SizedBox(
          width: Screen.width,
          height: Screen.height,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: .topCenter,
                end: .bottomCenter,
                colors: [
                  ColorConverter.darken(Colors.blue.shade500, 40).withValues(alpha: .8),
                  Colors.white.withValues(alpha: .0),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          top: 10,
          left: -98,
          child: Transform.flip(
            flipX: true,
            child: RotatedBox(
              quarterTurns: 2,
              child: SizedBox(
                width: Screen.width / 2.2,
                child: Image.asset('assets/backgrounds/floral_1.png', fit: .cover, package: 'iv_project_invitation_theme'),
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: -98,
          child: RotatedBox(
            quarterTurns: 2,
            child: SizedBox(
              width: Screen.width / 2.2,
              child: Image.asset('assets/backgrounds/floral_1.png', fit: .cover, package: 'iv_project_invitation_theme'),
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: -100,
          child: SizedBox(
            width: Screen.width / 2.2,
            child: Image.asset('assets/backgrounds/floral_1.png', fit: .cover, package: 'iv_project_invitation_theme'),
          ),
        ),
        Positioned(
          bottom: 16,
          right: -100,
          child: Transform.flip(
            flipX: true,
            child: SizedBox(
              width: Screen.width / 2.2,
              child: Image.asset('assets/backgrounds/floral_1.png', fit: .cover, package: 'iv_project_invitation_theme'),
            ),
          ),
        ),

        Positioned(
          top: 6,
          left: 6,
          child: Transform.flip(
            flipY: true,
            child: SizedBox(
              width: 40,
              child: Image.asset('assets/backgrounds/floral_leaf.png', fit: .cover, package: 'iv_project_invitation_theme'),
            ),
          ),
        ),
        Positioned(
          top: 6,
          right: 6,
          child: Transform.flip(
            flipX: true,
            flipY: true,
            child: SizedBox(
              width: 40,
              child: Image.asset('assets/backgrounds/floral_leaf.png', fit: .cover, package: 'iv_project_invitation_theme'),
            ),
          ),
        ),
        Positioned(
          bottom: 6,
          left: 6,
          child: Transform.flip(
            child: SizedBox(
              width: 40,
              child: Image.asset('assets/backgrounds/floral_leaf.png', fit: .cover, package: 'iv_project_invitation_theme'),
            ),
          ),
        ),
        Positioned(
          bottom: 6,
          right: 6,
          child: Transform.flip(
            flipX: true,
            child: SizedBox(
              width: 40,
              child: Image.asset('assets/backgrounds/floral_leaf.png', fit: .cover, package: 'iv_project_invitation_theme'),
            ),
          ),
        ),
        Positioned(
          top: Screen.height / 2,
          left: -2,
          child: Transform.flip(
            flipY: true,
            child: SizedBox(
              width: 30,
              child: Image.asset('assets/backgrounds/floral_leaf.png', fit: .cover, package: 'iv_project_invitation_theme'),
            ),
          ),
        ),
        Positioned(
          bottom: Screen.height / 2,
          left: -2,
          child: Transform.flip(
            child: SizedBox(
              width: 30,
              child: Image.asset('assets/backgrounds/floral_leaf.png', fit: .cover, package: 'iv_project_invitation_theme'),
            ),
          ),
        ),
        Positioned(
          top: Screen.height / 2,
          right: -2,
          child: Transform.flip(
            flipY: true,
            flipX: true,
            child: SizedBox(
              width: 30,
              child: Image.asset('assets/backgrounds/floral_leaf.png', fit: .cover, package: 'iv_project_invitation_theme'),
            ),
          ),
        ),
        Positioned(
          bottom: Screen.height / 2,
          right: -2,
          child: Transform.flip(
            flipX: true,
            child: SizedBox(
              width: 30,
              child: Image.asset('assets/backgrounds/floral_leaf.png', fit: .cover, package: 'iv_project_invitation_theme'),
            ),
          ),
        ),
        Positioned(
          bottom: -2,
          left: Screen.width / 2,
          child: Transform.flip(
            child: SizedBox(
              width: 20,
              child: Image.asset('assets/backgrounds/floral_leaf.png', fit: .cover, package: 'iv_project_invitation_theme'),
            ),
          ),
        ),
        Positioned(
          bottom: -2,
          right: Screen.width / 2,
          child: Transform.flip(
            flipX: true,
            child: SizedBox(
              width: 20,
              child: Image.asset('assets/backgrounds/floral_leaf.png', fit: .cover, package: 'iv_project_invitation_theme'),
            ),
          ),
        ),
      ],
    );
  }
}

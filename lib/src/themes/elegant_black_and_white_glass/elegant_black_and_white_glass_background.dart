import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/widgets/random_slide_transition.dart';

class ElegantBlackAndWhiteGlassBackground extends StatelessWidget {
  const ElegantBlackAndWhiteGlassBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          SizedBox(
            height: Screen.height,
            width: Screen.width,
            child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey.shade300)),
          ),
          Positioned(
            left: -110,
            bottom: -80,
            child: Bubble.fill(size: W.x16l, color: Colors.grey.shade900),
          ),
          Positioned(
            left: 80,
            bottom: H.x9l,
            child: RandomSlideTransition(
              child: Bubble.border(size: W.x5l, color: Colors.white),
            ),
          ),
          Positioned(
            right: -40,
            bottom: -90,
            child: Bubble.fill(size: W.x15l, color: Colors.white),
          ),
          Positioned(
            right: 90,
            bottom: 120,
            child: RandomSlideTransition(
              child: Bubble.border(size: W.x4l, color: Colors.grey.shade600, borderWidth: 1),
            ),
          ),
          Positioned(
            right: 4,
            bottom: H.x18l,
            child: RandomSlideTransition(
              maxSlideOffset: .2,
              child: Bubble.border(size: W.x9l, color: Colors.grey.shade600, borderWidth: 1),
            ),
          ),
          Positioned(
            right: 80,
            bottom: H.x20l,
            child: RandomSlideTransition(
              child: Bubble.fill(size: W.x5l, color: Colors.white),
            ),
          ),
          Positioned(
            left: 4,
            bottom: H.x20l,
            child: RandomSlideTransition(
              child: Bubble.border(size: W.x6l, color: Colors.white),
            ),
          ),
          Positioned(
            left: 40,
            bottom: H.x20l - 20,
            child: RandomSlideTransition(
              child: Bubble.fill(size: W.xl, color: Colors.grey.shade500),
            ),
          ),
          Positioned(
            left: 90,
            top: H.x5l,
            child: Bubble.fill(size: W.x6l, color: Colors.grey.shade400),
          ),
          Positioned(
            left: 140,
            top: H.x10l,
            child: Bubble.fill(size: W.md, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class Bubble extends StatelessWidget {
  const Bubble.fill({super.key, required this.size, required this.color}) : isBorder = false, borderWidth = 0;
  const Bubble.border({super.key, required this.size, required this.color, this.borderWidth = 2}) : isBorder = true;

  final bool isBorder;
  final double size;
  final Color color;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: .circle,
          color: !isBorder ? color : null,
          border: isBorder ? .all(width: borderWidth, color: color) : null,
        ),
      ),
    );
  }
}

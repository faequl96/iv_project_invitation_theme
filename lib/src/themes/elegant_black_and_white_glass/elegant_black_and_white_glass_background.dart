import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';
import 'package:iv_project_invitation_theme/src/widgets/random_slide_transition.dart';

class ElegantBlackAndWhiteGlassBackground extends StatelessWidget {
  const ElegantBlackAndWhiteGlassBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CoreCubit, CoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          SizedBox(
            height: ScreenUtil.size.height,
            width: ScreenUtil.size.width,
            child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey.shade300)),
          ),
          Positioned(
            left: -110,
            bottom: -80,
            child: RandomSlideTransition(
              maxSlideOffset: .05,
              child: Bubble(size: SizeScale.widthX16l, color: Colors.grey.shade900),
            ),
          ),
          Positioned(
            left: 80,
            bottom: SizeScale.heightX9l,
            child: RandomSlideTransition(
              child: Bubble(size: SizeScale.widthX5l, color: Colors.white),
            ),
          ),
          Positioned(
            right: -40,
            bottom: -90,
            child: RandomSlideTransition(
              maxSlideOffset: .04,
              child: Bubble(size: SizeScale.widthX15l, color: Colors.white),
            ),
          ),
          Positioned(
            right: 90,
            bottom: 120,
            child: RandomSlideTransition(
              child: Bubble(size: SizeScale.widthX4l, color: Colors.grey.shade600),
            ),
          ),
          Positioned(
            right: 4,
            bottom: SizeScale.heightX18l,
            child: RandomSlideTransition(
              maxSlideOffset: .2,
              child: Bubble(size: SizeScale.widthX9l, color: Colors.grey.shade600),
            ),
          ),
          Positioned(
            right: 80,
            bottom: SizeScale.heightX20l,
            child: RandomSlideTransition(
              child: Bubble(size: SizeScale.widthX5l, color: Colors.white),
            ),
          ),
          Positioned(
            left: 4,
            bottom: SizeScale.heightX20l,
            child: RandomSlideTransition(
              child: Bubble(size: SizeScale.widthX6l, color: Colors.white),
            ),
          ),
          Positioned(
            left: 40,
            bottom: SizeScale.heightX20l - 20,
            child: RandomSlideTransition(
              child: Bubble(size: SizeScale.widthXl, color: Colors.grey.shade700.withValues(alpha: .6)),
            ),
          ),
          Positioned(
            left: 90,
            top: SizeScale.heightX7l,
            child: RandomSlideTransition(
              maxSlideOffset: .2,
              child: Bubble(size: SizeScale.widthX6l, color: Colors.grey.shade400),
            ),
          ),
          Positioned(
            left: 140,
            top: SizeScale.heightX12l,
            child: RandomSlideTransition(
              maxSlideOffset: .4,
              child: Bubble(size: SizeScale.widthMd, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class Bubble extends StatelessWidget {
  const Bubble({super.key, required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}

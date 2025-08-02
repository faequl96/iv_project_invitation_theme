import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';

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
            child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey.shade50)),
          ),
          Positioned(
            left: -100,
            bottom: -140,
            child: Bubble(size: SizeScale.widthX19l, color: Colors.grey.shade900),
          ),
          Positioned(
            right: -220,
            bottom: -240,
            child: Bubble(size: SizeScale.widthX22l, color: Colors.grey.shade300.withValues(alpha: .7)),
          ),
          Positioned(
            left: 4,
            bottom: SizeScale.heightX18l,
            child: Bubble(size: SizeScale.widthX10l, color: Colors.grey.shade800),
          ),
          Positioned(
            left: 80,
            bottom: SizeScale.heightX20l,
            child: Bubble(size: SizeScale.widthX5l, color: Colors.grey.shade400.withValues(alpha: .5)),
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

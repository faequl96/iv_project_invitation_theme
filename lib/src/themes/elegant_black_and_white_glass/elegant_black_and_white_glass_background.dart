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
          Positioned(
            top: 0,
            child: SizedBox(
              height: ScreenUtil.size.height,
              width: ScreenUtil.size.width,
              child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey.shade50)),
            ),
          ),
          Positioned(
            left: -100,
            bottom: -140,
            child: SizedBox(
              width: SizeScale.widthX19l,
              height: SizeScale.widthX19l,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(SizeScale.widthX19l / 2),
                ),
              ),
            ),
          ),
          Positioned(
            right: -220,
            bottom: -240,
            child: SizedBox(
              width: SizeScale.widthX22l,
              height: SizeScale.widthX22l,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300.withValues(alpha: .7),
                  borderRadius: BorderRadius.circular(SizeScale.widthX22l / 2),
                ),
              ),
            ),
          ),
          Positioned(
            left: 4,
            bottom: SizeScale.heightX18l,
            child: SizedBox(
              width: SizeScale.widthX10l,
              height: SizeScale.widthX10l,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(SizeScale.widthX10l / 2),
                ),
              ),
            ),
          ),
          Positioned(
            left: 80,
            bottom: SizeScale.heightX20l,
            child: SizedBox(
              width: SizeScale.widthX5l,
              height: SizeScale.widthX5l,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300.withValues(alpha: .5),
                  borderRadius: BorderRadius.circular(SizeScale.widthX5l / 2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

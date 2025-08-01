import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';

class ElegantBlackAndWhiteGlassFirstPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassFirstPage({super.key});

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
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.grey.shade800, Colors.grey.shade50],
                    stops: const [.1, .7],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: -100,
            bottom: -100,
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
            bottom: -200,
            child: SizedBox(
              width: SizeScale.widthX22l,
              height: SizeScale.widthX22l,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200.withValues(alpha: .7),
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
                  color: Colors.grey.shade700.withValues(alpha: .5),
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
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: ScreenUtil.size.height,
              width: ScreenUtil.size.width,
              child: Padding(
                padding: EdgeInsets.only(top: SizeScale.heightX9l, left: 14, right: 14, bottom: 76),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .5),
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
                padding: EdgeInsets.only(top: SizeScale.heightX9l, left: 14, right: 14, bottom: 76),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: .5, color: Colors.grey.shade500),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

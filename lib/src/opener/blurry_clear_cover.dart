import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/core/cubit/invitation_theme_core_cubit.dart';

class BlurryClearCover extends StatelessWidget {
  const BlurryClearCover({super.key, required this.isLeft});

  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => SizedBox(
        height: ScreenUtil.size.height,
        width: ScreenUtil.size.width / 2,
        child: Stack(
          alignment: AlignmentDirectional.center,
          clipBehavior: Clip.none,
          children: [
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: SizedBox(
                  height: ScreenUtil.size.height,
                  width: ScreenUtil.size.width / 2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade500.withValues(alpha: 0.2),
                      border: Border(
                        left: isLeft ? BorderSide.none : BorderSide(color: Colors.grey.shade500, width: .5),
                        right: isLeft ? BorderSide(color: Colors.grey.shade500, width: .5) : BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(isLeft ? 1 : -1, .6),
              child: Transform.translate(
                offset: Offset(isLeft ? 1 : -1, 0),
                child: SizedBox(
                  height: SizeScale.heightX10l,
                  width: (ScreenUtil.size.width / 2) - SizeScale.widthLg,
                  child: _RecipientBox(isLeft: isLeft),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecipientBox extends StatelessWidget {
  const _RecipientBox({required this.isLeft});

  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey.shade800.withValues(alpha: .6),
        borderRadius: isLeft
            ? const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))
            : const BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        border: Border(
          top: BorderSide(width: .5, color: Colors.grey.shade500),
          left: isLeft ? BorderSide(width: .5, color: Colors.grey.shade500) : BorderSide.none,
          right: isLeft ? BorderSide.none : BorderSide(width: .5, color: Colors.grey.shade500),
          bottom: BorderSide(width: .5, color: Colors.grey.shade500),
        ),
      ),
    );
  }
}

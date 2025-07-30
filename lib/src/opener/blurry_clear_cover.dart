import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/utils/edge_insets_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/shape_scale.dart';

class BlurryClearCover extends StatelessWidget {
  const BlurryClearCover({super.key, required this.isLeft});

  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TryThemeCubit, TryThemeState, Size>(
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
              alignment: Alignment(isLeft ? 1 : -1, -.3),
              child: Transform.translate(
                offset: Offset(isLeft ? 1 : -1, 0),
                child: SizedBox(
                  height: ShapeScale.heightX17l,
                  width: ShapeScale.heightX13l,
                  child: _BrideInitialBox(isLeft: isLeft, initialLeftName: 'M', initialRightName: 'D'),
                ),
              ),
            ),
            Align(
              alignment: Alignment(isLeft ? 1 : -1, .6),
              child: Transform.translate(
                offset: Offset(isLeft ? 1 : -1, 0),
                child: SizedBox(
                  height: ShapeScale.heightX10l,
                  width: (ScreenUtil.size.width / 2) - EdgeInsetsScale.x8l,
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

class _BrideInitialBox extends StatelessWidget {
  const _BrideInitialBox({required this.isLeft, required this.initialLeftName, required this.initialRightName});

  final bool isLeft;
  final String initialLeftName;
  final String initialRightName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!isLeft) SizedBox(height: ShapeScale.heightX9l),
        Text(
          isLeft ? initialLeftName : initialRightName,
          style: GoogleFonts.parisienne(
            fontSize: FontScale.x2l + ShapeScale.heightX2l,
            fontWeight: FontWeight.w900,
            color: Colors.grey.shade100.withValues(alpha: .6),
          ),
        ),
        if (isLeft) SizedBox(height: ShapeScale.heightX9l),
      ],
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/core/app_fonts.dart';
import 'package:iv_project_invitation_theme/src/core/cubit/invitation_theme_core_cubit.dart';
import 'package:iv_project_invitation_theme/src/enums/enums.dart';
import 'package:iv_project_invitation_theme/src/widgets/countdown_timers.dart';
import 'package:iv_project_invitation_theme/src/widgets/double_arrow_slider.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_model/iv_project_model.dart';

class ElegantBlackAndWhiteGlassCoverPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassCoverPage({
    super.key,
    required this.previewType,
    this.coverImage,
    required this.general,
    required this.bride,
    required this.groom,
    required this.time,
  });

  final ThemePreviewType previewType;
  final File? coverImage;
  final GeneralResponse general;
  final BridegroomResponse bride;
  final BridegroomResponse groom;
  final EventResponse time;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          if (previewType == ThemePreviewType.fromRaw) ...[
            if (coverImage != null)
              Image.file(coverImage!, height: ScreenUtil.size.height / 1.2, width: ScreenUtil.size.width, fit: BoxFit.cover),
          ] else ...[
            if (general.coverImageUrl != null)
              Image.network(
                general.coverImageUrl!,
                height: ScreenUtil.size.height / 1.2,
                width: ScreenUtil.size.width,
                fit: BoxFit.cover,
              ),
          ],
          Positioned(
            bottom: 0,
            height: ScreenUtil.size.height / 1.2,
            width: ScreenUtil.size.width,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.grey.shade900],
                  stops: const [.3, .8],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            width: ScreenUtil.size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FadeAndSlideTransition(
                  slideFromOffset: 0,
                  child: Text(
                    'Pernikahan Dari',
                    style: TextStyle(fontSize: FontScale.lg, fontWeight: FontWeight.w500, color: Colors.grey.shade300),
                  ),
                ),
                SizedBox(height: SizeScale.heightX9s),
                _BridegroomName(bride: bride, groom: groom),
                SizedBox(height: SizeScale.heightMd),
                FadeAndSlideTransition(
                  slideFromOffset: 0,
                  child: Text(
                    'Menuju dalam waktu',
                    style: AppFonts.inter(fontSize: FontScale.xs, color: Colors.grey.shade300),
                  ),
                ),
                SizedBox(height: SizeScale.heightX8s),
                CountdownTimers(time: time.startTime),
                SizedBox(height: SizeScale.heightX5s),
                FadeAndSlideTransition(
                  slideFromOffset: 0,
                  delayBeforeStart: const Duration(milliseconds: 500),
                  child: DoubleArrowSlider(arrowSize: SizeScale.widthLg, sliderPathLength: SizeScale.heightX2l),
                ),
                FadeAndSlideTransition(
                  slideFromOffset: 0,
                  delayBeforeStart: const Duration(milliseconds: 500),
                  child: Text(
                    'Geser ke atas',
                    style: AppFonts.inter(fontSize: FontScale.xs, color: Colors.grey.shade300),
                  ),
                ),
                SizedBox(height: SizeScale.heightX2s),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BridegroomName extends StatelessWidget {
  const _BridegroomName({required this.bride, required this.groom});

  final BridegroomResponse bride;
  final BridegroomResponse groom;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: const Alignment(0, 0),
          child: FadeAndSlideTransition(
            slideFromOffset: .3,
            slideFrom: SlideFrom.left,
            animationSpeed: const Duration(milliseconds: 500),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: bride.nickname,
                    style: TextStyle(fontSize: FontScale.x8l, color: Colors.grey.shade300),
                  ),
                  TextSpan(
                    text: ' & ',
                    style: TextStyle(fontSize: FontScale.x4l, color: Colors.transparent),
                  ),
                  TextSpan(
                    text: groom.nickname,
                    style: TextStyle(fontSize: FontScale.x8l, color: Colors.transparent),
                  ),
                ],
              ),
              style: AppFonts.pacifico(fontSize: FontScale.x8l, height: 1.1),
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0, 0),
          child: FadeAndSlideTransition(
            slideFromOffset: 0,
            delayBeforeStart: const Duration(milliseconds: 300),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: bride.nickname,
                    style: TextStyle(fontSize: FontScale.x8l, color: Colors.transparent),
                  ),
                  TextSpan(
                    text: ' & ',
                    style: TextStyle(fontSize: FontScale.x4l, color: Colors.grey.shade300),
                  ),
                  TextSpan(
                    text: groom.nickname,
                    style: TextStyle(fontSize: FontScale.x8l, color: Colors.transparent),
                  ),
                ],
              ),
              style: AppFonts.pacifico(fontSize: FontScale.x8l, height: 1.1),
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0, 0),
          child: FadeAndSlideTransition(
            slideFromOffset: .3,
            slideFrom: SlideFrom.right,
            animationSpeed: const Duration(milliseconds: 500),
            delayBeforeStart: const Duration(milliseconds: 400),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: bride.nickname,
                    style: TextStyle(fontSize: FontScale.x8l, color: Colors.transparent),
                  ),
                  TextSpan(
                    text: ' & ',
                    style: TextStyle(fontSize: FontScale.x4l, color: Colors.transparent),
                  ),
                  TextSpan(
                    text: groom.nickname,
                    style: TextStyle(fontSize: FontScale.x8l, color: Colors.grey.shade300),
                  ),
                ],
              ),
              style: AppFonts.pacifico(fontSize: FontScale.x8l, height: 1.1),
            ),
          ),
        ),
      ],
    );
  }
}

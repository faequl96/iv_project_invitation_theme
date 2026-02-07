import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/widgets/audio_player_widget.dart';
import 'package:iv_project_invitation_theme/src/widgets/countdown_timers.dart';
import 'package:iv_project_invitation_theme/src/widgets/double_arrow_slider.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_model/iv_project_model.dart';

class ElegantBlackAndWhiteGlassCoverPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassCoverPage({
    super.key,
    required this.viewType,
    this.coverImage,
    required this.general,
    required this.bride,
    required this.groom,
    required this.time,
  });

  final ViewType viewType;
  final File? coverImage;
  final GeneralResponse general;
  final BridegroomResponse bride;
  final BridegroomResponse groom;
  final EventResponse time;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          if (viewType == ViewType.preview) ...[
            if (coverImage != null) Image.file(coverImage!, height: Screen.height / 1.2, width: Screen.width, fit: .cover),
          ] else if (viewType == ViewType.example) ...[
            if (general.coverImageUrl != null)
              Image.asset(
                general.coverImageUrl!,
                height: Screen.height / 1.2,
                width: Screen.width,
                fit: .cover,
                package: 'iv_project_invitation_theme',
              ),
          ] else ...[
            if (general.coverImageUrl != null)
              Image.network(general.coverImageUrl!, height: Screen.height / 1.2, width: Screen.width, fit: .cover),
          ],
          Positioned(
            bottom: 0,
            height: Screen.height / 1.2,
            width: Screen.width,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: .topCenter,
                  end: .bottomCenter,
                  colors: [Colors.transparent, Colors.grey.shade900],
                  stops: const [.3, .8],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            width: Screen.width,
            child: Column(
              mainAxisSize: .min,
              children: [
                FadeAndSlideTransition(
                  slideFromOffset: 0,
                  child: Text(
                    langCode == 'en' ? 'The Wedding of' : 'Pernikahan Dari',
                    style: TextStyle(fontSize: FontSize.lg, fontWeight: .w500, color: Colors.grey.shade300),
                  ),
                ),
                SizedBox(height: H.x9s),
                _BridegroomName(bride: bride, groom: groom),
                SizedBox(height: H.md),
                FadeAndSlideTransition(
                  slideFromOffset: 0,
                  child: Text(
                    langCode == 'en' ? 'Heading in' : 'Menuju dalam waktu',
                    style: AppFonts.inter(fontSize: FontSize.xs, color: Colors.grey.shade300),
                  ),
                ),
                SizedBox(height: H.x8s),
                CountdownTimers(time: time.startTime),
                SizedBox(height: H.x5s),
                FadeAndSlideTransition(
                  slideFromOffset: 0,
                  delayBeforeStart: const Duration(milliseconds: 500),
                  child: DoubleArrowSlider(arrowSize: W.lg, sliderPathLength: H.x2l),
                ),
                FadeAndSlideTransition(
                  slideFromOffset: 0,
                  delayBeforeStart: const Duration(milliseconds: 500),
                  child: Text(
                    langCode == 'en' ? 'Swipe up' : 'Geser ke atas',
                    style: AppFonts.inter(fontSize: FontSize.xs, color: Colors.grey.shade300),
                  ),
                ),
                SizedBox(height: H.x2s),
              ],
            ),
          ),
          if (viewType == ViewType.live && CoreStatic.player.audioSource != null)
            const Positioned(top: 10, right: 10, child: AudioPlayerWidget()),
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
            slideFrom: .left,
            animationSpeed: const Duration(milliseconds: 500),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: bride.nickname,
                    style: TextStyle(fontSize: FontSize.x8l, color: Colors.grey.shade300),
                  ),
                  TextSpan(
                    text: ' & ',
                    style: TextStyle(fontSize: FontSize.x4l, color: Colors.transparent),
                  ),
                  TextSpan(
                    text: groom.nickname,
                    style: TextStyle(fontSize: FontSize.x8l, color: Colors.transparent),
                  ),
                ],
              ),
              style: AppFonts.pacifico(fontSize: FontSize.x8l, height: 1.1),
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
                    style: TextStyle(fontSize: FontSize.x8l, color: Colors.transparent),
                  ),
                  TextSpan(
                    text: ' & ',
                    style: TextStyle(fontSize: FontSize.x4l, color: Colors.grey.shade300),
                  ),
                  TextSpan(
                    text: groom.nickname,
                    style: TextStyle(fontSize: FontSize.x8l, color: Colors.transparent),
                  ),
                ],
              ),
              style: AppFonts.pacifico(fontSize: FontSize.x8l, height: 1.1),
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0, 0),
          child: FadeAndSlideTransition(
            slideFromOffset: .3,
            slideFrom: .right,
            animationSpeed: const Duration(milliseconds: 500),
            delayBeforeStart: const Duration(milliseconds: 400),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: bride.nickname,
                    style: TextStyle(fontSize: FontSize.x8l, color: Colors.transparent),
                  ),
                  TextSpan(
                    text: ' & ',
                    style: TextStyle(fontSize: FontSize.x4l, color: Colors.transparent),
                  ),
                  TextSpan(
                    text: groom.nickname,
                    style: TextStyle(fontSize: FontSize.x8l, color: Colors.grey.shade300),
                  ),
                ],
              ),
              style: AppFonts.pacifico(fontSize: FontSize.x8l, height: 1.1),
            ),
          ),
        ),
      ],
    );
  }
}

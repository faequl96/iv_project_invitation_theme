import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/widgets/audio_player_widget.dart';
import 'package:iv_project_invitation_theme/src/widgets/bride_groom_name.dart';
import 'package:iv_project_invitation_theme/src/widgets/countdown_timers.dart';
import 'package:iv_project_invitation_theme/src/widgets/double_arrow_slider.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_model/iv_project_model.dart';

class PageViewBasedCoverPageConfig {
  const PageViewBasedCoverPageConfig({
    this.coverBackground,
    required this.gradientBaseColor,
    required this.brideNameColor,
    required this.groomNameColor,
    required this.countdownBorderWidth,
    required this.countdownOddColor,
    required this.countdownEvenColor,
    required this.countdownOddBorderColor,
    required this.countdownEvenBorderColor,
    required this.countdownNumberColor,
    required this.countdownUnitColor,
    required this.useLightningEffectOnCountdown,
    required this.firstArrowColor,
    required this.secondArrowColor,
  });

  final Widget? coverBackground;
  final Color gradientBaseColor;
  final Color brideNameColor;
  final Color groomNameColor;
  final double countdownBorderWidth;
  final Color countdownOddColor;
  final Color countdownEvenColor;
  final Color countdownOddBorderColor;
  final Color countdownEvenBorderColor;
  final Color countdownNumberColor;
  final Color countdownUnitColor;
  final bool useLightningEffectOnCountdown;
  final Color firstArrowColor;
  final Color secondArrowColor;
}

class PageViewBasedCoverPage extends StatelessWidget {
  const PageViewBasedCoverPage({
    super.key,
    required this.config,
    required this.viewType,
    this.coverImage,
    required this.general,
    required this.bride,
    required this.groom,
    required this.time,
    required this.noAnimate,
  });

  final PageViewBasedCoverPageConfig config;
  final ViewType viewType;
  final File? coverImage;
  final GeneralResponse general;
  final BridegroomResponse bride;
  final BridegroomResponse groom;
  final EventResponse time;
  final bool noAnimate;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          if (config.coverBackground != null)
            config.coverBackground!
          else ...[
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
                  colors: [config.gradientBaseColor.withValues(alpha: .0), config.gradientBaseColor],
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
                if (!noAnimate) ...[
                  FadeAndSlideTransition(slideFromOffset: 0, child: _theWeddingOf(langCode)),
                  SizedBox(height: H.x9s),
                  BridegroomName(
                    brideNameColor: config.brideNameColor,
                    groomNameColor: config.groomNameColor,
                    bride: bride,
                    groom: groom,
                    noAnimate: noAnimate,
                  ),
                  SizedBox(height: H.md),
                  FadeAndSlideTransition(slideFromOffset: 0, child: _headingIn(langCode)),
                  SizedBox(height: H.x8s),
                  CountdownTimers(
                    oddColor: config.countdownOddColor,
                    evenColor: config.countdownEvenColor,
                    oddBorderColor: config.countdownOddBorderColor,
                    evenBorderColor: config.countdownEvenBorderColor,
                    numberColor: config.countdownNumberColor,
                    unitColor: config.countdownUnitColor,
                    borderWidth: config.countdownBorderWidth,
                    useLightningEffect: config.useLightningEffectOnCountdown,
                    time: time.startTime,
                    noAnimate: noAnimate,
                  ),
                  SizedBox(height: H.x5s),
                  FadeAndSlideTransition(
                    slideFromOffset: 0,
                    delayBeforeStart: const Duration(milliseconds: 500),
                    child: _arrowSlider(),
                  ),
                  FadeAndSlideTransition(
                    slideFromOffset: 0,
                    delayBeforeStart: const Duration(milliseconds: 500),
                    child: _swipeUp(langCode),
                  ),
                  SizedBox(height: H.x2s),
                ] else ...[
                  _theWeddingOf(langCode),
                  SizedBox(height: H.x9s),
                  BridegroomName(
                    brideNameColor: config.brideNameColor,
                    groomNameColor: config.groomNameColor,
                    bride: bride,
                    groom: groom,
                    noAnimate: noAnimate,
                  ),
                  SizedBox(height: H.md),
                  _headingIn(langCode),
                  SizedBox(height: H.x8s),
                  CountdownTimers(
                    oddColor: config.countdownOddColor,
                    evenColor: config.countdownEvenColor,
                    oddBorderColor: config.countdownOddBorderColor,
                    evenBorderColor: config.countdownEvenBorderColor,
                    numberColor: config.countdownNumberColor,
                    unitColor: config.countdownUnitColor,
                    borderWidth: config.countdownBorderWidth,
                    useLightningEffect: config.useLightningEffectOnCountdown,
                    time: time.startTime,
                    noAnimate: noAnimate,
                  ),
                  SizedBox(height: H.x5s),
                  _arrowSlider(),
                  _swipeUp(langCode),
                  SizedBox(height: H.x2s),
                ],
              ],
            ),
          ),
          if (viewType == ViewType.live && Audio.player.audioSource != null)
            const Positioned(top: 10, right: 10, child: AudioPlayerWidget()),
        ],
      ),
    );
  }

  Widget _theWeddingOf(String langCode) => Text(
    langCode == 'en' ? 'The Wedding of' : 'Pernikahan Dari',
    style: TextStyle(fontSize: FontSize.lg, fontWeight: .w500, color: Colors.grey.shade300),
  );

  Widget _headingIn(String langCode) => Text(
    langCode == 'en' ? 'Heading in' : 'Menuju dalam waktu',
    style: AppFonts.inter(fontSize: FontSize.xs, color: Colors.grey.shade300),
  );

  Widget _swipeUp(String langCode) => Text(
    langCode == 'en' ? 'Swipe up' : 'Geser ke atas',
    style: AppFonts.inter(fontSize: FontSize.xs, color: Colors.grey.shade300),
  );

  Widget _arrowSlider() => DoubleArrowSlider(
    firstArrowColor: config.firstArrowColor,
    secondArrowColor: config.secondArrowColor,
    arrowSize: W.lg,
    sliderPathLength: H.x2l,
  );
}

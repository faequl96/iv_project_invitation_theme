import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_types/page_view_tab_bar/page_view_tab_bar_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/audio_player_widget.dart';
import 'package:iv_project_invitation_theme/src/widgets/bride_groom_name.dart';
import 'package:iv_project_invitation_theme/src/widgets/countdown_timers.dart';
import 'package:iv_project_invitation_theme/src/widgets/double_arrow_slider.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_model/iv_project_model.dart';

class PageViewTabBarCoverPage extends StatefulWidget {
  const PageViewTabBarCoverPage({
    super.key,
    required this.config,
    required this.viewType,
    this.coverImage,
    required this.general,
    required this.bride,
    required this.groom,
    required this.time,
  });

  final PageViewTabBarCoverPageConfig config;
  final ViewType viewType;
  final File? coverImage;
  final GeneralResponse general;
  final BridegroomResponse bride;
  final BridegroomResponse groom;
  final EventResponse time;

  @override
  State<PageViewTabBarCoverPage> createState() => _PageViewTabBarCoverPageState();
}

class _PageViewTabBarCoverPageState extends State<PageViewTabBarCoverPage> {
  Widget? _cachedImage;

  @override
  void initState() {
    super.initState();

    _buildCachedImage();
  }

  void _buildCachedImage() {
    if (widget.viewType == .preview && widget.coverImage != null) {
      _cachedImage = Image.file(
        widget.coverImage!,
        height: Screen.height / 1.2,
        width: Screen.width,
        fit: .cover,
      );
    } else if (widget.viewType == .example && widget.general.coverImageUrl != null) {
      _cachedImage = Image.asset(
        widget.general.coverImageUrl!,
        height: Screen.height / 1.2,
        width: Screen.width,
        fit: .cover,
        package: 'iv_project_invitation_theme',
      );
    } else if (widget.general.coverImageUrl != null) {
      _cachedImage = Image.network(
        widget.general.coverImageUrl!,
        height: Screen.height / 1.2,
        width: Screen.width,
        fit: .cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          if (widget.config.coverBackground != null)
            widget.config.coverBackground!
          else
            ?_cachedImage,

          Positioned(
            bottom: 0,
            height: Screen.height / 1.2,
            width: Screen.width,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: .topCenter,
                  end: .bottomCenter,
                  colors: [
                    widget.config.gradientBaseColor.withValues(alpha: .0),
                    widget.config.gradientBaseColor,
                  ],
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
                FadeAndSlideTransition(slideFromOffset: 0, child: _buildTheWeddingOf(langCode)),
                SizedBox(height: H.x9s),
                BridegroomName(
                  brideNameColor: widget.config.brideNameColor,
                  groomNameColor: widget.config.groomNameColor,
                  bride: widget.bride,
                  groom: widget.groom,
                  noAnimate: false,
                ),
                SizedBox(height: H.md),
                FadeAndSlideTransition(slideFromOffset: 0, child: _buildHeadingIn(langCode)),
                SizedBox(height: H.x8s),
                CountdownTimers(
                  oddColor: widget.config.countdownOddColor,
                  evenColor: widget.config.countdownEvenColor,
                  oddBorderColor: widget.config.countdownOddBorderColor,
                  evenBorderColor: widget.config.countdownEvenBorderColor,
                  numberColor: widget.config.countdownNumberColor,
                  unitColor: widget.config.countdownUnitColor,
                  borderWidth: widget.config.countdownBorderWidth,
                  useLightningEffect: widget.config.useLightningEffectOnCountdown,
                  time: widget.time.startTime,
                  noAnimate: false,
                ),
                SizedBox(height: H.x5s),
                FadeAndSlideTransition(
                  slideFromOffset: 0,
                  delayBeforeStart: const Duration(milliseconds: 500),
                  child: _buildArrowSlider(),
                ),
                FadeAndSlideTransition(
                  slideFromOffset: 0,
                  delayBeforeStart: const Duration(milliseconds: 500),
                  child: _buildSwipeUp(langCode),
                ),
                SizedBox(height: H.x2s),
              ],
            ),
          ),
          if (widget.viewType == .live && Audio.player.audioSource != null)
            const Positioned(top: 10, right: 10, child: AudioPlayerWidget()),
        ],
      ),
    );
  }

  Widget _buildTheWeddingOf(String langCode) => Text(
    langCode == 'en' ? 'The Wedding of' : 'Pernikahan Dari',
    style: TextStyle(fontSize: FontSize.lg, fontWeight: .w500, color: Colors.grey.shade300),
  );

  Widget _buildHeadingIn(String langCode) => Text(
    langCode == 'en' ? 'Heading in' : 'Menuju dalam waktu',
    style: AppFonts.inter(fontSize: FontSize.xs, color: Colors.grey.shade300),
  );

  Widget _buildSwipeUp(String langCode) => Text(
    langCode == 'en' ? 'Swipe up' : 'Geser ke atas',
    style: AppFonts.inter(fontSize: FontSize.xs, color: Colors.grey.shade300),
  );

  Widget _buildArrowSlider() => DoubleArrowSlider(
    firstArrowColor: widget.config.firstArrowColor,
    secondArrowColor: widget.config.secondArrowColor,
    arrowSize: W.lg,
    sliderPathLength: H.x2l,
  );
}

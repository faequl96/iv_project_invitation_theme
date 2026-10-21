import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/editorial_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/audio_player_widget.dart';
import 'package:iv_project_invitation_theme/src/widgets/countdown_timers_grid.dart';
import 'package:iv_project_invitation_theme/src/widgets/double_arrow_slider.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const EditorialCoverPage({
  super.key,
  required final EditorialCoverPageConfig config,
  required final ViewType viewType,
  final File? coverImage,
  required final GeneralResponse general,
  required final BridegroomResponse bride,
  required final BridegroomResponse groom,
  required final EventResponse time,
}) extends StatefulWidget {
  @override
  State<EditorialCoverPage> createState() => _EditorialCoverPageState();
}

class _EditorialCoverPageState() extends State<EditorialCoverPage> {
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
        height: .infinity,
        width: .infinity,
        fit: .cover,
      );
    } else if (widget.viewType == .example && widget.general.coverImageUrl != null) {
      _cachedImage = Image.asset(
        widget.general.coverImageUrl!,
        height: .infinity,
        width: .infinity,
        fit: .cover,
        package: 'iv_project_invitation_theme',
      );
    } else if (widget.general.coverImageUrl != null) {
      _cachedImage = Image.network(
        widget.general.coverImageUrl!,
        height: .infinity,
        width: .infinity,
        fit: .cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, size) => Container(
        height: size.height,
        width: size.width,
        color: widget.config.backgroundColor,
        padding: const .symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            SizedBox(height: H.x2s),
            FadeAndSlideTransition(
              slideFrom: .top,
              slideFromOffset: .3,
              child: Row(
                mainAxisAlignment: .spaceBetween,
                crossAxisAlignment: .center,
                children: [
                  Container(
                    padding: const .symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: widget.config.issueTagBgColor,
                      borderRadius: .circular(2),
                    ),
                    child: Text(
                      'SPECIAL EDITION',
                      style: TextStyle(
                        color: widget.config.issueTagTextColor,
                        fontSize: FontSize.x3s,
                        fontWeight: .w700,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  Text(
                    'THE WEDDING CELEBRATION',
                    style: TextStyle(
                      color: widget.config.subtitleColor,
                      fontSize: FontSize.x3s,
                      fontWeight: .w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: H.x5s),
            FadeAndSlideTransition(
              slideFrom: .top,
              slideFromOffset: .4,
              child: Text(
                '${widget.bride.nickname.toUpperCase()}\n& ${widget.groom.nickname.toUpperCase()}',
                style: TextStyle(
                  color: widget.config.titleColor,
                  fontSize: FontSize.x10l,
                  fontWeight: .w700,
                  height: 1.05,
                  letterSpacing: -.5,
                ),
              ),
            ),
            SizedBox(height: H.x4s),
            Expanded(
              child: FadeAndSlideTransition(
                slideFrom: .bottom,
                slideFromOffset: .2,
                child: Container(
                  width: .infinity,
                  decoration: BoxDecoration(
                    borderRadius: .circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .08),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  clipBehavior: .antiAlias,
                  child: Stack(
                    fit: .expand,
                    children: [
                      if (_cachedImage != null)
                        _cachedImage!
                      else
                        Container(
                          color: Colors.grey.shade300,
                          child: const Center(
                            child: Icon(Icons.favorite, color: Colors.white70, size: 48),
                          ),
                        ),
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: .topCenter,
                              end: .bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: .0),
                                Colors.black.withValues(alpha: .5),
                              ],
                              stops: const [.6, 1],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        left: 12,
                        right: 12,
                        child: Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Text(
                              DateUtil.format(widget.time.startTime, .EEEEddMMMMyyyy),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSize.xs,
                                fontWeight: .w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                            if (widget.viewType == .live && Audio.player.audioSource != null)
                              const AudioPlayerWidget(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: H.x4s),
            FadeAndSlideTransition(
              slideFrom: .bottom,
              slideFromOffset: .3,
              child: CountdownTimersGrid(
                paddingHorizontal: 0,
                time: widget.time.startTime,
                borderWidth: 1,
                oddBorderColor: widget.config.countdownBorderColor,
                evenBorderColor: widget.config.countdownBorderColor,
                numberColor: widget.config.countdownTextColor,
                unitColor: widget.config.countdownLabelColor,
                oddColor: widget.config.countdownBgColor,
                evenColor: widget.config.countdownBgColor,
                noAnimate: false,
                topLeftBorderRadius: .circular(4),
                topRightBorderRadius: .circular(4),
                bottomLeftBorderRadius: .circular(4),
                bottomRightBorderRadius: .circular(4),
              ),
            ),
            SizedBox(height: H.x14s),
            Center(
              child: FadeAndSlideTransition(
                slideFromOffset: 0,
                delayBeforeStart: const Duration(milliseconds: 500),
                child: _buildArrowSlider(),
              ),
            ),
            Center(
              child: FadeAndSlideTransition(
                slideFromOffset: 0,
                delayBeforeStart: const Duration(milliseconds: 500),
                child: _buildSwipeUp(langCode),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwipeUp(String langCode) => Text(
    langCode == 'en' ? 'Swipe up' : 'Geser ke atas',
    style: AppFonts.inter(fontSize: FontSize.xs, color: Colors.grey.shade500),
  );

  Widget _buildArrowSlider() => DoubleArrowSlider(
    firstArrowColor: widget.config.firstArrowColor,
    secondArrowColor: widget.config.secondArrowColor,
    arrowSize: W.lg,
    sliderPathLength: H.x2l,
  );
}

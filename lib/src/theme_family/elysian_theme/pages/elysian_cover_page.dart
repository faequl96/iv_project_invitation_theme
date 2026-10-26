import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/elysian_configs.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/widgets/elysian_reveal.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/widgets/elysian_shimmer_text.dart';
import 'package:iv_project_invitation_theme/src/widgets/countdown_timers_grid.dart';
import 'package:iv_project_invitation_theme/src/widgets/double_arrow_slider.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const ElysianCoverPage({
  super.key,
  required final ElysianCoverPageConfig config,
  required final ViewType viewType,
  final File? coverImage,
  required final GeneralResponse general,
  required final BridegroomResponse bride,
  required final BridegroomResponse groom,
  required final EventResponse time,
}) extends StatefulWidget {
  @override
  State<ElysianCoverPage> createState() => _ElysianCoverPageState();
}

class _ElysianCoverPageState() extends State<ElysianCoverPage> {
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
      builder: (_, size) => SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          alignment: .center,
          children: [
            if (widget.config.coverBackground != null)
              widget.config.coverBackground!
            else if (_cachedImage != null)
              Positioned.fill(child: _cachedImage!),

            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: .topCenter,
                    end: .bottomCenter,
                    colors: [
                      widget.config.gradientBaseColor.withValues(alpha: .2),
                      widget.config.gradientBaseColor.withValues(alpha: .65),
                      widget.config.gradientBaseColor.withValues(alpha: .95),
                    ],
                    stops: const [.2, .65, 1.0],
                  ),
                ),
              ),
            ),

            Positioned(
              left: 20,
              right: 20,
              bottom: 30,
              child: Column(
                mainAxisSize: .min,
                children: [
                  ElysianReveal(
                    delay: const Duration(milliseconds: 100),
                    child: Text(
                      langCode == 'en' ? 'THE WEDDING OF' : 'PERNIKAHAN DARI',
                      style: TextStyle(
                        color: widget.config.goldAccentColor,
                        fontSize: 12,
                        letterSpacing: 4,
                        fontWeight: .w600,
                      ),
                      textAlign: .center,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElysianReveal(
                    delay: const Duration(milliseconds: 250),
                    child: ElysianShimmerText(
                      text: '${widget.bride.nickname} & ${widget.groom.nickname}',
                      baseColor: widget.config.brideNameColor,
                      highlightColor: Colors.white,
                      style: AppFonts.pacifico(
                        fontSize: 44,
                        height: 1.15,
                        color: widget.config.brideNameColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElysianReveal(
                    delay: const Duration(milliseconds: 400),
                    child: Text(
                      DateUtil.format(widget.time.startTime, .EEEEddMMMMyyyy),
                      style: TextStyle(
                        color: widget.config.textColor.withValues(alpha: .9),
                        fontSize: 13,
                        letterSpacing: 2,
                        fontWeight: .w400,
                      ),
                      textAlign: .center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElysianReveal(
                    delay: const Duration(milliseconds: 550),
                    child: CountdownTimersGrid(
                      paddingHorizontal: 16,
                      oddColor: widget.config.countdownCardColor,
                      evenColor: widget.config.countdownCardColor,
                      oddBorderColor: widget.config.countdownBorderColor,
                      evenBorderColor: widget.config.countdownBorderColor,
                      numberColor: widget.config.countdownTextColor,
                      unitColor: widget.config.goldAccentColor,
                      borderWidth: 1.2,
                      time: widget.time.startTime,
                      noAnimate: false,
                      topLeftBorderRadius: const .only(
                        bottomRight: .circular(12),
                        topLeft: .circular(14),
                      ),
                      topRightBorderRadius: const .only(
                        bottomLeft: .circular(12),
                        topRight: .circular(14),
                      ),
                      bottomLeftBorderRadius: const .only(
                        bottomLeft: .circular(14),
                        topRight: .circular(12),
                      ),
                      bottomRightBorderRadius: const .only(
                        bottomRight: .circular(14),
                        topLeft: .circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  ElysianReveal(
                    delay: const Duration(milliseconds: 700),
                    child: DoubleArrowSlider(
                      firstArrowColor: widget.config.goldAccentColor.withValues(alpha: .85),
                      secondArrowColor: widget.config.goldAccentColor.withValues(alpha: .45),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

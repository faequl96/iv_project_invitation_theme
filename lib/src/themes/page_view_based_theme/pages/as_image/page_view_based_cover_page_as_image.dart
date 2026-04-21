import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/page_view_based_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/bride_groom_name.dart';
import 'package:iv_project_invitation_theme/src/widgets/countdown_timers.dart';
import 'package:iv_project_invitation_theme/src/widgets/double_arrow_slider.dart';
import 'package:iv_project_model/iv_project_model.dart';

class PageViewBasedCoverPageAsImage extends StatelessWidget {
  const PageViewBasedCoverPageAsImage({
    super.key,
    required this.config,
    required this.general,
    required this.bride,
    required this.groom,
    required this.time,
    required this.useWrapper,
  });

  final PageViewBasedCoverPageConfig config;
  final GeneralResponse general;
  final BridegroomResponse bride;
  final BridegroomResponse groom;
  final EventResponse time;
  final bool useWrapper;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return Stack(
      children: [
        if (config.coverBackground != null)
          config.coverBackground!
        else if (general.coverImageUrl != null)
          Image.asset(
            general.coverImageUrl!,
            height: Screen.height / 1.2,
            width: Screen.width,
            fit: .cover,
            package: 'iv_project_invitation_theme',
          ),
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
              if (!useWrapper) ...[
                _theWeddingOf(langCode),
                SizedBox(height: H.x9s),
                BridegroomName(
                  brideNameColor: config.brideNameColor,
                  groomNameColor: config.groomNameColor,
                  bride: bride,
                  groom: groom,
                  noAnimate: true,
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
                  noAnimate: true,
                ),
                SizedBox(height: H.x5s),
                _arrowSlider(),
                _swipeUp(langCode),
                SizedBox(height: H.x2s),
              ],
            ],
          ),
        ),
      ],
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
    staticValue: .9,
  );
}

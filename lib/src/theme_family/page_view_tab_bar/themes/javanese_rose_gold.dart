import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/core/theme_colors.dart';
import 'package:iv_project_invitation_theme/src/theme_family/page_view_tab_bar/page_view_tab_bar_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/background_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/foreground_slide_transition.dart';

class JavaneseRoseGold {
  const JavaneseRoseGold._();

  static PageViewTabBarConfigs get configs => PageViewTabBarConfigs(
    tabConfig: PageViewTabBarTabConfig(
      useGlassEffect: false,
      indicatorColor: ThemeColors.gold,
      backgroundColor: Colors.black.withValues(alpha: .5),
      titleActiveColor: ThemeColors.gold,
      titleInactiveColor: ThemeColors.roseGold,
      iconActiveColor: ThemeColors.gold,
      iconInactiveColor: ThemeColors.roseGold,
    ),
    globalBackgroundsBuilder: () => [
      SizedBox(
        width: Screen.width,
        height: Screen.height,
        child: const ColoredBox(color: Color.fromARGB(255, 11, 15, 19)),
      ),
    ],
    coverPageConfig: PageViewTabBarCoverPageConfig(
      coverBackground: const _CoverBackground(),
      gradientBaseColor: Colors.grey.shade900,
      brideNameColor: ThemeColors.roseGold,
      groomNameColor: ThemeColors.gold,
      countdownBorderWidth: 2,
      countdownOddColor: ThemeColors.gold.withValues(alpha: .1),
      countdownEvenColor: ThemeColors.roseGold.withValues(alpha: .1),
      countdownOddBorderColor: ThemeColors.gold,
      countdownEvenBorderColor: ThemeColors.roseGold,
      countdownNumberColor: ThemeColors.gold,
      countdownUnitColor: ThemeColors.roseGold,
      useLightningEffectOnCountdown: false,
      firstArrowColor: ThemeColors.gold.withValues(alpha: .9),
      secondArrowColor: ThemeColors.roseGold.withValues(alpha: .7),
    ),
    firstPageConfig: PageViewTabBarFirstPageConfig(
      foreground: const _PageForeground(),
      background: const _PageBackground(noAnimate: false),
      useBackdropBlurOnScaffold: false,
      firstGradientScaffoldColor: Colors.black.withValues(alpha: .7),
      secondGradientScaffoldColor: Colors.black.withValues(alpha: .7),
      scaffoldBorder: const GradientBoxBorder(
        width: 3,
        gradient: LinearGradient(
          begin: .topLeft,
          end: .bottomRight,
          colors: [ThemeColors.roseGold, ThemeColors.gold, ThemeColors.roseGold, ThemeColors.gold],
          transform: GradientRotation(-.2),
        ),
      ),
      useGlassEffectOnScaffold: false,
      titlePageColor: ThemeColors.gold,
      openingTextColor: Colors.grey.shade100,
      generalTextColor: Colors.grey.shade100,
      firstSubScaffoldColor: Colors.grey.shade500.withValues(alpha: .3),
      firstSubScaffoldBorderColor: ThemeColors.gold,
      firstSubScaffoldBorderWidth: .5,
      secondSubScaffoldColor: Colors.grey.shade500.withValues(alpha: .3),
      secondSubScaffoldBorderColor: ThemeColors.roseGold,
      secondSubScaffoldBorderWidth: .5,
    ),
    secondPageConfig: PageViewTabBarSecondPageConfig(
      foreground: const _PageForeground(),
      background: const _PageBackground(noAnimate: false),
      useBackdropBlurOnScaffold: false,
      firstGradientScaffoldColor: Colors.black.withValues(alpha: .7),
      secondGradientScaffoldColor: Colors.black.withValues(alpha: .7),
      scaffoldBorder: const GradientBoxBorder(
        width: 3,
        gradient: LinearGradient(
          begin: .topLeft,
          end: .bottomRight,
          colors: [ThemeColors.roseGold, ThemeColors.gold, ThemeColors.roseGold, ThemeColors.gold],
          transform: GradientRotation(-0.2),
        ),
      ),
      useGlassEffectOnScaffold: false,
      titlePageColor: ThemeColors.gold,
      generalTextColor: Colors.grey.shade200,
      brideDividingBorderWidth: .5,
      brideImageBorderWidth: .5,
      brideDividingLineWidth: .5,
      brideDividingBorderColor: Colors.grey.shade300,
      brideImageFrameColor: Colors.grey.shade500.withValues(alpha: .4),
      brideImageFrameBorderColor: Colors.grey.shade500.withValues(alpha: .4),
      brideDividingLineColor: Colors.grey.shade300,
      brideNameTextColor: ThemeColors.roseGold,
      brideFatherNameTextColor: ThemeColors.gold,
      brideMotherNameTextColor: ThemeColors.roseGold,
      groomDividingBorderWidth: .5,
      groomImageBorderWidth: .5,
      groomDividingLineWidth: .5,
      groomDividingBorderColor: Colors.grey.shade300,
      groomImageFrameColor: Colors.grey.shade500.withValues(alpha: .4),
      groomImageFrameBorderColor: Colors.grey.shade500.withValues(alpha: .4),
      groomDividingLineColor: Colors.grey.shade300,
      groomNameTextColor: ThemeColors.gold,
      groomFatherNameTextColor: ThemeColors.gold,
      groomMotherNameTextColor: ThemeColors.roseGold,
    ),
    thirdPageConfig: PageViewTabBarThirdPageConfig(
      foreground: const _PageForeground(),
      background: const _PageBackground(noAnimate: false),
      useBackdropBlurOnScaffold: false,
      firstGradientScaffoldColor: Colors.black.withValues(alpha: .7),
      secondGradientScaffoldColor: Colors.black.withValues(alpha: .7),
      scaffoldBorder: const GradientBoxBorder(
        width: 3,
        gradient: LinearGradient(
          begin: .topLeft,
          end: .bottomRight,
          colors: [ThemeColors.roseGold, ThemeColors.gold, ThemeColors.roseGold, ThemeColors.gold],
          transform: GradientRotation(-0.2),
        ),
      ),
      useGlassEffectOnScaffold: false,
      titlePageColor: ThemeColors.gold,
      contractTitleColor: ThemeColors.gold,
      contractBaseTextColor: Colors.grey.shade100,
      receptionTitleColor: ThemeColors.roseGold,
      receptionBaseTextColor: Colors.grey.shade100,
      dividingLineWidth: 1,
      dividingLineColor: ThemeColors.gold,
      contractCountdownBorderWidth: .5,
      contractCountdownOddColor: Colors.grey.shade500.withValues(alpha: .3),
      contractCountdownEvenColor: Colors.grey.shade500.withValues(alpha: .3),
      contractCountdownOddBorderColor: ThemeColors.gold,
      contractCountdownEvenBorderColor: ThemeColors.roseGold,
      contractCountdownNumberColor: ThemeColors.gold,
      contractCountdownUnitColor: ThemeColors.roseGold,
      receptionCountdownBorderWidth: .5,
      receptionCountdownOddColor: Colors.grey.shade500.withValues(alpha: .3),
      receptionCountdownEvenColor: Colors.grey.shade500.withValues(alpha: .3),
      receptionCountdownOddBorderColor: ThemeColors.gold,
      receptionCountdownEvenBorderColor: ThemeColors.roseGold,
      receptionCountdownNumberColor: ThemeColors.gold,
      receptionCountdownUnitColor: ThemeColors.roseGold,
      useLightningEffectOnCountdown: false,
    ),
    thirdDifferentLocationPageConfig: PageViewTabBarThirdDifferentLocationPageConfig(
      foreground: const _PageForeground(),
      background: const _PageBackground(noAnimate: false),
      useBackdropBlurOnScaffold: false,
      firstGradientScaffoldColor: Colors.black.withValues(alpha: .7),
      secondGradientScaffoldColor: Colors.black.withValues(alpha: .7),
      scaffoldBorder: const GradientBoxBorder(
        width: 3,
        gradient: LinearGradient(
          begin: .topLeft,
          end: .bottomRight,
          colors: [ThemeColors.roseGold, ThemeColors.gold, ThemeColors.roseGold, ThemeColors.gold],
          transform: GradientRotation(-0.2),
        ),
      ),
      useGlassEffectOnScaffold: false,
      titlePageColor: ThemeColors.gold,
      dateTimeIconColor: ThemeColors.gold,
      dateTimeBaseTextColor: Colors.grey.shade100,
      countdownBorderWidth: .5,
      countdownOddColor: Colors.grey.shade500.withValues(alpha: .3),
      countdownEvenColor: Colors.grey.shade500.withValues(alpha: .3),
      countdownOddBorderColor: ThemeColors.gold,
      countdownEvenBorderColor: ThemeColors.roseGold,
      countdownNumberColor: ThemeColors.gold,
      countdownUnitColor: ThemeColors.roseGold,
      useLightningEffectOnCountdown: false,
      dividingLineWidth: 1,
      dividingLineColor: ThemeColors.gold,
      placeIconColor: ThemeColors.gold,
      placeBaseTextColor: Colors.grey.shade100,
      addressTextColor: Colors.grey.shade50,
      mapsBorderColor: Colors.grey.shade400,
      getDirectionsButtonColor: Colors.grey.shade500.withValues(alpha: .3),
      getDirectionsButtonLabelColor: ThemeColors.gold,
      getDirectionsButtonBorderWidth: 1,
      getDirectionsButtonBorderColor: ThemeColors.gold,
    ),
    fourthPageConfig: PageViewTabBarFourthPageConfig(
      foreground: const _PageForeground(),
      background: const _PageBackground(noAnimate: false),
      useBackdropBlurOnScaffold: false,
      firstGradientScaffoldColor: Colors.black.withValues(alpha: .7),
      secondGradientScaffoldColor: Colors.black.withValues(alpha: .7),
      scaffoldBorder: const GradientBoxBorder(
        width: 3,
        gradient: LinearGradient(
          begin: .topLeft,
          end: .bottomRight,
          colors: [ThemeColors.roseGold, ThemeColors.gold, ThemeColors.roseGold, ThemeColors.gold],
          transform: GradientRotation(-0.2),
        ),
      ),
      useGlassEffectOnScaffold: false,
      titlePageColor: ThemeColors.gold,
      placeIconColor: ThemeColors.gold,
      placeTextColor: ThemeColors.roseGold,
      addressTextColor: Colors.grey.shade50,
      dividingLineWidth: 1,
      dividingLineColor: ThemeColors.gold,
      mapsBorderColor: Colors.grey.shade400,
      getDirectionsButtonColor: Colors.grey.shade500.withValues(alpha: .3),
      getDirectionsButtonLabelColor: ThemeColors.gold,
      getDirectionsButtonBorderWidth: 1,
      getDirectionsButtonBorderColor: ThemeColors.gold,
    ),
    fourthDifferentLocationPageConfig: PageViewTabBarFourthDifferentLocationPageConfig(
      foreground: const _PageForeground(),
      background: const _PageBackground(noAnimate: false),
      useBackdropBlurOnScaffold: false,
      firstGradientScaffoldColor: Colors.black.withValues(alpha: .7),
      secondGradientScaffoldColor: Colors.black.withValues(alpha: .7),
      scaffoldBorder: const GradientBoxBorder(
        width: 3,
        gradient: LinearGradient(
          begin: .topLeft,
          end: .bottomRight,
          colors: [ThemeColors.roseGold, ThemeColors.gold, ThemeColors.roseGold, ThemeColors.gold],
          transform: GradientRotation(-0.2),
        ),
      ),
      useGlassEffectOnScaffold: false,
      titlePageColor: ThemeColors.gold,
      dateTimeIconColor: ThemeColors.gold,
      dateTimeBaseTextColor: Colors.grey.shade100,
      countdownBorderWidth: .5,
      countdownOddColor: Colors.grey.shade500.withValues(alpha: .3),
      countdownEvenColor: Colors.grey.shade500.withValues(alpha: .3),
      countdownOddBorderColor: ThemeColors.gold,
      countdownEvenBorderColor: ThemeColors.roseGold,
      countdownNumberColor: ThemeColors.gold,
      countdownUnitColor: ThemeColors.roseGold,
      useLightningEffectOnCountdown: false,
      dividingLineWidth: 1,
      dividingLineColor: ThemeColors.gold,
      placeIconColor: ThemeColors.gold,
      placeBaseTextColor: Colors.grey.shade100,
      addressTextColor: Colors.grey.shade50,
      mapsBorderColor: Colors.grey.shade400,
      getDirectionsButtonColor: Colors.grey.shade500.withValues(alpha: .3),
      getDirectionsButtonLabelColor: ThemeColors.gold,
      getDirectionsButtonBorderWidth: 1,
      getDirectionsButtonBorderColor: ThemeColors.gold,
    ),
    fifthPageConfig: PageViewTabBarFifthPageConfig(
      foreground: const _PageForeground(),
      background: const _PageBackground(noAnimate: false),
      useBackdropBlurOnScaffold: false,
      firstGradientScaffoldColor: Colors.black.withValues(alpha: .7),
      secondGradientScaffoldColor: Colors.black.withValues(alpha: .7),
      scaffoldBorder: const GradientBoxBorder(
        width: 3,
        gradient: LinearGradient(
          begin: .topLeft,
          end: .bottomRight,
          colors: [ThemeColors.roseGold, ThemeColors.gold, ThemeColors.roseGold, ThemeColors.gold],
          transform: GradientRotation(-0.2),
        ),
      ),
      useGlassEffectOnScaffold: false,
      titlePageColor: ThemeColors.gold,
      dividingLineWidth: .5,
      dividingVerticalLineColor: Colors.grey.shade100,
      dividingHorizontalLineColor: Colors.grey.shade100,
      seeMoreButtonColor: Colors.grey.shade500.withValues(alpha: .3),
      seeMoreButtonLabelColor: ThemeColors.gold,
      seeMoreButtonBorderWidth: 1,
      seeMoreButtonBorderColor: ThemeColors.gold,
      bottomSheetHandleColor: ThemeColors.gold,
      bottomSheetContentScaffoldColor: Colors.grey.shade500.withValues(alpha: .3),
      bottomSheetBackgroundColor: Colors.black.withValues(alpha: .85),
      bottomSheetCloseIconColor: Colors.grey.shade400,
    ),
    sixthPageConfig: PageViewTabBarSixthPageConfig(
      foreground: const _PageForeground(),
      background: const _PageBackground(noAnimate: false),
      useBackdropBlurOnScaffold: false,
      firstGradientScaffoldColor: Colors.black.withValues(alpha: .7),
      secondGradientScaffoldColor: Colors.black.withValues(alpha: .7),
      scaffoldBorder: const GradientBoxBorder(
        width: 3,
        gradient: LinearGradient(
          begin: .topLeft,
          end: .bottomRight,
          colors: [ThemeColors.roseGold, ThemeColors.gold, ThemeColors.roseGold, ThemeColors.gold],
          transform: GradientRotation(-0.2),
        ),
      ),
      useGlassEffectOnScaffold: false,
      titlePageColor: ThemeColors.gold,
      introductionTextColor: Colors.grey.shade100,
      introductionColor: Colors.grey.shade500.withValues(alpha: .3),
      introductionBorderColor: ThemeColors.gold,
      introductionBorderWidth: .5,
      bankColor: Colors.grey.shade500.withValues(alpha: .3),
      bankBorderColor: ThemeColors.roseGold,
      bankBorderWidth: .5,
      bankTextColor: Colors.grey.shade100,
      bankCopyBaseColor: Colors.grey.shade400,
    ),
    seventhPageConfig: PageViewTabBarSeventhPageConfig(
      foreground: const _PageForeground(),
      background: const _PageBackground(noAnimate: false),
      useBackdropBlurOnScaffold: false,
      firstGradientScaffoldColor: Colors.black.withValues(alpha: .7),
      secondGradientScaffoldColor: Colors.black.withValues(alpha: .7),
      scaffoldBorder: const GradientBoxBorder(
        width: 3,
        gradient: LinearGradient(
          begin: .topLeft,
          end: .bottomRight,
          colors: [ThemeColors.roseGold, ThemeColors.gold, ThemeColors.roseGold, ThemeColors.gold],
          transform: GradientRotation(-0.2),
        ),
      ),
      useGlassEffectOnScaffold: false,
      titlePageColor: ThemeColors.gold,
      fieldTextColor: Colors.grey.shade100,
      fieldLabelColor: Colors.grey.shade300,
      fieldFillColor: Colors.grey.shade500.withValues(alpha: .3),
      fieldBorderColor: Colors.grey.shade600,
      fieldSplashColor: Colors.grey.shade700,
      overlayColor: Colors.grey.shade700.withValues(alpha: .95),
      overlayBorderColor: Colors.grey.shade500,
      dropdownItemSelectedColor: Colors.grey.shade500,
      dropdownItemTextColor: Colors.grey.shade100,
      dropdownItemSelectedTextColor: Colors.grey.shade100,
      // dropdownItemHoveredColor: Colors.grey.shade400,
      // dropdownItemSplashColor: Colors.grey.shade400,
      submitButtonColor: Colors.grey.shade500.withValues(alpha: .3),
      submitButtonLabelColor: ThemeColors.gold,
      submitButtonBorderWidth: 1,
      submitButtonBorderColor: ThemeColors.gold,
      rsvpBackgroundColor: Colors.grey.shade500.withValues(alpha: .3),
      rsvpBorderColor: Colors.grey.shade500,
      rsvpNameTextColor: Colors.grey.shade100,
      rsvpTimeAgoTextColor: Colors.grey.shade400,
      rsvpNameInstanceTextColor: Colors.grey.shade400,
      rsvpAttendanceTextColorLighten: 50,
      rsvpMessageTextColor: Colors.grey.shade200,
      seeMoreButtonColor: Colors.grey.shade900.withValues(alpha: .8),
      seeMoreButtonLabelColor: ThemeColors.roseGold,
      seeMoreButtonBorderWidth: 1,
      seeMoreButtonBorderColor: ThemeColors.roseGold,
      bottomSheetHandleColor: ThemeColors.gold,
      bottomSheetContentScaffoldColor: Colors.grey.shade500.withValues(alpha: .3),
      bottomSheetBackgroundColor: Colors.black.withValues(alpha: .85),
      bottomSheetCloseIconColor: Colors.grey.shade400,
    ),
    eighthPageConfig: PageViewTabBarEighthPageConfig(
      foreground: const _PageForeground(),
      background: const _PageBackground(noAnimate: false),
      useBackdropBlurOnScaffold: false,
      firstGradientScaffoldColor: Colors.black.withValues(alpha: .7),
      secondGradientScaffoldColor: Colors.black.withValues(alpha: .7),
      scaffoldBorder: const GradientBoxBorder(
        width: 3,
        gradient: LinearGradient(
          begin: .topLeft,
          end: .bottomRight,
          colors: [ThemeColors.roseGold, ThemeColors.gold, ThemeColors.roseGold, ThemeColors.gold],
          transform: GradientRotation(-0.2),
        ),
      ),
      useGlassEffectOnScaffold: false,
      titlePageColor: ThemeColors.gold,
      closingTextColor: Colors.grey.shade100,
      brideGroomNameColor: ThemeColors.gold,
      brandBackgroundColor: Colors.grey.shade800.withValues(alpha: .6),
      brandTextColor: Colors.grey.shade50,
    ),
  );

  static ThemeData? get themeData => null;
}

class _CoverBackground extends StatelessWidget {
  const _CoverBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(width: Screen.width, height: Screen.height),
        Positioned(
          left: 0,
          width: Screen.width / 2,
          height: Screen.height,
          child: Image.asset(
            'assets/backgrounds/batik_1_left.jpg',
            fit: .fitHeight,
            alignment: .centerRight,
            package: 'iv_project_invitation_theme',
          ),
        ),
        Positioned(
          right: 0,
          width: Screen.width / 2,
          height: Screen.height,
          child: Image.asset(
            'assets/backgrounds/batik_1_right.jpg',
            fit: .fitHeight,
            alignment: .centerLeft,
            package: 'iv_project_invitation_theme',
          ),
        ),
        Positioned(
          left: 0,
          width: Screen.width / 2,
          child: Stack(
            clipBehavior: .none,
            alignment: .center,
            children: [
              SizedBox(width: Screen.width / 2, height: Screen.height),
              Positioned(
                bottom: H.x20l,
                right: -W.x2s,
                width: W.x11l,
                child: Image.asset(
                  'assets/backgrounds/kelir_jawa_rose_gold.png',
                  width: W.x11l,
                  fit: .fitWidth,
                  package: 'iv_project_invitation_theme',
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          width: Screen.width / 2,
          child: Stack(
            clipBehavior: .none,
            alignment: .center,
            children: [
              SizedBox(width: Screen.width / 2, height: Screen.height),
              Positioned(
                bottom: H.x20l,
                left: -W.x2s,
                width: W.x11l,
                child: Image.asset(
                  'assets/backgrounds/kelir_jawa_gold.png',
                  width: W.x11l,
                  fit: .fitWidth,
                  package: 'iv_project_invitation_theme',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PageBackground extends StatelessWidget {
  const _PageBackground({required this.noAnimate});

  final bool noAnimate;

  final Duration animationSpeed = const Duration(milliseconds: 1200);
  final Duration delayedBeforeStart = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    if (noAnimate) {
      return Stack(
        children: [
          SizedBox(width: Screen.width, height: Screen.height),
          Positioned(
            left: 0,
            width: Screen.width / 2,
            height: Screen.height,
            child: Image.asset(
              'assets/backgrounds/batik_1_left.jpg',
              fit: .fitHeight,
              alignment: .centerRight,
              package: 'iv_project_invitation_theme',
            ),
          ),
          Positioned(
            right: 0,
            width: Screen.width / 2,
            height: Screen.height,
            child: Image.asset(
              'assets/backgrounds/batik_1_right.jpg',
              fit: .fitHeight,
              alignment: .centerLeft,
              package: 'iv_project_invitation_theme',
            ),
          ),
          Positioned(
            left: 0,
            width: Screen.width / 2,
            child: Stack(
              clipBehavior: .none,
              alignment: .center,
              children: [
                SizedBox(width: Screen.width / 2, height: Screen.height),
                Positioned(
                  right: -W.x2s,
                  width: W.x11l,
                  child: Image.asset(
                    'assets/backgrounds/kelir_jawa_rose_gold.png',
                    width: W.x11l,
                    fit: .fitWidth,
                    package: 'iv_project_invitation_theme',
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            width: Screen.width / 2,
            child: Stack(
              clipBehavior: .none,
              alignment: .center,
              children: [
                SizedBox(width: Screen.width / 2, height: Screen.height),
                Positioned(
                  left: -W.x2s,
                  width: W.x11l,
                  child: Image.asset(
                    'assets/backgrounds/kelir_jawa_gold.png',
                    width: W.x11l,
                    fit: .fitWidth,
                    package: 'iv_project_invitation_theme',
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Stack(
      children: [
        SizedBox(width: Screen.width, height: Screen.height),
        Positioned(
          left: 0,
          width: Screen.width / 2,
          height: Screen.height,
          child: BackgroundSlideTransition(
            animationSpeed: animationSpeed,
            delayedBeforeStart: delayedBeforeStart,
            slideFrom: .left,
            child: Image.asset(
              'assets/backgrounds/batik_1_left.jpg',
              fit: .fitHeight,
              alignment: .centerRight,
              package: 'iv_project_invitation_theme',
            ),
          ),
        ),
        Positioned(
          right: 0,
          width: Screen.width / 2,
          height: Screen.height,
          child: BackgroundSlideTransition(
            animationSpeed: animationSpeed,
            delayedBeforeStart: delayedBeforeStart,
            slideFrom: .right,
            child: Image.asset(
              'assets/backgrounds/batik_1_right.jpg',
              fit: .fitHeight,
              alignment: .centerLeft,
              package: 'iv_project_invitation_theme',
            ),
          ),
        ),
        Positioned(
          left: 0,
          width: Screen.width / 2,
          child: BackgroundSlideTransition(
            animationSpeed: animationSpeed,
            delayedBeforeStart: delayedBeforeStart,
            slideFrom: .left,
            child: Stack(
              clipBehavior: .none,
              alignment: .center,
              children: [
                SizedBox(width: Screen.width / 2, height: Screen.height),
                Positioned(
                  right: -W.x2s,
                  width: W.x11l,
                  child: Image.asset(
                    'assets/backgrounds/kelir_jawa_rose_gold.png',
                    width: W.x11l,
                    fit: .fitWidth,
                    package: 'iv_project_invitation_theme',
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          width: Screen.width / 2,
          child: BackgroundSlideTransition(
            animationSpeed: animationSpeed,
            delayedBeforeStart: delayedBeforeStart,
            slideFrom: .right,
            child: Stack(
              clipBehavior: .none,
              alignment: .center,
              children: [
                SizedBox(width: Screen.width / 2, height: Screen.height),
                Positioned(
                  left: -W.x2s,
                  width: W.x11l,
                  child: Image.asset(
                    'assets/backgrounds/kelir_jawa_gold.png',
                    width: W.x11l,
                    fit: .fitWidth,
                    package: 'iv_project_invitation_theme',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PageForeground extends StatelessWidget {
  const _PageForeground();

  final Duration animationSpeed = const Duration(milliseconds: 1200);
  final Duration delayedBeforeStart = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(width: Screen.width, height: Screen.height),
        Positioned(
          left: -Screen.width / 2,
          width: Screen.width / 2,
          height: Screen.height,
          child: ForegroundSlideTransition(
            animationSpeed: animationSpeed,
            delayedBeforeStart: delayedBeforeStart,
            slideFrom: .right,
            child: Image.asset(
              'assets/backgrounds/batik_1_left.jpg',
              fit: .fitHeight,
              alignment: .centerRight,
              package: 'iv_project_invitation_theme',
            ),
          ),
        ),
        Positioned(
          right: -Screen.width / 2,
          width: Screen.width / 2,
          height: Screen.height,
          child: ForegroundSlideTransition(
            animationSpeed: animationSpeed,
            delayedBeforeStart: delayedBeforeStart,
            slideFrom: .left,
            child: Image.asset(
              'assets/backgrounds/batik_1_right.jpg',
              fit: .fitHeight,
              alignment: .centerLeft,
              package: 'iv_project_invitation_theme',
            ),
          ),
        ),
        Positioned(
          left: -Screen.width / 2,
          width: Screen.width / 2,
          child: ForegroundSlideTransition(
            animationSpeed: animationSpeed,
            delayedBeforeStart: delayedBeforeStart,
            slideFrom: .right,
            child: Stack(
              clipBehavior: .none,
              alignment: .center,
              children: [
                SizedBox(width: Screen.width / 2, height: Screen.height),
                Positioned(
                  right: -W.x2s,
                  width: W.x11l,
                  child: Image.asset(
                    'assets/backgrounds/kelir_jawa_rose_gold.png',
                    width: W.x11l,
                    fit: .fitWidth,
                    package: 'iv_project_invitation_theme',
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: -Screen.width / 2,
          width: Screen.width / 2,
          child: ForegroundSlideTransition(
            animationSpeed: animationSpeed,
            delayedBeforeStart: delayedBeforeStart,
            slideFrom: .left,
            child: Stack(
              clipBehavior: .none,
              alignment: .center,
              children: [
                SizedBox(width: Screen.width / 2, height: Screen.height),
                Positioned(
                  left: -W.x2s,
                  width: W.x11l,
                  child: Image.asset(
                    'assets/backgrounds/kelir_jawa_gold.png',
                    width: W.x11l,
                    fit: .fitWidth,
                    package: 'iv_project_invitation_theme',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

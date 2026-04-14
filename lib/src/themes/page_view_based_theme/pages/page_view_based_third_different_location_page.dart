import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/widgets/countdown_timers.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_invitation_theme/src/widgets/maps.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';
import 'package:url_launcher/url_launcher.dart';

class PageViewBasedThirdDifferentLocationPageConfig {
  const PageViewBasedThirdDifferentLocationPageConfig({
    this.foreground,
    this.background,
    required this.useBackdropBlurOnScaffold,
    required this.firstGradientScaffoldColor,
    required this.secondGradientScaffoldColor,
    this.stopsGradientScaffoldColor,
    required this.scaffoldBorder,
    required this.useGlassEffectOnScaffold,
    this.glassEffectOpacity = .4,
    this.firstGradientBackgroundColor,
    this.secondGradientBackgroundColor,
    required this.titlePageColor,
    required this.dateTimeIconColor,
    required this.dateTimeBaseTextColor,
    required this.countdownBorderWidth,
    required this.countdownOddColor,
    required this.countdownEvenColor,
    required this.countdownOddBorderColor,
    required this.countdownEvenBorderColor,
    required this.countdownNumberColor,
    required this.countdownUnitColor,
    required this.useLightningEffectOnCountdown,
    required this.dividingLineWidth,
    required this.dividingLineColor,
    required this.placeIconColor,
    required this.placeBaseTextColor,
    required this.addressTextColor,
    required this.mapsBorderColor,
    required this.getDirectionsButtonColor,
    required this.getDirectionsButtonLabelColor,
    required this.getDirectionsButtonBorderWidth,
    required this.getDirectionsButtonBorderColor,
  });

  final Widget? foreground;
  final Widget? background;
  final bool useBackdropBlurOnScaffold;
  final Color firstGradientScaffoldColor;
  final Color secondGradientScaffoldColor;
  final List<double>? stopsGradientScaffoldColor;
  final BoxBorder scaffoldBorder;
  final bool useGlassEffectOnScaffold;
  final double glassEffectOpacity;
  final Color? firstGradientBackgroundColor;
  final Color? secondGradientBackgroundColor;
  final Color titlePageColor;
  final Color dateTimeIconColor;
  final Color dateTimeBaseTextColor;
  final double countdownBorderWidth;
  final Color countdownOddColor;
  final Color countdownEvenColor;
  final Color countdownOddBorderColor;
  final Color countdownEvenBorderColor;
  final Color countdownNumberColor;
  final Color countdownUnitColor;
  final bool useLightningEffectOnCountdown;
  final double dividingLineWidth;
  final Color dividingLineColor;
  final Color placeIconColor;
  final Color placeBaseTextColor;
  final Color addressTextColor;
  final Color mapsBorderColor;
  final Color getDirectionsButtonColor;
  final Color getDirectionsButtonLabelColor;
  final double getDirectionsButtonBorderWidth;
  final Color getDirectionsButtonBorderColor;
}

class PageViewBasedThirdDifferentLocationPage extends StatelessWidget {
  const PageViewBasedThirdDifferentLocationPage({
    super.key,
    required this.config,
    required this.contractEvent,
    required this.noAnimate,
  });

  final PageViewBasedThirdDifferentLocationPageConfig config;
  final EventResponse contractEvent;
  final bool noAnimate;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          if (config.firstGradientBackgroundColor != null && config.secondGradientBackgroundColor != null)
            Positioned(
              bottom: 0,
              height: Screen.height / 1.2,
              width: Screen.width,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: .topCenter,
                    end: .bottomCenter,
                    colors: [config.firstGradientBackgroundColor!, config.secondGradientBackgroundColor!],
                    stops: const [.2, .8],
                  ),
                ),
              ),
            ),

          config.background ?? const SizedBox.shrink(),

          Positioned(
            top: 0,
            child: FadeAndSlideTransition(
              slideFromOffset: .5,
              slideFrom: .top,
              child: SizedBox(
                height: H.x6l,
                width: Screen.width,
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    Icon(Icons.volunteer_activism, size: W.xs, color: config.titlePageColor),
                    const SizedBox(width: 10),
                    Text(
                      langCode == 'en' ? 'Marriage Contract' : 'Akad Nikah',
                      style: AppFonts.inter(color: config.titlePageColor, fontSize: FontSize.x3l, fontWeight: .w700),
                    ),
                    const SizedBox(width: 10),
                    Icon(Icons.menu_book, size: W.xs, color: config.titlePageColor),
                  ],
                ),
              ),
            ),
          ),
          if (config.useBackdropBlurOnScaffold)
            Positioned(
              bottom: 0,
              height: Screen.height,
              width: Screen.width,
              child: Padding(
                padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76),
                child: RepaintBoundary(
                  child: ClipRRect(
                    borderRadius: .circular(20),
                    child: BackdropFilter(
                      filter: .blur(sigmaX: 3, sigmaY: 3),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: .circular(20),
                          gradient: LinearGradient(
                            begin: .topCenter,
                            end: .bottomCenter,
                            colors: [config.firstGradientScaffoldColor, config.secondGradientScaffoldColor],
                            stops: config.stopsGradientScaffoldColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          else
            Positioned(
              bottom: 0,
              height: Screen.height,
              width: Screen.width,
              child: Padding(
                padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: .circular(20),
                    gradient: LinearGradient(
                      begin: .topCenter,
                      end: .bottomCenter,
                      colors: [config.firstGradientScaffoldColor, config.secondGradientScaffoldColor],
                      stops: config.stopsGradientScaffoldColor,
                    ),
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            height: Screen.height,
            width: Screen.width,
            child: Padding(
              padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76),
              child: DecoratedBox(
                decoration: BoxDecoration(borderRadius: .circular(20), border: config.scaffoldBorder),
                child: ClipRect(
                  child: Column(
                    children: [
                      const Spacer(),
                      Column(
                        mainAxisSize: .min,
                        children: [
                          FadeAndSlideTransition(
                            slideFromOffset: .0,
                            slideFrom: .bottom,
                            delayBeforeStart: const Duration(milliseconds: 500),
                            child: Column(
                              children: [
                                Icon(Icons.event, size: 32, color: config.dateTimeIconColor),
                                const SizedBox(height: 4),
                                Text(
                                  DateUtil.format(contractEvent.startTime, .EEEEddMMMMyyyy),
                                  style: AppFonts.inter(
                                    color: config.dateTimeBaseTextColor,
                                    fontSize: FontSize.lg,
                                    fontWeight: .w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: H.x14s),
                          FadeAndSlideTransition(
                            slideFromOffset: .8,
                            slideFrom: .bottom,
                            animationSpeed: const Duration(milliseconds: 300),
                            delayBeforeStart: const Duration(milliseconds: 800),
                            child: Text(
                              langCode == 'en'
                                  ? '${DateUtil.format(contractEvent.startTime, .HHmm)} o\'clock WIB - ${contractEvent.endTime == null ? 'Finished' : '${DateUtil.format(contractEvent.endTime!, .HHmm)} o\'clock WIB'}'
                                  : 'Pukul ${DateUtil.format(contractEvent.startTime, .HHmm)} WIB - ${contractEvent.endTime == null ? 'Selesai' : 'Pukul ${DateUtil.format(contractEvent.endTime!, .HHmm)} WIB'}',
                              style: AppFonts.inter(
                                color: config.dateTimeBaseTextColor,
                                fontSize: FontSize.md,
                                fontWeight: .w300,
                              ),
                            ),
                          ),
                          SizedBox(height: H.x6s),
                          SizedBox(
                            height: W.x3l,
                            child: CountdownTimers(
                              oddColor: config.countdownOddColor,
                              evenColor: config.countdownEvenColor,
                              oddBorderColor: config.countdownOddBorderColor,
                              evenBorderColor: config.countdownEvenBorderColor,
                              numberColor: config.countdownNumberColor,
                              unitColor: config.countdownUnitColor,
                              borderWidth: config.countdownBorderWidth,
                              useLightningEffect: config.useLightningEffectOnCountdown,
                              time: contractEvent.startTime,
                              animationDelayBeforeStart: const Duration(milliseconds: 800),
                              lightningEffectDelayBeforeShowed: const Duration(milliseconds: 1800),
                              noAnimate: noAnimate,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: H.x4s),
                      FadeAndSlideTransition(
                        slideFromOffset: .0,
                        delayBeforeStart: const Duration(milliseconds: 1400),
                        child: SizedBox(
                          height: config.dividingLineWidth,
                          width: W.x18l,
                          child: ColoredBox(color: config.dividingLineColor),
                        ),
                      ),
                      SizedBox(height: H.x4s),
                      FadeAndSlideTransition(
                        slideFromOffset: .0,
                        slideFrom: .top,
                        delayBeforeStart: const Duration(milliseconds: 500),
                        child: Column(
                          children: [
                            Icon(Icons.location_pin, size: 32, color: config.placeIconColor),
                            const SizedBox(height: 3),
                            Text(
                              contractEvent.place,
                              style: AppFonts.inter(color: config.placeBaseTextColor, fontSize: FontSize.lg, fontWeight: .w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: H.x10s),
                      FadeAndSlideTransition(
                        slideFromOffset: .8,
                        slideFrom: .bottom,
                        animationSpeed: const Duration(milliseconds: 300),
                        delayBeforeStart: const Duration(milliseconds: 800),
                        child: Padding(
                          padding: const .symmetric(horizontal: 20),
                          child: Text(
                            contractEvent.address,
                            style: AppFonts.inter(
                              color: config.addressTextColor,
                              fontSize: FontSize.xs,
                              fontWeight: .w400,
                              height: 1.3,
                            ),
                            textAlign: .center,
                          ),
                        ),
                      ),
                      SizedBox(height: H.x6s),
                      FadeAndSlideTransition(
                        slideFrom: .bottom,
                        delayBeforeStart: const Duration(milliseconds: 1100),
                        child: Maps(
                          borderColor: config.mapsBorderColor,
                          width: Screen.width - (W.x6s * 5),
                          height: Screen.height - (H.x18l * 2.1),
                          delayBeforeStart: const Duration(milliseconds: 2200),
                          url: contractEvent.mapsUrl,
                        ),
                      ),
                      SizedBox(height: H.x6s),
                      FadeAndSlideTransition(
                        slideFromOffset: .8,
                        slideFrom: .bottom,
                        animationSpeed: const Duration(milliseconds: 300),
                        delayBeforeStart: const Duration(milliseconds: 1800),
                        child: GeneralEffectsButton(
                          onTap: () => launchUrl(Uri.parse(contractEvent.mapsUrl), mode: .externalNonBrowserApplication),
                          padding: const .symmetric(horizontal: 24),
                          height: W.lg + H.x10s,
                          borderRadius: .circular(30),
                          border: .all(
                            width: config.getDirectionsButtonBorderWidth,
                            color: config.getDirectionsButtonBorderColor,
                          ),
                          color: config.getDirectionsButtonColor,
                          child: Stack(
                            alignment: .center,
                            children: [
                              Text(
                                langCode == 'en' ? 'Get Directions' : 'Dapatkan Petunjuk Arah',
                                style: AppFonts.inter(
                                  color: config.getDirectionsButtonLabelColor,
                                  fontSize: FontSize.md,
                                  fontWeight: .w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: Screen.height,
            width: Screen.width,
            child: Padding(
              padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76),
              child: GlassEffectBox(
                width: Screen.width - 32,
                height: Screen.height - (76 + H.x6l),
                borderRadius: 20,
                sliderWidth: 90,
                color: Colors.white.withValues(alpha: config.glassEffectOpacity),
                animationSpeed: const Duration(milliseconds: 600),
                delayBeforeStart: const Duration(milliseconds: 2200),
                animationInterval: const Duration(milliseconds: 3500),
              ),
            ),
          ),

          config.foreground ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}

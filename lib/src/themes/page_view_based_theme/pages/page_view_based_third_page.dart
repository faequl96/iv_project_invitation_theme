import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/widgets/countdown_timers.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_model/iv_project_model.dart';

class PageViewBasedThirdPageConfig {
  const PageViewBasedThirdPageConfig({
    this.frontground,
    this.background,
    required this.useBackdropBlurOnScaffold,
    required this.scaffoldColor,
    required this.scaffoldBorder,
    required this.useGlassEffectOnScaffold,
    this.firstGradientBackgroundColor,
    this.secondGradientBackgroundColor,
    required this.titlePageColor,
    required this.contractTitleColor,
    required this.receptionTitleColor,
    required this.dividingLineWidth,
    required this.dividingLineColor,
    required this.countdownBorderWidth,
    required this.countdownOddColor,
    required this.countdownEvenColor,
    required this.countdownOddBorderColor,
    required this.countdownEvenBorderColor,
    required this.countdownNumberColor,
    required this.countdownUnitColor,
    required this.useLightningEffectOnCountdown,
  });

  final Widget? frontground;
  final Widget? background;
  final bool useBackdropBlurOnScaffold;
  final Color scaffoldColor;
  final BoxBorder scaffoldBorder;
  final bool useGlassEffectOnScaffold;
  final Color? firstGradientBackgroundColor;
  final Color? secondGradientBackgroundColor;
  final Color titlePageColor;
  final Color contractTitleColor;
  final Color receptionTitleColor;
  final double dividingLineWidth;
  final Color dividingLineColor;
  final double countdownBorderWidth;
  final Color countdownOddColor;
  final Color countdownEvenColor;
  final Color countdownOddBorderColor;
  final Color countdownEvenBorderColor;
  final Color countdownNumberColor;
  final Color countdownUnitColor;
  final bool useLightningEffectOnCountdown;
}

class PageViewBasedThirdPage extends StatelessWidget {
  const PageViewBasedThirdPage({super.key, required this.config, required this.contractEvent, required this.receptionEvent});

  final PageViewBasedThirdPageConfig config;
  final EventResponse contractEvent;
  final EventResponse receptionEvent;

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
                    Icon(Icons.event, size: W.xs, color: config.titlePageColor),
                    const SizedBox(width: 10),
                    Text(
                      langCode == 'en' ? 'Weddings Event' : 'Acara Pernikahan',
                      style: AppFonts.inter(color: config.titlePageColor, fontSize: FontSize.x3l, fontWeight: .w700),
                    ),
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
                        decoration: BoxDecoration(color: config.scaffoldColor, borderRadius: .circular(20)),
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
                  decoration: BoxDecoration(color: config.scaffoldColor, borderRadius: .circular(20)),
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
                      const Spacer(),
                      Column(
                        mainAxisSize: .min,
                        children: [
                          FadeAndSlideTransition(
                            slideFromOffset: .0,
                            delayBeforeStart: const Duration(milliseconds: 500),
                            child: Row(
                              mainAxisSize: .min,
                              children: [
                                Icon(Icons.volunteer_activism, color: config.contractTitleColor),
                                const SizedBox(width: 8),
                                Text(
                                  langCode == 'en' ? 'Marriage Contract' : 'Akad Nikah',
                                  style: AppFonts.inter(
                                    color: config.contractTitleColor,
                                    fontSize: FontSize.x2l,
                                    fontWeight: .w500,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(Icons.menu_book, color: config.contractTitleColor),
                              ],
                            ),
                          ),
                          SizedBox(height: H.x2s),
                          FadeAndSlideTransition(
                            slideFromOffset: .8,
                            slideFrom: .bottom,
                            animationSpeed: const Duration(milliseconds: 300),
                            delayBeforeStart: const Duration(milliseconds: 800),
                            child: Column(
                              children: [
                                Text(
                                  DateUtil.format(contractEvent.startTime, .EEEEddMMMMyyyy),
                                  style: AppFonts.inter(color: Colors.grey.shade50, fontSize: FontSize.lg, fontWeight: .w500),
                                ),
                                SizedBox(height: H.x10s),
                                Text(
                                  langCode == 'en'
                                      ? '${DateUtil.format(contractEvent.startTime, .HHmm)} o\'clock WIB - ${contractEvent.endTime == null ? 'Finished' : '${DateUtil.format(contractEvent.endTime!, .HHmm)} o\'clock WIB'}'
                                      : 'Pukul ${DateUtil.format(contractEvent.startTime, .HHmm)} WIB - ${contractEvent.endTime == null ? 'Selesai' : 'Pukul ${DateUtil.format(contractEvent.endTime!, .HHmm)} WIB'}',
                                  style: AppFonts.inter(color: Colors.grey.shade100, fontSize: FontSize.md, fontWeight: .w300),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: H.md),
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
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      FadeAndSlideTransition(
                        slideFromOffset: .0,
                        delayBeforeStart: const Duration(milliseconds: 1400),
                        child: SizedBox(
                          height: config.dividingLineWidth,
                          width: W.x18l,
                          child: ColoredBox(color: config.dividingLineColor),
                        ),
                      ),
                      const Spacer(),
                      Column(
                        mainAxisSize: .min,
                        children: [
                          FadeAndSlideTransition(
                            slideFromOffset: .0,
                            delayBeforeStart: const Duration(milliseconds: 500),
                            child: Row(
                              mainAxisSize: .min,
                              children: [
                                Icon(Icons.celebration, color: config.receptionTitleColor),
                                const SizedBox(width: 8),
                                Text(
                                  langCode == 'en' ? 'Marriage Reception' : 'Resepsi Pernikahan',
                                  style: AppFonts.inter(
                                    color: config.receptionTitleColor,
                                    fontSize: FontSize.x2l,
                                    fontWeight: .w500,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(Icons.restaurant, color: config.receptionTitleColor),
                              ],
                            ),
                          ),
                          SizedBox(height: H.x2s),
                          FadeAndSlideTransition(
                            slideFromOffset: .8,
                            slideFrom: .bottom,
                            animationSpeed: const Duration(milliseconds: 300),
                            delayBeforeStart: const Duration(milliseconds: 800),
                            child: Column(
                              children: [
                                Text(
                                  DateUtil.format(receptionEvent.startTime, .EEEEddMMMMyyyy),
                                  style: AppFonts.inter(color: Colors.grey.shade50, fontSize: FontSize.lg, fontWeight: .w500),
                                ),
                                SizedBox(height: H.x10s),
                                Text(
                                  langCode == 'en'
                                      ? '${DateUtil.format(receptionEvent.startTime, .HHmm)} o\'clock WIB - ${receptionEvent.endTime == null ? 'Finished' : '${DateUtil.format(receptionEvent.endTime!, .HHmm)} o\'clock WIB'}'
                                      : 'Pukul ${DateUtil.format(receptionEvent.startTime, .HHmm)} WIB - ${receptionEvent.endTime == null ? 'Selesai' : 'Pukul ${DateUtil.format(receptionEvent.endTime!, .HHmm)} WIB'}',
                                  style: AppFonts.inter(color: Colors.grey.shade100, fontSize: FontSize.md, fontWeight: .w300),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: H.md),
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
                              time: receptionEvent.startTime,
                              animationDelayBeforeStart: const Duration(milliseconds: 800),
                              lightningEffectDelayBeforeShowed: const Duration(milliseconds: 1800),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (config.useGlassEffectOnScaffold)
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
                  color: Colors.grey.shade300.withValues(alpha: .4),
                  animationSpeed: const Duration(milliseconds: 600),
                  delayBeforeStart: const Duration(milliseconds: 2600),
                  animationInterval: const Duration(milliseconds: 3500),
                ),
              ),
            ),

          config.frontground ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}

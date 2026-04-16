import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/page_view_based_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/countdown_timers.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_model/iv_project_model.dart';

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
            child: FadeAndSlideTransition(slideFromOffset: .5, slideFrom: .top, child: _title(langCode)),
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
                      const Spacer(),
                      Column(
                        mainAxisSize: .min,
                        children: [
                          FadeAndSlideTransition(
                            slideFromOffset: .0,
                            delayBeforeStart: const Duration(milliseconds: 500),
                            child: _contractTitle(langCode),
                          ),
                          SizedBox(height: H.x2s),
                          FadeAndSlideTransition(
                            slideFromOffset: .8,
                            slideFrom: .bottom,
                            animationSpeed: const Duration(milliseconds: 300),
                            delayBeforeStart: const Duration(milliseconds: 800),
                            child: _contractTime(langCode),
                          ),
                          SizedBox(height: H.md),
                          SizedBox(
                            height: W.x3l,
                            child: CountdownTimers(
                              oddColor: config.contractCountdownOddColor,
                              evenColor: config.contractCountdownEvenColor,
                              oddBorderColor: config.contractCountdownOddBorderColor,
                              evenBorderColor: config.contractCountdownEvenBorderColor,
                              numberColor: config.contractCountdownNumberColor,
                              unitColor: config.contractCountdownUnitColor,
                              borderWidth: config.contractCountdownBorderWidth,
                              useLightningEffect: config.useLightningEffectOnCountdown,
                              time: contractEvent.startTime,
                              animationDelayBeforeStart: const Duration(milliseconds: 800),
                              lightningEffectDelayBeforeShowed: const Duration(milliseconds: 1800),
                              noAnimate: false,
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
                            child: _receptionTitle(langCode),
                          ),
                          SizedBox(height: H.x2s),
                          FadeAndSlideTransition(
                            slideFromOffset: .8,
                            slideFrom: .bottom,
                            animationSpeed: const Duration(milliseconds: 300),
                            delayBeforeStart: const Duration(milliseconds: 800),
                            child: _receptionTime(langCode),
                          ),
                          SizedBox(height: H.md),
                          SizedBox(
                            height: W.x3l,
                            child: CountdownTimers(
                              oddColor: config.receptionCountdownOddColor,
                              evenColor: config.receptionCountdownEvenColor,
                              oddBorderColor: config.receptionCountdownOddBorderColor,
                              evenBorderColor: config.receptionCountdownEvenBorderColor,
                              numberColor: config.receptionCountdownNumberColor,
                              unitColor: config.receptionCountdownUnitColor,
                              borderWidth: config.receptionCountdownBorderWidth,
                              useLightningEffect: config.useLightningEffectOnCountdown,
                              time: receptionEvent.startTime,
                              animationDelayBeforeStart: const Duration(milliseconds: 800),
                              lightningEffectDelayBeforeShowed: const Duration(milliseconds: 1800),
                              noAnimate: false,
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
                  color: Colors.white.withValues(alpha: config.glassEffectOpacity),
                  animationSpeed: const Duration(milliseconds: 600),
                  delayBeforeStart: const Duration(milliseconds: 2600),
                  animationInterval: const Duration(milliseconds: 3500),
                ),
              ),
            ),

          config.foreground ?? const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _title(String langCode) => SizedBox(
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
  );

  Widget _contractTitle(String langCode) => Row(
    mainAxisSize: .min,
    children: [
      Icon(Icons.volunteer_activism, color: config.contractTitleColor),
      const SizedBox(width: 8),
      Text(
        langCode == 'en' ? 'Marriage Contract' : 'Akad Nikah',
        style: AppFonts.inter(color: config.contractTitleColor, fontSize: FontSize.x2l, fontWeight: .w500),
      ),
      const SizedBox(width: 8),
      Icon(Icons.menu_book, color: config.contractTitleColor),
    ],
  );

  Widget _contractTime(String langCode) => Column(
    children: [
      Text(
        DateUtil.format(contractEvent.startTime, .EEEEddMMMMyyyy),
        style: AppFonts.inter(color: config.contractBaseTextColor, fontSize: FontSize.lg, fontWeight: .w500),
      ),
      SizedBox(height: H.x10s),
      Text(
        langCode == 'en'
            ? '${DateUtil.format(contractEvent.startTime, .HHmm)} o\'clock WIB - ${contractEvent.endTime == null ? 'Finished' : '${DateUtil.format(contractEvent.endTime!, .HHmm)} o\'clock WIB'}'
            : 'Pukul ${DateUtil.format(contractEvent.startTime, .HHmm)} WIB - ${contractEvent.endTime == null ? 'Selesai' : 'Pukul ${DateUtil.format(contractEvent.endTime!, .HHmm)} WIB'}',
        style: AppFonts.inter(color: config.contractBaseTextColor, fontSize: FontSize.md, fontWeight: .w300),
      ),
    ],
  );

  Widget _receptionTitle(String langCode) => Row(
    mainAxisSize: .min,
    children: [
      Icon(Icons.celebration, color: config.receptionTitleColor),
      const SizedBox(width: 8),
      Text(
        langCode == 'en' ? 'Marriage Reception' : 'Resepsi Pernikahan',
        style: AppFonts.inter(color: config.receptionTitleColor, fontSize: FontSize.x2l, fontWeight: .w500),
      ),
      const SizedBox(width: 8),
      Icon(Icons.restaurant, color: config.receptionTitleColor),
    ],
  );

  Widget _receptionTime(String langCode) => Column(
    children: [
      Text(
        DateUtil.format(receptionEvent.startTime, .EEEEddMMMMyyyy),
        style: AppFonts.inter(color: config.receptionBaseTextColor, fontSize: FontSize.lg, fontWeight: .w500),
      ),
      SizedBox(height: H.x10s),
      Text(
        langCode == 'en'
            ? '${DateUtil.format(receptionEvent.startTime, .HHmm)} o\'clock WIB - ${receptionEvent.endTime == null ? 'Finished' : '${DateUtil.format(receptionEvent.endTime!, .HHmm)} o\'clock WIB'}'
            : 'Pukul ${DateUtil.format(receptionEvent.startTime, .HHmm)} WIB - ${receptionEvent.endTime == null ? 'Selesai' : 'Pukul ${DateUtil.format(receptionEvent.endTime!, .HHmm)} WIB'}',
        style: AppFonts.inter(color: config.receptionBaseTextColor, fontSize: FontSize.md, fontWeight: .w300),
      ),
    ],
  );
}

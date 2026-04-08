import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_invitation_theme/src/widgets/maps.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';
import 'package:url_launcher/url_launcher.dart';

class PageViewBasedFourthPageConfig {
  const PageViewBasedFourthPageConfig({
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
    required this.placeIconColor,
    required this.placeTextColor,
    required this.addressTextColor,
    required this.dividingLineWidth,
    required this.dividingLineColor,
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
  final Color placeIconColor;
  final Color placeTextColor;
  final Color addressTextColor;
  final double dividingLineWidth;
  final Color dividingLineColor;
  final Color mapsBorderColor;
  final Color getDirectionsButtonColor;
  final Color getDirectionsButtonLabelColor;
  final double getDirectionsButtonBorderWidth;
  final Color getDirectionsButtonBorderColor;
}

class PageViewBasedFourthPage extends StatelessWidget {
  const PageViewBasedFourthPage({super.key, required this.config, required this.receptionEvent});

  final PageViewBasedFourthPageConfig config;
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
              top: 0,
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
                    Icon(Icons.location_pin, size: W.xs, color: config.titlePageColor),
                    const SizedBox(width: 10),
                    Text(
                      langCode == 'en' ? 'Event Location' : 'Lokasi Acara',
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
                      SizedBox(height: H.lg),
                      FadeAndSlideTransition(
                        slideFromOffset: .0,
                        slideFrom: .top,
                        delayBeforeStart: const Duration(milliseconds: 200),
                        child: Column(
                          children: [
                            Icon(Icons.maps_home_work_rounded, size: 32, color: config.placeIconColor),
                            const SizedBox(height: 4),
                            Text(
                              receptionEvent.place,
                              style: AppFonts.inter(color: config.placeTextColor, fontSize: FontSize.xl, fontWeight: .w600),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: config.dividingLineWidth,
                              width: W.x18l,
                              child: ColoredBox(color: config.dividingLineColor),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      FadeAndSlideTransition(
                        slideFromOffset: .8,
                        slideFrom: .bottom,
                        animationSpeed: const Duration(milliseconds: 300),
                        delayBeforeStart: const Duration(milliseconds: 400),
                        child: Padding(
                          padding: const .symmetric(horizontal: 20),
                          child: Text(
                            receptionEvent.address,
                            style: AppFonts.inter(color: config.addressTextColor, fontSize: FontSize.xs, fontWeight: .w400),
                            textAlign: .center,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Maps(
                        borderColor: config.mapsBorderColor,
                        width: Screen.width - (W.x6s * 5),
                        height: Screen.height - (H.x22l),
                        delayBeforeStart: const Duration(milliseconds: 1000),
                        url: receptionEvent.mapsUrl,
                      ),
                      SizedBox(height: H.x2s),
                      FadeAndSlideTransition(
                        slideFromOffset: .8,
                        slideFrom: .bottom,
                        animationSpeed: const Duration(milliseconds: 300),
                        delayBeforeStart: const Duration(milliseconds: 1000),
                        child: GeneralEffectsButton(
                          onTap: () {
                            launchUrl(Uri.parse(receptionEvent.mapsUrl), mode: .externalNonBrowserApplication);
                          },
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_model/iv_project_model.dart';

class PageViewBasedFirstPageConfig {
  const PageViewBasedFirstPageConfig({
    this.foreground,
    this.background,
    required this.useBackdropBlurOnScaffold,
    required this.firstGradientScaffoldColor,
    required this.secondGradientScaffoldColor,
    this.stopsGradientScaffoldColor,
    this.scaffoldBoxShadow,
    required this.scaffoldBorder,
    this.scaffoldBorderRadius = const BorderRadius.all(Radius.circular(20)),
    required this.useGlassEffectOnScaffold,
    this.glassEffectOpacity = .4,
    this.firstGradientBackgroundColor,
    this.secondGradientBackgroundColor,
    required this.titlePageColor,
    required this.openingTextColor,
    required this.generalTextColor,
    required this.firstSubScaffoldColor,
    this.firstSubScaffoldBoxShadow,
    required this.firstSubScaffoldBorderColor,
    required this.firstSubScaffoldBorderWidth,
    required this.secondSubScaffoldColor,
    this.secondSubScaffoldBoxShadow,
    required this.secondSubScaffoldBorderColor,
    required this.secondSubScaffoldBorderWidth,
  });

  final Widget? foreground;
  final Widget? background;
  final bool useBackdropBlurOnScaffold;
  final Color firstGradientScaffoldColor;
  final Color secondGradientScaffoldColor;
  final List<double>? stopsGradientScaffoldColor;
  final List<BoxShadow>? scaffoldBoxShadow;
  final BoxBorder scaffoldBorder;
  final BorderRadiusGeometry scaffoldBorderRadius;
  final bool useGlassEffectOnScaffold;
  final double glassEffectOpacity;
  final Color? firstGradientBackgroundColor;
  final Color? secondGradientBackgroundColor;
  final Color titlePageColor;
  final Color openingTextColor;
  final Color generalTextColor;
  final Color firstSubScaffoldColor;
  final List<BoxShadow>? firstSubScaffoldBoxShadow;
  final Color firstSubScaffoldBorderColor;
  final double firstSubScaffoldBorderWidth;
  final Color secondSubScaffoldColor;
  final List<BoxShadow>? secondSubScaffoldBoxShadow;
  final Color secondSubScaffoldBorderColor;
  final double secondSubScaffoldBorderWidth;
}

class PageViewBasedFirstPage extends StatelessWidget {
  const PageViewBasedFirstPage({super.key, required this.config, required this.general});

  final PageViewBasedFirstPageConfig config;
  final GeneralResponse general;

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
                child: Center(
                  child: Text(
                    langCode == 'en' ? 'Intent and Purpose' : 'Maksud dan Tujuan',
                    style: AppFonts.inter(color: config.titlePageColor, fontSize: FontSize.x3l, fontWeight: .w700),
                  ),
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
                    borderRadius: config.scaffoldBorderRadius,
                    child: BackdropFilter(
                      filter: .blur(sigmaX: 3, sigmaY: 3),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: config.scaffoldBorderRadius,
                          boxShadow: config.scaffoldBoxShadow,
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
                    borderRadius: config.scaffoldBorderRadius,
                    boxShadow: config.scaffoldBoxShadow,
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
                decoration: BoxDecoration(borderRadius: config.scaffoldBorderRadius, border: config.scaffoldBorder),
                child: ClipRect(
                  child: Column(
                    children: [
                      const Spacer(),
                      FadeAndSlideTransition(
                        slideFromOffset: .5,
                        slideFrom: .top,
                        delayBeforeStart: const Duration(milliseconds: 500),
                        child: Text(
                          general.opening.isNotEmpty ? general.opening : 'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ',
                          style: AppFonts.arefRuqaa(color: config.openingTextColor, fontSize: FontSize.x7l),
                        ),
                      ),
                      const Spacer(),
                      FadeAndSlideTransition(
                        slideFromOffset: .4,
                        slideFrom: .left,
                        delayBeforeStart: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: .symmetric(horizontal: W.x6s),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              boxShadow: config.firstSubScaffoldBoxShadow,
                              border: .all(width: config.firstSubScaffoldBorderWidth, color: config.firstSubScaffoldBorderColor),
                              borderRadius: .circular(10),
                              color: config.firstSubScaffoldColor,
                            ),
                            child: Padding(
                              padding: .only(top: H.md, left: 20, right: 20, bottom: H.sm),
                              child: Column(
                                mainAxisSize: .min,
                                children: [
                                  FadeAndSlideTransition(
                                    slideFromOffset: .3,
                                    slideFrom: .top,
                                    delayBeforeStart: const Duration(milliseconds: 1000),
                                    child: Text(
                                      general.openingQuote.isNotEmpty
                                          ? general.openingQuote
                                          : '"Dan di antara tanda-tanda (kebesaran)-Nya adalah Dia menciptakan pasangan-pasangan untukmu dari jenismu sendiri, agar kamu cenderung dan merasa tenteram kepadanya".',
                                      style: AppFonts.inter(
                                        color: config.generalTextColor,
                                        fontSize: FontSize.md,
                                        fontWeight: .w500,
                                        fontStyle: .italic,
                                      ),
                                      textAlign: .center,
                                    ),
                                  ),
                                  SizedBox(height: H.x6s),
                                  FadeAndSlideTransition(
                                    slideFromOffset: 1,
                                    slideFrom: .bottom,
                                    delayBeforeStart: const Duration(milliseconds: 1000),
                                    child: Text(
                                      general.quoteFrom.isNotEmpty ? general.quoteFrom : '(Ar-Ruum Ayat 21)',
                                      style: AppFonts.inter(
                                        color: config.generalTextColor,
                                        fontSize: FontSize.lg,
                                        fontWeight: .w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: H.x4s),
                      FadeAndSlideTransition(
                        slideFromOffset: .4,
                        slideFrom: .right,
                        delayBeforeStart: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: .symmetric(horizontal: W.x6s),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              boxShadow: config.secondSubScaffoldBoxShadow,
                              border: .all(
                                width: config.secondSubScaffoldBorderWidth,
                                color: config.secondSubScaffoldBorderColor,
                              ),
                              borderRadius: .circular(10),
                              color: config.secondSubScaffoldColor,
                            ),
                            child: Padding(
                              padding: .only(top: H.xs, left: 20, right: 20, bottom: H.sm),
                              child: Column(
                                mainAxisSize: .min,
                                children: [
                                  FadeAndSlideTransition(
                                    slideFromOffset: 1,
                                    slideFrom: .top,
                                    delayBeforeStart: const Duration(milliseconds: 1000),
                                    child: Text(
                                      general.regards.isNotEmpty ? general.regards : 'Assalamu\'alaikum Wr. Wb.',
                                      style: AppFonts.inter(
                                        color: config.generalTextColor,
                                        fontSize: FontSize.x2l,
                                        fontWeight: .w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: H.x6s),
                                  FadeAndSlideTransition(
                                    slideFromOffset: .4,
                                    slideFrom: .bottom,
                                    delayBeforeStart: const Duration(milliseconds: 1000),
                                    child: Text(
                                      general.greeting.isNotEmpty
                                          ? general.greeting
                                          : 'Dengan memohon rahmat dan ridho Allah Subhanahu Wa Ta\'ala. Kami mengundang Bapak/Ibu/Saudara/I, untuk menghadiri resepsi pernikahan kami.',
                                      style: AppFonts.inter(
                                        color: config.generalTextColor,
                                        fontSize: FontSize.md,
                                        fontWeight: .w400,
                                      ),
                                      textAlign: .center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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

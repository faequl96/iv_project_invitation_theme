import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/page_view_based_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_model/iv_project_model.dart';

class PageViewBasedEighthPage extends StatelessWidget {
  const PageViewBasedEighthPage({
    super.key,
    required this.config,
    required this.general,
    required this.brideName,
    required this.groomName,
    required this.brandProfile,
  });

  final PageViewBasedEighthPageConfig config;
  final GeneralResponse general;
  final String brideName;
  final String groomName;
  final BrandProfileResponse brandProfile;

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
              height: Screen.height,
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
                padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: H.x18l),
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
                padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: H.x18l),
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
              padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: H.x18l),
              child: DecoratedBox(
                decoration: BoxDecoration(borderRadius: .circular(20), border: config.scaffoldBorder),
                child: ClipRRect(
                  borderRadius: .circular(20),
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      Padding(
                        padding: .symmetric(horizontal: W.md),
                        child: FadeAndSlideTransition(
                          slideFromOffset: .8,
                          slideFrom: .bottom,
                          animationSpeed: const Duration(milliseconds: 500),
                          delayBeforeStart: const Duration(milliseconds: 700),
                          child: _closing(),
                        ),
                      ),
                      SizedBox(height: H.lg),
                      Padding(
                        padding: .symmetric(horizontal: W.md),
                        child: FadeAndSlideTransition(
                          slideFromOffset: .9,
                          slideFrom: .bottom,
                          animationSpeed: const Duration(milliseconds: 500),
                          delayBeforeStart: const Duration(milliseconds: 1100),
                          child: _brideGroomName(),
                        ),
                      ),
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
                padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: H.x18l),
                child: GlassEffectBox(
                  width: Screen.width - 32,
                  height: Screen.height - (76 + H.x6l),
                  borderRadius: 20,
                  sliderWidth: 90,
                  color: Colors.white.withValues(alpha: config.glassEffectOpacity),
                  animationSpeed: const Duration(milliseconds: 600),
                  delayBeforeStart: const Duration(milliseconds: 1900),
                  animationInterval: const Duration(milliseconds: 3500),
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            height: H.x18l - H.x4s,
            width: Screen.width,
            child: RepaintBoundary(
              child: ClipRRect(
                borderRadius: const .only(topLeft: .circular(36), topRight: .circular(36)),
                child: BackdropFilter(
                  filter: .blur(sigmaX: 3, sigmaY: 3),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: config.brandBackgroundColor,
                      borderRadius: const .only(topLeft: .circular(36), topRight: .circular(36)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: H.x18l - H.x4s,
            width: Screen.width,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                borderRadius: .only(topLeft: .circular(36), topRight: .circular(36)),
              ),
              child: ClipRRect(
                borderRadius: const .only(topLeft: .circular(36), topRight: .circular(36)),
                child: Padding(
                  padding: .symmetric(horizontal: W.x6s),
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        'Made By :',
                        style: AppFonts.inter(fontWeight: .w400, color: config.brandTextColor),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: .center,
                        children: [
                          if (brandProfile.logoUrl != null) Image.network(brandProfile.logoUrl!, height: 44),
                          if (brandProfile.logoUrl != null) const SizedBox(width: 10),
                          Text(
                            brandProfile.name,
                            style: AppFonts.inter(fontWeight: .w700, fontSize: 15, color: config.brandTextColor),
                          ),
                        ],
                      ),
                      SizedBox(height: H.x10s),
                      Row(
                        mainAxisAlignment: .center,
                        children: [
                          Text(
                            'Email : ',
                            style: AppFonts.inter(fontWeight: .w400, color: config.brandTextColor),
                          ),
                          Text(
                            brandProfile.email,
                            style: AppFonts.inter(fontWeight: .w700, color: config.brandTextColor),
                          ),
                        ],
                      ),
                      if (brandProfile.phone != null)
                        Row(
                          mainAxisAlignment: .center,
                          children: [
                            Text(
                              'WhatsApp : ',
                              style: AppFonts.inter(fontWeight: .w400, color: config.brandTextColor),
                            ),
                            Text(
                              brandProfile.phone!,
                              style: AppFonts.inter(fontWeight: .w700, color: config.brandTextColor),
                            ),
                          ],
                        ),
                      if (brandProfile.instagram != null)
                        Row(
                          mainAxisAlignment: .center,
                          children: [
                            Text(
                              'Instagram : ',
                              style: AppFonts.inter(fontWeight: .w400, color: config.brandTextColor),
                            ),
                            Text.rich(
                              TextSpan(children: [TextSpan(text: brandProfile.instagram!)]),
                              style: AppFonts.inter(fontWeight: .w700, color: config.brandTextColor),
                            ),
                          ],
                        ),
                      SizedBox(height: H.x10s),
                      if (brandProfile.address != null)
                        Text(
                          brandProfile.address!,
                          style: AppFonts.inter(fontWeight: .w400, color: config.brandTextColor, fontSize: 13),
                          textAlign: .center,
                        ),
                    ],
                  ),
                ),
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
        Icon(Icons.emoji_emotions, size: W.xs, color: config.titlePageColor),
        const SizedBox(width: 10),
        Text(
          langCode == 'en' ? 'Thank You' : 'Terima Kasih',
          style: AppFonts.inter(color: config.titlePageColor, fontSize: FontSize.x3l, fontWeight: .w700),
        ),
      ],
    ),
  );

  Widget _closing() => Text(
    general.closing.isNotEmpty
        ? general.closing
        : 'Merupakan suatu kehormatan dan kebahagiaan bagi kami apabila Bapak/Ibu/Saudara/i berkenan hadir dan memberikan doa restu untuk pernikahan kami. Atas kehadiran dan doa restunya, kami mengucapkan terima kasih.',
    style: AppFonts.inter(color: config.closingTextColor, fontSize: FontSize.md, fontWeight: .w600),
    textAlign: .center,
  );

  Widget _brideGroomName() => Text(
    '$brideName & $groomName',
    style: AppFonts.pacifico(color: config.brideGroomNameColor, fontSize: FontSize.x5l, fontWeight: .w500),
    textAlign: .center,
  );
}

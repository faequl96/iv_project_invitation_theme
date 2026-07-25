import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/gemini_star_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_model/iv_project_model.dart';

class GeminiStarNinthPage extends StatelessWidget {
  const GeminiStarNinthPage({
    super.key,
    required this.config,
    required this.general,
    required this.brideName,
    required this.groomName,
    required this.brandProfile,
  });

  final GeminiStarNinthPageConfig config;
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
        alignment: .center,
        children: [
          if (config.firstGradientBackgroundColor != null &&
              config.secondGradientBackgroundColor != null)
            Positioned(
              top: 0,
              height: Screen.height,
              width: Screen.width,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: .topCenter,
                    end: .bottomCenter,
                    colors: [
                      config.firstGradientBackgroundColor!,
                      config.secondGradientBackgroundColor!,
                    ],
                    stops: const [.2, .8],
                  ),
                ),
              ),
            ),

          Positioned(
            bottom: 0,
            height: Screen.height,
            width: Screen.width,
            child: Padding(
              padding: .symmetric(horizontal: W.sm),
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  const Spacer(),
                  FadeAndSlideTransition(
                    slideFromOffset: .5,
                    slideFrom: .top,
                    child: _buildTitle(langCode),
                  ),
                  const Spacer(),
                  // SizedBox(height: H.x3s),
                  Padding(
                    padding: .symmetric(horizontal: W.md),
                    child: FadeAndSlideTransition(
                      slideFromOffset: .8,
                      slideFrom: .bottom,
                      animationSpeed: const Duration(milliseconds: 500),
                      delayBeforeStart: const Duration(milliseconds: 700),
                      child: _buildClosing(),
                    ),
                  ),
                  SizedBox(height: H.x3s),
                  Padding(
                    padding: .symmetric(horizontal: W.md),
                    child: FadeAndSlideTransition(
                      slideFromOffset: .9,
                      slideFrom: .bottom,
                      animationSpeed: const Duration(milliseconds: 500),
                      delayBeforeStart: const Duration(milliseconds: 1100),
                      child: _buildBrideGroomName(),
                    ),
                  ),
                  SizedBox(height: H.x3l),
                  SizedBox(height: H.x18l - H.x4s),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            height: H.x18l - H.x4s,
            width: Screen.width,
            child: ColoredBox(
              color: config.brandBackgroundColor,
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
                        if (brandProfile.logoUrl != null)
                          Image.network(brandProfile.logoUrl!, height: 44),
                        if (brandProfile.logoUrl != null) const SizedBox(width: 10),
                        Text(
                          brandProfile.name,
                          style: AppFonts.inter(
                            fontWeight: .w700,
                            fontSize: 15,
                            color: config.brandTextColor,
                          ),
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
                        style: AppFonts.inter(
                          fontWeight: .w400,
                          color: config.brandTextColor,
                          fontSize: 13,
                        ),
                        textAlign: .center,
                      ),
                  ],
                ),
              ),
            ),
          ),

          if (config.decorationBuilder != null)
            SizedBox(
              height: Screen.height,
              width: Screen.width,
              child: config.decorationBuilder!(),
            ),
        ],
      ),
    );
  }

  Widget _buildTitle(String langCode) => SizedBox(
    height: H.x6l,
    width: Screen.width,
    child: Row(
      mainAxisAlignment: .center,
      children: [
        Icon(Icons.emoji_emotions, size: W.xs, color: config.titlePageColor),
        const SizedBox(width: 10),
        Text(
          langCode == 'en' ? 'Thank You' : 'Terima Kasih',
          style: AppFonts.inter(
            color: config.titlePageColor,
            fontSize: FontSize.x3l,
            fontWeight: .w700,
          ),
        ),
      ],
    ),
  );

  Widget _buildClosing() => Text(
    general.closing.isNotEmpty
        ? general.closing
        : 'Merupakan suatu kehormatan dan kebahagiaan bagi kami apabila Bapak/Ibu/Saudara/i berkenan hadir dan memberikan doa restu untuk pernikahan kami. Atas kehadiran dan doa restunya, kami mengucapkan terima kasih.',
    style: AppFonts.inter(color: config.closingTextColor, fontSize: FontSize.md, fontWeight: .w600),
    textAlign: .center,
  );

  Widget _buildBrideGroomName() => Text(
    '$brideName & $groomName',
    style: AppFonts.pacifico(
      color: config.brideGroomNameColor,
      fontSize: FontSize.x5l,
      fontWeight: .w500,
    ),
    textAlign: .center,
  );
}

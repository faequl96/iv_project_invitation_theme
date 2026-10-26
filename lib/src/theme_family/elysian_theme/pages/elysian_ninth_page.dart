import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/elysian_configs.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/widgets/elysian_glass_card.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/widgets/elysian_reveal.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/widgets/elysian_shimmer_text.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const ElysianNinthPage({
  super.key,
  required final ElysianNinthPageConfig config,
  required final GeneralResponse general,
  required final String brideName,
  required final String groomName,
  required final BrandProfileResponse brandProfile,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, size) => Container(
        height: size.height,
        width: size.width,
        color: config.backgroundColor,
        padding: const .symmetric(horizontal: 24, vertical: 32),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: .center,
              children: [
                ElysianReveal(
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    langCode == 'en' ? 'THANK YOU' : 'TERIMA KASIH',
                    style: TextStyle(
                      color: config.titleColor,
                      fontSize: 12,
                      letterSpacing: 4,
                      fontWeight: .w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElysianReveal(
                  delay: const Duration(milliseconds: 250),
                  child: ElysianGlassCard(
                    backgroundColor: const Color(0x18FFFFFF),
                    borderColor: config.titleColor.withValues(alpha: .4),
                    padding: const .all(24),
                    child: Column(
                      children: [
                        Text(
                          general.closing,
                          style: TextStyle(
                            color: config.subtitleColor,
                            fontSize: 13,
                            height: 1.6,
                          ),
                          textAlign: .center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          langCode == 'en' ? 'Warmest regards,' : 'Kami yang berbahagia,',
                          style: TextStyle(
                            color: config.titleColor,
                            fontSize: 12,
                            fontStyle: .italic,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElysianShimmerText(
                          text: '$brideName & $groomName',
                          baseColor: config.coupleNamesColor,
                          highlightColor: Colors.white,
                          style: AppFonts.pacifico(
                            fontSize: 36,
                            color: config.coupleNamesColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                ElysianReveal(
                  delay: const Duration(milliseconds: 400),
                  child: Column(
                    children: [
                      Text(
                        brandProfile.name.toUpperCase(),
                        style: TextStyle(
                          color: config.brandNameColor,
                          fontSize: 11,
                          fontWeight: .bold,
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Digital Wedding Invitation',
                        style: TextStyle(
                          color: config.brandSubtitleColor,
                          fontSize: 10,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

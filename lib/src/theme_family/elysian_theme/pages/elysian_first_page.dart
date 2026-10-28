import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/elysian_configs.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/widgets/elysian_glass_card.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/widgets/elysian_reveal.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const ElysianFirstPage({
  super.key,
  required final ElysianFirstPageConfig config,
  required final GeneralResponse general,
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
        padding: const .symmetric(horizontal: 22, vertical: 28),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: .center,
              children: [
                ElysianReveal(
                  delay: const Duration(milliseconds: 100),
                  child: Row(
                    mainAxisAlignment: .center,
                    children: [
                      Container(
                        width: 36,
                        height: 1.5,
                        color: config.ornamentColor.withValues(alpha: .6),
                      ),
                      Padding(
                        padding: const .symmetric(horizontal: 12),
                        child: Text(
                          langCode == 'en' ? 'INTENT & PURPOSE' : 'KATA PENGANTAR',
                          style: TextStyle(
                            color: config.headerColor,
                            fontSize: 12,
                            letterSpacing: 3,
                            fontWeight: .w600,
                          ),
                        ),
                      ),
                      Container(
                        width: 36,
                        height: 1.5,
                        color: config.ornamentColor.withValues(alpha: .6),
                      ),
                    ],
                  ),
                ),
                if (general.opening.trim().isNotEmpty) ...[
                  const SizedBox(height: 20),
                  ElysianReveal(
                    delay: const Duration(milliseconds: 200),
                    child: Text(
                      general.opening,
                      style: TextStyle(
                        color: config.quoteTextColor.withValues(alpha: .9),
                        fontSize: 13,
                        height: 1.6,
                      ),
                      textAlign: .center,
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                if (general.openingQuote.trim().isNotEmpty)
                  ElysianReveal(
                    delay: const Duration(milliseconds: 350),
                    child: ElysianGlassCard(
                      backgroundColor: config.cardBackgroundColor,
                      borderColor: config.cardBorderColor,
                      padding: const .all(22),
                      child: Column(
                        children: [
                          Icon(
                            Icons.format_quote_rounded,
                            color: config.ornamentColor,
                            size: 32,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            general.openingQuote,
                            style: TextStyle(
                              color: config.quoteTextColor,
                              fontSize: 13,
                              height: 1.7,
                              fontStyle: .italic,
                            ),
                            textAlign: .center,
                          ),
                          if (general.quoteFrom.trim().isNotEmpty) ...[
                            const SizedBox(height: 14),
                            Text(
                              general.quoteFrom,
                              style: TextStyle(
                                color: config.sourceTextColor,
                                fontSize: 11,
                                letterSpacing: 1.5,
                                fontWeight: .bold,
                              ),
                              textAlign: .center,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                if (general.greeting.trim().isNotEmpty) ...[
                  const SizedBox(height: 20),
                  ElysianReveal(
                    delay: const Duration(milliseconds: 500),
                    child: ElysianGlassCard(
                      backgroundColor: config.cardBackgroundColor,
                      borderColor: config.cardBorderColor,
                      padding: const .symmetric(horizontal: 18, vertical: 16),
                      child: Text(
                        general.greeting,
                        style: TextStyle(
                          color: config.quoteTextColor.withValues(alpha: .95),
                          fontSize: 13,
                          height: 1.6,
                        ),
                        textAlign: .center,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

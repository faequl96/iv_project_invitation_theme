import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/elysian_configs.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/widgets/elysian_glass_card.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/widgets/elysian_reveal.dart';
import 'package:iv_project_invitation_theme/src/widgets/maps.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:url_launcher/url_launcher.dart';

class const ElysianFifthPage({
  super.key,
  required final ElysianFifthPageConfig config,
  required final EventResponse receptionEvent,
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
        child: Column(
          children: [
            ElysianReveal(
              delay: const Duration(milliseconds: 100),
              child: Text(
                langCode == 'en' ? 'VENUE LOCATION' : 'LOKASI ACARA',
                style: TextStyle(
                  color: config.titleColor,
                  fontSize: 12,
                  letterSpacing: 4,
                  fontWeight: .w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ElysianReveal(
                delay: const Duration(milliseconds: 250),
                child: ClipRRect(
                  borderRadius: .circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: config.cardBorderColor, width: 1.5),
                      borderRadius: .circular(20),
                    ),
                    clipBehavior: .antiAlias,
                    child: Maps(
                      url: receptionEvent.mapsUrl,
                      borderColor: config.cardBorderColor,
                      height: size.height,
                      width: size.width,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElysianReveal(
              delay: const Duration(milliseconds: 400),
              child: ElysianGlassCard(
                backgroundColor: config.cardColor,
                borderColor: config.cardBorderColor,
                padding: const .all(18),
                child: Column(
                  children: [
                    Text(
                      receptionEvent.place,
                      style: TextStyle(
                        color: config.locationNameColor,
                        fontSize: 16,
                        fontWeight: .bold,
                      ),
                      textAlign: .center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      receptionEvent.address,
                      style: TextStyle(
                        color: config.addressColor,
                        fontSize: 12,
                        height: 1.4,
                      ),
                      textAlign: .center,
                    ),
                    const SizedBox(height: 14),
                    GestureDetector(
                      onTap: () async {
                        final uri = Uri.parse(receptionEvent.mapsUrl);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri, mode: .externalApplication);
                        }
                      },
                      child: Container(
                        padding: const .symmetric(horizontal: 18, vertical: 10),
                        decoration: BoxDecoration(
                          color: config.buttonColor,
                          borderRadius: .circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: config.buttonColor.withValues(alpha: .3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: .min,
                          children: [
                            Icon(Icons.directions_rounded, color: config.buttonTextColor, size: 16),
                            const SizedBox(width: 6),
                            Text(
                              langCode == 'en' ? 'OPEN GOOGLE MAPS' : 'PETUNJUK ARAH',
                              style: TextStyle(
                                color: config.buttonTextColor,
                                fontSize: 11,
                                fontWeight: .bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

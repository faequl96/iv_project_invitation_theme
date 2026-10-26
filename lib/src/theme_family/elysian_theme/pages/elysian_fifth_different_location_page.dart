import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/elysian_configs.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/widgets/elysian_glass_card.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/widgets/elysian_reveal.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:url_launcher/url_launcher.dart';

class const ElysianFifthDifferentLocationPage({
  super.key,
  required final ElysianFifthDifferentLocationPageConfig config,
  required final EventResponse receptionEvent,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    final timeStr = langCode == 'en'
        ? '${DateUtil.format(receptionEvent.startTime, .HHmm)} - ${receptionEvent.endTime == null ? 'Finish' : DateUtil.format(receptionEvent.endTime!, .HHmm)}'
        : 'Pukul ${DateUtil.format(receptionEvent.startTime, .HHmm)} - ${receptionEvent.endTime == null ? 'Selesai' : DateUtil.format(receptionEvent.endTime!, .HHmm)} WIB';

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
                  child: Text(
                    langCode == 'en' ? 'WEDDING RECEPTION' : 'RESEPSI PERNIKAHAN',
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
                    backgroundColor: config.cardColor,
                    borderColor: config.cardBorderColor,
                    padding: const .all(24),
                    child: Column(
                      children: [
                        Icon(Icons.wine_bar_rounded, color: config.titleColor, size: 36),
                        const SizedBox(height: 16),
                        Text(
                          DateUtil.format(receptionEvent.startTime, .EEEEddMMMMyyyy),
                          style: TextStyle(
                            color: config.dateTimeColor,
                            fontSize: 18,
                            fontWeight: .bold,
                          ),
                          textAlign: .center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          timeStr,
                          style: TextStyle(
                            color: config.titleColor,
                            fontSize: 14,
                            fontWeight: .w600,
                          ),
                          textAlign: .center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          receptionEvent.place,
                          style: TextStyle(
                            color: config.eventNameColor,
                            fontSize: 15,
                            fontWeight: .bold,
                          ),
                          textAlign: .center,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          receptionEvent.address,
                          style: TextStyle(
                            color: config.locationColor,
                            fontSize: 12,
                            height: 1.4,
                          ),
                          textAlign: .center,
                        ),
                        const SizedBox(height: 20),
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
                                Icon(Icons.location_on_rounded, color: config.buttonTextColor, size: 16),
                                const SizedBox(width: 6),
                                Text(
                                  langCode == 'en' ? 'OPEN IN MAPS' : 'BUKA GOOGLE MAPS',
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
        ),
      ),
    );
  }
}

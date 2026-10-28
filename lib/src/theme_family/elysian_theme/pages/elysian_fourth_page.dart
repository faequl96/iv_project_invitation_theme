import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/elysian_configs.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/widgets/elysian_glass_card.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/widgets/elysian_reveal.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:url_launcher/url_launcher.dart';

class const ElysianFourthPage({
  super.key,
  required final ElysianFourthPageConfig config,
  required final EventResponse contractEvent,
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
                langCode == 'en' ? 'WEDDING EVENTS' : 'RANGKAIAN ACARA',
                style: TextStyle(
                  color: config.titleColor,
                  fontSize: 12,
                  letterSpacing: 4,
                  fontWeight: .w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ElysianReveal(
                      delay: const Duration(milliseconds: 250),
                      child: _buildEventCard(
                        title: langCode == 'en' ? 'HOLY MATRIMONY' : 'AKAD NIKAH',
                        event: contractEvent,
                        langCode: langCode,
                      ),
                    ),
                    const SizedBox(height: 18),
                    ElysianReveal(
                      delay: const Duration(milliseconds: 400),
                      child: _buildEventCard(
                        title: langCode == 'en' ? 'WEDDING RECEPTION' : 'RESEPSI PERNIKAHAN',
                        event: receptionEvent,
                        langCode: langCode,
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

  Widget _buildEventCard({
    required String title,
    required EventResponse event,
    required String langCode,
  }) {
    final timeStr = langCode == 'en'
        ? '${DateUtil.format(event.startTime, .HHmm)} - ${event.endTime == null ? 'Finish' : DateUtil.format(event.endTime!, .HHmm)}'
        : 'Pukul ${DateUtil.format(event.startTime, .HHmm)} - ${event.endTime == null ? 'Selesai' : DateUtil.format(event.endTime!, .HHmm)} WIB';

    return ElysianGlassCard(
      backgroundColor: config.cardColor,
      borderColor: config.cardBorderColor,
      padding: const .all(20),
      child: Column(
        children: [
          Container(
            padding: const .symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: config.buttonColor.withValues(alpha: .2),
              borderRadius: .circular(20),
              border: Border.all(color: config.titleColor.withValues(alpha: .5), width: 1),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: config.titleColor,
                fontSize: 12,
                fontWeight: .bold,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            DateUtil.format(event.startTime, .EEEEddMMMMyyyy),
            style: TextStyle(
              color: config.dateTimeColor,
              fontSize: 16,
              fontWeight: .w700,
            ),
            textAlign: .center,
          ),
          const SizedBox(height: 6),
          Text(
            timeStr,
            style: TextStyle(
              color: config.titleColor,
              fontSize: 13,
              fontWeight: .w600,
            ),
            textAlign: .center,
          ),
          const SizedBox(height: 12),
          Text(
            event.place,
            style: TextStyle(
              color: config.eventNameColor,
              fontSize: 14,
              fontWeight: .bold,
            ),
            textAlign: .center,
          ),
          const SizedBox(height: 4),
          Text(
            event.address,
            style: TextStyle(
              color: config.locationColor,
              fontSize: 12,
              height: 1.4,
            ),
            textAlign: .center,
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () async {
              final uri = Uri.parse(event.mapsUrl);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: .externalApplication);
              }
            },
            child: Container(
              padding: const .symmetric(horizontal: 16, vertical: 9),
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
                  Icon(Icons.location_on_rounded, color: config.buttonTextColor, size: 15),
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
    );
  }
}

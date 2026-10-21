import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/editorial_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:url_launcher/url_launcher.dart';

class const EditorialFifthDifferentLocationPage({
  super.key,
  required final EditorialFifthDifferentLocationPageConfig config,
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
        padding: const .symmetric(horizontal: 20, vertical: 32),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisAlignment: .center,
          children: [
            FadeAndSlideTransition(
              slideFrom: .top,
              slideFromOffset: .3,
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    langCode == 'en' ? 'EVENT 02' : 'ACARA 02',
                    style: TextStyle(
                      color: config.sectionHeaderColor,
                      fontSize: 11,
                      fontWeight: .bold,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    langCode == 'en' ? 'RECEPTION' : 'RESEPSI',
                    style: TextStyle(
                      color: config.locationAddressColor,
                      fontSize: 10,
                      fontWeight: .w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FadeAndSlideTransition(
              slideFrom: .bottom,
              slideFromOffset: .2,
              child: Container(
                width: double.infinity,
                padding: const .all(24),
                decoration: BoxDecoration(
                  color: config.cardBackgroundColor,
                  borderRadius: .circular(4),
                  border: .all(color: config.borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      DateUtil.format(receptionEvent.startTime, .EEEEddMMMMyyyy),
                      style: TextStyle(
                        color: config.locationTitleColor,
                        fontSize: 22,
                        fontWeight: .w800,
                        fontFamily: 'serif',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      langCode == 'en'
                          ? '${DateUtil.format(receptionEvent.startTime, .HHmm)} o\'clock WIB - ${receptionEvent.endTime == null ? 'Finished' : '${DateUtil.format(receptionEvent.endTime!, .HHmm)} o\'clock WIB'}'
                          : 'Pukul ${DateUtil.format(receptionEvent.startTime, .HHmm)} WIB - ${receptionEvent.endTime == null ? 'Selesai' : 'Pukul ${DateUtil.format(receptionEvent.endTime!, .HHmm)} WIB'}',
                      style: TextStyle(
                        color: config.locationAddressColor,
                        fontSize: 14,
                        fontWeight: .w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      receptionEvent.place,
                      style: TextStyle(
                        color: config.locationAddressColor,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        final uri = Uri.parse(receptionEvent.mapsUrl);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri, mode: LaunchMode.externalApplication);
                        }
                      },
                      child: Container(
                        padding: const .symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: config.mapButtonBgColor,
                          borderRadius: .circular(2),
                        ),
                        child: Row(
                          mainAxisSize: .min,
                          children: [
                            const Icon(Icons.location_on_outlined, color: Colors.white, size: 14),
                            const SizedBox(width: 8),
                            Text(
                              langCode == 'en' ? 'OPEN MAPS' : 'BUKA GOOGLE MAPS',
                              style: TextStyle(
                                color: config.mapButtonTextColor,
                                fontSize: 11,
                                fontWeight: .bold,
                                letterSpacing: 1,
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

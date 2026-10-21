import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/editorial_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/maps.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';
import 'package:url_launcher/url_launcher.dart';

class const EditorialFifthPage({
  super.key,
  required final EditorialFifthPageConfig config,
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
          children: [
            FadeAndSlideTransition(
              slideFrom: .top,
              slideFromOffset: .3,
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    langCode == 'en' ? 'LOCATION' : 'LOKASI ACARA',
                    style: TextStyle(
                      color: config.sectionHeaderColor,
                      fontSize: 11,
                      fontWeight: .bold,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    'VENUE & MAP',
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
            const SizedBox(height: 16),
            Expanded(
              child: FadeAndSlideTransition(
                slideFrom: .bottom,
                slideFromOffset: .2,
                child: Maps(
                  url: receptionEvent.mapsUrl,
                  borderColor: config.borderColor,
                  height: size.height,
                  width: size.width,
                ),
              ),
            ),
            const SizedBox(height: 16),
            FadeAndSlideTransition(
              slideFrom: .bottom,
              slideFromOffset: .3,
              child: Container(
                width: double.infinity,
                padding: const .all(16),
                decoration: BoxDecoration(
                  color: config.cardBackgroundColor,
                  borderRadius: .circular(4),
                  border: .all(color: config.borderColor),
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      receptionEvent.place,
                      style: TextStyle(
                        color: config.locationTitleColor,
                        fontSize: 16,
                        fontWeight: .w800,
                      ),
                    ),
                    SizedBox(height: W.x15s),
                    Text(
                      receptionEvent.address,
                      style: TextStyle(color: config.locationTitleColor, fontSize: 12),
                    ),
                    const SizedBox(height: 14),
                    QuickButton(
                      onTap: () async {
                        final uri = Uri.parse(receptionEvent.mapsUrl);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri, mode: .externalApplication);
                        }
                      },
                      style: .new(
                        padding: const .symmetric(horizontal: 14, vertical: 8),
                        color: config.mapButtonBgColor,
                        borderRadius: .circular(2),
                      ),
                      child: Row(
                        mainAxisSize: .min,
                        children: [
                          const Icon(Icons.directions, color: Colors.white, size: 14),
                          const SizedBox(width: 6),
                          Text(
                            langCode == 'en' ? 'NAVIGATE WITH MAPS' : 'PETUNJUK ARAH',
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

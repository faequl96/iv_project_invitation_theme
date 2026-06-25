import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/src/theme_family/ethnic_theme/ethnic_theme_as_image.dart';
import 'package:iv_project_invitation_theme/src/theme_family/ethnic_theme/themes/javanese_rose_gold.dart';
import 'package:iv_project_model/iv_project_model.dart';

class EthnicThemeLauncherAsImage extends StatelessWidget {
  const EthnicThemeLauncherAsImage({
    super.key,
    this.initialPage = 0,
    required this.useWrapper,
    required this.invitationThemeId,
    required this.invitationData,
    required this.brandProfile,
  });

  final int initialPage;
  final bool useWrapper;
  final int invitationThemeId;
  final InvitationDataResponse invitationData;
  final BrandProfileResponse brandProfile;

  @override
  Widget build(BuildContext context) {
    final content = EthnicThemeAsImage(
      configs: switch (invitationThemeId) {
        5 => JavaneseRoseGold.configs,
        int() => JavaneseRoseGold.configs,
      },
      initialPage: initialPage,
      useWrapper: useWrapper,
      invitationData: invitationData,
      brandProfile: brandProfile,
    );

    return content;
  }
}

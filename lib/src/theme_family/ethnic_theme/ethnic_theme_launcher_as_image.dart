import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/src/theme_family/ethnic_theme/ethnic_theme_as_image.dart';
import 'package:iv_project_invitation_theme/src/theme_family/ethnic_theme/themes/javanese_rose_gold.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const EthnicThemeLauncherAsImage({
  super.key,
  final int initialPage = 0,
  required final bool useWrapper,
  required final int invitationThemeId,
  required final InvitationDataResponse invitationData,
  required final BrandProfileResponse brandProfile,
}) extends StatelessWidget {
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

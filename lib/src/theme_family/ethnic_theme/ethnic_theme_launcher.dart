import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/ethnic_theme/ethnic_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/ethnic_theme/themes/javanese_rose_gold.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const EthnicThemeLauncher({
  super.key,
  final double heightAdjustment = 0,
  required final ViewType viewType,
  required final int invitationThemeId,
  required final String invitationId,
  required final InvitationDataResponse invitationData,
  final ImagesRaw? imagesRaw,
  required final BrandProfileResponse brandProfile,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final content = EthnicTheme(
      configs: switch (invitationThemeId) {
        5 => JavaneseRoseGold.configs,
        int() => JavaneseRoseGold.configs,
      },
      heightAdjustment: heightAdjustment,
      viewType: viewType,
      invitationId: invitationId,
      invitationData: invitationData,
      imagesRaw: imagesRaw,
      brandProfile: brandProfile,
    );

    return content;
  }
}

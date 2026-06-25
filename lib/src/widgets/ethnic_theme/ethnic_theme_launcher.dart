import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/widgets/ethnic_theme/ethnic_theme.dart';
import 'package:iv_project_invitation_theme/src/widgets/ethnic_theme/themes/javanese_rose_gold.dart';
import 'package:iv_project_model/iv_project_model.dart';

class EthnicThemeLauncher extends StatelessWidget {
  const EthnicThemeLauncher({
    super.key,
    this.heightAdjustment = 0,
    required this.viewType,
    required this.invitationThemeId,
    required this.invitationId,
    required this.invitationData,
    this.imagesRaw,
    required this.brandProfile,
  });

  final double heightAdjustment;
  final ViewType viewType;
  final int invitationThemeId;
  final String invitationId;
  final InvitationDataResponse invitationData;
  final ImagesRaw? imagesRaw;
  final BrandProfileResponse brandProfile;

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

import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/elysian_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/themes/elysian_champagne_preset.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const ElysianThemeLauncher({
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
    return ElysianTheme(
      configs: switch (invitationThemeId) {
        9 => ElysianChampagnePreset.configs,
        int() => ElysianChampagnePreset.configs,
      },
      heightAdjustment: heightAdjustment,
      viewType: viewType,
      invitationId: invitationId,
      invitationData: invitationData,
      imagesRaw: imagesRaw,
      brandProfile: brandProfile,
    );
  }
}

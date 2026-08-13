import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/glass_theme/glass_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/glass_theme/themes/black_and_white_glass.dart';
import 'package:iv_project_invitation_theme/src/theme_family/glass_theme/themes/blue_sky_glass.dart';
import 'package:iv_project_invitation_theme/src/theme_family/glass_theme/themes/green_matcha_glass.dart';
import 'package:iv_project_invitation_theme/src/theme_family/glass_theme/themes/red_velvet_glass.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const GlassThemeLauncher({
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
    final content = GlassTheme(
      configs: switch (invitationThemeId) {
        1 => BlackAndWhiteGlass.configs,
        2 => RedVelvetGlass.configs,
        3 => GreenMatchaGlass.configs,
        4 => BlueSkyGlass.configs,
        int() => BlackAndWhiteGlass.configs,
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

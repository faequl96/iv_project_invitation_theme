import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/glass_theme/glass_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/glass_theme/themes/black_and_white_glass.dart';
import 'package:iv_project_invitation_theme/src/theme_family/glass_theme/themes/blue_sky_glass.dart';
import 'package:iv_project_invitation_theme/src/theme_family/glass_theme/themes/green_matcha_glass.dart';
import 'package:iv_project_invitation_theme/src/theme_family/glass_theme/themes/red_velvet_glass.dart';
import 'package:iv_project_model/iv_project_model.dart';

class GlassThemeLauncher extends StatelessWidget {
  const GlassThemeLauncher({
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

import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/src/theme_family/glass_theme/glass_theme_as_image.dart';
import 'package:iv_project_invitation_theme/src/theme_family/glass_theme/themes/black_and_white_glass.dart';
import 'package:iv_project_invitation_theme/src/theme_family/glass_theme/themes/blue_sky_glass.dart';
import 'package:iv_project_invitation_theme/src/theme_family/glass_theme/themes/green_matcha_glass.dart';
import 'package:iv_project_invitation_theme/src/theme_family/glass_theme/themes/red_velvet_glass.dart';
import 'package:iv_project_model/iv_project_model.dart';

class GlassThemeLauncherAsImage extends StatelessWidget {
  const GlassThemeLauncherAsImage({
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
    final content = GlassThemeAsImage(
      configs: switch (invitationThemeId) {
        1 => BlackAndWhiteGlass.configs,
        2 => RedVelvetGlass.configs,
        3 => GreenMatchaGlass.configs,
        4 => BlueSkyGlass.configs,
        int() => BlackAndWhiteGlass.configs,
      },
      initialPage: initialPage,
      useWrapper: useWrapper,
      invitationData: invitationData,
      brandProfile: brandProfile,
    );
    return content;
  }
}

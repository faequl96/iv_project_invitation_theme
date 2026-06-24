import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/src/theme_family/generic_theme/generic_theme_as_image.dart';
import 'package:iv_project_invitation_theme/src/theme_family/generic_theme/themes/black_and_white_glass.dart';
import 'package:iv_project_invitation_theme/src/theme_family/generic_theme/themes/blue_sky_glass.dart';
import 'package:iv_project_invitation_theme/src/theme_family/generic_theme/themes/floral_canvas.dart';
import 'package:iv_project_invitation_theme/src/theme_family/generic_theme/themes/green_matcha_glass.dart';
import 'package:iv_project_invitation_theme/src/theme_family/generic_theme/themes/javanese_rose_gold.dart';
import 'package:iv_project_invitation_theme/src/theme_family/generic_theme/themes/red_velvet_glass.dart';
import 'package:iv_project_model/iv_project_model.dart';

class GenericThemeLauncherAsImage extends StatelessWidget {
  const GenericThemeLauncherAsImage({
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
    final content = GenericThemeAsImage(
      configs: switch (invitationThemeId) {
        1 => BlackAndWhiteGlass.configs,
        2 => RedVelvetGlass.configs,
        3 => GreenMatchaGlass.configs,
        4 => BlueSkyGlass.configs,
        5 => JavaneseRoseGold.configs,
        6 => FloralCanvas.configs,
        int() => JavaneseRoseGold.configs,
      },
      initialPage: initialPage,
      useWrapper: useWrapper,
      invitationData: invitationData,
      brandProfile: brandProfile,
    );

    final themeData = switch (invitationThemeId) {
      1 => BlackAndWhiteGlass.themeData,
      2 => RedVelvetGlass.themeData,
      3 => GreenMatchaGlass.themeData,
      4 => BlueSkyGlass.themeData,
      5 => JavaneseRoseGold.themeData,
      6 => FloralCanvas.themeData,
      int() => JavaneseRoseGold.themeData,
    };

    if (themeData == null) return content;

    return Theme(data: themeData, child: content);
  }
}

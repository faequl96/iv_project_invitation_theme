import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/gemini_star_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/themes/black_and_white_gemini_star.dart';
import 'package:iv_project_model/iv_project_model.dart';

class GeminiStarThemeLauncher extends StatelessWidget {
  const GeminiStarThemeLauncher({
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
    final content = GeminiStarTheme(
      configs: switch (invitationThemeId) {
        7 => BlackAndWhiteGeminiStar.configs,
        int() => BlackAndWhiteGeminiStar.configs,
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

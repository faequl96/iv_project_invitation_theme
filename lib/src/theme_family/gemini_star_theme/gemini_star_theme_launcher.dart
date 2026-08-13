import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/gemini_star_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/themes/black_and_white_gemini_star.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const GeminiStarThemeLauncher({
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

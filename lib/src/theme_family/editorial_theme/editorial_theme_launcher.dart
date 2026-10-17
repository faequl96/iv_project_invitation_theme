import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/editorial_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/themes/monochrome_editorial.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const EditorialThemeLauncher({
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
    final content = EditorialTheme(
      configs: switch (invitationThemeId) {
        8 => MonochromeEditorial.configs,
        int() => MonochromeEditorial.configs,
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

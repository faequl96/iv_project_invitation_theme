import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/generic_theme/generic_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/generic_theme/themes/floral_canvas.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const GenericThemeLauncher({
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
    final content = GenericTheme(
      configs: switch (invitationThemeId) {
        6 => FloralCanvas.configs,
        int() => FloralCanvas.configs,
      },
      heightAdjustment: heightAdjustment,
      viewType: viewType,
      invitationId: invitationId,
      invitationData: invitationData,
      imagesRaw: imagesRaw,
      brandProfile: brandProfile,
    );

    final themeData = switch (invitationThemeId) {
      6 => FloralCanvas.themeData,
      int() => FloralCanvas.themeData,
    };

    return Theme(data: themeData, child: content);
  }
}

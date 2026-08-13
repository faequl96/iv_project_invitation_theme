import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/src/theme_family/generic_theme/generic_theme_as_image.dart';
import 'package:iv_project_invitation_theme/src/theme_family/generic_theme/themes/floral_canvas.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const GenericThemeLauncherAsImage({
  super.key,
  final int initialPage = 0,
  required final bool useWrapper,
  required final int invitationThemeId,
  required final InvitationDataResponse invitationData,
  required final BrandProfileResponse brandProfile,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final content = GenericThemeAsImage(
      configs: switch (invitationThemeId) {
        6 => FloralCanvas.configs,
        int() => FloralCanvas.configs,
      },
      initialPage: initialPage,
      useWrapper: useWrapper,
      invitationData: invitationData,
      brandProfile: brandProfile,
    );

    final themeData = switch (invitationThemeId) {
      6 => FloralCanvas.themeData,
      int() => FloralCanvas.themeData,
    };

    return Theme(data: themeData, child: content);
  }
}

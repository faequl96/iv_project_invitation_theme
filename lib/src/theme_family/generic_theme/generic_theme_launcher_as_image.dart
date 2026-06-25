import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/src/theme_family/generic_theme/generic_theme_as_image.dart';
import 'package:iv_project_invitation_theme/src/theme_family/generic_theme/themes/floral_canvas.dart';
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

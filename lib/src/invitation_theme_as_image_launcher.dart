import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/src/theme_family/generic_theme/generic_theme_launcher_as_image.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const InvitationThemeAsImageLauncher({
  super.key,
  final int initialPage = 0,
  final bool useWrapper = true,
  required final int invitationThemeId,
  required final InvitationDataResponse invitationData,
  required final BrandProfileResponse brandProfile,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const .linear(1)),
      child: _buildContent(),
    );
  }

  Widget _buildContent() => switch (invitationThemeId) {
    1 || 2 || 3 || 4 || 5 || 6 => GenericThemeLauncherAsImage(
      initialPage: initialPage,
      useWrapper: useWrapper,
      invitationThemeId: invitationThemeId,
      invitationData: invitationData,
      brandProfile: brandProfile,
    ),
    _ => const SizedBox.shrink(),
  };
}

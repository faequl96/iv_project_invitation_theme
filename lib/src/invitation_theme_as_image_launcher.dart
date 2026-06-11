import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/src/theme_types/page_view_tab_bar/page_view_tab_bar_theme_launcher_as_image.dart';
import 'package:iv_project_model/iv_project_model.dart';

class InvitationThemeAsImageLauncher extends StatelessWidget {
  const InvitationThemeAsImageLauncher({
    super.key,
    this.initialPage = 0,
    this.useWrapper = true,
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
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const .linear(1)),
      child: _buildContent(),
    );
  }

  Widget _buildContent() => switch (invitationThemeId) {
    1 || 2 || 3 || 4 || 5 || 6 => PageViewTabBarThemeLauncherAsImage(
      initialPage: initialPage,
      useWrapper: useWrapper,
      invitationThemeId: invitationThemeId,
      invitationData: invitationData,
      brandProfile: brandProfile,
    ),
    _ => const SizedBox.shrink(),
  };
}

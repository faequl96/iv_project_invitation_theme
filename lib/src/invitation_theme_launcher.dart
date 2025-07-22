import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/src/models/invitation.dart';
import 'package:iv_project_invitation_theme/src/themes/try_theme/try_theme.dart';

class InvitationThemeLauncher extends StatefulWidget {
  const InvitationThemeLauncher({super.key, required this.invitation});

  final Invitation invitation;

  @override
  State<InvitationThemeLauncher> createState() => _InvitationThemeLauncherState();
}

class _InvitationThemeLauncherState extends State<InvitationThemeLauncher> {
  @override
  Widget build(BuildContext context) {
    switch (widget.invitation.themeId) {
      case 1:
        return TryTheme(invitation: widget.invitation);
      default:
        return const SizedBox.shrink();
    }
  }
}

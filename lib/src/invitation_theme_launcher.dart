import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/src/models/invitation.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/elegant_black_and_white_glass.dart';

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
        return ElegantBlackAndWhiteGlass(invitation: widget.invitation);
      default:
        return const SizedBox.shrink();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_types/page_view_tab_bar/page_view_tab_bar_theme_launcher.dart';
import 'package:iv_project_model/iv_project_model.dart';

class InvitationThemeLauncher extends StatefulWidget {
  const InvitationThemeLauncher({
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
  State<InvitationThemeLauncher> createState() => _InvitationThemeLauncherState();
}

class _InvitationThemeLauncherState extends State<InvitationThemeLauncher> {
  @override
  void initState() {
    super.initState();

    context.read<InvitationThemeCoreCubit>().state.copyWith(animationTrigger: 0).emitState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const .linear(1)),
      child: _buildContent(),
    );
  }

  Widget _buildContent() => switch (widget.invitationThemeId) {
    1 || 2 || 3 || 4 || 5 || 6 => PageViewTabBarThemeLauncher(
      heightAdjustment: widget.heightAdjustment,
      viewType: widget.viewType,
      invitationThemeId: widget.invitationThemeId,
      invitationId: widget.invitationId,
      invitationData: widget.invitationData,
      imagesRaw: widget.imagesRaw,
      brandProfile: widget.brandProfile,
    ),
    _ => const SizedBox.shrink(),
  };
}

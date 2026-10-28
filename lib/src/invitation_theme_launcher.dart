import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/editorial_theme_launcher.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/elysian_theme_launcher.dart';
import 'package:iv_project_invitation_theme/src/theme_family/ethnic_theme/ethnic_theme_launcher.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/gemini_star_theme_launcher.dart';
// import 'package:iv_project_invitation_theme/src/theme_types/page_view_immersive/page_view_immersive_theme_launcher.dart';
import 'package:iv_project_invitation_theme/src/theme_family/generic_theme/generic_theme_launcher.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const InvitationThemeLauncher({
  super.key,
  final double heightAdjustment = 0,
  required final ViewType viewType,
  required final int invitationThemeId,
  required final String invitationId,
  required final InvitationDataResponse invitationData,
  final ImagesRaw? imagesRaw,
  required final BrandProfileResponse brandProfile,
}) extends StatefulWidget {
  @override
  State<InvitationThemeLauncher> createState() => _InvitationThemeLauncherState();
}

class _InvitationThemeLauncherState() extends State<InvitationThemeLauncher> {
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
    1 || 2 || 3 || 4 || 5 => GenericThemeLauncher(
      heightAdjustment: widget.heightAdjustment,
      viewType: widget.viewType,
      invitationThemeId: widget.invitationThemeId,
      invitationId: widget.invitationId,
      invitationData: widget.invitationData,
      imagesRaw: widget.imagesRaw,
      brandProfile: widget.brandProfile,
    ),
    6 => EthnicThemeLauncher(
      heightAdjustment: widget.heightAdjustment,
      viewType: widget.viewType,
      invitationThemeId: widget.invitationThemeId,
      invitationId: widget.invitationId,
      invitationData: widget.invitationData,
      imagesRaw: widget.imagesRaw,
      brandProfile: widget.brandProfile,
    ),
    7 => GeminiStarThemeLauncher(
      heightAdjustment: widget.heightAdjustment,
      viewType: widget.viewType,
      invitationThemeId: widget.invitationThemeId,
      invitationId: widget.invitationId,
      invitationData: widget.invitationData,
      imagesRaw: widget.imagesRaw,
      brandProfile: widget.brandProfile,
    ),
    8 => EditorialThemeLauncher(
      heightAdjustment: widget.heightAdjustment,
      viewType: widget.viewType,
      invitationThemeId: widget.invitationThemeId,
      invitationId: widget.invitationId,
      invitationData: widget.invitationData,
      imagesRaw: widget.imagesRaw,
      brandProfile: widget.brandProfile,
    ),
    9 => ElysianThemeLauncher(
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

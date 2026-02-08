import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/elegant_black_and_white_glass.dart';
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
    this.useWrapper = true,
    this.initialPage = 0,
    this.isSinglePageView = false,
  });

  final double heightAdjustment;
  final ViewType viewType;
  final int invitationThemeId;
  final String invitationId;
  final InvitationDataResponse invitationData;
  final ImagesRaw? imagesRaw;
  final BrandProfileResponse brandProfile;
  final bool useWrapper;
  final int initialPage;
  final bool isSinglePageView;

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
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: _content(),
    );
  }

  Widget _content() {
    switch (widget.invitationThemeId) {
      case 1:
        return ElegantBlackAndWhiteGlass(
          heightAdjustment: widget.heightAdjustment,
          viewType: widget.viewType,
          invitationId: widget.invitationId,
          invitationData: widget.invitationData,
          imagesRaw: widget.imagesRaw,
          brandProfile: widget.brandProfile,
          useWrapper: widget.useWrapper,
          initialPage: widget.initialPage,
          isSinglePageView: widget.isSinglePageView,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

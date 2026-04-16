import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/themes/canvas/canvas_theme.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/elegant_black_and_white_glass.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_blue_sky_glass/elegant_blue_sky_glass.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_green_matcha_glass/elegant_green_matcha_glass.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_red_velvet_glass/elegant_red_velvet_glass.dart';
import 'package:iv_project_invitation_theme/src/themes/javanese_rose_gold/javanese_rose_gold.dart';
import 'package:iv_project_model/iv_project_model.dart';

class InvitationThemeLauncher extends StatefulWidget {
  const InvitationThemeLauncher({
    super.key,
    this.heightAdjustment = 0,
    this.initialPage = 0,
    this.useWrapper = true,
    this.viewAsSinglePage = false,
    required this.viewType,
    required this.invitationThemeId,
    required this.invitationId,
    required this.invitationData,
    this.imagesRaw,
    required this.brandProfile,
  });

  final double heightAdjustment;
  final int initialPage;
  final bool useWrapper;
  final bool viewAsSinglePage;
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
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: _content,
    );
  }

  Widget get _content => switch (widget.invitationThemeId) {
    1 => ElegantBlackAndWhiteGlass(
      heightAdjustment: widget.heightAdjustment,
      initialPage: widget.initialPage,
      useWrapper: widget.useWrapper,
      viewAsSinglePage: widget.viewAsSinglePage,
      viewType: widget.viewType,
      invitationId: widget.invitationId,
      invitationData: widget.invitationData,
      imagesRaw: widget.imagesRaw,
      brandProfile: widget.brandProfile,
    ),
    2 => ElegantRedVelvetGlass(
      heightAdjustment: widget.heightAdjustment,
      initialPage: widget.initialPage,
      useWrapper: widget.useWrapper,
      viewAsSinglePage: widget.viewAsSinglePage,
      viewType: widget.viewType,
      invitationId: widget.invitationId,
      invitationData: widget.invitationData,
      imagesRaw: widget.imagesRaw,
      brandProfile: widget.brandProfile,
    ),
    3 => ElegantGreenMatchaGlass(
      heightAdjustment: widget.heightAdjustment,
      initialPage: widget.initialPage,
      useWrapper: widget.useWrapper,
      viewAsSinglePage: widget.viewAsSinglePage,
      viewType: widget.viewType,
      invitationId: widget.invitationId,
      invitationData: widget.invitationData,
      imagesRaw: widget.imagesRaw,
      brandProfile: widget.brandProfile,
    ),
    4 => ElegantBlueSkyGlass(
      heightAdjustment: widget.heightAdjustment,
      initialPage: widget.initialPage,
      useWrapper: widget.useWrapper,
      viewAsSinglePage: widget.viewAsSinglePage,
      viewType: widget.viewType,
      invitationId: widget.invitationId,
      invitationData: widget.invitationData,
      imagesRaw: widget.imagesRaw,
      brandProfile: widget.brandProfile,
    ),
    5 => JavaneseRoseGold(
      heightAdjustment: widget.heightAdjustment,
      initialPage: widget.initialPage,
      useWrapper: widget.useWrapper,
      viewAsSinglePage: widget.viewAsSinglePage,
      viewType: widget.viewType,
      invitationId: widget.invitationId,
      invitationData: widget.invitationData,
      imagesRaw: widget.imagesRaw,
      brandProfile: widget.brandProfile,
    ),
    6 => CanvasTheme(
      heightAdjustment: widget.heightAdjustment,
      initialPage: widget.initialPage,
      useWrapper: widget.useWrapper,
      viewAsSinglePage: widget.viewAsSinglePage,
      viewType: widget.viewType,
      invitationId: widget.invitationId,
      invitationData: widget.invitationData,
      imagesRaw: widget.imagesRaw,
      brandProfile: widget.brandProfile,
    ),
    int() => const SizedBox.shrink(),
  };
}

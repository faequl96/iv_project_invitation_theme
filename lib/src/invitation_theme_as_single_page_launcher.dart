import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/themes/canvas/canvas_theme_as_single_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/elegant_black_and_white_glass_as_single_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_blue_sky_glass/elegant_blue_sky_glass_as_single_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_green_matcha_glass/elegant_green_matcha_glass_as_single_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_red_velvet_glass/elegant_red_velvet_glass_as_single_page.dart';
import 'package:iv_project_invitation_theme/src/themes/javanese_rose_gold/javanese_rose_gold_as_single_page.dart';
import 'package:iv_project_model/iv_project_model.dart';

class InvitationThemeAsSinglePageLauncher extends StatefulWidget {
  const InvitationThemeAsSinglePageLauncher({
    super.key,
    this.heightAdjustment = 0,
    this.initialPage = 0,
    this.useWrapper = true,
    required this.invitationThemeId,
    required this.invitationData,
    required this.brandProfile,
  });

  final double heightAdjustment;
  final int initialPage;
  final bool useWrapper;
  final int invitationThemeId;
  final InvitationDataResponse invitationData;
  final BrandProfileResponse brandProfile;

  @override
  State<InvitationThemeAsSinglePageLauncher> createState() => _InvitationThemeAsSinglePageLauncherState();
}

class _InvitationThemeAsSinglePageLauncherState extends State<InvitationThemeAsSinglePageLauncher> {
  @override
  void initState() {
    super.initState();

    context.read<InvitationThemeCoreCubit>().state.copyWith(animationTrigger: 0).emitState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const .linear(1)),
      child: _content,
    );
  }

  Widget get _content => switch (widget.invitationThemeId) {
    1 => ElegantBlackAndWhiteGlassAsSinglePage(
      initialPage: widget.initialPage,
      useWrapper: widget.useWrapper,
      invitationData: widget.invitationData,
      brandProfile: widget.brandProfile,
    ),
    2 => ElegantRedVelvetGlassAsSinglePage(
      initialPage: widget.initialPage,
      useWrapper: widget.useWrapper,
      invitationData: widget.invitationData,
      brandProfile: widget.brandProfile,
    ),
    3 => ElegantGreenMatchaGlassAsSinglePage(
      initialPage: widget.initialPage,
      useWrapper: widget.useWrapper,
      invitationData: widget.invitationData,
      brandProfile: widget.brandProfile,
    ),
    4 => ElegantBlueSkyGlassAsSinglePage(
      initialPage: widget.initialPage,
      useWrapper: widget.useWrapper,
      invitationData: widget.invitationData,
      brandProfile: widget.brandProfile,
    ),
    5 => JavaneseRoseGoldAsSinglePage(
      initialPage: widget.initialPage,
      useWrapper: widget.useWrapper,
      invitationData: widget.invitationData,
      brandProfile: widget.brandProfile,
    ),
    6 => CanvasThemeAsSinglePage(
      initialPage: widget.initialPage,
      useWrapper: widget.useWrapper,
      invitationData: widget.invitationData,
      brandProfile: widget.brandProfile,
    ),
    int() => const SizedBox.shrink(),
  };
}

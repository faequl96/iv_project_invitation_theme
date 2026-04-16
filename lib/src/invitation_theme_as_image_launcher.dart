import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/src/themes/canvas/canvas_theme_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/elegant_black_and_white_glass_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_blue_sky_glass/elegant_blue_sky_glass_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_green_matcha_glass/elegant_green_matcha_glass_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_red_velvet_glass/elegant_red_velvet_glass_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/javanese_rose_gold/javanese_rose_gold_as_image.dart';
import 'package:iv_project_model/iv_project_model.dart';

class InvitationThemeAsImageLauncher extends StatelessWidget {
  const InvitationThemeAsImageLauncher({
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
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: _content,
    );
  }

  Widget get _content => switch (invitationThemeId) {
    1 => ElegantBlackAndWhiteGlassAsImage(
      heightAdjustment: heightAdjustment,
      initialPage: initialPage,
      useWrapper: useWrapper,
      invitationData: invitationData,
      brandProfile: brandProfile,
    ),
    2 => ElegantRedVelvetGlassAsImage(
      heightAdjustment: heightAdjustment,
      initialPage: initialPage,
      useWrapper: useWrapper,
      invitationData: invitationData,
      brandProfile: brandProfile,
    ),
    3 => ElegantGreenMatchaGlassAsImage(
      heightAdjustment: heightAdjustment,
      initialPage: initialPage,
      useWrapper: useWrapper,
      invitationData: invitationData,
      brandProfile: brandProfile,
    ),
    4 => ElegantBlueSkyGlassAsImage(
      heightAdjustment: heightAdjustment,
      initialPage: initialPage,
      useWrapper: useWrapper,
      invitationData: invitationData,
      brandProfile: brandProfile,
    ),
    5 => JavaneseRoseGoldAsImage(
      heightAdjustment: heightAdjustment,
      initialPage: initialPage,
      useWrapper: useWrapper,
      invitationData: invitationData,
      brandProfile: brandProfile,
    ),
    6 => CanvasThemeAsImage(
      heightAdjustment: heightAdjustment,
      initialPage: initialPage,
      useWrapper: useWrapper,
      invitationData: invitationData,
      brandProfile: brandProfile,
    ),
    int() => const SizedBox.shrink(),
  };
}

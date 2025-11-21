import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/elegant_black_and_white_glass.dart';
import 'package:iv_project_model/iv_project_model.dart';

class InvitationThemeLauncher extends StatelessWidget {
  const InvitationThemeLauncher({
    super.key,
    this.heightAdjustment = 0,
    required this.previewType,
    required this.invitationThemeId,
    required this.invitationId,
    required this.invitationData,
    this.imagesRaw,
    required this.brandProfile,
  });

  final double heightAdjustment;
  final ThemePreviewType previewType;
  final int invitationThemeId;
  final String invitationId;
  final InvitationDataResponse invitationData;
  final ImagesRaw? imagesRaw;
  final BrandProfileResponse brandProfile;

  @override
  Widget build(BuildContext context) {
    context.read<InvitationThemeCoreCubit>().state.copyWith(animationTrigger: 0).emitState();

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: _content(),
    );
  }

  Widget _content() {
    switch (invitationThemeId) {
      case 1:
        return ElegantBlackAndWhiteGlass(
          heightAdjustment: heightAdjustment,
          previewType: previewType,
          invitationId: invitationId,
          invitationData: invitationData,
          imagesRaw: imagesRaw,
          brandProfile: brandProfile,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

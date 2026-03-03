import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/theme_colors.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/page_view_based.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_cover_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_first_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_second_page.dart';
import 'package:iv_project_invitation_theme/src/widgets/cover_background.dart';
import 'package:iv_project_invitation_theme/src/widgets/group_background.dart';
import 'package:iv_project_invitation_theme/src/widgets/group_frontground.dart';
import 'package:iv_project_model/iv_project_model.dart';

class JavaneseRoseGold extends StatelessWidget {
  const JavaneseRoseGold({
    super.key,
    this.heightAdjustment = 0,
    this.initialPage = 0,
    this.viewAsImage = false,
    required this.viewType,
    required this.invitationId,
    required this.invitationData,
    this.imagesRaw,
    required this.brandProfile,
  });

  final double heightAdjustment;
  final int initialPage;
  final bool viewAsImage;
  final ViewType viewType;
  final String invitationId;
  final InvitationDataResponse invitationData;
  final ImagesRaw? imagesRaw;
  final BrandProfileResponse brandProfile;

  @override
  Widget build(BuildContext context) {
    return PageViewBased(
      configs: PageViewBasedConfigs(
        tabConfig: const PageViewBasedTabConfig(
          indicatorColor: ThemeColors.gold,
          titleActiveColor: ThemeColors.gold,
          titleInactiveColor: ThemeColors.roseGold,
          iconActiveColor: ThemeColors.gold,
          iconInactiveColor: ThemeColors.roseGold,
        ),
        globalBackgroundBuilder: () => SizedBox(
          width: Screen.width,
          height: Screen.height,
          child: const ColoredBox(color: Color.fromARGB(255, 11, 15, 19)),
        ),
        coverPageConfig: PageViewBasedCoverPageConfig(
          coverBackground: const CoverBackground(),
          brideNameColor: ThemeColors.roseGold,
          groomNameColor: ThemeColors.gold,
          countdownBorderWidth: 2,
          countdownOddColor: ThemeColors.gold.withValues(alpha: .1),
          countdownEvenColor: ThemeColors.roseGold.withValues(alpha: .1),
          countdownOddBorderColor: ThemeColors.gold,
          countdownEvenBorderColor: ThemeColors.roseGold,
          countdownNumberColor: ThemeColors.gold,
          countdownUnitColor: ThemeColors.roseGold,
          countdownUseLightningEffect: false,
          firstArrowColor: ThemeColors.gold.withValues(alpha: .9),
          secondArrowColor: ThemeColors.roseGold.withValues(alpha: .7),
        ),
        firstPageConfig: PageViewBasedFirstPageConfig(
          frontground: const GroupFrontground(),
          background: const GroupBackground(),
          useGradientBackground: false,
          useBackdropBlurOnScaffold: false,
          scaffoldColor: Colors.black.withValues(alpha: .7),
          scaffoldBorder: const GradientBoxBorder(
            width: 3,
            gradient: LinearGradient(
              begin: .topLeft,
              end: .bottomRight,
              colors: [ThemeColors.roseGold, ThemeColors.gold, ThemeColors.roseGold, ThemeColors.gold],
              transform: GradientRotation(-0.2),
            ),
          ),
          useGlassEffectOnScaffold: false,
          titlePageColor: ThemeColors.gold,
          firstSubScaffoldColor: Colors.grey.shade800.withValues(alpha: .7),
          firstSubScaffoldBorderColor: ThemeColors.gold,
          firstSubScaffoldBorderWidth: 2,
          secondSubScaffoldColor: Colors.grey.shade800.withValues(alpha: .7),
          secondSubScaffoldBorderColor: ThemeColors.gold,
          secondSubScaffoldBorderWidth: 2,
        ),
        secondPageConfig: PageViewBasedSecondPageConfig(
          frontground: const GroupFrontground(),
          background: const GroupBackground(),
          useGradientBackground: false,
          useBackdropBlurOnScaffold: false,
          scaffoldColor: Colors.black.withValues(alpha: .7),
          scaffoldBorder: const GradientBoxBorder(
            width: 3,
            gradient: LinearGradient(
              begin: .topLeft,
              end: .bottomRight,
              colors: [ThemeColors.roseGold, ThemeColors.gold, ThemeColors.roseGold, ThemeColors.gold],
              transform: GradientRotation(-0.2),
            ),
          ),
          useGlassEffectOnScaffold: false,
          titlePageColor: ThemeColors.gold,
          brideDividingBorderWidth: 2,
          brideImageBorderWidth: 2,
          brideDividingLineWidth: 1,
          brideDividingBorderColor: ThemeColors.roseGold,
          brideImageBaseColor: ThemeColors.roseGold,
          brideDividingLineColor: ThemeColors.roseGold,
          brideNameTextColor: ThemeColors.roseGold,
          brideFatherNameTextColor: ThemeColors.gold,
          brideMotherNameTextColor: ThemeColors.roseGold,
          groomDividingBorderWidth: 2,
          groomImageBorderWidth: 2,
          groomDividingLineWidth: 1,
          groomDividingBorderColor: ThemeColors.gold,
          groomImageBaseColor: ThemeColors.gold,
          groomDividingLineColor: ThemeColors.gold,
          groomNameTextColor: ThemeColors.gold,
          groomFatherNameTextColor: ThemeColors.gold,
          groomMotherNameTextColor: ThemeColors.roseGold,
        ),
      ),
      heightAdjustment: heightAdjustment,
      initialPage: initialPage,
      viewAsImage: viewAsImage,
      viewType: viewType,
      invitationId: invitationId,
      invitationData: invitationData,
      imagesRaw: imagesRaw,
      brandProfile: brandProfile,
    );
  }
}

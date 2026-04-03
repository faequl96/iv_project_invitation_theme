import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/theme_colors.dart';
import 'package:iv_project_invitation_theme/src/page_types/page_view_with_bottom_tab_bar.dart';
import 'package:iv_project_invitation_theme/src/themes/canvas/canvas_theme_background.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/page_view_based.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_cover_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_eighth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_fifth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_first_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_fourth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_second_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_seventh_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_sixth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_third_page.dart';
import 'package:iv_project_invitation_theme/src/widgets/group_background.dart';
import 'package:iv_project_invitation_theme/src/widgets/group_frontground.dart';
import 'package:iv_project_invitation_theme/src/widgets/particle_sphere.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class CanvasTheme extends StatelessWidget {
  const CanvasTheme({
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
        tabConfig: TabConfig(
          useGlassEffect: false,
          useBackdropBlur: false,
          widthFull: true,
          indicatorColor: ColorConverter.darken(Colors.blue.shade400, 50),
          backgroundColor: Colors.white.withValues(alpha: .0),
          titleActiveColor: ColorConverter.darken(Colors.blue.shade400, 50),
          titleInactiveColor: Colors.white,
          iconActiveColor: ColorConverter.darken(Colors.blue.shade400, 50),
          iconInactiveColor: Colors.white,
        ),
        globalBackgroundsBuilder: () => [const CanvasThemeBackground()],
        particleSphere: ParticleSphereConfig(
          particleCount: 22,
          particleVariatios: [
            Particle.image(imagePath: 'assets/backgrounds/floral_leaf.png'),
            Particle.image(imagePath: 'assets/backgrounds/floral_flower_pink.png'),
            Particle.image(imagePath: 'assets/backgrounds/floral_flower_blue.png'),
            Particle.image(imagePath: 'assets/backgrounds/floral_flower_pink.png'),
          ],
        ),
        coverPageConfig: PageViewBasedCoverPageConfig(
          gradientBaseColor: ColorConverter.darken(Colors.blue.shade700, 60),
          brideNameColor: ColorConverter.darken(Colors.blue.shade100, 10),
          groomNameColor: ColorConverter.darken(Colors.blue.shade100, 10),
          countdownBorderWidth: 2,
          countdownOddColor: ColorConverter.darken(Colors.blue.shade100, 10).withValues(alpha: .1),
          countdownEvenColor: ColorConverter.darken(Colors.blue.shade100, 10).withValues(alpha: .1),
          countdownOddBorderColor: ColorConverter.darken(Colors.blue.shade100, 10),
          countdownEvenBorderColor: ColorConverter.darken(Colors.blue.shade100, 10),
          countdownNumberColor: ColorConverter.darken(Colors.blue.shade50, 5),
          countdownUnitColor: ColorConverter.darken(Colors.blue.shade50, 5),
          useLightningEffectOnCountdown: false,
          firstArrowColor: ColorConverter.darken(Colors.blue.shade100, 5),
          secondArrowColor: ColorConverter.darken(Colors.blue.shade100, 25).withValues(alpha: .8),
        ),
        firstPageConfig: PageViewBasedFirstPageConfig(
          // frontground: const GroupFrontground(),
          // background: const GroupBackground(),
          useBackdropBlurOnScaffold: false,
          firstGradientScaffoldColor: Colors.white.withValues(alpha: .85),
          secondGradientScaffoldColor: ColorConverter.lighten(Colors.blue.shade50, 10).withValues(alpha: .9),
          scaffoldBorder: GradientBoxBorder(
            width: 4,
            gradient: LinearGradient(
              begin: .topCenter,
              end: .bottomCenter,
              colors: [ColorConverter.darken(Colors.blue.shade100, 10), ColorConverter.darken(Colors.blue.shade300, 30)],
              transform: const GradientRotation(-.2),
            ),
          ),
          useGlassEffectOnScaffold: false,
          titlePageColor: Colors.white,
          openingTextColor: ColorConverter.darken(Colors.blue.shade500, 40),
          generalTextColor: ColorConverter.darken(Colors.blue.shade500, 40),
          firstSubScaffoldColor: ColorConverter.darken(Colors.blue.shade200, 20).withValues(alpha: .2),
          firstSubScaffoldBorderColor: Colors.white,
          firstSubScaffoldBorderWidth: 2.5,
          secondSubScaffoldColor: ColorConverter.darken(Colors.blue.shade200, 20).withValues(alpha: .2),
          secondSubScaffoldBorderColor: Colors.white,
          secondSubScaffoldBorderWidth: 2.5,
        ),
        secondPageConfig: PageViewBasedSecondPageConfig(
          // frontground: const GroupFrontground(),
          // background: const GroupBackground(),
          useBackdropBlurOnScaffold: false,
          firstGradientScaffoldColor: Colors.white.withValues(alpha: .85),
          secondGradientScaffoldColor: ColorConverter.lighten(Colors.blue.shade50, 10).withValues(alpha: .9),
          scaffoldBorder: GradientBoxBorder(
            width: 4,
            gradient: LinearGradient(
              begin: .topCenter,
              end: .bottomCenter,
              colors: [ColorConverter.darken(Colors.blue.shade100, 10), ColorConverter.darken(Colors.blue.shade300, 30)],
              transform: const GradientRotation(-.2),
            ),
          ),
          useGlassEffectOnScaffold: false,
          titlePageColor: Colors.white,
          generalTextColor: ColorConverter.darken(Colors.blue.shade300, 40),
          brideDividingBorderWidth: 2,
          brideImageBorderWidth: 2,
          brideDividingLineWidth: 1,
          brideDividingBorderColor: ColorConverter.darken(Colors.blue.shade500, 40),
          brideImageBaseColor: Colors.white,
          brideDividingLineColor: ColorConverter.darken(Colors.blue.shade500, 40),
          brideNameTextColor: ColorConverter.darken(Colors.blue.shade500, 40),
          brideFatherNameTextColor: ColorConverter.darken(Colors.blue.shade500, 40),
          brideMotherNameTextColor: ColorConverter.darken(Colors.blue.shade500, 40),
          groomDividingBorderWidth: 2,
          groomImageBorderWidth: 2,
          groomDividingLineWidth: 1,
          groomDividingBorderColor: ColorConverter.darken(Colors.blue.shade500, 40),
          groomImageBaseColor: Colors.white,
          groomDividingLineColor: ColorConverter.darken(Colors.blue.shade500, 40),
          groomNameTextColor: ColorConverter.darken(Colors.blue.shade500, 40),
          groomFatherNameTextColor: ColorConverter.darken(Colors.blue.shade500, 40),
          groomMotherNameTextColor: ColorConverter.darken(Colors.blue.shade500, 40),
        ),
        thirdPageConfig: PageViewBasedThirdPageConfig(
          // frontground: const GroupFrontground(),
          // background: const GroupBackground(),
          useBackdropBlurOnScaffold: false,
          firstGradientScaffoldColor: Colors.white.withValues(alpha: .85),
          secondGradientScaffoldColor: ColorConverter.lighten(Colors.blue.shade50, 10).withValues(alpha: .9),
          scaffoldBorder: GradientBoxBorder(
            width: 4,
            gradient: LinearGradient(
              begin: .topCenter,
              end: .bottomCenter,
              colors: [ColorConverter.darken(Colors.blue.shade100, 10), ColorConverter.darken(Colors.blue.shade300, 30)],
              transform: const GradientRotation(-.2),
            ),
          ),
          useGlassEffectOnScaffold: false,
          titlePageColor: Colors.white,
          contractTitleColor: ColorConverter.darken(Colors.blue.shade500, 40),
          contractBaseTextColor: ColorConverter.darken(Colors.blue.shade500, 40),
          receptionTitleColor: ColorConverter.darken(Colors.blue.shade500, 40),
          receptionBaseTextColor: ColorConverter.darken(Colors.blue.shade500, 40),
          dividingLineWidth: 2,
          dividingLineColor: ColorConverter.darken(Colors.blue.shade500, 40),
          contractCountdownBorderWidth: 2.5,
          contractCountdownOddColor: ColorConverter.darken(Colors.blue.shade200, 20).withValues(alpha: .2),
          contractCountdownEvenColor: ColorConverter.darken(Colors.blue.shade200, 20).withValues(alpha: .2),
          contractCountdownOddBorderColor: Colors.white,
          contractCountdownEvenBorderColor: Colors.white,
          contractCountdownNumberColor: ColorConverter.darken(Colors.blue.shade500, 40),
          contractCountdownUnitColor: ColorConverter.darken(Colors.blue.shade500, 40),
          receptionCountdownBorderWidth: 2.5,
          receptionCountdownOddColor: ColorConverter.darken(Colors.blue.shade200, 20).withValues(alpha: .2),
          receptionCountdownEvenColor: ColorConverter.darken(Colors.blue.shade200, 20).withValues(alpha: .2),
          receptionCountdownOddBorderColor: Colors.white,
          receptionCountdownEvenBorderColor: Colors.white,
          receptionCountdownNumberColor: ColorConverter.darken(Colors.blue.shade500, 40),
          receptionCountdownUnitColor: ColorConverter.darken(Colors.blue.shade500, 40),
          useLightningEffectOnCountdown: false,
        ),
        fourthPageConfig: PageViewBasedFourthPageConfig(
          // frontground: const GroupFrontground(),
          // background: const GroupBackground(),
          useBackdropBlurOnScaffold: false,
          firstGradientScaffoldColor: Colors.white.withValues(alpha: .85),
          secondGradientScaffoldColor: ColorConverter.lighten(Colors.blue.shade50, 10).withValues(alpha: .9),
          scaffoldBorder: GradientBoxBorder(
            width: 4,
            gradient: LinearGradient(
              begin: .topCenter,
              end: .bottomCenter,
              colors: [ColorConverter.darken(Colors.blue.shade100, 10), ColorConverter.darken(Colors.blue.shade300, 30)],
              transform: const GradientRotation(-.2),
            ),
          ),
          useGlassEffectOnScaffold: false,
          titlePageColor: Colors.white,
          placeIconColor: ColorConverter.darken(Colors.blue.shade500, 40),
          placeTextColor: ColorConverter.darken(Colors.blue.shade500, 40),
          addressTextColor: ColorConverter.darken(Colors.blue.shade500, 40),
          dividingLineWidth: 1,
          dividingLineColor: ColorConverter.darken(Colors.blue.shade500, 40),
          mapsBorderColor: Colors.grey.shade400,
          getDirectionsButtonColor: ColorConverter.darken(Colors.blue.shade200, 20).withValues(alpha: .2),
          getDirectionsButtonLabelColor: ColorConverter.darken(Colors.blue.shade500, 40),
          getDirectionsButtonBorderWidth: 2,
          getDirectionsButtonBorderColor: ColorConverter.darken(Colors.blue.shade500, 40),
        ),
        fifthPageConfig: PageViewBasedFifthPageConfig(
          frontground: const GroupFrontground(),
          background: const GroupBackground(),
          useBackdropBlurOnScaffold: false,
          firstGradientScaffoldColor: Colors.black.withValues(alpha: .7),
          secondGradientScaffoldColor: Colors.black.withValues(alpha: .7),
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
          dividingLineWidth: 1.5,
          dividingVerticalLineColor: ThemeColors.gold,
          dividingHorizontalLineColor: ThemeColors.roseGold,
          seeMoreButtonColor: ThemeColors.gold.withValues(alpha: .2),
          seeMoreButtonLabelColor: ThemeColors.gold,
          seeMoreButtonBorderWidth: 2,
          seeMoreButtonBorderColor: ThemeColors.gold,
          bottomSheetHandleColor: ThemeColors.gold,
          bottomSheetContentScaffoldColor: ThemeColors.roseGold.withValues(alpha: .2),
          bottomSheetBackgroundColor: Colors.black.withValues(alpha: .85),
          bottomSheetCloseIconColor: Colors.grey.shade400,
        ),
        sixthPageConfig: PageViewBasedSixthPageConfig(
          frontground: const GroupFrontground(),
          background: const GroupBackground(),
          useBackdropBlurOnScaffold: false,
          firstGradientScaffoldColor: Colors.black.withValues(alpha: .7),
          secondGradientScaffoldColor: Colors.black.withValues(alpha: .7),
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
          introductionTextColor: Colors.grey.shade100,
          introductionColor: ThemeColors.gold.withValues(alpha: .12),
          introductionBorderColor: ThemeColors.gold,
          introductionBorderWidth: 1.5,
          bankColor: ThemeColors.roseGold.withValues(alpha: .12),
          bankBorderColor: ThemeColors.roseGold,
          bankBorderWidth: 1.5,
          bankTextColor: Colors.grey.shade100,
          bankCopyBaseColor: Colors.grey.shade400,
        ),
        seventhPageConfig: PageViewBasedSeventhPageConfig(
          frontground: const GroupFrontground(),
          background: const GroupBackground(),
          useBackdropBlurOnScaffold: false,
          firstGradientScaffoldColor: Colors.black.withValues(alpha: .7),
          secondGradientScaffoldColor: Colors.black.withValues(alpha: .7),
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
          fieldTextColor: Colors.grey.shade100,
          fieldLabelColor: Colors.grey.shade300,
          fieldFillColor: Colors.grey.shade500.withValues(alpha: .3),
          fieldBorderColor: Colors.grey.shade600,
          fieldSplashColor: Colors.grey.shade400,
          overlayColor: Colors.grey.shade700.withValues(alpha: .95),
          overlayBorderColor: Colors.grey.shade500,
          dropdownItemSelectedColor: Colors.grey.shade500,
          dropdownItemTextColor: Colors.grey.shade100,
          dropdownItemSelectedTextColor: Colors.grey.shade100,
          dropdownItemHoveredColor: Colors.grey.shade400,
          dropdownItemSplashColor: Colors.grey.shade400,
          submitButtonColor: ThemeColors.gold.withValues(alpha: .2),
          submitButtonLabelColor: ThemeColors.gold,
          submitButtonBorderWidth: 2,
          submitButtonBorderColor: ThemeColors.gold,
          rsvpBackgroundColor: Colors.grey.shade500.withValues(alpha: .3),
          rsvpBorderColor: Colors.grey.shade500,
          rsvpNameTextColor: Colors.grey.shade100,
          rsvpTimeAgoTextColor: Colors.grey.shade400,
          rsvpNameInstanceTextColor: Colors.grey.shade400,
          rsvpAttendanceTextColorLighten: 50,
          rsvpMessageTextColor: Colors.grey.shade200,
          seeMoreButtonColor: Colors.grey.shade900.withValues(alpha: .8),
          seeMoreButtonLabelColor: ThemeColors.roseGold,
          seeMoreButtonBorderWidth: 2,
          seeMoreButtonBorderColor: ThemeColors.roseGold,
          bottomSheetHandleColor: ThemeColors.gold,
          bottomSheetContentScaffoldColor: ThemeColors.roseGold.withValues(alpha: .2),
          bottomSheetBackgroundColor: Colors.black.withValues(alpha: .85),
          bottomSheetCloseIconColor: Colors.grey.shade400,
        ),
        eighthPageConfig: PageViewBasedEighthPageConfig(
          frontground: const GroupFrontground(),
          background: const GroupBackground(),
          useBackdropBlurOnScaffold: false,
          firstGradientScaffoldColor: Colors.black.withValues(alpha: .7),
          secondGradientScaffoldColor: Colors.black.withValues(alpha: .7),
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
          closingTextColor: Colors.grey.shade100,
          brideGroomNameColor: ThemeColors.gold,
          brandBackgroundColor: Colors.grey.shade800.withValues(alpha: .6),
          brandTextColor: Colors.grey.shade50,
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

import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/theme_colors.dart';
import 'package:iv_project_invitation_theme/src/page_types/page_view_with_bottom_tab_bar.dart';
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
        globalBackgroundsBuilder: () => [
          Stack(
            children: [
              SizedBox(
                width: Screen.width,
                height: Screen.height,
                child: Image.asset('assets/backgrounds/base_canvas.jpg', fit: .cover, package: 'iv_project_invitation_theme'),
              ),
              SizedBox(
                width: Screen.width,
                height: Screen.height,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: .topCenter,
                      end: .bottomCenter,
                      colors: [
                        ColorConverter.darken(Colors.blue.shade500, 40).withValues(alpha: .3),
                        Colors.white.withValues(alpha: .0),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: -72,
                child: RotatedBox(
                  quarterTurns: 2,
                  child: SizedBox(
                    width: Screen.width / 2.2,
                    child: Image.asset('assets/backgrounds/floral_1.png', fit: .cover, package: 'iv_project_invitation_theme'),
                  ),
                ),
              ),
              Positioned(
                top: -10,
                right: -98,
                child: RotatedBox(
                  quarterTurns: 2,
                  child: SizedBox(
                    width: Screen.width / 2.2,
                    child: Image.asset('assets/backgrounds/floral_1.png', fit: .cover, package: 'iv_project_invitation_theme'),
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                left: -102,
                child: SizedBox(
                  width: Screen.width / 2.2,
                  child: Image.asset('assets/backgrounds/floral_1.png', fit: .cover, package: 'iv_project_invitation_theme'),
                ),
              ),
              Positioned(
                bottom: 80,
                right: -82,
                child: SizedBox(
                  width: Screen.width / 2.2,
                  child: Image.asset('assets/backgrounds/floral_1.png', fit: .cover, package: 'iv_project_invitation_theme'),
                ),
              ),
            ],
          ),
        ],
        particleSphere: ParticleSphereConfig(
          particleVariatios: [
            Particle.circle(color: Colors.lightBlueAccent),
            Particle.circle(color: Colors.white),
            Particle.circle(color: ColorConverter.darken(Colors.blue.shade700, 40)),
            Particle.circle(color: ColorConverter.lighten(Colors.pinkAccent.shade100)),
          ],
        ),
        coverPageConfig: PageViewBasedCoverPageConfig(
          // coverBackground: const CoverBackground(),
          gradientBaseColor: Colors.grey.shade900,
          brideNameColor: ThemeColors.roseGold,
          groomNameColor: ThemeColors.gold,
          countdownBorderWidth: 2,
          countdownOddColor: ThemeColors.gold.withValues(alpha: .1),
          countdownEvenColor: ThemeColors.roseGold.withValues(alpha: .1),
          countdownOddBorderColor: ThemeColors.gold,
          countdownEvenBorderColor: ThemeColors.roseGold,
          countdownNumberColor: ThemeColors.gold,
          countdownUnitColor: ThemeColors.roseGold,
          useLightningEffectOnCountdown: false,
          firstArrowColor: ThemeColors.gold.withValues(alpha: .9),
          secondArrowColor: ThemeColors.roseGold.withValues(alpha: .7),
        ),
        firstPageConfig: PageViewBasedFirstPageConfig(
          // frontground: const GroupFrontground(),
          // background: const GroupBackground(),
          // firstGradientBackgroundColor: ColorConverter.darken(Colors.blue.shade500, 40).withValues(alpha: .1),
          // secondGradientBackgroundColor: Colors.white.withValues(alpha: .0),
          useBackdropBlurOnScaffold: false,
          firstGradientScaffoldColor: Colors.white.withValues(alpha: .0),
          secondGradientScaffoldColor: Colors.white.withValues(alpha: .0),
          scaffoldBorder: .all(width: 0, color: Colors.white.withValues(alpha: 0)),
          useGlassEffectOnScaffold: false,
          titlePageColor: Colors.white,
          openingTextColor: ColorConverter.darken(Colors.blue.shade500, 40),
          generalTextColor: ColorConverter.darken(Colors.blue.shade500, 40),
          firstSubScaffoldColor: Colors.white.withValues(alpha: .6),
          firstSubScaffoldBorderColor: Colors.transparent,
          firstSubScaffoldBorderWidth: 1.5,
          secondSubScaffoldColor: Colors.white.withValues(alpha: .6),
          secondSubScaffoldBorderColor: Colors.transparent,
          secondSubScaffoldBorderWidth: 1.5,
        ),
        secondPageConfig: PageViewBasedSecondPageConfig(
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
          generalTextColor: Colors.grey.shade200,
          brideDividingBorderWidth: 1.5,
          brideImageBorderWidth: 2,
          brideDividingLineWidth: 1,
          brideDividingBorderColor: ThemeColors.roseGold,
          brideImageBaseColor: ThemeColors.roseGold,
          brideDividingLineColor: ThemeColors.roseGold,
          brideNameTextColor: ThemeColors.roseGold,
          brideFatherNameTextColor: ThemeColors.gold,
          brideMotherNameTextColor: ThemeColors.roseGold,
          groomDividingBorderWidth: 1.5,
          groomImageBorderWidth: 2,
          groomDividingLineWidth: 1,
          groomDividingBorderColor: ThemeColors.gold,
          groomImageBaseColor: ThemeColors.gold,
          groomDividingLineColor: ThemeColors.gold,
          groomNameTextColor: ThemeColors.gold,
          groomFatherNameTextColor: ThemeColors.gold,
          groomMotherNameTextColor: ThemeColors.roseGold,
        ),
        thirdPageConfig: PageViewBasedThirdPageConfig(
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
          contractTitleColor: ThemeColors.gold,
          contractBaseTextColor: Colors.grey.shade100,
          receptionTitleColor: ThemeColors.roseGold,
          receptionBaseTextColor: Colors.grey.shade100,
          dividingLineWidth: 1,
          dividingLineColor: ThemeColors.gold,
          contractCountdownBorderWidth: 2,
          contractCountdownOddColor: ThemeColors.gold.withValues(alpha: .1),
          contractCountdownEvenColor: ThemeColors.roseGold.withValues(alpha: .1),
          contractCountdownOddBorderColor: ThemeColors.gold,
          contractCountdownEvenBorderColor: ThemeColors.roseGold,
          contractCountdownNumberColor: ThemeColors.gold,
          contractCountdownUnitColor: ThemeColors.roseGold,
          receptionCountdownBorderWidth: 2,
          receptionCountdownOddColor: ThemeColors.gold.withValues(alpha: .1),
          receptionCountdownEvenColor: ThemeColors.roseGold.withValues(alpha: .1),
          receptionCountdownOddBorderColor: ThemeColors.gold,
          receptionCountdownEvenBorderColor: ThemeColors.roseGold,
          receptionCountdownNumberColor: ThemeColors.gold,
          receptionCountdownUnitColor: ThemeColors.roseGold,
          useLightningEffectOnCountdown: false,
        ),
        fourthPageConfig: PageViewBasedFourthPageConfig(
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
          placeIconColor: ThemeColors.gold,
          placeTextColor: ThemeColors.roseGold,
          dividingLineWidth: 1,
          dividingLineColor: ThemeColors.gold,
          mapsBorderColor: Colors.grey.shade400,
          getDirectionsButtonColor: ThemeColors.gold.withValues(alpha: .2),
          getDirectionsButtonLabelColor: ThemeColors.gold,
          getDirectionsButtonBorderWidth: 2,
          getDirectionsButtonBorderColor: ThemeColors.gold,
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

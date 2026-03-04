import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/page_view_based.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_cover_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_fifth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_first_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_fourth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_second_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_sixth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_third_page.dart';
import 'package:iv_project_invitation_theme/src/widgets/bubble_background.dart';
import 'package:iv_project_model/iv_project_model.dart';

class ElegantBlackAndWhiteGlass extends StatelessWidget {
  const ElegantBlackAndWhiteGlass({
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
        tabConfig: PageViewBasedTabConfig(
          useGlassEffectOnTab: true,
          indicatorColor: Colors.grey.shade50,
          titleActiveColor: Colors.white,
          titleInactiveColor: Colors.grey.shade400,
          iconActiveColor: Colors.white,
          iconInactiveColor: Colors.grey.shade400,
        ),
        globalBackgroundBuilder: () => const BubbleBackground(),
        coverPageConfig: PageViewBasedCoverPageConfig(
          brideNameColor: Colors.grey.shade300,
          groomNameColor: Colors.grey.shade300,
          countdownBorderWidth: 1,
          countdownOddColor: Colors.grey.shade500.withValues(alpha: .1),
          countdownEvenColor: Colors.grey.shade500.withValues(alpha: .1),
          countdownOddBorderColor: Colors.grey.shade600,
          countdownEvenBorderColor: Colors.grey.shade600,
          countdownNumberColor: Colors.grey.shade200,
          countdownUnitColor: Colors.grey.shade200,
          useLightningEffectOnCountdown: true,
          firstArrowColor: Colors.grey.shade100.withValues(alpha: .7),
          secondArrowColor: Colors.grey.shade300.withValues(alpha: .5),
        ),
        firstPageConfig: PageViewBasedFirstPageConfig(
          useBackdropBlurOnScaffold: true,
          firstGradientBackgroundColor: Colors.grey.shade900,
          secondGradientBackgroundColor: Colors.transparent,
          scaffoldColor: Colors.black.withValues(alpha: .6),
          scaffoldBorder: .all(width: .5, color: Colors.grey.shade500),
          useGlassEffectOnScaffold: true,
          titlePageColor: Colors.grey.shade200,
          firstSubScaffoldColor: Colors.white.withValues(alpha: .05),
          firstSubScaffoldBorderColor: Colors.grey.shade500,
          firstSubScaffoldBorderWidth: .5,
          secondSubScaffoldColor: Colors.white.withValues(alpha: .05),
          secondSubScaffoldBorderColor: Colors.grey.shade500,
          secondSubScaffoldBorderWidth: .5,
        ),
        secondPageConfig: PageViewBasedSecondPageConfig(
          useBackdropBlurOnScaffold: true,
          scaffoldColor: Colors.black.withValues(alpha: .6),
          scaffoldBorder: .all(width: .5, color: Colors.grey.shade500),
          useGlassEffectOnScaffold: true,
          titlePageColor: Colors.grey.shade900,
          brideDividingBorderWidth: .5,
          brideImageBorderWidth: .5,
          brideDividingLineWidth: .5,
          brideDividingBorderColor: Colors.grey.shade200,
          brideImageBaseColor: Colors.grey.shade200,
          brideDividingLineColor: Colors.grey.shade200,
          brideNameTextColor: null,
          brideFatherNameTextColor: null,
          brideMotherNameTextColor: null,
          groomDividingBorderWidth: .5,
          groomImageBorderWidth: .5,
          groomDividingLineWidth: .5,
          groomDividingBorderColor: Colors.grey.shade200,
          groomImageBaseColor: Colors.grey.shade200,
          groomDividingLineColor: Colors.grey.shade200,
          groomNameTextColor: null,
          groomFatherNameTextColor: null,
          groomMotherNameTextColor: null,
        ),
        thirdPageConfig: PageViewBasedThirdPageConfig(
          useBackdropBlurOnScaffold: true,
          firstGradientBackgroundColor: Colors.transparent,
          secondGradientBackgroundColor: Colors.grey.shade900,
          scaffoldColor: Colors.black.withValues(alpha: .6),
          scaffoldBorder: .all(width: .5, color: Colors.grey.shade500),
          useGlassEffectOnScaffold: true,
          titlePageColor: Colors.grey.shade900,
          contractTitleColor: Colors.grey.shade100,
          receptionTitleColor: Colors.grey.shade100,
          dividingLineWidth: .5,
          dividingLineColor: Colors.grey.shade100,
          countdownBorderWidth: 1,
          countdownOddColor: Colors.grey.shade500.withValues(alpha: .1),
          countdownEvenColor: Colors.grey.shade500.withValues(alpha: .1),
          countdownOddBorderColor: Colors.grey.shade600,
          countdownEvenBorderColor: Colors.grey.shade600,
          countdownNumberColor: Colors.grey.shade200,
          countdownUnitColor: Colors.grey.shade200,
          useLightningEffectOnCountdown: true,
        ),
        fourthPageConfig: PageViewBasedFourthPageConfig(
          useBackdropBlurOnScaffold: true,
          firstGradientBackgroundColor: Colors.grey.shade900,
          secondGradientBackgroundColor: Colors.transparent,
          scaffoldColor: Colors.black.withValues(alpha: .6),
          scaffoldBorder: .all(width: .5, color: Colors.grey.shade500),
          useGlassEffectOnScaffold: true,
          titlePageColor: Colors.grey.shade200,
          placeIconColor: Colors.grey.shade50,
          placeTextColor: Colors.grey.shade50,
          getDirectionsButtonColor: Colors.grey.shade300.withValues(alpha: .2),
          getDirectionsButtonLabelColor: Colors.white,
          getDirectionsButtonBorderWidth: .5,
          getDirectionsButtonBorderColor: Colors.grey.shade500,
        ),
        fifthPageConfig: PageViewBasedFifthPageConfig(
          useBackdropBlurOnScaffold: true,
          scaffoldColor: Colors.black.withValues(alpha: .6),
          scaffoldBorder: .all(width: .5, color: Colors.grey.shade500),
          useGlassEffectOnScaffold: true,
          titlePageColor: Colors.grey.shade900,
          dividingLineWidth: .5,
          dividingVerticalLineColor: Colors.grey.shade500,
          dividingHorizontalLineColor: Colors.grey.shade500,
          seeMoreButtonColor: Colors.black.withValues(alpha: .5),
          seeMoreButtonLabelColor: Colors.grey.shade50,
          seeMoreButtonBorderWidth: .5,
          seeMoreButtonBorderColor: Colors.grey.shade500,
          bottomSheetHandleColor: null,
          bottomSheetContentScaffoldColor: Colors.grey.shade700.withValues(alpha: .5),
        ),
        sixthPageConfig: PageViewBasedSixthPageConfig(
          useBackdropBlurOnScaffold: true,
          firstGradientBackgroundColor: Colors.transparent,
          secondGradientBackgroundColor: Colors.grey.shade900,
          scaffoldColor: Colors.black.withValues(alpha: .6),
          scaffoldBorder: .all(width: .5, color: Colors.grey.shade500),
          useGlassEffectOnScaffold: true,
          titlePageColor: Colors.grey.shade900,
          introductionColor: Colors.white.withValues(alpha: .05),
          introductionBorderColor: Colors.grey.shade500,
          introductionBorderWidth: .5,
          bankColor: Colors.white.withValues(alpha: .05),
          bankBorderColor: Colors.grey.shade500,
          bankBorderWidth: .5,
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

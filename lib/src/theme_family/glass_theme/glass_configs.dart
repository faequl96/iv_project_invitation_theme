import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/src/widgets/particle_sphere.dart';

class GlassConfigs {
  const GlassConfigs({
    required this.tabConfig,
    this.globalBackgroundsBuilder,
    this.particleSphere,
    required this.coverPageConfig,
    required this.firstPageConfig,
    required this.secondPageConfig,
    required this.thirdPageConfig,
    required this.thirdDifferentLocationPageConfig,
    required this.fourthPageConfig,
    required this.fourthDifferentLocationPageConfig,
    required this.fifthPageConfig,
    required this.sixthPageConfig,
    required this.seventhPageConfig,
    required this.eighthPageConfig,
  });

  final GlassTabConfig tabConfig;
  final List<Widget> Function()? globalBackgroundsBuilder;
  final ParticleSphereConfig? particleSphere;
  final GlassCoverPageConfig coverPageConfig;
  final GlassFirstPageConfig firstPageConfig;
  final GlassSecondPageConfig secondPageConfig;
  final GlassThirdPageConfig thirdPageConfig;
  final GlassThirdDifferentLocationPageConfig thirdDifferentLocationPageConfig;
  final GlassFourthPageConfig fourthPageConfig;
  final GlassFourthDifferentLocationPageConfig fourthDifferentLocationPageConfig;
  final GlassFifthPageConfig fifthPageConfig;
  final GlassSixthPageConfig sixthPageConfig;
  final GlassSeventhPageConfig seventhPageConfig;
  final GlassEighthPageConfig eighthPageConfig;
}

class GlassTabConfig {
  const GlassTabConfig({
    required this.useGlassEffect,
    this.useBackdropBlur = true,
    this.widthFull = false,
    required this.indicatorColor,
    required this.backgroundColor,
    required this.titleActiveColor,
    required this.titleInactiveColor,
    required this.iconActiveColor,
    required this.iconInactiveColor,
  });

  final bool useGlassEffect;
  final bool useBackdropBlur;
  final bool widthFull;
  final Color indicatorColor;
  final Color backgroundColor;
  final Color titleActiveColor;
  final Color titleInactiveColor;
  final Color iconActiveColor;
  final Color iconInactiveColor;
}

class GlassCoverPageConfig {
  const GlassCoverPageConfig({
    required this.gradientBaseColor,
    required this.brideNameColor,
    required this.groomNameColor,
    required this.countdownBorderWidth,
    required this.countdownOddColor,
    required this.countdownEvenColor,
    required this.countdownOddBorderColor,
    required this.countdownEvenBorderColor,
    required this.countdownNumberColor,
    required this.countdownUnitColor,
    required this.useLightningEffectOnCountdown,
    required this.firstArrowColor,
    required this.secondArrowColor,
  });

  final Color gradientBaseColor;
  final Color brideNameColor;
  final Color groomNameColor;
  final double countdownBorderWidth;
  final Color countdownOddColor;
  final Color countdownEvenColor;
  final Color countdownOddBorderColor;
  final Color countdownEvenBorderColor;
  final Color countdownNumberColor;
  final Color countdownUnitColor;
  final bool useLightningEffectOnCountdown;
  final Color firstArrowColor;
  final Color secondArrowColor;
}

class GlassFirstPageConfig {
  const GlassFirstPageConfig({
    required this.useBackdropBlurOnScaffold,
    required this.firstGradientScaffoldColor,
    required this.secondGradientScaffoldColor,
    this.stopsGradientScaffoldColor,
    this.scaffoldBoxShadow,
    required this.scaffoldBorder,
    this.scaffoldBorderRadius = const .all(.circular(20)),
    required this.useGlassEffectOnScaffold,
    this.glassEffectOpacity = .4,
    this.firstGradientBackgroundColor,
    this.secondGradientBackgroundColor,
    required this.titlePageColor,
    required this.openingTextColor,
    required this.generalTextColor,
    required this.firstSubScaffoldColor,
    required this.firstSubScaffoldBorderColor,
    required this.firstSubScaffoldBorderWidth,
    required this.secondSubScaffoldColor,
    required this.secondSubScaffoldBorderColor,
    required this.secondSubScaffoldBorderWidth,
  });

  final bool useBackdropBlurOnScaffold;
  final Color firstGradientScaffoldColor;
  final Color secondGradientScaffoldColor;
  final List<double>? stopsGradientScaffoldColor;
  final List<BoxShadow>? scaffoldBoxShadow;
  final BoxBorder scaffoldBorder;
  final BorderRadiusGeometry scaffoldBorderRadius;
  final bool useGlassEffectOnScaffold;
  final double glassEffectOpacity;
  final Color? firstGradientBackgroundColor;
  final Color? secondGradientBackgroundColor;
  final Color titlePageColor;
  final Color openingTextColor;
  final Color generalTextColor;
  final Color firstSubScaffoldColor;
  final Color firstSubScaffoldBorderColor;
  final double firstSubScaffoldBorderWidth;
  final Color secondSubScaffoldColor;
  final Color secondSubScaffoldBorderColor;
  final double secondSubScaffoldBorderWidth;
}

class GlassSecondPageConfig {
  const GlassSecondPageConfig({
    required this.useBackdropBlurOnScaffold,
    required this.firstGradientScaffoldColor,
    required this.secondGradientScaffoldColor,
    this.stopsGradientScaffoldColor,
    required this.scaffoldBorder,
    required this.useGlassEffectOnScaffold,
    this.glassEffectOpacity = .4,
    this.firstGradientBackgroundColor,
    this.secondGradientBackgroundColor,
    required this.titlePageColor,
    required this.generalTextColor,
    required this.brideDividingBorderWidth,
    required this.brideImageBorderWidth,
    required this.brideDividingLineWidth,
    required this.brideDividingBorderColor,
    required this.brideImageFrameColor,
    required this.brideImageFrameBorderColor,
    required this.brideDividingLineColor,
    required this.brideNameTextColor,
    required this.brideFatherNameTextColor,
    required this.brideMotherNameTextColor,
    required this.groomDividingBorderWidth,
    required this.groomImageBorderWidth,
    required this.groomDividingLineWidth,
    required this.groomDividingBorderColor,
    required this.groomImageFrameColor,
    required this.groomImageFrameBorderColor,
    required this.groomDividingLineColor,
    required this.groomNameTextColor,
    required this.groomFatherNameTextColor,
    required this.groomMotherNameTextColor,
  });

  final bool useBackdropBlurOnScaffold;
  final Color firstGradientScaffoldColor;
  final Color secondGradientScaffoldColor;
  final List<double>? stopsGradientScaffoldColor;
  final BoxBorder scaffoldBorder;
  final bool useGlassEffectOnScaffold;
  final double glassEffectOpacity;
  final Color? firstGradientBackgroundColor;
  final Color? secondGradientBackgroundColor;
  final Color titlePageColor;
  final Color generalTextColor;
  final double brideDividingBorderWidth;
  final double brideImageBorderWidth;
  final double brideDividingLineWidth;
  final Color brideDividingBorderColor;
  final Color brideImageFrameColor;
  final Color brideImageFrameBorderColor;
  final Color brideDividingLineColor;
  final Color? brideNameTextColor;
  final Color? brideFatherNameTextColor;
  final Color? brideMotherNameTextColor;
  final double groomDividingBorderWidth;
  final double groomImageBorderWidth;
  final double groomDividingLineWidth;
  final Color groomDividingBorderColor;
  final Color groomImageFrameColor;
  final Color groomImageFrameBorderColor;
  final Color groomDividingLineColor;
  final Color? groomNameTextColor;
  final Color? groomFatherNameTextColor;
  final Color? groomMotherNameTextColor;
}

class GlassThirdPageConfig {
  const GlassThirdPageConfig({
    required this.useBackdropBlurOnScaffold,
    required this.firstGradientScaffoldColor,
    required this.secondGradientScaffoldColor,
    this.stopsGradientScaffoldColor,
    required this.scaffoldBorder,
    required this.useGlassEffectOnScaffold,
    this.glassEffectOpacity = .4,
    this.firstGradientBackgroundColor,
    this.secondGradientBackgroundColor,
    required this.titlePageColor,
    required this.contractTitleColor,
    required this.contractBaseTextColor,
    required this.receptionTitleColor,
    required this.receptionBaseTextColor,
    required this.dividingLineWidth,
    required this.dividingLineColor,
    required this.contractCountdownBorderWidth,
    required this.contractCountdownOddColor,
    required this.contractCountdownEvenColor,
    required this.contractCountdownOddBorderColor,
    required this.contractCountdownEvenBorderColor,
    required this.contractCountdownNumberColor,
    required this.contractCountdownUnitColor,
    required this.receptionCountdownBorderWidth,
    required this.receptionCountdownOddColor,
    required this.receptionCountdownEvenColor,
    required this.receptionCountdownOddBorderColor,
    required this.receptionCountdownEvenBorderColor,
    required this.receptionCountdownNumberColor,
    required this.receptionCountdownUnitColor,
    required this.useLightningEffectOnCountdown,
  });

  final bool useBackdropBlurOnScaffold;
  final Color firstGradientScaffoldColor;
  final Color secondGradientScaffoldColor;
  final List<double>? stopsGradientScaffoldColor;
  final BoxBorder scaffoldBorder;
  final bool useGlassEffectOnScaffold;
  final double glassEffectOpacity;
  final Color? firstGradientBackgroundColor;
  final Color? secondGradientBackgroundColor;
  final Color titlePageColor;
  final Color contractTitleColor;
  final Color contractBaseTextColor;
  final Color receptionTitleColor;
  final Color receptionBaseTextColor;
  final double dividingLineWidth;
  final Color dividingLineColor;
  final double contractCountdownBorderWidth;
  final Color contractCountdownOddColor;
  final Color contractCountdownEvenColor;
  final Color contractCountdownOddBorderColor;
  final Color contractCountdownEvenBorderColor;
  final Color contractCountdownNumberColor;
  final Color contractCountdownUnitColor;
  final double receptionCountdownBorderWidth;
  final Color receptionCountdownOddColor;
  final Color receptionCountdownEvenColor;
  final Color receptionCountdownOddBorderColor;
  final Color receptionCountdownEvenBorderColor;
  final Color receptionCountdownNumberColor;
  final Color receptionCountdownUnitColor;
  final bool useLightningEffectOnCountdown;
}

class GlassThirdDifferentLocationPageConfig {
  const GlassThirdDifferentLocationPageConfig({
    required this.useBackdropBlurOnScaffold,
    required this.firstGradientScaffoldColor,
    required this.secondGradientScaffoldColor,
    this.stopsGradientScaffoldColor,
    required this.scaffoldBorder,
    required this.useGlassEffectOnScaffold,
    this.glassEffectOpacity = .4,
    this.firstGradientBackgroundColor,
    this.secondGradientBackgroundColor,
    required this.titlePageColor,
    required this.dateTimeIconColor,
    required this.dateTimeBaseTextColor,
    required this.countdownBorderWidth,
    required this.countdownOddColor,
    required this.countdownEvenColor,
    required this.countdownOddBorderColor,
    required this.countdownEvenBorderColor,
    required this.countdownNumberColor,
    required this.countdownUnitColor,
    required this.useLightningEffectOnCountdown,
    required this.dividingLineWidth,
    required this.dividingLineColor,
    required this.placeIconColor,
    required this.placeBaseTextColor,
    required this.addressTextColor,
    required this.mapsBorderColor,
    required this.getDirectionsButtonColor,
    required this.getDirectionsButtonLabelColor,
    required this.getDirectionsButtonBorderWidth,
    required this.getDirectionsButtonBorderColor,
  });

  final bool useBackdropBlurOnScaffold;
  final Color firstGradientScaffoldColor;
  final Color secondGradientScaffoldColor;
  final List<double>? stopsGradientScaffoldColor;
  final BoxBorder scaffoldBorder;
  final bool useGlassEffectOnScaffold;
  final double glassEffectOpacity;
  final Color? firstGradientBackgroundColor;
  final Color? secondGradientBackgroundColor;
  final Color titlePageColor;
  final Color dateTimeIconColor;
  final Color dateTimeBaseTextColor;
  final double countdownBorderWidth;
  final Color countdownOddColor;
  final Color countdownEvenColor;
  final Color countdownOddBorderColor;
  final Color countdownEvenBorderColor;
  final Color countdownNumberColor;
  final Color countdownUnitColor;
  final bool useLightningEffectOnCountdown;
  final double dividingLineWidth;
  final Color dividingLineColor;
  final Color placeIconColor;
  final Color placeBaseTextColor;
  final Color addressTextColor;
  final Color mapsBorderColor;
  final Color getDirectionsButtonColor;
  final Color getDirectionsButtonLabelColor;
  final double getDirectionsButtonBorderWidth;
  final Color getDirectionsButtonBorderColor;
}

class GlassFourthPageConfig {
  const GlassFourthPageConfig({
    required this.useBackdropBlurOnScaffold,
    required this.firstGradientScaffoldColor,
    required this.secondGradientScaffoldColor,
    this.stopsGradientScaffoldColor,
    required this.scaffoldBorder,
    required this.useGlassEffectOnScaffold,
    this.glassEffectOpacity = .4,
    this.firstGradientBackgroundColor,
    this.secondGradientBackgroundColor,
    required this.titlePageColor,
    required this.placeIconColor,
    required this.placeTextColor,
    required this.addressTextColor,
    required this.dividingLineWidth,
    required this.dividingLineColor,
    required this.mapsBorderColor,
    required this.getDirectionsButtonColor,
    required this.getDirectionsButtonLabelColor,
    required this.getDirectionsButtonBorderWidth,
    required this.getDirectionsButtonBorderColor,
  });

  final bool useBackdropBlurOnScaffold;
  final Color firstGradientScaffoldColor;
  final Color secondGradientScaffoldColor;
  final List<double>? stopsGradientScaffoldColor;
  final BoxBorder scaffoldBorder;
  final bool useGlassEffectOnScaffold;
  final double glassEffectOpacity;
  final Color? firstGradientBackgroundColor;
  final Color? secondGradientBackgroundColor;
  final Color titlePageColor;
  final Color placeIconColor;
  final Color placeTextColor;
  final Color addressTextColor;
  final double dividingLineWidth;
  final Color dividingLineColor;
  final Color mapsBorderColor;
  final Color getDirectionsButtonColor;
  final Color getDirectionsButtonLabelColor;
  final double getDirectionsButtonBorderWidth;
  final Color getDirectionsButtonBorderColor;
}

class GlassFourthDifferentLocationPageConfig {
  const GlassFourthDifferentLocationPageConfig({
    required this.useBackdropBlurOnScaffold,
    required this.firstGradientScaffoldColor,
    required this.secondGradientScaffoldColor,
    this.stopsGradientScaffoldColor,
    required this.scaffoldBorder,
    required this.useGlassEffectOnScaffold,
    this.glassEffectOpacity = .4,
    this.firstGradientBackgroundColor,
    this.secondGradientBackgroundColor,
    required this.titlePageColor,
    required this.dateTimeIconColor,
    required this.dateTimeBaseTextColor,
    required this.countdownBorderWidth,
    required this.countdownOddColor,
    required this.countdownEvenColor,
    required this.countdownOddBorderColor,
    required this.countdownEvenBorderColor,
    required this.countdownNumberColor,
    required this.countdownUnitColor,
    required this.useLightningEffectOnCountdown,
    required this.dividingLineWidth,
    required this.dividingLineColor,
    required this.placeIconColor,
    required this.placeBaseTextColor,
    required this.addressTextColor,
    required this.mapsBorderColor,
    required this.getDirectionsButtonColor,
    required this.getDirectionsButtonLabelColor,
    required this.getDirectionsButtonBorderWidth,
    required this.getDirectionsButtonBorderColor,
  });

  final bool useBackdropBlurOnScaffold;
  final Color firstGradientScaffoldColor;
  final Color secondGradientScaffoldColor;
  final List<double>? stopsGradientScaffoldColor;
  final BoxBorder scaffoldBorder;
  final bool useGlassEffectOnScaffold;
  final double glassEffectOpacity;
  final Color? firstGradientBackgroundColor;
  final Color? secondGradientBackgroundColor;
  final Color titlePageColor;
  final Color dateTimeIconColor;
  final Color dateTimeBaseTextColor;
  final double countdownBorderWidth;
  final Color countdownOddColor;
  final Color countdownEvenColor;
  final Color countdownOddBorderColor;
  final Color countdownEvenBorderColor;
  final Color countdownNumberColor;
  final Color countdownUnitColor;
  final bool useLightningEffectOnCountdown;
  final double dividingLineWidth;
  final Color dividingLineColor;
  final Color placeIconColor;
  final Color placeBaseTextColor;
  final Color addressTextColor;
  final Color mapsBorderColor;
  final Color getDirectionsButtonColor;
  final Color getDirectionsButtonLabelColor;
  final double getDirectionsButtonBorderWidth;
  final Color getDirectionsButtonBorderColor;
}

class GlassFifthPageConfig {
  const GlassFifthPageConfig({
    required this.useBackdropBlurOnScaffold,
    required this.firstGradientScaffoldColor,
    required this.secondGradientScaffoldColor,
    this.stopsGradientScaffoldColor,
    required this.scaffoldBorder,
    required this.useGlassEffectOnScaffold,
    this.glassEffectOpacity = .4,
    this.firstGradientBackgroundColor,
    this.secondGradientBackgroundColor,
    required this.titlePageColor,
    required this.dividingLineWidth,
    required this.dividingVerticalLineColor,
    required this.dividingHorizontalLineColor,
    required this.seeMoreButtonColor,
    required this.seeMoreButtonLabelColor,
    required this.seeMoreButtonBorderWidth,
    required this.seeMoreButtonBorderColor,
    required this.bottomSheetHandleColor,
    required this.bottomSheetContentScaffoldColor,
    required this.bottomSheetBackgroundColor,
    required this.bottomSheetCloseIconColor,
    this.bottomSheetOnHoverCloseIconColor,
  });

  final bool useBackdropBlurOnScaffold;
  final Color firstGradientScaffoldColor;
  final Color secondGradientScaffoldColor;
  final List<double>? stopsGradientScaffoldColor;
  final BoxBorder scaffoldBorder;
  final bool useGlassEffectOnScaffold;
  final double glassEffectOpacity;
  final Color? firstGradientBackgroundColor;
  final Color? secondGradientBackgroundColor;
  final Color titlePageColor;
  final double dividingLineWidth;
  final Color dividingVerticalLineColor;
  final Color dividingHorizontalLineColor;
  final Color seeMoreButtonColor;
  final Color seeMoreButtonLabelColor;
  final double seeMoreButtonBorderWidth;
  final Color seeMoreButtonBorderColor;
  final Color? bottomSheetHandleColor;
  final Color bottomSheetContentScaffoldColor;
  final Color bottomSheetBackgroundColor;
  final Color bottomSheetCloseIconColor;
  final Color? bottomSheetOnHoverCloseIconColor;
}

class GlassSixthPageConfig {
  const GlassSixthPageConfig({
    required this.useBackdropBlurOnScaffold,
    required this.firstGradientScaffoldColor,
    required this.secondGradientScaffoldColor,
    this.stopsGradientScaffoldColor,
    required this.scaffoldBorder,
    required this.useGlassEffectOnScaffold,
    this.glassEffectOpacity = .4,
    this.firstGradientBackgroundColor,
    this.secondGradientBackgroundColor,
    required this.titlePageColor,
    required this.introductionTextColor,
    required this.introductionColor,
    required this.introductionBorderColor,
    required this.introductionBorderWidth,
    required this.bankColor,
    required this.bankBorderColor,
    required this.bankBorderWidth,
    required this.bankTextColor,
    required this.bankCopyBaseColor,
  });

  final bool useBackdropBlurOnScaffold;
  final Color firstGradientScaffoldColor;
  final Color secondGradientScaffoldColor;
  final List<double>? stopsGradientScaffoldColor;
  final BoxBorder scaffoldBorder;
  final bool useGlassEffectOnScaffold;
  final double glassEffectOpacity;
  final Color? firstGradientBackgroundColor;
  final Color? secondGradientBackgroundColor;
  final Color titlePageColor;
  final Color introductionTextColor;
  final Color introductionColor;
  final Color introductionBorderColor;
  final double introductionBorderWidth;
  final Color bankColor;
  final Color bankBorderColor;
  final double bankBorderWidth;
  final Color bankTextColor;
  final Color bankCopyBaseColor;
}

class GlassSeventhPageConfig {
  const GlassSeventhPageConfig({
    required this.useBackdropBlurOnScaffold,
    required this.firstGradientScaffoldColor,
    required this.secondGradientScaffoldColor,
    this.stopsGradientScaffoldColor,
    required this.scaffoldBorder,
    required this.useGlassEffectOnScaffold,
    this.glassEffectOpacity = .4,
    this.firstGradientBackgroundColor,
    this.secondGradientBackgroundColor,
    required this.titlePageColor,
    required this.fieldTextColor,
    required this.fieldLabelColor,
    required this.fieldFillColor,
    required this.fieldBorderColor,
    required this.fieldSplashColor,
    required this.overlayColor,
    required this.overlayBorderColor,
    required this.dropdownItemSelectedColor,
    required this.dropdownItemTextColor,
    required this.dropdownItemSelectedTextColor,
    // required this.dropdownItemHoveredColor,
    // required this.dropdownItemSplashColor,
    required this.submitButtonColor,
    required this.submitButtonLabelColor,
    required this.submitButtonBorderWidth,
    required this.submitButtonBorderColor,
    required this.rsvpBackgroundColor,
    required this.rsvpBorderColor,
    this.rsvpBorderWidth = .5,
    required this.rsvpNameTextColor,
    required this.rsvpTimeAgoTextColor,
    required this.rsvpNameInstanceTextColor,
    required this.rsvpAttendanceTextColorLighten,
    required this.rsvpMessageTextColor,
    required this.seeMoreButtonColor,
    required this.seeMoreButtonLabelColor,
    required this.seeMoreButtonBorderWidth,
    required this.seeMoreButtonBorderColor,
    required this.bottomSheetHandleColor,
    required this.bottomSheetContentScaffoldColor,
    required this.bottomSheetBackgroundColor,
    required this.bottomSheetCloseIconColor,
    this.bottomSheetOnHoverCloseIconColor,
  });

  final bool useBackdropBlurOnScaffold;
  final Color firstGradientScaffoldColor;
  final Color secondGradientScaffoldColor;
  final List<double>? stopsGradientScaffoldColor;
  final BoxBorder scaffoldBorder;
  final bool useGlassEffectOnScaffold;
  final double glassEffectOpacity;
  final Color? firstGradientBackgroundColor;
  final Color? secondGradientBackgroundColor;
  final Color titlePageColor;
  final Color fieldTextColor;
  final Color fieldLabelColor;
  final Color fieldFillColor;
  final Color fieldBorderColor;
  final Color fieldSplashColor;
  final Color overlayColor;
  final Color overlayBorderColor;
  final Color dropdownItemSelectedColor;
  final Color dropdownItemTextColor;
  final Color dropdownItemSelectedTextColor;
  // final Color dropdownItemHoveredColor;
  // final Color dropdownItemSplashColor;
  final Color submitButtonColor;
  final Color submitButtonLabelColor;
  final double submitButtonBorderWidth;
  final Color submitButtonBorderColor;
  final Color rsvpBackgroundColor;
  final Color rsvpBorderColor;
  final double rsvpBorderWidth;
  final Color rsvpNameTextColor;
  final Color rsvpTimeAgoTextColor;
  final Color rsvpNameInstanceTextColor;
  final int rsvpAttendanceTextColorLighten;
  final Color rsvpMessageTextColor;
  final Color seeMoreButtonColor;
  final Color seeMoreButtonLabelColor;
  final double seeMoreButtonBorderWidth;
  final Color seeMoreButtonBorderColor;
  final Color? bottomSheetHandleColor;
  final Color bottomSheetContentScaffoldColor;
  final Color bottomSheetBackgroundColor;
  final Color bottomSheetCloseIconColor;
  final Color? bottomSheetOnHoverCloseIconColor;
}

class GlassEighthPageConfig {
  const GlassEighthPageConfig({
    required this.useBackdropBlurOnScaffold,
    required this.firstGradientScaffoldColor,
    required this.secondGradientScaffoldColor,
    this.stopsGradientScaffoldColor,
    required this.scaffoldBorder,
    required this.useGlassEffectOnScaffold,
    this.glassEffectOpacity = .4,
    this.firstGradientBackgroundColor,
    this.secondGradientBackgroundColor,
    required this.titlePageColor,
    required this.closingTextColor,
    required this.brideGroomNameColor,
    required this.brandBackgroundColor,
    required this.brandTextColor,
  });

  final bool useBackdropBlurOnScaffold;
  final Color firstGradientScaffoldColor;
  final Color secondGradientScaffoldColor;
  final List<double>? stopsGradientScaffoldColor;
  final BoxBorder scaffoldBorder;
  final bool useGlassEffectOnScaffold;
  final double glassEffectOpacity;
  final Color? firstGradientBackgroundColor;
  final Color? secondGradientBackgroundColor;
  final Color titlePageColor;
  final Color closingTextColor;
  final Color brideGroomNameColor;
  final Color brandBackgroundColor;
  final Color brandTextColor;
}

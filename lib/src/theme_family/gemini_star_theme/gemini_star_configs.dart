import 'package:flutter/material.dart';

class GeminiStarConfigs {
  const GeminiStarConfigs({
    this.globalBackgroundsBuilder,
    required this.coverPageConfig,
    required this.firstPageConfig,
    required this.secondPageConfig,
    required this.thirdPageConfig,
    required this.fourthPageConfig,
    required this.fourthDifferentLocationPageConfig,
    required this.fifthPageConfig,
    required this.fifthDifferentLocationPageConfig,
    required this.sixthPageConfig,
    required this.seventhPageConfig,
    required this.eighthPageConfig,
    required this.ninthPageConfig,
  });

  final List<Widget> Function()? globalBackgroundsBuilder;
  final GeminiStarCoverPageConfig coverPageConfig;
  final GeminiStarFirstPageConfig firstPageConfig;
  final GeminiStarSecondPageConfig secondPageConfig;
  final GeminiStarThirdPageConfig thirdPageConfig;
  final GeminiStarFourthPageConfig fourthPageConfig;
  final GeminiStarFourthDifferentLocationPageConfig fourthDifferentLocationPageConfig;
  final GeminiStarFifthPageConfig fifthPageConfig;
  final GeminiStarFifthDifferentLocationPageConfig fifthDifferentLocationPageConfig;
  final GeminiStarSixthPageConfig sixthPageConfig;
  final GeminiStarSeventhPageConfig seventhPageConfig;
  final GeminiStarEighthPageConfig eighthPageConfig;
  final GeminiStarNinthPageConfig ninthPageConfig;
}

class GeminiStarCoverPageConfig {
  const GeminiStarCoverPageConfig({
    this.coverBackground,
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
    required this.firstArrowColor,
    required this.secondArrowColor,
  });

  final Widget? coverBackground;
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
  final Color firstArrowColor;
  final Color secondArrowColor;
}

class GeminiStarFirstPageConfig {
  const GeminiStarFirstPageConfig({
    this.decorationBuilder,
    this.firstGradientBackgroundColor,
    this.secondGradientBackgroundColor,
    required this.titlePageColor,
    required this.openingTextColor,
    required this.generalTextColor,
  });

  final Widget Function()? decorationBuilder;
  final Color? firstGradientBackgroundColor;
  final Color? secondGradientBackgroundColor;
  final Color titlePageColor;
  final Color openingTextColor;
  final Color generalTextColor;
}

class GeminiStarSecondPageConfig {
  const GeminiStarSecondPageConfig({
    this.decorationBuilder,
    this.firstGradientBackgroundColor,
    this.secondGradientBackgroundColor,
    required this.titlePageColor,
    required this.generalTextColor,
    required this.brideNameTextColor,
    required this.brideFatherNameTextColor,
    required this.brideMotherNameTextColor,
    required this.groomNameTextColor,
    required this.groomFatherNameTextColor,
    required this.groomMotherNameTextColor,
  });

  final Widget Function()? decorationBuilder;
  final Color? firstGradientBackgroundColor;
  final Color? secondGradientBackgroundColor;
  final Color titlePageColor;
  final Color generalTextColor;
  final Color? brideNameTextColor;
  final Color? brideFatherNameTextColor;
  final Color? brideMotherNameTextColor;
  final Color? groomNameTextColor;
  final Color? groomFatherNameTextColor;
  final Color? groomMotherNameTextColor;
}

class GeminiStarThirdPageConfig {
  const GeminiStarThirdPageConfig({
    this.decorationBuilder,
    this.firstGradientBackgroundColor,
    this.secondGradientBackgroundColor,
    required this.titlePageColor,
    required this.generalTextColor,
    required this.brideNameTextColor,
    required this.brideFatherNameTextColor,
    required this.brideMotherNameTextColor,
    required this.groomNameTextColor,
    required this.groomFatherNameTextColor,
    required this.groomMotherNameTextColor,
  });

  final Widget Function()? decorationBuilder;
  final Color? firstGradientBackgroundColor;
  final Color? secondGradientBackgroundColor;
  final Color titlePageColor;
  final Color generalTextColor;
  final Color? brideNameTextColor;
  final Color? brideFatherNameTextColor;
  final Color? brideMotherNameTextColor;
  final Color? groomNameTextColor;
  final Color? groomFatherNameTextColor;
  final Color? groomMotherNameTextColor;
}

class GeminiStarFourthPageConfig {
  const GeminiStarFourthPageConfig({
    this.decorationBuilder,
    this.firstGradientBackgroundColor,
    this.secondGradientBackgroundColor,
    required this.titlePageColor,
    required this.contractBaseTextColor,
    required this.receptionBaseTextColor,
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
  });

  final Widget Function()? decorationBuilder;
  final Color? firstGradientBackgroundColor;
  final Color? secondGradientBackgroundColor;
  final Color titlePageColor;
  final Color contractBaseTextColor;
  final Color receptionBaseTextColor;
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
}

class GeminiStarFourthDifferentLocationPageConfig {
  const GeminiStarFourthDifferentLocationPageConfig({
    this.decorationBuilder,
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
    required this.placeIconColor,
    required this.placeBaseTextColor,
    required this.addressTextColor,
    required this.getDirectionsButtonColor,
    required this.getDirectionsButtonLabelColor,
    required this.getDirectionsButtonBorderWidth,
    required this.getDirectionsButtonBorderColor,
  });

  final Widget Function()? decorationBuilder;
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
  final Color placeIconColor;
  final Color placeBaseTextColor;
  final Color addressTextColor;
  final Color getDirectionsButtonColor;
  final Color getDirectionsButtonLabelColor;
  final double getDirectionsButtonBorderWidth;
  final Color getDirectionsButtonBorderColor;
}

class GeminiStarFifthPageConfig {
  const GeminiStarFifthPageConfig({
    this.decorationBuilder,
    this.firstGradientBackgroundColor,
    this.secondGradientBackgroundColor,
    required this.titlePageColor,
    required this.placeIconColor,
    required this.placeTextColor,
    required this.addressTextColor,
    required this.getDirectionsButtonColor,
    required this.getDirectionsButtonLabelColor,
    required this.getDirectionsButtonBorderWidth,
    required this.getDirectionsButtonBorderColor,
  });

  final Widget Function()? decorationBuilder;
  final Color? firstGradientBackgroundColor;
  final Color? secondGradientBackgroundColor;
  final Color titlePageColor;
  final Color placeIconColor;
  final Color placeTextColor;
  final Color addressTextColor;
  final Color getDirectionsButtonColor;
  final Color getDirectionsButtonLabelColor;
  final double getDirectionsButtonBorderWidth;
  final Color getDirectionsButtonBorderColor;
}

class GeminiStarFifthDifferentLocationPageConfig {
  const GeminiStarFifthDifferentLocationPageConfig({
    this.decorationBuilder,
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
    required this.placeIconColor,
    required this.placeBaseTextColor,
    required this.addressTextColor,
    required this.getDirectionsButtonColor,
    required this.getDirectionsButtonLabelColor,
    required this.getDirectionsButtonBorderWidth,
    required this.getDirectionsButtonBorderColor,
  });

  final Widget Function()? decorationBuilder;
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
  final Color placeIconColor;
  final Color placeBaseTextColor;
  final Color addressTextColor;
  final Color getDirectionsButtonColor;
  final Color getDirectionsButtonLabelColor;
  final double getDirectionsButtonBorderWidth;
  final Color getDirectionsButtonBorderColor;
}

class GeminiStarSixthPageConfig {
  const GeminiStarSixthPageConfig({
    this.decorationBuilder,
    this.firstGradientBackgroundColor,
    this.secondGradientBackgroundColor,
    required this.titlePageColor,
  });

  final Widget Function()? decorationBuilder;
  final Color? firstGradientBackgroundColor;
  final Color? secondGradientBackgroundColor;
  final Color titlePageColor;
}

class GeminiStarSeventhPageConfig {
  const GeminiStarSeventhPageConfig({
    this.decorationBuilder,
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

  final Widget Function()? decorationBuilder;
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

class GeminiStarEighthPageConfig {
  const GeminiStarEighthPageConfig({
    this.decorationBuilder,
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

  final Widget Function()? decorationBuilder;
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

class GeminiStarNinthPageConfig {
  const GeminiStarNinthPageConfig({
    this.decorationBuilder,
    this.firstGradientBackgroundColor,
    this.secondGradientBackgroundColor,
    required this.titlePageColor,
    required this.closingTextColor,
    required this.brideGroomNameColor,
    required this.brandBackgroundColor,
    required this.brandTextColor,
  });

  final Widget Function()? decorationBuilder;
  final Color? firstGradientBackgroundColor;
  final Color? secondGradientBackgroundColor;
  final Color titlePageColor;
  final Color closingTextColor;
  final Color brideGroomNameColor;
  final Color brandBackgroundColor;
  final Color brandTextColor;
}

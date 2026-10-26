import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/elysian_configs.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/widgets/elysian_stardust_background.dart';

class ElysianChampagnePreset._() {
  static const Color darkBg = Color(0xFF0F0E17);
  static const Color gold = Color(0xFFE5C88F);
  static const Color brightGold = Color(0xFFFFE0A3);
  static const Color ivory = Color(0xFFF7F4EB);
  static const Color mutedIvory = Color(0xFFB8B3A8);
  static const Color cardGlass = Color(0x18FFFFFF);
  static const Color cardBorder = Color(0x50E5C88F);

  static ElysianConfigs get configs => ElysianConfigs(
    globalBackgroundsBuilder: () => [
      const Positioned.fill(
        child: ColoredBox(color: darkBg),
      ),
      const Positioned.fill(
        child: ElysianStardustBackground(
          particleCount: 50,
          primaryGlowColor: gold,
          secondaryGlowColor: brightGold,
        ),
      ),
    ],
    coverPageConfig: const ElysianCoverPageConfig(
      gradientBaseColor: darkBg,
      brideNameColor: brightGold,
      groomNameColor: brightGold,
      goldAccentColor: gold,
      textColor: ivory,
      countdownCardColor: cardGlass,
      countdownBorderColor: cardBorder,
      countdownTextColor: ivory,
    ),
    firstPageConfig: const ElysianFirstPageConfig(
      backgroundColor: Colors.transparent,
      cardBackgroundColor: cardGlass,
      cardBorderColor: cardBorder,
      headerColor: gold,
      quoteTextColor: ivory,
      sourceTextColor: mutedIvory,
      ornamentColor: gold,
    ),
    secondPageConfig: const ElysianSecondPageConfig(
      backgroundColor: Colors.transparent,
      titleColor: gold,
      nameColor: brightGold,
      parentsColor: mutedIvory,
      ringBorderColor: gold,
      cardColor: cardGlass,
    ),
    thirdPageConfig: const ElysianThirdPageConfig(
      backgroundColor: Colors.transparent,
      titleColor: gold,
      nameColor: brightGold,
      parentsColor: mutedIvory,
      ringBorderColor: gold,
      cardColor: cardGlass,
    ),
    fourthPageConfig: const ElysianFourthPageConfig(
      backgroundColor: Colors.transparent,
      cardColor: cardGlass,
      cardBorderColor: cardBorder,
      titleColor: gold,
      eventNameColor: brightGold,
      dateTimeColor: ivory,
      locationColor: mutedIvory,
      buttonColor: gold,
      buttonTextColor: darkBg,
    ),
    fourthDifferentLocationPageConfig: const ElysianFourthDifferentLocationPageConfig(
      backgroundColor: Colors.transparent,
      cardColor: cardGlass,
      cardBorderColor: cardBorder,
      titleColor: gold,
      eventNameColor: brightGold,
      dateTimeColor: ivory,
      locationColor: mutedIvory,
      buttonColor: gold,
      buttonTextColor: darkBg,
    ),
    fifthPageConfig: const ElysianFifthPageConfig(
      backgroundColor: Colors.transparent,
      cardColor: cardGlass,
      cardBorderColor: cardBorder,
      titleColor: gold,
      locationNameColor: brightGold,
      addressColor: mutedIvory,
      buttonColor: gold,
      buttonTextColor: darkBg,
    ),
    fifthDifferentLocationPageConfig: const ElysianFifthDifferentLocationPageConfig(
      backgroundColor: Colors.transparent,
      cardColor: cardGlass,
      cardBorderColor: cardBorder,
      titleColor: gold,
      eventNameColor: brightGold,
      dateTimeColor: ivory,
      locationColor: mutedIvory,
      buttonColor: gold,
      buttonTextColor: darkBg,
    ),
    sixthPageConfig: const ElysianSixthPageConfig(
      backgroundColor: Colors.transparent,
      titleColor: gold,
      subtitleColor: mutedIvory,
      cardBorderColor: cardBorder,
    ),
    seventhPageConfig: const ElysianSeventhPageConfig(
      backgroundColor: Colors.transparent,
      titleColor: gold,
      subtitleColor: mutedIvory,
      cardColor: cardGlass,
      cardBorderColor: cardBorder,
      bankNameColor: gold,
      accountNumberColor: ivory,
      ownerNameColor: mutedIvory,
      copyButtonColor: gold,
      copyButtonTextColor: darkBg,
    ),
    eighthPageConfig: const ElysianEighthPageConfig(
      backgroundColor: Colors.transparent,
      cardColor: cardGlass,
      cardBorderColor: cardBorder,
      titleColor: gold,
      subtitleColor: mutedIvory,
      inputFillColor: Color(0x30FFFFFF),
      inputBorderColor: cardBorder,
      inputTextColor: ivory,
      buttonColor: gold,
      buttonTextColor: darkBg,
      wishNameColor: brightGold,
      wishMessageColor: ivory,
      wishDateColor: mutedIvory,
    ),
    ninthPageConfig: const ElysianNinthPageConfig(
      backgroundColor: Colors.transparent,
      titleColor: gold,
      subtitleColor: ivory,
      coupleNamesColor: brightGold,
      brandNameColor: gold,
      brandSubtitleColor: mutedIvory,
    ),
  );
}

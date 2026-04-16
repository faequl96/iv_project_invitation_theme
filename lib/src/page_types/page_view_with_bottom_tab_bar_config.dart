import 'package:flutter/animation.dart';

class PageViewWithBottomTabBarConfig {
  const PageViewWithBottomTabBarConfig({
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

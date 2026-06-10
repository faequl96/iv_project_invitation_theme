import 'package:flutter/material.dart';

class PageViewTabBarScaffoldWrapper extends StatelessWidget {
  const PageViewTabBarScaffoldWrapper({
    super.key,
    required this.useBackdropBlur,
    this.borderRadius = const .all(.circular(20)),
    required this.child,
  });

  final bool useBackdropBlur;
  final BorderRadiusGeometry borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!useBackdropBlur) return child;

    return ClipRRect(
      borderRadius: borderRadius,
      // borderRadius: .circular(20),
      child: BackdropFilter(filter: .blur(sigmaX: 3, sigmaY: 3), child: child),
    );
  }
}

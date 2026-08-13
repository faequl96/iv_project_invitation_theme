import 'package:flutter/material.dart';

class const GenericScaffoldWrapper({
  super.key,
  required final bool useBackdropBlur,
  final BorderRadiusGeometry borderRadius = const .all(.circular(20)),
  required final Widget child,
}) extends StatelessWidget {
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

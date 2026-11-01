import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/src/widgets/three_dimensions/three_dimension_safe_area_painter.dart';

class const Thick3DCard({
  super.key,
  required final bool isFacingFront,
  required final Widget frontCard,
  required final Widget backCard,
  required final Widget thickCardStack,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final cosAngleAdjustment1 = tiltDx / 8;
    // final cosAngleAdjustment2 = tiltDx / 5.4;
    // final cosAngleFinalAdjustment = isTiltOnLeft
    //     ? (isCardOnLeft ? cosAngleAdjustment2 : -cosAngleAdjustment1)
    //     : (isCardOnLeft ? cosAngleAdjustment1 : -cosAngleAdjustment2);
    // final effectiveCosAngle = cosAngle - (.26 + cosAngleFinalAdjustment);

    // final isFacingFront = isGallery1 ? effectiveCosAngle >= 0 : math.sin(cosAngle) >= .0;

    return Stack(
      alignment: .center,
      clipBehavior: .none,
      children: [
        _stackPositionWrapper(isFacingFront ? 4 : -4, child: thickCardStack),
        _stackPositionWrapper(isFacingFront ? 2 : -2, child: thickCardStack),
        _stackPositionWrapper(0, child: thickCardStack),
        _stackPositionWrapper(isFacingFront ? -2 : 2, child: thickCardStack),
        _stackPositionWrapper(isFacingFront ? -4 : 4, child: isFacingFront ? frontCard : backCard),
      ],
    );
  }

  Widget _stackPositionWrapper(double position, {required Widget child}) => CustomPaint(
    painter: ThreeDimensionSafeAreaPainter(),
    child: Padding(
      padding: const .all(80),
      child: Transform(
        alignment: .center,
        transform: .identity()..translateByDouble(.0, .0, position, 1.0),
        child: child,
      ),
    ),
  );
}

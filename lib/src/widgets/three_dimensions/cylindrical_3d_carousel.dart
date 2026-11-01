import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/src/widgets/three_dimensions/thick_3d_card.dart';
import 'package:iv_project_invitation_theme/src/widgets/three_dimensions/three_dimension_safe_area_painter.dart';

typedef Cylindrical3DCarouselItemBuilder = Thick3DCard Function(
  BuildContext context,
  int index,
  bool isFacingFront,
);

class const Cylindrical3DCarousel({
  super.key,
  required final ValueNotifier<double> ambientPhaseNotifier,
  required final Offset tilt,
  final double cylinderSize = 220.0,
  required final int itemCount,
  required final Cylindrical3DCarouselItemBuilder itemBuilder,
}) extends StatefulWidget {
  @override
  State<Cylindrical3DCarousel> createState() => _Cylindrical3DCarouselState();
}

class _Cylindrical3DCarouselState() extends State<Cylindrical3DCarousel> {
  late final ValueNotifier<double> _continuousAngle;
  double _lastAmbientPhase = .0;

  final _parentMatrix = Matrix4.identity();
  final _totalMatrix = Matrix4.identity();

  double get _angleStep => widget.itemCount > 0 ? (2 * math.pi) / widget.itemCount : 0;

  @override
  void initState() {
    super.initState();

    _continuousAngle = ValueNotifier<double>(.0);
    _lastAmbientPhase = widget.ambientPhaseNotifier.value;

    widget.ambientPhaseNotifier.addListener(_onAutoRotate);
  }

  void _onAutoRotate() {
    final currentPhase = widget.ambientPhaseNotifier.value;
    final delta = currentPhase - _lastAmbientPhase;

    _continuousAngle.value += delta * .4;
    _lastAmbientPhase = currentPhase;
  }

  @override
  void didUpdateWidget(covariant Cylindrical3DCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.ambientPhaseNotifier != widget.ambientPhaseNotifier) {
      oldWidget.ambientPhaseNotifier.removeListener(_onAutoRotate);
      _lastAmbientPhase = widget.ambientPhaseNotifier.value;
      widget.ambientPhaseNotifier.addListener(_onAutoRotate);
    }
  }

  @override
  void dispose() {
    widget.ambientPhaseNotifier.removeListener(_onAutoRotate);
    _continuousAngle.dispose();

    super.dispose();
  }

  void _syncParentTransform(BuildContext context) {
    final renderObj = context.findRenderObject();
    if (renderObj is RenderBox && renderObj.attached && renderObj.hasSize) {
      final size = renderObj.size;
      final cx = size.width * .5;
      final cy = size.height * .5;

      _parentMatrix
        ..setFrom(renderObj.getTransformTo(null))
        ..translateByDouble(cx, cy, .0, 1.0);

      final s = _parentMatrix.storage;
      final w = s[15];
      if (w != .0) {
        final screenCenterX = s[12] / w;
        final screenCenterY = s[13] / w;

        s[0] -= s[3] * screenCenterX;
        s[1] -= s[3] * screenCenterY;
        s[4] -= s[7] * screenCenterX;
        s[5] -= s[7] * screenCenterY;
        s[8] -= s[11] * screenCenterX;
        s[9] -= s[11] * screenCenterY;
        s[12] = .0;
        s[13] = .0;
      }
    } else {
      _parentMatrix.setIdentity();
    }
  }

  bool get _isPlaneFacingCamera {
    final s = _totalMatrix.storage;
    final w3 = s[15];
    final tux = (s[0] * w3) - (s[3] * s[12]);
    final tuy = (s[1] * w3) - (s[3] * s[13]);
    final tvx = (s[4] * w3) - (s[7] * s[12]);
    final tvy = (s[5] * w3) - (s[7] * s[13]);

    return (tux * tvy) - (tuy * tvx) >= 0;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount == 0) return const SizedBox.shrink();

    final surfaceSize = widget.cylinderSize + (200 * 2);
    return GestureDetector(
      behavior: .opaque,
      onHorizontalDragUpdate: (d) => _continuousAngle.value += d.delta.dx * .012,
      child: SizedBox(
        height: surfaceSize,
        width: surfaceSize,
        child: CustomPaint(
          painter: ThreeDimensionSafeAreaPainter(),
          child: ValueListenableBuilder(
            valueListenable: _continuousAngle,
            builder: (context, baseAngle, _) {
              final count = widget.itemCount;

              _syncParentTransform(context);

              final itemAngles = List.generate(
                count,
                (i) => baseAngle + (i * _angleStep),
                growable: false,
              );

              final itemCosines = itemAngles.map(math.cos).toList(growable: false);

              final indices = List.generate(count, (i) => i, growable: false)
                ..sort((a, b) => itemCosines[a].compareTo(itemCosines[b]));

              return Stack(
                alignment: .center,
                clipBehavior: .none,
                children: indices
                    .map((index) {
                      final itemAngle = itemAngles[index];
                      final cosAngle = itemCosines[index];

                      final x = math.sin(itemAngle) * widget.cylinderSize;
                      final z = widget.cylinderSize - (cosAngle * widget.cylinderSize);

                      final normalizedDepth = (cosAngle + 1) / 2;
                      final cardOpacity = .65 + (normalizedDepth * .35);
                      final cardRotationY = -itemAngle;

                      final cardMatrix = Matrix4.identity()
                        ..setEntry(3, 2, .0015)
                        ..translateByDouble(x, -widget.tilt.dy * 15, z, 1.0)
                        ..rotateY(cardRotationY);

                      _totalMatrix
                        ..setFrom(_parentMatrix)
                        ..multiply(cardMatrix);

                      final isFacingFront = _isPlaneFacingCamera;

                      return Transform(
                        key: ValueKey('moment_card_$index'),
                        alignment: .center,
                        transform: cardMatrix,
                        child: Opacity(
                          opacity: cardOpacity.clamp(.0, 1.0),
                          child: widget.itemBuilder(context, index, isFacingFront),
                        ),
                      );
                    })
                    .toList(growable: false),
              );
            },
          ),
        ),
      ),
    );
  }
}

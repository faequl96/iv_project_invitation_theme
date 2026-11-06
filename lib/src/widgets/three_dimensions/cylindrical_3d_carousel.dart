import 'dart:math' as math;
import 'dart:typed_data';

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
  final double proximity = 1.0,
  final double cylinderRadius = 220.0,
  final double baseTunnelDepth = 180.0,
  final double vanishingRangeX = 220.0,
  final double vanishingRangeY = 185.0,
  final double horizonOffsetY = -8.0,
  final double cardEdgePerspective = .00145,
  required final int itemCount,
  required final Cylindrical3DCarouselItemBuilder itemBuilder,
}) extends StatefulWidget {
  @override
  State<Cylindrical3DCarousel> createState() => _Cylindrical3DCarouselState();
}

class _Cylindrical3DCarouselState() extends State<Cylindrical3DCarousel> {
  late final ValueNotifier<double> _continuousAngle;
  double _lastAmbientPhase = .0;
  double _angleStep = .0;

  final _parentMatrix = Matrix4.identity();
  final _totalMatrix = Matrix4.identity();
  final _perspectiveShearMatrix = Matrix4.identity();
  final _cylinderProjectionMatrix = Matrix4.identity();

  late Float64List _itemAngles;
  late Float64List _itemCosines;
  late Int32List _sortedIndices;
  late List<ValueKey<int>> _cardKeys;

  late List<Widget?> _cachedCards;
  late Uint8List _lastFacingState;

  @override
  void initState() {
    super.initState();

    _continuousAngle = ValueNotifier<double>(.0);
    _lastAmbientPhase = widget.ambientPhaseNotifier.value;
    _initBuffers(widget.itemCount);

    widget.ambientPhaseNotifier.addListener(_onAutoRotate);
  }

  @override
  void didUpdateWidget(covariant Cylindrical3DCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.itemCount != widget.itemCount) {
      _initBuffers(widget.itemCount);
    } else if (oldWidget.itemBuilder != widget.itemBuilder) {
      _invalidateCardCache();
    }

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

  void _initBuffers(int count) {
    _angleStep = count > 0 ? (2 * math.pi) / count : .0;
    _itemAngles = Float64List(count);
    _itemCosines = Float64List(count);
    _sortedIndices = Int32List(count);
    _cardKeys = .generate(count, ValueKey.new, growable: false);
    _cachedCards = List<Widget?>.filled(count, null, growable: false);
    _lastFacingState = Uint8List(count);
  }

  void _onAutoRotate() {
    final currentPhase = widget.ambientPhaseNotifier.value;
    final delta = currentPhase - _lastAmbientPhase;

    _continuousAngle.value += delta * .4;
    _lastAmbientPhase = currentPhase;
  }

  void _invalidateCardCache() {
    _lastFacingState.fillRange(0, _lastFacingState.length, 0);
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

  bool get _isFacingFront {
    final s = _totalMatrix.storage;
    final w3 = s[15];
    final tux = (s[0] * w3) - (s[3] * s[12]);
    final tuy = (s[1] * w3) - (s[3] * s[13]);
    final tvx = (s[4] * w3) - (s[7] * s[12]);
    final tvy = (s[5] * w3) - (s[7] * s[13]);

    return (tux * tvy) - (tuy * tvx) >= 0;
  }

  void _sortIndicesByDepth(int count) {
    for (int i = 1; i < count; i++) {
      final keyIndex = _sortedIndices[i];
      final keyCos = _itemCosines[keyIndex];
      int j = i - 1;

      while (j >= 0 && _itemCosines[_sortedIndices[j]] > keyCos) {
        _sortedIndices[j + 1] = _sortedIndices[j];
        j--;
      }
      _sortedIndices[j + 1] = keyIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.itemCount;
    if (count == 0) return const SizedBox.shrink();

    final radius = widget.cylinderRadius;
    final surfaceSize = (radius * 2.0) + 320.0;

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
            builder: (innerContext, baseAngle, _) {
              _syncParentTransform(innerContext);

              const focalLength = 650.0;
              final prox = widget.proximity.clamp(.45, 1.15);
              final pW = (widget.cardEdgePerspective * .82) * prox;

              final vpX = -widget.tilt.dx * widget.vanishingRangeX;
              final vpY = widget.horizonOffsetY - (widget.tilt.dy * widget.vanishingRangeY);

              final centerZ = widget.baseTunnelDepth + radius;
              final centerScale = focalLength / (focalLength + centerZ);
              final baseProgress = 1.0 - centerScale;
              final anchorY = (vpY * baseProgress) * .72;

              final cylVpX = vpX * .36;
              final cylVpY = vpY * .42;
              final shearX = cylVpX * pW;
              final shearY = cylVpY * pW;

              _perspectiveShearMatrix
                ..setIdentity()
                ..setEntry(0, 2, shearX)
                ..setEntry(0, 3, -shearX * radius)
                ..setEntry(1, 2, shearY)
                ..setEntry(1, 3, -shearY * radius)
                ..setEntry(2, 2, .01)
                ..setEntry(3, 2, pW);

              _cylinderProjectionMatrix
                ..setIdentity()
                ..translateByDouble(.0, anchorY, .0, 1.0)
                ..multiply(_perspectiveShearMatrix);

              final camAngle = math.atan(shearX);

              for (int i = 0; i < count; i++) {
                final angle = baseAngle + (i * _angleStep);
                _itemAngles[i] = angle;
                _itemCosines[i] = math.cos(angle - camAngle);
                _sortedIndices[i] = i;
              }

              _sortIndicesByDepth(count);

              final children = List.generate(count, (sortPos) {
                final index = _sortedIndices[sortPos];
                final itemAngle = _itemAngles[index];
                final cosAngle = math.cos(itemAngle);
                final sinAngle = math.sin(itemAngle);

                final orbitX = sinAngle * radius;
                final zLocal = (1.0 - cosAngle) * radius;

                final depthRatio = (1.0 + _itemCosines[index]) * .5;
                final cardOpacity = (.44 + (depthRatio * .56)).clamp(.0, 1.0);

                final cardMatrix = _cylinderProjectionMatrix.clone()
                  ..translateByDouble(orbitX, .0, zLocal, 1.0)
                  ..rotateY(-itemAngle);

                _totalMatrix
                  ..setFrom(_parentMatrix)
                  ..multiply(cardMatrix);

                final isFacingFront = _isFacingFront;
                final targetState = isFacingFront ? 2 : 1;
                if (_lastFacingState[index] != targetState) {
                  _lastFacingState[index] = targetState;
                  _cachedCards[index] = widget.itemBuilder(context, index, isFacingFront);
                }

                return Transform(
                  key: _cardKeys[index],
                  alignment: .center,
                  transform: cardMatrix,
                  child: Opacity(opacity: cardOpacity, child: _cachedCards[index]!),
                );
              }, growable: false);

              return Stack(alignment: .center, clipBehavior: .none, children: children);
            },
          ),
        ),
      ),
    );
  }
}

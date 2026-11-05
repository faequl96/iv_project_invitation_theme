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
  final double cylinderRadius = 265.0,
  final double baseTunnelDepth = 240.0,
  final double tunnelDepthRange = 300.0,
  final double vanishingRangeX = 220.0,
  final double vanishingRangeY = 185.0,
  final double horizonOffsetY = 8.0,
  final double cardEdgePerspective = .00145,
  final double cardHalfWidth = 105.0,
  final double maxCameraYaw = .18,
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
  final _cardPerspectiveMatrix = Matrix4.identity();

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

    final radiusX = widget.cylinderRadius;
    final surfaceSize = (radiusX * 2.0) + 320.0;

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
              final pCard = widget.cardEdgePerspective * prox;
              final cameraYaw = -widget.tilt.dx * widget.maxCameraYaw * prox;

              final vpX = -widget.tilt.dx * widget.vanishingRangeX;
              final vpY = widget.horizonOffsetY - (widget.tilt.dy * widget.vanishingRangeY);

              _cardPerspectiveMatrix
                ..setIdentity()
                ..setEntry(2, 2, .01)
                ..setEntry(3, 2, pCard);

              for (int i = 0; i < count; i++) {
                final angle = baseAngle + (i * _angleStep);
                _itemAngles[i] = angle;
                _itemCosines[i] = math.cos(angle);
                _sortedIndices[i] = i;
              }

              _sortIndicesByDepth(count);

              final children = List.generate(count, (sortPos) {
                final index = _sortedIndices[sortPos];
                final itemAngle = _itemAngles[index];
                final cosAngle = _itemCosines[index];
                final sinAngle = math.sin(itemAngle);

                // 1. Skala ukuran kartu berdasarkan kedalaman silinder
                final normDepth = (1.0 - cosAngle) * .5;
                final zLocal = normDepth * widget.tunnelDepthRange;
                final orbitScale = focalLength / (focalLength + zLocal);

                final frontProtrusion = math.max(.0, cosAngle) * sinAngle.abs();
                final frontScaleComp = 1.0 - (pCard * widget.cardHalfWidth * .5 * frontProtrusion);
                final depthScale = orbitScale * frontScaleComp;

                // 2. Proyeksi posisi sumbu silinder yang terkunci dengan kedalaman karpet & lengkungan lorong
                final zTunnel = widget.baseTunnelDepth + zLocal;
                final tunnelScale = focalLength / (focalLength + zTunnel);
                final tunnelDepthProgress = 1.0 - tunnelScale;

                final orbitX = sinAngle * radiusX;
                final xCenter = (vpX * tunnelDepthProgress) + (orbitX * depthScale);
                final yCenter = vpY * tunnelDepthProgress;

                // 3. Jarak vertikal dari titik tengah kartu ke garis horizon lorong (vpY)
                final localVpY = ((vpY - yCenter) / depthScale) * .55;

                final normalizedFront = 1.0 - normDepth;
                final cardOpacity = (.42 + (normalizedFront * .58)).clamp(.0, 1.0);

                final cardMatrix = Matrix4.identity()
                  ..translateByDouble(xCenter, yCenter, .0, 1.0)
                  ..scaleByDouble(depthScale, depthScale, 1.0, 1.0)
                  ..translateByDouble(.0, localVpY, .0, 1.0)
                  ..multiply(_cardPerspectiveMatrix)
                  ..translateByDouble(.0, -localVpY, .0, 1.0)
                  ..rotateY(-itemAngle + cameraYaw);

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

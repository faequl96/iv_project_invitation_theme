import 'dart:math' as math;

import 'package:flutter/material.dart';

class const Cylindrical3DGallery2({
  super.key,
  required final double ambientPhase,
  required final Offset tilt,
}) extends StatefulWidget {
  @override
  State<Cylindrical3DGallery2> createState() => _Cylindrical3DGallery2State();
}

class _Cylindrical3DGallery2State() extends State<Cylindrical3DGallery2> {
  late final ValueNotifier<double> _continuousAngle;
  double _lastAmbientPhase = .0;

  static const List<Map<String, String>> _moments = [
    {'title': 'Pertemuan Pertama', 'year': '2023', 'caption': 'Yogyakarta'},
    {'title': 'Lamaran Resmi', 'year': '2025', 'caption': 'Surakarta'},
    {'title': 'Prewedding Session', 'year': '2026', 'caption': 'Taman Sari'},
    {'title': 'Menuju Pelaminan', 'year': '2026', 'caption': 'Jakarta'},
    {'title': 'Pertemuan Pertama', 'year': '2023', 'caption': 'Yogyakarta'},
    {'title': 'Lamaran Resmi', 'year': '2025', 'caption': 'Surakarta'},
  ];

  static const double _cylinderRadius = 100.0;
  late final double _angleStep = (2 * math.pi) / _moments.length;

  @override
  void initState() {
    super.initState();

    _continuousAngle = ValueNotifier<double>(.0);
    _lastAmbientPhase = widget.ambientPhase;
  }

  @override
  void didUpdateWidget(covariant Cylindrical3DGallery2 oldWidget) {
    super.didUpdateWidget(oldWidget);

    final delta = widget.ambientPhase - _lastAmbientPhase;

    _continuousAngle.value += delta * .4;
    _lastAmbientPhase = widget.ambientPhase;
  }

  @override
  void dispose() {
    _continuousAngle.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: .opaque,
      onHorizontalDragUpdate: (d) => _continuousAngle.value += d.delta.dx * .012,
      child: SizedBox(
        width: 900,
        height: 600,
        child: ValueListenableBuilder<double>(
          valueListenable: _continuousAngle,
          builder: (_, baseAngle, _) {
            final int count = _moments.length;

            final angles = List.generate(
              count,
              (i) => baseAngle + (i * _angleStep),
              growable: false,
            );
            final zValues = List.generate(count, (i) => math.cos(angles[i]), growable: false);

            final indices = List.generate(count, (i) => i, growable: false);
            indices.sort((a, b) => zValues[a].compareTo(zValues[b]));

            return Stack(
              alignment: .center,
              clipBehavior: .none,
              children: indices
                  .map((index) {
                    final itemAngle = angles[index];
                    final z = zValues[index] * _cylinderRadius;
                    final x = math.sin(itemAngle) * _cylinderRadius;

                    final cardScale = .6 + ((z + _cylinderRadius) / (2 * _cylinderRadius)) * .2;
                    final cardOpacity = .45 + ((z + _cylinderRadius) / (2 * _cylinderRadius)) * .55;
                    final cardRotationY = -itemAngle + (math.pi / 2);
                    final item = _moments[index];

                    return Opacity(
                      key: ValueKey('moment_card_$index'),
                      opacity: cardOpacity.clamp(.0, 1.0),
                      child: Transform(
                        alignment: .center,
                        transform: .identity()
                          ..translateByDouble(x, -widget.tilt.dy * 15, .0, 1.0)
                          ..scaleByDouble(cardScale, cardScale, cardScale, 1.0)
                          ..rotateY(cardRotationY),
                        child: _Thick3DCard(item: item, cosAngle: itemAngle, isGallery1: false),
                      ),
                    );
                  })
                  .toList(growable: false),
            );
          },
        ),
      ),
    );
  }
}

class const _Thick3DCard({
  required final Map<String, String> item,
  required final double cosAngle,
  required final bool isGallery1,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isFacingFront = isGallery1 ? cosAngle >= .38 : math.sin(cosAngle) >= .0;

    final cardEdge = const SizedBox();

    return Stack(
      alignment: .center,
      children: [
        _stackPositionWrapper(isFacingFront ? 3 : -3, child: cardEdge),
        _stackPositionWrapper(isFacingFront ? 1 : -1, child: cardEdge),
        _stackPositionWrapper(isFacingFront ? -1 : 1, child: cardEdge),
        _stackPositionWrapper(
          isFacingFront ? -3 : 3,
          child: isFacingFront ? const SizedBox() : const SizedBox(),
        ),
      ],
    );
  }

  Widget _spaciousWrapper({required Widget child}) => SizedBox(
    height: 600,
    width: 400,
    child: ColoredBox(
      color: Colors.black.withValues(alpha: .005),
      child: Center(child: child),
    ),
  );

  Widget _stackPositionWrapper(double position, {required Widget child}) => _spaciousWrapper(
    child: Transform(
      alignment: .center,
      transform: .identity()..translateByDouble(.0, .0, position, 1.0),
      child: child,
    ),
  );
}

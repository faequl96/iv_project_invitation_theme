import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:iv_project_invitation_theme/src/widgets/three_dimensions/cylindrical_3d_carousel.dart';
import 'package:iv_project_invitation_theme/src/widgets/three_dimensions/thick_3d_card.dart';

class const Royal3DWorldScene({super.key}) extends StatefulWidget {
  @override
  State<Royal3DWorldScene> createState() => _Royal3DWorldSceneState();
}

class _Royal3DWorldSceneState() extends State<Royal3DWorldScene> with TickerProviderStateMixin {
  static const _moments = [
    {'title': 'Pertemuan Pertama', 'year': '2023', 'caption': 'Yogyakarta'},
    {'title': 'Lamaran Resmi', 'year': '2025', 'caption': 'Surakarta'},
    {'title': 'Prewedding Session', 'year': '2026', 'caption': 'Taman Sari'},
    {'title': 'Menuju Pelaminan', 'year': '2026', 'caption': 'Jakarta'},
    {'title': 'Janji Suci Abadi', 'year': '2026', 'caption': 'Nusantara'},
    {'title': 'Pertemuan Pertama', 'year': '2023', 'caption': 'Yogyakarta'},
  ];

  static const _stationZPositions = [.0, 1000.0, 2200.0, 3400.0, 4600.0];
  static const _stationLabels = ['Gerbang', 'Mempelai', 'Acara', 'Galeri 3D', 'Amplop & RSVP'];

  static const _maxCameraZ = 4800.0;
  static const _focalLength = 650.0;
  static const _vanishingFactorX = .34;
  static const _vanishingFactorY = .22;

  Offset _targetTilt = .zero;
  double _targetCameraZ = .0;
  bool _isGateOpen = false;

  late final AnimationController _gateController;
  late final Ticker _physicsTicker;
  late final Listenable _sceneListenable;
  late final Listenable _bgRaysListenable;
  late final Listenable _petalsListenable;

  final _ambientPhaseNotifier = ValueNotifier(.0);
  final _smoothTiltNotifier = ValueNotifier(Offset.zero);
  final _cameraZNotifier = ValueNotifier(.0);
  final _activeStationNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();

    _gateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _sceneListenable = Listenable.merge([_cameraZNotifier, _smoothTiltNotifier]);
    _bgRaysListenable = Listenable.merge([
      _ambientPhaseNotifier,
      _smoothTiltNotifier,
      _gateController,
    ]);
    _petalsListenable = Listenable.merge([
      _ambientPhaseNotifier,
      _cameraZNotifier,
      _smoothTiltNotifier,
    ]);

    _physicsTicker = createTicker((_) {
      _ambientPhaseNotifier.value += .01;

      final curTilt = _smoothTiltNotifier.value;
      if (curTilt != _targetTilt) {
        final dx = lerpDouble(curTilt.dx, _targetTilt.dx, .07) ?? .0;
        final dy = lerpDouble(curTilt.dy, _targetTilt.dy, .07) ?? .0;
        _smoothTiltNotifier.value =
            (dx - _targetTilt.dx).abs() < .0005 && (dy - _targetTilt.dy).abs() < .0005
            ? _targetTilt
            : Offset(dx, dy);
      }

      final curCamZ = _cameraZNotifier.value;
      if (curCamZ != _targetCameraZ) {
        final nextCamZ = lerpDouble(curCamZ, _targetCameraZ, .06) ?? .0;
        final snappedCamZ = (nextCamZ - _targetCameraZ).abs() < .05 ? _targetCameraZ : nextCamZ;
        _cameraZNotifier.value = snappedCamZ;

        int closestIndex = 0;
        double minDiff = .infinity;
        for (int i = 0; i < _stationZPositions.length; i++) {
          final diff = (snappedCamZ - _stationZPositions[i]).abs();
          if (diff < minDiff) {
            minDiff = diff;
            closestIndex = i;
          }
        }
        if (_activeStationNotifier.value != closestIndex) {
          _activeStationNotifier.value = closestIndex;
        }
      }
    })..start();
  }

  @override
  void dispose() {
    _physicsTicker.dispose();
    _gateController.dispose();
    _ambientPhaseNotifier.dispose();
    _smoothTiltNotifier.dispose();
    _cameraZNotifier.dispose();
    _activeStationNotifier.dispose();

    super.dispose();
  }

  void _updatePointerTilt(Offset localPosition, Size size) {
    final nx = (localPosition.dx / size.width) * 2.0 - 1.0;
    final ny = (localPosition.dy / size.height) * 2.0 - 1.0;
    _targetTilt = Offset(nx.clamp(-1.0, 1.0), ny.clamp(-1.0, 1.0));
  }

  void _openRoyalGate() {
    setState(() => _isGateOpen = true);
    _gateController.forward();
    _flyToStation(1);
  }

  void _flyToStation(int index) {
    if (index == 0) {
      _gateController.reverse();
      setState(() => _isGateOpen = false);
    } else if (!_isGateOpen) {
      setState(() => _isGateOpen = true);
      _gateController.forward();
    }
    _targetCameraZ = _stationZPositions[index];
  }

  void _onScrollDelta(double delta) {
    if (!_isGateOpen && delta > 15) {
      _openRoyalGate();
      return;
    }
    if (_isGateOpen) {
      _targetCameraZ = (_targetCameraZ + delta * 2.2).clamp(.0, _maxCameraZ);
      if (_targetCameraZ < 150 && delta < 0) _flyToStation(0);
    }
  }

  Offset _project3DTunnelAxisOffset(Size size, double scale, Offset smoothTilt) {
    final depthProgress = 1.0 - scale;
    return Offset(
      -smoothTilt.dx * size.width * _vanishingFactorX * depthProgress,
      -smoothTilt.dy * size.height * _vanishingFactorY * depthProgress,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Listener(
        onPointerSignal: (event) {
          if (event is PointerScrollEvent) _onScrollDelta(event.scrollDelta.dy);
        },
        child: MouseRegion(
          onHover: (e) => _updatePointerTilt(e.localPosition, size),
          onExit: (_) => _targetTilt = .zero,
          child: GestureDetector(
            onPanUpdate: (details) {
              _updatePointerTilt(details.localPosition, size);
              _onScrollDelta(-details.delta.dy * 1.6);
            },
            onPanEnd: (_) => _targetTilt = .zero,
            child: Stack(
              alignment: .center,
              clipBehavior: .none,
              children: [
                // 1. DEEP SKY & VOLUMETRIC GOD RAYS (Repaint via Listenable, 0 Widget rebuild)
                Positioned.fill(
                  child: RepaintBoundary(
                    child: CustomPaint(
                      painter: VolumetricGodRaysPainter(
                        repaint: _bgRaysListenable,
                        tiltNotifier: _smoothTiltNotifier,
                        ambientPhaseNotifier: _ambientPhaseNotifier,
                        gateController: _gateController,
                        vanishingFactorX: _vanishingFactorX,
                        vanishingFactorY: _vanishingFactorY,
                      ),
                    ),
                  ),
                ),

                // 1.5. JALAN KARPET KERATON 3D (Repaint via Listenable, 0 Widget rebuild)
                Positioned.fill(
                  child: IgnorePointer(
                    child: RepaintBoundary(
                      child: CustomPaint(
                        painter: RoyalPerspectiveWalkwayPainter(
                          repaint: _petalsListenable,
                          cameraZNotifier: _cameraZNotifier,
                          tiltNotifier: _smoothTiltNotifier,
                          ambientPhaseNotifier: _ambientPhaseNotifier,
                          focalLength: _focalLength,
                          vanishingFactorX: _vanishingFactorX,
                          vanishingFactorY: _vanishingFactorY,
                        ),
                      ),
                    ),
                  ),
                ),

                // 2, 3, 4. DYNAMIC 3D TUNNEL ARCHES, STATIONS, & SWINGING GATES
                ListenableBuilder(
                  listenable: _sceneListenable,
                  builder: (context, _) {
                    final camZ = _cameraZNotifier.value;
                    final tilt = _smoothTiltNotifier.value;
                    return Stack(
                      alignment: .center,
                      clipBehavior: .none,
                      children: [
                        ..._build3DTunnelArches(size, camZ, tilt),
                        ..._build3DContentStations(size, camZ, tilt),
                        if (camZ < 950) _build3DSwingingGates(size, camZ, tilt),
                      ],
                    );
                  },
                ),

                // 5. PARTIKEL KELOPAK BUNGA EMAS 3D (Repaint via Listenable, 0 Widget rebuild)
                Positioned.fill(
                  child: IgnorePointer(
                    child: RepaintBoundary(
                      child: CustomPaint(
                        painter: Floating3DPetalsPainter(
                          repaint: _petalsListenable,
                          ambientPhaseNotifier: _ambientPhaseNotifier,
                          cameraZNotifier: _cameraZNotifier,
                          tiltNotifier: _smoothTiltNotifier,
                          vanishingFactorX: _vanishingFactorX,
                          vanishingFactorY: _vanishingFactorY,
                        ),
                      ),
                    ),
                  ),
                ),

                // 6. HUD NAVIGATION BAR
                _buildBottom3DNavigationHud(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _build3DTunnelArches(Size size, double currentCameraZ, Offset smoothTilt) {
    final arches = <Widget>[];
    final isMobile = size.width < 600;
    final archVirtualWidth = isMobile ? (size.width * 1.25).clamp(480.0, 580.0) : size.width;
    final archWidthBoost = isMobile ? 1.15 : 1.0;

    for (double z = 4800; z >= 400; z -= 600) {
      final relativeZ = z - currentCameraZ;
      if (relativeZ <= -420 || relativeZ >= 3600) continue;

      final opacity =
          (1.0 - (relativeZ / 3400)).clamp(.0, 1.0) * ((relativeZ + 350) / 400).clamp(.0, 1.0);
      if (opacity <= .005) continue;

      final scale = _focalLength / (_focalLength + relativeZ);
      final proximity = scale.clamp(.0, 1.0);
      final tunnelOffset = _project3DTunnelAxisOffset(size, scale, smoothTilt);

      arches.add(
        IgnorePointer(
          key: ValueKey('arch_${z.toInt()}'),
          child: Transform(
            alignment: .center,
            transform: _createTunnelAlignedPerspectiveMatrix(
              tx: tunnelOffset.dx,
              ty: tunnelOffset.dy,
              scale: scale,
              scaleXMultiplier: archWidthBoost,
              perspective: .0008 * proximity,
              tiltX: smoothTilt.dx * proximity,
              tiltY: smoothTilt.dy * proximity,
              maxYaw: .10,
              maxPitch: .05,
            ),
            child: OverflowBox(
              maxWidth: archVirtualWidth,
              minWidth: archVirtualWidth,
              maxHeight: size.height,
              minHeight: size.height,
              child: CustomPaint(
                size: Size(archVirtualWidth, size.height),
                painter: GoldenPalaceArchPainter(
                  repaint: _ambientPhaseNotifier,
                  archIndex: z ~/ 600,
                  swingPhaseNotifier: _ambientPhaseNotifier,
                  opacity: opacity,
                  isMobile: isMobile,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return arches;
  }

  List<Widget> _build3DContentStations(Size size, double currentCameraZ, Offset smoothTilt) {
    final stations = <Widget>[];
    for (int i = _stationZPositions.length - 1; i >= 1; i--) {
      final relativeZ = _stationZPositions[i] - currentCameraZ;
      if (relativeZ <= -420 || relativeZ >= 2600) continue;

      final distanceFade = (1.0 - (relativeZ.abs() / 1600)).clamp(.0, 1.0);
      final passThroughFade = ((relativeZ + 360) / 360).clamp(.0, 1.0);
      final opacity = (distanceFade * passThroughFade).clamp(.0, 1.0);
      if (opacity <= .005) continue;

      final scale = _focalLength / (_focalLength + relativeZ);
      final proximity = scale.clamp(.0, 1.0);
      final angularWeight = proximity * proximity;
      final tunnelOffset = _project3DTunnelAxisOffset(size, scale, smoothTilt);
      final attenuatedTilt = smoothTilt * angularWeight;

      // Station 3 (Carousel) mengelola rotasi 3D tiap kartunya sendiri agar tidak miring sebagai kanvas 2D datar
      final stationMatrix = i == 3
          ? (Matrix4.identity()
              ..translateByDouble(tunnelOffset.dx, tunnelOffset.dy, .0, 1.0)
              ..scaleByDouble(scale, scale, scale, 1.0))
          : _createTunnelAlignedPerspectiveMatrix(
              tx: tunnelOffset.dx,
              ty: tunnelOffset.dy,
              scale: scale,
              perspective: .0012 * proximity,
              tiltX: attenuatedTilt.dx,
              tiltY: attenuatedTilt.dy,
              maxYaw: .18,
              maxPitch: .09,
            );

      stations.add(
        KeyedSubtree(
          key: ValueKey('station_3d_$i'),
          child: IgnorePointer(
            ignoring: relativeZ.abs() >= 350,
            child: Transform(
              alignment: .center,
              transform: stationMatrix,
              child: Opacity(
                opacity: opacity,
                child: _buildStationWidgetByIndex(size, i, smoothTilt, attenuatedTilt, proximity),
              ),
            ),
          ),
        ),
      );
    }
    return stations;
  }

  Widget _buildStationWidgetByIndex(
    Size size,
    int index,
    Offset smoothTilt,
    Offset attenuatedTilt,
    double proximity,
  ) {
    return switch (index) {
      1 => _BrideGroom3DShowcase(tilt: attenuatedTilt, proximity: proximity),
      2 => _SacredEvent3DShowcase(tilt: attenuatedTilt),
      3 => Cylindrical3DCarousel(
        ambientPhaseNotifier: _ambientPhaseNotifier,
        tilt: smoothTilt,
        proximity: proximity,
        vanishingRangeX: size.width * _vanishingFactorX,
        vanishingRangeY: size.height * _vanishingFactorY,
        itemCount: _moments.length,
        itemBuilder: (context, index, isFacingFront) => Thick3DCard(
          isFacingFront: isFacingFront,
          frontCard: _CardFront(item: _moments[index]),
          backCard: const _CardBack(),
          thickCardStack: const _CardEdge(),
        ),
      ),
      4 => _HolographicGiftAndRsvpShowcase(tilt: attenuatedTilt, proximity: proximity),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _build3DSwingingGates(Size size, double currentCameraZ, Offset smoothTilt) {
    return AnimatedBuilder(
      animation: _gateController,
      builder: (context, _) {
        final curve = Curves.easeInOutCubic.transform(_gateController.value);
        final doorSwingAngle = curve * (math.pi * .62);
        final effectiveDenom = (_focalLength - currentCameraZ * .55).clamp(160.0, _focalLength);
        final cameraPushScale = _focalLength / effectiveDenom;
        final gateOpacity = (1.0 - (currentCameraZ / 800.0)).clamp(.0, 1.0);
        final tunnelOffset = _project3DTunnelAxisOffset(size, cameraPushScale, smoothTilt);

        final gateSize = Size(
          math.min(size.width * .44, 240.0),
          math.min(size.height * .78, 560.0),
        );

        return Opacity(
          opacity: gateOpacity,
          child: Transform(
            alignment: .center,
            transform: _createTunnelAlignedPerspectiveMatrix(
              tx: tunnelOffset.dx * .35,
              ty: tunnelOffset.dy * .35,
              scale: cameraPushScale,
              perspective: .0008,
              tiltX: smoothTilt.dx,
              tiltY: smoothTilt.dy,
              maxYaw: .09,
              maxPitch: .045,
            ),
            child: Stack(
              alignment: .center,
              children: [
                Row(
                  mainAxisSize: .min,
                  children: [
                    Transform(
                      alignment: .centerLeft,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, .0012)
                        ..rotateY(-doorSwingAngle),
                      child: RepaintBoundary(
                        child: CustomPaint(
                          size: gateSize,
                          painter: const OrnateRoyalDoorPainter(isLeftDoor: true),
                        ),
                      ),
                    ),
                    Transform(
                      alignment: .centerRight,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, .0012)
                        ..rotateY(doorSwingAngle),
                      child: RepaintBoundary(
                        child: CustomPaint(
                          size: gateSize,
                          painter: const OrnateRoyalDoorPainter(isLeftDoor: false),
                        ),
                      ),
                    ),
                  ],
                ),
                if (curve < .85)
                  Opacity(
                    opacity: (1.0 - curve * 1.4).clamp(.0, 1.0),
                    child: Transform(
                      alignment: .center,
                      transform: Matrix4.identity()
                        ..translateByDouble(-smoothTilt.dx * 14.0, -smoothTilt.dy * 10.0, .0, 1.0)
                        ..scaleByDouble(1.0 + curve * .3, 1.0 + curve * .3, 1.0, 1.0),
                      child: _buildCenterRoyalSealMedallion(smoothTilt),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCenterRoyalSealMedallion(Offset smoothTilt) {
    return Container(
      width: 310,
      padding: const .symmetric(horizontal: 26, vertical: 34),
      decoration: BoxDecoration(
        borderRadius: .circular(180),
        gradient: const RadialGradient(colors: [Color(0xFF162E26), Color(0xFF091410)], radius: .9),
        border: .all(color: const Color(0xFFE5C158), width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .8),
            blurRadius: 45,
            spreadRadius: 8,
            offset: Offset(smoothTilt.dx * 22, smoothTilt.dy * 18 + 16),
          ),
          BoxShadow(color: const Color(0xFFD4AF37).withValues(alpha: .28), blurRadius: 40),
        ],
      ),
      child: Column(
        mainAxisSize: .min,
        children: [
          const Icon(Icons.auto_awesome, color: Color(0xFFE5C158), size: 24),
          const SizedBox(height: 10),
          const Text(
            'PAWIWAHAN AGUNG',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 4.5,
              color: Color(0xFFE5C158),
              fontWeight: .w600,
            ),
          ),
          const SizedBox(height: 18),
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              begin: Alignment(-1.0 + smoothTilt.dx * 1.5, -1.0),
              end: Alignment(1.0 + smoothTilt.dx * 1.5, 1.0),
              colors: const [
                Color(0xFFB38728),
                Color(0xFFFBF5B7),
                Color(0xFFD4AF37),
                Color(0xFF8A5A19),
              ],
            ).createShader(bounds),
            child: const Text(
              'Rama\n&\nShinta',
              textAlign: .center,
              style: TextStyle(fontSize: 38, height: 1.12, fontWeight: .bold, color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Minggu, 20 Desember 2026',
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 1.5,
              color: Colors.white.withValues(alpha: .85),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _openRoyalGate,
            icon: const Icon(Icons.meeting_room_outlined, size: 18),
            label: const Text(
              'BUKA GERBANG 3D',
              style: TextStyle(letterSpacing: 2.0, fontSize: 11, fontWeight: .bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE5C158),
              foregroundColor: const Color(0xFF07120E),
              padding: const .symmetric(horizontal: 24, vertical: 14),
              elevation: 14,
              shadowColor: const Color(0xFFE5C158),
              shape: RoundedRectangleBorder(borderRadius: .circular(30)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottom3DNavigationHud() {
    return Positioned(
      bottom: 24,
      child: Column(
        mainAxisSize: .min,
        children: [
          if (_isGateOpen)
            Padding(
              padding: const .only(bottom: 10),
              child: ValueListenableBuilder<double>(
                valueListenable: _cameraZNotifier,
                builder: (_, camZ, _) => Text(
                  'Scroll / Geser Layar untuk Menjelajahi Lorong 3D (Z: ${camZ.toInt()}m)',
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 1.2,
                    color: const Color(0xFFE5C158).withValues(alpha: .75),
                  ),
                ),
              ),
            ),
          Container(
            padding: const .symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF0A1814).withValues(alpha: .75),
              borderRadius: .circular(40),
              border: .all(color: const Color(0xFFD4AF37).withValues(alpha: .45)),
            ),
            child: ValueListenableBuilder<int>(
              valueListenable: _activeStationNotifier,
              builder: (_, activeIndex, _) => Wrap(
                spacing: 6,
                children: List.generate(_stationLabels.length, (i) {
                  final isSelected = activeIndex == i;
                  return InkWell(
                    onTap: () => _flyToStation(i),
                    borderRadius: .circular(24),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const .symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFD4AF37) : Colors.transparent,
                        borderRadius: .circular(24),
                      ),
                      child: Text(
                        _stationLabels[i],
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isSelected ? .bold : .normal,
                          color: isSelected ? const Color(0xFF07120E) : const Color(0xFFE5C158),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Matrix4 _createTunnelAlignedPerspectiveMatrix({
  double tx = .0,
  double ty = .0,
  double scale = 1.0,
  double scaleXMultiplier = 1.0,
  double perspective = .0011,
  double tiltX = .0,
  double tiltY = .0,
  double maxYaw = .16,
  double maxPitch = .08,
  double extraRotateY = .0,
}) {
  final yaw = (-tiltX * maxYaw) + extraRotateY;
  final pitch = tiltY * maxPitch;

  return .identity()
    ..translateByDouble(tx, ty, .0, 1.0)
    ..scaleByDouble(scale * scaleXMultiplier, scale, scale, 1.0)
    ..multiply(.identity()..setEntry(3, 2, perspective))
    ..rotateY(yaw)
    ..rotateX(pitch * math.cos(yaw));
}

// ============================================================================
// SEKSI 1: PROFIL MEMPELAI DENGAN KARTU HOLOGRAM 3D MULTI-LAYER
// ============================================================================
class const _BrideGroom3DShowcase({required final Offset tilt, required final double proximity})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 680,
      constraints: const BoxConstraints(maxWidth: 680),
      padding: const .all(28),
      child: Column(
        mainAxisSize: .min,
        children: [
          const Text(
            'PASANGAN MEMPELAI',
            style: TextStyle(
              letterSpacing: 4,
              fontSize: 12,
              color: Color(0xFFE5C158),
              fontWeight: .bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Maha Suci Tuhan yang telah menciptakan makhluk-Nya berpasang-pasangan.',
            textAlign: .center,
            style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: .75)),
          ),
          const SizedBox(height: 26),
          Wrap(
            spacing: 24,
            runSpacing: 20,
            alignment: .center,
            children: [
              _buildPerson3DCard(
                name: 'R.M. Rama Wijaya, S.Kom.',
                parents: 'Putra Pertama Bpk. H. Wijaya & Ibu Hj. Sekar',
                role: 'THE GROOM',
                icon: Icons.workspace_premium_outlined,
                depthDirection: -1,
              ),
              _buildPerson3DCard(
                name: 'R.A. Shinta Maharani, S.Ds.',
                parents: 'Putri Kedua Bpk. H. Baskoro & Ibu Hj. Dewi',
                role: 'THE BRIDE',
                icon: Icons.diamond_outlined,
                depthDirection: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerson3DCard({
    required String name,
    required String parents,
    required String role,
    required IconData icon,
    required int depthDirection,
  }) {
    return Transform.translate(
      offset: Offset(-tilt.dx * 8.0 * depthDirection, -tilt.dy * 6.0 * depthDirection),
      child: Container(
        width: 280,
        padding: const .all(24),
        decoration: BoxDecoration(
          borderRadius: .circular(28),
          gradient: LinearGradient(
            begin: .topLeft,
            end: .bottomRight,
            colors: [
              const Color(0xFF17332A).withValues(alpha: .9),
              const Color(0xFF0A1612).withValues(alpha: .92),
            ],
          ),
          border: .all(color: const Color(0xFFD4AF37).withValues(alpha: .6)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .65),
              blurRadius: 30,
              offset: Offset(tilt.dx * 16, 15),
            ),
          ],
        ),
        child: Column(
          children: [
            Transform.translate(
              offset: Offset(-tilt.dx * 8, -tilt.dy * 8),
              child: Container(
                width: 82,
                height: 82,
                decoration: BoxDecoration(
                  shape: .circle,
                  gradient: const RadialGradient(colors: [Color(0xFFE5C158), Color(0xFF7D5A18)]),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE5C158).withValues(alpha: .35),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Icon(icon, size: 38, color: const Color(0xFF081410)),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              role,
              style: const TextStyle(fontSize: 10, letterSpacing: 3.0, color: Color(0xFFE5C158)),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              textAlign: .center,
              style: const TextStyle(fontSize: 19, fontWeight: .bold, color: Color(0xFFFFF3D1)),
            ),
            const SizedBox(height: 10),
            Text(
              parents,
              textAlign: .center,
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color: Colors.white.withValues(alpha: .75),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// SEKSI 2: AKAD & RESEPSI DENGAN 3D FLOATING SUNDIAL / COUNTDOWN
// ============================================================================
class const _SacredEvent3DShowcase({required final Offset tilt}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 660,
      padding: const .all(28),
      decoration: BoxDecoration(
        borderRadius: .circular(32),
        color: const Color(0xFF0D1E19).withValues(alpha: .88),
        border: .all(color: const Color(0xFFE5C158).withValues(alpha: .55)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .7),
            blurRadius: 40,
            offset: Offset(tilt.dx * 22, tilt.dy * 18 + 16),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: .min,
        children: [
          const Icon(Icons.location_city_rounded, color: Color(0xFFE5C158), size: 34),
          const SizedBox(height: 10),
          const Text(
            'RANGKAIAN ACARA SUCI',
            style: TextStyle(
              letterSpacing: 4,
              fontSize: 13,
              color: Color(0xFFE5C158),
              fontWeight: .bold,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 20,
            runSpacing: 16,
            alignment: .center,
            children: [
              _buildEventPillar(
                title: 'Akad Nikah',
                time: '08.00 - 10.00 WIB',
                place: 'Masjid Agung Keraton\nJl. Nusantara Raya No. 1, Jakarta',
              ),
              _buildEventPillar(
                title: 'Resepsi Agung',
                time: '11.00 - 14.00 WIB',
                place: 'Grand Emerald Ballroom\nJl. Nusantara Raya No. 1, Jakarta',
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: .center,
            spacing: 8,
            children: [
              _buildCountdownCube('54', 'HARI'),
              _buildCountdownCube('08', 'JAM'),
              _buildCountdownCube('45', 'MENIT'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventPillar({required String title, required String time, required String place}) {
    return Container(
      width: 270,
      padding: const .all(20),
      decoration: BoxDecoration(
        borderRadius: .circular(20),
        color: const Color(0xFF142D25),
        border: .all(color: const Color(0xFFD4AF37).withValues(alpha: .4)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: .bold, color: Color(0xFFFFE599)),
          ),
          const SizedBox(height: 8),
          Text(
            time,
            style: const TextStyle(fontSize: 13, fontWeight: .w600, color: Color(0xFFE5C158)),
          ),
          const SizedBox(height: 10),
          Text(
            place,
            textAlign: .center,
            style: TextStyle(fontSize: 12, height: 1.5, color: Colors.white.withValues(alpha: .8)),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownCube(String value, String label) {
    return Container(
      width: 74,
      padding: const .symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: .circular(14),
        gradient: const LinearGradient(
          colors: [Color(0xFFE5C158), Color(0xFF9C7316)],
          begin: .topLeft,
          end: .bottomRight,
        ),
        boxShadow: [
          BoxShadow(color: const Color(0xFFE5C158).withValues(alpha: .35), blurRadius: 16),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: .bold, color: Color(0xFF07120E)),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: .bold,
              letterSpacing: 1.5,
              color: Color(0xFF07120E),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SEKSI 4: KARTU AMPLOP HOLOGRAM 3D YANG BISA DIBALIK 180 DERAJAT
// ============================================================================
class const _HolographicGiftAndRsvpShowcase({
  required final Offset tilt,
  required final double proximity,
}) extends StatefulWidget {
  @override
  State<_HolographicGiftAndRsvpShowcase> createState() => _HolographicGiftAndRsvpShowcaseState();
}

class _HolographicGiftAndRsvpShowcaseState()
    extends State<_HolographicGiftAndRsvpShowcase>
    with SingleTickerProviderStateMixin {
  late final AnimationController _flipController;
  bool _isFront = true;
  bool _copied = false;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _toggleCardFlip() {
    _isFront ? _flipController.forward() : _flipController.reverse();
    _isFront = !_isFront;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        const Text(
          'TANDA KASIH DIGITAL (KLIK KARTU UNTUK MEMBALIK 3D)',
          style: TextStyle(
            fontSize: 11,
            letterSpacing: 3.0,
            color: Color(0xFFE5C158),
            fontWeight: .bold,
          ),
        ),
        const SizedBox(height: 18),
        GestureDetector(
          onTap: _toggleCardFlip,
          child: AnimatedBuilder(
            animation: _flipController,
            builder: (context, _) {
              final angle = Curves.easeInOutBack.transform(_flipController.value) * math.pi;
              final isShowingBack = angle > (math.pi * .5);

              return Transform(
                alignment: .center,
                transform: .identity()
                  ..setEntry(3, 2, .0008 * widget.proximity)
                  ..rotateY(angle),
                child: Container(
                  width: 380,
                  height: 225,
                  padding: const .all(24),
                  decoration: BoxDecoration(
                    borderRadius: .circular(24),
                    gradient: LinearGradient(
                      begin: Alignment(-1.0 + widget.tilt.dx, -1.0 + widget.tilt.dy * .5),
                      end: Alignment(1.0 - widget.tilt.dx, 1.0 - widget.tilt.dy * .5),
                      colors: const [
                        Color(0xFF9C7316),
                        Color(0xFFF6E27A),
                        Color(0xFFD4AF37),
                        Color(0xFF6E4E0E),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD4AF37).withValues(alpha: .35),
                        blurRadius: 35,
                        offset: Offset(widget.tilt.dx * 16, widget.tilt.dy * 12 + 14),
                      ),
                    ],
                  ),
                  child: isShowingBack
                      ? Transform(
                          alignment: .center,
                          transform: Matrix4.identity()..rotateY(math.pi),
                          child: _buildBackCardContent(),
                        )
                      : _buildFrontCardContent(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFrontCardContent() {
    return Column(
      crossAxisAlignment: .start,
      mainAxisAlignment: .spaceBetween,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            const Text(
              'ROYAL WEDDING GIFT CARD',
              style: TextStyle(
                fontSize: 11,
                letterSpacing: 2.5,
                fontWeight: .bold,
                color: Color(0xFF091410),
              ),
            ),
            Icon(
              Icons.contactless_rounded,
              color: const Color(0xFF091410).withValues(alpha: .8),
              size: 26,
            ),
          ],
        ),
        const Text(
          '1200  2026  8899  0001',
          style: TextStyle(
            fontSize: 22,
            letterSpacing: 3.0,
            fontWeight: .bold,
            color: Color(0xFF091410),
          ),
        ),
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: .start,
              children: [
                Text('ATAS NAMA MEMPELAI', style: TextStyle(fontSize: 9, color: Color(0xFF221A07))),
                Text(
                  'RAMA WIJAYA & SHINTA',
                  style: TextStyle(fontSize: 13, fontWeight: .bold, color: Color(0xFF091410)),
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: () {
                Clipboard.setData(const ClipboardData(text: '1200202688990001'));
                setState(() => _copied = true);
              },
              icon: Icon(_copied ? Icons.check_circle : Icons.copy_rounded, size: 14),
              label: Text(
                _copied ? 'TERSALIN' : 'SALIN NO. REK',
                style: const TextStyle(fontSize: 10, fontWeight: .bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF091410),
                foregroundColor: const Color(0xFFF6E27A),
                padding: const .symmetric(horizontal: 14, vertical: 8),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBackCardContent() {
    return Column(
      mainAxisAlignment: .center,
      children: [
        const Icon(Icons.qr_code_2_rounded, size: 78, color: Color(0xFF091410)),
        const SizedBox(height: 8),
        const Text(
          'SCAN QRIS PAWIWAHAN RAMA & SHINTA',
          style: TextStyle(fontSize: 12, fontWeight: .bold, color: Color(0xFF091410)),
        ),
        const SizedBox(height: 4),
        Text(
          'Ketuk kartu kembali untuk membalik ke tampilan Nomor Rekening',
          style: TextStyle(fontSize: 10, color: const Color(0xFF091410).withValues(alpha: .75)),
        ),
      ],
    );
  }
}

// ============================================================================
// CUSTOM PAINTERS: ZERO-ALLOCATION LOOP & DIRECT REPAINT LISTENABLES
// ============================================================================

class VolumetricGodRaysPainter({
  required super.repaint,
  required final ValueNotifier<Offset> tiltNotifier,
  required final ValueNotifier<double> ambientPhaseNotifier,
  required final Animation<double> gateController,
  required final double vanishingFactorX,
  required final double vanishingFactorY,
}) extends CustomPainter {
  static final Paint _bgPaint = Paint();
  static final Paint _rayPaint = Paint()..blendMode = .plus;
  static final Path _rayPath = Path();

  @override
  void paint(Canvas canvas, Size size) {
    final tilt = tiltNotifier.value;
    final ambientPhase = ambientPhaseNotifier.value;
    final gateOpenProgress = gateController.value;

    final vpAlignX = -tilt.dx * vanishingFactorX * 2.0;
    final vpAlignY = -tilt.dy * vanishingFactorY * 2.0 - .38;

    final bgRect = Offset.zero & size;
    _bgPaint.shader = RadialGradient(
      center: Alignment(vpAlignX, vpAlignY),
      radius: 1.1,
      colors: const [Color(0xFF0D211B), Color(0xFF050D0A), Color(0xFF010302)],
      stops: const [.0, .55, 1.0],
    ).createShader(bgRect);
    canvas.drawRect(bgRect, _bgPaint);

    final sourceX = size.width * .5 - (tilt.dx * size.width * vanishingFactorX);
    final sourceY = size.height * .22 - (tilt.dy * size.height * vanishingFactorY);

    const rayCount = 9;
    final baseIntensity = .07 + (gateOpenProgress * .11);
    _rayPaint.shader = LinearGradient(
      begin: .topCenter,
      end: .bottomCenter,
      colors: [
        const Color(0xFFFFE599).withValues(alpha: baseIntensity),
        const Color(0xFFD4AF37).withValues(alpha: baseIntensity * .25),
        Colors.transparent,
      ],
    ).createShader(bgRect);

    final rayLen = size.height * 1.5;
    final endY = size.height * 1.2;

    for (int i = 0; i < rayCount; i++) {
      final spread = (i - rayCount / 2) * .16;
      final sway = math.sin(ambientPhase + i) * .04 - (tilt.dx * .08);
      final angle = spread + sway;

      _rayPath
        ..reset()
        ..moveTo(sourceX, sourceY)
        ..lineTo(sourceX + math.sin(angle - .06) * rayLen, endY)
        ..lineTo(sourceX + math.sin(angle + .06) * rayLen, endY)
        ..close();

      canvas.drawPath(_rayPath, _rayPaint);
    }
  }

  @override
  bool shouldRepaint(covariant VolumetricGodRaysPainter oldDelegate) => false;
}

class const OrnateRoyalDoorPainter({required final bool isLeftDoor}) extends CustomPainter {
  static final _doorPath = Path();
  static final _filigreePath = Path();
  static final _fillPaint = Paint();
  static final _goldBorder = Paint()
    ..style = .stroke
    ..strokeWidth = 3.0
    ..color = const Color(0xFFE5C158);
  static final _filigreePaint = Paint()
    ..style = .stroke
    ..strokeWidth = 1.2
    ..color = const Color(0xFFD4AF37).withValues(alpha: .45);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    _doorPath.reset();
    if (isLeftDoor) {
      _doorPath
        ..moveTo(.0, h)
        ..lineTo(.0, h * .25)
        ..quadraticBezierTo(.0, .0, w, .0)
        ..lineTo(w, h)
        ..close();
    } else {
      _doorPath
        ..moveTo(.0, h)
        ..lineTo(.0, .0)
        ..quadraticBezierTo(w, .0, w, h * .25)
        ..lineTo(w, h)
        ..close();
    }

    _fillPaint.shader = const LinearGradient(
      begin: .topLeft,
      end: .bottomRight,
      colors: [Color(0xFF152C24), Color(0xFF0A1713), Color(0xFF060E0B)],
    ).createShader(Offset.zero & size);

    canvas.drawPath(_doorPath, _fillPaint);
    canvas.drawPath(_doorPath, _goldBorder);

    _filigreePath.reset();
    for (double y = h * .22; y < h * .88; y += 70) {
      for (double x = w * .22; x < w * .85; x += 60) {
        _filigreePath
          ..addOval(Rect.fromCircle(center: Offset(x, y), radius: 22))
          ..addOval(Rect.fromCircle(center: Offset(x, y), radius: 8));
      }
    }
    canvas.drawPath(_filigreePath, _filigreePaint);
  }

  @override
  bool shouldRepaint(covariant OrnateRoyalDoorPainter oldDelegate) =>
      oldDelegate.isLeftDoor != isLeftDoor;
}

class GoldenPalaceArchPainter({
  required super.repaint,
  required final int archIndex,
  required final ValueNotifier<double> swingPhaseNotifier,
  required final double opacity,
  final bool isMobile = false,
}) extends CustomPainter {
  static final _archPath = Path();
  static final _archPaint = Paint()..style = .stroke;
  static final _pillarAmbientGlowPaint = Paint()
    ..style = .stroke
    ..strokeCap = .round
    ..blendMode = .plus;
  static final _pillarSpecularPaint = Paint()
    ..style = .stroke
    ..strokeCap = .round
    ..blendMode = .plus;
  static final _chainPaint = Paint()..strokeWidth = 1.8;
  static final _outerHaloPaint = Paint()..blendMode = .plus;
  static final _innerBloomPaint = Paint()..blendMode = .plus;
  static final _corePaint = Paint();
  static final _capPaint = Paint()..style = .fill;

  @override
  void paint(Canvas canvas, Size size) {
    if (opacity <= .0) return;

    final w = size.width;
    final h = size.height;
    final leftPillarX = isMobile ? w * .02 : w * .06;
    final rightPillarX = isMobile ? w * .98 : w * .94;
    final shoulderY = isMobile ? h * .26 : h * .32;

    _archPaint
      ..strokeWidth = isMobile ? 3.0 : 2.6
      ..shader = LinearGradient(
        begin: .topCenter,
        end: .bottomCenter,
        colors: [
          const Color(0xFFFFE599).withValues(alpha: opacity * .9),
          const Color(0xFFD4AF37).withValues(alpha: opacity * .85),
          const Color(0xFF5A4210).withValues(alpha: opacity * .7),
        ],
      ).createShader(Offset.zero & size);

    _archPath
      ..reset()
      ..moveTo(leftPillarX, h)
      ..lineTo(leftPillarX, shoulderY)
      ..quadraticBezierTo(leftPillarX, h * .03, w * .5, h * .015)
      ..quadraticBezierTo(rightPillarX, h * .03, rightPillarX, shoulderY)
      ..lineTo(rightPillarX, h);

    canvas.drawPath(_archPath, _archPaint);

    final swing = math.sin(swingPhaseNotifier.value + archIndex) * 9.0;
    final leftLanternX = isMobile ? w * .18 : w * .22;
    final rightLanternX = isMobile ? w * .82 : w * .78;
    final chainLen = isMobile ? 82.0 : 96.0;

    final leftTopAnchor = Offset(leftLanternX + swing, h * .105);
    final rightTopAnchor = Offset(rightLanternX - swing, h * .105);
    final leftLanternCenter = Offset(leftTopAnchor.dx, leftTopAnchor.dy + chainLen);
    final rightLanternCenter = Offset(rightTopAnchor.dx, rightTopAnchor.dy + chainLen);

    _drawPillarIllumination(canvas, leftLanternCenter, w);
    _drawPillarIllumination(canvas, rightLanternCenter, w);

    _drawHangingLantern(canvas, leftTopAnchor, leftLanternCenter);
    _drawHangingLantern(canvas, rightTopAnchor, rightLanternCenter);
  }

  void _drawPillarIllumination(Canvas canvas, Offset lanternCenter, double archWidth) {
    final illuminationRadius = isMobile ? archWidth * .38 : archWidth * .32;
    final glowRect = Rect.fromCircle(center: lanternCenter, radius: illuminationRadius);

    _pillarAmbientGlowPaint
      ..strokeWidth = isMobile ? 7.0 : 6.0
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFE599).withValues(alpha: .42 * opacity),
          const Color(0xFFD4AF37).withValues(alpha: .20 * opacity),
          const Color(0xFF9C7316).withValues(alpha: .06 * opacity),
          Colors.transparent,
        ],
        stops: const [.0, .35, .70, 1.0],
      ).createShader(glowRect);
    canvas.drawPath(_archPath, _pillarAmbientGlowPaint);

    final coreRect = Rect.fromCircle(center: lanternCenter, radius: illuminationRadius * .75);
    _pillarSpecularPaint
      ..strokeWidth = isMobile ? 3.5 : 3.0
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFF4CC).withValues(alpha: .88 * opacity),
          const Color(0xFFFFE599).withValues(alpha: .52 * opacity),
          const Color(0xFFD4AF37).withValues(alpha: .15 * opacity),
          Colors.transparent,
        ],
        stops: const [.0, .30, .65, 1.0],
      ).createShader(coreRect);
    canvas.drawPath(_archPath, _pillarSpecularPaint);
  }

  void _drawHangingLantern(Canvas canvas, Offset topAnchor, Offset lanternCenter) {
    _chainPaint.color = const Color(0xFFE5C158).withValues(alpha: .8 * opacity);
    canvas.drawLine(topAnchor, lanternCenter, _chainPaint);

    final outerRadius = isMobile ? 105.0 : 135.0;
    _outerHaloPaint.shader = RadialGradient(
      colors: [
        const Color(0xFFFFE599).withValues(alpha: .58 * opacity),
        const Color(0xFFD4AF37).withValues(alpha: .25 * opacity),
        const Color(0xFF9C7316).withValues(alpha: .07 * opacity),
        Colors.transparent,
      ],
      stops: const [.0, .30, .65, 1.0],
    ).createShader(Rect.fromCircle(center: lanternCenter, radius: outerRadius));
    canvas.drawCircle(lanternCenter, outerRadius, _outerHaloPaint);

    final innerRadius = isMobile ? 40.0 : 48.0;
    _innerBloomPaint.shader = RadialGradient(
      colors: [
        const Color(0xFFFFF4CC).withValues(alpha: .95 * opacity),
        const Color(0xFFFFE599).withValues(alpha: .52 * opacity),
        const Color(0xFFD4AF37).withValues(alpha: .0),
      ],
      stops: const [.0, .42, 1.0],
    ).createShader(Rect.fromCircle(center: lanternCenter, radius: innerRadius));
    canvas.drawCircle(lanternCenter, innerRadius, _innerBloomPaint);

    _capPaint.color = const Color(0xFFD4AF37).withValues(alpha: opacity);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(lanternCenter.dx, lanternCenter.dy - 13),
          width: 20,
          height: 4.5,
        ),
        const .circular(3),
      ),
      _capPaint,
    );

    final coreRadius = isMobile ? 11.0 : 13.0;
    _corePaint.color = const Color(0xFFFFF4CC).withValues(alpha: opacity);
    canvas.drawOval(
      Rect.fromCenter(center: lanternCenter, width: coreRadius * 1.55, height: coreRadius * 2.0),
      _corePaint,
    );
  }

  @override
  bool shouldRepaint(covariant GoldenPalaceArchPainter oldDelegate) =>
      oldDelegate.opacity != opacity ||
      oldDelegate.isMobile != isMobile ||
      oldDelegate.archIndex != archIndex;
}

class RoyalPerspectiveWalkwayPainter({
  required super.repaint,
  required final ValueNotifier<double> cameraZNotifier,
  required final ValueNotifier<Offset> tiltNotifier,
  required final ValueNotifier<double> ambientPhaseNotifier,
  required final double focalLength,
  required final double vanishingFactorX,
  required final double vanishingFactorY,
}) extends CustomPainter {
  static final _mainPath = Path();
  static final _trimAndTilesPath = Path();

  static final _surfacePaint = Paint()..style = .fill;
  static final _lampFloorSpotPaint = Paint()
    ..style = .fill
    ..blendMode = .plus;
  static final _trimPaint = Paint()
    ..style = .stroke
    ..strokeWidth = 1.4
    ..strokeCap = .butt;

  @override
  void paint(Canvas canvas, Size size) {
    _mainPath.reset();
    _trimAndTilesPath.reset();

    final cameraZ = cameraZNotifier.value;
    final tilt = tiltNotifier.value;
    final ambientPhase = ambientPhaseNotifier.value;

    final w = size.width;
    final h = size.height;
    final centerX = w * .5;
    final centerY = h * .5;
    final isMobile = w < 600;

    const zStart = -220.0;
    const zEnd = 3600.0;

    final maxVanishingX = w * vanishingFactorX;
    final maxVanishingY = h * vanishingFactorY;

    final scaleNear = focalLength / (focalLength + zStart);
    final scaleFar = focalLength / (focalLength + zEnd);

    final axisNearX = -tilt.dx * maxVanishingX * (1.0 - scaleNear);
    final axisNearY = -tilt.dy * maxVanishingY * (1.0 - scaleNear);
    final axisFarX = -tilt.dx * maxVanishingX * (1.0 - scaleFar);
    final axisFarY = -tilt.dy * maxVanishingY * (1.0 - scaleFar);

    final yNear = centerY + axisNearY + (centerY * scaleNear);
    final yFar = centerY + axisFarY + (centerY * scaleFar);

    final halfWidth = isMobile ? w * .6 : w * .3;
    final innerTrimWidth = halfWidth * .86;

    final shaderRect = Rect.fromLTRB(.0, math.min(yFar, yNear), w, math.max(yFar, yNear));

    final nearLeftX = centerX + axisNearX - (halfWidth * scaleNear);
    final nearRightX = centerX + axisNearX + (halfWidth * scaleNear);
    final farRightX = centerX + axisFarX + (halfWidth * scaleFar);
    final farLeftX = centerX + axisFarX - (halfWidth * scaleFar);

    _mainPath
      ..moveTo(nearLeftX, yNear)
      ..lineTo(nearRightX, yNear)
      ..lineTo(farRightX, yFar)
      ..lineTo(farLeftX, yFar)
      ..close();

    _surfacePaint.shader = LinearGradient(
      begin: .bottomCenter,
      end: .topCenter,
      colors: [
        const Color(0xFFB38728).withValues(alpha: .48),
        const Color(0xFF7D5A18).withValues(alpha: .32),
        const Color(0xFF3D2B08).withValues(alpha: .14),
        Colors.transparent,
      ],
      stops: const [.0, .38, .78, 1.0],
    ).createShader(shaderRect);
    canvas.drawPath(_mainPath, _surfacePaint);

    canvas.save();
    canvas.clipPath(_mainPath);

    final archVirtualWidth = isMobile ? (w * 1.25).clamp(480.0, 580.0) : w;
    final archWidthBoost = isMobile ? 1.15 : 1.0;
    final lampWorldOffsetX =
        (isMobile ? archVirtualWidth * .32 : archVirtualWidth * .28) * archWidthBoost;

    final baseSpotRatioY = isMobile ? .3 : .26;
    final tiltFactorY = (1.0 + (tilt.dy * .35)).clamp(.5, 1.6);

    for (double archZ = 4800; archZ >= 600; archZ -= 600) {
      final relZ = archZ - cameraZ;
      if (relZ <= zStart || relZ >= zEnd) continue;

      final fadeFar = (1.0 - (relZ / 3400.0)).clamp(.0, 1.0);
      final fadeNear = ((relZ + 220.0) / 320.0).clamp(.0, 1.0);
      final spotOpacity = fadeFar * fadeNear;
      if (spotOpacity <= .01) continue;

      final scale = focalLength / (focalLength + relZ);
      final depthProgress = 1.0 - scale;

      final axisX = -tilt.dx * maxVanishingX * depthProgress;
      final axisY = -tilt.dy * maxVanishingY * depthProgress;
      final floorY = centerY + axisY + (centerY * scale);

      final archIndex = archZ ~/ 600;
      final swingOffset = math.sin(ambientPhase + archIndex) * 9.0 * archWidthBoost * scale;

      final lampSpreadX = lampWorldOffsetX * scale;
      final leftSpotX = centerX + axisX - lampSpreadX + swingOffset;
      final rightSpotX = centerX + axisX + lampSpreadX - swingOffset;

      final spotRadiusX = (isMobile ? w * .72 : w * .28) * scale;
      final depthFlatten = .4 + (.6 * scale);
      final spotRadiusY = spotRadiusX * baseSpotRatioY * tiltFactorY * depthFlatten;

      _drawFloorLightPool(canvas, Offset(leftSpotX, floorY), spotRadiusX, spotRadiusY, spotOpacity);
      _drawFloorLightPool(
        canvas,
        Offset(rightSpotX, floorY),
        spotRadiusX,
        spotRadiusY,
        spotOpacity,
      );
    }

    canvas.restore();

    final nearInnerLeftX = centerX + axisNearX - (innerTrimWidth * scaleNear);
    final nearInnerRightX = centerX + axisNearX + (innerTrimWidth * scaleNear);
    final farInnerLeftX = centerX + axisFarX - (innerTrimWidth * scaleFar);
    final farInnerRightX = centerX + axisFarX + (innerTrimWidth * scaleFar);

    _trimAndTilesPath
      ..moveTo(nearLeftX, yNear)
      ..lineTo(farLeftX, yFar)
      ..moveTo(nearRightX, yNear)
      ..lineTo(farRightX, yFar)
      ..moveTo(nearInnerLeftX, yNear)
      ..lineTo(farInnerLeftX, yFar)
      ..moveTo(nearInnerRightX, yNear)
      ..lineTo(farInnerRightX, yFar);

    const tileStep = 300.0;
    final firstTileZ = (cameraZ / tileStep).floorToDouble() * tileStep;

    for (double worldZ = firstTileZ - tileStep; worldZ < cameraZ + zEnd; worldZ += tileStep) {
      final relZ = worldZ - cameraZ;
      if (relZ <= zStart || relZ >= zEnd) continue;

      final scale = focalLength / (focalLength + relZ);
      final depthProgress = 1.0 - scale;

      final axisX = -tilt.dx * maxVanishingX * depthProgress;
      final axisY = -tilt.dy * maxVanishingY * depthProgress;

      final ty = centerY + axisY + (centerY * scale);
      final halfTileW = innerTrimWidth * scale;

      _trimAndTilesPath
        ..moveTo(centerX + axisX - halfTileW, ty)
        ..lineTo(centerX + axisX + halfTileW, ty);
    }

    _trimPaint.shader = LinearGradient(
      begin: .bottomCenter,
      end: .topCenter,
      colors: [
        const Color(0xFFFFF3D1).withValues(alpha: .55),
        const Color(0xFFE5C158).withValues(alpha: .24),
        Colors.transparent,
      ],
      stops: const [.0, .6, 1.0],
    ).createShader(shaderRect);

    canvas.drawPath(_trimAndTilesPath, _trimPaint);
  }

  void _drawFloorLightPool(
    Canvas canvas,
    Offset center,
    double radiusX,
    double radiusY,
    double intensity,
  ) {
    if (radiusX <= 1.0 || radiusY <= .5) return;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(1.0, radiusY / radiusX);

    final localCircle = Rect.fromCircle(center: .zero, radius: radiusX);
    _lampFloorSpotPaint.shader = RadialGradient(
      colors: [
        const Color(0xFFFFF4CC).withValues(alpha: .50 * intensity),
        const Color(0xFFFFE599).withValues(alpha: .34 * intensity),
        const Color(0xFFD4AF37).withValues(alpha: .16 * intensity),
        const Color(0xFF8A5A19).withValues(alpha: .04 * intensity),
        Colors.transparent,
      ],
      stops: const [.0, .25, .55, .80, 1.0],
    ).createShader(localCircle);

    canvas.drawCircle(.zero, radiusX, _lampFloorSpotPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant RoyalPerspectiveWalkwayPainter oldDelegate) => false;
}

class Floating3DPetalsPainter({
  required super.repaint,
  required final ValueNotifier<double> ambientPhaseNotifier,
  required final ValueNotifier<double> cameraZNotifier,
  required final ValueNotifier<Offset> tiltNotifier,
  required final double vanishingFactorX,
  required final double vanishingFactorY,
}) extends CustomPainter {
  static final Paint _petalPaint = Paint()..style = .fill;
  static final Path _petalPath = Path()
    ..moveTo(.0, -8)
    ..quadraticBezierTo(7, .0, .0, 8)
    ..quadraticBezierTo(-7, .0, .0, -8);

  static final List<double> _baseZList = [];
  static final List<double> _baseXMultList = [];
  static final List<double> _baseYMultList = [];

  static void _initCache() {
    if (_baseZList.isNotEmpty) return;
    final random = math.Random(108);
    for (int i = 0; i < 34; i++) {
      _baseZList.add(random.nextDouble() * 1600.0);
      _baseXMultList.add((random.nextDouble() - .5) * 1.4);
      _baseYMultList.add((random.nextDouble() - .5) * 1.4);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    _initCache();

    final ambientPhase = ambientPhaseNotifier.value;
    final camZMod = (cameraZNotifier.value * .8) % 1600.0;
    final tilt = tiltNotifier.value;

    final halfW = size.width * .5;
    final halfH = size.height * .5;
    final maxVanishingX = size.width * vanishingFactorX;
    final maxVanishingY = size.height * vanishingFactorY;

    for (int i = 0; i < 34; i++) {
      final zPos = (_baseZList[i] - camZMod + 1600.0) % 1600.0;
      final depthScale = (650.0 / (650.0 + zPos)).clamp(.2, 1.4);
      final oneMinusDepth = 1.0 - depthScale;

      final swayX = math.sin(ambientPhase * 2 + i) * 28.0;
      final swayY = math.cos(ambientPhase + i) * 22.0;

      final screenX =
          halfW -
          (tilt.dx * maxVanishingX * oneMinusDepth) +
          (_baseXMultList[i] * size.width + swayX) * depthScale;
      final screenY =
          halfH -
          (tilt.dy * maxVanishingY * oneMinusDepth) +
          (_baseYMultList[i] * size.height + swayY) * depthScale;

      final opacity = (1.0 - (zPos / 1600.0)).clamp(.15, .85);
      _petalPaint.color = const Color(0xFFFFE599).withValues(alpha: opacity);

      canvas.save();
      canvas.translate(screenX, screenY);
      canvas.rotate(ambientPhase * (i.isEven ? 1.0 : -1.0) + i);
      canvas.scale(depthScale, depthScale * (.35 + math.sin(ambientPhase * 3 + i).abs() * .65));
      canvas.drawPath(_petalPath, _petalPaint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant Floating3DPetalsPainter oldDelegate) => false;
}

class const _CardEdge() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 300,
      child: DecoratedBox(
        decoration: BoxDecoration(borderRadius: .circular(24), color: const Color(0xFFE5C158)),
      ),
    );
  }
}

class const _CardFront({required final Map<String, String> item}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 300,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: .circular(24),
          gradient: const LinearGradient(
            begin: .topCenter,
            end: .bottomCenter,
            colors: [Color(0xFF1E3F34), Color(0xFF0A1713)],
          ),
          border: .all(color: const Color(0xFFE5C158), width: 2),
        ),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            SizedBox(
              width: 64,
              height: 64,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: .circle,
                  border: .all(color: const Color(0xFFE5C158)),
                ),
                child: const Icon(
                  Icons.camera_enhance_outlined,
                  color: Color(0xFFE5C158),
                  size: 28,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              item['year']!,
              style: const TextStyle(fontSize: 12, letterSpacing: 3, color: Color(0xFFE5C158)),
            ),
            const SizedBox(height: 8),
            Text(
              item['title']!,
              textAlign: .center,
              style: const TextStyle(fontSize: 18, fontWeight: .bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              item['caption']!,
              style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: .8)),
            ),
          ],
        ),
      ),
    );
  }
}

class const _CardBack() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.flip(
      flipX: true,
      child: SizedBox(
        width: 200,
        height: 300,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: .circular(24),
            gradient: const LinearGradient(
              begin: .topLeft,
              end: .bottomRight,
              colors: [Color(0xFF0E241D), Color(0xFF050C0A)],
            ),
            border: .all(color: const Color(0xFFE5C158), width: 2),
          ),
          child: Center(
            child: SizedBox(
              width: 80,
              height: 80,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: .circle,
                  border: .all(color: const Color(0xFFE5C158), width: 2),
                ),
                child: const Icon(Icons.auto_awesome, color: Color(0xFFE5C158), size: 32),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

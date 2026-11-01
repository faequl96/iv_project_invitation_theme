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

  // Posisi kemiringan kursor/sentuhan (-1.0 s/d 1.0)
  Offset _targetTilt = Offset.zero;

  double _targetCameraZ = 0.0;
  static const double _maxCameraZ = 4800.0;
  static const double _focalLength = 650.0;

  // Rasio titik hilang (Vanishing Point) terhadap ukuran layar:
  // Setengah lebar arch adalah 0.44 * width (pilar di 0.06w dan 0.94w).
  // Nilai 0.37 (~85% dari 0.44) membuat tepian tunnel di sisi tilt hampir sejajar
  // dengan titik tilt tanpa pernah bocor keluar melewati arch di depannya.
  static const double _vanishingFactorX = 0.37;
  static const double _vanishingFactorY = 0.26;

  // Status Gerbang 3D
  late final AnimationController _gateController;
  late final Ticker _physicsTicker;

  final _ambientPhaseNotifier = ValueNotifier(.0);
  final _smoothTiltNotifier = ValueNotifier(Offset.zero);
  final _cameraZNotifier = ValueNotifier(.0);
  final _activeStationNotifier = ValueNotifier(0);

  bool _isGateOpen = false;

  // Titik perhentian Z-Axis untuk setiap seksi undangan
  final List<double> _stationZPositions = [
    0.0, // 0: Cover Gerbang
    1000.0, // 1: Salam & Mempelai
    2200.0, // 2: Akad & Resepsi
    3400.0, // 3: 3D Ring Gallery
    4600.0, // 4: 3D Flip Amplop & RSVP
  ];

  final List<String> _stationLabels = [
    'Gerbang',
    'Mempelai',
    'Acara',
    'Galeri 3D',
    'Amplop & RSVP',
  ];

  @override
  void initState() {
    super.initState();

    _gateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _physicsTicker = createTicker((_) {
      _ambientPhaseNotifier.value += 0.01;

      final nextTiltX = lerpDouble(_smoothTiltNotifier.value.dx, _targetTilt.dx, 0.07) ?? 0.0;
      final nextTiltY = lerpDouble(_smoothTiltNotifier.value.dy, _targetTilt.dy, 0.07) ?? 0.0;
      _smoothTiltNotifier.value = Offset(nextTiltX, nextTiltY);

      final nextCamZ = lerpDouble(_cameraZNotifier.value, _targetCameraZ, 0.06) ?? 0.0;
      _cameraZNotifier.value = nextCamZ;

      int closestIndex = 0;
      double minDiff = double.infinity;
      for (int i = 0; i < _stationZPositions.length; i++) {
        final diff = (nextCamZ - _stationZPositions[i]).abs();
        if (diff < minDiff) {
          minDiff = diff;
          closestIndex = i;
        }
      }

      if (_activeStationNotifier.value != closestIndex) {
        _activeStationNotifier.value = closestIndex;
      }
    })..start();
  }

  @override
  void dispose() {
    _physicsTicker.dispose();
    _gateController.dispose();

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
      _targetCameraZ = (_targetCameraZ + delta * 2.2).clamp(0.0, _maxCameraZ);
      if (_targetCameraZ < 150 && delta < 0) {
        _flyToStation(0);
      }
    }
  }

  /// Proyeksi Sumbu Lorong 3D Satu Titik Hilang (1-Point Perspective):
  /// - Saat dekat di mata (scale = 1.0) -> depthProgress = 0.0 (tetap di tengah layar).
  /// - Saat semakin jauh (scale -> 0.0) -> depthProgress -> 1.0 (bergeser ekstrem menuju Vanishing Point),
  ///   sehingga tepian tiap tunnel di sisi tilt hampir sejajar sempurna.
  Offset _project3DTunnelAxisOffset(Size size, double scale, Offset smoothTilt) {
    final maxVanishingX = size.width * _vanishingFactorX;
    final maxVanishingY = size.height * _vanishingFactorY;

    final depthProgress = 1.0 - scale;
    final dx = -smoothTilt.dx * maxVanishingX * depthProgress;
    final dy = -smoothTilt.dy * maxVanishingY * depthProgress;
    return Offset(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Listener(
        onPointerSignal: (event) {
          if (event is PointerScrollEvent) {
            _onScrollDelta(event.scrollDelta.dy);
          }
        },
        child: MouseRegion(
          onHover: (e) => _updatePointerTilt(e.localPosition, size),
          onExit: (_) => _targetTilt = Offset.zero,
          child: GestureDetector(
            onPanUpdate: (details) {
              _updatePointerTilt(details.localPosition, size);
              _onScrollDelta(-details.delta.dy * 1.6);
            },
            onPanEnd: (_) => _targetTilt = Offset.zero,
            child: ListenableBuilder(
              listenable: Listenable.merge([_cameraZNotifier, _smoothTiltNotifier]),
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  clipBehavior: .none,
                  children: [
                    // =========================================================
                    // 1. DEEP SKY & VOLUMETRIC GOD RAYS (SINAR CAHAYA DINAMIS)
                    // =========================================================
                    Positioned.fill(
                      child: ValueListenableBuilder(
                        valueListenable: _ambientPhaseNotifier,
                        builder: (context, value, child) {
                          return CustomPaint(
                            painter: VolumetricGodRaysPainter(
                              tilt: _smoothTiltNotifier.value,
                              ambientPhase: value,
                              gateOpenProgress: _gateController.value,
                              vanishingFactorX: _vanishingFactorX,
                              vanishingFactorY: _vanishingFactorY,
                            ),
                          );
                        },
                      ),
                    ),

                    // =========================================================
                    // 2. LORONG ARSITEKTUR 3D (GERBANG ARCH & LENTERA Z-SPACE)
                    // =========================================================
                    ..._build3DTunnelArches(
                      size,
                      _cameraZNotifier.value,
                      _smoothTiltNotifier.value,
                    ),

                    // =========================================================
                    // 3. SEKSI KONTEN UNDANGAN DALAM RUANG 3D (Z-STATIONS)
                    // =========================================================
                    ..._build3DContentStations(
                      size,
                      _cameraZNotifier.value,
                      _smoothTiltNotifier.value,
                    ),

                    // =========================================================
                    // 4. PINTU GERBANG KERATON 3D (SWINGING DOUBLE DOORS)
                    // =========================================================
                    if (_cameraZNotifier.value < 950)
                      _build3DSwingingGates(
                        size,
                        _cameraZNotifier.value,
                        _smoothTiltNotifier.value,
                      ),

                    // =========================================================
                    // 5. PARTIKEL KELOPAK BUNGA EMAS 3D (FOREGROUND BOKEH)
                    // =========================================================
                    Positioned.fill(
                      child: IgnorePointer(
                        child: ValueListenableBuilder(
                          valueListenable: _ambientPhaseNotifier,
                          builder: (context, value, child) {
                            return CustomPaint(
                              painter: Floating3DPetalsPainter(
                                ambientPhase: _ambientPhaseNotifier.value,
                                cameraZ: _cameraZNotifier.value,
                                tilt: _smoothTiltNotifier.value,
                                vanishingFactorX: _vanishingFactorX,
                                vanishingFactorY: _vanishingFactorY,
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // =========================================================
                    // 6. HUD NAVIGATION BAR & PETUNJUK INTERAKSI
                    // =========================================================
                    _buildBottom3DNavigationHud(_cameraZNotifier.value),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _build3DTunnelArches(Size size, double currentCameraZ, Offset smoothTilt) {
    final List<Widget> arches = [];
    for (double z = 4800; z >= 400; z -= 600) {
      final relativeZ = z - currentCameraZ;
      if (relativeZ > -420 && relativeZ < 3600) {
        final scale = _focalLength / (_focalLength + relativeZ);

        final opacity =
            (1.0 - (relativeZ / 3400)).clamp(0.0, 1.0) * ((relativeZ + 350) / 400).clamp(0.0, 1.0);

        // Translasi murni menuju titik hilang (1 - scale) + skala kedalaman (scale)
        // Menjamin seluruh arch tetap simetris, konsentris, dan tidak pernah saling memotong
        final tunnelOffset = _project3DTunnelAxisOffset(size, scale, smoothTilt);

        final archMatrix = Matrix4.identity()
          ..translateByDouble(tunnelOffset.dx, tunnelOffset.dy, .0, 1.0)
          ..scaleByDouble(scale, scale, 1.0, 1.0);

        arches.add(
          IgnorePointer(
            child: Opacity(
              opacity: opacity,
              child: Transform(
                alignment: Alignment.center,
                transform: archMatrix,
                child: ValueListenableBuilder(
                  valueListenable: _ambientPhaseNotifier,
                  builder: (context, value, child) {
                    return CustomPaint(
                      size: Size(size.width, size.height),
                      painter: GoldenPalaceArchPainter(archIndex: (z ~/ 600), swingPhase: value),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      }
    }
    return arches;
  }

  List<Widget> _build3DContentStations(Size size, double currentCameraZ, Offset smoothTilt) {
    final List<Widget> stations = [];
    for (int i = _stationZPositions.length - 1; i >= 1; i--) {
      final stationZ = _stationZPositions[i];
      final relativeZ = stationZ - currentCameraZ;

      if (relativeZ > -420 && relativeZ < 2600) {
        final scale = _focalLength / (_focalLength + relativeZ);
        // Batasi maksimal di 1.0 agar saat stasiun melewati kamera (relativeZ < 0)
        // rotasi tidak membengkak berlebihan
        final proximity = scale.clamp(0.0, 1.0);
        final angularWeight = proximity * proximity;

        final distanceFade = (1.0 - (relativeZ.abs() / 1600)).clamp(0.0, 1.0);
        final passThroughFade = ((relativeZ + 360) / 360).clamp(0.0, 1.0);
        final opacity = (distanceFade * passThroughFade).clamp(0.0, 1.0);

        final tunnelOffset = _project3DTunnelAxisOffset(size, scale, smoothTilt);

        final isInteractive = relativeZ.abs() < 350;

        final stationMatrix = _createPinHolePerspectiveMatrix(
          tx: tunnelOffset.dx,
          ty: tunnelOffset.dy,
          scale: scale,
          perspective: 0.0013 * proximity,
          rotateX: -smoothTilt.dy * 0.16 * angularWeight,
          rotateY: smoothTilt.dx * 0.18 * angularWeight,
        );

        final attenuatedTilt = smoothTilt * angularWeight;

        stations.add(
          KeyedSubtree(
            key: ValueKey('station_3d_$i'),
            child: IgnorePointer(
              ignoring: !isInteractive,
              child: Transform(
                alignment: Alignment.center,
                transform: stationMatrix,
                child: Opacity(
                  opacity: opacity,
                  child: _buildStationWidgetByIndex(i, attenuatedTilt, proximity),
                ),
              ),
            ),
          ),
        );
      }
    }
    return stations;
  }

  Widget _buildStationWidgetByIndex(int index, Offset attenuatedTilt, double proximity) {
    switch (index) {
      case 1:
        return _BrideGroom3DShowcase(tilt: attenuatedTilt, proximity: proximity);
      case 2:
        return _SacredEvent3DShowcase(tilt: attenuatedTilt);
      case 3:
        return const SizedBox.shrink();
      case 4:
        return _HolographicGiftAndRsvpShowcase(tilt: attenuatedTilt, proximity: proximity);
      default:
        return const SizedBox.shrink();
    }
  }

  /// Pintu Gerbang Keraton 3D yang Membuka ke Kiri & Kanan (berada di Z = 0)
  Widget _build3DSwingingGates(Size size, double currentCameraZ, Offset smoothTilt) {
    return AnimatedBuilder(
      animation: _gateController,
      builder: (context, _) {
        final curve = CurvedAnimation(parent: _gateController, curve: Curves.easeInOutCubic).value;

        final doorSwingAngle = curve * (math.pi * 0.62);
        final effectiveDenom = (_focalLength - currentCameraZ * 0.55).clamp(160.0, _focalLength);
        final cameraPushScale = _focalLength / effectiveDenom;
        final gateOpacity = (1.0 - (currentCameraZ / 800.0)).clamp(0.0, 1.0);

        final tunnelOffset = _project3DTunnelAxisOffset(size, cameraPushScale, smoothTilt);

        final gateWidth = math.min(size.width * 0.44, 240.0);
        final gateHeight = math.min(size.height * 0.78, 560.0);

        final gateMatrix = _createPinHolePerspectiveMatrix(
          tx: tunnelOffset.dx * 0.35,
          ty: tunnelOffset.dy * 0.35,
          scale: cameraPushScale,
          perspective: 0.0014,
          rotateX: -smoothTilt.dy * 0.16,
          rotateY: smoothTilt.dx * 0.18,
        );

        return Opacity(
          opacity: gateOpacity,
          child: Transform(
            alignment: Alignment.center,
            transform: gateMatrix,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Pasangan Daun Pintu Gerbang Kiri & Kanan
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Pintu Kiri (Engsel di Kiri)
                    Transform(
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.0015)
                        ..rotateY(-doorSwingAngle),
                      child: CustomPaint(
                        size: Size(gateWidth, gateHeight),
                        painter: OrnateRoyalDoorPainter(isLeftDoor: true, tilt: smoothTilt),
                      ),
                    ),
                    // Pintu Kanan (Engsel di Kanan)
                    Transform(
                      alignment: Alignment.centerRight,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.0015)
                        ..rotateY(doorSwingAngle),
                      child: CustomPaint(
                        size: Size(gateWidth, gateHeight),
                        painter: OrnateRoyalDoorPainter(isLeftDoor: false, tilt: smoothTilt),
                      ),
                    ),
                  ],
                ),

                // Medali Segel Tengah
                if (curve < 0.85)
                  Opacity(
                    opacity: (1.0 - curve * 1.4).clamp(0.0, 1.0),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..translateByDouble(smoothTilt.dx * 24.0, smoothTilt.dy * 24.0, .0, 1.0)
                        ..scaleByDouble(1.0 + curve * 0.3, 1.0 + curve * 0.3, 1.0, 1.0),
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
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 34),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(180),
        gradient: const RadialGradient(colors: [Color(0xFF162E26), Color(0xFF091410)], radius: 0.9),
        border: Border.all(color: const Color(0xFFE5C158), width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.8),
            blurRadius: 45,
            spreadRadius: 8,
            offset: Offset(-smoothTilt.dx * 28, -smoothTilt.dy * 28 + 18),
          ),
          BoxShadow(color: const Color(0xFFD4AF37).withValues(alpha: 0.28), blurRadius: 40),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_awesome, color: Color(0xFFE5C158), size: 24),
          const SizedBox(height: 10),
          const Text(
            'PAWIWAHAN AGUNG',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 4.5,
              color: Color(0xFFE5C158),
              fontWeight: FontWeight.w600,
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
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 38,
                height: 1.12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Minggu, 20 Desember 2026',
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 1.5,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _openRoyalGate,
            icon: const Icon(Icons.meeting_room_outlined, size: 18),
            label: const Text(
              'BUKA GERBANG 3D',
              style: TextStyle(letterSpacing: 2.0, fontSize: 11, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE5C158),
              foregroundColor: const Color(0xFF07120E),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              elevation: 14,
              shadowColor: const Color(0xFFE5C158),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottom3DNavigationHud(double currentCameraZ) {
    return Positioned(
      bottom: 24,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isGateOpen)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'Scroll / Geser Layar untuk Menjelajahi Lorong 3D (Z: ${currentCameraZ.toInt()}m)',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 1.2,
                  color: const Color(0xFFE5C158).withValues(alpha: 0.75),
                ),
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF0A1814).withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: const Color(0xFFD4AF37).withValues(alpha: 0.45)),
            ),
            child: Wrap(
              spacing: 6,
              children: List.generate(_stationLabels.length, (i) {
                final isSelected = _activeStationNotifier.value == i;
                return InkWell(
                  onTap: () => _flyToStation(i),
                  borderRadius: BorderRadius.circular(24),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFD4AF37) : Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      _stationLabels[i],
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? const Color(0xFF07120E) : const Color(0xFFE5C158),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

/// Helper Matriks Proyeksi Pinhole 3D:
/// Mengalikan matriks perspektif dengan `..multiply(...)` setelah translasi dan skala
/// agar translasi layar (tx, ty) yang besar saat jauh tidak memicu distorsi trapesium (shear).
Matrix4 _createPinHolePerspectiveMatrix({
  double tx = .0,
  double ty = .0,
  double scale = 1.0,
  double perspective = .0014,
  double rotateX = .0,
  double rotateY = .0,
}) {
  final perspectiveMatrix = Matrix4.identity()..setEntry(3, 2, perspective);
  return Matrix4.identity()
    ..translateByDouble(tx, ty, .0, 1.0)
    ..scaleByDouble(scale, scale, scale, 1.0)
    ..multiply(perspectiveMatrix)
    ..rotateX(rotateX)
    ..rotateY(rotateY);
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
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'PASANGAN MEMPELAI',
            style: TextStyle(
              letterSpacing: 4,
              fontSize: 12,
              color: Color(0xFFE5C158),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Maha Suci Tuhan yang telah menciptakan makhluk-Nya berpasang-pasangan.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.75)),
          ),
          const SizedBox(height: 26),
          Wrap(
            spacing: 24,
            runSpacing: 20,
            alignment: WrapAlignment.center,
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
    final cardMatrix = _createPinHolePerspectiveMatrix(
      tx: tilt.dx * 12.0 * depthDirection,
      ty: tilt.dy * 10.0,
      perspective: 0.0014 * proximity,
      rotateX: -tilt.dy * 0.14,
      rotateY: tilt.dx * 0.14,
    );

    return Transform(
      alignment: Alignment.center,
      transform: cardMatrix,
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF17332A).withValues(alpha: 0.9),
              const Color(0xFF0A1612).withValues(alpha: 0.92),
            ],
          ),
          border: Border.all(color: const Color(0xFFD4AF37).withValues(alpha: 0.6)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.65),
              blurRadius: 30,
              offset: Offset(-tilt.dx * 18, 15),
            ),
          ],
        ),
        child: Column(
          children: [
            Transform.translate(
              offset: Offset(tilt.dx * 12, tilt.dy * 12),
              child: Container(
                width: 82,
                height: 82,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const RadialGradient(colors: [Color(0xFFE5C158), Color(0xFF7D5A18)]),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE5C158).withValues(alpha: 0.35),
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
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFF3D1),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              parents,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color: Colors.white.withValues(alpha: 0.75),
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
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: const Color(0xFF0D1E19).withValues(alpha: 0.88),
        border: Border.all(color: const Color(0xFFE5C158).withValues(alpha: 0.55)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.7),
            blurRadius: 40,
            offset: Offset(-tilt.dx * 22, -tilt.dy * 22 + 16),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.location_city_rounded, color: Color(0xFFE5C158), size: 34),
          const SizedBox(height: 10),
          const Text(
            'RANGKAIAN ACARA SUCI',
            style: TextStyle(
              letterSpacing: 4,
              fontSize: 13,
              color: Color(0xFFE5C158),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 20,
            runSpacing: 16,
            alignment: WrapAlignment.center,
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF142D25),
        border: Border.all(color: const Color(0xFFD4AF37).withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFE599),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            time,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFFE5C158),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            place,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, height: 1.5, color: Colors.white.withValues(alpha: 0.8)),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownCube(String value, String label) {
    return Container(
      width: 74,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          colors: [Color(0xFFE5C158), Color(0xFF9C7316)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(color: const Color(0xFFE5C158).withValues(alpha: 0.35), blurRadius: 16),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF07120E),
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
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
    if (_isFront) {
      _flipController.forward();
    } else {
      _flipController.reverse();
    }
    _isFront = !_isFront;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'TANDA KASIH DIGITAL (KLIK KARTU UNTUK MEMBALIK 3D)',
          style: TextStyle(
            fontSize: 11,
            letterSpacing: 3.0,
            color: Color(0xFFE5C158),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 18),
        GestureDetector(
          onTap: _toggleCardFlip,
          child: AnimatedBuilder(
            animation: _flipController,
            builder: (context, _) {
              final angle =
                  CurvedAnimation(parent: _flipController, curve: Curves.easeInOutBack).value *
                  math.pi;

              final isShowingBack = angle > (math.pi / 2);

              final cardMatrix = _createPinHolePerspectiveMatrix(
                perspective: 0.0014 * widget.proximity,
                rotateX: -widget.tilt.dy * 0.16,
                rotateY: (widget.tilt.dx * 0.18) + angle,
              );

              return Transform(
                alignment: Alignment.center,
                transform: cardMatrix,
                child: Container(
                  width: 380,
                  height: 225,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      begin: Alignment(-1.0 + widget.tilt.dx, -1.0 + widget.tilt.dy * 0.5),
                      end: Alignment(1.0 - widget.tilt.dx, 1.0 - widget.tilt.dy * 0.5),
                      colors: const [
                        Color(0xFF9C7316),
                        Color(0xFFF6E27A),
                        Color(0xFFD4AF37),
                        Color(0xFF6E4E0E),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD4AF37).withValues(alpha: 0.35),
                        blurRadius: 35,
                        offset: Offset(-widget.tilt.dx * 16, -widget.tilt.dy * 12 + 14),
                      ),
                    ],
                  ),
                  child: isShowingBack
                      ? Transform(
                          alignment: Alignment.center,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'ROYAL WEDDING GIFT CARD',
              style: TextStyle(
                fontSize: 11,
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
                color: Color(0xFF091410),
              ),
            ),
            Icon(
              Icons.contactless_rounded,
              color: const Color(0xFF091410).withValues(alpha: 0.8),
              size: 26,
            ),
          ],
        ),
        const Text(
          '1200  2026  8899  0001',
          style: TextStyle(
            fontSize: 22,
            letterSpacing: 3.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF091410),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ATAS NAMA MEMPELAI', style: TextStyle(fontSize: 9, color: Color(0xFF221A07))),
                Text(
                  'RAMA WIJAYA & SHINTA',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF091410),
                  ),
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
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF091410),
                foregroundColor: const Color(0xFFF6E27A),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBackCardContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.qr_code_2_rounded, size: 78, color: Color(0xFF091410)),
        const SizedBox(height: 8),
        const Text(
          'SCAN QRIS PAWIWAHAN RAMA & SHINTA',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF091410)),
        ),
        const SizedBox(height: 4),
        Text(
          'Ketuk kartu kembali untuk membalik ke tampilan Nomor Rekening',
          style: TextStyle(fontSize: 10, color: const Color(0xFF091410).withValues(alpha: 0.75)),
        ),
      ],
    );
  }
}

// ============================================================================
// CUSTOM PAINTERS: GOD RAYS, GERBANG UKIR 3D, LORONG ARCH, DAN KELOPAK 3D
// ============================================================================

/// 1. Painter untuk Sinar Cahaya Ilahi (Volumetric God Rays)
/// Pusat sinar dikunci pada Vanishing Point ujung lorong (depthProgress = 1.0)
class VolumetricGodRaysPainter({
  required final Offset tilt,
  required final double ambientPhase,
  required final double gateOpenProgress,
  required final double vanishingFactorX,
  required final double vanishingFactorY,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgRect = Offset.zero & size;
    final bgPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment(
          -tilt.dx * vanishingFactorX * 0.5,
          -0.25 - tilt.dy * vanishingFactorY * 0.5,
        ),
        radius: 1.2,
        colors: const [Color(0xFF1B3B30), Color(0xFF0B1915), Color(0xFF040907)],
      ).createShader(bgRect);
    canvas.drawRect(bgRect, bgPaint);

    // Pusat pancaran sinar berada tepat di titik hilang (ujung terjauh lorong 3D)
    final sourceX = size.width * 0.5 - (tilt.dx * size.width * vanishingFactorX * 0.85);
    final sourceY = size.height * 0.16 - (tilt.dy * size.height * vanishingFactorY * 0.85);

    const rayCount = 9;
    final baseIntensity = 0.08 + (gateOpenProgress * 0.12);

    for (int i = 0; i < rayCount; i++) {
      final spread = (i - rayCount / 2) * 0.16;
      final sway = math.sin(ambientPhase + i) * 0.04 - (tilt.dx * 0.08);
      final angle = spread + sway;

      final path = Path()
        ..moveTo(sourceX, sourceY)
        ..lineTo(sourceX + math.sin(angle - 0.06) * size.height * 1.4, size.height * 1.2)
        ..lineTo(sourceX + math.sin(angle + 0.06) * size.height * 1.4, size.height * 1.2)
        ..close();

      final rayPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFFE599).withValues(alpha: baseIntensity),
            const Color(0xFFD4AF37).withValues(alpha: baseIntensity * 0.3),
            Colors.transparent,
          ],
        ).createShader(bgRect)
        ..blendMode = BlendMode.plus;

      canvas.drawPath(path, rayPaint);
    }
  }

  @override
  bool shouldRepaint(covariant VolumetricGodRaysPainter oldDelegate) => true;
}

/// 2. Painter untuk Daun Pintu Gerbang Keraton 3D (Kiri & Kanan)
class OrnateRoyalDoorPainter({required final bool isLeftDoor, required final Offset tilt})
    extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final doorPath = Path();
    if (isLeftDoor) {
      doorPath.moveTo(0, h);
      doorPath.lineTo(0, h * 0.25);
      doorPath.quadraticBezierTo(0, 0, w, 0);
      doorPath.lineTo(w, h);
      doorPath.close();
    } else {
      doorPath.moveTo(0, h);
      doorPath.lineTo(0, 0);
      doorPath.quadraticBezierTo(w, 0, w, h * 0.25);
      doorPath.lineTo(w, h);
      doorPath.close();
    }

    final fillPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF152C24), Color(0xFF0A1713), Color(0xFF060E0B)],
      ).createShader(Offset.zero & size);
    canvas.drawPath(doorPath, fillPaint);

    final goldBorder = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = const Color(0xFFE5C158);
    canvas.drawPath(doorPath, goldBorder);

    final filigreePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = const Color(0xFFD4AF37).withValues(alpha: 0.45);

    for (double y = h * 0.22; y < h * 0.88; y += 70) {
      for (double x = w * 0.22; x < w * 0.85; x += 60) {
        canvas.drawCircle(Offset(x, y), 22, filigreePaint);
        canvas.drawCircle(Offset(x, y), 8, filigreePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant OrnateRoyalDoorPainter oldDelegate) => oldDelegate.tilt != tilt;
}

/// 3. Painter untuk Pilar Lengkung Emas & Lentera Gantung di Sepanjang Lorong Z
class GoldenPalaceArchPainter({required final int archIndex, required final double swingPhase})
    extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final archPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFE599), Color(0xFFD4AF37), Color(0xFF5A4210)],
      ).createShader(Offset.zero & size);

    final archPath = Path()
      ..moveTo(w * 0.06, h)
      ..lineTo(w * 0.06, h * 0.32)
      ..quadraticBezierTo(w * 0.06, h * 0.04, w * 0.5, h * 0.02)
      ..quadraticBezierTo(w * 0.94, h * 0.04, w * 0.94, h * 0.32)
      ..lineTo(w * 0.94, h);

    canvas.drawPath(archPath, archPaint);

    final swing = math.sin(swingPhase + archIndex) * 8.0;
    _drawHangingLantern(canvas, Offset(w * 0.18 + swing, h * 0.14), 90);
    _drawHangingLantern(canvas, Offset(w * 0.82 - swing, h * 0.14), 90);
  }

  void _drawHangingLantern(Canvas canvas, Offset topAnchor, double chainLength) {
    final chainPaint = Paint()
      ..color = const Color(0xFFD4AF37).withValues(alpha: 0.7)
      ..strokeWidth = 1.5;

    final lanternCenter = Offset(topAnchor.dx, topAnchor.dy + chainLength);
    canvas.drawLine(topAnchor, lanternCenter, chainPaint);

    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFE599).withValues(alpha: 0.55),
          const Color(0xFFD4AF37).withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: lanternCenter, radius: 42));
    canvas.drawCircle(lanternCenter, 42, glowPaint);

    final corePaint = Paint()..color = const Color(0xFFFFF4CC);
    canvas.drawCircle(lanternCenter, 6, corePaint);
  }

  @override
  bool shouldRepaint(covariant GoldenPalaceArchPainter oldDelegate) =>
      oldDelegate.swingPhase != swingPhase;
}

/// 4. Painter Partikel Kelopak Bunga Emas 3D (Mengikuti Sumbu Lorong 1 - s)
class Floating3DPetalsPainter({
  required final double ambientPhase,
  required final double cameraZ,
  required final Offset tilt,
  required final double vanishingFactorX,
  required final double vanishingFactorY,
}) extends CustomPainter {
  static final Paint _petalPaint = Paint()..style = .fill;
  static final Path _petalPath = Path()
    ..moveTo(0, -8)
    ..quadraticBezierTo(7, 0, 0, 8)
    ..quadraticBezierTo(-7, 0, 0, -8);

  static final List<double> _baseZList = [];
  static final List<double> _baseXMultList = [];
  static final List<double> _baseYMultList = [];

  static void _initCache() {
    if (_baseZList.isNotEmpty) return;

    final random = math.Random(108);
    for (int i = 0; i < 34; i++) {
      _baseZList.add(random.nextDouble() * 1600.0);
      _baseXMultList.add((random.nextDouble() - 0.5) * 1.4);
      _baseYMultList.add((random.nextDouble() - 0.5) * 1.4);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    _initCache();

    final maxVanishingX = size.width * vanishingFactorX;
    final maxVanishingY = size.height * vanishingFactorY;

    for (int i = 0; i < 34; i++) {
      final baseZ = _baseZList[i];
      final baseX = _baseXMultList[i] * size.width;
      final baseY = _baseYMultList[i] * size.height;

      final zPos = (baseZ - (cameraZ * 0.8) % 1600.0 + 1600.0) % 1600.0;
      final depthScale = (650.0 / (650.0 + zPos)).clamp(0.2, 1.4);

      final swayX = math.sin(ambientPhase * 2 + i) * 28.0;
      final swayY = math.cos(ambientPhase * 1.0 + i) * 22.0;

      // Kelopak di kejauhan mengikuti titik hilang lorong (1 - depthScale)
      final tunnelAxisX = -tilt.dx * maxVanishingX * (1.0 - depthScale);
      final tunnelAxisY = -tilt.dy * maxVanishingY * (1.0 - depthScale);

      final screenX = size.width / 2 + tunnelAxisX + (baseX + swayX) * depthScale;
      final screenY = size.height / 2 + tunnelAxisY + (baseY + swayY) * depthScale;

      final opacity = (1.0 - (zPos / 1600.0)).clamp(0.15, 0.85);

      _petalPaint.color = const Color(0xFFFFE599).withValues(alpha: opacity);

      canvas.save();
      canvas.translate(screenX, screenY);
      canvas.rotate(ambientPhase * (i.isEven ? 1.0 : -1.0) + i);
      final flipSquash = (0.35 + math.sin(ambientPhase * 3 + i).abs() * 0.65);
      canvas.scale(depthScale, depthScale * flipSquash);

      canvas.drawPath(_petalPath, _petalPaint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant Floating3DPetalsPainter oldDelegate) => true;
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

// import 'dart:async';
// import 'dart:ui' as ui;
// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
// import 'package:vector_math/vector_math_64.dart' as v_math;

// class _DrawData {
//   Offset offset = Offset.zero;
//   double z = 0;
//   double scale = 0;
//   Color color = Colors.transparent;
//   ParticleType? type;
//   ui.Image? image;
//   double rotation = 0;
// }

// class _Particle {
//   _Particle({required this.basePosition, this.color = Colors.white, this.image, required this.type, this.isFlickering = false})
//     : velocityMultiplier = math.Random().nextDouble() * 2.5 + .5,
//       rotationAngle = math.Random().nextDouble() * math.pi * 2,
//       rotationSpeed = (math.Random().nextDouble() - .5) * .05;

//   final v_math.Vector3 basePosition;
//   final double velocityMultiplier;
//   final Color color;
//   final ui.Image? image;
//   final ParticleType type;
//   final bool isFlickering;
//   double rotationAngle;
//   final double rotationSpeed;
// }

// enum GroundType { fore, back, both }

// enum ParticleType { circle, image }

// class Particle {
//   Particle.circle({required this.color}) : type = ParticleType.circle;
//   Particle.image({required this.imagePath}) : type = ParticleType.image;

//   final ParticleType type;
//   late final Color color;
//   late final String imagePath;
// }

// class ParticleSphereConfig {
//   const ParticleSphereConfig({
//     this.size = 200,
//     this.particleCount = 30,
//     this.particleScaleSize = 6,
//     required this.particleVariatios,
//     this.groundType = .both,
//   });

//   final double size;
//   final int particleCount;
//   final double particleScaleSize;
//   final List<Particle> particleVariatios;
//   final GroundType groundType;
// }

// class ParticleSphere extends StatefulWidget {
//   const ParticleSphere({
//     super.key,
//     required this.config,
//     this.initialPage = 0,
//     this.viewAsSinglePage = false,
//     this.useWrapper = true,
//     this.child = const SizedBox.shrink(),
//   });

//   final ParticleSphereConfig config;
//   final int initialPage;
//   final bool viewAsSinglePage;
//   final bool useWrapper;
//   final Widget child;

//   @override
//   State<ParticleSphere> createState() => _ParticleSphereState();
// }

// class _ParticleSphereState extends State<ParticleSphere> with TickerProviderStateMixin {
//   StreamSubscription? _sub;

//   AnimationController? _controller;
//   final List<_Particle> _particles = [];
//   final v_math.Matrix4 _rotation = v_math.Matrix4.identity();

//   late final AnimationController _secondController;
//   late final Animation<double> _explosionAnimation;
//   late final Animation<double> _fadeAnimation;

//   double _rotateX = .003;
//   double _rotateY = .003;
//   double _targetRotateX = .003;
//   double _targetRotateY = .003;

//   static const String _packageName = 'iv_project_invitation_theme';
//   final _loadedImages = <String, ui.Image>{};
//   bool _isLoading = true;

//   void _updateRotation() {
//     _rotateX = _rotateX + (_targetRotateX - _rotateX) * .01;
//     _rotateY = _rotateY + (_targetRotateY - _rotateY) * .01;

//     _rotation.rotateY(_rotateY);
//     _rotation.rotateX(_rotateX);

//     final rand = math.Random();
//     if (rand.nextInt(100) == 1) {
//       _targetRotateX = (rand.nextDouble() - .5) * .015;
//       _targetRotateY = (rand.nextDouble() - .5) * .015;
//     }
//   }

//   Future<ui.Image> _loadAssetImage(String path) async {
//     final data = await rootBundle.load('packages/$_packageName/$path');
//     final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
//     final frame = await codec.getNextFrame();
//     return frame.image;
//   }

//   void _generateParticles() {
//     final rand = math.Random();
//     const goldenRatio = 1.61803398875;
//     double radius = widget.config.size / 3;

//     for (int i = 0; i < widget.config.particleCount; i++) {
//       double y = 1 - (i / (widget.config.particleCount - 1)) * 2;
//       double radiusAtY = math.sqrt(1 - y * y);
//       double theta = 2 * math.pi * goldenRatio * i;

//       v_math.Vector3 pos = v_math.Vector3(math.cos(theta) * radiusAtY, y, math.sin(theta) * radiusAtY) * radius;

//       final variation = widget.config.particleVariatios[rand.nextInt(widget.config.particleVariatios.length)];

//       _particles.add(
//         _Particle(
//           basePosition: pos,
//           type: variation.type,
//           color: variation.type == ParticleType.circle ? variation.color : Colors.white,
//           image: variation.type == ParticleType.image ? _loadedImages[variation.imagePath] : null,
//           isFlickering: rand.nextDouble() < .4,
//         ),
//       );
//     }
//   }

//   Future<void> _init() async {
//     for (var variation in widget.config.particleVariatios) {
//       if (variation.type == ParticleType.image && !_loadedImages.containsKey(variation.imagePath)) {
//         final img = await _loadAssetImage(variation.imagePath);
//         _loadedImages[variation.imagePath] = img;
//       }
//     }

//     _generateParticles();

//     if (mounted) setState(() => _isLoading = false);
//   }

//   @override
//   void initState() {
//     super.initState();

//     _init();

//     _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
//       ..addListener(_updateRotation)
//       ..repeat();

//     _secondController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

//     _explosionAnimation = Tween<double>(begin: .0, end: 2).animate(
//       CurvedAnimation(
//         parent: _secondController,
//         curve: const Interval(.1, 1, curve: Curves.easeOutCubic),
//       ),
//     );

//     _fadeAnimation = Tween<double>(begin: .0, end: 1).animate(
//       CurvedAnimation(
//         parent: _secondController,
//         curve: const Interval(.0, .3, curve: Curves.easeIn),
//       ),
//     );

//     _sub = context.read<InvitationThemeCoreCubit>().stream.listen((state) {
//       if (widget.viewAsSinglePage) {
//         final explose = widget.initialPage == 0 && !widget.useWrapper;
//         if (explose) {
//           _secondController.forward();
//         } else {
//           if (widget.initialPage != 0) _secondController.value = 1;
//         }
//       } else {
//         if (state.animationTrigger == 1) {
//           _secondController.forward();
//           _sub?.cancel();
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _sub?.cancel();

//     _controller?.removeListener(_updateRotation);
//     _controller?.dispose();

//     _secondController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) return const SizedBox.shrink();

//     return Stack(
//       alignment: .center,
//       children: [
//         if (widget.config.groundType == .both || widget.config.groundType == .back) _buildPainter(isForeground: false),
//         widget.child,
//         if (widget.config.groundType == .both || widget.config.groundType == .fore)
//           IgnorePointer(child: _buildPainter(isForeground: true)),
//       ],
//     );
//   }

//   Widget _buildPainter({required bool isForeground}) {
//     return RepaintBoundary(
//       child: AnimatedBuilder(
//         animation: Listenable.merge([_controller, _secondController]),
//         builder: (context, _) {
//           return Opacity(
//             opacity: _fadeAnimation.value,
//             child: CustomPaint(
//               size: Size(widget.config.size, widget.config.size),
//               painter: _ParticlePainter(
//                 particles: _particles,
//                 rotation: _rotation,
//                 explosionForce: _explosionAnimation.value,
//                 scaleSize: widget.config.particleScaleSize,
//                 drawForeground: isForeground,
//                 shouldRepaintValue: true,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class ParticleSphereAsImage extends StatefulWidget {
//   const ParticleSphereAsImage({super.key, required this.config, this.child = const SizedBox.shrink()});

//   final ParticleSphereConfig config;
//   final Widget child;

//   @override
//   State<ParticleSphereAsImage> createState() => _ParticleSphereAsImageState();
// }

// class _ParticleSphereAsImageState extends State<ParticleSphereAsImage> with TickerProviderStateMixin {
//   final List<_Particle> _particles = [];
//   final v_math.Matrix4 _rotation = v_math.Matrix4.identity();

//   double _rotateX = .003;
//   double _rotateY = .003;
//   double _targetRotateX = .003;
//   double _targetRotateY = .003;

//   static const String _packageName = 'iv_project_invitation_theme';
//   final _loadedImages = <String, ui.Image>{};

//   void _updateRotation() {
//     _rotateX = _rotateX + (_targetRotateX - _rotateX) * .01;
//     _rotateY = _rotateY + (_targetRotateY - _rotateY) * .01;

//     _rotation.rotateY(_rotateY);
//     _rotation.rotateX(_rotateX);

//     final rand = math.Random();
//     if (rand.nextInt(100) == 1) {
//       _targetRotateX = (rand.nextDouble() - .5) * .015;
//       _targetRotateY = (rand.nextDouble() - .5) * .015;
//     }
//   }

//   Future<ui.Image> _loadAssetImage(String path) async {
//     final data = await rootBundle.load('packages/$_packageName/$path');
//     final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
//     final frame = await codec.getNextFrame();
//     return frame.image;
//   }

//   void _generateParticles() {
//     final rand = math.Random();
//     const goldenRatio = 1.61803398875;
//     double radius = widget.config.size / 3;

//     for (int i = 0; i < widget.config.particleCount; i++) {
//       double y = 1 - (i / (widget.config.particleCount - 1)) * 2;
//       double radiusAtY = math.sqrt(1 - y * y);
//       double theta = 2 * math.pi * goldenRatio * i;

//       v_math.Vector3 pos = v_math.Vector3(math.cos(theta) * radiusAtY, y, math.sin(theta) * radiusAtY) * radius;

//       final variation = widget.config.particleVariatios[rand.nextInt(widget.config.particleVariatios.length)];

//       _particles.add(
//         _Particle(
//           basePosition: pos,
//           type: variation.type,
//           color: variation.type == ParticleType.circle ? variation.color : Colors.white,
//           image: variation.type == ParticleType.image ? _loadedImages[variation.imagePath] : null,
//           isFlickering: rand.nextDouble() < .4,
//         ),
//       );
//     }
//   }

//   Future<void> _init() async {
//     for (var variation in widget.config.particleVariatios) {
//       if (variation.type == ParticleType.image && !_loadedImages.containsKey(variation.imagePath)) {
//         final img = await _loadAssetImage(variation.imagePath);
//         _loadedImages[variation.imagePath] = img;
//       }
//     }

//     _generateParticles();

//     _updateRotation();
//   }

//   @override
//   void initState() {
//     super.initState();

//     _init();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: .center,
//       children: [
//         if (widget.config.groundType == .both || widget.config.groundType == .back) _buildPainter(isForeground: false),
//         widget.child,
//         if (widget.config.groundType == .both || widget.config.groundType == .fore)
//           IgnorePointer(child: _buildPainter(isForeground: true)),
//       ],
//     );
//   }

//   Widget _buildPainter({required bool isForeground}) {
//     return CustomPaint(
//       size: Size(widget.config.size, widget.config.size),
//       painter: _ParticlePainter(
//         particles: _particles,
//         rotation: _rotation,
//         explosionForce: 2,
//         scaleSize: widget.config.particleScaleSize,
//         drawForeground: isForeground,
//         shouldRepaintValue: false,
//       ),
//     );
//   }
// }

// class _ParticlePainter extends CustomPainter {
//   const _ParticlePainter({
//     required this.particles,
//     required this.rotation,
//     required this.explosionForce,
//     required this.scaleSize,
//     required this.drawForeground,
//     required this.shouldRepaintValue,
//   });

//   final List<_Particle> particles;
//   final v_math.Matrix4 rotation;
//   final double explosionForce;
//   final double scaleSize;
//   final bool drawForeground;
//   final bool shouldRepaintValue;

//   @override
//   void paint(Canvas canvas, Size size) {
//     final drawList = <_DrawData>[];

//     final center = Offset(size.width / 2, size.height / 2);
//     const viewDistance = 600;

//     drawList.clear();

//     for (var p in particles) {
//       p.rotationAngle += p.rotationSpeed;

//       v_math.Vector3 pos = rotation.transformed3(p.basePosition);

//       if (explosionForce > .01) {
//         v_math.Vector3 dir = pos.normalized();
//         pos += dir * (explosionForce * 50 * p.velocityMultiplier);
//       }

//       if (drawForeground ? pos.z >= 0 : pos.z < 0) continue;

//       final scale = viewDistance / (viewDistance + pos.z);

//       double flicker = 1;
//       if (p.type == ParticleType.circle && p.isFlickering) flicker = math.Random().nextDouble() > .5 ? 1 : .3;

//       final data = _DrawData()
//         ..offset = Offset(pos.x * scale + center.dx, pos.y * scale + center.dy)
//         ..z = pos.z
//         ..scale = scale
//         ..color = p.color.withValues(alpha: (scale * .8 * flicker).clamp(.1, 1))
//         ..type = p.type
//         ..image = p.image
//         ..rotation = p.rotationAngle;

//       drawList.add(data);
//     }

//     drawList.sort((a, b) => b.z.compareTo(a.z));

//     final paint = Paint();
//     for (var item in drawList) {
//       paint.color = item.color;

//       if (item.type == ParticleType.circle) {
//         canvas.drawCircle(item.offset, scaleSize * item.scale, paint);
//       } else if (item.type == ParticleType.image && item.image != null) {
//         final imgSize = (16 + (scaleSize * 1.4)) * item.scale;

//         canvas.save();

//         canvas.translate(item.offset.dx, item.offset.dy);

//         canvas.rotate(item.rotation);

//         final rect = Rect.fromLTWH(-imgSize / 2, -imgSize / 2, imgSize, imgSize);

//         canvas.drawImageRect(
//           item.image!,
//           Rect.fromLTWH(0, 0, item.image!.width.toDouble(), item.image!.height.toDouble()),
//           rect,
//           paint,
//         );

//         canvas.restore();
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant _ParticlePainter oldDelegate) => shouldRepaintValue;
// }

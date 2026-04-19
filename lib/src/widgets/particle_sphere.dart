import 'dart:async';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:vector_math/vector_math_64.dart' as v_math;

enum GroundType { fore, back, both }

enum ParticleType { circle, image }

class ParticleSphereConfig {
  ParticleSphereConfig.circle({
    this.size = 200,
    this.particleCount = 30,
    this.particleScaleSize = 6,
    required this.circleParticleVariatios,
    this.groundType = .both,
  }) : type = ParticleType.circle,
       imageParticleVariatios = const [];

  ParticleSphereConfig.image({
    this.size = 200,
    this.particleCount = 30,
    this.particleScaleSize = 6,
    required this.imageParticleVariatios,
    this.groundType = .both,
  }) : type = ParticleType.circle,
       circleParticleVariatios = const [];

  final ParticleType type;
  final double size;
  final int particleCount;
  final double particleScaleSize;
  final List<CircleParticle> circleParticleVariatios;
  final List<ImageParticle> imageParticleVariatios;
  final GroundType groundType;
}

class _CircleParticle {
  _CircleParticle({required this.basePosition, this.color = Colors.white, this.isFlickering = false})
    : velocityMultiplier = math.Random().nextDouble() * 2.5 + .5;

  final v_math.Vector3 basePosition;
  final double velocityMultiplier;
  final Color color;
  final bool isFlickering;
}

class CircleParticle {
  const CircleParticle({required this.color});

  final Color color;
}

class CircleParticleSphere extends StatefulWidget {
  const CircleParticleSphere({
    super.key,
    required this.config,
    this.initialPage = 0,
    this.viewAsSinglePage = false,
    this.useWrapper = true,
    this.child = const SizedBox.shrink(),
  });

  final ParticleSphereConfig config;
  final int initialPage;
  final bool viewAsSinglePage;
  final bool useWrapper;
  final Widget child;

  @override
  State<CircleParticleSphere> createState() => _CircleParticleSphereState();
}

class _CircleParticleSphereState extends State<CircleParticleSphere> with TickerProviderStateMixin {
  StreamSubscription? _sub;

  AnimationController? _controller;
  final List<_CircleParticle> _particles = [];
  final v_math.Matrix4 _rotation = v_math.Matrix4.identity();

  late final AnimationController _secondController;
  late final Animation<double> _explosionAnimation;
  late final Animation<double> _fadeAnimation;

  double _rotateX = .003;
  double _rotateY = .003;
  double _targetRotateX = .003;
  double _targetRotateY = .003;

  bool _isLoading = true;

  void _updateRotation() {
    _rotateX = _rotateX + (_targetRotateX - _rotateX) * .01;
    _rotateY = _rotateY + (_targetRotateY - _rotateY) * .01;

    _rotation.rotateY(_rotateY);
    _rotation.rotateX(_rotateX);

    final rand = math.Random();
    if (rand.nextInt(100) == 1) {
      _targetRotateX = (rand.nextDouble() - .5) * .015;
      _targetRotateY = (rand.nextDouble() - .5) * .015;
    }
  }

  void _generateParticles() {
    final rand = math.Random();
    const goldenRatio = 1.61803398875;
    double radius = widget.config.size / 3;

    for (int i = 0; i < widget.config.particleCount; i++) {
      double y = 1 - (i / (widget.config.particleCount - 1)) * 2;
      double radiusAtY = math.sqrt(1 - y * y);
      double theta = 2 * math.pi * goldenRatio * i;

      v_math.Vector3 pos = v_math.Vector3(math.cos(theta) * radiusAtY, y, math.sin(theta) * radiusAtY) * radius;

      final variation = widget.config.circleParticleVariatios[rand.nextInt(widget.config.circleParticleVariatios.length)];

      _particles.add(_CircleParticle(basePosition: pos, color: variation.color, isFlickering: rand.nextDouble() < .4));
    }
  }

  void _init() async {
    if (AppParticles.circle == null) await AppParticles.initCreateCircle();

    _generateParticles();

    if (mounted) setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();

    _init();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..addListener(_updateRotation)
      ..repeat();

    _secondController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    _explosionAnimation = Tween<double>(begin: .0, end: 2).animate(
      CurvedAnimation(
        parent: _secondController,
        curve: const Interval(.1, 1, curve: Curves.easeOutCubic),
      ),
    );

    _fadeAnimation = Tween<double>(begin: .0, end: 1).animate(
      CurvedAnimation(
        parent: _secondController,
        curve: const Interval(.0, .3, curve: Curves.easeIn),
      ),
    );

    _sub = context.read<InvitationThemeCoreCubit>().stream.listen((state) {
      if (widget.viewAsSinglePage) {
        final explose = widget.initialPage == 0 && !widget.useWrapper;
        if (explose) {
          _secondController.forward();
        } else {
          if (widget.initialPage != 0) _secondController.value = 1;
        }
      } else {
        if (state.animationTrigger == 1) {
          _secondController.forward();
          _sub?.cancel();
        }
      }
    });
  }

  @override
  void dispose() {
    _sub?.cancel();

    _controller?.removeListener(_updateRotation);
    _controller?.dispose();

    _secondController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || AppParticles.circle == null) return const SizedBox.shrink();

    return Stack(
      alignment: .center,
      children: [
        if (widget.config.groundType == .both || widget.config.groundType == .back) _buildPainter(isForeground: false),
        widget.child,
        if (widget.config.groundType == .both || widget.config.groundType == .fore)
          IgnorePointer(child: _buildPainter(isForeground: true)),
      ],
    );
  }

  Widget _buildPainter({required bool isForeground}) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: Listenable.merge([_controller, _secondController]),
        builder: (context, _) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: CustomPaint(
              size: Size(widget.config.size, widget.config.size),
              painter: _CircleParticlePainter(
                particles: _particles,
                rotation: _rotation,
                explosionForce: _explosionAnimation.value,
                scaleSize: widget.config.particleScaleSize,
                drawForeground: isForeground,
                shouldRepaintValue: true,
              ),
            ),
          );
        },
      ),
    );
  }
}

class CircleParticleSphereAsImage extends StatefulWidget {
  const CircleParticleSphereAsImage({super.key, required this.config, this.child = const SizedBox.shrink()});

  final ParticleSphereConfig config;
  final Widget child;

  @override
  State<CircleParticleSphereAsImage> createState() => _CircleParticleSphereAsImageState();
}

class _CircleParticleSphereAsImageState extends State<CircleParticleSphereAsImage> {
  final List<_CircleParticle> _particles = [];
  final v_math.Matrix4 _rotation = v_math.Matrix4.identity();

  double _rotateX = .003;
  double _rotateY = .003;
  double _targetRotateX = .003;
  double _targetRotateY = .003;

  bool _isLoading = true;

  void _updateRotation() {
    _rotateX = _rotateX + (_targetRotateX - _rotateX) * .01;
    _rotateY = _rotateY + (_targetRotateY - _rotateY) * .01;

    _rotation.rotateY(_rotateY);
    _rotation.rotateX(_rotateX);

    final rand = math.Random();
    if (rand.nextInt(100) == 1) {
      _targetRotateX = (rand.nextDouble() - .5) * .015;
      _targetRotateY = (rand.nextDouble() - .5) * .015;
    }
  }

  void _generateParticles() {
    final rand = math.Random();
    const goldenRatio = 1.61803398875;
    double radius = widget.config.size / 3;

    for (int i = 0; i < widget.config.particleCount; i++) {
      double y = 1 - (i / (widget.config.particleCount - 1)) * 2;
      double radiusAtY = math.sqrt(1 - y * y);
      double theta = 2 * math.pi * goldenRatio * i;

      v_math.Vector3 pos = v_math.Vector3(math.cos(theta) * radiusAtY, y, math.sin(theta) * radiusAtY) * radius;

      final variation = widget.config.circleParticleVariatios[rand.nextInt(widget.config.circleParticleVariatios.length)];

      _particles.add(_CircleParticle(basePosition: pos, color: variation.color, isFlickering: false));
    }
  }

  void _init() async {
    if (AppParticles.circle == null) await AppParticles.initCreateCircle();

    _generateParticles();
    _updateRotation();

    if (mounted) setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || AppParticles.circle == null) return const SizedBox.shrink();

    return Stack(
      alignment: .center,
      children: [
        if (widget.config.groundType == .both || widget.config.groundType == .back) _buildPainter(isForeground: false),
        widget.child,
        if (widget.config.groundType == .both || widget.config.groundType == .fore)
          IgnorePointer(child: _buildPainter(isForeground: true)),
      ],
    );
  }

  Widget _buildPainter({required bool isForeground}) {
    return CustomPaint(
      size: Size(widget.config.size, widget.config.size),
      painter: _CircleParticlePainter(
        particles: _particles,
        rotation: _rotation,
        explosionForce: 2,
        scaleSize: widget.config.particleScaleSize,
        drawForeground: isForeground,
        shouldRepaintValue: false,
      ),
    );
  }
}

class _CircleParticlePainter extends CustomPainter {
  _CircleParticlePainter({
    required this.particles,
    required this.rotation,
    required this.explosionForce,
    required this.scaleSize,
    required this.drawForeground,
    required this.shouldRepaintValue,
  }) : _paint = Paint()..filterQuality = ui.FilterQuality.none;

  final List<_CircleParticle> particles;
  final v_math.Matrix4 rotation;
  final double explosionForce;
  final double scaleSize;
  final bool drawForeground;
  final bool shouldRepaintValue;
  final Paint _paint;

  static final List<RSTransform> _transforms = [];
  static final List<Rect> _rects = [];
  static final List<Color> _colors = [];

  @override
  void paint(Canvas canvas, Size size) {
    if (particles.isEmpty) return;

    _transforms.clear();
    _rects.clear();
    _colors.clear();

    final center = Offset(size.width / 2, size.height / 2);
    const viewDistance = 600.0;
    const rectCircle = Rect.fromLTWH(0, 0, 50, 50);
    final random = math.Random();

    for (int i = 0; i < particles.length; i++) {
      final p = particles[i];

      final v_math.Vector3 pos = rotation.transformed3(p.basePosition);

      if (explosionForce > .01) {
        final double len = pos.length;
        if (len > 0) {
          final double factor = (explosionForce * 50 * p.velocityMultiplier) / len;
          pos.x += pos.x * factor;
          pos.y += pos.y * factor;
          pos.z += pos.z * factor;
        }
      }

      if (drawForeground ? pos.z >= 0 : pos.z < 0) continue;

      final double scale = viewDistance / (viewDistance + pos.z);

      double flicker = 1.0;
      if (p.isFlickering) {
        flicker = random.nextDouble() > 0.5 ? 1.0 : 0.3;
      }

      _rects.add(rectCircle);
      _transforms.add(
        RSTransform.fromComponents(
          rotation: 0,
          scale: (scaleSize * scale) / 25,
          anchorX: 25,
          anchorY: 25,
          translateX: pos.x * scale + center.dx,
          translateY: pos.y * scale + center.dy,
        ),
      );

      _colors.add(p.color.withValues(alpha: (scale * .8 * flicker).clamp(0.1, 1.0)));
    }

    if (_transforms.isNotEmpty) {
      canvas.drawAtlas(AppParticles.circle!, _transforms, _rects, _colors, ui.BlendMode.modulate, null, _paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CircleParticlePainter oldDelegate) => shouldRepaintValue;
}

class _ImageParticle {
  _ImageParticle({required this.basePosition, this.atlasIndex = 0})
    : velocityMultiplier = math.Random().nextDouble() * 2.5 + .5,
      rotationSpeed = (math.Random().nextDouble() - 0.5) * 0.05,
      rotationAngle = math.Random().nextDouble() * math.pi * 2;

  final v_math.Vector3 basePosition;
  final double velocityMultiplier;
  final int atlasIndex;
  final double rotationSpeed;
  double rotationAngle;
}

class ImageParticle {
  const ImageParticle({required this.imagePath});

  final String imagePath;
}

class ImageParticleSphere extends StatefulWidget {
  const ImageParticleSphere({
    super.key,
    required this.config,
    this.initialPage = 0,
    this.viewAsSinglePage = false,
    this.useWrapper = true,
    this.child = const SizedBox.shrink(),
  });

  final ParticleSphereConfig config;
  final int initialPage;
  final bool viewAsSinglePage;
  final bool useWrapper;
  final Widget child;

  @override
  State<ImageParticleSphere> createState() => _ImageParticleSphereState();
}

class _ImageParticleSphereState extends State<ImageParticleSphere> with TickerProviderStateMixin {
  StreamSubscription? _sub;

  AnimationController? _controller;
  final List<_ImageParticle> _particles = [];
  final v_math.Matrix4 _rotation = v_math.Matrix4.identity();

  late final AnimationController _secondController;
  late final Animation<double> _explosionAnimation;
  late final Animation<double> _fadeAnimation;

  double _rotateX = .003;
  double _rotateY = .003;
  double _targetRotateX = .003;
  double _targetRotateY = .003;

  bool _isLoading = true;

  late final String particleImagesId;

  void _updateRotation() {
    _rotateX = _rotateX + (_targetRotateX - _rotateX) * .01;
    _rotateY = _rotateY + (_targetRotateY - _rotateY) * .01;

    _rotation.rotateY(_rotateY);
    _rotation.rotateX(_rotateX);

    final rand = math.Random();
    if (rand.nextInt(100) == 1) {
      _targetRotateX = (rand.nextDouble() - .5) * .015;
      _targetRotateY = (rand.nextDouble() - .5) * .015;
    }
  }

  void _generateParticles(int imageCount) {
    final rand = math.Random();
    const goldenRatio = 1.61803398875;
    double radius = widget.config.size / 3;

    for (int i = 0; i < widget.config.particleCount; i++) {
      double y = 1 - (i / (widget.config.particleCount - 1)) * 2;
      double radiusAtY = math.sqrt(1 - y * y);
      double theta = 2 * math.pi * goldenRatio * i;

      v_math.Vector3 pos = v_math.Vector3(math.cos(theta) * radiusAtY, y, math.sin(theta) * radiusAtY) * radius;

      _particles.add(_ImageParticle(basePosition: pos, atlasIndex: rand.nextInt(imageCount)));
    }
  }

  Future<ui.Image> _loadUiImage(String path) async {
    final completer = Completer<ui.Image>();
    final config = createLocalImageConfiguration(context);
    final asset = AssetImage(path);
    final stream = asset.resolve(config);
    stream.addListener(ImageStreamListener((info, _) => completer.complete(info.image)));
    return completer.future;
  }

  void _init() async {
    final particleFileNames = <String>[];
    final loadedImages = <ui.Image>[];
    for (final variation in widget.config.imageParticleVariatios) {
      particleFileNames.add(variation.imagePath.split('/').last);
      final img = await _loadUiImage(variation.imagePath);
      loadedImages.add(img);
    }

    particleImagesId = particleFileNames.join('_');
    if (AppParticles.images[particleImagesId] == null) await AppParticles.initCreateImages(loadedImages, particleImagesId);

    _generateParticles(loadedImages.length);

    if (mounted) setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();

    _init();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..addListener(_updateRotation)
      ..repeat();

    _secondController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    _explosionAnimation = Tween<double>(begin: .0, end: 2).animate(
      CurvedAnimation(
        parent: _secondController,
        curve: const Interval(.1, 1, curve: Curves.easeOutCubic),
      ),
    );

    _fadeAnimation = Tween<double>(begin: .0, end: 1).animate(
      CurvedAnimation(
        parent: _secondController,
        curve: const Interval(.0, .3, curve: Curves.easeIn),
      ),
    );

    _sub = context.read<InvitationThemeCoreCubit>().stream.listen((state) {
      if (widget.viewAsSinglePage) {
        final explose = widget.initialPage == 0 && !widget.useWrapper;
        if (explose) {
          _secondController.forward();
        } else {
          if (widget.initialPage != 0) _secondController.value = 1;
        }
      } else {
        if (state.animationTrigger == 1) {
          _secondController.forward();
          _sub?.cancel();
        }
      }
    });
  }

  @override
  void dispose() {
    _sub?.cancel();

    _controller?.removeListener(_updateRotation);
    _controller?.dispose();

    _secondController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || AppParticles.images[particleImagesId] == null) return const SizedBox.shrink();

    return Stack(
      alignment: .center,
      children: [
        if (widget.config.groundType == .both || widget.config.groundType == .back) _buildPainter(isForeground: false),
        widget.child,
        if (widget.config.groundType == .both || widget.config.groundType == .fore)
          IgnorePointer(child: _buildPainter(isForeground: true)),
      ],
    );
  }

  Widget _buildPainter({required bool isForeground}) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: Listenable.merge([_controller, _secondController]),
        builder: (context, _) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: CustomPaint(
              size: Size(widget.config.size, widget.config.size),
              painter: _ImageParticlePainter(
                particles: _particles,
                rotation: _rotation,
                explosionForce: _explosionAnimation.value,
                scaleSize: widget.config.particleScaleSize,
                drawForeground: isForeground,
                shouldRepaintValue: true,
                particleImage: AppParticles.images[particleImagesId]!,
                imageCount: widget.config.imageParticleVariatios.length,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ImageParticleSphereAsImage extends StatefulWidget {
  const ImageParticleSphereAsImage({super.key, required this.config, this.child = const SizedBox.shrink()});

  final ParticleSphereConfig config;
  final Widget child;

  @override
  State<ImageParticleSphereAsImage> createState() => _ImageParticleSphereAsImageState();
}

class _ImageParticleSphereAsImageState extends State<ImageParticleSphereAsImage> {
  final List<_ImageParticle> _particles = [];
  final v_math.Matrix4 _rotation = v_math.Matrix4.identity();

  double _rotateX = .003;
  double _rotateY = .003;
  double _targetRotateX = .003;
  double _targetRotateY = .003;

  bool _isLoading = true;

  late final String particleImagesId;

  void _updateRotation() {
    _rotateX = _rotateX + (_targetRotateX - _rotateX) * .01;
    _rotateY = _rotateY + (_targetRotateY - _rotateY) * .01;

    _rotation.rotateY(_rotateY);
    _rotation.rotateX(_rotateX);

    final rand = math.Random();
    if (rand.nextInt(100) == 1) {
      _targetRotateX = (rand.nextDouble() - .5) * .015;
      _targetRotateY = (rand.nextDouble() - .5) * .015;
    }
  }

  void _generateParticles(int imageCount) {
    final rand = math.Random();
    const goldenRatio = 1.61803398875;
    double radius = widget.config.size / 3;

    for (int i = 0; i < widget.config.particleCount; i++) {
      double y = 1 - (i / (widget.config.particleCount - 1)) * 2;
      double radiusAtY = math.sqrt(1 - y * y);
      double theta = 2 * math.pi * goldenRatio * i;

      v_math.Vector3 pos = v_math.Vector3(math.cos(theta) * radiusAtY, y, math.sin(theta) * radiusAtY) * radius;

      _particles.add(_ImageParticle(basePosition: pos, atlasIndex: rand.nextInt(imageCount)));
    }
  }

  Future<ui.Image> _loadUiImage(String path) async {
    final completer = Completer<ui.Image>();
    final config = createLocalImageConfiguration(context);
    final asset = AssetImage(path);
    final stream = asset.resolve(config);
    stream.addListener(ImageStreamListener((info, _) => completer.complete(info.image)));
    return completer.future;
  }

  void _init() async {
    final particleFileNames = <String>[];
    final loadedImages = <ui.Image>[];
    for (final variation in widget.config.imageParticleVariatios) {
      particleFileNames.add(variation.imagePath.split('/').last);
      final img = await _loadUiImage(variation.imagePath);
      loadedImages.add(img);
    }

    particleImagesId = particleFileNames.join('_');
    if (AppParticles.images[particleImagesId] == null) await AppParticles.initCreateImages(loadedImages, particleImagesId);

    _generateParticles(loadedImages.length);
    _updateRotation();

    if (mounted) setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || AppParticles.images[particleImagesId] == null) return const SizedBox.shrink();

    return Stack(
      alignment: .center,
      children: [
        if (widget.config.groundType == .both || widget.config.groundType == .back) _buildPainter(isForeground: false),
        widget.child,
        if (widget.config.groundType == .both || widget.config.groundType == .fore)
          IgnorePointer(child: _buildPainter(isForeground: true)),
      ],
    );
  }

  Widget _buildPainter({required bool isForeground}) {
    return CustomPaint(
      size: Size(widget.config.size, widget.config.size),
      painter: _ImageParticlePainter(
        particles: _particles,
        rotation: _rotation,
        explosionForce: 2,
        scaleSize: widget.config.particleScaleSize,
        drawForeground: isForeground,
        shouldRepaintValue: false,
        particleImage: AppParticles.images[particleImagesId]!,
        imageCount: widget.config.imageParticleVariatios.length,
      ),
    );
  }
}

class _ImageParticlePainter extends CustomPainter {
  _ImageParticlePainter({
    required this.particles,
    required this.rotation,
    required this.explosionForce,
    required this.scaleSize,
    required this.drawForeground,
    required this.shouldRepaintValue,
    required this.particleImage,
    required this.imageCount,
  }) : _paint = Paint()..filterQuality = ui.FilterQuality.low;

  final List<_ImageParticle> particles;
  final v_math.Matrix4 rotation;
  final double explosionForce;
  final double scaleSize;
  final bool drawForeground;
  final bool shouldRepaintValue;
  final ui.Image particleImage;
  final int imageCount;
  final Paint _paint;

  static final List<RSTransform> _transforms = [];
  static final List<Rect> _rects = [];
  static final List<Color> _colors = [];

  @override
  void paint(Canvas canvas, Size size) {
    _transforms.clear();
    _rects.clear();
    _colors.clear();

    final center = Offset(size.width / 2, size.height / 2);
    const double viewDistance = 600.0;
    final double sourceSize = particleImage.width / imageCount;

    for (int i = 0; i < particles.length; i++) {
      final p = particles[i];
      final v_math.Vector3 pos = rotation.transformed3(p.basePosition);

      if (drawForeground ? pos.z >= 0 : pos.z < 0) continue;

      final double scale = viewDistance / (viewDistance + pos.z);
      final double x = pos.x * scale + center.dx;
      final double y = pos.y * scale + center.dy;

      _rects.add(Rect.fromLTWH(p.atlasIndex * sourceSize, 0, sourceSize, sourceSize));

      _transforms.add(
        RSTransform.fromComponents(
          rotation: p.rotationAngle,
          scale: (scaleSize * scale) / (sourceSize / 2),
          anchorX: sourceSize / 2,
          anchorY: sourceSize / 2,
          translateX: x,
          translateY: y,
        ),
      );

      _colors.add(Colors.white.withValues(alpha: (scale * 0.9).clamp(0.1, 1.0)));
    }

    if (_transforms.isNotEmpty) {
      canvas.drawAtlas(particleImage, _transforms, _rects, _colors, ui.BlendMode.modulate, null, _paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => shouldRepaintValue;
}

import 'dart:async';
import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:vector_math/vector_math_64.dart' as v_math;

enum GroundType() {
  fore,
  back,
  both,
}

enum ParticleType() {
  circle,
  image,
}

class ParticleSphereConfig {
  new circle({
    this.size = 200,
    this.particleCount = 30,
    this.particleScaleSize = 6,
    required this.circleParticleVariations,
    this.groundType = .both,
  }) : type = .circle,
       imageParticleVariations = const [];

  new image({
    this.size = 200,
    this.particleCount = 30,
    this.particleScaleSize = 6,
    required this.imageParticleVariations,
    this.groundType = .both,
  }) : type = .image,
       circleParticleVariations = const [];

  final ParticleType type;
  final double size;
  final int particleCount;
  final double particleScaleSize;
  final List<CircleParticle> circleParticleVariations;
  final List<ImageParticle> imageParticleVariations;
  final GroundType groundType;
}

class _CircleParticle({
  required final v_math.Vector3 basePosition,
  final Color color = Colors.white,
  final bool isFlickering = false,
}) {
  this : velocityMultiplier = math.Random().nextDouble() * 2.5 + .5;

  final double velocityMultiplier;
}

class const CircleParticle({required final Color color});

class const CircleParticleSphere({
  super.key,
  required final ParticleSphereConfig config,
  final int initialPage = 0,
  final bool viewAsSinglePage = false,
  final bool useWrapper = true,
  final Widget child = const SizedBox.shrink(),
}) extends StatefulWidget {
  @override
  State<CircleParticleSphere> createState() => _CircleParticleSphereState();
}

class _CircleParticleSphereState()
    extends State<CircleParticleSphere>
    with TickerProviderStateMixin {
  StreamSubscription? _sub;

  AnimationController? _controller;
  final List<_CircleParticle> _particles = [];
  final v_math.Matrix4 _rotation = .identity();

  late final AnimationController _secondController;
  late final Animation<double> _explosionAnimation;
  late final Animation<double> _fadeAnimation;

  double _rotateX = .003;
  double _rotateY = .003;
  double _targetRotateX = .003;
  double _targetRotateY = .003;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _init();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..addListener(_updateRotation)
      ..repeat();

    _secondController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

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

  void _init() async {
    if (AppParticles.circle == null) await AppParticles.initCreateCircle();

    _generateParticles();

    if (mounted) setState(() => _isLoading = false);
  }

  void _generateParticles() {
    final rand = math.Random();
    const goldenRatio = 1.61803398875;
    final radius = widget.config.size / 3;

    for (int i = 0; i < widget.config.particleCount; i++) {
      final y = 1 - (i / (widget.config.particleCount - 1)) * 2;
      final radiusAtY = math.sqrt(1 - y * y);
      final theta = 2 * math.pi * goldenRatio * i;

      final pos =
          v_math.Vector3(math.cos(theta) * radiusAtY, y, math.sin(theta) * radiusAtY) * radius;

      final variation = widget
          .config
          .circleParticleVariations[rand.nextInt(widget.config.circleParticleVariations.length)];

      _particles.add(
        .new(basePosition: pos, color: variation.color, isFlickering: rand.nextDouble() < .4),
      );
    }
  }

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

  @override
  Widget build(BuildContext context) {
    if (_isLoading || AppParticles.circle == null) return const SizedBox.shrink();

    return Stack(
      alignment: .center,
      children: [
        if (widget.config.groundType == .both || widget.config.groundType == .back)
          _buildPainter(isForeground: false),
        widget.child,
        if (widget.config.groundType == .both || widget.config.groundType == .fore)
          IgnorePointer(child: _buildPainter(isForeground: true)),
      ],
    );
  }

  Widget _buildPainter({required bool isForeground}) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: .merge([_controller, _secondController]),
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

class _CircleParticlePainter({
  required final List<_CircleParticle> particles,
  required final v_math.Matrix4 rotation,
  required final double explosionForce,
  required final double scaleSize,
  required final bool drawForeground,
  required final bool shouldRepaintValue,
}) extends CustomPainter {
  this : _paint = Paint()..filterQuality = .none;

  final Paint _paint;

  static final List<RSTransform> _transforms = [];
  static final List<Rect> _rects = [];
  static final List<Color> _colors = [];

  final math.Random _random = math.Random();

  final v_math.Vector3 _calcPos = .zero();

  @override
  void paint(Canvas canvas, Size size) {
    if (particles.isEmpty) return;

    _transforms.clear();
    _rects.clear();
    _colors.clear();

    final center = Offset(size.width / 2, size.height / 2);
    const viewDistance = 600;
    const rectCircle = Rect.fromLTWH(0, 0, 50, 50);

    for (int i = 0; i < particles.length; i++) {
      final p = particles[i];

      _calcPos.setFrom(p.basePosition);
      rotation.transform3(_calcPos);

      if (explosionForce > .01) {
        final len = _calcPos.length;
        if (len > 0) {
          final factor = (explosionForce * 50 * p.velocityMultiplier) / len;
          _calcPos.x += _calcPos.x * factor;
          _calcPos.y += _calcPos.y * factor;
          _calcPos.z += _calcPos.z * factor;
        }
      }

      if (drawForeground ? _calcPos.z >= 0 : _calcPos.z < 0) continue;

      final scale = viewDistance / (viewDistance + _calcPos.z);

      double flicker = 1;
      if (p.isFlickering) {
        flicker = _random.nextDouble() > .5 ? 1 : .3;
      }

      _rects.add(rectCircle);
      _transforms.add(
        .fromComponents(
          rotation: 0,
          scale: (scaleSize * scale) / 25,
          anchorX: 25,
          anchorY: 25,
          translateX: _calcPos.x * scale + center.dx,
          translateY: _calcPos.y * scale + center.dy,
        ),
      );

      _colors.add(p.color.withValues(alpha: (scale * .8 * flicker).clamp(.1, 1)));
    }

    if (_transforms.isNotEmpty) {
      canvas.drawAtlas(AppParticles.circle!, _transforms, _rects, _colors, .modulate, null, _paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CircleParticlePainter oldDelegate) => shouldRepaintValue;
}

class _ImageParticle({required final v_math.Vector3 basePosition, final int atlasIndex = 0}) {
  this
    : velocityMultiplier = math.Random().nextDouble() * 2.5 + .5,
      rotationSpeed = (math.Random().nextDouble() - 0.5) * 0.05,
      rotationAngle = math.Random().nextDouble() * math.pi * 2;

  final double velocityMultiplier;
  final double rotationSpeed;
  double rotationAngle;
}

class const ImageParticle({required final String imagePath});

class const ImageParticleSphere({
  super.key,
  required final ParticleSphereConfig config,
  final int initialPage = 0,
  final bool viewAsSinglePage = false,
  final bool useWrapper = true,
  final Widget child = const SizedBox.shrink(),
}) extends StatefulWidget {
  @override
  State<ImageParticleSphere> createState() => _ImageParticleSphereState();
}

class _ImageParticleSphereState() extends State<ImageParticleSphere> with TickerProviderStateMixin {
  StreamSubscription? _sub;

  AnimationController? _controller;
  final List<_ImageParticle> _particles = [];
  final v_math.Matrix4 _rotation = .identity();

  late final AnimationController _secondController;
  late final Animation<double> _explosionAnimation;
  late final Animation<double> _fadeAnimation;

  double _rotateX = .003;
  double _rotateY = .003;
  double _targetRotateX = .003;
  double _targetRotateY = .003;

  bool _isLoading = true;
  bool _hasInitialized = false;

  late final String particleImagesId;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..addListener(_updateRotation)
      ..repeat();

    _secondController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

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
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_hasInitialized) {
      _init();
      _hasInitialized = true;
    }
  }

  @override
  void dispose() {
    _sub?.cancel();

    _controller?.removeListener(_updateRotation);
    _controller?.dispose();

    _secondController.dispose();

    super.dispose();
  }

  void _init() async {
    final particleFileNames = <String>[];
    final loadedImages = <ui.Image>[];
    for (final variation in widget.config.imageParticleVariations) {
      particleFileNames.add(variation.imagePath.split('/').last);
      final img = await _loadUiImage(variation.imagePath);
      loadedImages.add(img);
    }

    particleImagesId = particleFileNames.join('_');
    if (AppParticles.images[particleImagesId] == null) {
      await AppParticles.initCreateImages(loadedImages, particleImagesId);
    }

    _generateParticles(loadedImages.length);

    if (mounted) setState(() => _isLoading = false);
  }

  Future<ui.Image> _loadUiImage(String path) async {
    final completer = Completer<ui.Image>();
    final config = createLocalImageConfiguration(context);
    final asset = AssetImage(path, package: 'iv_project_invitation_theme');
    final stream = asset.resolve(config);
    stream.addListener(.new((info, _) => completer.complete(info.image)));
    return completer.future;
  }

  void _generateParticles(int imageCount) {
    final rand = math.Random();
    const goldenRatio = 1.61803398875;
    final radius = widget.config.size / 3;

    for (int i = 0; i < widget.config.particleCount; i++) {
      final y = 1 - (i / (widget.config.particleCount - 1)) * 2;
      final radiusAtY = math.sqrt(1 - y * y);
      final theta = 2 * math.pi * goldenRatio * i;

      final pos =
          v_math.Vector3(math.cos(theta) * radiusAtY, y, math.sin(theta) * radiusAtY) * radius;

      _particles.add(.new(basePosition: pos, atlasIndex: rand.nextInt(imageCount)));
    }
  }

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

  @override
  Widget build(BuildContext context) {
    if (_isLoading || AppParticles.images[particleImagesId] == null) return const SizedBox.shrink();

    return Stack(
      alignment: .center,
      children: [
        if (widget.config.groundType == .both || widget.config.groundType == .back)
          _buildPainter(isForeground: false),
        widget.child,
        if (widget.config.groundType == .both || widget.config.groundType == .fore)
          IgnorePointer(child: _buildPainter(isForeground: true)),
      ],
    );
  }

  Widget _buildPainter({required bool isForeground}) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: .merge([_controller, _secondController]),
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
                imageCount: widget.config.imageParticleVariations.length,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ImageParticlePainter({
  required final List<_ImageParticle> particles,
  required final v_math.Matrix4 rotation,
  required final double explosionForce,
  required final double scaleSize,
  required final bool drawForeground,
  required final bool shouldRepaintValue,
  required final ui.Image particleImage,
  required final int imageCount,
}) extends CustomPainter {
  this : _paint = Paint()..filterQuality = .low;

  final Paint _paint;

  static final List<RSTransform> _transforms = [];
  static final List<Rect> _rects = [];
  static final List<Color> _colors = [];

  final v_math.Vector3 _calcPos = .zero();

  @override
  void paint(Canvas canvas, Size size) {
    if (particles.isEmpty) return;

    _transforms.clear();
    _rects.clear();
    _colors.clear();

    final center = Offset(size.width / 2, size.height / 2);
    const double viewDistance = 600;

    final sourceSize = particleImage.width / imageCount;
    final halfSourceSize = sourceSize / 2;

    for (int i = 0; i < particles.length; i++) {
      final p = particles[i];

      _calcPos.setFrom(p.basePosition);
      rotation.transform3(_calcPos);

      if (explosionForce > .01) {
        final len = _calcPos.length;
        if (len > 0) {
          final factor = (explosionForce * 50 * p.velocityMultiplier) / len;
          _calcPos.x += _calcPos.x * factor;
          _calcPos.y += _calcPos.y * factor;
          _calcPos.z += _calcPos.z * factor;
        }
      }

      if (drawForeground ? _calcPos.z >= 0 : _calcPos.z < 0) continue;

      final scale = viewDistance / (viewDistance + _calcPos.z);
      final x = _calcPos.x * scale + center.dx;
      final y = _calcPos.y * scale + center.dy;

      _rects.add(Rect.fromLTWH(p.atlasIndex * sourceSize, 0, sourceSize, sourceSize));

      final sizeMultiplier = 1.75;

      _transforms.add(
        .fromComponents(
          rotation: p.rotationAngle,
          scale: ((scaleSize * scale) / halfSourceSize) * sizeMultiplier,
          anchorX: halfSourceSize,
          anchorY: halfSourceSize,
          translateX: x,
          translateY: y,
        ),
      );

      _colors.add(Colors.white.withValues(alpha: (scale * .9).clamp(.1, 1)));
    }

    if (_transforms.isNotEmpty) {
      canvas.drawAtlas(particleImage, _transforms, _rects, _colors, .modulate, null, _paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => shouldRepaintValue;
}

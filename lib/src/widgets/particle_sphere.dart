import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as v_math;

class _DrawData {
  Offset offset = Offset.zero;
  double z = 0;
  double scale = 0;
  Color color = Colors.transparent;
}

class Particle {
  Particle({required this.basePosition, required this.color}) : velocityMultiplier = math.Random().nextDouble() * 2.5 + 0.5;

  final v_math.Vector3 basePosition;
  final double velocityMultiplier;
  final Color color;
}

class ParticleSphere extends StatefulWidget {
  const ParticleSphere({
    super.key,
    this.size = 200.0,
    this.particleCount = 30,
    required this.colors,
    this.child = const SizedBox.shrink(),
  });

  final double size;
  final int particleCount;
  final List<Color> colors;
  final Widget child;

  @override
  State<ParticleSphere> createState() => _ParticleSphereState();
}

class _ParticleSphereState extends State<ParticleSphere> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<Particle> _particles = [];
  final v_math.Matrix4 _rotation = v_math.Matrix4.identity();

  double _rotateX = 0.003;
  double _rotateY = 0.003;
  double _targetRotateX = 0.003;
  double _targetRotateY = 0.003;

  double _speedMultiplier = 1.0;

  void _generateParticles() {
    final rand = math.Random();
    const goldenRatio = 1.61803398875;
    double radius = widget.size / 3;

    for (int i = 0; i < widget.particleCount; i++) {
      double y = 1 - (i / (widget.particleCount - 1)) * 2;
      double radiusAtY = math.sqrt(1 - y * y);
      double theta = 2 * math.pi * goldenRatio * i;

      v_math.Vector3 pos = v_math.Vector3(math.cos(theta) * radiusAtY, y, math.sin(theta) * radiusAtY) * radius;

      _particles.add(Particle(basePosition: pos, color: widget.colors[rand.nextInt(widget.colors.length)]));
    }
  }

  void _updateRotation() {
    _rotateX += (_targetRotateX * _speedMultiplier - _rotateX) * 0.02;
    _rotateY += (_targetRotateY * _speedMultiplier - _rotateY) * 0.02;

    _rotation.rotateY(_rotateY);
    _rotation.rotateX(_rotateX);

    final rand = math.Random();
    if (_speedMultiplier > 0.5 && rand.nextInt(100) == 1) {
      _targetRotateX = (rand.nextDouble() - 0.5) * 0.015;
      _targetRotateY = (rand.nextDouble() - 0.5) * 0.015;
    }
  }

  @override
  void initState() {
    super.initState();

    _generateParticles();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..addListener(_updateRotation)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: .center,
      children: [
        _buildPainter(isForeground: false),
        NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollStartNotification) {
              setState(() => _speedMultiplier = 0.05);
            } else if (notification is ScrollEndNotification) {
              setState(() => _speedMultiplier = 1.0);
            }
            return true;
          },
          child: widget.child,
        ),
        IgnorePointer(child: _buildPainter(isForeground: true)),
      ],
    );
  }

  Widget _buildPainter({required bool isForeground}) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: ParticlePainter(particles: _particles, rotation: _rotation, explosionForce: 2, drawForeground: isForeground),
        );
      },
    );
  }
}

class ParticlePainter extends CustomPainter {
  const ParticlePainter({
    required this.particles,
    required this.rotation,
    required this.explosionForce,
    required this.drawForeground,
  });

  final List<Particle> particles;
  final v_math.Matrix4 rotation;
  final double explosionForce;
  final bool drawForeground;

  static final List<_DrawData> _drawList = [];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const viewDistance = 600.0;

    _drawList.clear();

    for (var p in particles) {
      v_math.Vector3 pos = rotation.transformed3(p.basePosition);

      if (explosionForce > 0.01) {
        v_math.Vector3 dir = pos.normalized();
        pos += dir * (explosionForce * 50 * p.velocityMultiplier);
      }

      if (drawForeground ? pos.z >= 0 : pos.z < 0) continue;

      final scale = viewDistance / (viewDistance + pos.z);

      final data = _DrawData()
        ..offset = Offset(pos.x * scale + center.dx, pos.y * scale + center.dy)
        ..z = pos.z
        ..scale = scale
        ..color = p.color.withValues(alpha: (scale * 0.8).clamp(0.1, 1.0));

      _drawList.add(data);
    }

    _drawList.sort((a, b) => b.z.compareTo(a.z));

    final paint = Paint();
    for (var item in _drawList) {
      paint.color = item.color;
      canvas.drawCircle(item.offset, 6 * item.scale, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) => true;
}

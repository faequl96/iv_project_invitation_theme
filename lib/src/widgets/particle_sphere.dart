import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:vector_math/vector_math_64.dart' as v_math;

class Particle {
  Particle({required this.basePosition, required this.color}) : velocityMultiplier = math.Random().nextDouble() * 2.5 + 0.5;

  final v_math.Vector3 basePosition;
  final double velocityMultiplier;
  final Color color;
}

class ParticleSphere extends StatefulWidget {
  const ParticleSphere({super.key, this.size = 200.0, this.particleCount = 30, required this.colors, required this.child});

  const ParticleSphere.background({super.key, this.size = 200.0, this.particleCount = 30, required this.colors})
    : child = const SizedBox.shrink();

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
  final double _explosionForce = 2;
  final v_math.Matrix4 _rotation = v_math.Matrix4.identity();

  double _rotateX = 0.003;
  double _rotateY = 0.003;

  double _targetRotateX = 0.003;
  double _targetRotateY = 0.003;

  void _updateRandomDirection() {
    final rand = math.Random();
    _targetRotateX = (rand.nextDouble() - 0.5) * 0.02;
    _targetRotateY = (rand.nextDouble() - 0.5) * 0.02;
  }

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

  @override
  void initState() {
    super.initState();

    _generateParticles();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _controller.addListener(() {
      if (!mounted) return;

      setState(() {
        _rotateX = _rotateX + (_targetRotateX - _rotateX) * 0.01;
        _rotateY = _rotateY + (_targetRotateY - _rotateY) * 0.01;

        _rotation.rotateY(_rotateY);
        _rotation.rotateX(_rotateX);

        if (math.Random().nextInt(150) == 1) _updateRandomDirection();
      });
    });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _rotation.rotateY(0.003);

    return Stack(
      alignment: .center,
      children: [
        RepaintBoundary(
          child: CustomPaint(
            size: Size(widget.size, widget.size),
            painter: ParticlePainter(
              particles: _particles,
              rotation: _rotation,
              explosionForce: _explosionForce,
              drawForeground: false,
            ),
          ),
        ),
        SizedBox(width: Screen.width, height: Screen.height, child: widget.child),
        RepaintBoundary(
          child: CustomPaint(
            size: Size(widget.size, widget.size),
            painter: ParticlePainter(
              particles: _particles,
              rotation: _rotation,
              explosionForce: _explosionForce,
              drawForeground: true,
            ),
          ),
        ),
      ],
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

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const viewDistance = 600.0;
    List<Map<String, dynamic>> depthList = [];

    for (var p in particles) {
      v_math.Vector3 pos = rotation.transformed3(p.basePosition);

      if (explosionForce > 0.01) {
        v_math.Vector3 dir = pos.normalized();
        pos += dir * (explosionForce * 50 * p.velocityMultiplier);
      }

      if (drawForeground ? pos.z >= 0 : pos.z < 0) continue;

      double scale = viewDistance / (viewDistance + pos.z);
      double x = pos.x * scale + center.dx;
      double y = pos.y * scale + center.dy;

      depthList.add({
        'pos': Offset(x, y),
        'z': pos.z,
        'size': 6 * scale,
        'color': p.color.withValues(alpha: (scale * 0.8).clamp(0.1, 1.0)),
      });
    }

    depthList.sort((a, b) => (b['z'] as double).compareTo(a['z'] as double));

    final paint = Paint();
    for (var item in depthList) {
      paint.color = item['color'];
      canvas.drawCircle(item['pos'], item['size'], paint);
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) => true;
}

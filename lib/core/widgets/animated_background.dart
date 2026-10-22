import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

/// Living page background: drifting aurora glows, a slowly moving particle
/// network that links up to the mouse, and a soft spotlight under the cursor.
class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key, required this.pointer});

  /// Mouse position in global coordinates, or null when outside the page.
  final ValueNotifier<Offset?> pointer;

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 60),
  )..repeat();
  final List<_Particle> _particles = [];
  final Random _random = Random(7);
  Size _size = Size.zero;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _ensureParticles(Size size) {
    if (size == _size) return;
    _size = size;
    // Scale the particle count with screen area so phones stay smooth.
    final count = (size.width * size.height / 22000).clamp(25, 90).toInt();
    _particles
      ..clear()
      ..addAll(List.generate(count, (_) => _Particle.random(_random, size)));
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: LayoutBuilder(
        builder: (context, constraints) {
          _ensureParticles(constraints.biggest);
          return CustomPaint(
            size: constraints.biggest,
            painter: _BackgroundPainter(
              animation: _controller,
              pointer: widget.pointer,
              particles: _particles,
            ),
          );
        },
      ),
    );
  }
}

class _Particle {
  _Particle(this.position, this.velocity, this.radius);

  Offset position;
  Offset velocity;
  final double radius;

  factory _Particle.random(Random random, Size size) {
    final angle = random.nextDouble() * pi * 2;
    final speed = .15 + random.nextDouble() * .35;
    return _Particle(
      Offset(random.nextDouble() * size.width,
          random.nextDouble() * size.height),
      Offset(cos(angle), sin(angle)) * speed,
      .8 + random.nextDouble() * 1.6,
    );
  }

  void step(Size size) {
    position += velocity;
    if (position.dx < 0 || position.dx > size.width) {
      velocity = Offset(-velocity.dx, velocity.dy);
    }
    if (position.dy < 0 || position.dy > size.height) {
      velocity = Offset(velocity.dx, -velocity.dy);
    }
  }
}

class _BackgroundPainter extends CustomPainter {
  _BackgroundPainter({
    required this.animation,
    required this.pointer,
    required this.particles,
  }) : super(repaint: Listenable.merge([animation, pointer]));

  final Animation<double> animation;
  final ValueNotifier<Offset?> pointer;
  final List<_Particle> particles;

  static const double _linkDistance = 130;
  static const double _pointerDistance = 190;

  @override
  void paint(Canvas canvas, Size size) {
    final t = animation.value * 2 * pi;
    canvas.drawRect(Offset.zero & size, Paint()..color = AppColors.scaffoldColor);

    _paintGlow(canvas, size, Offset(.18 + .08 * sin(t), .22 + .06 * cos(t * 2)),
        .55, AppColors.primaryColor.withValues(alpha: .28));
    _paintGlow(canvas, size, Offset(.85 + .06 * cos(t), .35 + .1 * sin(t)),
        .5, AppColors.secondaryColor.withValues(alpha: .16));
    _paintGlow(canvas, size, Offset(.55 + .12 * sin(t * 2), .9 + .05 * cos(t)),
        .6, AppColors.accentPink.withValues(alpha: .12));

    final mouse = pointer.value;
    if (mouse != null) {
      canvas.drawCircle(
        mouse,
        320,
        Paint()
          ..shader = RadialGradient(colors: [
            AppColors.primaryColor.withValues(alpha: .14),
            Colors.transparent,
          ]).createShader(Rect.fromCircle(center: mouse, radius: 320)),
      );
    }

    final dot = Paint()..color = AppColors.white.withValues(alpha: .55);
    final line = Paint()..strokeWidth = .7;
    for (var i = 0; i < particles.length; i++) {
      final p = particles[i]..step(size);
      for (var j = i + 1; j < particles.length; j++) {
        final distance = (p.position - particles[j].position).distance;
        if (distance < _linkDistance) {
          line.color = AppColors.primaryColor
              .withValues(alpha: .22 * (1 - distance / _linkDistance));
          canvas.drawLine(p.position, particles[j].position, line);
        }
      }
      if (mouse != null) {
        final distance = (p.position - mouse).distance;
        if (distance < _pointerDistance) {
          line.color = AppColors.secondaryColor
              .withValues(alpha: .45 * (1 - distance / _pointerDistance));
          canvas.drawLine(p.position, mouse, line);
        }
      }
      canvas.drawCircle(p.position, p.radius, dot);
    }
  }

  void _paintGlow(
      Canvas canvas, Size size, Offset relative, double scale, Color color) {
    final center = Offset(relative.dx * size.width, relative.dy * size.height);
    final radius = size.shortestSide * scale + 200;
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..shader = RadialGradient(colors: [color, Colors.transparent])
            .createShader(Rect.fromCircle(center: center, radius: radius)),
    );
  }

  @override
  bool shouldRepaint(covariant _BackgroundPainter oldDelegate) => false;
}

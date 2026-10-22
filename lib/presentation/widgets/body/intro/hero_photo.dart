import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../data/portfolio_data.dart';

/// Profile photo with a glowing, rotating gradient ring, a gentle float and
/// tech badges orbiting around it.
class HeroPhoto extends StatefulWidget {
  const HeroPhoto({super.key, required this.size});

  final double size;

  @override
  State<HeroPhoto> createState() => _HeroPhotoState();
}

class _HeroPhotoState extends State<HeroPhoto> with TickerProviderStateMixin {
  late final AnimationController _spin = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 8),
  )..repeat();
  late final AnimationController _orbit = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 40),
  )..repeat();
  late final AnimationController _float = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _spin.dispose();
    _orbit.dispose();
    _float.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    final photo = size * .72;
    final badges = PortfolioData.profile.heroBadges;
    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: Listenable.merge([_orbit, _float]),
        builder: (context, child) {
          final dy = sin(_float.value * pi) * 10 - 5;
          return Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Soft glow behind the photo.
              Container(
                width: photo * 1.25,
                height: photo * 1.25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    AppColors.primaryColor.withValues(alpha: .45),
                    Colors.transparent,
                  ]),
                ),
              ),
              // Dashed orbit path.
              CustomPaint(
                size: Size.square(size * .92),
                painter: _OrbitPainter(),
              ),
              Transform.translate(offset: Offset(0, dy), child: child),
              for (var i = 0; i < badges.length; i++)
                _orbitBadge(badges[i], i, badges.length, size * .46),
            ],
          );
        },
        child: SizedBox(
          width: photo + 12,
          height: photo + 12,
          child: Stack(
            alignment: Alignment.center,
            children: [
              RotationTransition(
                turns: _spin,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(colors: [
                      AppColors.primaryColor,
                      AppColors.secondaryColor,
                      AppColors.accentPink,
                      AppColors.primaryColor,
                    ]),
                  ),
                ),
              ),
              Container(
                width: photo,
                height: photo,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.primaryLight, AppColors.scaffoldColor],
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: PortfolioData.profile.photo == null
                    ? _Monogram(size: photo)
                    : Image.asset(PortfolioData.profile.photo!, fit: BoxFit.cover),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _orbitBadge(String label, int index, int count, double radius) {
    final angle = 2 * pi * (_orbit.value + index / count);
    return Transform.translate(
      offset: Offset(cos(angle) * radius, sin(angle) * radius),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: .08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: Text(
              label,
              style: AppStyles.s14.copyWith(fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
}

/// Initials avatar used when profile.json has no photo.
class _Monogram extends StatelessWidget {
  const _Monogram({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: size * .2,
          child: Text(
            '</>',
            style: AppStyles.s16.copyWith(
              fontSize: size * .08,
              color: AppColors.secondaryColor.withValues(alpha: .8),
              letterSpacing: 2,
            ),
          ),
        ),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) =>
              AppColors.primaryGradient.createShader(bounds),
          child: Text(
            PortfolioData.profile.initials,
            style: AppStyles.s52.copyWith(
              fontSize: size * .34,
              fontWeight: FontWeight.w700,
              letterSpacing: -2,
            ),
          ),
        ),
        Positioned(
          bottom: size * .2,
          child: Text(
            'FLUTTER  ·  MOBILE',
            style: AppStyles.s14.copyWith(
              fontSize: size * .045,
              letterSpacing: 3,
              color: AppColors.lowPriority,
            ),
          ),
        ),
      ],
    );
  }
}

class _OrbitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.white.withValues(alpha: .12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final center = size.center(Offset.zero);
    final radius = size.width / 2;
    const dashes = 60;
    for (var i = 0; i < dashes; i += 2) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        2 * pi * i / dashes,
        2 * pi / dashes,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

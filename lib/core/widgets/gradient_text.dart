import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

/// Text painted with the brand gradient. When [animate] is true the
/// gradient slowly slides across the text.
class GradientText extends StatefulWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.style,
    this.animate = false,
    this.textAlign,
  });

  final String text;
  final TextStyle style;
  final bool animate;
  final TextAlign? textAlign;

  @override
  State<GradientText> createState() => _GradientTextState();
}

class _GradientTextState extends State<GradientText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  );

  @override
  void initState() {
    super.initState();
    if (widget.animate) _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = [
      AppColors.primaryColor,
      AppColors.secondaryColor,
      AppColors.accentPink,
      AppColors.primaryColor,
    ];
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) {
          final shift = bounds.width * 2 * _controller.value;
          return LinearGradient(colors: colors).createShader(
            Rect.fromLTWH(-shift, 0, bounds.width * 2, bounds.height),
          );
        },
        child: child,
      ),
      child: Text(
        widget.text,
        style: widget.style.copyWith(color: AppColors.white),
        textAlign: widget.textAlign,
      ),
    );
  }
}

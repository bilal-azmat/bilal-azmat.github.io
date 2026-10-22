import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

/// Filled (gradient) when [backgroundColor] is set, otherwise an outlined
/// glass button. Both glow and lift slightly on hover.
class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    this.height,
    required this.label,
    this.icon,
    this.backgroundColor,
    this.borderColor,
    this.onPressed,
    this.width,
  });

  final Function()? onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? height;
  final IconData? icon;
  final String label;
  final double? width;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final filled = widget.backgroundColor != null;
    final radius = BorderRadius.circular(14);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: widget.height ?? 48,
          width: widget.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          decoration: BoxDecoration(
            borderRadius: radius,
            gradient: filled ? AppColors.primaryGradient : null,
            color: filled
                ? null
                : AppColors.white.withValues(alpha: _hovered ? .08 : .03),
            border: filled
                ? null
                : Border.all(
                    color: _hovered
                        ? AppColors.secondaryColor
                        : (widget.borderColor ?? AppColors.glassBorder)
                            .withValues(alpha: .7),
                  ),
            boxShadow: [
              BoxShadow(
                color: (filled ? AppColors.primaryColor : AppColors.secondaryColor)
                    .withValues(alpha: _hovered ? .5 : (filled ? .25 : 0)),
                blurRadius: _hovered ? 28 : 18,
                spreadRadius: -6,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: AutoSizeText(
                  widget.label,
                  style: AppStyles.s16,
                  textAlign: TextAlign.center,
                  minFontSize: 8,
                  maxLines: 1,
                ),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 8),
                AnimatedSlide(
                  duration: const Duration(milliseconds: 200),
                  offset: Offset(_hovered ? .15 : 0, 0),
                  child: Icon(widget.icon, size: 18, color: AppColors.white),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

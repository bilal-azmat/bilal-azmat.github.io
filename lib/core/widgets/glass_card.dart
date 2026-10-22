import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

/// Frosted-glass surface that lifts and glows on hover.
class GlassCard extends StatefulWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.width,
    this.height,
    this.onTap,
    this.hoverEffect = true,
    this.radius = 20,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final bool hoverEffect;
  final double radius;

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final hovered = widget.hoverEffect && _hovered;
    final borderRadius = BorderRadius.circular(widget.radius);
    return MouseRegion(
      cursor: widget.onTap == null
          ? MouseCursor.defer
          : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          width: widget.width,
          height: widget.height,
          transform: Matrix4.translationValues(0, hovered ? -6 : 0, 0),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor
                    .withValues(alpha: hovered ? .35 : 0),
                blurRadius: 40,
                spreadRadius: -8,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: widget.padding,
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: hovered
                      ? AppColors.white.withValues(alpha: .07)
                      : AppColors.glass,
                  border: Border.all(
                    color: hovered
                        ? AppColors.primaryColor.withValues(alpha: .7)
                        : AppColors.glassBorder,
                  ),
                ),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

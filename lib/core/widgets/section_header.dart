import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_enums.dart';
import '../utils/app_extensions.dart';
import '../utils/app_styles.dart';
import 'gradient_text.dart';
import 'reveal.dart';

/// "01 / ABOUT" eyebrow, large title and optional subtitle.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
  });

  final String eyebrow;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final isMobile = context.width < DeviceType.mobile.getMaxWidth();
    return Reveal(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 28,
                height: 2,
                decoration:
                    BoxDecoration(gradient: AppColors.primaryGradient),
              ),
              const SizedBox(width: 10),
              GradientText(
                eyebrow.toUpperCase(),
                style: AppStyles.s14.copyWith(
                  letterSpacing: 3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppStyles.s52.copyWith(
              fontSize: isMobile ? 32 : 44,
              height: 1.15,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Text(
                subtitle!,
                style: (isMobile ? AppStyles.s14 : AppStyles.s17)
                    .copyWith(color: AppColors.lowPriority, height: 1.6),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

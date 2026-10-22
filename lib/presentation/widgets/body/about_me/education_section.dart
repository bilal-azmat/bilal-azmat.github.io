import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../data/portfolio_data.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final education = PortfolioData.profile.education;
    if (education == null) return const SizedBox.shrink();
    return Reveal(
      child: GlassCard(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(Icons.school_outlined, color: AppColors.white),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.education.toUpperCase(),
                    style: AppStyles.s14.copyWith(
                      fontSize: 11,
                      letterSpacing: 2.5,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    education.degree,
                    style: AppStyles.s18.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${education.institute}  ·  ${education.duration}',
                    style: AppStyles.s14.copyWith(color: AppColors.lowPriority),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

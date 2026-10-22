import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_extensions.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/animated_counter.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/gradient_text.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../data/portfolio_data.dart';

class AboutMeIntro extends StatelessWidget {
  const AboutMeIntro({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = PortfolioData.profile;
    final isMobile = context.width < DeviceType.mobile.getMaxWidth();
    final isWide = context.width > DeviceType.smallScreenLaptop.getMaxWidth();

    final paragraphs = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < profile.about.length; i++)
          Reveal(
            delay: Duration(milliseconds: 100 * i),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Text(
                profile.about[i],
                style: (isMobile ? AppStyles.s14 : AppStyles.s17)
                    .copyWith(color: AppColors.lightColor, height: 1.75),
              ),
            ),
          ),
      ],
    );

    final stats = Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        for (var i = 0; i < profile.stats.length; i++)
          Reveal(
            delay: Duration(milliseconds: 150 * i),
            child: GlassCard(
              width: isWide ? 200 : (isMobile ? double.infinity : 200),
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) =>
                        AppColors.primaryGradient.createShader(bounds),
                    child: AnimatedCounter(
                      value: profile.stats[i].value,
                      style: AppStyles.s52.copyWith(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile.stats[i].label,
                    style: AppStyles.s14.copyWith(color: AppColors.lowPriority),
                  ),
                ],
              ),
            ),
          ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          eyebrow: AppStrings.aboutEyebrow,
          title: AppStrings.aboutTitle,
        ),
        const SizedBox(height: 40),
        if (isWide)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: paragraphs),
              const SizedBox(width: 48),
              SizedBox(width: 200, child: stats),
            ],
          )
        else ...[
          paragraphs,
          const SizedBox(height: 16),
          stats,
        ],
        const SizedBox(height: 8),
        Reveal(
          child: Row(
            children: [
              Icon(Icons.location_on_outlined,
                  color: AppColors.secondaryColor, size: 18),
              const SizedBox(width: 6),
              GradientText(profile.location, style: AppStyles.s14),
            ],
          ),
        ),
      ],
    );
  }
}

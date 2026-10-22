import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_extensions.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../data/portfolio_data.dart';
import 'detailed_experience_item.dart';

/// Vertical timeline: a gradient rail with a glowing node per role.
class DetailedExperienceGrid extends StatelessWidget {
  const DetailedExperienceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final experience = PortfolioData.profile.experience;
    final isMobile = context.width < DeviceType.mobile.getMaxWidth();
    final railWidth = isMobile ? 24.0 : 48.0;
    return Column(
      children: [
        for (var i = 0; i < experience.length; i++)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: railWidth,
                  child: _TimelineRail(
                    isFirst: i == 0,
                    isLast: i == experience.length - 1,
                    isCurrent: experience[i].duration.contains('Present'),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Reveal(
                      delay: Duration(milliseconds: 120 * i),
                      child: DetailedExperienceItem(experience: experience[i]),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _TimelineRail extends StatelessWidget {
  const _TimelineRail({
    required this.isFirst,
    required this.isLast,
    required this.isCurrent,
  });

  final bool isFirst;
  final bool isLast;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: isFirst ? 32 : 0,
          bottom: isLast ? null : 0,
          height: isLast ? 32 : null,
          child: Container(
            width: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primaryColor,
                  AppColors.secondaryColor.withValues(alpha: .3),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 24,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.scaffoldColor,
              border: Border.all(
                color: isCurrent
                    ? AppColors.secondaryColor
                    : AppColors.primaryColor,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: (isCurrent
                          ? AppColors.secondaryColor
                          : AppColors.primaryColor)
                      .withValues(alpha: .6),
                  blurRadius: 14,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

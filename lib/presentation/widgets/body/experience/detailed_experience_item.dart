import 'package:flutter/material.dart';
import 'package:portfolio/data/models/experience_model.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_extensions.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/glass_card.dart';

class DetailedExperienceItem extends StatelessWidget {
  const DetailedExperienceItem({super.key, required this.experience});

  final WorkingExperience experience;

  @override
  Widget build(BuildContext context) {
    final isMobile = context.width < DeviceType.mobile.getMaxWidth();
    final logo = experience.logo == null
        ? null
        : Container(
            width: isMobile ? 48 : 60,
            height: isMobile ? 48 : 60,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Image.asset(experience.logo!, fit: BoxFit.contain),
          );

    final header = Wrap(
      spacing: 12,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              experience.designation,
              style: (isMobile ? AppStyles.s18 : AppStyles.s24)
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 2),
            Text(
              [experience.companyName, if (experience.client != null) experience.client]
                  .join('  ·  '),
              style: AppStyles.s16.copyWith(color: AppColors.secondaryColor),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.primaryColor.withValues(alpha: .12),
            border: Border.all(
                color: AppColors.primaryColor.withValues(alpha: .4)),
          ),
          child: Text(
            experience.duration,
            style: AppStyles.s14.copyWith(fontSize: 12),
          ),
        ),
      ],
    );

    return GlassCard(
      padding: EdgeInsets.all(isMobile ? 18 : 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (logo != null) ...[logo, const SizedBox(width: 18)],
              Expanded(child: header),
            ],
          ),
          if (experience.location != null) ...[
            const SizedBox(height: 10),
            Text(
              experience.location!,
              style: AppStyles.s14.copyWith(color: AppColors.lowPriority),
            ),
          ],
          if (experience.highlights.isNotEmpty) ...[
            const SizedBox(height: 16),
            for (final highlight in experience.highlights)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4, right: 10),
                      child: Icon(Icons.arrow_right_rounded,
                          size: 18, color: AppColors.secondaryColor),
                    ),
                    Expanded(
                      child: Text(
                        highlight,
                        style: (isMobile ? AppStyles.s14 : AppStyles.s16)
                            .copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.lightColor,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}

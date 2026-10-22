import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../data/models/custom_service.dart';

class DetailedServiceItem extends StatelessWidget {
  const DetailedServiceItem({super.key, required this.service});

  final CustomService service;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      height: 270,
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withValues(alpha: .45),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: SvgPicture.asset(
              service.logo,
              colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            service.service,
            style: AppStyles.s18.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: .5,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              service.description,
              style: AppStyles.s14.copyWith(
                color: AppColors.lightColor,
                height: 1.6,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }
}

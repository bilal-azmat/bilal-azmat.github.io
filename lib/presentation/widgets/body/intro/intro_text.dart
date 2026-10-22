import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_extensions.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/gradient_text.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../data/portfolio_data.dart';
import '../contact/social_medial_icons.dart';
import 'intro_actions.dart';
import 'typewriter_text.dart';

class IntroText extends StatelessWidget {
  const IntroText({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = PortfolioData.profile;
    final isMobile = context.width < DeviceType.ipad.getMaxWidth();
    final align = isMobile ? TextAlign.center : TextAlign.start;
    final cross =
        isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    Widget step(int index, Widget child) => Reveal(
          delay: Duration(milliseconds: 120 * index),
          offset: 24,
          child: child,
        );

    return Column(
      crossAxisAlignment: cross,
      children: [
        if (profile.availability != null)
          step(0, _AvailabilityBadge(text: profile.availability!)),
        const SizedBox(height: 24),
        step(
          1,
          Text(
            AppStrings.helloIM,
            style: (isMobile ? AppStyles.s18 : AppStyles.s24)
                .copyWith(color: AppColors.lightColor),
            textAlign: align,
          ),
        ),
        const SizedBox(height: 4),
        step(
          2,
          GradientText(
            profile.name,
            animate: true,
            textAlign: align,
            style: AppStyles.s52.copyWith(
              fontSize: isMobile ? 44 : 72,
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
          ),
        ),
        const SizedBox(height: 12),
        step(
          3,
          SizedBox(
            height: isMobile ? 34 : 44,
            child: TypewriterText(
              phrases: profile.roles.isEmpty ? [profile.title] : profile.roles,
              textAlign: align,
              style: (isMobile ? AppStyles.s24 : AppStyles.s32)
                  .copyWith(color: AppColors.white, fontSize: isMobile ? 22 : 30),
            ),
          ),
        ),
        if (profile.headline != null) ...[
          const SizedBox(height: 10),
          step(
            4,
            Text(
              profile.headline!,
              style: AppStyles.s14.copyWith(
                color: AppColors.secondaryColor,
                letterSpacing: .3,
              ),
              textAlign: align,
            ),
          ),
        ],
        const SizedBox(height: 20),
        step(
          5,
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              profile.intro,
              style: (isMobile ? AppStyles.s14 : AppStyles.s17)
                  .copyWith(color: AppColors.lightColor, height: 1.7),
              textAlign: align,
            ),
          ),
        ),
        const SizedBox(height: 32),
        step(6, const IntoActions()),
        const SizedBox(height: 24),
        step(7, const SocialMediaIcons()),
      ],
    );
  }
}

class _AvailabilityBadge extends StatefulWidget {
  const _AvailabilityBadge({required this.text});

  final String text;

  @override
  State<_AvailabilityBadge> createState() => _AvailabilityBadgeState();
}

class _AvailabilityBadgeState extends State<_AvailabilityBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat();

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.success.withValues(alpha: .35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 14,
            height: 14,
            child: AnimatedBuilder(
              animation: _pulse,
              builder: (context, _) => Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 6 + 8 * _pulse.value,
                    height: 6 + 8 * _pulse.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.success
                          .withValues(alpha: .5 * (1 - _pulse.value)),
                    ),
                  ),
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              widget.text,
              style: AppStyles.s14.copyWith(color: AppColors.success),
            ),
          ),
        ],
      ),
    );
  }
}

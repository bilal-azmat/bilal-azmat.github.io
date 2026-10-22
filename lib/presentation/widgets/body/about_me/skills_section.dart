import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../data/portfolio_data.dart';

class SkillSection extends StatelessWidget {
  const SkillSection({super.key});

  static const double _spacing = 20;

  @override
  Widget build(BuildContext context) {
    final groups = PortfolioData.profile.skills;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          eyebrow: AppStrings.skillsEyebrow,
          title: AppStrings.skillsIOffer,
        ),
        const SizedBox(height: 40),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns =
                (constraints.maxWidth / 360).floor().clamp(1, 3);
            final width =
                (constraints.maxWidth - _spacing * (columns - 1)) / columns;
            return Wrap(
              spacing: _spacing,
              runSpacing: _spacing,
              children: [
                for (var i = 0; i < groups.length; i++)
                  Reveal(
                    delay: Duration(milliseconds: 60 * (i % columns)),
                    child: GlassCard(
                      width: width,
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: AppColors.primaryGradient,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  groups[i].group,
                                  style: AppStyles.s16,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (final skill in groups[i].items)
                                SkillChip(label: skill),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class SkillChip extends StatefulWidget {
  const SkillChip({super.key, required this.label, this.dense = false});

  final String label;
  final bool dense;

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final dense = widget.dense;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(
          horizontal: dense ? 10 : 12,
          vertical: dense ? 4 : 7,
        ),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.primaryColor.withValues(alpha: .22)
              : AppColors.white.withValues(alpha: .04),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? AppColors.secondaryColor.withValues(alpha: .8)
                : AppColors.glassBorder,
          ),
        ),
        child: Text(
          widget.label,
          style: AppStyles.s14.copyWith(
            fontSize: dense ? 11 : 13,
            color: _hovered ? AppColors.white : AppColors.lightColor,
          ),
        ),
      ),
    );
  }
}

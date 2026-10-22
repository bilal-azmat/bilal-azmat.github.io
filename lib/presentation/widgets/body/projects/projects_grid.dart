import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../data/portfolio_data.dart';
import 'project_item.dart';

class ProjectsGrid extends StatefulWidget {
  const ProjectsGrid({super.key});

  @override
  State<ProjectsGrid> createState() => _ProjectsGridState();
}

class _ProjectsGridState extends State<ProjectsGrid> {
  static const double _spacing = 24;
  static const double _minCardWidth = 320;

  String _selected = AppStrings.allProjects;

  @override
  Widget build(BuildContext context) {
    final categories = [AppStrings.allProjects, ...PortfolioData.categories];
    final filtered = _selected == AppStrings.allProjects
        ? PortfolioData.projects
        : PortfolioData.projects
            .where((project) => project.companyName == _selected)
            .toList();
    // Projects with screenshots first, keeping the JSON order within each group.
    final projects = [
      ...filtered.where((project) => project.images.isNotEmpty),
      ...filtered.where((project) => project.images.isEmpty),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Reveal(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final category in categories)
                _FilterChip(
                  label: category,
                  count: category == AppStrings.allProjects
                      ? PortfolioData.projects.length
                      : PortfolioData.projects
                          .where((project) => project.companyName == category)
                          .length,
                  selected: category == _selected,
                  onTap: () => setState(() => _selected = category),
                ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = (constraints.maxWidth / _minCardWidth)
                .floor()
                .clamp(1, 3);
            final cardWidth =
                (constraints.maxWidth - _spacing * (columns - 1)) / columns;
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 450),
              switchInCurve: Curves.easeOutCubic,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween(
                    begin: const Offset(0, .03),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
              child: Wrap(
                key: ValueKey(_selected),
                spacing: _spacing,
                runSpacing: _spacing,
                children: [
                  for (var i = 0; i < projects.length; i++)
                    Reveal(
                      delay: Duration(milliseconds: 80 * (i % columns)),
                      child: ProjectItem(
                        project: projects[i],
                        width: cardWidth,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _FilterChip extends StatefulWidget {
  const _FilterChip({
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_FilterChip> createState() => _FilterChipState();
}

class _FilterChipState extends State<_FilterChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final selected = widget.selected;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: selected ? AppColors.primaryGradient : null,
            color: selected
                ? null
                : AppColors.white.withValues(alpha: _hovered ? .08 : .03),
            border: Border.all(
              color: selected
                  ? Colors.transparent
                  : (_hovered ? AppColors.secondaryColor : AppColors.glassBorder),
            ),
            boxShadow: [
              if (selected)
                BoxShadow(
                  color: AppColors.primaryColor.withValues(alpha: .4),
                  blurRadius: 20,
                  spreadRadius: -4,
                ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  widget.label,
                  style: AppStyles.s14,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: selected ? .25 : .08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${widget.count}',
                  style: AppStyles.s14.copyWith(fontSize: 11),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

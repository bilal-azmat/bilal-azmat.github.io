import 'package:flutter/material.dart';
import 'package:portfolio/data/models/project_list_model.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/glass_card.dart';
import '../about_me/skills_section.dart';
import 'project_actions.dart';
import 'project_cover.dart';
import 'project_details_dialog.dart';

class ProjectItem extends StatefulWidget {
  const ProjectItem({super.key, required this.project, required this.width});

  final Project project;
  final double width;

  @override
  State<ProjectItem> createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GlassCard(
        width: widget.width,
        height: 540,
        padding: const EdgeInsets.all(14),
        onTap: () => ProjectDetailsDialog.show(context, project),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProjectCover(project: project, zoomed: _hovered),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 18, 8, 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ProjectIcon(project: project, size: 36),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project.title,
                                style: AppStyles.s18
                                    .copyWith(fontWeight: FontWeight.w700),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                [project.companyName, if (project.client != null) project.client]
                                    .join('  ·  '),
                                style: AppStyles.s14.copyWith(
                                  fontSize: 12,
                                  color: AppColors.secondaryColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Fills the space left on the fixed-height card and clips
                    // instead of overflowing when chips wrap onto extra lines.
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project.shortDescription,
                              style: AppStyles.s14.copyWith(
                                color: AppColors.lightColor,
                                height: 1.6,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: [
                                for (final tech in project.techStack.take(4))
                                  SkillChip(label: tech, dense: true),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ProjectActions(project: project),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

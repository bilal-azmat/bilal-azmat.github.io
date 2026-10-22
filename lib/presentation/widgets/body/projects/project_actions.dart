import 'package:flutter/material.dart';
import 'package:portfolio/data/models/project_list_model.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import 'project_details_dialog.dart';

class ProjectActions extends StatelessWidget {
  const ProjectActions({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final link = project.links.isEmpty ? null : project.links.first;
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            label: 'Details',
            icon: Icons.arrow_forward,
            height: 44,
            backgroundColor: AppColors.primaryColor,
            onPressed: () => ProjectDetailsDialog.show(context, project),
          ),
        ),
        if (link != null) ...[
          const SizedBox(width: 10),
          Expanded(
            child: CustomButton(
              label: project.links.length > 1 ? 'Play Store' : link.label,
              icon: Icons.open_in_new,
              height: 44,
              borderColor: AppColors.primaryColor,
              onPressed: () => html.window.open(link.url, '_blank'),
            ),
          ),
        ],
      ],
    );
  }
}

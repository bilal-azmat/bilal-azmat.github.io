import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/section_header.dart';

class ProjectsIntro extends StatelessWidget {
  const ProjectsIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionHeader(
      eyebrow: AppStrings.projectsEyebrow,
      title: AppStrings.featuredProjects,
      subtitle: AppStrings.projectsMsg,
    );
  }
}

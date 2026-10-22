import 'package:flutter/material.dart';

import 'projects_grid.dart';
import 'projects_intro.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 100, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProjectsIntro(),
          SizedBox(height: 40),
          ProjectsGrid(),
        ],
      ),
    );
  }
}

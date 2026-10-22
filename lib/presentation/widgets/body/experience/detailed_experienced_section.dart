import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/section_header.dart';
import 'detailed_experienced_grid.dart';

class DetailedExperienceSection extends StatelessWidget {
  const DetailedExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: AppStrings.experienceEyebrow,
          title: AppStrings.workingExpIOffer,
        ),
        SizedBox(height: 40),
        DetailedExperienceGrid(),
      ],
    );
  }
}

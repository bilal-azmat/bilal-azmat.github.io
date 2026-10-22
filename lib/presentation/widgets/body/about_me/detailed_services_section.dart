import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/section_header.dart';
import 'detailed_services_grid.dart';

class DetailedServicesSection extends StatelessWidget {
  const DetailedServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: AppStrings.servicesEyebrow,
          title: AppStrings.servicesIOffer,
        ),
        SizedBox(height: 40),
        DetailedServicesGrid(),
      ],
    );
  }
}

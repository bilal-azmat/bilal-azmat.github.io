import 'package:flutter/material.dart';

import '../experience/detailed_experienced_section.dart';
import 'about_me_intro.dart';
import 'detailed_services_section.dart';
import 'education_section.dart';
import 'skills_section.dart';

class AboutMeSection extends StatelessWidget {
  const AboutMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 100, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AboutMeIntro(),
          SizedBox(height: 140),
          DetailedExperienceSection(),
          SizedBox(height: 140),
          SkillSection(),
          SizedBox(height: 140),
          DetailedServicesSection(),
          SizedBox(height: 24),
          EducationSection(),
        ],
      ),
    );
  }
}

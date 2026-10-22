import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../data/models/project_list_model.dart';
import '../../../../data/portfolio_data.dart';
import 'project_image.dart';

/// Card header: up to three screenshots side by side, or the app icon
/// (falling back to the company logo) when there are no screenshots yet.
/// Screenshots ease upward and zoom slightly when [zoomed].
class ProjectCover extends StatelessWidget {
  const ProjectCover({
    super.key,
    required this.project,
    this.height = 220,
    this.zoomed = false,
  });

  final Project project;
  final double height;
  final bool zoomed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryColor.withValues(alpha: .35),
            AppColors.secondaryColor.withValues(alpha: .12),
            AppColors.scaffoldColor,
          ],
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: project.images.isEmpty
          ? Center(
              child: AnimatedScale(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                scale: zoomed ? 1.12 : 1,
                child: ProjectIcon(project: project, size: 92),
              ),
            )
          : AnimatedSlide(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              offset: Offset(0, zoomed ? -.04 : .06),
              child: AnimatedScale(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
                scale: zoomed ? 1.06 : 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 18, 12, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final image in project.images.take(3))
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ProjectImage(
                                path: image,
                                fit: BoxFit.cover,
                                height: height,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class ProjectIcon extends StatelessWidget {
  const ProjectIcon({super.key, required this.project, this.size = 56});

  final Project project;
  final double size;

  @override
  Widget build(BuildContext context) {
    final path = project.icon ?? _companyLogo(project.companyName);
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(project.icon == null ? size * .15 : 0),
      decoration: BoxDecoration(
        color: path == null ? null : AppColors.white,
        gradient: path == null ? AppColors.primaryGradient : null,
        borderRadius: BorderRadius.circular(size * .24),
      ),
      clipBehavior: Clip.antiAlias,
      child: path == null
          ? Icon(Icons.code, color: AppColors.white, size: size * .5)
          : ProjectImage(path: path, fit: BoxFit.contain),
    );
  }

  static String? _companyLogo(String companyName) {
    for (final experience in PortfolioData.profile.experience) {
      if (experience.companyName == companyName) return experience.logo;
    }
    return null;
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio/data/models/project_list_model.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_extensions.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/gradient_text.dart';
import '../about_me/skills_section.dart';
import 'project_cover.dart';
import 'project_image.dart';

class ProjectDetailsDialog extends StatelessWidget {
  const ProjectDetailsDialog({super.key, required this.project});

  final Project project;

  static Future<void> show(BuildContext context, Project project) {
    return showDialog(
      context: context,
      builder: (_) => ProjectDetailsDialog(project: project),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.width < DeviceType.ipad.getMaxWidth();
    return Dialog(
      backgroundColor: AppColors.appBarColor,
      insetPadding: EdgeInsets.all(isMobile ? 12 : 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: AppColors.glassBorder),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(isMobile ? 16 : 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(project: project),
                  if (project.images.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    _Screenshots(
                      images: project.images,
                      height: isMobile ? 380 : 480,
                    ),
                  ],
                  const SizedBox(height: 24),
                  Text(
                    project.description,
                    style: isMobile ? AppStyles.s14 : AppStyles.s17,
                  ),
                  if (project.highlights.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Text('Highlights', style: AppStyles.s24),
                    const SizedBox(height: 12),
                    for (final highlight in project.highlights)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2, right: 10),
                              child: Icon(Icons.check_circle,
                                  size: 18, color: AppColors.primaryColor),
                            ),
                            Expanded(
                              child: Text(
                                highlight,
                                style: isMobile ? AppStyles.s14 : AppStyles.s16,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                  if (project.techStack.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Text('Tech stack', style: AppStyles.s24),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (final tech in project.techStack)
                          SkillChip(label: tech),
                      ],
                    ),
                  ],
                  if (project.links.isNotEmpty) ...[
                    const SizedBox(height: 32),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        for (final link in project.links)
                          CustomButton(
                            label: link.label,
                            icon: Icons.open_in_new,
                            width: 160,
                            borderColor: AppColors.primaryColor,
                            onPressed: () => html.window.open(link.url, '_blank'),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                tooltip: 'Close',
                icon: Icon(Icons.close, color: AppColors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: Row(
        children: [
          ProjectIcon(project: project, size: 64),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GradientText(
                  project.title,
                  style: AppStyles.s28.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  [project.companyName, if (project.client != null) project.client]
                      .join('  •  '),
                  style: AppStyles.s14.copyWith(color: AppColors.lowPriority),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Screenshots extends StatefulWidget {
  const _Screenshots({required this.images, required this.height});

  final List<String> images;
  final double height;

  @override
  State<_Screenshots> createState() => _ScreenshotsState();
}

class _ScreenshotsState extends State<_Screenshots> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height + 16,
      // Let mouse users drag the strip as well as scroll it.
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: PointerDeviceKind.values.toSet(),
        ),
        child: Scrollbar(
          controller: _controller,
          thumbVisibility: true,
          child: ListView.separated(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: widget.images.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => _openFullScreen(context, index),
              child: MouseRegion(
                cursor: SystemMouseCursors.zoomIn,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ProjectImage(
                    path: widget.images[index],
                    height: widget.height,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openFullScreen(BuildContext context, int initialIndex) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) => _FullScreenGallery(
        images: widget.images,
        initialIndex: initialIndex,
      ),
    );
  }
}

class _FullScreenGallery extends StatefulWidget {
  const _FullScreenGallery({required this.images, required this.initialIndex});

  final List<String> images;
  final int initialIndex;

  @override
  State<_FullScreenGallery> createState() => _FullScreenGalleryState();
}

class _FullScreenGalleryState extends State<_FullScreenGallery> {
  late final PageController _controller =
      PageController(initialPage: widget.initialIndex);
  late int _index = widget.initialIndex;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _controller,
          itemCount: widget.images.length,
          onPageChanged: (index) => setState(() => _index = index),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 64),
            child: ProjectImage(
              path: widget.images[index],
              fit: BoxFit.contain,
            ),
          ),
        ),
        if (_index > 0)
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              iconSize: 40,
              icon: Icon(Icons.chevron_left, color: AppColors.white),
              onPressed: () => _goTo(_index - 1),
            ),
          ),
        if (_index < widget.images.length - 1)
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              iconSize: 40,
              icon: Icon(Icons.chevron_right, color: AppColors.white),
              onPressed: () => _goTo(_index + 1),
            ),
          ),
        Positioned(
          top: 8,
          right: 8,
          child: IconButton(
            tooltip: 'Close',
            icon: Icon(Icons.close, color: AppColors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Text(
            '${_index + 1} / ${widget.images.length}',
            textAlign: TextAlign.center,
            style: AppStyles.s14,
          ),
        ),
      ],
    );
  }
}

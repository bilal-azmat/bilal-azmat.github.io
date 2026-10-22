import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

/// Shows an image from either a bundled asset path or a network URL,
/// so projects.json can mix both.
class ProjectImage extends StatelessWidget {
  const ProjectImage({
    super.key,
    required this.path,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  final String path;
  final BoxFit fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    Widget error(BuildContext context, Object error, dynamic _) => Icon(
          Icons.broken_image_outlined,
          color: AppColors.lowPriority,
          size: 40,
        );

    if (path.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: path,
        width: width,
        height: height,
        fit: fit,
        errorWidget: error,
      );
    }
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: error,
    );
  }
}

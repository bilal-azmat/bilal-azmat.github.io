import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_enums.dart';
import '../../../core/utils/app_extensions.dart';
import 'custom_menu_btn.dart';
import 'developer_name_btn.dart';
import 'horizontal_headers.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(AppConstants.appBarHeight);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          height: AppConstants.appBarHeight,
          decoration: BoxDecoration(
            color: AppColors.scaffoldColor.withValues(alpha: .55),
            border: Border(bottom: BorderSide(color: AppColors.glassBorder)),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: _getHorizontalPadding(context),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(child: DeveloperNameBtn()),
              context.width > DeviceType.ipad.getMaxWidth()
                  ? const HorizontalHeaders()
                  : const CustomMenuBtn()
            ],
          ),
        ),
      ),
    );
  }

  double _getHorizontalPadding(BuildContext context) {
    if (context.width < DeviceType.ipad.getMaxWidth()) {
      return context.width * .04;
    } else {
      return context.width * .08;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_enums.dart';
import '../../../core/utils/app_extensions.dart';
import '../../../core/utils/app_styles.dart';
import '../../blocs/home_bloc/home_bloc.dart';

/// Nav link with a gradient underline that grows on hover and stays on the
/// active section.
class CustomHeaderBtn extends StatefulWidget {
  const CustomHeaderBtn({super.key, required this.headerIndex});

  final int headerIndex;

  @override
  State<CustomHeaderBtn> createState() => _CustomHeaderBtnState();
}

class _CustomHeaderBtnState extends State<CustomHeaderBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final active =
        context.read<HomeBloc>().appBarHeaderIndex == widget.headerIndex;
    final highlighted = active || _hovered;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context
            .read<HomeBloc>()
            .add(ChangeAppBarHeadersIndex(widget.headerIndex)),
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: AppStyles.s16.copyWith(
                  fontWeight: FontWeight.w500,
                  color: highlighted ? AppColors.white : AppColors.lowPriority,
                ),
                child: Text(AppBarHeaders.values[widget.headerIndex].getString()),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                height: 2,
                width: active ? 24 : (_hovered ? 14 : 0),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

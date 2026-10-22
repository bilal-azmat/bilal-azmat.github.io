import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_enums.dart';
import '../../blocs/home_bloc/home_bloc.dart';
import 'vertical_headers.dart';

class VerticalHeadersBuilder extends StatelessWidget {
  const VerticalHeadersBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final open = context.read<HomeBloc>().appBarHeaderAxis ==
            AppBarHeadersAxis.vertical;
        return Padding(
          padding: const EdgeInsets.only(top: AppConstants.appBarHeight),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: open
                ? ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.scaffoldColor.withValues(alpha: .8),
                          border: Border(
                            bottom: BorderSide(color: AppColors.glassBorder),
                          ),
                        ),
                        child: const VerticalHeaders(),
                      ),
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        );
      },
    );
  }
}

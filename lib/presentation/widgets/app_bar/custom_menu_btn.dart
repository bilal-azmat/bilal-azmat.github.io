import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_enums.dart';
import '../../blocs/home_bloc/home_bloc.dart';

class CustomMenuBtn extends StatelessWidget {
  const CustomMenuBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final open = context.read<HomeBloc>().appBarHeaderAxis ==
            AppBarHeadersAxis.vertical;
        return IconButton(
          onPressed: () => context.read<HomeBloc>().add(
                ChangeAppBarHeadersAxis(
                  open
                      ? AppBarHeadersAxis.horizontal
                      : AppBarHeadersAxis.vertical,
                ),
              ),
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) =>
                RotationTransition(turns: animation, child: child),
            child: Icon(
              open ? Icons.close_rounded : Icons.menu_rounded,
              key: ValueKey(open),
              color: AppColors.white,
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../data/portfolio_data.dart';
import '../../blocs/home_bloc/home_bloc.dart';

/// Gradient monogram logo with the name beside it; scrolls back to the top.
class DeveloperNameBtn extends StatelessWidget {
  const DeveloperNameBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = PortfolioData.profile;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.read<HomeBloc>().add(ChangeAppBarHeadersIndex(0)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: .5),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Text(
                profile.initials,
                style: AppStyles.s16.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(text: profile.name),
                  TextSpan(
                    text: '.',
                    style: TextStyle(color: AppColors.secondaryColor),
                  ),
                ]),
                style: AppStyles.s18.copyWith(fontWeight: FontWeight.w700),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

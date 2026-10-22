import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../data/portfolio_data.dart';
import '../../../blocs/home_bloc/home_bloc.dart';

class IntoActions extends StatelessWidget {
  const IntoActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        CustomButton(
          label: 'View my work',
          icon: Icons.arrow_forward,
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            context.read<HomeBloc>().add(ChangeAppBarHeadersIndex(2));
          },
          width: 190,
          height: 52,
        ),
        CustomButton(
          label: 'View Resume',
          icon: Icons.description_outlined,
          borderColor: AppColors.primaryColor,
          onPressed: () {
            // Flutter web serves bundled assets under /assets/<asset path>.
            html.window.open('assets/${PortfolioData.profile.resume}', '_blank');
          },
          width: 190,
          height: 52,
        ),
      ],
    );
  }
}

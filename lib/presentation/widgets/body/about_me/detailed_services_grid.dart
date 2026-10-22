import 'package:flutter/material.dart';

import '../../../../core/widgets/reveal.dart';
import '../../../../data/portfolio_data.dart';
import 'detailed_service_item.dart';

class DetailedServicesGrid extends StatelessWidget {
  const DetailedServicesGrid({super.key});

  static const double _spacing = 20;

  @override
  Widget build(BuildContext context) {
    final services = PortfolioData.profile.services;
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = (constraints.maxWidth / 300).floor().clamp(1, 3);
        final width =
            (constraints.maxWidth - _spacing * (columns - 1)) / columns;
        return Wrap(
          spacing: _spacing,
          runSpacing: _spacing,
          children: [
            for (var i = 0; i < services.length; i++)
              Reveal(
                delay: Duration(milliseconds: 120 * i),
                child: SizedBox(
                  width: width,
                  child: DetailedServiceItem(service: services[i]),
                ),
              ),
          ],
        );
      },
    );
  }
}

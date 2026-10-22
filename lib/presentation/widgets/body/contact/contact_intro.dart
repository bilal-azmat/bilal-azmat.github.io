import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../data/portfolio_data.dart';
import 'social_medial_icons.dart';

class ContactIntro extends StatelessWidget {
  const ContactIntro({super.key});

  static const String _phone = '+923472299343';

  @override
  Widget build(BuildContext context) {
    final profile = PortfolioData.profile;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ContactTile(
          icon: Icons.mail_outline,
          label: 'Email',
          value: profile.email,
          onTap: () => html.window.open('mailto:${profile.email}', '_self'),
        ),
        const SizedBox(height: 14),
        _ContactTile(
          icon: FontAwesomeIcons.whatsapp,
          label: 'WhatsApp',
          value: _phone,
          onTap: () => html.window
              .open('https://wa.me/${_phone.replaceAll('+', '')}', '_blank'),
        ),
        const SizedBox(height: 14),
        _ContactTile(
          icon: Icons.location_on_outlined,
          label: 'Location',
          value: profile.location,
        ),
        const SizedBox(height: 24),
        const SocialMediaIcons(),
      ],
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      radius: 16,
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.white, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppStyles.s14
                      .copyWith(fontSize: 12, color: AppColors.lowPriority),
                ),
                Text(value, style: AppStyles.s16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

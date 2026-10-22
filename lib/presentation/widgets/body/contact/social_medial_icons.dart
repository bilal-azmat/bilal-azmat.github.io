import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/social_links.dart';

class SocialMediaIcons extends StatelessWidget {
  const SocialMediaIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        SocialMediaIconBtn(
          icon: FontAwesomeIcons.linkedinIn,
          link: SocialLinks.linkedin,
        ),
        SocialMediaIconBtn(
          icon: FontAwesomeIcons.github,
          link: SocialLinks.github,
        ),
        SocialMediaIconBtn(
          icon: FontAwesomeIcons.googlePlay,
          link: SocialLinks.playStore,
        ),
      ],
    );
  }
}

class SocialMediaIconBtn extends StatefulWidget {
  const SocialMediaIconBtn({super.key, required this.icon, required this.link});

  final IconData icon;
  final String link;

  @override
  State<SocialMediaIconBtn> createState() => _SocialMediaIconBtnState();
}

class _SocialMediaIconBtnState extends State<SocialMediaIconBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => html.window.open(widget.link, '_blank'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: 46,
          height: 46,
          transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: _hovered ? AppColors.primaryGradient : null,
            color: _hovered ? null : AppColors.white.withValues(alpha: .05),
            border: Border.all(
              color: _hovered ? Colors.transparent : AppColors.glassBorder,
            ),
            boxShadow: [
              if (_hovered)
                BoxShadow(
                  color: AppColors.primaryColor.withValues(alpha: .5),
                  blurRadius: 20,
                ),
            ],
          ),
          child: Icon(widget.icon, size: 18, color: AppColors.white),
        ),
      ),
    );
  }
}

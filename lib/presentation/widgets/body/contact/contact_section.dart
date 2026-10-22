import 'package:flutter/material.dart';
import 'package:portfolio/core/utils/app_enums.dart';
import 'package:portfolio/core/utils/app_extensions.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../core/widgets/section_header.dart';
import 'contact_form.dart';
import 'contact_intro.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = context.width > DeviceType.ipad.getMaxWidth();
    final form = Reveal(
      delay: const Duration(milliseconds: 150),
      child: GlassCard(
        hoverEffect: false,
        padding: EdgeInsets.all(isWide ? 32 : 20),
        child: const ContactForm(),
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(top: 100, bottom: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: AppStrings.contactEyebrow,
            title: AppStrings.contactWithMe,
            subtitle: AppStrings.contactMsg,
          ),
          const SizedBox(height: 40),
          isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 4, child: Reveal(child: ContactIntro())),
                    const SizedBox(width: 32),
                    Expanded(flex: 6, child: form),
                  ],
                )
              : Column(
                  children: [
                    const Reveal(child: ContactIntro()),
                    const SizedBox(height: 24),
                    form,
                  ],
                ),
        ],
      ),
    );
  }
}

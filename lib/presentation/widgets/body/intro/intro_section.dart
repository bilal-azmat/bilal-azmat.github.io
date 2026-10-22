import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_extensions.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/reveal.dart';
import 'hero_photo.dart';
import 'intro_text.dart';

class IntroSection extends StatelessWidget {
  const IntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.width < DeviceType.ipad.getMaxWidth();
    final photo = Reveal(
      delay: const Duration(milliseconds: 300),
      child: HeroPhoto(
        size: isMobile
            ? (context.width * .8).clamp(260, 380)
            : (context.width * .34).clamp(340, 500),
      ),
    );
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: context.height),
      child: Padding(
        padding: EdgeInsets.only(
          top: AppConstants.appBarHeight + (isMobile ? 32 : 48),
          bottom: 32,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isMobile
                ? Column(
                    children: [photo, const SizedBox(height: 40), const IntroText()],
                  )
                : Row(
                    children: [
                      const Expanded(flex: 6, child: IntroText()),
                      const SizedBox(width: 32),
                      Expanded(flex: 5, child: Center(child: photo)),
                    ],
                  ),
            const SizedBox(height: 48),
            const _ScrollHint(),
          ],
        ),
      ),
    );
  }
}

/// Animated mouse outline nudging visitors to scroll.
class _ScrollHint extends StatefulWidget {
  const _ScrollHint();

  @override
  State<_ScrollHint> createState() => _ScrollHintState();
}

class _ScrollHintState extends State<_ScrollHint>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.lowPriority, width: 1.5),
          ),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => Align(
              alignment: Alignment(0, -.6 + _controller.value),
              child: Opacity(
                opacity: 1 - _controller.value,
                child: Container(
                  width: 4,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'SCROLL',
          style: AppStyles.s14.copyWith(
            fontSize: 10,
            letterSpacing: 3,
            color: AppColors.lowPriority,
          ),
        ),
      ],
    );
  }
}

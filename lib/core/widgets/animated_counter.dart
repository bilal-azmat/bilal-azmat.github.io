import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Counts up to the number inside [value] (e.g. "20+") when first visible,
/// keeping any prefix or suffix text.
class AnimatedCounter extends StatefulWidget {
  const AnimatedCounter({super.key, required this.value, required this.style});

  final String value;
  final TextStyle style;

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );
  final Key _key = UniqueKey();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final match = RegExp(r'\d+').firstMatch(widget.value);
    if (match == null) return Text(widget.value, style: widget.style);
    final target = int.parse(match.group(0)!);
    final prefix = widget.value.substring(0, match.start);
    final suffix = widget.value.substring(match.end);
    return VisibilityDetector(
      key: _key,
      onVisibilityChanged: (info) {
        if (info.visibleFraction > .3 && !_controller.isAnimating &&
            _controller.value == 0) {
          _controller.forward();
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final current = (target *
                  Curves.easeOutCubic.transform(_controller.value))
              .round();
          return Text('$prefix$current$suffix', style: widget.style);
        },
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

/// Types each phrase, pauses, deletes it and moves to the next, with a
/// blinking cursor.
class TypewriterText extends StatefulWidget {
  const TypewriterText({
    super.key,
    required this.phrases,
    required this.style,
    this.textAlign = TextAlign.start,
  });

  final List<String> phrases;
  final TextStyle style;
  final TextAlign textAlign;

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _cursor = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  )..repeat(reverse: true);
  Timer? _timer;
  int _phrase = 0;
  int _length = 0;
  bool _deleting = false;

  @override
  void initState() {
    super.initState();
    if (widget.phrases.isNotEmpty) _tick();
  }

  void _tick() {
    final text = widget.phrases[_phrase];
    Duration next = Duration(milliseconds: _deleting ? 35 : 75);
    setState(() {
      if (!_deleting && _length < text.length) {
        _length++;
      } else if (!_deleting) {
        _deleting = true;
        next = const Duration(milliseconds: 1800);
      } else if (_length > 0) {
        _length--;
      } else {
        _deleting = false;
        _phrase = (_phrase + 1) % widget.phrases.length;
        next = const Duration(milliseconds: 300);
      }
    });
    _timer = Timer(next, _tick);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cursor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.phrases.isEmpty) return const SizedBox.shrink();
    final text = widget.phrases[_phrase].substring(0, _length);
    return Text.rich(
      TextSpan(children: [
        TextSpan(text: text),
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: FadeTransition(
            opacity: _cursor,
            child: Container(
              margin: const EdgeInsets.only(left: 4),
              width: 3,
              height: (widget.style.fontSize ?? 20) * 1.1,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ]),
      style: widget.style,
      textAlign: widget.textAlign,
    );
  }
}

import 'package:flutter/material.dart';

abstract class AppColors {
  static Color white = const Color(0xffffffff);
  static Color lightColor = const Color(0xffD4D4E8);
  static Color lowPriority = const Color(0xff8B8BA7);
  static Color primaryColor = const Color(0xff8B5CF6);
  static Color secondaryColor = const Color(0xff22D3EE);
  static Color accentPink = const Color(0xffF472B6);
  static Color darkColor = const Color(0xff000036);
  static Color scaffoldColor = const Color(0xff070712);
  static Color appBarColor = const Color(0xff0B0B18);
  static Color primaryLight = const Color(0xff15152A);
  static Color glass = const Color(0x0DFFFFFF);
  static Color glassBorder = const Color(0x1FFFFFFF);
  static Color success = const Color(0xff34D399);

  static LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, const Color(0xff6366F1), secondaryColor],
  );
}

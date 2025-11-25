import 'package:flutter/material.dart';

class AppColor {
  // Primary Brand Color
  static const Color primary = Color(0xff3D5EF3);
  static const Color secondary = Colors.white;

  // Background Colors
  static const Color background = Colors.white;
  static const Color surface = Color(0xFFF4F6F6);
  static const Color price = Colors.green;

  // Text Colors
  static const Color textPrimary = Color(0xff737DF7); // headings like "Privacy Policy"
  static const Color textSecondary = Color(0xFF6C6C6C); // body paragraph text
  static const Color textBlack = Color(0xFF25262C);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Button Colors
  static const Color buttonPrimary = Color(0xff737DF7);
  static const Color buttonText = Color(0xFFFFFFFF);

  // Border / Divider / Checkbox
  static const Color border = Color(0xFF000000);
  static const Color divider = Color(0xFFE0E0E0);

  // Status / Utility Colors (optional, for icons or highlights)
  static const Color success = Color(0xFF28A745); // green
  static const Color danger = Color(0xFFE74C3C);  // red
  static const Color info = Color(0xFF3498DB);    // blue
  static const Color warning = Color(0xFFF1C40F); // yellow


  static const Color gradientStart = Color(0xFF1BA7C9);
  static const Color gradientEnd   = Color(0xFF25CAD0);

  // Reusable LinearGradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [gradientStart, gradientEnd],
  );

}

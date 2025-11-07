import 'package:flutter/material.dart';

import '../app_color.dart';
import '../commons.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextStyle? style;
  // final bool isPoppins;

  const AppText(
      this.text, {
        Key? key,
        this.fontSize,
        this.color,
        this.fontWeight,
        this.textAlign = TextAlign.start,
        this.overflow ,
        this.maxLines,
        this.style,
         // this.isPoppins = false,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseStyle = style ??
        TextStyle(
          // fontFamily: isPoppins ? "Poppins" : "Outfit",
          fontSize: fontSize,
          fontWeight:fontWeight,
          color: AppColor.textBlack,
        );

    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: baseStyle.copyWith(
        fontSize: fontSize != null
            ? getSize(fontSize!, isFont: true)
            : (baseStyle.fontSize != null
            ? getSize(baseStyle.fontSize!, isFont: true)
            : getSize(15, isFont: true)),
        color: color ?? baseStyle.color,
        fontWeight: fontWeight,
      ),
    );
  }
}

// class GradientText extends StatelessWidget {
//   final String text;
//   final TextStyle? style;
//   // final Gradient gradient;
//   final bool isPoppins;
//
//   const GradientText(
//       this.text, {
//         super.key,
//         this.style,
//         // this.gradient = AppColor.primaryGradient,
//         this.isPoppins = false,
//       });
//
//   @override
//   Widget build(BuildContext context) {
//     final baseStyle = style ??
//         TextStyle(
//           fontFamily: isPoppins ? "Poppins" : "Outfit",
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         );
//
//     return ShaderMask(
//       shaderCallback: (bounds) {
//         return gradient.createShader(
//           Rect.fromLTWH(0, 0, bounds.width, bounds.height),
//         );
//       },
//       child: Text(
//         text,
//         style: baseStyle.copyWith(color: Colors.white),
//       ),
//     );
//   }
// }

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
  final String? fontFamily;

  const AppText(
      this.text, {
        Key? key,
        this.fontSize,
        this.color,
        this.fontWeight,
        this.textAlign = TextAlign.start,
        this.overflow,
        this.maxLines,
        this.style,
        this.fontFamily,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseStyle = style ??
        TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          color: AppColor.textBlack,
        );

    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: baseStyle.copyWith(
        fontFamily: fontFamily ?? baseStyle.fontFamily,
        fontSize: fontSize != null
            ? getSize(fontSize!, isFont: true)
            : (baseStyle.fontSize != null
            ? getSize(baseStyle.fontSize!, isFont: true)
            : getSize(15, isFont: true)),
        color: color ?? baseStyle.color,
        fontWeight: fontWeight ?? baseStyle.fontWeight,
      ),
    );
  }
}

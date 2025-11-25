import 'package:flutter/material.dart';

import '../app_color.dart';
import 'app_text.dart';

class OutlineWhiteButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Widget? icon;
  final double height;
  final double width;
  final double radius;
  final Color? textColor;
  final Color? borderColor;

  const OutlineWhiteButton({
    super.key,
    required this.text,
    required this.onTap,
    this.icon,
    this.height = 55,
    this.width = double.infinity,
    this.radius = 100,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColor.textWhite,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: 8),
              ],
              AppText(
                text,
                style: TextStyle(
                  color: textColor ?? AppColor.textBlack,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

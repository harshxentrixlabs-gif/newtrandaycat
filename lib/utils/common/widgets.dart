import 'package:flutter/material.dart';
import '../app_color.dart';
import '../common_font.dart';
import 'app_image.dart';
import 'app_text.dart';

class OutlineWhiteButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Widget? icon;
  final double height;
  final double width;
  final double radius;
  final Color? textColor;
  final Color? borderColor;
  final String? image;

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
    this.image,
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
          border: Border.all(color: borderColor ?? Colors.grey),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null) ...[
              AppImage.svg(image!, height: 22, width: 22),
              const SizedBox(width: 8),
            ],
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 8),
            ],

            MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: MediaQuery.of(context)
                    .textScaleFactor
                    .clamp(1.0, 1.1),
              ),
              child: Center(
                child: AppText(
                  text,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: AppFont.semiBold,
                    color: textColor ?? AppColor.textBlack,
                  ),
                ),
              ),
            ),
          ],
        ),


      ),
    );
  }
}

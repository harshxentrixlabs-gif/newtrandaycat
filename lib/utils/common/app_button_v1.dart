import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../app_color.dart';
import 'app_text.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool isLoading;
  final double radius;
  final Color? color;
  final Color? textColor;
  final String? image;

  const CommonButton({
    super.key,
    required this.title,
    this.onTap,
    this.isLoading = false,
    this.radius = 20,
    this.color,
    this.textColor,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: isLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: color ?? AppColor.primary,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: isLoading
            ? SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              textColor ?? AppColor.textWhite,
            ),
          ),
        )
            : Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: image != null ? 35 : 15,
              ),
              child: AppText(
                title,
                color: textColor ?? AppColor.textWhite,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
            ),
            if (image != null)
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    color: AppColor.textWhite.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SvgPicture.asset(
                      image!,
                      height: 20,
                      width: 20,
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

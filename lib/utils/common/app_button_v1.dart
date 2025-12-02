import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../app_color.dart';
import '../common_font.dart';
import 'app_loader.dart';
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
    this.radius = 100,
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
                child: AppLoaderWidget(
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
                     fontFamily: AppFont.bold,
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

class CommonBlackButton extends StatelessWidget {
  const CommonBlackButton({
    super.key,
    required this.title,
    this.onTap,
    this.isLoading = false,
    this.radius = 100,
    this.color,
    this.textColor,
    this.image,
  });

  final String title;
  final VoidCallback? onTap;
  final bool isLoading;
  final double radius;
  final Color? color;
  final Color? textColor;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: isLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: color ?? Colors.black,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
            height: 22,
            width: 22,
            child: AppLoaderWidget(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                textColor ?? AppColor.textWhite,
              ),
            ),
          )
              : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image NEXT to Title

              AppText(
                title,
                color: textColor ?? AppColor.textWhite,
                fontFamily: AppFont.semiBold,
                textAlign: TextAlign.center,
              ),
              SizedBox(width: 10,),
              if (image != null) ...[
                SvgPicture.asset(
                  image!,
                  height: 15,
                  width: 15,
                ),
                const SizedBox(width: 8),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

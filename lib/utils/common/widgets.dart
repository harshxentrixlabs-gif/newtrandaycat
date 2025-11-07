import 'package:flutter/material.dart';
import '../app_color.dart';
import 'app_text.dart';


/// 🌈 Common Background (gradient for full screen)
class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white
        // gradient: LinearGradient(
        //   colors: [
        //     Color(0xFFFFC1E3), Color(0xFFD7B0FF)
        //   ],
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        // ),
      ),
      child: SafeArea(child: child),
    );
  }
}

/// 🔘 Gradient Button
// class GradientButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onTap;
//   final double height;
//   final double width;
//   final double radius;
//   final Widget? icon;
//   final TextStyle? textStyle;
//
//   const GradientButton({
//     super.key,
//     required this.text,
//     required this.onTap,
//     this.height = 55,
//     this.width = double.infinity,
//     this.radius = 30,
//     this.icon,
//     this.textStyle,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(radius),
//       child: Container(
//         height: height,
//         width: width,
//         decoration: BoxDecoration(
//           gradient: AppColor.primaryGradient,
//           borderRadius: BorderRadius.circular(radius),
//         ),
//         child: Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               if (icon != null) ...[
//                 icon!,
//                 const SizedBox(width: 8),
//               ],
//               AppText(
//                 text,
//                 style: textStyle ??
//                     const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

/// ⚪ White Button (Google button style)
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
    this.radius = 20,
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
          border: Border.all(color: borderColor ?? AppColor.primary),
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
              Expanded(
                child: Center(
                  child: AppText(
                    text,
                    style: TextStyle(
                      color: textColor ?? AppColor.textBlack,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

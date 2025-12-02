import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trendycart/utils/common_font.dart';

import '../app_color.dart';
import 'app_text.dart';

/// 🔤 Common TextField
class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? title;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? minLines;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;

  const CommonTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.title,
    this.maxLines = 1,
    this.minLines,
    this.obscureText = false,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,  this.validator, this.prefixIcon,

  });

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(title != null && title!.isNotEmpty)...[
          AppText(
            title!,
            style: const TextStyle(
              color: AppColor.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 4,)
        ],
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                spreadRadius: 0,
                blurRadius: 8,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            maxLines: maxLines,
            minLines: minLines,
            readOnly: readOnly,
            onTap: onTap,
            cursorColor: Colors.black,
            inputFormatters: keyboardType == TextInputType.number
                ? [FilteringTextInputFormatter.digitsOnly]
                : [],

            style: const TextStyle(
              color: AppColor.textBlack,
              fontSize: 14,
            ),
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle:  TextStyle(color: AppColor.textSecondary,fontSize: 13,fontFamily: AppFont.semiBold),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              filled: true,
              fillColor: AppColor.background,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide.none
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide.none


              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide.none
                      
              ),
            ),
          ),
        ),
      ],
    );
  }
  //TextField(
//       controller: controller,
//       keyboardType: keyboardType,
//       obscureText: obscureText,
//       maxLines: maxLines,
//       readOnly: readOnly,
//       onTap: onTap,
//       cursorColor: Colors.black,
//       style: const TextStyle(
//         color: AppColor.textBlack,
//         fontSize: 15,
//       ),
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: const TextStyle(color: AppColor.textGrey),
//         suffixIcon: suffixIcon,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         filled: true,
//         fillColor: AppColor.textFieldBg,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30),
//           borderSide: BorderSide.none, // 🚫 No border
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     )
}


// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import '../app_color.dart';
//
//
// class CommonTextField extends StatelessWidget {
//   final String hintText;
//   final TextEditingController? controller;
//   final TextInputType keyboardType;
//   final bool readOnly;
//   final VoidCallback? onTap;
//   final List<TextInputFormatter>? inputFormatters;
//   final double borderRadius;
//   final double verticalPadding;
//   final double horizontalPadding;
//   final bool obscureText;
//   final Color textColor;
//   final Color? fillColor;
//   final Color? enabledBorderColor;
//   final void Function(String)? onChanged;
//   final int? maxLength;
//
//   const CommonTextField({
//     super.key,
//     required this.hintText,
//     this.controller,
//     this.keyboardType = TextInputType.text,
//     this.readOnly = false,
//     this.onTap,
//     this.inputFormatters,
//     this.enabledBorderColor,
//     this.fillColor,
//     this.borderRadius = 30,
//     this.verticalPadding = 14,
//     this.horizontalPadding = 16,
//     this.obscureText = false,
//     this.onChanged,
//     this.maxLength,
//     this.textColor = AppColor.textWhite,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       readOnly: readOnly,
//       onTap: onTap,cursorColor: enabledBorderColor,
//       keyboardType: keyboardType,
//       inputFormatters: inputFormatters,
//       obscureText: obscureText,
//       style: const TextStyle(
//         color: AppColor.textWhite,
//         fontSize: 16,
//         fontWeight: FontWeight.w500,
//       ),
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: TextStyle(
//           color: textColor,
//           fontSize: 16,
//         ),
//         filled: true,
//         fillColor: fillColor ?? AppColor.black,
//         contentPadding: EdgeInsets.symmetric(
//           vertical: verticalPadding,
//           horizontal: horizontalPadding,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: enabledBorderColor ?? AppColor.yellow, width: 1.5),
//           borderRadius: BorderRadius.circular(borderRadius),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: enabledBorderColor ?? AppColor.yellow, width: 1.5),
//           borderRadius: BorderRadius.circular(borderRadius),
//         ),
//       ),
//       onChanged: onChanged,
//       maxLength: maxLength,
//     );
//   }
// }

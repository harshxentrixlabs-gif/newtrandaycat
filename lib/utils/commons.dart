
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../service/api_config.dart';
import '../service/api_service.dart';
import 'app_color.dart';
import 'app_print.dart';
import 'common/app_text.dart';
import 'common_font.dart';

double getSize(double value, {bool isHeight = false, bool isFont = false}) {
  if (isFont) {
    return (Get.width / 375.0) * value; // font base on width
  } else if (isHeight) {
    return (Get.height / 812.0) * value; // height responsive
  } else {
    return (Get.width / 375.0) * value; // width responsive
  }
}


  appPrint(message){
  Text(message);
}


String getImageUrl(String? path) {
  if (path == null || path.isEmpty) {
    return "https://t3.ftcdn.net/jpg/06/43/97/08/360_F_643970869_qYWnzzuznbMO7TaymQirwMnQ5fiQHZbu.jpg"; // 🔗 fallback image
  }

  String cleanPath = path.trim();

// agar path already http thi start thay to direct return kari de
  if (cleanPath.startsWith("http")) {
    return cleanPath;
  }

// Agar path ma starting ma `/` hoy to remove kari de
  if (cleanPath.startsWith("/")) {
    cleanPath = cleanPath.substring(1);
  }

  return "${ApiConfig.apiUrl}/$cleanPath";
}


// class UrlGenerator {
//
//   /// Get Uploaded File URL
//   static Future<String?> getUrl(String filePath,
//       {void Function(int, int)? onSendProgress}) async {
//     try {
//       final response = await AppApi.getInstance().uploadFile<Map<String, dynamic>>(
//         ApiConfig.generateUrl,
//         filePath,
//         fieldName: 'image',
//         onSendProgress: (count, total) {
//           if(onSendProgress != null) onSendProgress(count, total);
//         },
//       );
//
//       if (response.success && response.data != null) {
//         final data = response.data!;
//         AppLogs.log("✅ URL generated successfully: ${data['data']}");
//         return data['data'];
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print("❌ Error while generating URL: $e");
//       return null;
//     }
//   }
// }

class AppLaunchData {
  static bool openCallScreen = false;
  static Map<String, dynamic>? callData;
}


class CircularBackground extends StatelessWidget {
  final Widget child;             // center ma je widget pass karvo che
  final double size;              // circle size
  final Color backgroundColor;    // background color
  final EdgeInsets padding;       // inside padding
  final BoxBorder? border;        // optional border
  final List<BoxShadow>? shadow;  // optional shadow

  const CircularBackground({
    Key? key,
    required this.child,
    this.size = 80,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.all(12),
    this.border,
    this.shadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: border,
        boxShadow: shadow,
      ),
      child: Center(child: child),
    );
  }
}

Widget commonTitle(text,{EdgeInsetsGeometry? padding}){
  return Padding(
    padding: padding ??  EdgeInsets.symmetric(horizontal: 13,vertical: 8),
    child: AppText(text,maxLines: 1,color: AppColor.textBlack,fontWeight: FontWeight.w500,fontSize: 14,overflow: TextOverflow.ellipsis,),
  );
}

class AppSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color? inactiveColor;

  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor = const Color(0xFFDB1ECB),
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: Colors.white, // thumb color
      activeTrackColor: activeColor, // background track
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: inactiveColor ?? Colors.grey.shade300,
      trackOutlineColor: WidgetStateColor.transparent,
    );
  }
}
class AppRadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final String? label;

  const AppRadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radio = Radio<T>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: AppColor.primary,
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColor.primary; // selected color
        }
        return Colors.black; // unselected border color
      }),
      visualDensity: VisualDensity.compact,
    );

    if (label == null || label!.isEmpty) {
      return radio;
    }

    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          radio,
          const SizedBox(width: 0),
          Text(
            label!,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: AppFont.semiBold,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}


class GradientBorder extends StatelessWidget {
  final double width;
  final double height;
  final double borderWidth;
  final Widget child;
  final Gradient gradient;
  final double radius;

  const GradientBorder({
    super.key,
    required this.width,
    required this.height,
    required this.borderWidth,
    required this.child,
    required this.gradient,
    this.radius = 100, // default circular
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: gradient,
      ),
      child: Padding(
        padding: EdgeInsets.all(borderWidth),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: ClipOval(child: child),
        ),
      ),
    );
  }
}

String formatCoins(double? coins) {
  if (coins == null) return "0";
  // If it's a whole number, show as int
  if (coins % 1 == 0) {
    return coins.toInt().toString();
  }
  // Otherwise show up to 2 decimals (no unnecessary trailing zeros)
  return coins.toStringAsFixed(2).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
}



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_color.dart';
import '../commons.dart';
import 'app_text.dart';

class AppBottomSheet {
  static void show({
    required String title,
     required Widget content,
  }) {
    Get.bottomSheet(
      SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Title + Close Button
              Stack(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: Get.width,height: 36,
        
                  ),
                  Align(alignment: Alignment.bottomCenter,
                    child: Center(
                      child: AppText(
                        title,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Positioned(top: -5,right: 0,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child:  Icon(Icons.close, color: AppColor.textSecondary),
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 12),
        
              /// Custom Content (Dynamic)
               content,
        
               // SizedBox(height: Get.height * 0.05),
        
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}

// class CommonConfirmBottomSheet extends StatelessWidget {
//   final dynamic icon;
//   final String title;
//   final String description;
//   final VoidCallback onYes;
//   final VoidCallback? onNo;
//
//   const CommonConfirmBottomSheet({
//     super.key,
//     required this.icon,
//     required this.title,
//     this.description = "",
//     required this.onYes,
//     this.onNo,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(bottom: true,
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: const BoxDecoration(
//           color: AppColor.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // 🔹 Icon
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: AppColor.redEB2E2E,
//                 shape: BoxShape.circle,
//               ),
//               child: icon is IconData?Icon(icon, color: Colors.white, size: 35):Icon(icon, color: Colors.white, size: 35),
//             ),
//             const SizedBox(height: 12),
//
//             // 🔹 Title
//             AppText(
//               title,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: AppColor.textBlack,
//               ),
//             ),
//             const SizedBox(height: 6),
//
//             // 🔹 Description
//             if (description.isNotEmpty)
//               AppText(
//                 description,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   color: AppColor.textGrey,
//                 ),
//               ),
//             const SizedBox(height: 20),
//
//             // 🔹 Buttons
//             Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () {
//                       if (onNo != null) {
//                         onNo!();
//                       } else {
//                         Get.back(); // default close
//                       }
//                     },
//                     style: OutlinedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30)),
//                       side: const BorderSide(color: AppColor.colorF2F2F2),
//                     ),
//                     child: const AppText(
//                       "No",
//                       style: TextStyle(color: AppColor.textBlack),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Get.back();
//                       onYes();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30)),
//                       backgroundColor: AppColor.redEB2E2E,
//                     ),
//                     child: const AppText(
//                       "Yes",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CommonInfoBottomSheet extends StatelessWidget {
//   final dynamic icon; // can be IconData or svg path
//   final String title;
//   final String description;
//   final String buttonText;
//   final VoidCallback onPressed;
//   final Widget? extraWidget; // e.g. checkbox
//
//   const CommonInfoBottomSheet({
//     super.key,
//     required this.icon,
//     required this.title,
//     this.description = "",
//     required this.buttonText,
//     required this.onPressed,
//     this.extraWidget,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(bottom: true,
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: const BoxDecoration(
//           color: AppColor.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // 🔹 Icon
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration:  BoxDecoration(
//                 color: AppColor.darkPrimary,
//                 shape: BoxShape.circle,
//               ),
//               child: icon is IconData
//                   ? Icon(icon, color: Colors.white, size: 34)
//                   : Icon(icon, color: Colors.white, size: 35),
//             ),
//             const SizedBox(height: 16),
//
//             // 🔹 Title
//             AppText(isPoppins: true,
//               title,
//               style: const TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w600,
//                 color: AppColor.textBlack,
//               ),
//             ),
//             const SizedBox(height: 6),
//
//             // 🔹 Description
//             if (description.isNotEmpty)
//               AppText(isPoppins: true,
//                 description,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontSize: 13,
//                   color: AppColor.textGrey,
//                 ),
//                 maxLines: 20,
//               ),
//             const SizedBox(height: 16),
//
//             // 🔹 Extra Widget (checkbox or custom)
//             if (extraWidget != null) extraWidget!,
//             if (extraWidget != null) const SizedBox(height: 16),
//
//             // 🔹 Primary Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Get.back();
//                   onPressed();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30)),
//                   backgroundColor: AppColor.darkPrimary,
//                 ),
//                 child: AppText(
//                   buttonText,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 15,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


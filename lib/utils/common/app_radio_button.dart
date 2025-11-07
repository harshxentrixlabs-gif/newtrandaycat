import 'package:flutter/material.dart';

import '../app_color.dart';
import 'app_text.dart';

class GradientRadioButton<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final Function(T?) onChanged;
  final String label;

  const GradientRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // gradient:  AppColor.primaryGradient
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // gradient: LinearGradient(
                    //   colors: [
                    //     AppColor.primary,
                    //     AppColor.secondary,
                    //   ],
                    // ),
                  ),
                ),
              )
                  : null,
            ),
          ),
           SizedBox(width: 8),
          AppText(
            label,
            style: const TextStyle(color: Colors.black, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

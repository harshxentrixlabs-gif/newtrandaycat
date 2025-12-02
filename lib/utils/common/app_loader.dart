import 'package:flutter/material.dart';
import '../../utils/app_color.dart';

class AppLoaderWidget extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final AlwaysStoppedAnimation<Color>? valueColor;

  const AppLoaderWidget({
    Key? key,
    this.size = 40,
    this.strokeWidth = 3,
     this.valueColor, // ✅ Proper required variable
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: valueColor, // ← required variable used here
        ),
      ),
    );
  }
}

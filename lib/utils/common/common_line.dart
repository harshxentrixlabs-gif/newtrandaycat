import 'package:flutter/material.dart';

class CustomLine extends StatelessWidget {
  final double height;
  final List<Color> colors;
  final Alignment begin;
  final Alignment end;
  final double? width;

  const CustomLine({
    Key? key,
    this.height = 1,
    this.width,
    this.colors = const [
      Colors.black,
      Colors.black,
      Colors.black,
    ],
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: begin,
          end: end,
        ),
      ),
    );
  }
}

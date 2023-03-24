import 'package:flutter/material.dart';

class DSize extends StatelessWidget {
  final double width;
  final double height;

  const DSize({required this.height, required this.width, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}

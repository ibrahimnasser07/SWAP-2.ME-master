import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({this.color, this.height, this.width, this.padding, Key? key})
      : super(key: key);
  final double? width;
  final double? height;
  final double? padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 2.0,
      color: color ?? Colors.grey,
      margin: const EdgeInsets.all(6),
    );
  }
}
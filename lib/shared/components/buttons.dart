import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swap_me/shared/styles/theme.dart';

Widget defaultMaterialButton({
  required Function() function,
  required String text,
  double? width,
  double? height,
  double? radius,
  bool isUpperCase = false,
  Color? color,
  Function? onTap,
}) => Container(
      width: width ?? 354,
      height: height ?? 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius ?? 10,
        ),
        color: color,
      ),
      child: MaterialButton(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        height: 22,
        minWidth: 59,
        onPressed: function,
        child: Text(
          textAlign: TextAlign.center,
          isUpperCase ? text.toUpperCase() : text,
          style: GoogleFonts.cairo(
            fontSize: 16,
            color: ThemeApp.secondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

Widget defaultButton({
  Function()? function,
  required Widget widget,
  double? width,
  double? height,
  double? radius,
  bool isUpperCase = false,
  Color? color,
  Function? onTap,
}) => Container(
      width: width ?? 354,
      height: height ?? 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius ?? 10,
        ),
        color: color,
      ),
      child: MaterialButton(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        height: 22,
        minWidth: 59,
        onPressed: function,
        child: widget,
      ),
    );


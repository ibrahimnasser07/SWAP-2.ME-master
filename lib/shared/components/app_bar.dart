import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget secondaryAppBar() => AppBar(
      backgroundColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light),
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 0,
    );

PreferredSizeWidget thirdAppBar() => AppBar(
      backgroundColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light),
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 0,
    );

PreferredSizeWidget primaryAppBar({
  required String title,
  required Function() function,
  required Widget iconData,
  Color? titleColor,
  Color? iconColor,
  double? fontSizeTitle,
  FontWeight? fontWeightTitle,
  List<Widget>? actions,
}) =>
    AppBar(
      backgroundColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
      elevation: 0,
      titleSpacing: 1,
      centerTitle: false,
      leading: IconButton(
        onPressed: () {
          function();
        },
        icon: iconData,
        color: iconColor ?? Colors.black,
      ),
      title: Text(
        title,
        style: GoogleFonts.roboto(
            color: titleColor ?? Colors.black,
            fontSize: fontSizeTitle ?? 20,
            fontWeight: fontWeightTitle ?? FontWeight.w700,
        ),
      ),
      actions: actions,
    );
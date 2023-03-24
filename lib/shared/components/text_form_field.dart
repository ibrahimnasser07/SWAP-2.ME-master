import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swap_me/shared/styles/theme.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField(
      {required this.context,
      required this.controller,
       this.keyboardType,
      this.validate,
      this.maxLines,
      this.hint,
      this.label,
      this.onTap,
      this.onChanged,
      this.onFieldSubmitted,
      this.obscuringCharacter,
      this.style,
      this.color,
      this.borderSideColor,
      this.prefixColor,
      this.styleColor,
      this.focusNode,
      this.isClickable,
      this.isPassword,
      this.decoration,
      this.suffixPressed,
      this.suffix,
      this.maxLength,
      this.read,
      Key? key})
      : super(key: key);
  final BuildContext context;
  final FocusNode? focusNode;
  final Color? color;
  final Color? borderSideColor;
  final Color? styleColor;
  final Color? prefixColor;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validate;
  final String? hint;
  final String? label;
  final Function()? onTap;
  final dynamic onChanged;
  final Function(String)? onFieldSubmitted;
  final bool? isPassword;
  final bool? isClickable;
  final InputDecoration? decoration;
  final IconData? suffix;
  final Function? suffixPressed;
  final TextStyle? style;
  final String? obscuringCharacter;
  final int? maxLength;
  final int? maxLines;
  final bool? read;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: read ?? false,
      textDirection: TextDirection.rtl,
      maxLength: maxLength,
      focusNode: focusNode,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.start,
      style: GoogleFonts.cairo(
        fontStyle: FontStyle.normal,
        color: styleColor ?? ThemeApp.blackPrimary,
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
      maxLines: maxLines ?? 1,
      minLines: 1,
      controller: controller,
      validator: validate,
      obscureText: isPassword ?? false,
      keyboardType: keyboardType,
      autofocus: false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 8, 8, 20),
        fillColor: color,
        filled: true,
        suffixIcon: suffix != null
            ? IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                  color: ThemeApp.greyColor,
                  size: 24,
                ),
              )
            : null,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        hintText: hint,
        hintStyle: GoogleFonts.cairo(
          locale: const Locale('en'),
          color: ThemeApp.greyColor,
          height: 1,
        ),
        labelText: label,
        labelStyle: const TextStyle(
          locale: Locale('en'),
          color: ThemeApp.primaryColor,
          height: 1,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
          borderSide: BorderSide(
            color: borderSideColor ?? ThemeApp.greyColor,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        errorStyle: const TextStyle(color: Colors.red, fontSize: 16),
      ),
    );
  }
}

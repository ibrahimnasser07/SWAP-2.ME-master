import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/theme.dart';

class MyDropdownFormField extends StatelessWidget {
  const MyDropdownFormField({
    Key? key,
    required this.onChanged,
    this.validator,
    required this.hint,
    required this.value,
    required this.items,
  }) : super(key: key);

  final void Function(String?) onChanged;
  final String? Function(String?)? validator;
  final String hint;
  final String? value;
  final List<DropdownMenuItem<String>> items;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String?>(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        hintStyle: GoogleFonts.cairo(
          locale: const Locale('en'),
          color: ThemeApp.greyColor,
          height: 1,
        ),
        labelStyle: const TextStyle(
          locale: Locale('en'),
          color: ThemeApp.primaryColor,
          height: 1,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
          borderSide: BorderSide(
            color: ThemeApp.greyColor,
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
      validator: validator,
      isExpanded: true,
      iconSize: 20,
      hint: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          hint,
          style: GoogleFonts.cairo(
            color: ThemeApp.greyColor,
            height: 1,
            locale: const Locale('en'),
            fontSize: 17,
          ),
        ),
      ),
      icon: const Icon(Icons.keyboard_arrow_down),
      items: items,
      onChanged: onChanged,
      value: value,
    );
  }
}

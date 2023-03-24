import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/styles/theme.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);
  static const String routeName = 'favoritesScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: ThemeApp.primaryColor,
            ),
          ),
        ],
        title: Text(
          "المفضلة",
          style: GoogleFonts.cairo(
            color: ThemeApp.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Center(
          child: Text("لم تقم باضافة اى منتجات الى المفضلة"),
        ),
      ),
    );
  }
}

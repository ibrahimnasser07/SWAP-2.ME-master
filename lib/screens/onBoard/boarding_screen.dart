import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swap_me/screens/SignIn/sign_in_screen.dart';
import 'package:swap_me/screens/SignUp/sign_up_screen.dart';
import 'package:swap_me/shared/components/buttons.dart';
import 'package:swap_me/shared/components/sized_box.dart';
import 'package:swap_me/shared/styles/theme.dart';

class BoardingScreen extends StatelessWidget {
  const BoardingScreen({Key? key}) : super(key: key);
  static const String routeName = 'BoardingScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeApp.backgroundColor,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/Group 33.svg',
              width: double.infinity,
              height: 100,
            ),
            const DSize(height: 46, width: 0),
            Text(
              'مرحبا بكم في قايضني',
              style: Theme.of(context).textTheme.headline3,
            ),
            const DSize(height: 16, width: 0),
            Text(
              'هو تطبيق يمكن من الأشخاص تبادل/ مبادله اغراضهم',
              style: GoogleFonts.cairo(
                color: const Color.fromARGB(255, 152, 150, 150),
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
            const DSize(height: 113, width: 0),
            defaultButton(
              function: () {
                Navigator.pushNamed(context, SignInScreen.routeName);
              },
              widget: Text(
                'تسجيل الدخول',
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ThemeApp.primaryColor,
                ),
              ),
              color: ThemeApp.secondaryColor,
            ),
            const DSize(height: 20, width: 0),
            defaultMaterialButton(
              function: () {
                Navigator.pushNamed(context, SignUpScreen.routeName);
              },
              text: 'انشاء حساب',
              color: ThemeApp.primaryColor,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swap_me/screens/Splash/splash.dart';
import 'package:swap_me/shared/styles/theme.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "initial";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeApp.primaryColor,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ThemeApp.primaryColor,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: AnimatedSplashScreen(
        splashIconSize: 200,
        backgroundColor: ThemeApp.primaryColor,
        pageTransitionType: PageTransitionType.rightToLeft,
        splashTransition: SplashTransition.scaleTransition,
        splash: SvgPicture.asset('assets/images/Group 13.svg'),
        nextScreen: const NewScreen(),
        duration: 2000,
        animationDuration: const Duration(seconds: 2),
      ),
    );
  }
}
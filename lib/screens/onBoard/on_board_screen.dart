import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:swap_me/screens/onBoard/boarding_screen.dart';
import 'package:swap_me/shared/components/sized_box.dart';
import 'package:swap_me/shared/network/cache_helper.dart';
import 'package:swap_me/shared/styles/theme.dart';

class BoardingModel {
  final String image;
  final String imageTitle;
  final String? body;
  final String title;

  BoardingModel({
    required this.image,
    required this.imageTitle,
    this.body,
    required this.title,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  static const String routeName = 'onboard';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/Group 30.svg',
      imageTitle: 'assets/images/Group 16.svg',
      title: 'هو تطبيق  للأشخاص الذين يرغبون في إعطاء',
      body: ' أو مبادلة أغراضهم',
    ),
    BoardingModel(
      image: 'assets/images/Group 34.svg',
      imageTitle: 'assets/images/Group 23.svg',
      title: 'من بين كل الأشياء التي لا تحتاجها',
    ),
    BoardingModel(
      image: 'assets/images/Group 24.svg',
      imageTitle: 'assets/images/Group 26.svg',
      title: 'وقم التواصل مع المقايض',
    ),
    BoardingModel(
      image: 'assets/images/Group 27.svg',
      imageTitle: 'assets/images/Group 28.svg',
      title: ' عرض وتبادل ما لا تحتاجه',
    ),
  ];
  bool isLast = false;

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        Navigator.of(context).pushReplacementNamed(
          BoardingScreen.routeName,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: TextButton(
          onPressed: () {
            submit();
          },
          child: Text(
            isLast ? '' : 'تخطي',
            textDirection: TextDirection.ltr,
            style: GoogleFonts.cairo(
              color: ThemeApp.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),

            // style: TextStyle(

            // ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              onPageChanged: (int index) {
                if (index == boarding.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
              controller: pageController,
              itemBuilder: (context, index) =>
                  buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
            ),
          ),
          const DSize(height: 35, width: 0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SmoothPageIndicator(
                textDirection: TextDirection.ltr,
                controller: pageController,
                count: boarding.length,
                effect: const ExpandingDotsEffect(
                  dotWidth: 10.0,
                  dotHeight: 10.0,
                  dotColor: Color.fromARGB(255, 189, 211, 208),
                  activeDotColor: ThemeApp.primaryColor,
                  radius: 20.0,
                  spacing: 6,
                  expansionFactor: 1.01,
                ),
              ),
              const DSize(height: 40, width: 0),
              isLast
                  ? SizedBox(
                      width: 354,
                      height: 44,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeApp.primaryColor,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, BoardingScreen.routeName);
                        },
                        child: Text(
                          'ابدأ',
                          style: GoogleFonts.cairo(
                            fontSize: 18,
                          ),
                        ),
                      ),
              )
                  : Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                        ),
                        child: Text(
                          'التالي',
                          style: GoogleFonts.cairo(
                            color: ThemeApp.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          if (isLast) {
                            submit();
                          } else {
                            pageController.nextPage(
                              duration: const Duration(
                                milliseconds: 780,
                              ),
                              curve: Curves.bounceInOut,
                            );
                          }
                        },
                      ),
                    ),
              const DSize(height: 40, width: 0),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 400,
              child: SvgPicture.asset(model.image),
            ),
            SizedBox(
              height: 75,
              child: SvgPicture.asset(model.imageTitle),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  model.title,
                  style: GoogleFonts.cairo(
                    fontSize: 19,
                    color: const Color.fromARGB(255, 152, 150, 150),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  model.body ?? '',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(
                    fontSize: 19,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 152, 150, 150),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}

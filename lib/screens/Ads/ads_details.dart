import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swap_me/model/arg_model.dart';
import 'package:swap_me/screens/Ads/image_details.dart';
import 'package:swap_me/screens/Ads/trade_now.dart';
import 'package:swap_me/shared/components/buttons.dart';
import 'package:swap_me/shared/components/my_divider.dart';
import 'package:swap_me/shared/components/sized_box.dart';
import 'package:swap_me/shared/constants/constants.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_cubit.dart';
import 'package:swap_me/shared/styles/theme.dart';

class AdsDetails extends StatelessWidget {
  const AdsDetails({Key? key}) : super(key: key);
  static const String routeName = 'AdsDetails';

  @override
  Widget build(BuildContext context) {
    ScreenArgs screenArgs =
        ModalRoute.of(context)!.settings.arguments as ScreenArgs;
    return SafeArea(
      child: Scaffold(
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  CarouselSlider(
                                    items: List.generate(
                                      3,
                                      (index) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              ImageDetails.routeName,
                                              arguments: ScreenArgs(
                                                adsModel: screenArgs.adsModel,
                                                productModel:
                                                    screenArgs.productModel,
                                                categoryMainModel: screenArgs
                                                    .categoryMainModel,
                                              ),
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              screenArgs.adsModel.image,
                                              width: 105,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    options: CarouselOptions(
                                      height: 280,
                                      enlargeCenterPage: false,
                                      disableCenter: true,
                                      viewportFraction: 0.7,
                                      autoPlay: true,
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 190),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'التفاصيل الرئيسيه',
                                      style: GoogleFonts.cairo(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: ThemeApp.primaryColor,
                                      ),
                                    ),
                                    const DSize(height: 12, width: 0),
                                    Row(
                                      children: [
                                        Text(
                                          'القسم',
                                          style: GoogleFonts.cairo(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: ThemeApp.greyColor,
                                          ),
                                        ),
                                        const DSize(height: 0, width: 50),
                                        Text(
                                          screenArgs.adsModel.productName,
                                          style: GoogleFonts.cairo(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: ThemeApp.primaryColor,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const MyDivider(),
                                    Row(
                                      children: [
                                        Text(
                                          'القسم الفرعي',
                                          style: GoogleFonts.cairo(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: ThemeApp.greyColor,
                                          ),
                                        ),
                                        const DSize(height: 0, width: 40),
                                        Text(
                                          screenArgs.adsModel.categoryName,
                                          style: GoogleFonts.cairo(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: ThemeApp.primaryColor,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const MyDivider(
                                      padding: 6,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          'الوصف',
                                          style: GoogleFonts.cairo(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: ThemeApp.greyColor,
                                          ),
                                        ),
                                        const DSize(height: 2, width: 0),
                                        Text(
                                          screenArgs.adsModel.desc,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.cairo(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: ThemeApp.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            // top: 391,
                            top: 228,
                            left: 18,
                            right: 18,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              height: 240,
                              width: 392,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: ThemeApp.primaryColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 47,
                                    height: 27,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.remove_red_eye_outlined,
                                          color: ThemeApp.greyColor,
                                        ),
                                        const DSize(height: 0, width: 5),
                                        Text(
                                          '5',
                                          style: GoogleFonts.cairo(
                                            fontSize: 12,
                                            color: ThemeApp.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          screenArgs.adsModel.name,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.cairo(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: ThemeApp.secondaryColor,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.watch_later_outlined,
                                              color: ThemeApp.secondaryColor,
                                            ),
                                            const DSize(height: 0, width: 5),
                                            Text(
                                              'منذ ${daysBetween(
                                                DateTime.parse(
                                                  screenArgs.adsModel.dateTime
                                                      .toString(),
                                                ),
                                              )}',
                                              style: GoogleFonts.cairo(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: ThemeApp.secondaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const MyDivider(),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/images/Group 517.svg'),
                                      const DSize(height: 0, width: 30),
                                      FutureBuilder(
                                          future: SwapCubit.get(context)
                                              .getName(
                                              screenArgs.adsModel.iD),
                                          builder: (context, snapshot) {
                                          return Text(
                                            snapshot.data ?? "",
                                            style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: ThemeApp.secondaryColor,
                                            ),
                                          );
                                        }
                                      ),
                                      const DSize(height: 0, width: 23),
                                      const MyDivider(
                                        width: 1,
                                        height: 30,
                                      ),
                                      const DSize(height: 0, width: 23),
                                      FutureBuilder(
                                          future: SwapCubit.get(context)
                                              .getPhone(
                                              screenArgs.adsModel.iD),
                                          builder: (context, snapshot) {
                                          return Text(
                                            snapshot.data ?? "01111111111",
                                            style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              color: ThemeApp.secondaryColor,
                                            ),
                                          );
                                        }
                                      ),
                                    ],
                                  ),
                                  const MyDivider(),

                                  /// fix here
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.locationDot,
                                          color: ThemeApp.secondaryColor,
                                        ),
                                        const DSize(height: 0, width: 30),
                                        FutureBuilder(
                                            future: SwapCubit.get(context)
                                                .getAddress(
                                                    screenArgs.adsModel.iD),
                                            builder: (context, snapshot) {
                                              return Text(
                                                snapshot.data ?? "مصر, القاهرة",
                                                style: GoogleFonts.cairo(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color:
                                                      ThemeApp.secondaryColor,
                                                ),
                                              );
                                            }),
                                        const DSize(height: 0, width: 23),
                                        const MyDivider(
                                          width: 1,
                                          height: 30,
                                        ),
                                        const DSize(height: 0, width: 23),
                                        const Icon(
                                          Icons.star,
                                          color: ThemeApp.secondaryColor,
                                        ),
                                        const DSize(height: 0, width: 8),
                                        Text(
                                          'تقييم (0.0)',
                                          style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: ThemeApp.secondaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            // top: 391,
                            top: 10,
                            left: 10,

                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: ThemeApp.primaryColor,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // top: 391,
                            top: 180,
                            left: 180,

                            child: Container(
                              margin: const EdgeInsets.all(8),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.camera_alt,
                                    color: ThemeApp.primaryColor,
                                  ),
                                  Text('1/2')
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            // top: 391,
                            top: 10,
                            right: 10,
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.more_vert_sharp,
                                      color: ThemeApp.primaryColor,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.favorite_border,
                                      color: ThemeApp.primaryColor,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.share_sharp,
                                      color: ThemeApp.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
              SizedBox(
                height: 60,
                child: Center(
                  child: defaultButton(
                    function: () {
                      Navigator.pushNamed(
                        context,
                        TradeNowScreen.routeName,
                        arguments: screenArgs,
                      );
                    },
                    widget: Text(
                      'مقايضه',
                      style: GoogleFonts.cairo(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: ThemeApp.secondaryColor,
                      ),
                    ),
                    color: ThemeApp.primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

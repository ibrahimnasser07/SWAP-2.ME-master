import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/arg_model.dart';
import '../../shared/components/buttons.dart';
import '../../shared/components/my_divider.dart';
import '../../shared/components/sized_box.dart';
import '../../shared/cubit/swapCubit/swap_cubit.dart';
import '../../shared/cubit/swapCubit/swap_state.dart';
import '../../shared/styles/theme.dart';
import 'confirm_trade.dart';

class TradeNowScreen extends StatelessWidget {
  const TradeNowScreen({Key? key}) : super(key: key);
  static const String routeName = 'TradeNowScreen';

  @override
  Widget build(BuildContext context) {
    ScreenArgs screenArgs =
        ModalRoute.of(context)!.settings.arguments as ScreenArgs;
    return BlocConsumer<SwapCubit, SwapStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SwapCubit swapCubit = SwapCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
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
              "مقايضة الان",
              style: GoogleFonts.cairo(
                color: ThemeApp.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: FutureBuilder(
                            future: swapCubit.getImage(screenArgs.adsModel.iD),
                            builder: (context, snapshot) {
                              return CachedNetworkImage(
                                imageUrl: snapshot.hasData
                                    ? snapshot.data!
                                    : "https://i.pinimg.com/originals/10/b2/f6/"
                                        "10b2f6d95195994fca386842dae53bb2.png",
                                height: 60,
                                width: 60,
                              );
                            }),
                        title: FutureBuilder(
                          future: swapCubit.getName(screenArgs.adsModel.iD),
                          builder: (context, snapshot) {
                            return Text(snapshot.hasData ? snapshot.data! : "");
                          },
                        ),
                        subtitle: FutureBuilder(
                          future: swapCubit.getAddress(screenArgs.adsModel.iD),
                          builder: (context, snapshot) {
                            return Text(snapshot.hasData
                                ? snapshot.data!
                                : 'مصر, القاهرة');
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'المقايضة',
                                  style: GoogleFonts.cairo(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: ThemeApp.greyColor,
                                  ),
                                ),
                                const DSize(height: 0, width: 40),
                                Text(
                                  screenArgs.adsModel.name,
                                  style: GoogleFonts.cairo(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: ThemeApp.primaryColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                            const MyDivider(),
                            // القسم
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
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        endIndent: 8,
                        indent: 20,
                        color: Colors.grey,
                        height: 2,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/images/Group 33.svg',
                      width: 20,
                      height: 35,
                    ),
                    const Expanded(
                      child: Divider(
                        endIndent: 20,
                        indent: 8,
                        color: Colors.grey,
                        height: 2,
                      ),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                defaultButton(
                  function: () {
                    Navigator.pushNamed(
                      context,
                      ConfirmTradeScreen.routeName,
                      arguments: screenArgs,
                    );
                  },
                  widget: Text(
                    'اختر عنصر المقايضة',
                    style: GoogleFonts.cairo(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: ThemeApp.secondaryColor,
                    ),
                  ),
                  color: ThemeApp.primaryColor,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

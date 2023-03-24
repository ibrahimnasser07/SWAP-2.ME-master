import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swap_me/screens/Ads/select_ad_item.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/arg_model.dart';
import '../../shared/components/buttons.dart';
import '../../shared/components/sized_box.dart';
import '../../shared/cubit/swapCubit/swap_cubit.dart';
import '../../shared/cubit/swapCubit/swap_state.dart';
import '../../shared/styles/theme.dart';

class ConfirmTradeScreen extends StatefulWidget {
  const ConfirmTradeScreen({Key? key}) : super(key: key);
  static const String routeName = 'ConfirmTrade';

  @override
  State<ConfirmTradeScreen> createState() => _ConfirmTradeScreenState();
}

class _ConfirmTradeScreenState extends State<ConfirmTradeScreen> {
  late ScreenArgs screenArgs;
  late SwapCubit swapCubit;

  bool _initialized = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      screenArgs = ModalRoute.of(context)!.settings.arguments as ScreenArgs;
      swapCubit = SwapCubit.get(context);
      setState(() => _initialized = true);
    });
    super.initState();
  }

  @override
  void dispose() {
    swapCubit.resetSelectedId();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return Container();
    }
    return BlocConsumer<SwapCubit, SwapStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
              "اختر عنصر المقايضة",
              style: GoogleFonts.cairo(
                color: ThemeApp.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return SelectAdItem(
                            adsModel: swapCubit.userAds[index],
                          );
                        },
                        separatorBuilder: (context, _) {
                          return const DSize(height: 20, width: 0);
                        },
                        itemCount: swapCubit.userAds.length,
                      ),
                    ),
                    const DSize(height: 60, width: 0),
                  ],
                ),
                SizedBox(
                  height: 60,
                  child: Center(
                    child: defaultButton(
                      function: swapCubit.selectedId == "None"
                          ? null
                          : () async {
                              String telephoneNumber = await swapCubit
                                  .getPhone(screenArgs.adsModel.iD);
                              Uri telephoneUri = Uri(
                                scheme: "tel",
                                path: telephoneNumber,
                              );
                              launchUrl(telephoneUri);
                            },
                      widget: Text(
                        'قايض الان',
                        style: GoogleFonts.cairo(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: ThemeApp.secondaryColor,
                        ),
                      ),
                      color: swapCubit.selectedId == "None"
                          ? Theme.of(context).disabledColor
                          : ThemeApp.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

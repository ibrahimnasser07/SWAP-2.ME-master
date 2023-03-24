import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swap_me/shared/components/sized_box.dart';
import 'package:swap_me/shared/constants/constants.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_cubit.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_state.dart';
import 'package:swap_me/shared/styles/theme.dart';

import '../../shared/components/my_ad_item.dart';

class MyAdsScreen extends StatelessWidget {
  const MyAdsScreen({Key? key}) : super(key: key);
  static const String routeName = 'MyAdsScreen';

  @override
  Widget build(BuildContext context) {
    var cubit = SwapCubit.get(context)..getMyAdsData(uId);
    return BlocConsumer<SwapCubit, SwapStates>(
      listener: (context, state) {
        if (state is DeletedAdSuccessState) {
          cubit.getMyAdsData(uId);
        } else if (state is CreateAdsSuccessState) {
          cubit.getMyAdsData(uId);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'الإعلانات :',
                    style: GoogleFonts.cairo(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: ThemeApp.primaryColor,
                    ),
                  ),
                  const DSize(height: 0, width: 10),
                  Text(
                    '${cubit.userAds.length}',
                    style: GoogleFonts.cairo(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: ThemeApp.primaryColor,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: cubit.userAds.length,
                  separatorBuilder: (context, index) =>
                      const DSize(height: 10, width: 0),
                  itemBuilder: (context, index) => MyAdItem(
                    adsModel: cubit.userAds[index],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

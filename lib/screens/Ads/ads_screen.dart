import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swap_me/model/arg_model.dart';
import 'package:swap_me/model/category_model.dart';
import 'package:swap_me/model/product_model.dart';
import 'package:swap_me/shared/components/sized_box.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_cubit.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_state.dart';
import 'package:swap_me/shared/styles/theme.dart';

import '../../shared/components/ad_item.dart';

class AdsScreen extends StatelessWidget {
  const AdsScreen({Key? key}) : super(key: key);
  static const String routeName = 'AdsScreen';

  @override
  Widget build(BuildContext context) {
    ScreenArgs screenArgs =
        ModalRoute.of(context)!.settings.arguments as ScreenArgs;
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
              screenArgs.productModel!.name,
              style: GoogleFonts.cairo(
                color: ThemeApp.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          body: LIstAds(
            screenArgs.categoryMainModel,
            screenArgs.productModel!,
          ),
        );
      },
    );
  }
}

class LIstAds extends StatelessWidget {
  const LIstAds(
    this.categoryMainModel,
    this.productModel, {
    Key? key,
  }) : super(key: key);

  final CategoryMainModel categoryMainModel;
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwapCubit, SwapStates>(
      builder: (context, state) {
        SwapCubit cubit = SwapCubit.get(context);
        return ListView.separated(
          itemBuilder: (context, index) {
            return AdItem(
              categoryMainModel,
              productModel,
              adsModel: cubit.categoryAdsList[index],
            );
          },
          separatorBuilder: (context, _) {
            return const DSize(height: 5, width: 0);
          },
          itemCount: cubit.categoryAdsList.length,
        );
      },
    );
  }
}

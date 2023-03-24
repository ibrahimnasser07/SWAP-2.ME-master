import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swap_me/model/ads_model.dart';
import 'package:swap_me/model/arg_model.dart';
import 'package:swap_me/model/category_model.dart';
import 'package:swap_me/screens/Ads/add_ads.dart';
import 'package:swap_me/shared/components/buttons.dart';
import 'package:swap_me/shared/components/sized_box.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_cubit.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_state.dart';
import 'package:swap_me/shared/styles/theme.dart';

import '../../shared/components/product.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = 'ProductScreen';

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
              screenArgs.categoryMainModel.name,
              style: GoogleFonts.cairo(
                color: ThemeApp.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                NewList(
                  categoryMainModel: screenArgs.categoryMainModel,
                  screenArgs.adsModel,
                ),
                defaultButton(
                  function: () {
                    SwapCubit.get(context).getDataPro();
                    Navigator.pushNamed(context, AddAds.routeName);
                  },
                  widget: Text(
                    'اضف اعلان',
                    style: GoogleFonts.cairo(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: ThemeApp.secondaryColor,
                    ),
                  ),
                  color: ThemeApp.primaryColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class NewList extends StatelessWidget {
  const NewList(
    this.adsModel, {
    Key? key,
    required this.categoryMainModel,
  }) : super(key: key);

  final CategoryMainModel categoryMainModel;
  final AdsModel adsModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwapCubit, SwapStates>(
      builder: (context, state) {
        SwapCubit cubit = SwapCubit.get(context);
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Product(
                    categoryMainModel,
                    adsModel,
                    productModel: cubit.productsList[index],
                  );
                },
                separatorBuilder: (context, _) {
                  return const DSize(height: 20, width: 0);
                },
                itemCount: cubit.productsList.length,
              ),
            ),
            const DSize(height: 60, width: 0),
          ],
        );
      },
    );
  }
}

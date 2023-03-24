import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swap_me/model/ads_model.dart';
import 'package:swap_me/model/category_model.dart';
import 'package:swap_me/shared/components/sized_box.dart';

import '../../model/arg_model.dart';
import '../../model/product_model.dart';
import '../../screens/Ads/ads_screen.dart';
import '../cubit/swapCubit/swap_cubit.dart';
import '../cubit/swapCubit/swap_state.dart';
import '../styles/theme.dart';

class Product extends StatelessWidget {
  const Product(
      this.categoryMainModel,
      this.adsModel, {
        Key? key,
        required this.productModel,
      }) : super(key: key);

  final ProductModel productModel;
  final CategoryMainModel categoryMainModel;
  final AdsModel adsModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwapCubit, SwapStates>(
      builder: (context, state) {
        var cubit = SwapCubit.get(context);
        return InkWell(
          onTap: () {
            cubit.getADSData(
              adsModel.categoryName = productModel.name,
            );
            Navigator.pushNamed(
              context,
              AdsScreen.routeName,
              arguments: ScreenArgs(
                productModel: productModel,
                categoryMainModel: categoryMainModel,
                adsModel: adsModel,
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            width: double.infinity,
            height: 90,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (productModel.image.isEmpty)
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60,
                    child: Icon(FontAwesomeIcons.info),
                  ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 60,
                  child: Image.network(productModel.image),
                ),
                const DSize(height: 0, width: 60),
                Text(
                  productModel.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: ThemeApp.primaryColor,
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
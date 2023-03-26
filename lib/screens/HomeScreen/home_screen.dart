import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swap_me/model/ads_model.dart';
import 'package:swap_me/model/arg_model.dart';
import 'package:swap_me/model/category_model.dart';
import 'package:swap_me/screens/Product/product_screen.dart';
import 'package:swap_me/shared/components/sized_box.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_cubit.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_state.dart';
import 'package:swap_me/shared/styles/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SwapCubit, SwapStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SwapCubit.get(context);
        return Column(
          children: [
            Expanded(
              child:
                  buildCategoryItem(context, cubit.adsModel!),
            ),
          ],
        );
      },
    );
  }

  Widget buildCategoryItem(
      BuildContext context, AdsModel adsModel) {
    var cubit = SwapCubit.get(context);
    return ListView.separated(
      itemBuilder: (context, index) {
        return CategoryItem(
          adsModel,
          categoryMainModel: cubit.category[index],
        );
      },
      separatorBuilder: (context, _) {
        return const DSize(height: 20, width: 0);
      },
      itemCount: cubit.category.length,
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem(
    this.adsModel, {
    Key? key,
    required this.categoryMainModel,
  }) : super(key: key);

  final CategoryMainModel categoryMainModel;
  final AdsModel adsModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SwapCubit, SwapStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return InkWell(
          onTap: () {
            SwapCubit.get(context).getProductData(categoryMainModel.cId);
            Navigator.pushNamed(
              context,
              ProductScreen.routeName,
              arguments: ScreenArgs(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (categoryMainModel.image.isEmpty)
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60,
                    child: Icon(FontAwesomeIcons.info),
                  ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 60,
                  child: Image.network(categoryMainModel.image),
                ),
                Text(
                  categoryMainModel.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: ThemeApp.primaryColor,
                      ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
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

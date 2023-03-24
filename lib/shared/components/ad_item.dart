import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swap_me/shared/components/sized_box.dart';

import '../../model/ads_model.dart';
import '../../model/arg_model.dart';
import '../../model/category_model.dart';
import '../../model/product_model.dart';
import '../../screens/Ads/ads_details.dart';
import '../constants/constants.dart';
import '../cubit/swapCubit/swap_cubit.dart';
import '../cubit/swapCubit/swap_state.dart';
import '../styles/theme.dart';
import 'buttons.dart';

class AdItem extends StatelessWidget {
  const AdItem(
    this.categoryMainModel,
    this.productModel, {
    Key? key,
    required this.adsModel,
  }) : super(key: key);

  final ProductModel productModel;
  final CategoryMainModel categoryMainModel;
  final AdsModel adsModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SwapCubit, SwapStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SwapCubit cubit = SwapCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AdsDetails.routeName,
                arguments: ScreenArgs(
                  adsModel: adsModel,
                  productModel: productModel,
                  categoryMainModel: categoryMainModel,
                ),
              );
            },
            child: Column(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              adsModel.image,
                              width: 105,
                              fit: BoxFit.fill,
                              height: 200,
                            )),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                adsModel.name,
                                style: GoogleFonts.cairo(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: ThemeApp.primaryColor,
                                ),
                              ),
                              const DSize(height: 6, width: 0),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.watch_later_outlined,
                                    color: ThemeApp.primaryColor,
                                  ),
                                  const DSize(height: 0, width: 5),
                                  Text(
                                    'منذ ${daysBetween(
                                      DateTime.parse(
                                          adsModel.dateTime.toString()),
                                    )}',
                                    style: GoogleFonts.cairo(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: ThemeApp.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: ThemeApp.primaryColor,
                                  ),
                                  const DSize(height: 0, width: 5),
                                  FutureBuilder(
                                    future: cubit.getAddress(adsModel.iD),
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.hasData ? snapshot.data! : "",
                                        style: GoogleFonts.cairo(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: ThemeApp.primaryColor,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const DSize(height: 5, width: 0),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: defaultButton(
                                        function: () {},
                                        widget: Text(
                                          cubit.userModel!.phone,
                                          style: GoogleFonts.cairo(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: ThemeApp.secondaryColor,
                                          ),
                                        ),
                                        color: ThemeApp.primaryColor,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.favorite_border,
                                        color: ThemeApp.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

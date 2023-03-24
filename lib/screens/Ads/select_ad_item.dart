import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_cubit.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_state.dart';

import '../../model/ads_model.dart';
import '../../shared/components/my_divider.dart';
import '../../shared/components/sized_box.dart';
import '../../shared/styles/theme.dart';

class SelectAdItem extends StatelessWidget {
  const SelectAdItem({Key? key, required this.adsModel}) : super(key: key);

  final AdsModel adsModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwapCubit, SwapStates>(
      builder: (context, state) {
        SwapCubit cubit = SwapCubit.get(context);
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            adsModel.image,
                            width: 105,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
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
                                    ' منذ ساعه',
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const MyDivider(),
                  Row(
                    children: [
                      Radio<String>(
                        value: adsModel.image,
                        groupValue: cubit.state is SwapItemSelectedState
                            ? (cubit.state as SwapItemSelectedState).id
                            : "None",
                        onChanged: (v) => cubit.updateSelectedId(v!),
                      ),
                      const Text("اختر العنصر"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

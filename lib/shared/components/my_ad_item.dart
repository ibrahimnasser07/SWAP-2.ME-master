import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swap_me/screens/Ads/edit_ad.dart';
import 'package:swap_me/shared/components/sized_box.dart';

import '../../model/ads_model.dart';
import '../cubit/swapCubit/swap_cubit.dart';
import '../cubit/swapCubit/swap_state.dart';
import '../styles/theme.dart';
import 'my_divider.dart';

class MyAdItem extends StatelessWidget {
  const MyAdItem({Key? key, required this.adsModel}) : super(key: key);

  final AdsModel adsModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SwapCubit, SwapStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SwapCubit cubit = SwapCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                                          snapshot.hasData
                                              ? snapshot.data!
                                              : "",
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                EditAdScreen.routeName,
                                arguments: adsModel,
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.8,
                              padding: const EdgeInsets.all(2),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color.fromARGB(255, 242, 242, 242),
                              ),
                              child: Column(
                                children: [
                                  const Icon(Icons.edit,
                                      color: ThemeApp.greyColor),
                                  Text(
                                    'تعديل',
                                    style: GoogleFonts.cairo(
                                      color: ThemeApp.greyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.8,
                            padding: const EdgeInsets.all(2),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromARGB(255, 242, 242, 242),
                            ),
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: const Text(
                                          "هل انت متأكد من مسح اعلانك؟"),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey,
                                          ),
                                          child: const Text("إلغاء"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            cubit.deleteAd(
                                              image: adsModel.image,
                                            );
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ThemeApp.primaryColor,
                                          ),
                                          child: const Text("تأكيد"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.delete_forever,
                                    color: Color.fromARGB(255, 234, 53, 73),
                                  ),
                                  Text(
                                    'حذف',
                                    style: GoogleFonts.cairo(
                                      color: const Color.fromARGB(
                                          255, 234, 53, 73),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const MyDivider(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

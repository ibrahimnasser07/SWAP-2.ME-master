import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swap_me/shared/components/buttons.dart';
import 'package:swap_me/shared/components/my_divider.dart';
import 'package:swap_me/shared/components/sized_box.dart';
import 'package:swap_me/shared/components/text_form_field.dart';
import 'package:swap_me/shared/components/toast.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_cubit.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_state.dart';
import 'package:swap_me/shared/styles/theme.dart';

import '../../shared/components/my_drop_down_button.dart';
import '../../shared/constants/constants.dart';

class AddAds extends StatefulWidget {
  const AddAds({Key? key}) : super(key: key);
  static const String routeName = 'AddAds';

  @override
  State<AddAds> createState() => _AddAdsState();
}

class _AddAdsState extends State<AddAds> {
  late SwapCubit cubit;

  @override
  void initState() {
    cubit = SwapCubit.get(context);
    super.initState();
  }

  @override
  void dispose() {
    cubit.resetAddAdsPageValues();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var productController = TextEditingController();
    var descController = TextEditingController();
    return BlocConsumer<SwapCubit, SwapStates>(
      listener: (context, state) {
        if (state is CreateAdsSuccessState) {
          showToast(text: 'تم إنشاء إعلانك بنجاح', state: ToastStates.success);
        }
        if (state is CreateAdsErrorState) {
          showToast(
              text: 'تأكد من مراجعة بعض البيانات', state: ToastStates.error);
        }
      },
      builder: (context, state) {
        File? adsImage = SwapCubit.get(context).adsImagePicked;
        return Stack(
          children: [
            Scaffold(
              backgroundColor: ThemeApp.backgroundColor,
              appBar: AppBar(
                centerTitle: true,
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      cubit.removePostImage();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: ThemeApp.primaryColor,
                    ),
                  ),
                ],
                title: Text(
                  'ضع اعلانك',
                  style: GoogleFonts.cairo(
                    color: ThemeApp.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ادخل بيانات المنتج',
                          style: GoogleFonts.cairo(
                            color: ThemeApp.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const DSize(height: 10, width: 0),
                        Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 147,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              cubit.pickImage();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (adsImage == null)
                                  SvgPicture.asset(
                                      'assets/images/Group 339.svg'),
                                if (adsImage != null)
                                  CircleAvatar(
                                    backgroundImage: FileImage(adsImage),
                                    radius: 45,
                                    backgroundColor: Colors.transparent,
                                  ),
                                Text(
                                  'اضف صوره',
                                  style: GoogleFonts.cairo(
                                    color: ThemeApp.greyColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const DSize(height: 16, width: 0),
                        DefaultTextFormField(
                          color: ThemeApp.secondaryColor.withOpacity(0.3),
                          context: context,
                          controller: productController,
                          keyboardType: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'برجاء إدخال اسم المنتج';
                            }
                            return null;
                          },
                          hint: '  اسم المنتج',
                        ),
                        const DSize(height: 16, width: 0),
                        MyDropdownFormField(
                          hint: 'اختر القسم',
                          value: cubit.tradeProduct,
                          onChanged: (cSelected) {
                            cubit.tradeProduct = cSelected;
                            cubit.clearTradeCategory();
                            cubit.getSelectedCategoryData(cSelected!);
                          },
                          validator: (value) {
                            return value == null ? 'برجاء إدخال القسم' : null;
                          },
                          items: cubit.category.map((e) {
                            return DropdownMenuItem(
                              value: e.name,
                              child: Center(
                                child: Text(
                                  e.name,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const DSize(height: 16, width: 0),
                        MyDropdownFormField(
                          hint: 'اختر الفئه',
                          value: cubit.tradeCategory,
                          onChanged: (newValue) =>
                              cubit.tradeCategory = newValue,
                          validator: (value) {
                            return value == null ? 'برجاء إدخال الفئه' : null;
                          },
                          items: cubit.tradeCategories.map((e) {
                            return DropdownMenuItem(
                              value: e.name,
                              child: Center(
                                child: Text(
                                  e.name,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const DSize(height: 16, width: 0),
                        DefaultTextFormField(
                          maxLines: 4,
                          color: ThemeApp.secondaryColor.withOpacity(0.3),
                          context: context,
                          controller: descController,
                          keyboardType: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'برجاء إدخال الوصف';
                            }
                            return null;
                          },
                          hint: '  الوصف',
                        ),
                        const DSize(height: 16, width: 0),
                        Row(
                          children: [
                            const MyDivider(
                              width: 150,
                            ),
                            SvgPicture.asset(
                              'assets/images/Group 33.svg',
                              width: 20,
                              height: 35,
                            ),
                            const MyDivider(
                              width: 150,
                            ),
                          ],
                        ),
                        Text(
                          'ادخل بيانات منتج المقايضه',
                          style: GoogleFonts.cairo(
                            color: ThemeApp.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const DSize(height: 16, width: 0),
                        MyDropdownFormField(
                          onChanged: (wantedCSelected) {
                            cubit.wantedTradeProduct = wantedCSelected;
                            cubit.clearWantedTradeCategory();
                            cubit.getSelectedCategoryData(
                              wantedCSelected!,
                              wanted: true,
                            );
                          },
                          value: cubit.wantedTradeProduct,
                          hint: 'اختر القسم',
                          items: cubit.category.map((e) {
                            return DropdownMenuItem(
                              value: e.name,
                              child: Center(
                                child: Text(
                                  e.name,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const DSize(height: 16, width: 0),
                        MyDropdownFormField(
                          hint: 'اختر الفئه للمقايضه معه',
                          value: cubit.wantedTradeCategory,
                          onChanged: (newValue) =>
                              cubit.wantedTradeCategory = newValue,
                          items: cubit.wantedTradeCategories.map((e) {
                            return DropdownMenuItem(
                              value: e.name,
                              child: Center(
                                child: Text(
                                  e.name,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const DSize(height: 20, width: 0),
                        defaultButton(
                          function: () {
                            DateTime now = DateTime.now();
                            if (formKey.currentState!.validate()) {
                              if (adsImage != null) {
                                cubit
                                    .uploadAdsImage(
                                  dateTime: now.toString(),
                                  name: productController.text,
                                  desc: descController.text,
                                  categoryName: cubit.tradeCategory,
                                  productName: cubit.tradeProduct,
                                )
                                    .then((_) {
                                  cubit.removePostImage();
                                  cubit.getMyAdsData(uId);
                                  Navigator.pop(context);
                                });
                              } else {
                                showToast(
                                  text: "برجاء إدخال صورة للمنتج",
                                  state: ToastStates.error,
                                );
                              }
                            }
                          },
                          widget: Text(
                            'نشر الاعلان',
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
                ),
              ),
            ),
            if (state is CreateAdsLoadingState)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        );
      },
    );
  }
}

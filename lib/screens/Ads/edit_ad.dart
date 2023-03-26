import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_state.dart';

import '../../model/ads_model.dart';
import '../../shared/components/buttons.dart';
import '../../shared/components/circle_image_with_button.dart';
import '../../shared/components/my_divider.dart';
import '../../shared/components/my_drop_down_button.dart';
import '../../shared/components/sized_box.dart';
import '../../shared/components/text_form_field.dart';
import '../../shared/cubit/swapCubit/swap_cubit.dart';
import '../../shared/styles/theme.dart';

class EditAdScreen extends StatefulWidget {
  const EditAdScreen({Key? key}) : super(key: key);
  static const String routeName = 'EditAdsScreen';

  @override
  State<EditAdScreen> createState() => _EditAdScreenState();
}

class _EditAdScreenState extends State<EditAdScreen> {
  late SwapCubit cubit;
  var formKey = GlobalKey<FormState>();
  late TextEditingController adNameController;
  late TextEditingController descController;

  @override
  void initState() {
    cubit = SwapCubit.get(context);
    super.initState();
  }

  @override
  void dispose() {
    cubit.removePostImage();
    cubit.resetAddAdsPageValues();
    adNameController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AdsModel screenArgs =
        ModalRoute.of(context)!.settings.arguments as AdsModel;
    adNameController = TextEditingController(text: screenArgs.name);
    descController = TextEditingController(text: screenArgs.desc);
    cubit.getSelectedCategoryData(screenArgs.productName);
    return Scaffold(
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
          'تعديل الاعلان',
          style: GoogleFonts.cairo(
            color: ThemeApp.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: BlocBuilder<SwapCubit, SwapStates>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 210,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: ProfileCircleImageWithButton(
                          iconData: Icons.edit_outlined,
                          onPressed: () => cubit.pickImage(),
                          imageUrl: screenArgs.image,
                          buttonColor: Colors.lightBlue,
                        ),
                      ),
                    ),
                    const DSize(height: 16, width: 0),
                    DefaultTextFormField(
                      color: ThemeApp.secondaryColor.withOpacity(0.3),
                      context: context,
                      controller: adNameController,
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
                      value: cubit.tradeProduct ?? screenArgs.productName,
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
                      value: cubit.editCategoryChanged
                          ? cubit.tradeCategory
                          : screenArgs.categoryName,
                      onChanged: (newValue) => cubit.tradeCategory = newValue,
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
                      hint: 'اختر القسم',
                      value: cubit.wantedTradeProduct,
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
                      onChanged: (v) => cubit.wantedTradeCategory = v,
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
                        if (formKey.currentState!.validate()) {
                          cubit
                              .updateAd(
                            AdsModel(
                              image: screenArgs.image,
                              name: adNameController.text,
                              desc: descController.text,
                              iD: screenArgs.iD,
                              dateTime: DateTime.now().toString(),
                              categoryName:
                                  cubit.tradeCategory ?? screenArgs.categoryName,
                              productName:
                                  cubit.tradeProduct ?? screenArgs.productName,
                            ),
                          )
                              .then((value) {
                            cubit.getMyAdsData(screenArgs.iD);
                            Navigator.pop(context);
                          });
                        }
                      },
                      widget: Text(
                        'تعديل الاعلان',
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
          );
        },
      ),
    );
  }
}

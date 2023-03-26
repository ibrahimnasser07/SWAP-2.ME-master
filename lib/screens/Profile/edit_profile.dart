import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/user_model.dart';
import '../../shared/components/buttons.dart';
import '../../shared/components/circle_image_with_button.dart';
import '../../shared/components/my_drop_down_button.dart';
import '../../shared/components/sized_box.dart';
import '../../shared/components/text_form_field.dart';
import '../../shared/cubit/swapCubit/swap_cubit.dart';
import '../../shared/cubit/swapCubit/swap_state.dart';
import '../../shared/styles/theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  static const String routeName = 'editProfileScreen';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late SwapCubit swapCubit;
  late UserModel userModel;
  var formKey = GlobalKey<FormState>();
  late TextEditingController firstnameController;
  late TextEditingController lastnameController;
  late TextEditingController phoneController;
  late TextEditingController governorateController;
  late TextEditingController cityController;
  late TextEditingController areaController;
  late String? genderDropdownValue;
  bool updatingUserData = false;

  @override
  void initState() {
    swapCubit = SwapCubit.get(context);
    userModel = swapCubit.userModel!;
    firstnameController = TextEditingController(text: userModel.firstName);
    lastnameController = TextEditingController(text: userModel.lastName);
    phoneController = TextEditingController(text: userModel.phone);
    governorateController = TextEditingController(text: userModel.governorate);
    cityController = TextEditingController(text: userModel.city);
    areaController = TextEditingController(text: userModel.area);
    genderDropdownValue = null; // set initial value to null
    if (userModel.gender != null &&
        ["ذكر", "انثي"].contains(userModel.gender)) {
      genderDropdownValue = userModel.gender;
    }
    super.initState();
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    phoneController.dispose();
    governorateController.dispose();
    cityController.dispose();
    areaController.dispose();
    swapCubit.removePostImage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
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
          "تعديل الحساب",
          style: GoogleFonts.cairo(
            color: ThemeApp.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: BlocConsumer<SwapCubit, SwapStates>(
        listener: (context, state) {
          if (state is UserDataUpdateLoading) {
            updatingUserData = true;
          } else {
            updatingUserData = false;
          }
        },
        builder: (context, state) {
          SwapCubit swapCubit = SwapCubit.get(context);
          UserModel userModel = swapCubit.userModel!;
          return Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: double.infinity),
                        Center(
                          child: ProfileCircleImageWithButton(
                            imageUrl: userModel.image,
                            buttonColor: ThemeApp.blueColor,
                            iconData: Icons.camera_alt,
                            onPressed: () => swapCubit.pickImage(profile: true),
                          ),
                        ),
                        const DSize(width: 0, height: 25),
                        DefaultTextFormField(
                          color: ThemeApp.secondaryColor.withOpacity(0.3),
                          context: context,
                          controller: firstnameController,
                          keyboardType: TextInputType.name,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'برجاء إدخال الاسم الأول';
                            }
                            return null;
                          },
                          hint: 'الاسم الاول',
                          suffix: Icons.supervised_user_circle_sharp,
                        ),
                        const DSize(width: 0, height: 15),
                        DefaultTextFormField(
                          color: ThemeApp.secondaryColor.withOpacity(0.3),
                          context: context,
                          controller: lastnameController,
                          keyboardType: TextInputType.name,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'برجاء إدخال الاسم الأخير';
                            }
                            return null;
                          },
                          hint: 'الاسم الاخير',
                          suffix: Icons.person,
                        ),
                        const DSize(width: 0, height: 15),
                        MyDropdownFormField(
                          hint: 'الجنس',
                          value: genderDropdownValue,
                          onChanged: (newValue) {
                            if (newValue != null &&
                                ["ذكر", "انثي"].contains(newValue)) {
                              setState(() => genderDropdownValue = newValue);
                            }
                          },
                          items: ["ذكر", "انثي"].map((e) {
                            return DropdownMenuItem(
                              key: ValueKey(e), // add a unique key
                              value: e,
                              child: Center(
                                child: Text(
                                  e,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const DSize(width: 0, height: 15),
                        DefaultTextFormField(
                          color: ThemeApp.secondaryColor.withOpacity(0.3),
                          context: context,
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'برجاء إدخال رقم الهاتف';
                            } else if (value.length != 11) {
                              return 'يجب ان يكون رقم الهاتف مكون من 11 رقم';
                            } else {
                              return null;
                            }
                          },
                          suffix: Icons.phone,
                          hint: 'ادخل رقم الهاتف',
                        ),
                        const DSize(width: 0, height: 15),
                        DefaultTextFormField(
                          color: ThemeApp.secondaryColor.withOpacity(0.3),
                          context: context,
                          controller: governorateController,
                          hint: 'المحافظة',
                        ),
                        const DSize(width: 0, height: 15),
                        DefaultTextFormField(
                          color: ThemeApp.secondaryColor.withOpacity(0.3),
                          context: context,
                          controller: cityController,
                          hint: 'المدينة',
                        ),
                        const DSize(width: 0, height: 15),
                        DefaultTextFormField(
                          color: ThemeApp.secondaryColor.withOpacity(0.3),
                          context: context,
                          controller: areaController,
                          hint: 'المنطقة',
                        ),
                        const DSize(height: 20, width: double.infinity),
                        Center(
                          child: defaultButton(
                            function: () async {
                              if (formKey.currentState!.validate()) {
                                userModel.firstName = firstnameController.text;
                                userModel.lastName = lastnameController.text;
                                userModel.gender = genderDropdownValue;
                                userModel.phone = phoneController.text;
                                userModel.governorate =
                                    governorateController.text;
                                userModel.city = cityController.text;
                                userModel.area = areaController.text;
                                swapCubit
                                    .updateUser(userModel)
                                    .then((_) => Navigator.pop(context));
                              }
                            },
                            widget: Text(
                              'حفظ',
                              style: GoogleFonts.cairo(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: ThemeApp.secondaryColor,
                              ),
                            ),
                            color: ThemeApp.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (updatingUserData)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

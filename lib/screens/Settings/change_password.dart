import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/components/buttons.dart';
import '../../shared/components/sized_box.dart';
import '../../shared/components/text_form_field.dart';
import '../../shared/cubit/changePasswordCubit/change_password_cubit.dart';
import '../../shared/cubit/swapCubit/swap_cubit.dart';
import '../../shared/styles/theme.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);
  static const String routeName = 'changePassword';

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String? _currentPasswordError;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var currentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();
  late ChangePasswordCubit changePasswordCubit;

  @override
  void initState() {
    changePasswordCubit  = ChangePasswordCubit.get(context);
    super.initState();
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    changePasswordCubit.resetIsPassword();
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
          "تغيير كلمة المرور",
          style: GoogleFonts.cairo(
            color: ThemeApp.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
        builder: (context, state) {
          ChangePasswordCubit cubit = ChangePasswordCubit.get(context);
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2.2,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          DefaultTextFormField(
                            context: context,
                            hint: "كلمة المرور الحالية",
                            controller: currentPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value!.trim().isEmpty) {
                                return 'برجاء إدخال كلمة المرور';
                              } else {
                                return _currentPasswordError;
                              }
                            },
                            color: Colors.transparent,
                            isPassword: cubit.isPassword,
                            suffix: cubit.suffix,
                            suffixPressed: cubit.showPassword,
                          ),
                          const DSize(height: 16, width: 0),
                          DefaultTextFormField(
                            context: context,
                            hint: "كلمة المرور الجديدة",
                            controller: newPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value!.trim().isEmpty) {
                                return 'برجاء إدخال كلمة المرور الجديدة';
                              }
                              return null;
                            },
                            color: Colors.transparent,
                            isPassword: cubit.isPassword,
                            suffix: cubit.suffix,
                            suffixPressed: cubit.showPassword,
                          ),
                          const DSize(height: 16, width: 0),
                          DefaultTextFormField(
                            context: context,
                            hint: "تاكيد كلمة المرور",
                            controller: confirmNewPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value!.trim().isEmpty) {
                                return 'برجاء إدخال كلمة المرور الجديدة';
                              } else if (newPasswordController.text.trim() !=
                                  value.trim()) {
                                return "كلمة المرور ليست متطابقة";
                              }
                              return null;
                            },
                            color: Colors.transparent,
                            isPassword: cubit.isPassword,
                            suffix: cubit.suffix,
                            suffixPressed: cubit.showPassword,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  defaultMaterialButton(
                    function: () async {
                      _currentPasswordError = await cubit
                          .verifyPassword(currentPasswordController.text);
                      if (formKey.currentState!.validate()) {
                        cubit
                            .changePassword(newPasswordController.text)
                            .then((value) {
                          currentPasswordController.clear();
                          newPasswordController.clear();
                          confirmNewPasswordController.clear();
                          SwapCubit.get(context).logOut(context);
                        });
                      }
                    },
                    text: 'تغيير كلمة المرور',
                    color: ThemeApp.primaryColor,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

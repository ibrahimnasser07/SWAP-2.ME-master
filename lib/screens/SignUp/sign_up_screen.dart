import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:swap_me/screens/EmailVerify/email_verify.dart';
import 'package:swap_me/screens/SignIn/sign_in_screen.dart';
import 'package:swap_me/shared/components/buttons.dart';
import 'package:swap_me/shared/components/navigator.dart';
import 'package:swap_me/shared/components/sized_box.dart';
import 'package:swap_me/shared/components/text_form_field.dart';
import 'package:swap_me/shared/components/toast.dart';
import 'package:swap_me/shared/constants/constants.dart';
import 'package:swap_me/shared/cubit/signUpCubit/sign_up_cubit.dart';
import 'package:swap_me/shared/cubit/signUpCubit/sign_up_state.dart';
import 'package:swap_me/shared/network/cache_helper.dart';
import 'package:swap_me/shared/styles/theme.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const String routeName = 'signUp';

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var firstnameController = TextEditingController();
    var lastnameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    var phoneController = TextEditingController();
    var dateTimeController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is UserCreateSuccessState) {
            showToast(
              text: 'تم إنشاء حسابك بنجاح',
              state: ToastStates.success,
            );
            CacheHelper.saveData(value: state.uid, key: 'uId').then((value) {
              uId = state.uid;
              Navigator.pushReplacementNamed(context, EmailVerify.routeName);
            });
          } else if (state is SignUpErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.error,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 30,
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
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'انشاء حساب',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const DSize(height: 15, width: 0),
                      Text(
                        'أدخل بياناتك للانضمام إلى قايضني',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const DSize(width: 0, height: 20),
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
                        suffixPressed: () {},
                      ),
                      const DSize(width: 0, height: 26),
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
                      const DSize(width: 0, height: 26),
                      DefaultTextFormField(
                        color: ThemeApp.secondaryColor.withOpacity(0.3),
                        context: context,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'برجاء إدخال البريد الإلكترونى';
                          }
                          return null;
                        },
                        hint: 'البريد الالكتروني',
                        suffix: Icons.alternate_email_outlined,
                        suffixPressed: () {},
                      ),
                      const DSize(width: 0, height: 26),
                      DefaultTextFormField(
                        color: ThemeApp.secondaryColor.withOpacity(0.3),
                        context: context,
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        validate: (String? value) {
                          if (value!.trim().isEmpty) {
                            return 'برجاء إدخال كلمة المرور';
                          } else if (passwordController.text.trim() !=
                              confirmPasswordController.text.trim()) {
                            return "كلمة المرور ليست متطابقة";
                          }

                          return null;
                        },
                        suffix: SignUpCubit.get(context).suffix,
                        isPassword: SignUpCubit.get(context).isPassword,
                        suffixPressed: () {
                          SignUpCubit.get(context).showPassword();
                        },
                        hint: 'كلمه المرور',
                      ),
                      const DSize(width: 0, height: 26),
                      DefaultTextFormField(
                        color: ThemeApp.secondaryColor.withOpacity(0.3),
                        context: context,
                        controller: confirmPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        validate: (String? value) {
                          if (value!.trim().isEmpty) {
                            return 'تأكيد كلمة المرور';
                          } else if (passwordController.text.trim() !=
                              confirmPasswordController.text.trim()) {
                            return "كلمة المرور ليست متطابقة";
                          }

                          return null;
                        },
                        suffix: SignUpCubit.get(context).suffix,
                        isPassword: SignUpCubit.get(context).isPassword,
                        suffixPressed: () {
                          SignUpCubit.get(context).showPassword();
                        },
                        hint: 'تأكيد كلمه المرور',
                      ),
                      const DSize(width: 0, height: 26),
                      DefaultTextFormField(
                        color: ThemeApp.secondaryColor.withOpacity(0.3),
                        context: context,
                        controller: dateTimeController,
                        keyboardType: TextInputType.datetime,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'برجاء إدخال تاريخ ميلادك';
                          }
                          return null;
                        },
                        suffix: Icons.keyboard_arrow_down,
                        suffixPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 18250)),
                            lastDate: DateTime.now(),
                          ).then((value) {
                            dateTimeController.text =
                                DateFormat.yMMMd().format(value!);
                          });
                        },
                        hint: 'تاريخ الميلاد',
                      ),
                      const DSize(width: 0, height: 26),
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
                        suffixPressed: () {},
                      ),
                      const DSize(width: 0, height: 26),
                      defaultMaterialButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              SignUpCubit.get(context).userSignUp(
                                email: emailController.text,
                                phone: phoneController.text,
                                password: passwordController.text,
                                firstName: firstnameController.text,
                                lastName: lastnameController.text,
                              );
                              emailController.clear();
                              passwordController.clear();
                              firstnameController.clear();
                              lastnameController.clear();
                              confirmPasswordController.clear();
                              phoneController.clear();
                              dateTimeController.clear();
                            }
                          },
                          text: 'تسجيل الدخول',
                          color: ThemeApp.primaryColor),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 19),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {
                                navigateTo(context,
                                    routeName: SignInScreen.routeName);
                              },
                              child: Text(
                                'هل لديك حساب ؟  تسجيل الدخول الان',
                                style: GoogleFonts.cairo(
                                  color: ThemeApp.primaryColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

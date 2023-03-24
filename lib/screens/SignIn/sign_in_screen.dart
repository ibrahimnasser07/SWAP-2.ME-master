import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swap_me/screens/Layout/layout_screen.dart';
import 'package:swap_me/screens/Password/forgot_password.dart';
import 'package:swap_me/screens/SignUp/sign_up_screen.dart';
import 'package:swap_me/shared/components/buttons.dart';
import 'package:swap_me/shared/components/navigator.dart';
import 'package:swap_me/shared/components/sized_box.dart';
import 'package:swap_me/shared/components/text_form_field.dart';
import 'package:swap_me/shared/components/toast.dart';
import 'package:swap_me/shared/constants/constants.dart';
import 'package:swap_me/shared/cubit/signInCubit/sign_in_cubit.dart';
import 'package:swap_me/shared/cubit/signInCubit/sign_in_state.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_cubit.dart';
import 'package:swap_me/shared/network/cache_helper.dart';
import 'package:swap_me/shared/styles/theme.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static const String routeName = 'signIn';

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SignInCubit(),
      child: BlocConsumer<SignInCubit, SignInStates>(
        listener: (context, state) {
          if (state is SignInLoadingState) {}
          if (state is SignInSuccessState) {
            showToast(
              text: 'تم تسجيل الدخول بنجاح',
              state: ToastStates.success,
            );
            CacheHelper.saveData(value: state.uid, key: 'uId').then((value) {
              uId = state.uid;

              SwapCubit.get(context).getUserData();
              SwapCubit.get(context).getMyAdsData(uId);
              navigateAndFinish(context, routeName: LayoutScreen.routeName);
            });
          } else if (state is SignInErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.error,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(automaticallyImplyLeading: false, actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: ThemeApp.primaryColor,
                  )),
            ]),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const DSize(height: 100, width: 0),
                      Text(
                        'تسجيل الدخول',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const DSize(height: 36, width: 0),
                      Text(
                        'الرجاء إدخال البيانات الخاصة بك لتسجيل الدخول إلى حسابك',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const DSize(width: 0, height: 67),
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
                        suffix: Icons.alternate_email,
                      ),
                      const DSize(width: 0, height: 26),
                      DefaultTextFormField(
                        color: ThemeApp.secondaryColor.withOpacity(0.3),
                        context: context,
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'برجاء إدخال كلمة المرور';
                          }
                          return null;
                        },
                        suffix: SignInCubit.get(context).suffix,
                        isPassword: SignInCubit.get(context).isPassword,
                        suffixPressed: () {
                          SignInCubit.get(context).showPassword();
                        },
                        hint: 'كلمه المرور',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 19, bottom: 73),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {
                                navigateTo(context,
                                    routeName: ForgotPassword.routeName);
                              },
                              child: Text(
                                'هل نسيت كلمه السر؟',
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
                      defaultMaterialButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            SignInCubit.get(context).userSignIn(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            emailController.clear();
                            passwordController.clear();
                          }
                        },
                        text: 'تسجيل الدخول',
                        color: ThemeApp.primaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 19),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {
                                navigateTo(context,
                                    routeName: SignUpScreen.routeName);
                              },
                              child: Text(
                                'ليس لديك حساب ؟ انشاء الحساب',
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swap_me/screens/SignIn/sign_in_screen.dart';
import 'package:swap_me/shared/components/buttons.dart';
import 'package:swap_me/shared/components/navigator.dart';
import 'package:swap_me/shared/components/sized_box.dart';
import 'package:swap_me/shared/components/text_form_field.dart';
import 'package:swap_me/shared/cubit/restPasswordCubit/rest_password_cubit.dart';
import 'package:swap_me/shared/cubit/restPasswordCubit/rest_password_state.dart';
import 'package:swap_me/shared/styles/theme.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  static const String routeName = 'ForgotPassword';

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordStates>(
        listener: (context, state) {
          if (state is ResetPasswordSuccessState) {
            navigateAndFinish(context, routeName: SignInScreen.routeName);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
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
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'هل نسيت كلمه السر',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const DSize(height: 20, width: 0),
                    Text(
                      'سنرسل اليك  رابط عبر البريد الالكتروني لاعاده\n تعيين كلمه المرور',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(height: 3),
                      textAlign: TextAlign.center,
                    ),
                    const DSize(width: 0, height: 24),
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
                    const Spacer(),
                    defaultMaterialButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            ResetPasswordCubit.get(context).resetPassword(
                              email: emailController.text,
                            );
                            emailController.clear();
                          }
                        },
                        text: 'ارسال',
                        color: ThemeApp.primaryColor),
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

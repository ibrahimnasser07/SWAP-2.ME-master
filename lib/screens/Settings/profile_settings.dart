import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swap_me/shared/cubit/changePasswordCubit/change_password_cubit.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_cubit.dart';

import '../../shared/components/settings_item.dart';
import '../../shared/components/text_form_field.dart';
import '../../shared/styles/theme.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({Key? key}) : super(key: key);
  static const String routeName = 'profileSettings';

  @override
  Widget build(BuildContext context) {
    ChangePasswordCubit cubit = ChangePasswordCubit.get(context);
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
          "إعدادات الحساب",
          style: GoogleFonts.cairo(
            color: ThemeApp.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SettingsItem(
              title: "إلغاء حسابي",
              iconData: Icons.cancel,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    var passwordController = TextEditingController();
                    GlobalKey<FormState> formKey = GlobalKey<FormState>();
                    String? errorPassword;
                    IconData suffix = Icons.visibility_outlined;
                    bool isPassword = true;
                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("هل انت متاكد من الغاء حسابك؟"),
                            const SizedBox(height: 16),
                            Form(
                              key: formKey,
                              child: DefaultTextFormField(
                                context: context,
                                hint: " برجاء إدخال كلمة المرور",
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                validate: (value) => errorPassword,
                                color: Colors.transparent,
                                isPassword: isPassword,
                                suffix: suffix,
                                suffixPressed: () {
                                  setState(() {
                                    isPassword = !isPassword;
                                    suffix = isPassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                            ),
                            child: const Text("إلغاء"),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await cubit
                                  .verifyPassword(passwordController.text)
                                  .then((value) {
                                errorPassword = value;
                                if (formKey.currentState!.validate()) {
                                  SwapCubit.get(context).deleteUser(
                                    context,
                                    passwordController.text,
                                  );
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeApp.primaryColor,
                            ),
                            child: const Text("تأكيد"),
                          ),
                        ],
                      );
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

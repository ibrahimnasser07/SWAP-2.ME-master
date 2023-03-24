import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:swap_me/screens/Settings/change_password.dart';
import 'package:swap_me/screens/Settings/favorites.dart';
import 'package:swap_me/screens/Settings/profile_settings.dart';

import '../../shared/components/settings_item.dart';
import '../../shared/cubit/swapCubit/swap_cubit.dart';
import '../../shared/cubit/swapCubit/swap_state.dart';
import '../../shared/styles/theme.dart';
import 'about.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const String routeName = 'settingsScreen';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SwapCubit, SwapStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SwapCubit cubit = SwapCubit.get(context);
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
              "الإعدادات",
              style: GoogleFonts.cairo(
                color: ThemeApp.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return false;
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SettingsItem(
                      title: "إعدادات الحساب",
                      iconData: Icons.settings_outlined,
                      onTap: () {
                        Navigator.pushNamed(context, ProfileSettings.routeName);
                      },
                    ),
                    SettingsItem(
                      title: "تغيير كلمة المرور",
                      iconData: Icons.lock,
                      onTap: () {
                        Navigator.pushNamed(context, ChangePassword.routeName);
                      },
                    ),
                    SettingsItem(
                      title: "المفضلة",
                      iconData: Icons.favorite,
                      onTap: () {
                        Navigator.pushNamed(context, FavoritesScreen.routeName);
                      },
                    ),
                    SettingsItem(
                      title: "عن التطبيق",
                      iconData: Icons.info,
                      onTap: () {
                        Navigator.pushNamed(context, AboutScreen.routeName);
                      },
                    ),
                    SettingsItem(
                      title: "تسجيل الخروج",
                      iconData: Icons.exit_to_app,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: const Text("هل تريد تسجيل الخروج؟"),
                              actions: [
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                  ),
                                  child: const Text("إلغاء"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    cubit.logOut(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ThemeApp.primaryColor,
                                  ),
                                  child: const Text("تأكيد"),
                                ),
                              ],
                            );
                          },
                        );

                      },
                    ),
                    const SizedBox(height: 300),
                    FutureBuilder<PackageInfo>(
                      future: PackageInfo.fromPlatform(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            "الاصدار: ${snapshot.data!.version}",
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

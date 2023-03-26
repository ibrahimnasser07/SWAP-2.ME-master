import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swap_me/screens/Ads/add_ads.dart';
import 'package:swap_me/screens/Settings/settings_screen.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_cubit.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_state.dart';
import 'package:swap_me/shared/styles/theme.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);
  static const String routeName = 'LayoutScreen';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SwapCubit, SwapStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SwapCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SettingsScreen.routeName);
                },
                icon: SvgPicture.asset('assets/images/menu-left-alt.svg'),
              ),
            ],
            centerTitle: true,
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: GoogleFonts.cairo(
                color: ThemeApp.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: SvgPicture.asset('assets/images/Group 281.svg'),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: ThemeApp.primaryColor,
            shape: const StadiumBorder(
              side: BorderSide(color: Colors.white, width: 0),
            ),
            onPressed: () {
              SwapCubit.get(context).getDataPro();
              Navigator.pushNamed(
                context,
                AddAds.routeName,
              );
            },
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            elevation: 5,
            shape: const CircularNotchedRectangle(),
            notchMargin: 5,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              // backgroundColor: Colors.transparent,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage('assets/images/home.png')),
                  label: 'الرئيسية',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage('assets/images/bell.png')),
                  label: 'تنبيهاتى',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage('assets/images/tablet.png')),
                  label: 'إعلاناتى',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage('assets/images/user.png')),
                  label: 'حسابى',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

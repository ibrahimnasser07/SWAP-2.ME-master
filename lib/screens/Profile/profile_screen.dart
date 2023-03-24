import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swap_me/model/user_model.dart';
import 'package:swap_me/screens/Profile/edit_profile.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_cubit.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_state.dart';

import '../../shared/styles/theme.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);
  static const String routeName = 'MyProfileScreen';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SwapCubit, SwapStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SwapCubit swapCubit = SwapCubit.get(context);
        UserModel userModel = swapCubit.userModel!;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: double.infinity),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, EditProfileScreen.routeName);
                  },
                  child: const Text("تعديل"),
                ),
                Center(
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: userModel.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    " ${userModel.firstName} ${userModel.lastName}",
                    style: GoogleFonts.cairo(
                      color: ThemeApp.blackPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.email_outlined),
                  title: Text(userModel.email),
                ),
                const Divider(indent: 10, endIndent: 10, color: Colors.grey),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: Text(userModel.phone),
                ),
                if (userModel.gender != null)
                  const Divider(indent: 10, endIndent: 10, color: Colors.grey),
                if (userModel.gender != null)
                  ListTile(
                    leading: Icon(
                      userModel.gender! == "ذكر" ? Icons.male : Icons.female,
                    ),
                    title: Text(userModel.gender!),
                  ),
                const Divider(indent: 10, endIndent: 10, color: Colors.grey),
                ListTile(
                  leading: const Icon(Icons.location_on_outlined),
                  title: Text(
                    userModel.governorate != null && userModel.city != null
                        ? '${userModel.governorate}, ${userModel.city}'
                        : userModel.governorate ??
                            userModel.city ??
                            'لم تقم بتحديد عنوانك بعد',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  late User user;

  ChangePasswordCubit() : super(ChangePasswordInitial()) {
    user = FirebaseAuth.instance.currentUser!;
  }

  static ChangePasswordCubit get(context) => BlocProvider.of(context);

  Future<String?> verifyPassword(String currentPassword) async {
    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );

    try {
      await user.reauthenticateWithCredential(credential);
      return null;
    } catch (e) {
      return "كلمة المرور غير صحيحة";
    }
  }

  Future<void> changePassword(String newPassword) async {
    await user.updatePassword(newPassword);
    emit(PasswordUpdated());
  }

  ///START : Show Password
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void resetIsPassword() {
    isPassword = true;
    suffix = Icons.visibility_outlined;
  }

  void showPassword() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShowPasswordState());
  }

  ///END : Show Password
}

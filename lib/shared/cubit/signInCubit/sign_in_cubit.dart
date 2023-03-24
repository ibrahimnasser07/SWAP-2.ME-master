import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swap_me/shared/cubit/signInCubit/sign_in_state.dart';



class SignInCubit extends Cubit<SignInStates> {
  SignInCubit() : super(SignInInitialState());

  static SignInCubit get(context) => BlocProvider.of(context);
///START : SignIn With E-mail & Password
  Future<void> userSignIn({
    required String email,
    required String password,
  })async {
    emit(SignInLoadingState());
  await  FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
    emit(SignInSuccessState(value.user!.uid));
    }).catchError((error) {
    emit(SignInErrorState(error.toString()));
    });
  }
///END : SignIn With E-mail & Password

///START : Show Password
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void showPassword() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShowPasswordState());
  }
///END : Show Password
}
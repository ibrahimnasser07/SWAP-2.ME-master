abstract class SignUpStates{}

class SignUpInitialState extends SignUpStates{}

class SignUpLoadingState extends SignUpStates{}

class SignUpSuccessState extends SignUpStates{}

class SignUpErrorState extends SignUpStates{

  final String error;

  SignUpErrorState(this.error);
}

class UserCreateSuccessState extends SignUpStates
{
 late final String uid;
  UserCreateSuccessState(this.uid);
}

class UserCreateErrorState extends SignUpStates{

  final String error;

  UserCreateErrorState(this.error);
}

class ChangePasswordSignUpState extends SignUpStates{}
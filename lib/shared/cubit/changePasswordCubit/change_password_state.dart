part of 'change_password_cubit.dart';

@immutable
abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}
class PasswordUpdated extends ChangePasswordState {}
class ShowPasswordState extends ChangePasswordState {}

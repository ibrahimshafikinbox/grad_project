import 'package:grad_project/Feature/Login/Model/usermodel.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String accessToken;
  final UserModel user;

  LoginSuccess({required this.accessToken, required this.user});
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}

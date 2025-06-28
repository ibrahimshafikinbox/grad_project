import 'package:grad_project/Feature/Profile/Model/profile_model.dart';

abstract class GetProfileState {}

class GetProfileInitial extends GetProfileState {}

class GetProfileLoading extends GetProfileState {}

class GetProfileSuccess extends GetProfileState {
  final ProfileModel profile;

  GetProfileSuccess(this.profile);
}

class GetProfileFailure extends GetProfileState {
  final String error;

  GetProfileFailure(this.error);
}

class UpdateProfileLoading extends GetProfileState {}

class UpdateProfileSuccess extends GetProfileState {
  final ProfileModel profile;

  UpdateProfileSuccess(this.profile);
}

class UpdateProfileFailure extends GetProfileState {
  final String error;

  UpdateProfileFailure(this.error);
}

class ConvertProfileLoading extends GetProfileState {}

class ConvertProfileSuccess extends GetProfileState {}

class ConvertProfileFailure extends GetProfileState {
  final String error;

  ConvertProfileFailure(this.error);
}

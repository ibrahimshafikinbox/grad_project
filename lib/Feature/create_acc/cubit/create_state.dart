abstract class CreateAccountState {}

class CreateAccountInitial extends CreateAccountState {}

class CreateAccountLoading extends CreateAccountState {}

class CreateAccountSuccess extends CreateAccountState {
  final Map<String, dynamic> userData;

  CreateAccountSuccess(this.userData);
}

class CreateAccountFailure extends CreateAccountState {
  final String error;

  CreateAccountFailure(this.error);
}

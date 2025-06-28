abstract class SettingsState {
  const SettingsState();
}

class PasswordChangeInitial extends SettingsState {
  const PasswordChangeInitial();
}

class PasswordChangeLoading extends SettingsState {
  const PasswordChangeLoading();
}

class PasswordChangeSuccess extends SettingsState {
  final String message;

  const PasswordChangeSuccess({required this.message});

  @override
  String toString() => 'PasswordChangeSuccess(message: $message)';
}

class PasswordChangeFailure extends SettingsState {
  final String error;

  const PasswordChangeFailure({required this.error});

  @override
  String toString() => 'PasswordChangeFailure(error: $error)';
}

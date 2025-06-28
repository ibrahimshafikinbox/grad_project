import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/Core/constants/api_consts.dart';
import 'package:grad_project/Feature/Settings/cubit/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final Dio dio;

  SettingsCubit({required this.dio}) : super(PasswordChangeInitial());

  Future<void> changePassword({
    required int userId,
    required String oldPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    emit(PasswordChangeLoading());

    try {
      final response = await dio.post(
        '${ApiConsts.baseUrl}/change-password',
        data: {
          'user_id': userId,
          'old_password': oldPassword,
          'new_password': newPassword,
          'new_password_confirmation': newPasswordConfirmation,
        },
      );

      if (response.statusCode == 200) {
        emit(PasswordChangeSuccess(message: response.data['message']));
      } else {
        emit(PasswordChangeFailure(
            error: response.data['error'] ?? 'Failed to change password'));
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.response != null) {
        errorMessage = e.response?.data['error'] ??
            e.response?.statusMessage ??
            'Failed to change password';
      } else {
        errorMessage = e.message ?? 'Network error occurred';
      }
      emit(PasswordChangeFailure(error: errorMessage));
    } catch (e) {
      emit(PasswordChangeFailure(error: 'An unexpected error occurred'));
    }
  }

  void reset() {
    emit(PasswordChangeInitial());
  }
}

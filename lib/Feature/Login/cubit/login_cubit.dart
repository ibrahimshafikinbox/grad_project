import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:grad_project/Core/constants/api_consts.dart';
import 'package:grad_project/Feature/Login/Model/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final Dio _dio = Dio();

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    try {
      final response = await _dio.post(
        '${ApiConsts.baseUrl}${ApiConsts.loginEndpoint}',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final accessToken = data['access_token'];
        final user = UserModel.fromJson(data['user']);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('user_id', user.userId);
        await prefs.setString('access_token', accessToken); // ✅ Save token

        final savedId = prefs.getInt('user_id');
        final savedToken = prefs.getString('access_token');
        print('✅ Saved user ID: $savedId');
        print('🔐 Saved access token: $savedToken');

        emit(LoginSuccess(accessToken: accessToken, user: user));
        print("✅ Login successful: ${response.data}");
      } else {
        print("❌ ${response.statusCode}");
        emit(LoginFailure('Login failed. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      print("❌ ${e.toString()}");
      emit(LoginFailure('An error occurred: ${e.toString()}'));
    }
  }

  // ✅ Get saved user ID
  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('user_id');
    print('📦 Retrieved user ID: $id');
    return id;
  }
}

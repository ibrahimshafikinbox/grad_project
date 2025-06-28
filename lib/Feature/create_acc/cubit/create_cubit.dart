import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:grad_project/Core/constants/api_consts.dart';
import 'package:grad_project/Feature/create_acc/cubit/create_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit() : super(CreateAccountInitial());

  final Dio _dio = Dio();

  Future<void> createAccount({
    required String lastname,
    required String firstname,
    required String phonenumber,
    required String email,
    required String password,
  }) async {
    emit(CreateAccountLoading());
    print('Creating account for: $email');

    try {
      final response = await _dio.post(
        "${ApiConsts.baseUrl}${ApiConsts.registerEndpoint}",
        data: {
          'lastname': lastname,
          "firstname": firstname,
          'email': email,
          'password': password,
          "password_confirmation": password,
          "phonenumber": phonenumber,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        print(response.data);
        emit(CreateAccountSuccess(response.data));
      } else {
        print('Failed with status: ${response.statusCode}');
        emit(
            CreateAccountFailure('Failed with status: ${response.statusCode}'));
      }
    } catch (e) {
      print('Error occurred: $e');
      print('Error occurred: $e');
      emit(CreateAccountFailure(e.toString()));
    }
  }
}

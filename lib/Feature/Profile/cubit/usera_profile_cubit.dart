// import 'dart:io';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:grad_project/Core/constants/api_consts.dart';
// import 'package:grad_project/Feature/Login/Model/usermodel.dart';
// import 'package:grad_project/Feature/Profile/Model/profile_model.dart';
// import 'package:grad_project/Feature/Profile/cubit/user_profile_state.dart';

// class GetProfileCubit extends Cubit<GetProfileState> {
//   GetProfileCubit() : super(GetProfileInitial());

//   Future<void> getProfile(int userId) async {
//     print("✅ method get profile called");
//     emit(GetProfileLoading());
//     try {
//       final response = await Dio().get('${ApiConsts.baseUrl}/user/2');
//       final profile = ProfileModel.fromJson(response.data);
//       print("✅ get profile success");
//       print(profile.firstname);
//       emit(GetProfileSuccess(profile));
//     } catch (e) {
//       print(e.toString());
//       emit(GetProfileFailure(e.toString()));
//     }
//   }

//   Future<void> updateUserProfile(int userId) async {
//     print("✅ method Update profile called");
//     emit(UpdateProfileLoading());
//     try {
//       final response = await Dio().get('${ApiConsts.baseUrl}/user/$userId');
//       final profile = ProfileModel.fromJson(response.data);
//       print("✅ Update profile success");
//       print(profile.token);
//       emit(UpdateProfileSuccess(profile));
//     } catch (e) {
//       print(e.toString());
//       emit(UpdateProfileFailure(e.toString()));
//     }
//   }

//   Future<void> updateProfile({
//     required int userId,
//     String? lastname,
//     String? phoneNumber,
//     String? email,
//     String? profilePicturePath,
//   }) async {
//     emit(UpdateProfileLoading());
//     ProfileModel? user;

//     try {
//       final formData = FormData.fromMap({
//         if (lastname != null) 'lastname': lastname,
//         if (phoneNumber != null) 'phone_number': phoneNumber,
//         if (email != null) 'email': email,
//         if (profilePicturePath != null)
//           'profile_picture': await MultipartFile.fromFile(profilePicturePath),
//       });

//       final response = await Dio().post(
//         '${ApiConsts.baseUrl}/user/update-profile',
//         data: formData,
//         options: Options(headers: {
//           'Authorization':
//               'Bearer 6|UdxODUobEe215bhNP4fuEaOtWayPfdn9sdPqlXThce873f2a',
//         }),
//       );

//       if (response.statusCode == 200) {
//         final updatedUser = ProfileModel.fromJson(response.data['user']);
//         emit(UpdateProfileSuccess(updatedUser));
//       } else {
//         emit(UpdateProfileFailure(
//             'Failed to update profile: ${response.statusCode}'));
//       }
//     } on DioException catch (e) {
//       emit(UpdateProfileFailure('Error updating profile: ${e.message}'));
//     } catch (e) {
//       emit(UpdateProfileFailure('Unexpected error: $e'));
//     }
//   }

//   Future<void> convertToProvider({
//     required String userId,
//     required String serviceId,
//     required String experience,
//     required String startTime,
//     required String endTime,
//     required String location,
//     required String bio,
//     required String phoneNumber,
//     required File profilePicture,
//   }) async {
//     emit(ConvertProfileLoading());
//     print(" ✅ method convert  called");

//     try {
//       final dio = Dio();
//       final formData = FormData.fromMap({
//         'user_id': 2,
//         'service_id': 1,
//         'experience': experience,
//         'start_time': startTime,
//         'end_time': endTime,
//         'location': location,
//         'bio': bio,
//         'phone_number': phoneNumber,
//         'profile_picture': await MultipartFile.fromFile(
//           profilePicture.path,
//           filename: profilePicture.path.split('/').last,
//         ),
//       });

//       final response = await dio.post(
//         '${ApiConsts.baseUrl}/serviceprovider',
//         data: formData,
//         options: Options(
//           contentType: 'multipart/form-data',
//         ),
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         emit(ConvertProfileSuccess());
//         print(" ✅ method convert  success");
//       } else {
//         emit(ConvertProfileFailure(
//             'Failed with status: ${response.statusCode}'));
//       }
//     } catch (e) {
//       print(" ❌ method convert  failed");
//       print(e.toString());
//       emit(ConvertProfileFailure('Error: $e'));
//     }
//   }
// }
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:grad_project/Core/constants/api_consts.dart';
import 'package:grad_project/Feature/Profile/Model/profile_model.dart';
import 'package:grad_project/Feature/Profile/cubit/user_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  GetProfileCubit() : super(GetProfileInitial());

  Future<void> getProfile() async {
    print("✅ method get profile called");
    emit(GetProfileLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');

      if (userId == null) {
        emit(GetProfileFailure('User ID not found'));
        return;
      }

      final response = await Dio().get('${ApiConsts.baseUrl}/user/$userId');
      final profile = ProfileModel.fromJson(response.data);
      print("✅ get profile success");
      emit(GetProfileSuccess(profile));
    } catch (e) {
      print(e.toString());
      emit(GetProfileFailure(e.toString()));
    }
  }

  Future<void> updateUserProfile() async {
    print("✅ method updateUserProfile called");
    emit(UpdateProfileLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');

      if (userId == null) {
        emit(UpdateProfileFailure('User ID not found'));
        return;
      }

      final response = await Dio().get('${ApiConsts.baseUrl}/user/$userId');
      final profile = ProfileModel.fromJson(response.data);
      print("✅ update profile success");
      emit(UpdateProfileSuccess(profile));
    } catch (e) {
      print(e.toString());
      emit(UpdateProfileFailure(e.toString()));
    }
  }

  Future<void> updateProfile({
    String? lastname,
    String? phoneNumber,
    String? email,
    String? profilePicturePath,
  }) async {
    emit(UpdateProfileLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');
      print(userId);
      if (userId == null) {
        emit(UpdateProfileFailure('User ID not found'));
        return;
      }

      final formData = FormData.fromMap({
        'user_id': userId,
        if (lastname != null) 'lastname': lastname,
        if (phoneNumber != null) 'phone_number': phoneNumber,
        if (email != null) 'email': email,
        if (profilePicturePath != null)
          'profile_picture': await MultipartFile.fromFile(profilePicturePath),
      });

      final response = await Dio().post(
        '${ApiConsts.baseUrl}/user/update-profile',
        data: formData,
        options: Options(headers: {
          'Authorization':
              'Bearer 15|OVVzocUgnhl3jJnUnAR1CXk9Nt4YiBnjzliG93k494d0f7e7',
        }),
      );

      if (response.statusCode == 200) {
        final updatedUser = ProfileModel.fromJson(response.data['user']);
        emit(UpdateProfileSuccess(updatedUser));
      } else {
        emit(UpdateProfileFailure(
            'Failed to update profile: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      print(e.toString());
      emit(UpdateProfileFailure('Error updating profile: ${e.message}'));
    } catch (e) {
      print(e.toString());

      emit(UpdateProfileFailure('Unexpected error: $e'));
    }
  }

  Future<void> convertToProvider({
    required String serviceId,
    required String experience,
    required String startTime,
    required String endTime,
    required String location,
    required String bio,
    required String phoneNumber,
    required File profilePicture,
  }) async {
    emit(ConvertProfileLoading());
    print("✅ method convertToProvider called");

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');

      if (userId == null) {
        emit(ConvertProfileFailure('User ID not found'));
        return;
      }

      final formData = FormData.fromMap({
        'user_id': userId,
        'service_id': "2",
        'experience': experience,
        'start_time': startTime,
        'end_time': endTime,
        'location': location,
        'bio': bio,
        'phone_number': phoneNumber,
        'profile_picture': await MultipartFile.fromFile(
          profilePicture.path,
          filename: profilePicture.path.split('/').last,
        ),
      });

      final response = await Dio().post(
        '${ApiConsts.baseUrl}/serviceprovider',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ convert to provider success");
        emit(ConvertProfileSuccess());
      } else {
        print(response.statusCode);
        print("❌ convert to provider failed");
        emit(ConvertProfileFailure(
            'Failed with status: ${response.statusCode}'));
      }
    } catch (e) {
      print("❌ convert to provider failed");
      print(e.toString());
      emit(ConvertProfileFailure('Error: $e'));
    }
  }
}

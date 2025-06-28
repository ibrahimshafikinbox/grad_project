import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:grad_project/Core/Helper/storage/strage_helper.dart';
import 'package:grad_project/Core/constants/api_consts.dart';
import 'package:grad_project/Feature/provider_profile/Model/service_provider_model.dart';
import 'package:grad_project/Feature/provider_profile/cubit/provider_state.dart';

class ServiceProviderCubit extends Cubit<ServiceProviderState> {
  ServiceProviderCubit() : super(ServiceProviderInitial());

  final Dio _dio = Dio();

  Future<void> getServiceProvider(int id) async {
    emit(ServiceProviderLoading());
    print("✅get service provider called");
    try {
      final response = await _dio.get('${ApiConsts.baseUrl}/serviceprovider/1');
      final serviceProvider = ServiceProvider.fromJson(response.data);
      print("✅get service provider success");
      print(response.data);
      emit(ServiceProviderLoaded(serviceProvider));
    } catch (e) {
      print("🔴${e.toString()}");
      emit(ServiceProviderError('Failed to load data: $e'));
    }
  }

  Future<void> addReview({
    required int providerId,
    required int rating,
    required String reviewText,
    int? bookingId,
  }) async {
    emit(ReviewLoading());

    try {
      final userId = await LocalStorageHelper.getUserId();

      if (userId == null) {
        emit(ReviewError("User ID not found in local storage."));
        return;
      }

      final dio = Dio();

      final response = await dio.post(
        'https://b778-156-221-49-37.ngrok-free.app/api/review',
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
        ),
        data: FormData.fromMap({
          'user_id': userId,
          'provider_id': providerId,
          'rating': rating,
          'review_text': reviewText,
          if (bookingId != null) 'booking_id': bookingId,
        }),
      );

      if (response.statusCode == 200) {
        emit(ReviewSuccess("Review submitted successfully"));
      } else {
        emit(ReviewError("Failed to submit review"));
      }
    } catch (e) {
      emit(ReviewError("Error: ${e.toString()}"));
    }
  }
}

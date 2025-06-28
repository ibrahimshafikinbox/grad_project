// booking_cubit.dart
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/Core/constants/api_consts.dart';
import 'package:grad_project/Feature/Booking/book_customer/cubit/booking_state.dart';
import 'package:intl/intl.dart';

class BookingCubit extends Cubit<BookingState> {
  final Dio dio;

  BookingCubit({required this.dio}) : super(BookingInitial());

  Future<void> createBooking({
    required String userId,
    required String providerId,
    required DateTime bookingDate,
  }) async {
    emit(BookingLoading());
    print("✅ create booking called");
    try {
      final response = await dio.post(
        '${ApiConsts.baseUrl}/booking',
        data: {
          "service_id": "2",
          'user_id': 6,
          'provider_id': 2,
          'booking_date': "2025-04-24T14:30",
          "status": "pending",
          "address": "123 Main St",
          "order_id": "1"
        },
      );

      final booking = Booking.fromJson(response.data);
      print("✅ create booking success");
      print(booking.bookingDate);
      emit(BookingCreated(booking));
    } on DioException catch (e) {
      print(e.response?.data);
      print(e.response?.statusCode);
      final errorMessage = e.response?.data?['message'] ?? 'Booking failed';
      print(errorMessage.toString());
      emit(BookingError(errorMessage));
    } catch (e) {
      print(e.toString());
      emit(BookingError('An unexpected error occurred'));
    }
  }
}

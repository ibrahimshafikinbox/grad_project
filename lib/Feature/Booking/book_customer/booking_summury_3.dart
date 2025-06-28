// import 'package:flutter/material.dart';
// import 'package:grad_project/Core/widget/app_Bar.dart';
// import 'package:grad_project/Feature/Booking/widget/success_pop_Up.dart';
// import 'package:grad_project/Feature/Booking/widget/summury_book_container.dart';
// import 'package:grad_project/Feature/Login/Widget/app_button.dart';
// import 'package:grad_project/Feature/resources/colors/colors.dart';
// import 'package:grad_project/Feature/resources/styles/app_sized_box.dart';
// import 'package:grad_project/Feature/resources/styles/app_text_style.dart';

// class ReviewSummaryScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColors.white,
//         appBar: const CustomAppBar(title: "Summary"),
//         body: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 AppSizedBox.sizedH15,
//                 const Text(
//                   "Review Summary",
//                   style: AppTextStyle.textStyleBoldBlack,
//                 ),
//                 AppSizedBox.sizedH15,
//                 const SummuryBookContainer(),
//                 AppSizedBox.sizedH40,
//                 const withoudimage(),
//                 AppSizedBox.sizedH20,
//                 AppButton(
//                   function: () {
//                     showOrderReceivedDialog(context);
//                   },
//                   text: 'Confirm',
//                   textColor: AppColors.white,
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }
// ReviewSummaryScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/Core/widget/app_Bar.dart';
import 'package:grad_project/Feature/Booking/book_customer/cubit/booking_cubit.dart';
import 'package:grad_project/Feature/Booking/book_customer/cubit/booking_state.dart';
import 'package:grad_project/Feature/Booking/widget/success_pop_Up.dart';
import 'package:grad_project/Feature/Login/Widget/app_button.dart';
import 'package:grad_project/Feature/resources/colors/colors.dart';
import 'package:grad_project/Feature/resources/styles/app_sized_box.dart';
import 'package:grad_project/Feature/resources/styles/app_text_style.dart';

class ReviewSummaryScreen extends StatelessWidget {
  final String userId;
  final String providerId;
  final String houseNumber;
  final String streetNumber;
  final String completeAddress;
  final DateTime bookingDate;

  const ReviewSummaryScreen({
    required this.userId,
    required this.providerId,
    required this.houseNumber,
    required this.streetNumber,
    required this.completeAddress,
    required this.bookingDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: "Summary"),
      body: BlocListener<BookingCubit, BookingState>(
        listener: (context, state) {
          if (state is BookingCreated) {
            showOrderReceivedDialog(context);
          } else if (state is BookingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSummaryItem('House Number', houseNumber),
              _buildSummaryItem('Street Number', streetNumber),
              _buildSummaryItem('Address', completeAddress),
              _buildSummaryItem('Date',
                  "${bookingDate.day}/${bookingDate.month}/${bookingDate.year}"),
              _buildSummaryItem('Time',
                  "${bookingDate.hour}:${bookingDate.minute.toString().padLeft(2, '0')}"),
              AppSizedBox.sizedH40,
              BlocBuilder<BookingCubit, BookingState>(
                builder: (context, state) {
                  if (state is BookingLoading) {
                    return const CircularProgressIndicator();
                  }
                  return AppButton(
                    function: () {
                      context.read<BookingCubit>().createBooking(
                            userId: userId,
                            providerId: providerId,
                            // houseNumber: houseNumber,
                            // streetNumber: streetNumber,
                            // completeAddress: completeAddress,
                            bookingDate: bookingDate,
                          );
                    },
                    text: 'Confirm Booking',
                    textColor: AppColors.white,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyle.textStyleMediumBlack),
          Text(value, style: AppTextStyle.textStyleMediumBlack),
        ],
      ),
    );
  }
}

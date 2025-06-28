import 'package:flutter/material.dart';
import 'package:grad_project/Core/Helper/naviagation_helper.dart';
import 'package:grad_project/Feature/Login/Widget/app_button.dart';
import 'package:grad_project/Feature/payment/payment_view.dart';
import 'package:grad_project/Feature/resources/colors/colors.dart';
import 'package:grad_project/Feature/resources/images/images.dart';
import 'package:grad_project/Feature/resources/styles/app_sized_box.dart';
import 'package:grad_project/Feature/resources/styles/app_text_style.dart';

class PaidBuildContainer extends StatelessWidget {
  const PaidBuildContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(AssetsHelper.personIcon),
                AppSizedBox.sizedW15,
                const Text("Caepenter", style: AppTextStyle.textStyleBoldBlack),
              ],
            ),
            const Divider(),
            const Row(
              children: [
                Text(
                  "Amount to pay ",
                  style: AppTextStyle.textStyleBoldBlack,
                ),
                Spacer(),
                Text(
                  "\$200.00",
                  style: AppTextStyle.textStylesemiBoldBlue,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Booking date ",
                  style: AppTextStyle.textStyleBoldBlack,
                ),
                Spacer(),
                Text(
                  "July 23, 2025",
                  style: AppTextStyle.textStyleBoldBlack,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Carpenter name",
                  style: AppTextStyle.textStyleBoldBlack,
                ),
                Spacer(),
                Text(
                  "Ibrahim shafik",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      color: Color(0XFF165BB3)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:grad_project/Feature/Login/Widget/app_button.dart';
import 'package:grad_project/Feature/resources/colors/colors.dart';
import 'package:grad_project/Feature/resources/styles/app_sized_box.dart';
import 'package:grad_project/Feature/resources/styles/app_text_style.dart';

class SuccessWidget extends StatelessWidget {
  const SuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            AppSizedBox.sizedH100,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/img/four_check_star_mark_circles 1.png"),
              ],
            ),
            const Text(
              "Successfully",
              style: AppTextStyle.textStylesemiBoldBlue,
            ),
            const Text(
              "your account has been created",
              style: AppTextStyle.textStyleMediumBlack,
            ),
            AppSizedBox.sizedH15,
            AppButton(
              function: () {},
              text: "Continue",
              textColor: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:grad_project/Feature/Home_Screen/View/home_view.dart';
import 'package:grad_project/Feature/Login/Widget/app_button.dart';
import 'package:grad_project/Feature/Otp/widget/otp_input_field.dart';
import 'package:grad_project/Feature/resources/colors/colors.dart';
import 'package:grad_project/Feature/resources/images/images.dart';
import 'package:grad_project/Feature/resources/styles/app_sized_box.dart';
import 'package:grad_project/Feature/resources/styles/app_text_style.dart';
import 'package:grad_project/Feature/Main/View/main_view.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.navigate_before,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            Center(
              child: Image.asset(
                AssetsHelper.logoWithText,
                height: 150,
              ),
            ),
            AppSizedBox.sizedH30,
            const Text(
              "Verification Code",
              style: AppTextStyle.textStylesemiBoldBlue,
            ),
            AppSizedBox.sizedH10,
            const Text(
              "We just send you a verify code. Check your inbox to get them.",
              style: AppTextStyle.textStyleMediumBlack,
            ),
            AppSizedBox.sizedH15,
            OTPInputWidget(otpController: TextEditingController()),
            AppSizedBox.sizedH15,
            AppButton(
              function: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MainView()), // Replace with your next screen
                );
              },
              text: "Continue",
              textColor: AppColors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Re-send code",
                    style: AppTextStyle.textStyleMediumBlack,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

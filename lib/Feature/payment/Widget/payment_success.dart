import 'package:flutter/material.dart';
import 'package:grad_project/Feature/resources/colors/colors.dart';
import 'package:grad_project/Feature/resources/images/images.dart';
import 'package:grad_project/Feature/resources/styles/app_sized_box.dart';
import 'package:grad_project/Feature/resources/styles/app_text_style.dart';

class paymentSuceesWidget extends StatelessWidget {
  const paymentSuceesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              AssetsHelper.changePassSuccess,
            ),
          ),
          AppSizedBox.sizedH25,
          const Text('Your payment was \n      successful!',
              style: AppTextStyle.textStyleBoldBlack20),
        ],
      ),
    );
  }
}

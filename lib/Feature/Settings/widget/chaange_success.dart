import 'package:flutter/material.dart';
import 'package:grad_project/Feature/resources/images/images.dart';
import 'package:grad_project/Feature/resources/styles/app_sized_box.dart';
import 'package:grad_project/Feature/resources/styles/app_text_style.dart';

class PasswordChangedSuccessfully extends StatelessWidget {
  const PasswordChangedSuccessfully({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              AssetsHelper.changePassSuccess,
              height: 100,
            ),
          ),
          AppSizedBox.sizedH25,
          const Text('Password Has Been',
              style: AppTextStyle.textStyleBoldBlack20),
          const Text('Changed Successfully',
              style: AppTextStyle.textStyleBoldBlack20),
        ],
      ),
    );
  }
}

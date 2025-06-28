import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grad_project/Core/Helper/naviagation_helper.dart';
import 'package:grad_project/Feature/Login/Widget/app_button.dart';
import 'package:grad_project/Feature/payment/payment_view.dart';
import 'package:grad_project/Feature/resources/colors/colors.dart';
import 'package:grad_project/Feature/resources/images/images.dart';
import 'package:grad_project/Feature/resources/styles/app_text_style.dart';

void showOrderReceivedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              AssetsHelper.changePassSuccess,
              height: 70,
            ),
            Text(
              'Order received',
              style: AppTextStyle.textStyleBoldBlack20,
            ),
            SizedBox(height: 10),
            Text(
              'Your order for the Booking the\nCarpinter has received, ',
              style: AppTextStyle.textStyleMediumAppBlack,
            ),
            SizedBox(height: 20),
            DefaultButton(
                function: () {
                  navigateTo(context, PaymentView());
                },
                text: "Payment",
                textColor: AppColors.white),
          ],
        ),
      );
    },
  );
}

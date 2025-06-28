import 'package:flutter/material.dart';
import 'package:grad_project/Core/Helper/Payment_manager/paymob_helper.dart';
import 'package:grad_project/Core/Helper/naviagation_helper.dart';
import 'package:grad_project/Feature/Login/Widget/app_button.dart';
import 'package:grad_project/Feature/payment/Widget/payment_success.dart';
import 'package:grad_project/Feature/resources/colors/colors.dart';
import 'package:grad_project/Feature/resources/styles/app_text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({Key? key}) : super(key: key);

  Future<void> handlePayment(BuildContext context) async {
    try {
      final paymob = PaymobManager();
      final String paymentKey = await paymob.getPaymentKey(150, "EGP");
      final String paymentUrl = paymob.getPaymentUrl(paymentKey);

      final Uri uri = Uri.parse(paymentUrl);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch payment URL';
      }
    } catch (e) {
      print("Payment failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("فشل في الدفع. حاول مرة أخرى")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(height: 15),
            const Text(
              "طريقة الدفع",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            const SizedBox(height: 10),
            AppButton(
              function: () {
                handlePayment(context);
              },
              textColor: AppColors.white,
              text: "بطاقة ائتمان",
            ),
            const SizedBox(height: 20),
            paymentBuildRow(text: 'المجموع', value: '150 EGP'),
            const SizedBox(height: 10),
            paymentBuildRow(text: 'رسوم البطاقة', value: '5 EGP'),
            const SizedBox(height: 10),
            paymentBuildRow(text: 'الخصم', value: '0 EGP'),
            const SizedBox(height: 10),
            paymentBuildRow(text: 'الإجمالي', value: '155 EGP'),
            const SizedBox(height: 20),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0XFF165BB3)),
              onPressed: () {
                handlePayment(context);
              },
              child: Text(
                "تأكيد الدفع",
                style: AppTextStyle.textStyleWhiteMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class paymentBuildRow extends StatelessWidget {
  final String text;
  final String value;

  const paymentBuildRow({
    Key? key,
    required this.text,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: AppTextStyle.textStyleMediumAppBlack,
        ),
        const Spacer(),
        Text(
          value,
          style: AppTextStyle.textStyleMediumGray,
        ),
      ],
    );
  }
}

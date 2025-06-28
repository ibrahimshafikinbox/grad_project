import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OTPInputWidget extends StatelessWidget {
  final TextEditingController otpController;

  const OTPInputWidget({super.key, required this.otpController});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 80,
      height: 55,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: const Color(0x0f1a1d1f),
        borderRadius: BorderRadius.circular(
          8,
        ),
      ),
    );

    return Center(
      child: Pinput(
        length: 4,
        controller: otpController,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color.fromARGB(
                255,
                3,
                32,
                56,
              ),
            ),
          ),
        ),
        submittedPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              8,
            ),
            border: Border.all(
              color: Colors.green,
            ),
          ),
        ),
        showCursor: true,
      ),
    );
  }
}

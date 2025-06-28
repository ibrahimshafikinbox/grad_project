import 'package:flutter/material.dart';
import 'dart:async';

import 'package:grad_project/Feature/Login/view/select_way.dart';
import 'package:grad_project/Feature/On_Boarding/View/on_boarding.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/img/splash_logo.png",
              width: 100,
            ),
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              "assets/img/ProServe.png",
              width: 80,
            )
          ],
        ),
      ),
    );
  }
}

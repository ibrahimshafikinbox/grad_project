import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:grad_project/Core/Localizations/app_localizatios.dart';
import 'package:grad_project/Feature/Login/view/select_way.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  void _skip() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => SelectAuthWayView(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context); // Safe usage

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              OnboardingPage(
                imagePath: 'assets/img/Group 33302.png',
                title: localizations.translate("onboarding_title_1"),
                description:
                    localizations.translate("onboarding_description_1"),
              ),
              OnboardingPage(
                imagePath: 'assets/img/image 2361.png',
                title: localizations.translate("onboarding_title_2"),
                description:
                    localizations.translate("onboarding_description_2"),
              ),
            ],
          ),
          Positioned(
            top: 40.0,
            right: 20.0,
            child: TextButton(
              onPressed: _skip,
              child: Text(
                localizations.translate("skip"),
                style: TextStyle(color: Colors.blue, fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingPage({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 200,
            width: 200,
          ),
          SizedBox(height: 20.0),
          Text(
            title,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          Text(
            description,
            style: TextStyle(fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

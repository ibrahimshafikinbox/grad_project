import 'package:flutter/material.dart';
import 'package:grad_project/Core/Localizations/app_localizatios.dart';
import 'package:grad_project/Feature/Login/Widget/app_button.dart';
import 'package:grad_project/Feature/Login/view/Login_view.dart';
import 'package:grad_project/Feature/create_acc/create_acc_view.dart';

class SelectAuthWayView extends StatefulWidget {
  const SelectAuthWayView({super.key});

  @override
  State<SelectAuthWayView> createState() => _SelectAuthWayViewState();
}

class _SelectAuthWayViewState extends State<SelectAuthWayView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/img/appLogo_blue.png"),
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              "assets/img/ProServe _blue.png",
              width: 100,
            ),
            const SizedBox(
              height: 100,
            ),
            DefaultButton(
              text: AppLocalizations.of(context).translate("sign_in"),
              function: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LoginView(),
                ));
              },
              textColor: Colors.white,
            ),
            const SizedBox(
              height: 20,
            ),
            DefaultButton(
              text: AppLocalizations.of(context).translate("sign_up"),
              function: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const CreateAccountView(),
                ));
              },
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

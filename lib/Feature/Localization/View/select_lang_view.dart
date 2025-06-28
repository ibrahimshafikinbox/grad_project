import 'package:flutter/material.dart';

class SelectLangView extends StatefulWidget {
  const SelectLangView({super.key});

  @override
  State<SelectLangView> createState() => _SelectLangViewState();
}

class _SelectLangViewState extends State<SelectLangView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Image.asset("assets/img/appLogo_blue.png"),
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              "assets/img/ProServe _blue.png",
              width: 100,
            ),
            const SizedBox(
              height: 50,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Language",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.asset("assets/img/Ar.png"),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Arabic",
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.asset("assets/img/En.png"),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "English",
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Image.asset("assets/img/amico.png")
          ],
        ),
      ),
    );
  }
}

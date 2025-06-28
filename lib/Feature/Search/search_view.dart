import 'package:flutter/material.dart';
import 'package:grad_project/Feature/Home_Screen/Widget/product_Item.dart';
import 'package:grad_project/Feature/resources/colors/colors.dart';
import 'package:grad_project/Feature/resources/styles/app_sized_box.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.white,
          body: Column(
            children: [
              AppSizedBox.sizedH25,
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.blue),
                  ),
                ),
              ),
              AppSizedBox.sizedH15,
              // const ServiceCard(imagePath: '', discountText: '', serviceName: '', rating: null,),
              // AppSizedBox.sizedH15,
              // ServiceCard(),
              // AppSizedBox.sizedH15,
              // ServiceCard(),
              // AppSizedBox.sizedH15,
              // ServiceCard(),
              // AppSizedBox.sizedH15,
            ],
          )),
    );
  }
}

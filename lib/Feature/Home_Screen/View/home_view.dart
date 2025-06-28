import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/Core/Helper/naviagation_helper.dart';
import 'package:grad_project/Core/Localizations/app_localizatios.dart';
import 'package:grad_project/Feature/Home_Screen/Cubit/home_cubit.dart';
import 'package:grad_project/Feature/Home_Screen/Cubit/home_state.dart';
import 'package:grad_project/Feature/Home_Screen/Widget/category_screen.dart';
import 'package:grad_project/Feature/Home_Screen/Widget/catrgories_widget.dart';
import 'package:grad_project/Feature/Home_Screen/Widget/product_Item.dart';
import 'package:grad_project/Feature/Search/search_view.dart';

import 'package:grad_project/Feature/provider_profile/view/profile_view.dart';
import 'package:grad_project/Feature/resources/images/images.dart';
import 'package:grad_project/Feature/resources/styles/app_sized_box.dart';
import 'package:grad_project/Feature/resources/styles/app_text_style.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()
        ..getCategories()
        ..getTopServices(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            children: [
              _buildHeaderSection(),
              _buildCategoriesSection(),
              _buildServicesSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Stack(
      children: [
        ClipRRect(
          child: Image.asset(
            AssetsHelper.homeScreenImage,
            width: double.infinity,
            height: 200,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: 20,
          left: 20,
          right: 20,
          child: Container(
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
            child: GestureDetector(
              onDoubleTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchView()),
                );
              },
              child: TextField(
                decoration: InputDecoration(
                  hintText:
                      AppLocalizations.of(context).translate("search_hint"),
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is CategoryLoading ||
          current is CategorySuccess ||
          current is CategoryError,
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategorySuccess) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                        AppLocalizations.of(context)
                            .translate("categories_title"),
                        style: AppTextStyle.textStylesemiBoldBlue),
                    Spacer(),
                    TextButton(
                        onPressed: () {
                          navigateTo(context, CategoryView());
                        },
                        child: Text(
                          AppLocalizations.of(context).translate("see_all"),
                          style: TextStyle(color: Colors.blue),
                        ))
                  ],
                ),
                //                "search_hint": "ابحث هنا",
                // "categories_title": "الفئات",
                // "see_all": "عرض الكل",
                // "top_services_title": "الخدمات المميزة",
                // "loading": "جاري التحميل...",
                // "error_loading_data": "حدث خطأ أثناء تحميل البيانات"
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CategoriesWidget(
                          image: category.image ?? '',
                          title: category.categoryName,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is CategoryError) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildServicesSection() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is TopServicesLoading ||
          current is TopServicesSuccess ||
          current is TopServicesError,
      builder: (context, state) {
        if (state is TopServicesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TopServicesSuccess) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                        AppLocalizations.of(context)
                            .translate("top_services_title"),
                        style: AppTextStyle.textStylesemiBoldBlue),
                    const Spacer(),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.of(context).translate("see_all"),
                          style: const TextStyle(color: Colors.blue),
                        ))
                  ],
                ),
                AppSizedBox.sizedH10,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.services.length,
                  itemBuilder: (context, index) {
                    final service = state.services[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProviderProfileView(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ServiceCard(
                          imagePath: service.image ?? '',
                          discountText: "",
                          serviceName: service.name,
                          rating: 2,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        } else if (state is TopServicesError) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return const SizedBox(); // Initial state
      },
    );
  }
}

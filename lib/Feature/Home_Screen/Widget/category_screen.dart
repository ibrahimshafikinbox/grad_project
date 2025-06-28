import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/Feature/Home_Screen/Cubit/home_cubit.dart';
import 'package:grad_project/Feature/Home_Screen/Cubit/home_state.dart';
import 'package:grad_project/Feature/Home_Screen/Widget/catrgories_widget.dart';
import 'package:grad_project/Feature/resources/colors/colors.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  void initState() {
    super.initState();
    // Fetch categories when the screen loads
    context.read<HomeCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text("Categories"),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            current is CategoryLoading ||
            current is CategorySuccess ||
            current is CategoryError,
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<HomeCubit>().getCategories(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is CategorySuccess) {
            return _buildCategoriesGrid(state.categories);
          }
          return const Center(child: Text('No categories available'));
        },
      ),
    );
  }

  Widget _buildCategoriesGrid(List<CategoryModel> categories) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.9, // Adjust based on your item's aspect ratio
        ),
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final category = categories[index];
          return CategoriesWidget(
            image: category.image ?? '',
            title: category.categoryName,
          );
        },
      ),
    );
  }
}

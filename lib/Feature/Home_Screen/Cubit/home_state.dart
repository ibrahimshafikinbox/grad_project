import 'package:grad_project/Feature/Home_Screen/Model/service_model.dart';

class CategoryModel {
  final int categoryId;
  final String categoryName;
  final String? image;
  final DateTime createdAt;
  final DateTime updatedAt;

  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

abstract class HomeState {}

class CategoryInitial extends HomeState {}

class CategoryLoading extends HomeState {}

class CategorySuccess extends HomeState {
  final List<CategoryModel> categories;

  CategorySuccess(this.categories);
}

class CategoryError extends HomeState {
  final String message;

  CategoryError(this.message);
}

class TopServicesLoading extends HomeState {}

class TopServicesSuccess extends HomeState {
  final List<ServiceModel> services;
  TopServicesSuccess(this.services);
}

class TopServicesError extends HomeState {
  final String message;
  TopServicesError(this.message);
}

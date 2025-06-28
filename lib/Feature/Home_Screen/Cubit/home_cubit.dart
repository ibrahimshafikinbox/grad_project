import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:grad_project/Core/constants/api_consts.dart';
import 'package:grad_project/Feature/Home_Screen/Cubit/home_state.dart';
import 'package:grad_project/Feature/Home_Screen/Model/service_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(CategoryInitial());

  final Dio dio = Dio();

  Future<void> getCategories() async {
    emit(CategoryLoading());
    try {
      final response =
          await dio.get('${ApiConsts.baseUrl}${ApiConsts.categories}');
      final List data = response.data;

      final categories =
          data.map((json) => CategoryModel.fromJson(json)).toList();
      print('Categories: ${categories.first.image}');

      emit(CategorySuccess(categories));
    } catch (e) {
      print('Error: $e');
      emit(CategoryError(' Failed to load categories: $e'));
    }
  }

  Future<void> getTopServices() async {
    print("✅top service called");
    emit(TopServicesLoading());

    try {
      final response = await Dio().get(
        '${ApiConsts.baseUrl}${ApiConsts.topServices}',
      );

      if (response.statusCode == 200 && response.data['status'] == true) {
        final List<ServiceModel> services = (response.data['data'] as List)
            .map((e) => ServiceModel.fromJson(e))
            .toList();
        print("✅top services sucess");
        print(services.first.image);
        emit(TopServicesSuccess(services));
      } else {
        emit(TopServicesError(response.data['message'] ?? 'Unknown error'));
      }
    } catch (e) {
      print(e.toString());
      emit(TopServicesError('Failed to fetch services: $e'));
    }
  }
}

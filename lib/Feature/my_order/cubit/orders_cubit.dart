import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:grad_project/Core/constants/api_consts.dart';
import 'package:grad_project/Feature/my_order/Model/oders_model.dart';
import 'package:grad_project/Feature/my_order/cubit/orders_state.dart';

class GetOrdersCubit extends Cubit<GetOrdersState> {
  GetOrdersCubit() : super(GetOrdersInitial());

  Future<void> fetchGetOrders(int id) async {
    print(" ✅ ✅ method get orders called");

    emit(GetOrdersLoading());
    try {
      final response = await Dio().get('${ApiConsts.baseUrl}/booking/4');
      print(response.data); // This is fin

      final getOrdersModel = OrdersModel.fromJson(response.data);
      print(" ✅ get orders success");

      emit(GetOrdersLoaded(getOrdersModel));
    } catch (e) {
      print(e.toString());
      emit(GetOrdersError('Failed to load GetOrders: ${e.toString()}'));
    }
  }
}

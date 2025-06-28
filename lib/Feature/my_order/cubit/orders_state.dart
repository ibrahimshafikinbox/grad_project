import 'package:grad_project/Feature/my_order/Model/oders_model.dart';

abstract class GetOrdersState {}

class GetOrdersInitial extends GetOrdersState {}

class GetOrdersLoading extends GetOrdersState {}

class GetOrdersLoaded extends GetOrdersState {
  final OrdersModel GetOrders;

  GetOrdersLoaded(this.GetOrders);
}

class GetOrdersError extends GetOrdersState {
  final String message;

  GetOrdersError(this.message);
}

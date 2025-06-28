import 'package:grad_project/Feature/provider_profile/Model/service_provider_model.dart';

abstract class ServiceProviderState {}

class ServiceProviderInitial extends ServiceProviderState {}

class ServiceProviderLoading extends ServiceProviderState {}

class ServiceProviderLoaded extends ServiceProviderState {
  final ServiceProvider serviceProvider;

  ServiceProviderLoaded(this.serviceProvider);
}

class ServiceProviderError extends ServiceProviderState {
  final String message;

  ServiceProviderError(this.message);
}

class ReviewLoading extends ServiceProviderState {}

class ReviewSuccess extends ServiceProviderState {
  final String message;

  ReviewSuccess(this.message);
}

class ReviewError extends ServiceProviderState {
  final String error;

  ReviewError(this.error);
}

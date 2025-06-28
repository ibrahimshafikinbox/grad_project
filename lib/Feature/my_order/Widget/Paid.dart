import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/Core/Localizations/app_localizatios.dart';
import 'package:grad_project/Feature/my_order/cubit/orders_cubit.dart';
import 'package:grad_project/Feature/my_order/cubit/orders_state.dart';
import 'package:grad_project/Feature/my_order/Model/oders_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PaidServicesView extends StatelessWidget {
  final int userId;

  const PaidServicesView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOrdersCubit, GetOrdersState>(
      builder: (context, state) {
        if (state is GetOrdersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetOrdersLoaded) {
          // Filter paid orders (adjust condition based on your status values)
          final isPaid = state.GetOrders.order.status.toLowerCase() == 'paid';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  AppLocalizations.of(context).translate("paid_services_title"),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              if (isPaid)
                PaidBuildContainer(order: state.GetOrders)
              else
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(AppLocalizations.of(context)
                      .translate("no_paid_services")),
                ),
            ],
          );
        } else if (state is GetOrdersError) {
          return Center(child: Text(state.message));
        }
        return Center(
            child:
                Text(AppLocalizations.of(context).translate("loading_error")));
      },
    );
  }
}

class PaidBuildContainer extends StatelessWidget {
  final OrdersModel order;

  const PaidBuildContainer({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: order.service.image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.service.serviceName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order.provider.phone,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context).translate("amount"),
                style: TextStyle(color: Colors.grey[600]),
              ),
              Text(
                "\$${order.order.amount.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context).translate("status"),
                style: TextStyle(color: Colors.grey[600]),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order.order.status,
                  style: const TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

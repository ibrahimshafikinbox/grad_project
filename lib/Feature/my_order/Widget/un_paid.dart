import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/Core/Localizations/app_localizatios.dart';
import 'package:grad_project/Feature/my_order/cubit/orders_cubit.dart';
import 'package:grad_project/Feature/my_order/cubit/orders_state.dart';
import 'package:grad_project/Feature/my_order/Model/oders_model.dart';
import 'package:grad_project/Core/Helper/naviagation_helper.dart';
import 'package:grad_project/Feature/Login/Widget/app_button.dart';
import 'package:grad_project/Feature/payment/payment_view.dart';
import 'package:grad_project/Feature/resources/colors/colors.dart';
import 'package:grad_project/Feature/resources/styles/app_sized_box.dart';
import 'package:grad_project/Feature/resources/styles/app_text_style.dart';

class UnPaidServicesView extends StatelessWidget {
  final int userId;

  const UnPaidServicesView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOrdersCubit, GetOrdersState>(
      builder: (context, state) {
        if (state is GetOrdersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetOrdersLoaded) {
          final isUnpaid =
              state.GetOrders.order.status.toLowerCase() == 'unpaid';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppLocalizations.of(context)
                      .translate("unpaid_services_title"),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              if (isUnpaid)
                UnPaidBuildContainer(order: state.GetOrders)
              else
                Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      AppLocalizations.of(context)
                          .translate("no_unpaid_services"),
                    )),
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

class UnPaidBuildContainer extends StatelessWidget {
  final OrdersModel order;

  const UnPaidBuildContainer({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: order.service.image ?? "",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                AppSizedBox.sizedW15,
                Text(
                  order.service.serviceName,
                  style: AppTextStyle.textStyleBoldBlack,
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context).translate("amount_to_pay"),
                  style: AppTextStyle.textStyleBoldBlack,
                ),
                const Spacer(),
                Text(
                  "\$${order.order.amount.toStringAsFixed(2)}",
                  style: AppTextStyle.textStylesemiBoldBlue,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context).translate("amount_to_pay"),
                  style: AppTextStyle.textStyleBoldBlack,
                ),
                const Spacer(),
                Text(
                  order.order
                      .orderDate, // Assuming your order model has a date field
                  style: AppTextStyle.textStyleBoldBlack,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context).translate("provider_name"),
                  style: AppTextStyle.textStyleBoldBlack,
                ),
                const Spacer(),
                Text(
                  order.provider
                      .location, // Assuming your provider model has a name field
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      color: Color(0XFF165BB3)),
                ),
              ],
            ),
            AppButton(
                function: () {
                  navigateTo(context, const PaymentView());
                },
                text: AppLocalizations.of(context).translate("pay_now"),
                textColor: AppColors.white)
          ],
        ),
      ),
    );
  }
}

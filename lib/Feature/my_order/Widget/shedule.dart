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
import 'package:grad_project/Feature/resources/images/images.dart';
import 'package:grad_project/Feature/resources/styles/app_sized_box.dart';
import 'package:grad_project/Feature/resources/styles/app_text_style.dart';

class SheduleServicesView extends StatelessWidget {
  final int userId;

  const SheduleServicesView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOrdersCubit, GetOrdersState>(
      builder: (context, state) {
        if (state is GetOrdersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetOrdersLoaded) {
          // Filter Shedule orders (adjust condition based on your status values)
          final isShedule =
              state.GetOrders.order.status.toLowerCase() == 'Shedule';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  AppLocalizations.of(context).translate("schedule_services"),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              if (isShedule)
                SheduleBuildContainer(order: state.GetOrders)
              else
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      AppLocalizations.of(context)
                          .translate("no_schedule_services"),
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

class SheduleBuildContainer extends StatelessWidget {
  final OrdersModel order;

  const SheduleBuildContainer({super.key, required this.order});

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
                  child: Image.network(
                    order.service.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
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
                //                   "Paid Services",
//                     "unpaid_services_title": "الخدمات غير المدفوعة",
//   "no_unpaid_services": "لا توجد خدمات غير مدفوعة حالياً",

//   "paid_services_title": "الخدمات المدفوعة",
//   "no_paid_services": "لا توجد خدمات مدفوعة",
//   "amount": "المبلغ:",
//   "status": "الحالة:",
//     "":"_______________________________________________________________________________________________",
// "schedule_services": "الخدمات المجدولة",
//   "no_schedule_services": "لا توجد خدمات مجدولة حالياً",
//   "amount_to_pay": "المبلغ المطلوب",
//   "booking_date": "تاريخ الحجز",
//   "provider_name": "اسم المزود",
//   "": "ادفع الآن"
                Text(
                  "\$${order.order.amount.toStringAsFixed(2)}",
                  style: AppTextStyle.textStylesemiBoldBlue,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context).translate("booking_date"),
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
                  navigateTo(context, PaymentView());
                },
                text: AppLocalizations.of(context).translate("pay_now"),
                textColor: AppColors.white)
          ],
        ),
      ),
    );
  }
}

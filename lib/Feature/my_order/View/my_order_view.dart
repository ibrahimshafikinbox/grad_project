import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/Core/Localizations/app_localizatios.dart';
import 'package:grad_project/Feature/my_order/Widget/Paid.dart';
import 'package:grad_project/Feature/my_order/Widget/shedule.dart';
import 'package:grad_project/Feature/my_order/Widget/un_paid.dart';
import 'package:grad_project/Feature/my_order/cubit/orders_cubit.dart';

class MyOrderView extends StatefulWidget {
  final int userId;

  const MyOrderView({super.key, required this.userId});

  @override
  State<MyOrderView> createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView> {
  int selectedIndex = 0;
  List<String> tabTitles = [];

  @override
  void initState() {
    super.initState();
    context.read<GetOrdersCubit>().fetchGetOrders(widget.userId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabTitles = [
      AppLocalizations.of(context).translate("tab_unpaid"),
      AppLocalizations.of(context).translate("tab_paid"),
      AppLocalizations.of(context).translate("tab_schedule"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          AppLocalizations.of(context).translate("my_orders"),
          style: const TextStyle(
            color: Color(0Xff165BB3),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(tabTitles.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      width: 110,
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? const Color(0Xff165BB3)
                            : const Color(0XFFF5F5F5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          tabTitles[index],
                          style: TextStyle(
                            color: selectedIndex == index
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: [
                UnPaidServicesView(userId: widget.userId),
                PaidServicesView(userId: widget.userId),
                SheduleServicesView(userId: widget.userId),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

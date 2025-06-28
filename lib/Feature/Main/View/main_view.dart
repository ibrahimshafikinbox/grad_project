import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:grad_project/Core/Localizations/app_localizatios.dart';
import 'package:grad_project/Feature/Chat/View/chat_lsit_view.dart';
import 'package:grad_project/Feature/my_order/View/my_order_view.dart';
import 'package:grad_project/Feature/Home_Screen/View/home_view.dart';
import 'package:grad_project/Feature/Profile/View/profile_view.dart';
import 'package:grad_project/Feature/resources/images/images.dart';
import 'package:grad_project/Feature/Main/Cubit/maion_cubit.dart';

class MainView extends StatefulWidget {
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<BottomNavCubit, int>(
          builder: (context, state) {
            return Center(
              child: _getPage(state),
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<BottomNavCubit, int>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CurvedNavigationBar(
                  index: state, // Use the state from Cubit
                  height: 70.0,
                  items: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AssetsHelper.homeIcon, height: 35),
                        Text(AppLocalizations.of(context).translate("nav_home"),
                            style:
                                TextStyle(color: Colors.black, fontSize: 12)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AssetsHelper.bookingIcon, height: 35),
                        Text(
                            AppLocalizations.of(context)
                                .translate("nav_booking"),
                            style:
                                TextStyle(color: Colors.black, fontSize: 12)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AssetsHelper.bookingIcon, height: 35),
                        Text(AppLocalizations.of(context).translate("nav_chat"),
                            style:
                                TextStyle(color: Colors.black, fontSize: 12)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AssetsHelper.personIcon, height: 35),
                        Text(
                            AppLocalizations.of(context)
                                .translate("nav_profile"),
                            style:
                                TextStyle(color: Colors.black, fontSize: 12)),
                      ],
                    ),
                  ],
                  color: const Color(0XFFF7FAFE),
                  backgroundColor: Colors.transparent,
                  animationCurve: Curves.easeInSine,
                  animationDuration: const Duration(milliseconds: 350),
                  onTap: (index) {
                    context.read<BottomNavCubit>().updateIndex(index);
                  },
                  letIndexChange: (index) => true,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return const MyOrderView(
          userId: 4,
        );
      case 2:
        return const ChatListView();
      case 3:
        return const ProfileView();
      default:
        return const HomeView();
    }
  }
}

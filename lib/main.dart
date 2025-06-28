import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/Feature/Booking/book_customer/cubit/booking_cubit.dart';
import 'package:grad_project/Feature/Chat/Cubit/chat_cubit.dart';
import 'package:grad_project/Feature/Home_Screen/Cubit/home_cubit.dart';
import 'package:grad_project/Feature/Login/cubit/login_cubit.dart';
import 'package:grad_project/Feature/Login/view/Login_view.dart';
import 'package:grad_project/Feature/Profile/cubit/usera_profile_cubit.dart';
import 'package:grad_project/Feature/Settings/cubit/settings_cubit.dart';

import 'package:grad_project/Feature/View/splash_view.dart';
import 'package:grad_project/Feature/create_acc/cubit/create_cubit.dart';
import 'package:grad_project/Feature/my_order/cubit/orders_cubit.dart';
import 'package:grad_project/Feature/payment/payment_view.dart';
import 'package:grad_project/Feature/provider_profile/cubit/provider_pprfile_cubit.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (_) => CreateAccountCubit()),
//         BlocProvider(create: (_) => HomeCubit()),
//         BlocProvider(create: (_) => ServiceProviderCubit()),
//         BlocProvider(create: (_) => GetOrdersCubit()),
//         BlocProvider(create: (_) => SettingsCubit(dio: Dio())),
//         BlocProvider(create: (_) => LoginCubit()),
//         BlocProvider(create: (_) => GetProfileCubit()),
//         BlocProvider(create: (_) => ChatCubit()),
//         BlocProvider(create: (_) => BookingCubit(dio: Dio())),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Grad Project',
//         home: SplashView(),
//       ),
//     );
//   }
// }

import 'package:grad_project/Core/Localizations/app_localizatios.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Removed duplicate import of login_cubit.dart

import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  // Load the saved locale from SharedPreferences
  _loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode');
    if (languageCode != null) {
      setLocale(Locale(languageCode));
    }
  }

  setLocale(Locale locale) async {
    setState(() {
      _locale = locale;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CreateAccountCubit()),
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => ServiceProviderCubit()),
        BlocProvider(create: (_) => GetOrdersCubit()),
        BlocProvider(create: (_) => SettingsCubit(dio: Dio())),
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => GetProfileCubit()),
        BlocProvider(create: (_) => ChatCubit()),
        BlocProvider(create: (_) => BookingCubit(dio: Dio())),
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          supportedLocales: [
            Locale('en'),
            Locale('ar'),
            Locale('fr'),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: Locale("ar"),
          title: ' Demo',
          home: LoginView()),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:grad_project/Feature/Login/Widget/app_button.dart';
// import 'package:grad_project/Feature/Login/Widget/default_form_field.dart';
// import 'package:grad_project/Feature/Otp/View/otp_view.dart';
// import 'package:grad_project/Feature/create_acc/create_acc_view.dart';

// class LoginView extends StatefulWidget {
//   const LoginView({super.key});

//   @override
//   State<LoginView> createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView> {
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController nameController =
//       TextEditingController(); // For registration
//   bool isRegisterMode = false;

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 50,
//             ),
//             Image.asset("assets/img/appLogo_blue.png"),
//             Image.asset("assets/img/ProServe _blue.png"),
//             const SizedBox(
//               height: 20,
//             ),
//             DefaultFormField(
//               controller: emailController,
//               type: TextInputType.emailAddress,
//               hint: 'user@gmail.com',
//               onValidate: (String? value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter your email';
//                 } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                   return 'Please enter a valid email';
//                 }
//                 return null;
//               },
//               label: 'Email',
//               maxlines: 1,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             passwordFormField(
//               controller: passwordController,
//               type: TextInputType.visiblePassword,
//               label: "password",
//               hint: '********************',
//               // suffix: LoginCubit.get(context).suffix,
//               // isPassword: LoginCubit.get(context).isPassword,
//               prefix: Icons.lock_outline,
//               suffixPressed: () {
//                 // LoginCubit.get(context).changePasswordVisibility();
//               },
//               onValidate: (String? value) {
//                 if (value == null || value.isEmpty) {
//                   return 'enter Your Password';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             DefaultButton(
//               function: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                           OtpView()), // Replace with your next screen
//                 );
//               },
//               text: "Sign In",
//               textColor: Colors.white,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text("Create a New Account?"),
//                 TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pushReplacement(MaterialPageRoute(
//                         builder: (context) => CreateAccountView(),
//                       ));
//                     },
//                     child: const Text(
//                       " Sign up",
//                       style: TextStyle(color: Colors.blue),
//                     ))
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/Core/Localizations/app_localizatios.dart';
import 'package:grad_project/Feature/Home_Screen/View/home_view.dart';
import 'package:grad_project/Feature/Login/Widget/app_button.dart';
import 'package:grad_project/Feature/Login/Widget/default_form_field.dart';
import 'package:grad_project/Feature/Main/View/main_view.dart';
import 'package:grad_project/Feature/Otp/View/otp_view.dart';
import 'package:grad_project/Feature/create_acc/create_acc_view.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../Cubit/login_cubit.dart';
import '../Cubit/login_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainView()),
            );
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<LoginCubit>(context);

          return Scaffold(
            backgroundColor: Colors.white,
            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Image.asset("assets/img/appLogo_blue.png"),
                    Image.asset("assets/img/ProServe _blue.png"),
                    const SizedBox(height: 50),
                    DefaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      hint:
                          AppLocalizations.of(context).translate("email_hint"),
                      onValidate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)
                              .translate("email_invalid_error");
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return AppLocalizations.of(context)
                              .translate("email_invalid_error");
                        }
                        return null;
                      },
                      label:
                          AppLocalizations.of(context).translate("email_label"),
                      maxlines: 1,
                    ),
                    const SizedBox(height: 20),
                    passwordFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      label: AppLocalizations.of(context)
                          .translate("password_label"),
                      hint: AppLocalizations.of(context)
                          .translate("password_hint"),
                      prefix: Icons.lock_outline,
                      suffixPressed: () {},
                      onValidate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)
                              .translate("password_empty_error");
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ConditionalBuilder(
                      condition: state is! LoginLoading,
                      builder: (context) => DefaultButton(
                        function: () {
                          if (_formKey.currentState!.validate()) {
                            cubit.login(
                              emailController.text.trim(),
                              passwordController.text,
                            );
                          }
                        },
                        text: AppLocalizations.of(context).translate("sign_in"),
                        textColor: Colors.white,
                      ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)
                            .translate("create_account_prompt")),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const CreateAccountView(),
                              ),
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context).translate("sign_up"),
                            style: const TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

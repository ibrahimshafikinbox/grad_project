import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/Core/Localizations/app_localizatios.dart';
import 'package:grad_project/Feature/Login/Widget/app_button.dart';
import 'package:grad_project/Feature/Login/Widget/default_form_field.dart';
import 'package:grad_project/Feature/Login/view/Login_view.dart';
import 'package:grad_project/Feature/create_acc/cubit/create_cubit.dart';
import 'package:grad_project/Feature/create_acc/cubit/create_state.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              Image.asset("assets/img/appLogo_blue.png", height: 80),
              Image.asset("assets/img/ProServe _blue.png"),
              const SizedBox(height: 20),

              DefaultFormField(
                controller: firstNameController,
                type: TextInputType.name,
                hint: AppLocalizations.of(context).translate("first_name"),
                label: AppLocalizations.of(context).translate("first_name"),
                maxlines: 1,
                onValidate: (value) =>
                    value == null || value.isEmpty ? 'Enter first name' : null,
              ),
              const SizedBox(height: 20),

              DefaultFormField(
                controller: lastNameController,
                type: TextInputType.name,
                hint: AppLocalizations.of(context).translate("last_name"),
                label: AppLocalizations.of(context).translate("last_name"),
                maxlines: 1,
                onValidate: (value) => value == null || value.isEmpty
                    ? AppLocalizations.of(context).translate("enter_last_name")
                    : null,
              ),
              const SizedBox(height: 20),

              DefaultFormField(
                controller: emailController,
                type: TextInputType.emailAddress,
                hint: AppLocalizations.of(context).translate("email_hint"),
                label: AppLocalizations.of(context).translate("email"),
                maxlines: 1,
                onValidate: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate("invalid_email");
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return AppLocalizations.of(context)
                        .translate("invalid_email");
                    ;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              DefaultFormField(
                controller: phoneController,
                type: TextInputType.phone,
                hint: '01012345678',
                label: AppLocalizations.of(context).translate("phone_number"),
                maxlines: 1,
                onValidate: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate("enter_phone");
                  } else if (!RegExp(r'^\d{10,15}$').hasMatch(value)) {
                    return AppLocalizations.of(context)
                        .translate("invalid_phone");
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              passwordFormField(
                controller: passwordController,
                type: TextInputType.visiblePassword,
                label: AppLocalizations.of(context).translate("password"),
                hint: AppLocalizations.of(context).translate("password_hint"),
                prefix: Icons.lock_outline,
                onValidate: (value) => value == null || value.isEmpty
                    ? AppLocalizations.of(context).translate("enter_password")
                    : null,
              ),
              const SizedBox(height: 20),

              BlocConsumer<CreateAccountCubit, CreateAccountState>(
                listener: (context, state) {
                  if (state is CreateAccountSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(AppLocalizations.of(context)
                              .translate("account_created_success"))),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginView()),
                    );
                  } else if (state is CreateAccountFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is CreateAccountLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return DefaultButton(
                    text: AppLocalizations.of(context).translate("sign_up"),
                    textColor: Colors.white,
                    function: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<CreateAccountCubit>().createAccount(
                              firstname: firstNameController.text.trim(),
                              lastname: lastNameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text,
                              phonenumber: phoneController.text.trim(),
                            );
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 20),

              /// Switch to Sign In
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)
                      .translate("already_have_account")),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const LoginView()),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context).translate("sign_in"),
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

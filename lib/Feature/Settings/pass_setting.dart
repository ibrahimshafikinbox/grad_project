import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/Core/Helper/assets_helper.dart';
import 'package:grad_project/Core/Helper/naviagation_helper.dart';
import 'package:grad_project/Core/Localizations/app_localizatios.dart';
import 'package:grad_project/Core/widget/app_Bar.dart';
import 'package:grad_project/Feature/Settings/cubit/settings_cubit.dart';
import 'package:grad_project/Feature/Settings/cubit/settings_state.dart';
import 'package:grad_project/Feature/Settings/widget/chaange_success.dart';
import 'package:grad_project/Feature/resources/images/images.dart';
import 'package:grad_project/Feature/resources/styles/app_sized_box.dart';
import 'package:grad_project/Feature/resources/styles/app_text_style.dart';

class PassSettingView extends StatefulWidget {
  @override
  State<PassSettingView> createState() => _PassSettingViewState();
}

class _PassSettingViewState extends State<PassSettingView> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          title: AppLocalizations.of(context).translate("password_settings")),
      body: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state is PasswordChangeSuccess) {
            // Show success message and navigate
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            navigateTo(context, PasswordChangedSuccessfully());
          } else if (state is PasswordChangeFailure) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSizedBox.sizedH20,
                  buildLabel(AppLocalizations.of(context)
                      .translate("current_password")),
                  _buildPasswordField(
                    controller: _currentPasswordController,
                    hintText: AppLocalizations.of(context)
                        .translate("enter_current_password"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate("please_enter_current_password");
                      }
                      return null;
                    },
                  ),
                  AppSizedBox.sizedH15,
                  buildLabel(
                    AppLocalizations.of(context).translate("new_password"),
                  ),
                  _buildPasswordField(
                    controller: _newPasswordController,
                    hintText: AppLocalizations.of(context)
                        .translate("enter_new_password"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate("please_enter_new_password");
                      }
                      if (value.length < 6) {
                        return AppLocalizations.of(context)
                            .translate("password_min_length");
                      }
                      return null;
                    },
                  ),
                  AppSizedBox.sizedH15,
                  buildLabel(
                    AppLocalizations.of(context)
                        .translate("confirm_new_password"),
                  ),
                  _buildPasswordField(
                    controller: _confirmPasswordController,
                    hintText: AppLocalizations.of(context)
                        .translate("confirm_new_password"),
                    validator: (value) {
                      if (value != _newPasswordController.text) {
                        return AppLocalizations.of(context)
                            .translate("passwords_do_not_match");
                      }
                      return null;
                    },
                  ), // "": "تأكيد كلمة المرور الجديدة",
                  // "confirm_password_hint": "أعد إدخال كلمة المرور الجديدة",
                  // "": "كلمتا المرور غير متطابقتين",
                  // "": "تغيير كلمة المرور",
                  // "": "تم تغيير كلمة المرور بنجاح"
                  AppSizedBox.sizedH40,
                  BlocBuilder<SettingsCubit, SettingsState>(
                    builder: (context, state) {
                      return Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0XFF165BB3),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: state is PasswordChangeLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    context
                                        .read<SettingsCubit>()
                                        .changePassword(
                                          userId:
                                              6, // Replace with actual user ID
                                          oldPassword:
                                              _currentPasswordController.text,
                                          newPassword:
                                              _newPasswordController.text,
                                          newPasswordConfirmation:
                                              _confirmPasswordController.text,
                                        );
                                  }
                                },
                          child: state is PasswordChangeLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  AppLocalizations.of(context)
                                      .translate("change_password"),
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLabel(String text) {
    return Text(text, style: AppTextStyle.textStyleBoldBlack);
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required String? Function(String?) validator,
  }) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        validator: validator,
      ),
    );
  }
}

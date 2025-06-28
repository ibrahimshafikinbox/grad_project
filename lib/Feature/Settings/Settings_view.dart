import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/Core/Helper/naviagation_helper.dart';
import 'package:grad_project/Core/Localizations/app_localizatios.dart';
import 'package:grad_project/Core/widget/app_Bar.dart';
import 'package:grad_project/Feature/Settings/pass_setting.dart';
import 'package:grad_project/Feature/resources/colors/colors.dart';
import 'package:grad_project/Feature/resources/styles/app_text_style.dart';

class SettingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
          title: AppLocalizations.of(context).translate("settings")),
      body: ListView(
        children: <Widget>[
          ListTile(
            //           "settings": "الإعدادات",
            // "notification_settings": "إعدادات الإشعارات",
            // "password_settings": "إعدادات كلمة المرور"
            title: Text(
              AppLocalizations.of(context).translate("notification_settings"),
              style: AppTextStyle.textStyleBoldBlack,
            ),
            leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: const Color(0XFF165BB3),
                    borderRadius: BorderRadius.circular(18)),
                child: const Icon(
                  Icons.notifications_on_outlined,
                  color: AppColors.white,
                )),
            onTap: () {
              // Navigate to notification settings
            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context).translate("password_settings"),
              style: AppTextStyle.textStyleBoldBlack,
            ),
            leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: const Color(0XFF165BB3),
                    borderRadius: BorderRadius.circular(18)),
                child: const Icon(
                  Icons.lock_outline,
                  color: AppColors.white,
                )),
            onTap: () {
              navigateTo(context, PassSettingView());
            },
          ),
        ],
      ),
    );
  }
}

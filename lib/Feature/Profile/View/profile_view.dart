import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/Core/Helper/naviagation_helper.dart';
import 'package:grad_project/Core/Localizations/app_localizatios.dart';
import 'package:grad_project/Feature/Notification/View/notifi_view.dart';
import 'package:grad_project/Feature/Profile/View/edit_profile.dart';
import 'package:grad_project/Feature/Profile/View/provider_edit_profile.dart';
import 'package:grad_project/Feature/Profile/cubit/user_profile_state.dart';
import 'package:grad_project/Feature/Profile/cubit/usera_profile_cubit.dart';
import 'package:grad_project/Feature/Settings/Settings_view.dart';
import 'package:grad_project/Feature/resources/colors/colors.dart';
import 'package:grad_project/Feature/resources/images/images.dart';
import 'package:grad_project/Feature/resources/styles/app_sized_box.dart';
import 'package:grad_project/Feature/resources/styles/app_text_style.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isUser = true;

  @override
  void initState() {
    super.initState();
    // Fetch the profile data
    context
        .read<GetProfileCubit>()
        .getProfile(); // Replace with dynamic user ID
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0Xff165BB3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppLocalizations.of(context).translate("my_profile"),
          style: AppTextStyle.textStyleWhiteSemiBold19,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              navigateTo(context, const NotificationView());
            },
            icon: const Icon(
              Icons.notifications_none_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: const Color(0Xff165BB3),
            height: 140,
          ),
          Column(
            children: [
              AppSizedBox.sizedH75,
              BlocBuilder<GetProfileCubit, GetProfileState>(
                builder: (context, state) {
                  if (state is GetProfileSuccess) {
                    final profile = state.profile;
                    final profileImageUrl = profile.profilePicture;

                    return CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 56,
                        backgroundImage: profileImageUrl != null &&
                                profileImageUrl.isNotEmpty
                            ? NetworkImage(profileImageUrl)
                            : const AssetImage(AssetsHelper.profileImage)
                                as ImageProvider,
                      ),
                    );
                  } else if (state is GetProfileLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 56,
                        backgroundImage: AssetImage(AssetsHelper.profileImage),
                      ),
                    );
                  }
                },
              ),
              AppSizedBox.sizedH10,
              BlocBuilder<GetProfileCubit, GetProfileState>(
                builder: (context, state) {
                  if (state is GetProfileLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is GetProfileSuccess) {
                    final profile = state.profile;
                    return Column(
                      children: [
                        Text(
                          "${profile.firstname ?? ''} ${profile.lastname ?? ''}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${AppLocalizations.of(context).translate("id")}: ${profile.displayNumber ?? profile.userId}",
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    );
                  } else if (state is GetProfileFailure) {
                    return Text(
                      AppLocalizations.of(context)
                          .translate("failed_to_load_profile"),
                      style: TextStyle(color: Colors.red),
                    );
                  } //         "my_profile": "ملفي الشخصي",
                  // "edit_profile": "تعديل الملف الشخصي",
                  // "setting": "الإعدادات",
                  // "logout": "تسجيل الخروج",
                  // "convert_to_provider": "التحويل إلى مقدم خدمة",
                  // "user": "مستخدم",
                  // "provider": "مقدم خدمة",
                  // "failed_to_load_profile": "فشل في تحميل الملف الشخصي",
                  // "profile_data_not_loaded": "لم يتم تحميل بيانات الملف الشخصي",
                  // "notifications": "الإشعارات",
                  //   "phone": "رقم الهاتف",
                  // "email_address": "عنوان البريد الإلكتروني",
                  // "update_profile": "تحديث الملف الشخصي",
                  // "profile_updated_successfully": "تم تحديث الملف الشخصي بنجاح",
                  // "failed_to_update_profile": "فشل في تحديث الملف الشخصي",
                  // "id": "المعرف"
                  return const SizedBox.shrink();
                },
              ),
              AppSizedBox.sizedH15,
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    BlocBuilder<GetProfileCubit, GetProfileState>(
                      builder: (context, state) {
                        if (state is GetProfileSuccess) {
                          return ProfileOption(
                            ontap: () {
                              navigateTo(
                                context,
                                BlocProvider(
                                  create: (context) => GetProfileCubit(),
                                  child: EditProfileView(user: state.profile),
                                ),
                              );
                            },
                            icon: Icons.person,
                            title: AppLocalizations.of(context)
                                .translate("edit_profile"),
                          );
                        }
                        return ProfileOption(
                          ontap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Profile data not loaded')),
                            );
                          },
                          icon: Icons.person,
                          title: AppLocalizations.of(context)
                              .translate("edit_profile"),
                        );
                      },
                    ),
                    ProfileOption(
                      icon: Icons.settings,
                      title: AppLocalizations.of(context).translate("setting"),
                      ontap: () {
                        navigateTo(context, SettingView());
                      },
                    ),
                    ProfileOption(
                      icon: Icons.logout,
                      title: AppLocalizations.of(context).translate("logout"),
                      ontap: () {
                        _showLogOutDialog(context);
                      },
                    ),
                    BlocBuilder<GetProfileCubit, GetProfileState>(
                      builder: (context, state) {
                        if (state is GetProfileSuccess) {
                          return ProfileOption(
                            ontap: () {
                              navigateTo(
                                context,
                                BlocProvider(
                                  create: (context) => GetProfileCubit(),
                                  child: ProviderEditProfileView(
                                      user: state.profile),
                                ),
                              );
                            },
                            icon: Icons.design_services,
                            title: AppLocalizations.of(context)
                                .translate("convert_to_provider"),
                          );
                        }
                        return ProfileOption(
                          ontap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Profile data not loaded')),
                            );
                          },
                          icon: Icons.person,
                          title: AppLocalizations.of(context)
                              .translate("edit_profile"),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback ontap;

  const ProfileOption({
    Key? key,
    required this.icon,
    required this.title,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: ontap,
        child: ListTile(
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF165BB3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.white, size: 28),
          ),
          title: Text(title, style: AppTextStyle.textStyleBoldBlack),
        ),
      ),
    );
  }
}

void _showLogOutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // handle logout logic
              Navigator.of(context).pop();
            },
            child: const Text('Log Out'),
          ),
        ],
      );
    },
  );
}

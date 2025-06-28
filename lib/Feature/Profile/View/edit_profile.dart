import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/Core/Helper/assets_helper.dart';
import 'package:grad_project/Core/Localizations/app_localizatios.dart';
import 'package:grad_project/Feature/Profile/Model/profile_model.dart';
import 'package:grad_project/Feature/Profile/cubit/user_profile_state.dart';
import 'package:grad_project/Feature/Profile/cubit/usera_profile_cubit.dart';
import 'package:grad_project/Feature/resources/images/images.dart';
import 'package:grad_project/Feature/resources/styles/app_sized_box.dart';
import 'package:grad_project/Feature/resources/styles/app_text_style.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileView extends StatelessWidget {
  final ProfileModel user; // Pass the current user data to the view

  const EditProfileView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController lastNameController =
        TextEditingController(text: user.lastname);
    final TextEditingController phoneController =
        TextEditingController(text: user.phoneNumber);
    final TextEditingController emailController =
        TextEditingController(text: user.email);

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
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none_outlined,
                color: Colors.white,
              ))
        ],
      ),
      body: BlocConsumer<GetProfileCubit, GetProfileState>(
        listener: (context, state) {
          if (state is UpdateProfileFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
          if (state is UpdateProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(AppLocalizations.of(context)
                      .translate("profile_updated_success"))),
            );
            {}

            // Optionally update the parent widget with new user data
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  color: const Color(0Xff165BB3),
                  height: 140,
                ),
                Column(
                  children: [
                    AppSizedBox.sizedH75,
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 58,
                              backgroundImage: user.profilePicture != null
                                  ? NetworkImage(user.profilePicture!)
                                  : const AssetImage(AssetsHelper.profileImage)
                                      as ImageProvider,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt,
                                    color: Colors.white),
                                onPressed: () async {
                                  final picker = ImagePicker();
                                  final pickedFile = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (pickedFile != null) {
                                    context
                                        .read<GetProfileCubit>()
                                        .updateProfile(
                                          // userId: user.userId,
                                          profilePicturePath: pickedFile.path,
                                        );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppSizedBox.sizedH10,
                    Text(
                      "${user.firstname} ${user.lastname}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${AppLocalizations.of(context).translate("id_label")}: ${user.userId}",
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    AppSizedBox.sizedH15,
                    Container(
                      // "my_profile": "My Profile",
                      // "profile_updated_success": "Profile updated successfully",
                      // "last_name": "Last Name",
                      // "phone": "Phone",
                      // "email_address": "Email Address",
                      // "update_profile": "Update Profile",
                      // "": "ID"

                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSizedBox.sizedH20,
                          buildLabel(AppLocalizations.of(context)
                              .translate("first_name")),
                          buildEditableFormField(lastNameController),
                          AppSizedBox.sizedH15,
                          buildLabel(
                              AppLocalizations.of(context).translate("phone")),
                          buildEditableFormField(phoneController),
                          AppSizedBox.sizedH15,
                          buildLabel(AppLocalizations.of(context)
                              .translate("email_address")),
                          buildEditableFormField(emailController),
                          AppSizedBox.sizedH40,
                          Center(
                            child: state is UpdateProfileLoading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0XFF165BB3),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: () {
                                      context
                                          .read<GetProfileCubit>()
                                          .updateProfile(
                                            // userId: user.userId,
                                            lastname: lastNameController.text,
                                            phoneNumber: phoneController.text,
                                            email: emailController.text,
                                          );
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)
                                            .translate("update_profile"),
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildLabel(String text) {
    return Text(text, style: AppTextStyle.textStyleBoldBlack);
  }

  Widget buildEditableFormField(TextEditingController controller) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

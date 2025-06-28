import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/Core/Localizations/app_localizatios.dart';
import 'package:grad_project/Feature/Profile/Model/profile_model.dart';
import 'package:grad_project/Feature/Profile/cubit/user_profile_state.dart';
import 'package:grad_project/Feature/Profile/cubit/usera_profile_cubit.dart';
import 'package:grad_project/Feature/resources/images/images.dart';
import 'package:grad_project/Feature/resources/styles/app_sized_box.dart';
import 'package:grad_project/Feature/resources/styles/app_text_style.dart';
import 'package:image_picker/image_picker.dart';

class ProviderEditProfileView extends StatefulWidget {
  final ProfileModel user;

  const ProviderEditProfileView({Key? key, required this.user})
      : super(key: key);

  @override
  State<ProviderEditProfileView> createState() =>
      _ProviderEditProfileViewState();
}

class _ProviderEditProfileViewState extends State<ProviderEditProfileView> {
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController serviceController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  XFile? _pickedImage; // Store the picked image file

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = pickedFile;
      });
      // Optionally upload the image immediately
      context.read<GetProfileCubit>().updateProfile(
            profilePicturePath: pickedFile.path,
          );
    }
  }

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              AppLocalizations.of(context).translate("choose_image_source")),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child:
                      Text(AppLocalizations.of(context).translate("gallery")),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                // "choose_image_source": "Choose Image Source",
                // "gallery": "Gallery",
                // "camera": "Camera",
                // "convert_to_provider": "Convert to service provider",
                // "last_name": "Last Name",
                // "phone": "Phone",
                // "email": "Email Address",
                // "service": "Service",
                // "experience": "Experience",
                // "address": "Address",
                // "bio": "Bio",
                // "update_profile": "Update Profile",
                // "please_select_profile_image": "Please select a profile image",
                // "profile_updated_successfully": "Profile updated successfully",
                // "profile_update_failed": "Failed to update profile",
                // "id": "ID"
                GestureDetector(
                  child: Text(AppLocalizations.of(context).translate("camera")),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
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
          AppLocalizations.of(context).translate("convert_to_provider"),
          style: AppTextStyle.textStyleWhiteSemiBold19,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_outlined,
              color: Colors.white,
            ),
          ),
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
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(AppLocalizations.of(context)
                    .translate("profile_updated_successfully"))));
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
                              backgroundImage: _pickedImage != null
                                  ? FileImage(File(_pickedImage!.path))
                                  : widget.user.profilePicture != null
                                      ? NetworkImage(
                                          widget.user.profilePicture!)
                                      : const AssetImage(
                                              AssetsHelper.profileImage)
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
                                onPressed: _showImagePickerDialog,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppSizedBox.sizedH10,
                    Text(
                      "${widget.user.firstname} ${widget.user.lastname}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${AppLocalizations.of(context).translate("id")}: ${widget.user.userId}",
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    AppSizedBox.sizedH15,
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSizedBox.sizedH20,
                          buildLabel(AppLocalizations.of(context)
                              .translate("last_name")),
                          buildEditableFormField(
                              lastNameController, TextInputType.text),
                          AppSizedBox.sizedH15,
                          buildLabel(
                              AppLocalizations.of(context).translate("phone")),
                          buildEditableFormField(
                              phoneController, TextInputType.number),
                          AppSizedBox.sizedH15,
                          buildLabel(
                              AppLocalizations.of(context).translate("email")),
                          buildEditableFormField(
                              emailController, TextInputType.text),
                          AppSizedBox.sizedH15,
                          buildLabel(AppLocalizations.of(context)
                              .translate("service")),
                          buildEditableFormField(
                              serviceController, TextInputType.text),
                          AppSizedBox.sizedH15,
                          buildLabel(AppLocalizations.of(context)
                              .translate("experience")),
                          buildEditableFormField(
                              experienceController, TextInputType.number),
                          AppSizedBox.sizedH15,
                          buildLabel(AppLocalizations.of(context)
                              .translate("address")),
                          buildEditableFormField(
                              addressController, TextInputType.text,
                              maxLines: 3),
                          AppSizedBox.sizedH15,
                          buildLabel(
                              AppLocalizations.of(context).translate("bio")),
                          buildEditableFormField(
                              bioController, TextInputType.text,
                              maxLines: 4),
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
                                      if (_pickedImage == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                            AppLocalizations.of(context).translate(
                                                "please_select_profile_image"),
                                          )),
                                        );
                                        return;
                                      }

                                      context
                                          .read<GetProfileCubit>()
                                          .convertToProvider(
                                            // userId:
                                            //     widget.user.userId.toString(),
                                            serviceId: serviceController.text,
                                            experience:
                                                experienceController.text,
                                            startTime: '14:30', // make dynamic
                                            endTime: '16:45', // make dynamic
                                            location: addressController.text,
                                            bio: bioController.text,
                                            phoneNumber: phoneController.text,
                                            profilePicture:
                                                File(_pickedImage!.path),
                                          );
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)
                                            .translate("update_profile"),
                                        style: TextStyle(color: Colors.white)),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: AppTextStyle.textStyleBoldBlack),
    );
  }

  Widget buildEditableFormField(
      TextEditingController controller, TextInputType keyboardType,
      {int maxLines = 1}) {
    return SizedBox(
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        maxLines: maxLines,
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

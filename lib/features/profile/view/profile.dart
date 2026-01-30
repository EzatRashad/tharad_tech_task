import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharad_tech/core/constants/api_constants.dart';
import 'package:tharad_tech/core/constants/app_strings.dart';
import 'package:tharad_tech/core/functions/lang_btn.dart';
import 'package:tharad_tech/core/services/get_storage_helper.dart';
import 'package:tharad_tech/core/style/app_colors.dart';
import 'package:tharad_tech/core/utils/validatio.dart';
import 'package:tharad_tech/core/widgets/app_pick_image.dart';
import 'package:tharad_tech/core/widgets/my_scaffold.dart';
import 'package:tharad_tech/features/profile/cubit/profile_cubit.dart';
import 'package:tharad_tech/features/profile/cubit/profile_stste.dart';
import '/core/utils/utils.dart';
import '/core/widgets/app_input.dart';
import '/core/widgets/app_image_widget.dart';
import '/core/widgets/app_button.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (BuildContext context, ProfileState state) {
          if (state is UpdateProfileError) {
            context.showSnackBar(state.error, backgroundColor: Colors.red);
          }
          if (state is UpdateProfileSuccess) {
            context.showSnackBar(state.message);
          }
        },
        builder: (context, state) {
          final cubit = ProfileCubit.get(context);

          if (state is GetProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          if (state is GetProfileError) {
            return Center(child: Text(state.error));
          }
          if (state is GetProfileSuccess) {
            nameController.text = state.model.username;
            emailController.text = state.model.email;
          }
          return MyScaffold(
            title: AppStrings.profile.tr(),
            body: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),

                children: [
                  Column(
                    children: [
                      32.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => LangBtn.show(context),
                            child: Row(
                              children: [
                                AppImageWidget(imageName: "global.svg"),
                                4.pw,
                                Text(AppStrings.lang.tr()),
                              ],
                            ),
                          ),
                        ],
                      ),
                      8.ph,
                      AppInput(
                        label: AppStrings.usernameLabel.tr(),
                        controller: nameController,
                        validator: (value) => Validation.validateName(value),
                      ),

                      12.ph,
                      AppInput(
                        label: AppStrings.emailLabel.tr(),
                        controller: emailController,
                        validator: (value) => Validation.validateEmail(value),
                      ),

                      12.ph,
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.profileImage.tr(),
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            6.ph,
                            cubit.selectNewImage
                                ? AppPickImage(
                                    onImagePicked: (image) =>
                                        cubit.pickImage(image),
                                  )
                                : Stack(
                                    children: [
                                      cubit.profileImage != null
                                          ? Image.file(
                                              cubit.profileImage!,
                                              height: 100,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl:
                                                  CacheHelper.getData<String>(
                                                    key: imageK,
                                                  ) ??
                                                  "",
                                              width: 100.w,
                                              height: 100.h,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                      Positioned(
                                        top: 8,
                                        left: 8,
                                        child: GestureDetector(
                                          onTap: cubit.toggleSelectNewImage,
                                          child: AppImageWidget(
                                            imageName: "uploaded_camera.svg",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),

                      12.ph,
                      AppInput(
                        label: AppStrings.oldPassword.tr(),
                        controller: passwordController,
                        obscureText: cubit.isPasswordVisible1,
                        suffixIcon: GestureDetector(
                          onTap: cubit.togglePasswordVisibility1,
                          child: AppImageWidget(
                            imageName: cubit.isPasswordVisible1
                                ? "visibily_off.svg"
                                : "visiblily.svg",
                          ),
                        ),
                      ),
                      12.ph,
                      AppInput(
                        label: AppStrings.newPassword.tr(),
                        controller: newPasswordController,
                        validator: (value) =>
                            Validation.validatePassword(value),

                        obscureText: cubit.isPasswordVisible2,
                        suffixIcon: GestureDetector(
                          onTap: cubit.togglePasswordVisibility2,
                          child: AppImageWidget(
                            imageName: cubit.isPasswordVisible2
                                ? "visibily_off.svg"
                                : "visiblily.svg",
                          ),
                        ),
                      ),
                      12.ph,
                      AppInput(
                        label: AppStrings.confirmNewPassword.tr(),
                        validator: (value) =>
                            Validation.validateConfirmPassword(
                              value,
                              newPasswordController.text,
                            ),
                        controller: confirmPasswordController,
                        obscureText: cubit.isPasswordVisible3,
                        suffixIcon: GestureDetector(
                          onTap: cubit.togglePasswordVisibility3,
                          child: AppImageWidget(
                            imageName: cubit.isPasswordVisible3
                                ? "visibily_off.svg"
                                : "visiblily.svg",
                          ),
                        ),
                      ),
                      40.ph,

                      state is UpdateProfileLoading
                          ? CircularProgressIndicator(color: AppColors.primary)
                          : AppButton(
                              width: 234.w,
                              title: AppStrings.saveChanges.tr(),
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.updateProfile(
                                    username: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    newPassword: newPasswordController.text,
                                    newPasswordConfirmation:
                                        confirmPasswordController.text,
                                  );
                                }
                              },
                            ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

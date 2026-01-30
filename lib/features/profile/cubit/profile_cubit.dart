import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad_tech/core/constants/api_constants.dart';
import 'package:tharad_tech/core/error/api_error.dart';
import 'package:tharad_tech/core/services/dio_helper.dart';
import 'package:tharad_tech/core/services/get_storage_helper.dart';
import 'package:tharad_tech/features/profile/cubit/profile_stste.dart';
import 'package:tharad_tech/features/profile/model/profile_details_model.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(GetProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);
  bool isPasswordVisible1 = true;
  bool isPasswordVisible2 = true;
  bool isPasswordVisible3 = true;
  File? profileImage;
  bool selectNewImage = false;

  void toggleSelectNewImage() {
    selectNewImage = !selectNewImage;
    emit(SelectNewImage(selectNewImage));
  }

  void togglePasswordVisibility1() {
    isPasswordVisible1 = !isPasswordVisible1;
    emit(PasswordVisibilityChanged(isPasswordVisible1));
  }

  void togglePasswordVisibility2() {
    isPasswordVisible2 = !isPasswordVisible2;
    emit(PasswordVisibilityChanged(isPasswordVisible2));
  }

  void togglePasswordVisibility3() {
    isPasswordVisible3 = !isPasswordVisible3;
    emit(PasswordVisibilityChanged(isPasswordVisible3));
  }

  void pickImage(File image) {
    profileImage = image;
    emit(RegisterImagePicked());
  }

  Future<void> getProfile() async {
    emit(GetProfileLoading());
    try {
      final response = await DioHelper.getData(url: profileDetailsEndpoint);
      final profile = ProfileDetailsModel.fromJson(response.data["data"]);

      CacheHelper.saveData(key: nameK, value: profile.username);
      CacheHelper.saveData(key: emailK, value: profile.email);
      CacheHelper.saveData(key: imageK, value: profile.image);

      selectNewImage = false;
      emit(GetProfileSuccess(profile));
    } on ApiError catch (error) {
      final localUsername = CacheHelper.getData<String>(key: nameK) ?? '';
      final localEmail = CacheHelper.getData<String>(key: emailK) ?? '';
      final localImage = CacheHelper.getData<String>(key: imageK) ?? '';

      if (localUsername.isNotEmpty || localEmail.isNotEmpty) {
        final profile = ProfileDetailsModel(
          id: 0,
          username: localUsername,
          email: localEmail,
          image: localImage,
        );
        emit(GetProfileSuccess(profile, message: error.message));
      } else {
        emit(GetProfileError(error.message));
      }
    }
  }

  Future<void> updateProfile({
    required String username,
    required String email,
    required String password,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    emit(UpdateProfileLoading());
    try {
      final formData = FormData.fromMap({
        "username": username,
        "email": email,
        "password": password,
        "new_password": newPassword,
        "new_password_confirmation": newPasswordConfirmation,
        "_method": "PUT",
        if (profileImage != null)
          "image": await MultipartFile.fromFile(
            profileImage!.path,
            filename: profileImage!.path.split('/').last,
          ),
      });

      final response = await DioHelper.postData(
        url: updateProfileEndpoint,
        data: formData,
      );

      await getProfile();
      emit(UpdateProfileSuccess(response.data['message']));
    } on ApiError catch (error) {
      emit(UpdateProfileError(error.message));
    }
  }
}

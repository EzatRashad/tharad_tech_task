import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/constants/api_constants.dart';
import '/core/error/api_error.dart';
import '/core/services/dio_helper.dart';
import '/features/register/cubit/regiser_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  File? profileImage;

  bool isPasswordVisible1 = true;
  bool isPasswordVisible2 = true;

  void pickImage(File image) {
    profileImage = image;
    emit(RegisterImagePicked());
  }

  void togglePassword1() {
    isPasswordVisible1 = !isPasswordVisible1;
    emit(RegisterPasswordVisibilityChanged());
  }

  void togglePassword2() {
    isPasswordVisible2 = !isPasswordVisible2;
    emit(RegisterPasswordVisibilityChanged());
  }

  Future<void> register({
    required String email,
    required String username,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(RegisterLoading());

    try {
      final formData = FormData.fromMap({
        "email": email,
        "username": username.trim().replaceAll(' ', ''),
        "password": password,
        "password_confirmation": passwordConfirmation,
        if (profileImage != null)
          "image": await MultipartFile.fromFile(
            profileImage!.path,
            filename: profileImage!.path.split('/').last,
          ),
      });

      final response = await DioHelper.postData(
        url: registerEndpoint,
        data: formData,
      );

      emit(
        RegisterSuccess(
          response.data['message'],
          response.data['data']['otp'].toString(),
        ),
      );
    } on ApiError catch (error) {
      emit(RegisterError(error.message));
    }
  }
}

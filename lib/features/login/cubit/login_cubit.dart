import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/constants/api_constants.dart';
import '/core/constants/app_strings.dart';
import '/core/error/api_error.dart';
import '/core/services/dio_helper.dart';
import '/core/services/get_storage_helper.dart';
import '/features/login/cubit/login_state.dart';
import '/features/login/model/user_model.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPasswordVisible = true;
  bool isTermsAccepted = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordVisibilityChanged(isPasswordVisible));
  }

  void changeTermsAccepted(bool value) {
    isTermsAccepted = value;
    emit(TermsAcceptedChanged(isTermsAccepted));
  }

  Future<void> login({required String email, required String password}) async {
    if (!isTermsAccepted) {
      emit(LoginError(AppStrings.termsError.tr()));
      return;
    }

    emit(LoginLoading());

    try {
      final response = await DioHelper.postData(
        url: loginEndpoint,
        data: {"email": email, "password": password},
      );

      UserModel userModel = UserModel.fromJson(response.data['data']);
      token = userModel.token;
      log(token ?? "nullllllllllllllllllllll");

      await CacheHelper.saveData(key: tokenK, value: token);
      await CacheHelper.saveData(key: nameK, value: userModel.username);
      await CacheHelper.saveData(key: emailK, value: userModel.email);

      emit(LoginSuccess(userModel, response.data['message']));
    } on ApiError catch (error) {
      emit(LoginError(error.message));
    }
  }
}

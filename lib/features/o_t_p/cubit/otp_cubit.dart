import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad_tech/core/constants/api_constants.dart';
import 'package:tharad_tech/core/constants/app_strings.dart';
import 'package:tharad_tech/core/error/api_error.dart';
import 'package:tharad_tech/core/services/dio_helper.dart';
import 'package:tharad_tech/features/o_t_p/cubit/oto_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());
  List<String> otpCode = ["", "", "", ""];
  List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  static OtpCubit get(context) => BlocProvider.of(context);

 void changeCode(String value) {
  otpCode = List<String>.generate(4, (i) => i < value.length ? value[i] : "");
  emit(OtpCodeChanged(code: List.from(otpCode)));
}


  @override
  Future<void> close() {
    for (final node in focusNodes) {
      node.dispose();
    }
    return super.close();
  }

  Future<void> verifyOtp({
    required String email,
    required String sentCode,
  }) async {
    final otp = otpCode.join();
    if (otp.length < 3) {
      emit(OtpError(message: AppStrings.otpIncomplete.tr()));
      return;
    }
    if (otp != sentCode) {
      emit(OtpError(message: AppStrings.otpInvalid.tr()));
      return;
    }

    emit(OtpLoading());
    try {
      final response = await DioHelper.getData(
        url: otpEndpoint,
        queryParameters: {"email": email, "otp": otp},
      );
      emit(OtpSuccess(message: response.data['message']));
    } on ApiError catch (error) {
      emit(OtpError(message: error.message));
    }
  }
}

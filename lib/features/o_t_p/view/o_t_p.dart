import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tharad_tech/core/style/app_colors.dart';
import 'package:tharad_tech/features/login/view/login.dart';
import 'package:tharad_tech/features/o_t_p/cubit/oto_state.dart';
import 'package:tharad_tech/features/o_t_p/cubit/otp_cubit.dart';
import '/core/constants/app_strings.dart';
import '/core/utils/navigate.dart';
import '/core/utils/utils.dart';
import '/core/widgets/app_image_widget.dart';
import '/core/widgets/app_button.dart';

class OTPView extends StatefulWidget {
  final String sentCode;
  final String email;
  const OTPView({super.key, required this.sentCode, required this.email});

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  TextEditingController otpController = TextEditingController();
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  @override
  void dispose() {
    otpController.dispose();
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (_) => OtpCubit(),
      child: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {
          if (state is OtpSuccess) {
            context.showSnackBar(state.message);
            context.nextScreen(LoginView(), remove: true);
          } else if (state is OtpError) {
            context.showSnackBar(state.message, backgroundColor: Colors.red);
          }
        },
        builder: (context, state) {
          final cubit = OtpCubit.get(context);

          return Scaffold(
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              children: [
                Column(
                  children: [
                    120.ph,
                    AppImageWidget(
                      imageName: "logo.png",
                      height: 58.h,
                      width: 178.w,
                    ),
                    116.ph,
                    Text(AppStrings.otpTitle.tr(), style: theme.titleLarge),
                    8.ph,
                    Text(
                      AppStrings.otpDescription.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF998C8C),
                        fontSize: 12,
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    40.ph,

                    PinCodeTextField(
                      appContext: context,
                      length: 4,
                      controller: otpController,
                      errorAnimationController: errorController,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.scale,
                      backgroundColor: Colors.transparent,

                      pinTheme: PinTheme(
                        activeFillColor: Colors.transparent,
                        inactiveFillColor: Colors.transparent,
                        selectedFillColor: Colors.transparent,
                        selectedColor: const Color(0xffF0E6DE),
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(12.r),
                        fieldHeight: 45.h,
                        fieldWidth: 45.w,
                        activeColor: const Color(0xffF0E6DE),
                        inactiveColor: const Color(0xffF0E6DE),
                      ),
                      cursorColor: AppColors.primary,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      onChanged: (value) {
                        cubit.changeCode(value);
                      },
                      onCompleted: (value) {
                        cubit.verifyOtp(
                          email: widget.email,
                          sentCode: widget.sentCode,
                        );
                      },
                    ),
                    12.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.timer.tr(),
                          style: theme.titleSmall!.copyWith(
                            color: Color(0xff998C8C),
                          ),
                        ),
                        Spacer(),
                        Text(
                          AppStrings.notReceived.tr(),
                          style: theme.titleSmall,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            AppStrings.resend.tr(),
                            style: theme.titleSmall!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF42867B),
                            ),
                          ),
                        ),
                      ],
                    ),
                    40.ph,

                    state is OtpLoading
                        ? CircularProgressIndicator(color: AppColors.primary)
                        : AppButton(
                            title: AppStrings.continueBtn.tr(),
                            onTap: () {
                              cubit.verifyOtp(
                                email: widget.email,
                                sentCode: widget.sentCode,
                              );
                            },
                          ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharad_tech/core/functions/lang_btn.dart';
import 'package:tharad_tech/features/layout/view/layout.dart';
import 'package:tharad_tech/features/register/view/register.dart';
import '/core/constants/app_strings.dart';
import '/core/style/app_colors.dart';
import '/core/utils/navigate.dart';
import '/core/utils/utils.dart';
import '/core/widgets/app_button.dart';
import '/core/widgets/app_image_widget.dart';
import '/core/widgets/app_input.dart';
import '/core/widgets/register_or_login.dart';
import '/core/widgets/terms_and_conditions.dart';
import '/features/login/cubit/login_cubit.dart';
import '/features/login/cubit/login_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final theme = Theme.of(context).textTheme;
    @override
    void dispose() {
      emailController.dispose();
      passwordController.dispose();
      super.dispose();
    }

    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            context.showSnackBar(state.message, backgroundColor: Colors.red);
          }
          if (state is LoginSuccess) {
            context.showSnackBar(state.message);
            context.nextScreen(const LayoutView(), remove: true);
          }
        },
        builder: (context, state) {
          final cubit = LoginCubit.get(context);

          return Scaffold(
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              children: [
                Column(
                  children: [
                    80.ph,

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

                    100.ph,

                    AppImageWidget(
                      imageName: "logo.png",
                      height: 58.h,
                      width: 178.w,
                    ),
                    40.ph,

                    Text(AppStrings.loginTitle.tr(), style: theme.titleLarge),

                    24.ph,

                    AppInput(
                      label: AppStrings.emailLabel.tr(),
                      hint: AppStrings.emailHint.tr(),
                      controller: emailController,
                    ),

                    12.ph,

                    AppInput(
                      label: AppStrings.passwordLabel.tr(),
                      hint: AppStrings.passwordHint.tr(),
                      controller: passwordController,
                      obscureText: cubit.isPasswordVisible,
                      suffixIcon: GestureDetector(
                        onTap: cubit.togglePasswordVisibility,
                        child: AppImageWidget(
                          imageName: cubit.isPasswordVisible
                              ? "visibily_off.svg"
                              : "visiblily.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),

                    8.ph,

                    Row(
                      children: [
                        TermsAndConditionsWidget(
                          isChecked: cubit.isTermsAccepted,
                          onChanged: cubit.changeTermsAccepted,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            AppStrings.forgotPassword.tr(),
                            style: theme.titleSmall!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF42867B),
                            ),
                          ),
                        ),
                      ],
                    ),

                    40.ph,

                    state is LoginLoading
                        ? CircularProgressIndicator(color: AppColors.primary)
                        : AppButton(
                            title: AppStrings.loginButton.tr(),
                            onTap: () => cubit.login(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          ),

                    12.ph,

                    RegisterOrLogin(
                      normalText: AppStrings.noAccount.tr(),
                      actionText: AppStrings.createAccount.tr(),
                      onTap: () =>
                          context.nextScreen(const Register()),
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

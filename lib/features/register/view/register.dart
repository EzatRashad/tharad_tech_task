import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/constants/app_strings.dart';
import '/core/style/app_colors.dart';
import '/core/utils/navigate.dart';
import '/core/utils/utils.dart';
import '/core/utils/validatio.dart';
import '/core/widgets/app_pick_image.dart';
import '/core/widgets/app_button.dart';
import '/core/widgets/app_image_widget.dart';
import '/core/widgets/app_input.dart';
import '/core/widgets/register_or_login.dart';
import '/features/o_t_p/view/o_t_p.dart';
import '/features/login/view/login.dart';
import '/features/register/cubit/regiser_state.dart';
import '/features/register/cubit/register_cubit.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              context.showSnackBar(state.message);
              context.nextScreen(OTPView(sentCode: state.code, email: emailController.text));
            } else if (state is RegisterError) {
              context.showSnackBar(state.message, backgroundColor: Colors.red);
            }
          },
          builder: (context, state) {
            final cubit = RegisterCubit.get(context);

            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                children: [
                  80.ph,
                  AppImageWidget(
                    imageName: "logo.png",
                    height: 58.h,
                    width: 178.w,
                  ),
                  40.ph,

                  Text(
                    AppStrings.registerTitle.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  24.ph,

                  cubit.profileImage != null
                      ? Image.file(cubit.profileImage!, height: 100)
                      : AppPickImage(
                          onImagePicked: (image) {
                            cubit.pickImage(image);
                          },
                        ),

                  12.ph,

                  AppInput(
                    label: AppStrings.usernameLabel.tr(),
                    hint: AppStrings.usernameHint.tr(),
                    controller: nameController,
                    validator: (value) => Validation.validateName(value),
                  ),

                  12.ph,

                  AppInput(
                    label: AppStrings.emailLabel.tr(),
                    hint: AppStrings.emailHint.tr(),
                    controller: emailController,
                    validator: (value) => Validation.validateEmail(value),
                  ),

                  12.ph,

                  AppInput(
                    label: AppStrings.passwordLabel.tr(),
                    hint: AppStrings.passwordHint.tr(),
                    controller: passwordController,
                    obscureText: cubit.isPasswordVisible1,
                    validator: (value) => Validation.validatePassword(value),
                    suffixIcon: GestureDetector(
                      onTap: cubit.togglePassword1,
                      child: AppImageWidget(
                        imageName: cubit.isPasswordVisible1
                            ? "visibily_off.svg"
                            : "visiblily.svg",
                      ),
                    ),
                  ),

                  12.ph,

                  AppInput(
                    label: AppStrings.confirmPasswordLabel.tr(),
                    hint: AppStrings.confirmPasswordHint.tr(),
                    controller: confirmPasswordController,
                    obscureText: cubit.isPasswordVisible2,
                    validator: (value) => Validation.validateConfirmPassword(
                      value,
                      passwordController.text,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: cubit.togglePassword2,
                      child: AppImageWidget(
                        imageName: cubit.isPasswordVisible2
                            ? "visibily_off.svg"
                            : "visiblily.svg",
                      ),
                    ),
                  ),

                  40.ph,

                  state is RegisterLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        )
                      : AppButton(
                          title: AppStrings.registerButton.tr(),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.register(
                                email: emailController.text,
                                username: nameController.text,
                                password: passwordController.text,
                                passwordConfirmation:
                                    confirmPasswordController.text,
                              );
                            }
                          },
                        ),

                  12.ph,

                  RegisterOrLogin(
                    normalText: AppStrings.haveAccount.tr(),
                    actionText: AppStrings.loginAction.tr(),
                    onTap: () {
                      context.nextScreen(const LoginView());
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:tharad_tech/core/constants/app_strings.dart';

class Validation {
  static String? validateName(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return AppStrings.nameEmpty.tr();
    } else if (value.length < minLength) {
      return AppStrings.nameMinLength.tr(args: [minLength.toString()]);
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailEmpty.tr();
    }
    final emailRegExp = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    if (!emailRegExp.hasMatch(value)) {
      return AppStrings.emailInvalid.tr();
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordEmpty.tr();
    }
    final passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}$');
    if (!passwordRegExp.hasMatch(value)) {
      return AppStrings.passwordInvalid.tr();
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return AppStrings.confirmPasswordEmpty.tr();
    } else if (password != confirmPassword) {
      return AppStrings.passwordNotMatch.tr();
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.phoneEmpty.tr();
    } else if (!RegExp(r'^\d{10,15}$').hasMatch(value)) {
      return AppStrings.phoneInvalid.tr();
    }
    return null;
  }
}

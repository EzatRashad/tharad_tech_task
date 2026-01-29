import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/style/app_colors.dart';
import '/core/utils/utils.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    required this.hint,
  });
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500),
        ),
        6.ph,

        TextFormField(
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(color: AppColors.primary),
          validator: validator,

          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus!.unfocus(),

          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.primary.withValues(alpha: 0.03),
            isDense: true,

            hint: Text(hint),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: suffixIcon,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Color(0xffF0E6DE), width: 1.5.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),

              borderSide: BorderSide(color: Color(0xffF0E6DE), width: 1.5.w),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(width: 1.5.w, color: Color(0xffF0E6DE)),
            ),
            errorMaxLines: 3,
            errorStyle: Theme.of(
              context,
            ).textTheme.titleSmall!.copyWith(color: Colors.red),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),

              borderSide: BorderSide(color: Colors.red, width: .5.w),
            ),
          ),
        ),
      ],
    );
  }
}
